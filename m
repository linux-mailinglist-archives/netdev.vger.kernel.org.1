Return-Path: <netdev+bounces-133964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B2997916
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC143B21CA6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6408D1E32A6;
	Wed,  9 Oct 2024 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LwaNj/Qq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DE169397;
	Wed,  9 Oct 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516215; cv=none; b=obLiPe1xKodrzKUSdeacPE11j0ofbq5PeUkpHE2LVwH1i41mkoUXAc3OkFys9xhZJsEXnrJ5eYDyOOy78I2ZLKSaKApcsrRv5p3U7oRK2Lg/qkdSeXpAypgvT8kf22GMjXqwm9nmpc/wFfL3qybJgT+8ZAD3ctjX6JPqENGF1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516215; c=relaxed/simple;
	bh=+C5Qr+mxYND4L29vfseI0DgHsb0pl9/0uuMChGraoGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XStfPrHRiYXlQ/GF3UhxWrscQvQtu+06ToUCuK79KG16faRiIO+zFvB9SpI6a5vFgfC6Llzc0acndEkCmneDNHh8x31Lrlzm7wLSmLI/owVgN12YGCkn0susGxyo9cakKftU7jZ2cQnqDUkPiCyMMGwNUS6ZbxD/ULjDJW5y+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LwaNj/Qq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KFvuVaa0REHDnUGWzgrjVSbD7JE24My6kkYs1+j+tfc=; b=LwaNj/Qqzw5qVrapJcR5IAEslI
	zJ48UafW+XnmHif2daNy1sdCWeZk0FIrrDI5kHGr14/teZl3O4x/lLj4rjslfiWT9Arqm4xSTIWRJ
	WJkmsc2hpG++VYz9WxhyWG/9w5rxG0Q8RvR1VhiYaSpooL23Wk3Whe6USDygK8ySxuG4tzlIOaZa9
	ZZ8b3IT8SKjOjz5ovj6v2juapBKX8Qdg405dDVkjjYX+XTMyhP9ffnOuE+AmN1y3K4qiNe6CJBUow
	xQCE91kvy9n/KCDSOe828NfjUVQU4MsrMzmFRAx0zdEfLVZ5HaYwseoq3zzc1X4tTer+Py90MZXgR
	pbYc5t9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syg1Z-0001PL-1r;
	Thu, 10 Oct 2024 00:23:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syg1W-0006iH-0u;
	Thu, 10 Oct 2024 00:23:18 +0100
Date: Thu, 10 Oct 2024 00:23:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwcQZmR0Q40ugXI7@shell.armlinux.org.uk>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
 <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
 <Zwb2RzOQXd2Wfd6O@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwb2RzOQXd2Wfd6O@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 10:31:51PM +0100, Daniel Golle wrote:
> On Wed, Oct 09, 2024 at 09:12:06PM +0100, Russell King (Oracle) wrote:
> > On Wed, Oct 09, 2024 at 07:52:42PM +0100, Daniel Golle wrote:
> > > [...]
> > > Imho allowing several available interface modes can still be
> > > advantageous also for built-in PHYs. Measurable power savings (~100mW on
> > > MT7986!) and not needing rate matching are both desireable things.
> > > 
> > > The question is just how would we get there...
> > 
> > We already do. Let me take an example that I use. Macchiatobin, which
> > you've probably heard lots about.
> > 
> > The PHY there is the 88x3310, which is configured to run in MAC mode 0
> > by hardware strapping. MAC mode 0 means the 88x3310 will switch between
> > 10GBASE-R, 5GBASE-R, 2500BASE-X and SGMII on its host interface.
> > 
> > The MAC is Marvell's PP2, which supports all of those, and being one of
> > the original MACs that phylink was developed against, is coded properly
> > such that it fully works with phylink dynamically changing the interface
> > mode.
> > 
> > The interface mode given in DT is just a "guide" because the 88x3310
> > does no more than verify that the interface mode that it is bound with
> > is one it supports. However, every time the link comes up, providing
> > it is not operating in rate matching mode (which the PP2 doesn't
> > support) it will change its MAC facing interface appropriately.
> 
> Unfortunately, and apparently different from the 88x3310, there is no
> hardware strapping for this to be decided with RealTek's PHYs, but
> using rate-matching or interface-mode-switching is decided by the
> driver.

No, but there is firmware, and firmware provisioning determines the
PHY behaviour. That's the equivalent of hardware pin strapping on
Aquantia PHYs.

