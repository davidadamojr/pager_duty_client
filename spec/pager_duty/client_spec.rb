# frozen_string_literal: true

module PagerDuty
  RSpec.describe Client do
    it "has a version number" do
      expect(PagerDuty::Client::VERSION).not_to be nil
    end

    subject { described_class.new.find_service(service_name) }

    describe "#find_service" do
      let(:service_name) { "sputnik" }
      let(:url) { "https://api.pagerduty.com/services?query=#{service_name}&limit=1&sort_by=name:asc" }
      let(:api_token) { "super_secret_token" }
      let(:headers) do
        {
          "Authorization" => "Token token=#{api_token}",
          "Accept" => "application/vnd.pagerduty+json;version=2",
          "Content-Type" => "application/json"
        }
      end
      let(:response) do
        {
          services: [
            {
              id: "some_id",
              name: "Korabl-Sputnik 1"
            }
          ]
        }
      end

      before(:each) { allow(Environment).to receive(:get_env_variable).and_return(api_token) }

      it "makes HTTP call to PagerDuty with provided service name" do
        stub_request(:get, url).with(headers: headers).to_return(body: response.to_json, status: 200)

        subject

        expect(WebMock).to have_requested(:get, url).with(headers: headers)
      end

      context "with a 200 success response" do
        it "returns service information for the requested service" do
          stub_request(:get, url).with(headers: headers).to_return(body: response.to_json, status: 200)

          expect(subject).to eq(response[:services][0].transform_keys(&:to_s))
        end
      end

      context "with a rate limited request" do
        it "raises a RateLimitError with message 'Too many requests'." do
          stub_request(:get, url).with(headers: headers).to_return(body: {}.to_json, status: 429)

          expect { subject }.to raise_error(Client::RateLimitError)
        end
      end

      context "with a non-200 response code" do
        it "raises an ApiError" do
          stub_request(:get, url).with(headers: headers).to_return(body: {}.to_json, status: 403)

          expect{ subject }.to raise_error(Client::ApiError, /non-success/)
        end
      end

      context "when the requested service is not found" do
        it "raises a ServiceNotFound error" do
          stub_request(:get, url).with(headers: headers).to_return(body: { services: [] }.to_json, status: 200)

          expect{ subject }.to raise_error(Client::ServiceNotFound, /not found/)
        end
      end
    end
  end
end
