require "spec_helper"

RSpec.describe Quickbuild::Config do
  it "has a version number" do
    expect(Quickbuild::Config::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
