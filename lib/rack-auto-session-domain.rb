require "rack-auto-session-domain/version"
require 'domainatrix'

module Rack
  class AutoSessionDomain
    def initialize(app)
      @app = app
    end

    def call(env)      
      env["rack.session.options"] ||= {}
      host = env["SERVER_NAME"]
      
      env["rack.session.options"][:domain] = Domainatrix.parse(host).domain_with_tld if valid_host?(host)

      @app.call(env)
    end

    private

    def valid_host?(host)
      return false unless host.include? '.' #exclude hosts such as 'localhost'
      return !is_numeric?(host.gsub(/\D/,'')) #exclude IP addresses
    end

    def is_numeric?(text)
      true if Float(text) rescue false
    end
  end
end