I think you need to review a previous thread on the Aquantia PHYs
and firmware setting stupid interface modes, and trying to fix the
stuff up (and there in you will find the discussions about the
firmware provisioning that determines how the MAC interface on these
PHYs behave.

https://lore.kernel.org/lkml/20221115230207.2e77pifwruzkexbr@skbuf/T/

You'll also find other useful stuff relevant to this discussion too.
This is the lore link for the phy-modes discussion:

https://lore.kernel.org/all/20211123164027.15618-1-kabel@kernel.org/T/

> > Another board uses the 88x3310 with XAUI, and if I remember correctly,
> > the PHY is strapped for XAUI with rate matching mode. It's connected
> > to an 88e6390x DSA switch port 9, which supports RXAUI, XAUI, SGMII,
> > 1000BASEX, 2500BASEX and maybe other stuff too.
> > 
> > So, what we do is in DT, we specify the maximum mode, and rely on the
> > hardware being correctly strapped on the PHY to configure how the
> > MAC side interface will be used.
> 
> Does that mean the realtek.c PHY driver (and maybe others as well) should
> just assume that the MAC must also support SGMII mode in case 2500Base-X
> is supported?
> 
> I was under the impression that there might be MAC out there which support
> only 2500Base-X, or maybe 2500Base-X and 1000Base-X, but not SGMII. And on
> those we would always need to use 2500Base-X with rate matching.
> But maybe I'm wrong.

The problem I'm trying to point out is that doing what you're wanting
has a high chance of causing _regressions_, causing setups that work
today to stop working. We can't allow that to happen, sorry.

> > Now, the thing with that second board is... if we use your original
> > suggestion, then we end up filling the host_interfaces with just
> > 2500BASEX, 1000BASEX and SGMII. That will lead mv3310_select_mactype()
> > to select MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER for which the PHY will
> > attempt to use the modes I listed above for Macchiatobin on its MAC
> > interface which is wrong.
> > 
> > Let me repeat the point. phydev->host_interfaces is there to allow a
> > PHY driver to go off and make its own decisions about the interface
> > mode group that it should use _ignoring_ what's being asked of it
> > when the MAC binds to it. It should be empty for built-in setups
> > where this should not be used, and we have precedent on Macchiatobin
> > that interface switching by the PHY is permitted even in that
> > situation.
> 
> ... because it is decided before Linux even starts, and despite in
> armada-8040-mcbin.dts is stated.
>         phy-mode = "10gbase-r";

You may notice in the discussions I've linked above, phy-mode is the
"initial" MAC mode for these PHYs...

Note that this interface switching mechanism was introduced early on
with the 88x3310 PHY, before any documentation on it was available,
and all that was known at the time is that the PHY switched between
different MAC facing interface modes depending on the negotiated
speed. It needed to be supported, and what we have came out of that.
Legacy is important, due to the "no regressions" rule that we have
in kernel development - we can't go breaking already working setups.

> The same approach would not work for those RealTek PHYs and boards
> using them. In some cases the bootloader sets up the PHY, and usually
> there rate matching is used -- performance is not the goal there, but
> simplicity. In other cases we rely entirely on the Linux PHY driver
> to set things up. How would the PHY driver know whether it should
> setup rate matching mode or interface switching mode?

In the case of the Realtek driver, it decides to override whatever came
before in a defined way. E.g. rtl822xb_config_init().

> The SFP case is clear, it's using host_interfaces. But in the built-in
> case, as of today, it always ends up in fixed interface mode with
> rate matching.

"always rate matching" no. Fixed interface mode, yes. If
rtl822xb_config_init() sees phydev->interface is set to SGMII, then
it uses 2500BASEX_SGMII mode without rate matching - and the
advertisement will be limited to 1G and below which will effectively
prevent the PHY using 2.5G mode - which is fine in that case.

> > > > So, aqr107_get_rate_matching() should work out whether rate matching
> > > > will be used for the interface mode by scanning these registers.
> > > > [...]
> > > 
> > > Afaik Aquantia 2.5G PHYs always work only with a fixed interface mode
> > > and perform rate-matching for lower speeds.
> > 
> > They don't _have_ to. To use a SFP with an AQR PHY on it in a clearfog
> > platform (which only supports SGMII, 1000BASE-X and 2500BASE-X, I
> > hacked the aquantia driver to do this:
> > 
> >         phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1, MDIO_CTRL1_LPOWER);
> >         mdelay(10);
> >         phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x31a, 2);
> >         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_10M,
> >                       VEND1_GLOBAL_CFG_SGMII_AN |
> >                       VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> >         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_100M,
> >                       VEND1_GLOBAL_CFG_SGMII_AN |
> >                       VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> >         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_1G,
> >                       VEND1_GLOBAL_CFG_SGMII_AN |
> >                       VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> >         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_2_5G,
> >                       VEND1_GLOBAL_CFG_SGMII_AN |
> >                       VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII);
> >         phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1,
> >                            MDIO_CTRL1_LPOWER);
> > 
> > which disables rate matching and causes it to switch interfaces.
> 
> That's pretty cool, and when connected to a MAC which support both
> SGMII and 2500Base-X, and a driver which can switch between the two,
> it should be the default imho.
> 
> > 
> > Moreover, aqr107_read_status() reads the interface status and sets
> > the MAC interface accordingly, so the driver does support dynamically
> > changing the MAC interface just like 88x3310. If all use cases of
> > this PHY only ever did rate matching, then there would be no point
> > to that code being there!
> 
> So, just like for mcbin, the driver here replies on the PHY being
> configured (by strapping or by the bootloader) to either use
> a fixed interface mode with rate matching, or perform interface mode
> switching. What if we had to decide this in the driver (like it is
> the case with RealTek PHYs)?

