require 'spec_helper'
describe Macklog::Cli do
  describe "file not found" do
    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "not_exist.text", warning: "test" }) }.to raise_error(Macklog::FileNotFound)
    end
  end
  
  describe "unmach" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/macklog_test1.tmp"))
    end
    it do
      Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "unmatch" })
    end
  end

  describe "normal" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/macklog_test1.tmp"))
    end

    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "normal" }) }
    end
    
    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", critical: "normal" }) }
    end

  end

  describe "warning" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/macklog_test1.tmp"))
    end

    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "Fatal" }) }.to raise_error(Macklog::Warning)
    end
    
    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "fatal", ignorecase: true }) }.to raise_error(Macklog::Warning)
    end
  end
  
  describe "critical" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/macklog_test1.tmp"))
    end

    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "Fatal", critical: "Fatal" }) }.to raise_error(Macklog::Critical)
    end
    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", critical: "Fatal" }) }.to raise_error(Macklog::Critical)
    end
    
    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "fatal", critical: "fatal", ignorecase: true }) }.to raise_error(Macklog::Critical)
    end
    
    it do
      expect { Macklog::Cli.new.invoke(:check, [], { file: "test1.log", critical: "fatal", ignorecase: true }) }.to raise_error(Macklog::Critical)
    end
  end
  
  describe "notified" do
    before do
      allow(File).to receive(:expand_path).and_return("test1.log")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:readlines).and_return(File.readlines("spec/fixture/test1.log"), File.readlines("spec/fixture/macklog_test1.tmp"))
    end

    it do
      Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "critical",critical: "critical" })
    end
    
    it do
      Macklog::Cli.new.invoke(:check, [], { file: "test1.log", warning: "critical",critical: "critical", ignorecase: true })
    end
  end
end
