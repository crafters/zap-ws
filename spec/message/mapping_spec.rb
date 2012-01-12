#encoding: utf-8
require 'spec_helper'

describe ZapWs::Message::Mapping do
  subject{ ZapWs::Message::Mapping }
  
  describe "converting keys to xml tags" do
    it "convert a symbol in a zap's xml tag" do
      subject.xml_tag_for(:my_awesome_field).should == "MyAwesomeField"
    end
  
    it "convert a string in a zap's xml tag" do
      subject.xml_tag_for('my_awesome_field').should == "MyAwesomeField"
    end
  
    it "convert a specific key to an zap's xml tag" do
      subject.xml_tag_for(:codigo).should == "CodigoImovel"
    end
  end
end