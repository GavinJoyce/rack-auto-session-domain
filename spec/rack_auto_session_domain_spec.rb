require 'rspec'
require 'rack/test'
require 'rack-auto-session-domain'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

describe Rack::AutoSessionDomain do
  include Rack::Test::Methods

  let(:app) { 
    Rack::AutoSessionDomain.new(
      lambda { |env| [200, {'Content-Type' => 'text/plain'}, 'hello there'] }
    )
  }

  it "returns a valid response" do
    get '/'
    last_response.should be_ok
    last_response.body.should == 'hello there'
  end
  
  it "ignores the subdomain" do
    get 'http://www.incremental.ie/apps'
    session_domain_from(last_request).should == 'incremental.ie'
  end
  
  it "ignores multiple subdomains" do
    get 'http://ballinteer.dublin.incremental.ie/apps'
    session_domain_from(last_request).should == 'incremental.ie'
  end
  
  it "sets the session domain when there is no subdomain" do
    get 'http://incremental.ie/apps'
    session_domain_from(last_request).should == 'incremental.ie'
  end
  
  it "ignores request port" do
    get 'http://incremental.ie:8080/apps'
    session_domain_from(last_request).should == 'incremental.ie'
  end
  
  it "ignores protocol" do
    get 'https://www.incremental.ie/apps'
    session_domain_from(last_request).should == 'incremental.ie'
  end
  
  it "works with country code second level domains" do
    get 'http://www.bbc.co.uk/sport/0/'
    session_domain_from(last_request).should == 'bbc.co.uk'
  end
  
  it "ignores localhost" do
    get 'http://localhost/apps'
    session_domain_from(last_request).should == nil
  end
  
  it "ignores ip addresses" do
    get 'http://127.0.0.1/apps'
    session_domain_from(last_request).should == nil
  end
  
  private
  
  def session_domain_from(request)
    request.env["rack.session.options"][:domain]
  end
end