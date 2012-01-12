#encoding: utf-8
require 'spec_helper'

describe ZapWs::WebService do
  subject { described_class.new }
  describe "#send_listings" do
    context "with invalid params" do
      it "returns nil when no listing was given" do
        subject.send_listings.should be_nil
      end
      it "raises a InvalidClientCode when no client_id was given" do
        ZapWs.client_id = ""
        lambda { subject.send_listings ["Blah"] }.should raise_error ZapWs::InvalidClientCode
      end
      
      it "raises a InvalidClientPassword when no client_password was given" do
        ZapWs.client_id = "999"
        lambda { subject.send_listings ["Blah"] }.should raise_error ZapWs::InvalidClientPassword
      end
    end
    
    context "with valid params" do
      before do
        ZapWs.setup do |config|
          config.client_id = "999"
          config.client_password = "******"
        end
        FakeWeb.register_uri(:any, "http://ws.zap.com.br/EnvArqSenha.asmx", body: '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  <soap:Body><AtualizarArquivoStringResponse xmlns="http://zap.com.br/webservices/"><AtualizarArquivoStringResult>OK</AtualizarArquivoStringResult></AtualizarArquivoStringResponse></soap:Body></soap:Envelope>')
      end
      
      it "hits the zap webservice and parses the response" do
        ZapWs::Message::Builder.should_receive(:generate_xml).and_return "<imoveis>BLah</imoveis>"
        response = subject.send_listings ["Blah"]
        response.should == "OK"
      end
    end
  end
end