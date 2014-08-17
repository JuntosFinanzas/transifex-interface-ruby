require_relative '../../spec_helper'

describe Transifex::ProjectComponents::LanguageComponents::Reviewers do
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ProjectComponents::LanguageComponents::Reviewers.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should not raise an error and retrieve the language's informations" do
      language_coordinators_infos = nil
      expect{ language_coordinators_infos = @project.language('en').reviewers.fetch }.to_not raise_error
      expect(language_coordinators_infos).to be_a_kind_of(Hash)
      expect(language_coordinators_infos.keys).to contain_exactly("reviewers")
    end
  end

  describe "Update" do
    it "should not raise an error and update the coordinators list" do
      expect{ @project.language('en').reviewers.update(['fredericgrais'])}.to_not raise_error
    end

    it "should raise an error if the coordinator doesn't exist" do
      expect{ @project.language('en').reviewers.update(['grgrgef'])}.to raise_error(Transifex::TransifexError)
    end
  end
end