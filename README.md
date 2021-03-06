rack-auto-session-domain
===============================

This rack middleware automatically sets the rack session domain to the current domain.

eg. env["rack.session.options"][:domain] = 'domain1.com'

This is handy if you want your rack app to serve multiple domains and have access to the session data across all subdomains. For example, let's say your app serves the following domains:

- www.domain1.com
- auth.domain1.com
- billing.domain1.com

and..

- www.domain2.co.uk
- auth.domain2.co.uk
- billing.domain2.co.uk

The session cookies will now automatically be accessible across all subdomains on *.domain1.com and *.domain2.co.uk respectively.

## Source

https://github.com/GavinJoyce/rack-auto-session-domain