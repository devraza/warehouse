#import "template.typ": conf
#show: doc => conf(
  title: [ Host your own private search engine with SearXNG ],
  doc,
)

= Tailscale
#link("https://tailscale.com/")[Tailscale] is a modern tunnel VPN
service based on #link("https://www.wireguard.com/")[WireGuard®] which
provides a 'free' and secure means of communication between devices
within a #link("https://tailscale.com/kb/1136/tailnet")[tailnet] - a
private network which Tailscale provides its users.

Essentially, it provides a private and secure way of accessing any of
your devices, no matter where you are in the world - a personal WAN
encompassing the entire world.

And on top of this, Tailscale is completely free and open-source! At
least, on the surface…

== Not FOSS? What do you mean?
There’s a quite popular saying within the free and open-source software
community, which goes along the lines of:

#quote(block: true)[
If you aren’t paying for the product, then you are the product.
]

Which makes perfect sense. It’s the #emph[modern] era so anything
significant is powered by some form of #emph[modern] technology, data is
the new oil, and so on. In exchange for offering you 'free' services,
companies collect and use your data; while there supposedly are laws in
place preventing the inconcensual collection of data in most countries
around the world, #emph[your] personal data may #emph[still] be traded
unethically and inconsensually.

I personally am of the opinion that these laws are worth absolutely
nothing if people aren’t educated in how their data is being used, and
what specifically is being collected. But I digress, and that’s a blog
post for another time.

I also think it’s quite unfortunate that users of paid services
#emph[still] have their personal data collected in the unethical manner
outlined above, despite the fact that they are #emph[paying] for the
service…

In the context of Tailscale: while their clients are all open-source,
their control server - the thing that’s managing and rerouting
#emph[everything] going through what they advertise as #emph[your]
'secure' VPN, isn’t. You’ve got no idea what this thing is doing with
the traffic it recieves.

= Headscale
For every problem, there’s probably a solution somewhere. And luckily
for this one \(which may or may not actually be a problem for you),
we’ve got #link("https://headscale.net/")[Headscale] as our solution.
Headscale’s a self-hostable, open-source alternative to the Tailscale
control server, and aims to 'provide self-hosters and hobbyists with an
open-source server they can use for their projects and labs'.

== Installing on NixOS
Moving on to installing and setting up Headscale on NixOS.

```nix
# ...
{
  # ...
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 7070;
    settings = {
      logtail.enabled = false;
      server_url = "https://headscale.devraza.duckdns.org";
      dns_config.base_domain = "devraza.duckdns.org"; 
    };
  };
  # ...
}
```

This starts up the `headscale` systemd service on our host machine at
port `7070`. After that, we make Headscale available over the clearnet
with an NGINX reverse proxy, per the usual:

```nix
{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "headscale" = {
        addSSL = true;
        serverName = "headscale.devraza.duckdns.org";
        sslCertificate = ./services/nginx/certs/subdomains/fullchain.pem;
        sslCertificateKey = ./services/nginx/certs/subdomains/privkey.pem;
        # Headscale proxy
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.headscale.port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
```

And that’s it. A self-hosted, #emph[truly] open-source Wireguard®-based
VPN is now at your fingertips. Enjoy! Oh, but please read the conclusion
before doing that:

= Conclusion
For those of you who wish to have access to something like Tailscale but
value your privacy above all, you would genuinely be greatful for
Headscale. However, I’ve found that some are fine with what Tailscale
#emph[does] provide in regards to FOSS, and are satisfied by the raw
convenience and simplicity of a non-selfhosted Tailscale control server - exactly what it hopes to provide, as shown by their self-description on their website: 'a zero-config, no-fuss VPN \[provider\]'.

Or you could just settle with bare Wireguard®.
