# frozen_string_literal: true

module PagerDuty
  RSpec.describe Environment do
    describe "#get_env_variable" do
      let(:env_variable) { "TOKEN" }
      let(:api_token) { "super_secret_key" }

      before(:each) { ENV[env_variable] = api_token }
      after(:each) { ENV.delete(env_variable) }

      subject { Environment.get_env_variable(env_variable) }

      it "returns the value of the requested environment variable when it is set" do
        expect(subject).to eq(api_token)
      end

      it "returns nil when the environment variable is not set" do
        ENV.delete(env_variable)

        expect(subject).to be_nil
      end
    end
  end
end
