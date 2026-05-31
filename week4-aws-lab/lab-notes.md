Week 4 AWS Lab - Notes


1. What I built (one sentence)
Answer: (e.g. a VPC with a public and private subnet in one AZ, an internet gateway, and one EC2 I could SSH into and reach the internet from) So what I built is a virtual private cloud. Within a virtual private cloud, there's a private and a public subnet in one availability zone with an internet gateway and one EC2 that I could SSH into and reach the internet from. 

2. What each step actually did, in my words

2.1 VPC (10.0.0.0/16)
  So I chose this classless inter-domain routing because And specifically, I chose the /16 because it's just the starting size and it's a great way to break into subnets later on, such as /24. 

2.2 Public and private subnet (10.0.1.0/24 and 10.0.2.0/24)
  And then I created a public and private subnet. What makes a subnet public is not an IP. It's just if the route has a route table to the internet gateway. 

2.3 Internet Gateway
 And then we needed an internet gateway because with an internet gateway, you're able to access your virtual private cloud. It's a great way to have security, so you have a VPC that, with the internet gateway, lets you into the public subnet.

2.4 Route table (0.0.0.0/0 to IGW), associated to public subnet
I created a route table and associated it with my public subnet. Inside this route table, I added a route for 0.0.0.0/0 pointing to the Internet Gateway. This acts like a wide-open highway, allowing traffic to flow smoothly between my subnet and anywhere on the public internet.After setting up this highway, I assigned a Public IP address to my server. This Public IP acts exactly like a dedicated phone number (or a specific street address). While the route table opens up the highway for anybody and everybody, people ultimately dial my server's specific Public IP address to connect directly to it. 

2.5 Key pair (.pem)
A key pair (.pem file) is a private security key used to securely log into an EC2 instance. It acts like a highly secure digital passport rather than a simple password.This matters because without this file, you are completely locked out of your EC2 instance. The EC2 instance sits inside your public subnet, which is inside your VPC. By using the key pair to access the EC2 instance, you gain the administrative rights needed to edit files, configure software, and manage your server within the cloud network.

2.6 EC2 (t2.micro) in public subnet, security group SSH from My IP
We choose "My IP" instead of "0.0.0.0/0" for SSH access to create a strict, two-step authentication process for maximum security.Step 1 (The Bouncer): Setting the rule to "My IP" tells the Security Group to act as a bouncer that only allows traffic originating from my specific home network. If we used 0.0.0.0/0, the door would be wide open to the entire internet, allowing global hackers and automated bots to constantly attack the server.Step 2 (The Key): Once the bouncer recognizes my network's IP and lets me through, I must still provide the downloaded .pem key pair to officially unlock and administrative-log into the EC2 instance.

2.7 SSH in, then ping and curl
When running a ping or curl command, the traffic takes a complete round-trip path from the EC2 instance to the internet and back:Outbound Path: The EC2 instance initiates the command. The traffic hits the Route Table, which reads the 0.0.0.0/0 rule and directs the traffic out through the Internet Gateway to reach the public Internet.Inbound Path: The target internet server replies, sending the data back through the Internet Gateway, which routes it across the subnet directly back to the EC2 instance.

3. What surprised me
What surprised me most was seeing my command prompt display ip-10-0-1-122—which is a Private IP address—yet the server was still able to successfully communicate with the public internet.I learned that this works because of the Internet Gateway's hidden superpower: Network Address Translation (NAT).Inside the VPC, my server only knows its own identity as a private IP (10.0.1.122).When I pinged the internet, the traffic traveled to the Internet Gateway.The Internet Gateway acted like a smart translator. It automatically stripped away my private IP signature and swapped it with the Public IP address that I had assigned to the instance earlier.Essentially, the server got to stay safe and private inside the VPC envelope, while the Internet Gateway handled the public mapping out on the internet highway. Seeing how those two separate IPs worked together seamlessly was a huge eye-opener!

4. What was confusing
(real things that tripped me up this session, write what was confusing and how it cleared up)
4.1 The subnet CIDR field: I thought I could only pick /16 and could not find where to type /24.
What confused me at first was how to properly size my subnets in the cloud console. When I created the main VPC network, I assigned it a massive /16 block. Because of this, I mistakenly thought I was locked into using /16 for everything and struggled to find where to define a smaller /24 network chunk.I cleared this up when I realized that the /16 network acts as a "parent" block. You don't change the parent; instead, you use the subnet CIDR field to cleanly slice that parent into smaller "child" subnets (like 10.0.1.0/24). This gives you smaller, isolated neighborhoods within your massive VPC cloud footprint.
4.2 The .pem permissions on Windows: chmod 400 is Mac/Linux, I had to use icacls instead, and the folder name had a space so I had to quote the path in the ssh command.
The most frustrating point of confusion happened when trying to securely lock down my private key (.pem) file on my Windows machine. Every standard tutorial online told me to run the chmod 400 command, but Windows doesn't recognize Linux commands, leaving me locked out with a "permissions too open" error. On top of that, my command line kept failing because the folder name where I saved the key contained a blank space.I cleared this up by learning how to translate Linux practices into Windows environments:I bypassed chmod and used the native Windows icacls utility to strip away all other user permissions from the file.I solved the folder space issue by wrapping my entire file path in double quotation marks (e.g., "C:\My Folder\key.pem") inside my SSH command.Overcoming this taught me that while the cloud servers themselves run Linux, managing them requires knowing how to adapt commands specifically for my local Windows operating system.

5. What I would want to learn more about
How does this get me 1 step closer to get a cloud job and providing  value to companys. 

7. My IPs (for reference)
Private IP inside public subnet: 10.0.1.122
Public IP assigned to the instance: 3.81.200.191
