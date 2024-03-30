#import "template.typ": conf
#show: doc => conf(
  title: [ Setting up Zola on NixOS ],
  doc,
)

= Introduction
#link("https://getzola.org")[Zola] is a static site generator
\(similarly to the infamous #link("https://gohugo.io")[Hugo];, which you
may have already heard of) and is written in Rust. It also happens to be
the framework that this site is built on!

This blog post is a guide on setting up the site engine on NixOS
specifically.

= Installation
== Installing the package
`zola` is packaged in the nix package repository, so you just
declaratively add the package to your configuration as usual: For the
purposes of this guide, zola can be installed either as a system or user
package.

As a system package:

```nix
{ pkgs, ... }: {
    # ...
    environment.systemPackages = with pkgs; [
        zola # Append the package name to the list
    ];
    # ...
}
```

As a user package (with home-manager):

```nix
{ pkgs, ... }: {
    # ...
    home.packages = with pkgs; [
        zola # Append the package name to the list
    ];
    # ...
}
```

Now that `zola` itself is installed, we can move on setting up the pages
it serves - continue reading…

== Setting up a theme
Zola actually has a section of its website showcasing several
community-made themes which you can choose from to be the theme for your
static site #link("https://getzola.org/themes/")[here];.

Simply choose a theme that you like \(demos are usually available for
each theme listed) and follow its appropriate documentation to set it up - this site uses a version of the #link("https://www.getzola.org/themes/serene/")[serene theme] with my custom colours.

You can also make your own theme if
that better suits you \(I recommend giving the
#link("https://getzola.org/documentation")[documentation] a read if so).

== Setting up NGINX
After selecting a theme \(or making your own) you should now have a
directory somewhere on your server containing your static site. For the
following snippet, we’ll assume this is at `/var/lib/blog`.

#link("https://nginx.com")[NGINX] is a popular webserver which we’re
going to use for the purposes of hosting and serving our site. To do so,
append the following somewhere in your configuration:

```nix
# ...
{
    # ...
    services.nginx = {
        enable = true;
        virtualHosts = {
            "blog" = {
                forceSSL = true;
                serverName = "blog.devraza.duckdns.org";
                root = "/var/lib/blog/public";
            };
        };
    };
    # ...
}
```

Obviously, you'll want to change any of the values to better accomodate your needs.

= Finishing up
You should now have your own static site built with Zola! You can use
this for a bunch of things, like:
- Your personal blog (as I’ve done)
- A way to showcase your projects #link("https://blog.devraza.duckdns.org/projects")[(as I’ve also done)]
- Hosting documentation (check out #link("https://www.getzola.org/themes/adidoks/")[this Zola theme])

=== Help, my changes aren't sticking!
When you make new markdown files \(or any other changes to the structure of your
site), remember to run `zola build` in your site directory
\(`/var/lib/blog`) for the changes to #emph[build] into the actual site.