Then we have a problem, because simply re-using the host_interfaces
for built-in PHYs is _going_ _to_ cause problems.

As I've said several times now... if all phylink users implemented the
phylink methods such that they can at run time switch between all the
interface modes in phylink's supported_interfaces (or only set
interface modes they were prepared to switch between), then that would
be a good first step forward. Unfortunately, for some, such as the
88e6390x, we can't tell exactly which interface mode is pinstrapped,
and we can't change the interface mode. So, we have to live with the
fact that ->supported_interfaces is less than accurate.

> Let me summarize:
>  - We can't just assume that every MAC which supports 2500Base-X also
>    supports SGMII. It might support only 2500Base-X, or 2500Base-X and
>    1000Base-X, or the driver might not support switching between
>    interface modes.
>  - We can't rely on the PHY being pre-configured by the bootloader to
>    either rate maching or interface-switching mode.
>  - There are no strapping options for this, the only thing which is
>    configured by strapping is the address.

Right, so the only _safe_ thing to do is to assume that:

1. On existing PHY drivers which do not do any kind of interface
switching, retrofitting interface switching of any kind is unsafe.

2. On brand new PHY drivers which have no prior history, there can
not be any regressions, so implementing interface switching from
the very start is safe.

The only way out of this is by inventing something new for existing
drivers that says "you can adopt a different behaviour" and that
must be a per-platform switch - in other words, coming from the
platform's firmware definition in some way.

> > > > Now, while phylink restricts RATE_MATCH_PAUSE to being full-duplex only,
> > > > I'm not sure that is correct. I didn't contribute this support, and I
> > > > don't have any platforms that support this, and I don't have any
> > > > experience of it.
> > > 
> > > Afaik enforcing half-duplex via rate-maching with pause-frames is
> > > supported by all the 2.5G PHYs I've seen up to now.
> > 
> > I'm sorry, I don't understand your sentence, because it just flies
> > wildly against everything that's been said.
> > 
> > First, pause-frames require full duplex on the link on which pause
> > frames are to be sent and received. That's fundamental.
> 
> I meant pause-frames on the host-side interface of the PHY, which
> are used to perform rate and duplex matching for the remote-side
> interface. I hope that makes more sense now.
> 
> > 
> > Second, I'm not sure what "enforcing half-duplex" has to do with
> > rate-matching with pause-frames.
> 
> It can be used as a method to preventing the MAC from sending
> to the PHY while receiving.
> 
> > 
> > Third, the 88x3310 without MACSEC in rate matching mode requires the
> > MAC to pace itself. No support for pause frames at all - you only
> > get pause frames with the 88x3310P which has MACSEC. This is a 10M
> > to 10G PHY multi-rate PHY.
> > 
> > So... your comment makes no sense to me, sorry.
> 
> You misunderstood me. I didn't mean pause frames on the remote-side of
> the PHY. I meant pause frames as in RATE_MATCH_PAUSE.

You also misunderstand me. I wasn't talking about remote-side of the
PHY either! I'm also none the wiser exactly what you meant by "Afaik
enforcing half-duplex via rate-maching with pause-frames is supported
by all the 2.5G PHYs I've seen up to now."

When rate matching with pause frames is being used, the host-side
interface _must_ be in full duplex mode, because that is the only
time when pause frames are permitted to be used by a MAC. I think
we agree on that.

What I'm having a hard time understanding is *enforcing* half-duplex.
I think what you're trying to say is not "enforcing" the use of
half-duplex somewhere, but pause frames over the host link to
prevent transmission while receiving.

It's likely not that simple - the PHY probably has buffering of
the transmit frame (consider the difference in the time it takes
to send a frame at 10G speeds vs a potential media speed of 10M.)
What the PHY will do is send pause frames when that buffer gets
full (e.g. after receiving one packet to be transmitted) until
it has enough space to accept another transmit packet. If the
link is in half-duplex mode, then the PHY will need to do the
receive detection, collision handling, and retries of the pending
frame itself because there will be no way to signal back to the
MAC "that last frame you sent me, could you resend because it
collided".

