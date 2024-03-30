#import "template.typ": conf
#show: doc => conf(
  title: [ Misconceptions about NFC ],
  doc,
)

#align(left, text(10pt)[*I made a mistake while writing this blog
post - somehow forgetting that security isn’t unambiguous. You can
actually skim NFC chips from a certain distance \(having a limited
distance is still an important factor though!), and though I think some
of what I said below still applies you’re better off ignoring it all.*
There are, of course, a whole range of problems with skimming NFC chips
from a distance so my point - don’t be so worried - would still stand.
Either way, I recommend you take this with a grain of salt.
])

= Introduction
NFC \(short for Near-Field Communication) is the set of communication
protocols which allow for #emph[near-field communication] between two
electronic devices. One of the most prominent uses of this technology
are contactless transactions - this includes services like Google and
Apple Pay as well as all of your contactless-enabled cards.

It’s been a while since my last blog past, but this one will be brief
too - I’m writing here for the sake of clearing up some misconceptions
people have about NFC.

= The Misconceptions
== Inspiration
While talking with a friend on a WhatsApp group chat a few days ago
about a program I found on my jailbroken iOS device - link("https://github.com/Aemulo")[Aemulo] - I was informed of 'subway
skimmers'; devices that could #emph[supposedly] read data from
contactless-enabled devices \(via NFC) and would be able to emulate
them.

The idea behind the above example was that someone with malicious intent
could place such a device in a public location and take their
contactless devices for their malicious purposes. When I heard of this,
my first thought was:
#link("https://devraza.duckdns.org/blog/hoaxes-overview/")[hoax];, and I
think that it was rightfully so.

== What exactly is wrong with this?
Several things. I’m no expert in cybersecurity - everyone’s a student in
some way, but I was sure that NFC was, as it’s name implies, for
#strong[near-field communication];. I’m repeating myself here, but
that’s kind of the point. Various reliable resources, including
Wikipedia, show that NFC has a maximum range of only a few centimetres -
which makes sense, no?

And yet, whatever source my friend had for 'subway skimmers' gave the
impression, or otherwise stated, that it would work within a radius of a
few feet, which is just impossible. Upon voicing my doubts, I was then
told that 'with a powerful enough antenna, it’s possible'. Hoaxes sure
are convincing, aren’t they? Unfortunately, I am not able to find the
source of my friend’s misinformation.

See, NFC only works within a few centimetres anyways. Even if it could
#emph[magically] work within a radius of a few feet, you’ve got to take
in the electromagnetic interference that the clothes and wallets people
have would bring to any malicious device. The point of electromagnetic
interference is especially true over a #emph[huge] area of a few feet
\(relatively), where you’ve got several NFC-enabled devices.

== Where it’s actually an issue
Of course, that isn’t to say there aren’t any issues with NFC and
malicious readers - I’m just saying that the word getting around is
horribly unrealistic. For example, a #emph[realistic] example of a
malicious NFC reader would be one placed on the card slots in cash
machines - you get:

- The short range (~20 cm)
- Only one device
- Lots of devices to read!

And so, you’ve got someone so much more realistic that poses an actual
threat!

= Conclusion
<conclusion>
The information above, which I deem accurate, is there. What I suggest
be taken away from this is pretty much the same as what is was for
#link("https://devraza.duckdns.org/blog/hoaxes-overview/")[my blog post on hoaxes] - #strong[do some fact-checking!]
