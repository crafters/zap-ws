#encoding: utf-8
module ZapWs
  class WebService
    def initialize
      @client = Savon::Client.new "http://ws.zap.com.br/EnvArqSenha.asmx?WSDL"
    end
    
    def send_listings listings=[]
      return if listings.empty?
      raise InvalidClientCode if !ZapWs.client_id || ZapWs.client_id.blank?
      raise InvalidClientPassword if !ZapWs.client_password || ZapWs.client_password.blank?
      
      xml = ZapWs::Message::Builder.generate_xml listings
      
      params = { plng_cod_cliente: ZapWs.client_id, pstr_senha_cliente: ZapWs.client_password, pstr_conteudo: xml }
      
      response = @client.request :atualizar_arquivo_string do
        soap.body = params
      end
      body = response.body rescue response.hash
      return body if !body[:atualizar_arquivo_string_response] || !body[:atualizar_arquivo_string_response][:atualizar_arquivo_string_result]
      body[:atualizar_arquivo_string_response][:atualizar_arquivo_string_result]
    end
  end
end