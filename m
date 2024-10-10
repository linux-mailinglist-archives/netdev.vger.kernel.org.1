Return-Path: <netdev+bounces-134338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D36998D71
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D283289C7E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB61CEE93;
	Thu, 10 Oct 2024 16:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1351CEABD;
	Thu, 10 Oct 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577715; cv=none; b=Tu+98TQC4wZqI5ar5w9yv76+BHwADGG2iBEUe9WCzpwcrY9ouhGtd4Y8U/e9ECBMS+PRGfPSO2sOEHwhh33wrXoRtqjevCD5L2joMypnwFPidVmFrvXRylR7w6asMbHmdlgWAMUYWsl8LkQbJLw8S2SjQ/ZJYev+dGAgFLHIB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577715; c=relaxed/simple;
	bh=GaecT/0pD3zgixvYsIjfZKWkAIPBIQCXIkagwWPfifo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFja4rxZoMYKwaZmIT9diPlbLghYV/8PXiFYb1WvpKJpeWUl6y9jUd+kxgK4CrfPxV/W7UYvlq+yc8lloBrjeoBxUdCSZBedms4S/r+F2M/U5vrvHHbL4YrEyYaMJlaNBYTOHvkvOCzX9jBHf8ndrOC6rJ8FXHLBGYcDJroi5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syw1W-000000004Bx-2oUN;
	Thu, 10 Oct 2024 16:28:22 +0000
Date: Thu, 10 Oct 2024 17:28:18 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwgAomacnmOtg8AK@makrotopia.org>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
 <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
 <Zwb2RzOQXd2Wfd6O@makrotopia.org>
 <ZwcQZmR0Q40ugXI7@shell.armlinux.org.uk>
 <ZwffopLK0x26n206@makrotopia.org>
 <ZwfrnFpqTlt0GnMn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwfrnFpqTlt0GnMn@shell.armlinux.org.uk>

On Thu, Oct 10, 2024 at 03:58:36PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 10, 2024 at 03:07:30PM +0100, Daniel Golle wrote:
> > > Note that this interface switching mechanism was introduced early on
> > > with the 88x3310 PHY, before any documentation on it was available,
> > > and all that was known at the time is that the PHY switched between
> > > different MAC facing interface modes depending on the negotiated
> > > speed. It needed to be supported, and what we have came out of that.
> > > Legacy is important, due to the "no regressions" rule that we have
> > > in kernel development - we can't go breaking already working setups.
> > 
> > What about marking Ethernet drivers which are capable of interface
> > mode switching? Right now there isn't one "correct" thing to do for
> > PHY drivers, which is bad, as people may look into any driver as
> > a reference for the development of future drivers.
> > 
> > So why not introduce a MAC capability bit? Even dedicated for switching
> > between two specific modes (SGMII and 2500Base-X), to avoid any
> > ambiguitities or unnecessary feature-creep.
> 
> They already have a perfectly good way to do this today. They can look
> at DT and set just one mode in the ->supported_interfaces bitmap if
> they don't support interface switching!

Some drivers seem to support multiple interface modes, but don't support
switching between them if asked to do so by the PHY. That was the
potential cause for regressions you named in case we would populate
host_interfaces also for on-board PHYs (independently of how careful or
selective we would do that, which is another story).

> The MAC drivers are already
> responsible for parsing the phy-mode from firmware, and it's that
> driver that also knows whether it knows if it supports interface
> switching or not. So I don't see any need for additional capability
> bits.

I agree that the MAC driver should know whether it can do PHY-requested
mode switches, however, at this point phylink doesn't. We may want to
let phylink know that the MAC (-driver) is fit for such acrobatic moves,
instead of just assuming that in PHY drivers by historic precedence, no?

