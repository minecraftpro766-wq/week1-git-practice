# Network Architecture Walkthrough

Trace a user request through the diagram in `network-architecture.png`. Half a page. Your own words.

## 1. Where does the request hit first?

<!-- A user types your URL into a browser. What's the first AWS thing the request touches? Mention DNS/Route 53, the Internet Gateway, and the Application Load Balancer. -->



## 2. How does it get to the app server?

<!-- After the load balancer accepts the request, how does it route to the app servers? Which subnet do the app servers live in, and why? -->



## 3. How does the app server reach the database?

<!-- The app server needs data. The database is in an even more isolated private subnet. How does the app server talk to it, and what stops the database from being reachable from the internet? -->



## 4. If the app server needs to call an external API, how does it reach the internet?

<!-- App servers are in a private subnet — they have no public IP. So how do they get out to call, say, a Stripe API? Walk through the NAT Gateway path. -->



## 5. If a malicious actor on the internet tries to talk directly to the database, what stops them?

<!-- Be specific: route tables, no public IP, security groups, NACLs. What's the layered defense? -->
