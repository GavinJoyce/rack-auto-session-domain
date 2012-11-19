rack-auto-session-cookie-domain
===============================

Automatically sets rack session domain to the current domain. This is handy if you want your rack app to serve multiple domains and have access to the session data on all subdomains.

For example, let's say your app serves the following domains:

www.domain1.com
auth.domain1.com
billing.domain1.com

www.domain2.co.uk
auth.domain2.co.uk
billing.domain2.co.uk

The session cookie will now be accessible from *.domain1.com and *.domain2.co.uk automatically.