> > > > What I do have is the data sheet for 88x3310, and that doesn't mention
> > > > any restriction such as "only full duplex is supported in rate matching
> > > > mode".
> > > 
> > > Yep, and I suppose it should work just fine. The same applies for
> > > RealTek and MaxLinear PHYs. I've tested it.
> > > 
> > > > It is true that to use pause frames, the MAC/PCS must be in full-duplex
> > > > mode, but if the PHY supports half-duplex on the media to full-duplex
> > > > on the MAC side link, then why should phylink restrict this to be
> > > > full-duplex only?
> > > 
> > > There is no reason for that imho. phylink.c states
> > > /* Although a duplex-matching phy might exist, we
> > >  * conservatively remove these modes because the MAC
> > >  * will not be aware of the half-duplex nature of the
> > >  * link.
> > >  */
> > > 
> > > Afaik, practially all rate-matching PHYs which do support half-duplex
> > > modes on the TP interface can perform duplex-matching as well.
> > 
> > So we should remove that restriction!
> 
> Absolutely. That will solve at least half of the problem. It still
> leaves us with a SerDes clock running 2.5x faster than it would have to,
> PHY and MAC consuming more energy than they would have to and TX
> performance being slightly worse (visible with iperf3 --bidir at least
> with some PHYs). But at least the link would come up.

It also means we move forward!

> > > > I suspect phylink_get_capabilities() handling for RATE_MATCH_PAUSE is
> > > > not correct - or maybe not versatile enough.
> > > 
> > > I agree. Never the less, why use rate matching at all if we don't have
> > > to? It's obviously inefficient and wasteful, having the MAC follow the
> > > PHY speed is preferrable in every case imho.
> > 
> > As I say, I believe this is a matter of how the Aquantia firmware is
> > commissioned - I believe the defaults for all of the VEND1_GLOBAL_CFG*
> > registers come from the firmware that the PHY loads.
> 
> I must admit I don't care much about the Aquantia story in the
> picture here. Simply because the rate-matching implementation they
> got seems to work rather well, and there anyway aren't many low-cost
> mass-produced devices having Aquantia 2.5GBit/s PHYs. I know exactly
> one device (Ubiquity UniFi 6 LR v1) which isn't produced in that
> version any more -- later versions replaced the rather costly
> Aquantia PHY with a low-cost RealTek PHY.
> 
> There are millions of devices with Intel/MaxLinear GPY211, and
> probably even by magnitudes more with RealTek RTL8221B. Having all
> those devices perform rate-matching and hence running the SerDes
> clock at 3.125 GHz instead of 1.250 GHz is not just a significant
> waste of electricity, but also just means wrose performance, esp. on
> 1000 MBit/s links (which happen to still be the most common).
> 
> > 
> > So much like the pin strapping of 88x3310 determines its set of MAC
> > modes, which are decided by the board designer, Aquantia firmware
> > determines the PHY behaviour.
> > 
> > The problem here is we need to be mindful of the existing
> > implementations, not only those where the MAC/PHY combination would
> > get stuff wrong, but also of those MACs where multiple different
> > interfaces are supported through hardware strapping which is not
> > software determinable, but are not software configurable (like DSA
> > switches.) Then there's those who hacked phylink into their use
> > without properly implementing it (e.g. where mac_config() is entirely
> > empty, and thus support no reconfiguration of the interface yet
> > support multiple different interfaces at driver initialisation time.)
> > 
> > Yes, some of these situations can be said to be buggy. Feel free to
> > spend a few years hacking on stmmac to try and fix that god almighty
> > mess. I've given up with stmmac now after trying several attempts at
> > cleaning the mess up, and ending up in a very non-productive place
> > with it.
> 
> Sounds dreadful. However, just because one driver is a crazy mess it
> should mean that all drivers have to perform worse than they could.
> Can you name a few boards which rely on that particularly smelly
> code? I might get some of those and get a feel of how bad things are,
> and maybe I will spend a few years trying to improve things there.

Well, when you realise that stmmac's internal PCS implementation
entirely bypasses phylink yet the driver uses phylink... I had
patches, now junked.

I tried some simpler cleanups before trying to fix that, which got
massively hung up on an insanely trivial question about whether
"%d" or "%u" should be used to print the speed in a mac_link_up
method... and resulted in me junking the entire set of stmmac
patches I had.

I've given up with stmmac. You may notice that my recent XPCS
patch series only _minimally_ touched the stmmac code. It could've
gone further, but I really want to touch stmmac as little as
possible now. I've decided it's a hopeless case. In fact, I've
asked that the driver backs out its use of phylink... which has
been ignored. So... at this point, as phylink maintainer, my
only option is to ignore stmmac for any more major changes and
leave the updates to whoever cares about stmmac. I don't like
reaching that point with a driver, but I see no other option
with it given the history..

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

