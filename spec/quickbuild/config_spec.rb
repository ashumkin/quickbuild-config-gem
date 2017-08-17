require "spec_helper"

RSpec.describe Quickbuild::Config do
  it "has a version number" do
    expect(Quickbuild::Config::VERSION).not_to be nil
  end

end
