require 'rspec'
require 'rack/test'
require 'rack-auto-session-cookie-domain'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

describe Rack::AutoSessionCookieDomain do
  include Rack::Test::Methods

  let(:app) { 
    Rack::AutoSessionCookieDomain.new(
      lambda { |env| [200, {'Content-Type' => 'text/plain'}, 'hello there'] }
    )
  }

  it "should return a valid response" do
    get '/'
    last_response.should be_ok
    last_response.body.should == 'hello there'
  end
  
  it "should ignore the subdomain" do
    get 'http://www.incremental.ie/apps'
    session_domain_from(last_request).should == 'incremental.ie'
  end
  
  it "should ignore multiple subdomains" do
    get 'http://ballinteer.dublin.incremental.ie/apps'
    last_request.env["rack.session.options"][:domain].should == 'incremental.ie'
  end
  
  it "should set the session domain when there is no subdomain" do
    get 'http://incremental.ie/apps'
    last_request.env["rack.session.options"][:domain].should == 'incremental.ie'
  end
  
  it "should ignore request port" do
    get 'http://incremental.ie:8080/apps'
    last_request.env["rack.session.options"][:domain].should == 'incremental.ie'
  end
  
  it "should ignore protocol" do
    get 'https://www.incremental.ie/apps'
    last_request.env["rack.session.options"][:domain].should == 'incremental.ie'
  end
  
  it "should work with country code second level domains" do
    get 'http://www.bbc.co.uk/sport/0/'
    last_request.env["rack.session.options"][:domain].should == 'bbc.co.uk'
  end
  
  it "should ignore localhost" do
    get 'http://localhost/apps'
    last_request.env["rack.session.options"][:domain].should == nil
  end
  
  it "should ignore ip addresses" do
    get 'http://127.0.0.1/apps'
    last_request.env["rack.session.options"][:domain].should == nil
  end
  
  private
  
  def session_domain_from(request)
    request.env["rack.session.options"][:domain]
  end
end