Let me reiterate over the current situation:

 - The mxl-gpy.c depends on the PHY being pre-provisioned by early boot
   firmware to decide whether it should do interface mode switching or
   perform rate matching. Some (but not all) board vendors correctly
   provision the PHY (ie. to perform interface mode switching), others
   just set it to rate-matching because it's easier to support when
   using the Ethernet connection **within the bootloader**.
   After all, this is not so much of a problem because while still being
   a potential waste of power (clocks running 2.5x faster even if not
   needed to) the rate matching is at least implemented in a way which
   works well and doesn't hurt too much beyond wasting ~100 milliwatts.

 - Marvell PHYs use pin strapping to decide that.

 - Aquantia seems to rely on provisioned firmware.

 - The RealTek driver currently decides whether to use interface mode
   switching or rate matching based on the selected (main) interface
   mode as well as phydev->host_interfaces.
   * host_interfaces is not set unless the PHY is used on a SFP module
   * the driver hence ends up always using a fixed interface mode for
     on-board PHYs.
     => This is bad because we end up using the (bad) rate matching
        instead of interface mode switching (good) even though that
        would be perfectly supported by both MAC and PHY.
        - We currently don't have a way for phylink to know whether
          a MAC can perform interface mode switching
        - Populating host_interfaces also for on-board PHYs was
          rejected because it might introduce regressions due to MAC
          drivers not being able to perform interface mode switching
          and relying on the current behaviour.
          => We may hence need a way for phylink to know whether an
             Ethernet MAC can perform interface mode switching or not.

> > I understand, however, there may of course be other users of those
> > RealTek 2.5G PHYs, even Rockchip with stmmac maybe, and that would
> > break if we assume the MAC can support switching between 2500Base-X
> > and SGMII, so users of those boards will have to live with the bad
> > performance of the rate-matching performed by the PHY unless someone
> > fixes the stmmac driver...
> 
> If OpenWRT's switching predates July 2017, then maybe they should've
> been more pro-active at getting their patches upstream?

No, and there were no consumer-grade devices with 2.5G PHYs back then.
The first started to show up around 2020. The first to be supported by
OpenWrt was the before mentioned Ubiquiti UniFi 6 LR AP, sporting an
Aquanria AQR112 2.5G PHY connected via 2500Base-X, and always performing
rate matching.

The RealTek 2.5G PHY driver creeped in via their PCIe Ethernet NIC
drivers, and in the beginning (2020) only supported the PHYs built-into
those PCIe NIC chips. Most setup of the built-in PHY is anyway done by
the NIC driver, so nobody bothered to implement config_init() until we
started to see devices using the RTL8226 (later renamed to RTL8221B) as
standalone PHY ICs connected to router SoCs around 2021/22. Soon people
contributed OpenWrt support for those boards, initially just not
understanding why the PHY would only work with 2500Base-T links but not
with 1000Base-T, 100Base-TX, ...

At some point Alexander Couzens and me were working on sorting out
proper support for those PHYs, including interface mode switching, and
Alexander implemented the config_init() and update_interface()
functions.

I initially tried to upstream the patch Alexander Couzens had written
for that in 2023, and back then we assumed that interface mode switching
would always be performed in case 2500Base-X was the main mode.
However, I gave up at some point because I was asked for detailed
definition of the PHY registers and bits, which, frankly speaking, just
doesn't exist, not even in RealTek's under-NDA datasheet which merely
lists some magic sequences of register writes.

https://patchwork.kernel.org/comment/25331309/

In December 2023 Marek Behún then modified the patch and sent it
upstream once again. It was part of a bigger series improving the
driver, and he clearly stated that:
"All this is done so that we can support another 2.5G copper SFP module"

https://patchwork.kernel.org/project/netdevbpf/cover/20231220155518.15692-1-kabel@kernel.org/

This series (luckily without anyone asking for non-existent register
definitions this time) ended up in mainline Linux.

As OpenWrt generally tries to be as close to upstream as possible the
downstream patches for the RealTek PHY drivers have then been replaced
by backports of the corresponding commits in mainline Linux earlier this
year.

This has resulted in multiple reports of degraded performance, and it
took a while until I understood that Marek's version of the config_init
function only sets the PHY to perform interface mode switching if that
is indicated by host_interfaces -- and built-in PHYs will *always* use a
fixed interface mode now.

We could of course just introduce a downstream patch changing that
again, e.g. by letting the driver assume that SGMII is also supported in
case 2500Base-X is supported -- but that may not be true for all the
Ethernet MACs out there. Some might not support SGMII at all, or not be
ready to perform interface mode switching.

Hence, and we may need a way for phylink or the phy driver to
destinguish whether interface mode switching is supported by the
Ethernet MAC or not.

> 
> Unfortunately, in July 2017, there was nothing in mainline supporting
> 2500base*, and nothing doing any interface switching until I added
> the Marvell 88x3310 driver which was where _I_ proposed interface
> switching being added to phylib.

