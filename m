Return-Path: <netdev+bounces-250614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FED385BC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598E2310164A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842D322A28;
	Fri, 16 Jan 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PC8hgBR/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B41F1932;
	Fri, 16 Jan 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591381; cv=none; b=MMQ2ULIRj4rBr1vIcyOs2SEvh19SMwTjeW7pLp04jHwp3s2sv07MPzTp0/PRw5SHohKKAmRYcPMtjZ5U6V0j+dNGEekzmDJmUqN/9EvpUi0vCCeast88+H/vno1iBT5PGd5wgGswM511gV8jGRccpqSqWpuuXPKKHQOsylqOn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591381; c=relaxed/simple;
	bh=AaA921OgWgVGcYxhc/bFfdVLOLTjeI93lm9H8nt8ULU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p35siKoQ2PIYOhRf6RhQonLsN+UQkqxyfoOp9nDrKdN6VjZznuMv8ZMpCz2xwarog+bW2iWClpJVbrhRJa4f2v+9WAwDV0KdZQb38SVhtyIEiYIclp6W/oG+OAfUTksFlND7B4gKmGPTNo6e64I19r4Hqkt4kGFUX582wupMciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PC8hgBR/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNIBJ/gbrOzWSlLTD1GWeFnlI64FCaEfCKZHp3Gq1yQ=; b=PC8hgBR/4eKiTuiiAtp6ojEkup
	vEwn0OMgJ03AK1nFjyZaycmOaMDTRvSp0h3KWJUYQycJyvd7u1x/ChRwJkRgewR/zQ0FpJfDNBTIi
	z4POefgQ4NKvrdTKRovA0oqn5Gv4CCJrJGiMD9hsPN7HlTELnCtqKGJoF2VUlX/p9BT1L/1SkmpSQ
	2MqkAI69LcGQy/3sqAwHQARTyaqXE9xV8wwpnLt+wQpYkDV6LPIvn+/dtVZK6u1RUG6xjbw2ULBG5
	17/e/zjEqHhOAYp1+83uiYTDUaNn9rxc41wsPR920b0UAc1LiZT7NudOS5lkcQ3ulMEKsPlhxDG8m
	FFCUoZZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55682)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgpPB-000000002bC-2XxK;
	Fri, 16 Jan 2026 19:22:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgpP4-000000003qk-41XR;
	Fri, 16 Jan 2026 19:22:38 +0000
Date: Fri, 16 Jan 2026 19:22:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWqP_hhX73x_8Qs1@shell.armlinux.org.uk>
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
 <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
 <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
 <aWp-lDunV9URYNRL@shell.armlinux.org.uk>
 <3a93c79e-f755-4642-a3b0-1cce7d0ea0ef@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a93c79e-f755-4642-a3b0-1cce7d0ea0ef@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 07:27:16PM +0100, Maxime Chevallier wrote:
> Hi,
> 
> On 16/01/2026 19:08, Russell King (Oracle) wrote:
> > On Fri, Jan 16, 2026 at 01:37:48PM +0000, Russell King (Oracle) wrote:
> >> On Fri, Jan 16, 2026 at 12:50:35AM +0000, Russell King (Oracle) wrote:
> >>> However, while this may explain the transmit slowdown because it's
> >>> on the transmit side, it doesn't explain the receive problem.
> >>
> >> I'm bisecting to find the cause of the receive issue, but it's going to
> >> take a long time (in the mean time, I can't do any mainline work.)
> >>
> >> So far, the range of good/bad has been narrowed down to 6.14 is good,
> >> 1b98f357dadd ("Merge tag 'net-next-6.16' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next") is bad.
> >>
> >> 14 more iterations to go. Might be complete by Sunday. (Slowness in
> >> building the more fully featured net-next I use primarily for build
> >> testing, the slowness of the platform to reboot, and the need to
> >> manually test each build.)
> > 
> > Well, that's been a waste of time today. While the next iteration was
> > building, because it's been suspicious that each and every bisect
> > point has failed so far, I decided to re-check 6.14, and that fails.
> > So, it looks like this problem has existed for some considerable
> > time. I don't have the compute power locally to bisect over a massive
> > range of kernels, so I'm afraid stmmac receive is going to have to
> > stay broken unless someone else can bisect (and find a "good" point
> > in the git history.)
> > 
> 
> To me RX looks OK, at least on the various devices I have that use
> stmmac. It's fine on Cyclone V socfpga, and imx8mp. Maybe that's Jetson
> specific ?

Maybe - it could be something to do with MMUs slowing down the packet
rate, or it could be uncovering a bug in stmmac's handling of dwmac4
when it runs out of descriptors in the ring.

The problem I'm seeing is that RBU ends up being set in the channel 0
control register (there's only a single channel) which means that the
hardware moved on to the next receive descriptor, and found that it
didn't own it.

It _should_ be counted by this statistic:

     rx_buf_unav_irq: 0

but clearly, this doesn't work, because here is the channel 0 status
register:

Value at address 0x02491160: 0x00000484

which has:

#define DMA_CHAN_STATUS_RBU             BIT(7)

set. The documentation I have (sadly not for Xavier but for stm32mp151)
states that when this occurs, a "Receive Poll Demand" command needs to
be issued, but fails to explain how to do that. Older cores (such as
dwmac1000) had a "received poll demand" register to write to for this.

> I've got pretty-much line rate with a basic 'iperf3 -c XX" and same with
> 'iperf3 -c XX -R". What commands are you running to check the issue ?

Merely iperf3 -R -c XX, it's enough to make it fall over normally
within the first second.

> Are you still seeing the pause frames flood ?

Yes, because the receive DMA has stopped, which makes the FIFO between
the MAC and MTL fill above the threshold for sending pause frames.

In order to stop the disruption to my network (because it basically
causes *everything* to clog up) I've had to turn off pause autoneg,
but that doesn't affect whether or not this happens.

It _may_ be worth testing whether adding a ndelay(500) into the
receive processing path, thereby making it intentionally slow,
allows you to reproduce the problem. If it does, then that confirms
that we're missing something in the dwmac4 handling for RBU.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

