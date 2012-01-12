module ZapWs
  module Message
    class Builder
      def self.generate_xml listings=[]
        return if listings.empty?
        raise InvalidClientCode if !ZapWs.client_id || ZapWs.client_id.blank?
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.Carga('xmlns:xsi'=>"http://www.w3.org/2001/XMLSchema-instance", 'xmlns:xsd'=>"http://www.w3.org/2001/XMLSchema") {
            xml.Imoveis {
              listings.each do |listing|
                xml.Imovel {
                  xml.CodigoCliente ZapWs.client_id
                  translate_to_xml xml, listing
                }
              end
            }
          }
        end
        builder.to_xml
      end
      
      protected
      def self.translate_to_xml builder, listing
        listing.each do |attribute, value|
          xml_tag = ZapWs::Message::Mapping.xml_tag_for attribute
          array = nil
          if value.is_a? Array
            builder.__send__(xml_tag) { |xml|
              value.each do |child|
                child.each do |tag, attributes|
                  child_tag = ZapWs::Message::Mapping.xml_tag_for tag
                  builder.__send__(child_tag){ |xml|
                    translate_to_xml builder, attributes
                  }
                end
              end
            }
          else
            builder.__send__(xml_tag, value)
          end
        end
      end
      
    end
  end
end