Yes, and that has worked well.
We should have a way to make use of it also on boards with on-board PHYs
which are at the same time also used on boards which rely on Ethernet
drivers which do not support SGMII, or don't support switching the
interface mode.

> 
> > > 2. On brand new PHY drivers which have no prior history, there can
> > > not be any regressions, so implementing interface switching from
> > > the very start is safe.
> > > 
> > > The only way out of this is by inventing something new for existing
> > > drivers that says "you can adopt a different behaviour" and that
> > > must be a per-platform switch - in other words, coming from the
> > > platform's firmware definition in some way.
> > 
> > Why would it not just be the MAC driver which indicates that it can
> > support switching to lower-speed interface modes it also supports?
> > Do you really believe there are boards which are electrically
> > unfit for performing SGMII on the traces intended for 2500Base-X?
> 
> For a single-lane serdes, what you say is true. However, it is not
> universal across all interface modes.

Of course not, but for single-lane serdes it could (and, if possible,
should!) be done.

> 
> As I stated in a previous discussion, if we have e.g. four lanes of
> XAUI between a PHY and MAC, and both ends support XAUI, RXAUI,
> 10GBASE-R, 5GBASE-R, 2500BASE-X, and SGMII, it does not necessarily
> follow that the platform can support 10GBASE-R and 5GBASE-R over
> a single lane because the signalling rate is so much higher. Just
> because the overall speed is the same or lower does not automatically
> mean that it can be used.
> 
> > If by 'firmware' you mean 'device tree' then we are back on square
> > one, and we would need several phy-connection-type aka. phy-mode
> > listed there.
> > 
> > After having read all the threads from 2021 you have provided links for,
> > I believe that maybe an additional property which lists the interface
> > modes to be used *optionally* and in addition to the primary (ie.
> > fastest) mode stated in phy-mode or phy-connection-type could be a way
> > out of this. It would still end up being potentially a longer list of
> > interface modes, but reality is complex! Looking at other corners of DT
> > it would still be rather simple and human readable (in contrast: take a
> > look at inhumanly long arrays of gpio-line-names where even the order
> > matters, for example...)
> > 
> > Yet, it would still be a partial violation of Device Tree rules because
> > we are (also) describing driver capabilities there then. What if, let's
> > say one day stmmac *will* support interface mode switching? Should we
> > update each and every board's device tree?
> 
> Well, I guess we need people that adopt phylink to actually implement
> it properly rather than just slapping it into their driver in a way
> that "works for them". :)

+1

> 
> This is a battle that I've been trying for years with, but programmers
> are lazy individuals who don't want to (a) read API documentation, (b)
> implement things properly.
> 
> Anyway, I'm out of time right now to continue replying to this
> conversation (it's taken over an hour so far to put what I've said
> together, and I now have a meeting... so reached the end of what I can
> do right now... so close to the end of your email too! Alas...

Thank you for putting all this time into it. I think the problem itself
is simple and well understood by both of us. It was already well
understood in 2021. There are many possible solutions to chose from:

1) List multiple phy-connection-type (aka. phy-mode) in DT, populate
   host_interfaces accordingly.

2) Let the MAC indicate that it supports mode switching, so phylink would
   populate host_interfaces accordingly.

3) Assume that MAC supports mode switching to slower, also supported,
   single-lane SerDes modes (and risk breakage because of bad drivers),
   and populate host_interfaces accordingly.

4) Change the PHY driver to assume SGMII and interface mode switching is
   always supported in case 2500Base-X is the mode declared in DT.

5) Live with bad performance of RealTek's rate matching (not acceptable
   for OpenWrt)

6) Throw all devices with cheapo PHYs or bad boot firmware in the bin
   (bad for the environment, and consumer wallets)

7) Downstream hacks (current situation in OpenWrt and vendor firmware)

Did I forget any?

3) and 4) may obviously cause regressions.
So, from what I can see, only 1) and 2) would allow us to do anything
else than 7) from OpenWrt's perspective.

I totally understand if Linux netdev maintainers chose 5) or 6),
however, for OpenWrt the result in that case would be to move the
existing downstream patches from "pending" to "hack", which means that
we will not attempt to send them upstream.

