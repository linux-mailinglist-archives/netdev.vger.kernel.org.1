Return-Path: <netdev+bounces-134253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A49988CA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C551C218CB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463DD1C9EDD;
	Thu, 10 Oct 2024 14:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E71C8FBA;
	Thu, 10 Oct 2024 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569269; cv=none; b=oRTf9is2hFwnbTonCTK7hds0xJ3TguJ4B0PZfHtflkW+AbqDlftsskuA8mKy6euGcSx5RsRVwB7en1vjOaHloZ/lewltq07bXTLUWn+m341Uo3Z3yGx2jtTdn6LLgtTx2cqTEQMOXI9VBR7HdrKsg+Icf91fGDY/cNkXp87M8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569269; c=relaxed/simple;
	bh=lsYW1BuZnBvNpBTuvwHHxoRqtLMm6Hg/VPlS3KH/J6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cobBHDStgKEhi2YZptCUUvrCl39JYkLorb2//TSz9NJDYDmovv39J5Bc/aY7lPY2P1BsfT/KKqUCtX1DfLgfyhQnN0rfCrP2IIoRBBm2qmZ8hrTgGze7czGEODPlZse9ySP7CrIemiW2qzHGUVdjsHoCOZmacPzRMr6FY+wu+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sytpF-000000003WF-3pvY;
	Thu, 10 Oct 2024 14:07:34 +0000
Date: Thu, 10 Oct 2024 15:07:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwffopLK0x26n206@makrotopia.org>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
 <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
 <Zwb2RzOQXd2Wfd6O@makrotopia.org>
 <ZwcQZmR0Q40ugXI7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwcQZmR0Q40ugXI7@shell.armlinux.org.uk>

On Thu, Oct 10, 2024 at 12:23:18AM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 10:31:51PM +0100, Daniel Golle wrote:
> > On Wed, Oct 09, 2024 at 09:12:06PM +0100, Russell King (Oracle) wrote:
> > > [...]
> > > The interface mode given in DT is just a "guide" because the 88x3310
> > > does no more than verify that the interface mode that it is bound with
> > > is one it supports. However, every time the link comes up, providing
> > > it is not operating in rate matching mode (which the PP2 doesn't
> > > support) it will change its MAC facing interface appropriately.
> > 
> > Unfortunately, and apparently different from the 88x3310, there is no
> > hardware strapping for this to be decided with RealTek's PHYs, but
> > using rate-matching or interface-mode-switching is decided by the
> > driver.
> 
> No, but there is firmware, and firmware provisioning determines the
> PHY behaviour. That's the equivalent of hardware pin strapping on
> Aquantia PHYs.

Yes, but there is broken firmware, or firmware which doesn't care
and always just expected the Linux driver to take care of that.
In many cases I've seen, U-Boot, for example, only initializes the
PHY and sets those registers in case it is configured to load
Linux via TFTP, or interrupted by the user who may chose to do that.
In the default case (loading Linux from flash) the PHY is not even
powered-up in some cases.

In case you mean firmware as in what Linux is presented in DT, then
yes, I agree. But we'll need define new bindings for that then.

> 
> I think you need to review a previous thread on the Aquantia PHYs
> and firmware setting stupid interface modes, and trying to fix the
> stuff up (and there in you will find the discussions about the
> firmware provisioning that determines how the MAC interface on these
> PHYs behave.
> 
> https://lore.kernel.org/lkml/20221115230207.2e77pifwruzkexbr@skbuf/T/
> 
> You'll also find other useful stuff relevant to this discussion too.
> This is the lore link for the phy-modes discussion:
> 
> https://lore.kernel.org/all/20211123164027.15618-1-kabel@kernel.org/T/

Thank you a lot for digging up those conversions. I've spent some hours
reading and understanding all of that, and well, things are complicated.

To my surprise, introducing an array of phy-connection-type or phy-mode
in DT has been positively received by the DT folks, but the idea was
then later on discarded by netdev participants of the debate. Imho that
would still be the best solution, but I understand the argument that
having to list all supported modes can be both tedious and hard to
review, and hence error-prone.

> > > So, what we do is in DT, we specify the maximum mode, and rely on the
> > > hardware being correctly strapped on the PHY to configure how the
> > > MAC side interface will be used.
> > 
> > Does that mean the realtek.c PHY driver (and maybe others as well) should
> > just assume that the MAC must also support SGMII mode in case 2500Base-X
> > is supported?
> > 
> > I was under the impression that there might be MAC out there which support
> > only 2500Base-X, or maybe 2500Base-X and 1000Base-X, but not SGMII. And on
> > those we would always need to use 2500Base-X with rate matching.
> > But maybe I'm wrong.
> 
> The problem I'm trying to point out is that doing what you're wanting
> has a high chance of causing _regressions_, causing setups that work
> today to stop working. We can't allow that to happen, sorry.

Of course :)

> Note that this interface switching mechanism was introduced early on
> with the 88x3310 PHY, before any documentation on it was available,
> and all that was known at the time is that the PHY switched between
> different MAC facing interface modes depending on the negotiated
> speed. It needed to be supported, and what we have came out of that.
> Legacy is important, due to the "no regressions" rule that we have
> in kernel development - we can't go breaking already working setups.

What about marking Ethernet drivers which are capable of interface
mode switching? Right now there isn't one "correct" thing to do for
PHY drivers, which is bad, as people may look into any driver as
a reference for the development of future drivers.

So why not introduce a MAC capability bit? Even dedicated for switching
between two specific modes (SGMII and 2500Base-X), to avoid any
ambiguitities or unnecessary feature-creep.

