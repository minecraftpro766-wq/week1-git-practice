# Networking Notes

Run date: May 3, 2026

## Command Notes

### `ping google.com`

My computer sent test packets to `google.com`, which resolved to `142.251.41.14`, and Google replied to all 5 packets with 0% loss. A ping checks whether another host is reachable and measures round-trip time; mine was about 4-6 ms, with a 5 ms average.

### `nslookup google.com`

`nslookup` asked my DNS server, `gateway.home` at `192.168.254.254`, what IP addresses belong to `google.com`. It returned an IPv6 address and an IPv4 address; an A record is the DNS record that maps a domain name to an IPv4 address, like `142.251.215.78`.

### `curl -I https://google.com`

The `-I` flag tells `curl` to fetch only the HTTP response headers instead of downloading the full page body. Google returned status code `301 Moved Permanently`, which means the request worked but the browser/client should go to the new URL in the `Location` header: `https://www.google.com/`.

### `ipconfig`

My main Ethernet adapter has IPv4 address `192.168.254.192`, subnet mask `255.255.255.0`, and default gateway `192.168.254.254`. That IP is private because it starts with `192.168`, which is one of the reserved private address ranges used inside local networks.

The WSL virtual adapter also showed `172.21.64.1`, which is another private/internal address used for virtualization on this computer. It is not the address websites see when I connect to them.

### Public IP Check

A public IP lookup, like whatismyip.com, shows `47.156.3.51`, while `ipconfig` shows my local machine as `192.168.254.192`. These are different because of NAT: my router gives devices private local IPs, then translates their traffic out through one public IP on the internet.

## Short Answers

### What is an IP address, and what's the difference between public and private?

An IP address is a number that identifies a device or network location so data knows where to go. A private IP is used inside a local network, like my `192.168.254.192` address at home, while a public IP is reachable on the internet, like `47.156.3.51`. Private IPs usually sit behind a router, and the router uses NAT to connect them to the public internet.

### What is DNS, in one sentence?

DNS is the system that translates human-friendly names like `google.com` into IP addresses that computers can actually connect to.

### What is the difference between TCP and UDP?

TCP is connection-oriented, meaning it checks that data arrives and resends anything that gets lost. UDP is faster and simpler because it sends packets without setting up a reliable connection first. TCP is good for web pages and logins, while UDP is useful for things like live video, voice chat, or games where speed matters more than perfect delivery.

### What is a port, and why do we need them?

A port is like a numbered doorway on a computer that tells network traffic which application should receive it. One machine can run many network apps at the same time, so ports separate web traffic, SSH traffic, database traffic, and so on. For example, HTTPS usually uses port 443.

### What does it mean when an application is "listening on port 80"?

It means the application is running and waiting for incoming network connections on port 80. Port 80 is the standard port for plain HTTP websites. When a request arrives on that port, the operating system hands it to the app that is listening there.

## Mock Interview Walkthrough: Typing `google.com`

When I type `google.com` into a browser, the browser first needs an IP address, so it checks cache and then asks DNS. DNS returns one or more IP addresses for Google, such as an A record for IPv4 or an AAAA record for IPv6.

After the browser has an IP address, it opens a network connection to Google. For HTTPS, it usually connects to port 443 with TCP, then performs a TLS handshake so the connection is encrypted and the server proves its identity with a certificate.

Once the secure connection is ready, the browser sends an HTTP request asking for the page. The server responds with an HTTP status code, headers, and page content. The browser then downloads any linked files like CSS, JavaScript, and images, runs the code it needs, lays out the page, and renders it on screen.
