Return-Path: <netdev+bounces-203256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2153AF107D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634641898178
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18A23D285;
	Wed,  2 Jul 2025 09:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1824DD07
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449597; cv=none; b=hPhE4Hje89C8rELD7j/hwYrJDTYVKoBr/ueJ8nmaM5KnFJ1dX3NNn9JFGuw32wx2Ak1HVTldhE7gwP4wZv313NqtIKgkC51woqXgebxeS2fpFNLaPCpp6a1X/NPSqChN3EKcFpqAya6SMqOoPQ2ShfdHYwbqq9fSo7huSjVpFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449597; c=relaxed/simple;
	bh=fcqLwKrtBfo+Rc0zgHHKHepYzHt0trmddqrZRYjg/Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6jgY0qr4erLkjpeQqSCYSz0L8SgqyvFy4oQFgEKg5lWGD5iZv0VmyzFjlkRs7b58xm1j3zwmeozw5geaTexn8C1J2GGHfY6rNwJWe1oVEtrIWS+Ao0pUthtZy+0sz9AKMcvWvrRQ7lGPxRoIpBQUu8tMg4pN1/+x51KFqY16rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uWu2Z-0007ke-ED; Wed, 02 Jul 2025 11:46:07 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWu2X-006PhV-26;
	Wed, 02 Jul 2025 11:46:05 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWu2X-00DaqA-1k;
	Wed, 02 Jul 2025 11:46:05 +0200
Date: Wed, 2 Jul 2025 11:46:05 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: Re: [PATCH net v1 4/4] net: phy: smsc: Disable IRQ support to
 prevent link state corruption
Message-ID: <aGT_3SpVVzJFzT6B@pengutronix.de>
References: <20250701122146.35579-1-o.rempel@pengutronix.de>
 <20250701122146.35579-5-o.rempel@pengutronix.de>
 <aGPba6fX1bqgVfYC@wunner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGPba6fX1bqgVfYC@wunner.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Lukas,

On Tue, Jul 01, 2025 at 02:58:19PM +0200, Lukas Wunner wrote:
> On Tue, Jul 01, 2025 at 02:21:46PM +0200, Oleksij Rempel wrote:
> > Disable interrupt handling for the LAN87xx PHY to prevent the network
> > interface from entering a corrupted state after rapid configuration
> > changes.
> > 
> > When the link configuration is changed quickly, the PHY can get stuck in
> > a non-functional state. In this state, 'ethtool' reports that a link is
> > present, but 'ip link' shows NO-CARRIER, and the interface is unable to
> > transfer data.
> [...]
> > --- a/drivers/net/phy/smsc.c
> > +++ b/drivers/net/phy/smsc.c
> > @@ -746,10 +746,6 @@ static struct phy_driver smsc_phy_driver[] = {
> >  	.soft_reset	= smsc_phy_reset,
> >  	.config_aneg	= lan87xx_config_aneg,
> >  
> > -	/* IRQ related */
> > -	.config_intr	= smsc_phy_config_intr,
> > -	.handle_interrupt = smsc_phy_handle_interrupt,
> > -
> 
> Well, that's not good.  I guess this means that the interrupt is
> polled again, so we basically go back to the suboptimal behavior
> prior to 1ce8b37241ed?

Not fully. It will disable interrupt support only for the embedded PHY,
other types of interrupts should work as expected.

> Without support for interrupt handling, we can't take advantage
> of the GPIOs on the chip for interrupt generation.  Nor can we
> properly support runtime PM if no cable is attached.

Hm... the PHY smsc driver is not using EDPD mode by default if PHY
interrupts are enabled. Or do you mean other kind of PM?

> What's the actual root cause?  Is it the issue described in this
> paragraph of 1ce8b37241ed's commit message?
> 
>     Normally the PHY interrupt should be masked until the PHY driver has
>     cleared it.  However masking requires a (sleeping) USB transaction and
>     interrupts are received in (non-sleepable) softirq context.  I decided
>     not to mask the interrupt at all (by using the dummy_irq_chip's noop
>     ->irq_mask() callback):  The USB interrupt endpoint is polled in 1 msec
>     intervals and normally that's sufficient to wake the PHY driver's IRQ
>     thread and have it clear the interrupt.  If it does take longer, worst
>     thing that can happen is the IRQ thread is woken again.  No big deal.

I'm not sure. It seems to be not the problem.

> There must be better options than going back to polling.
> E.g. inserting delays to avoid the PHY getting wedged.
> 
> TBH I did test this thoroughly back in the day and never
> witnessed the issue.

I did some testing back in time too. It worked and still works normally
in the autoneg mode.

What is not working as expected is the fixed mode, especially 10 mbit
fixed mode.

Here are my current testing results:

# configure 10 mbit forced mode:
ethtool -s eth0 autoneg off speed 10 duplex half
# attach cable (can be done wothout reataching cable)
[10174.585150] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[10174.586760] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[10174.594636] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[10174.602777] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[10174.841458] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[10174.843017] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[10174.850619] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[10174.857026] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[10175.425513] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[10175.427046] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[10175.434871] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[10175.441332] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off

At this point no more interrupts will come and link up state will not be
detected. Replugging cable will have same result.

The worst part - unplugging the cable may trigger an endless interrupt storm
(which is some times reproducible in the 10Mbit forced mode):
[ 1584.132799] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.134220] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.389134] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.390591] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.644757] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.646177] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.900781] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1584.902305] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 1585.158416] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098

With latest kernel we can use adaptive polling, wich I added now for
testing. Here are the results:

[ 2200.702427] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2200.948552] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2200.949640] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2200.950182] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2200.951374] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2200.953186] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2200.959234] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2201.204270] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.205284] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.207139] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.208825] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.216406] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2201.460548] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.461618] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.462181] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.463273] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.464764] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.471066] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2201.716547] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.717607] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.718235] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.719267] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.721035] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.727488] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2201.972542] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.973614] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.974176] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2201.975321] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.977078] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2201.983500] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2202.228538] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2202.229615] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2202.230174] smsc95xx 1-1.1:1.0 enu1u1: intdata: 0x00008000
[ 2202.231292] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2202.233038] smsc_phy_handle_interrupt: MII_LAN83C185_ISF = 0x0098
[ 2202.238972] lan87xx_read_status: link: no, speed: 10, duplex: half, autoneg: off
[ 2202.239018] smsc_phy_get_next_update: next update in 250 jiffies
[ 2203.258566] lan87xx_read_status: link: yes, speed: 10, duplex: half, autoneg: off
[ 2203.258756] smsc95xx 1-1.1:1.0 enu1u1: Link is Up - 10Mbps/Half - flow control off

With adaptive polling we can use both. Since IRQ down interrupt works as
expected, we can use low frequency polling (one per 30 seconds) in link up
state. On link down state, after last interrupt poll one time per second
for 30 seconds, then switch to low frequency polling (one per 30
seconds).

I need to figure out haw to handle an interrupt storm.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

