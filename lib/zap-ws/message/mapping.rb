require 'active_support/inflector'
module ZapWs
  module Message
    module Mapping
      ATTRIBUTES = {
        :codigo => "CodigoImovel",
        :tipo => "TipoImovel",
        :sub_tipo => "SubTipImovel",
        :categoria => "CategoriaImovel",
        :cep => "CEP",
        :valor_venda => "PrecoVenda",
        :valor_locacao => "PrecoLocacao",
        :valor_locacao_temporada => "PrecoLocacaoTemporada",
        :valor_condominio => "PrecoCondominio",
        :suites => "QtdSuites",
        :bainheiros => "QtdBanheiros",
        :salas => "QtdSalas",
        :vagas => "QtdVagas",
        :elevador => "QtdElevador",
        :unidades_andar => "QtdUnidadesAndar",
        :andar => "QtdAndar",
        :quantidade_pessoas_temporada => "QtdPessoasTemporada",
        :dormitorios => "QtdDormitorios",
        :utilize_fgts => "UtilizeFGTS",
        :url_arquivo => "URLArquivo"
      }
      
      def self.xml_tag_for field
        field = field.to_sym
        return field.to_s.camelize unless ATTRIBUTES.include? field
        ATTRIBUTES[field]
      end
    end
  end
end