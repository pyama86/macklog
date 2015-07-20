require 'spec_helper'
describe Maltch::Cli do
  describe "file not found" do
    it do
      expect { Maltch::Cli.new.invoke(:check, [], { file: "not_exist.text", word: "test" }) }.to raise_error(Maltch::FileNotFound)
    end
  end
  
  describe "unmach" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/maltch_test1.tmp"))
    end
    it do
      Maltch::Cli.new.invoke(:check, [], { file: "test1.log", word: "unmatch" })
    end
  end

  describe "match" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/maltch_test1.tmp"))
    end

    it do
      expect { Maltch::Cli.new.invoke(:check, [], { file: "test1.log", word: "Fatal" }) }.to raise_error(Maltch::MatchWord)
    end
    
    it do
      expect { Maltch::Cli.new.invoke(:check, [], { file: "test1.log", word: "fatal", ignorecase: true }) }.to raise_error(Maltch::MatchWord)
    end
  end
  
  describe "notified" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/maltch_test1.tmp"))
    end

    it do
      Maltch::Cli.new.invoke(:check, [], { file: "test1.log", word: "critical" })
    end
    
    it do
      Maltch::Cli.new.invoke(:check, [], { file: "test1.log", word: "critical", ignorecase: true })
    end
  end
end
