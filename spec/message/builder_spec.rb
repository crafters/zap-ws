#encoding: utf-8
require 'spec_helper'

describe ZapWs::Message::Builder do
  subject{ ZapWs::Message::Builder }
  
  it "returns nill when a empty array was given" do
    subject.generate_xml.should be_nil
  end
  
  it "raises a InvalidClientCode when no client id was given" do
    lambda{ subject.generate_xml ["blah"] }.should raise_error(ZapWs::InvalidClientCode)
  end
  
  it "generate a xml based on the mapping tags" do
    ZapWs.client_id = "999"
    xml = subject.generate_xml([
      {codigo: "ABC123", tipo: "Apartamento", sub_tipo: "Apartamento Padrão", categoria: "Padrão", cidade: "Rio de Janeiro", 
        bairro: "Barra da Tijuca", endereco: "Rua da rua", numero: "100", complemento: "ap. 13", cep: "11586900", 
        valor_venda: "145000", area_util: "56", area_total: "56", dormitorios: "4", valor_entrada: "10.000", valor_mensal: "5.000" }])
    xml.should == "<?xml version=\"1.0\"?>\n<Carga xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <Imoveis>\n    <Imovel>\n      <CodigoCliente>999</CodigoCliente>\n      <CodigoImovel>ABC123</CodigoImovel>\n      <TipoImovel>Apartamento</TipoImovel>\n      <SubTipImovel>Apartamento Padr&#xE3;o</SubTipImovel>\n      <CategoriaImovel>Padr&#xE3;o</CategoriaImovel>\n      <Cidade>Rio de Janeiro</Cidade>\n      <Bairro>Barra da Tijuca</Bairro>\n      <Endereco>Rua da rua</Endereco>\n      <Numero>100</Numero>\n      <Complemento>ap. 13</Complemento>\n      <CEP>11586900</CEP>\n      <PrecoVenda>145000</PrecoVenda>\n      <AreaUtil>56</AreaUtil>\n      <AreaTotal>56</AreaTotal>\n      <QtdDormitorios>4</QtdDormitorios>\n      <ValorEntrada>10.000</ValorEntrada>\n      <ValorMensal>5.000</ValorMensal>\n    </Imovel>\n  </Imoveis>\n</Carga>\n"
  end
  
  it "generate a xml with listing pictures" do
    ZapWs.client_id = "999"
    xml = subject.generate_xml([
      {codigo: "ABC123", tipo: "Apartamento", sub_tipo: "Apartamento Padrão", categoria: "Padrão", cidade: "Rio de Janeiro", 
        bairro: "Barra da Tijuca", endereco: "Rua da rua", numero: "100", complemento: "ap. 13", cep: "11586900", 
        valor_venda: "145000", area_util: "56", area_total: "56", dormitorios: "4", valor_entrada: "10.000", valor_mensal: "5.000", 
        fotos: [:foto => { nome_arquivo: "foto.jpg", url_arquivo: "http://www.site.com.br/imagens/foto.jpg", principal: "1", alterada: "0" }] }])
    xml.should == "<?xml version=\"1.0\"?>\n<Carga xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <Imoveis>\n    <Imovel>\n      <CodigoCliente>999</CodigoCliente>\n      <CodigoImovel>ABC123</CodigoImovel>\n      <TipoImovel>Apartamento</TipoImovel>\n      <SubTipImovel>Apartamento Padr&#xE3;o</SubTipImovel>\n      <CategoriaImovel>Padr&#xE3;o</CategoriaImovel>\n      <Cidade>Rio de Janeiro</Cidade>\n      <Bairro>Barra da Tijuca</Bairro>\n      <Endereco>Rua da rua</Endereco>\n      <Numero>100</Numero>\n      <Complemento>ap. 13</Complemento>\n      <CEP>11586900</CEP>\n      <PrecoVenda>145000</PrecoVenda>\n      <AreaUtil>56</AreaUtil>\n      <AreaTotal>56</AreaTotal>\n      <QtdDormitorios>4</QtdDormitorios>\n      <ValorEntrada>10.000</ValorEntrada>\n      <ValorMensal>5.000</ValorMensal>\n      <Fotos>\n        <Foto>\n          <NomeArquivo>foto.jpg</NomeArquivo>\n          <URLArquivo>http://www.site.com.br/imagens/foto.jpg</URLArquivo>\n          <Principal>1</Principal>\n          <Alterada>0</Alterada>\n        </Foto>\n      </Fotos>\n    </Imovel>\n  </Imoveis>\n</Carga>\n"
  end
  
end