Typically switching between modes within the same PCS is more easy to
support, switching from 10:8 to 66:64 coding can be more involved,
and require resets which affect other links, so that's something
worth avoiding unless we really need it (in case the users inserts
a different SFP module it would be really needed, in case the external
link goes from 5 Gbit/s to 2.5 Gbit/s it might be worth avoiding
having to switch from 5GBase-R to 2500Base-X)

It wouldn't be the first time something like that would be done, however
I have full understanding that any reminder of that whole
legacy_pre_march2020 episode may trigger post-traumatic stress in netdev
maintainers.

> 
> > The same approach would not work for those RealTek PHYs and boards
> > using them. In some cases the bootloader sets up the PHY, and usually
> > there rate matching is used -- performance is not the goal there, but
> > simplicity. In other cases we rely entirely on the Linux PHY driver
> > to set things up. How would the PHY driver know whether it should
> > setup rate matching mode or interface switching mode?
> 
> In the case of the Realtek driver, it decides to override whatever came
> before in a defined way. E.g. rtl822xb_config_init().

Yes, and right now it would decide to always use 2500Base-X on a host
capable of 2500Base-X, and hence make use of RATE_MATCH_PAUSE for
1000M/100M/10M links, even though using SGMII would be better in terms
of energy consumption and performance.

> 
> > The SFP case is clear, it's using host_interfaces. But in the built-in
> > case, as of today, it always ends up in fixed interface mode with
> > rate matching.
> 
> "always rate matching" no. Fixed interface mode, yes. If
> rtl822xb_config_init() sees phydev->interface is set to SGMII, then
> it uses 2500BASEX_SGMII mode without rate matching - and the
> advertisement will be limited to 1G and below which will effectively
> prevent the PHY using 2.5G mode - which is fine in that case.

While that case might be relevant for SFP modules, in pracise, why would
anyone use a more expensive 2.5Gbit/s PHY on a board which only supports
up to 1Gbit/s -- that doesn't happen in the real world, because 1Gbit/s
SGMII PHYs are ubiquitous and much cheaper than faster ones.

> > Let me summarize:
> >  - We can't just assume that every MAC which supports 2500Base-X also
> >    supports SGMII. It might support only 2500Base-X, or 2500Base-X and
> >    1000Base-X, or the driver might not support switching between
> >    interface modes.
> >  - We can't rely on the PHY being pre-configured by the bootloader to
> >    either rate maching or interface-switching mode.
> >  - There are no strapping options for this, the only thing which is
> >    configured by strapping is the address.
> 
> Right, so the only _safe_ thing to do is to assume that:
> 
> 1. On existing PHY drivers which do not do any kind of interface
> switching, retrofitting interface switching of any kind is unsafe.

It's important to note that for the RealTek driver specifically we
have done that in OpenWrt from day 1 -- simply because the rate-matching
performed, especially by early versions of the PHY, is too bad. So we
always made the driver switch interface to SGMII in case of link speeds
slower than 2500M.
Now, with the backport of upstream commits replacing our downstream
patches, users started to complain that the issue of bad PHY performance
in 1 Gbit/s mode has returned, which is the whole reason why I started
to work on this issue.

I understand, however, there may of course be other users of those
RealTek 2.5G PHYs, even Rockchip with stmmac maybe, and that would
break if we assume the MAC can support switching between 2500Base-X
and SGMII, so users of those boards will have to live with the bad
performance of the rate-matching performed by the PHY unless someone
fixes the stmmac driver...

> 
> 2. On brand new PHY drivers which have no prior history, there can
> not be any regressions, so implementing interface switching from
> the very start is safe.
> 
> The only way out of this is by inventing something new for existing
> drivers that says "you can adopt a different behaviour" and that
> must be a per-platform switch - in other words, coming from the
> platform's firmware definition in some way.

Why would it not just be the MAC driver which indicates that it can
support switching to lower-speed interface modes it also supports?
Do you really believe there are boards which are electrically
unfit for performing SGMII on the traces intended for 2500Base-X?

If by 'firmware' you mean 'device tree' then we are back on square
one, and we would need several phy-connection-type aka. phy-mode
listed there.

After having read all the threads from 2021 you have provided links for,
I believe that maybe an additional property which lists the interface
modes to be used *optionally* and in addition to the primary (ie.
fastest) mode stated in phy-mode or phy-connection-type could be a way
out of this. It would still end up being potentially a longer list of
interface modes, but reality is complex! Looking at other corners of DT
it would still be rather simple and human readable (in contrast: take a
look at inhumanly long arrays of gpio-line-names where even the order
matters, for example...)

Yet, it would still be a partial violation of Device Tree rules because
we are (also) describing driver capabilities there then. What if, let's
say one day stmmac *will* support interface mode switching? Should we
update each and every board's device tree?

Hence, unless there is a really good reason to believe that a board which
works fine with 2500Base-X would not work equally well with SGMII, given
that both the MAC (-driver) and PHY (-driver) support both modes, I don't
see a need to burden firmware with having to list additional phy-modes.

Of course, I'm always only talking about allowing switching to slower
interface modes, and always only about modes which use a single pair
differential lanes (ie. sgmii, 1000base-x, 2500base-x, 5gbase-r,
10gbase-r, ...). 

> > > > Afaik, practially all rate-matching PHYs which do support half-duplex
> > > > modes on the TP interface can perform duplex-matching as well.
> > > 
> > > So we should remove that restriction!
> > 
> > Absolutely. That will solve at least half of the problem. It still
> > leaves us with a SerDes clock running 2.5x faster than it would have to,
> > PHY and MAC consuming more energy than they would have to and TX
> > performance being slightly worse (visible with iperf3 --bidir at least
> > with some PHYs). But at least the link would come up.
> 
> It also means we move forward!

ACK. Patch posted.

