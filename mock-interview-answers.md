# Mock Interview Answers

8 prompts. 150-250 words each. Sound like a person talking, not a research paper. Your voice. No AI.

---

## Part A — Review (last week's material)

### 1. Walk me through what happens when you `docker build -t my-app .` and then `docker run my-app`

<!-- ~150-250 words. Cover: build reads the Dockerfile, creates layers, produces an image tagged my-app. Then run takes that image and starts a container from it (the recipe vs. cake analogy you already used). -->



### 2. Explain the difference between an image and a container. Use an analogy.

<!-- ~150-250 words. Image = recipe/blueprint, container = the running thing made from it. You can spin up many containers from one image. -->



### 3. What's the difference between Git and GitHub? When would you use each?

<!-- ~150-250 words. Git = local version control tool on your machine. GitHub = the website that hosts your repo remotely so others can see/collaborate. -->



### 4. What's the difference between HTTP and HTTPS, and why does it matter for cloud architecture?

<!-- ~150-250 words. HTTP plain text, HTTPS encrypted with TLS. In cloud, you almost always terminate TLS at the load balancer; mention certs / ACM if you can. -->



---

## Part B — New networking material

### 5. In your own words, what is a VPC and what problem does it solve?

<!-- ~150-250 words. This is the one Isaac said you trailed off on. Fill 5 minutes worth of substance. Your own private isolated network inside AWS, you control IP ranges, subnets, routing, who can talk to who. Without it, every EC2 would be naked on the internet. -->



### 6. Walk me through the difference between a public subnet and a private subnet.

<!-- ~150-250 words. It's NOT about the IP range. It's about routing — a public subnet has a route to the Internet Gateway, a private one doesn't. Public subnet hosts: ALB, NAT GW. Private subnet hosts: app servers, DB. -->



### 7. What's the difference between a security group and a NACL?

<!-- ~150-250 words. The interview classic. SG = instance level, stateful, allow-only. NACL = subnet level, stateless, allow + deny. Explain stateful vs stateless with the return-traffic example. -->



### 8. If I'm building a web app on AWS that has a frontend, backend, and database, walk me through how I'd structure the VPC.

<!-- ~150-250 words. The 3-tier story. VPC, 2 AZs for HA, public subnets with ALB + NAT, private subnets with app servers, isolated private subnets with RDS Multi-AZ. IGW attached. -->



---

## Part C — Explain to a Non-Technical Person

Pick 2 of the new networking concepts above. Explain them out loud to someone who is not in tech. Then fill this in.

### Which 2 concepts you picked

<!-- e.g., "VPC" and "Security groups vs NACLs" -->



### Who you explained them to

<!-- name + their relationship to you -->



### What worked

<!-- which analogies landed? what made their eyes light up? -->



### What didn't

<!-- where did they get confused or pretend to follow? -->



### How you'd explain it differently next time

<!-- be honest — if a part fell flat, that's where your understanding is still weak -->
