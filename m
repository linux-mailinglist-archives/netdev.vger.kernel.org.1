Return-Path: <netdev+bounces-26386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C2777ADC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ED21C215E9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C31ADF8;
	Thu, 10 Aug 2023 14:36:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A651E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:36:43 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2EB2684
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1SRmLprLJmwREFQ6LXlWeMC3HtmVfaMbnBQwXr4wJ4Y=; b=YQmDJMoqqXErw5+pz8Hgp9HD6K
	HiRpu+zaVsepBtH0aEpFFv2n5uykvgaBT7X0PGL/PUyQtK3bcF3X46Ywjuik99AiKRyUn6QiZBc0K
	uDB2s5QHTgdjWEL3CpDGltZdkJjmCh8EAhd63pPpbQDlTVo2Zbm5ivZqt2l6zRrkrh2lxgZ2PHyGK
	3Io0pqIL9ZPrtXMjRX9HshY/y9b+kk7BtK5Dvq/2I5xBwAS++jtuGVJ1ggeOiseeKCOIux+PMACnh
	ykmTc0E4/OXbAFAgnKrlrrO+4FWqMLom1Fmjhc8VbUBhnLAUCZTAWR3lj0YJ6Q6wPD221DUWi2aD1
	aeCoZ0LQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU6mA-00046s-2C;
	Thu, 10 Aug 2023 15:36:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU6m8-0001sJ-7s; Thu, 10 Aug 2023 15:36:32 +0100
Date: Thu, 10 Aug 2023 15:36:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNT18BsOZPGLN+Dj@shell.armlinux.org.uk>
References: <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
 <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
 <20230810125117.GD13300@pengutronix.de>
 <ZNTjQnufpCPMEEwd@shell.armlinux.org.uk>
 <ffc4c902-689a-495a-9b57-e72601547c53@lunn.ch>
 <ZNTsMuuvqaOh6x0Q@shell.armlinux.org.uk>
 <52154174-d3c3-4482-81c7-eadde1fed8af@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52154174-d3c3-4482-81c7-eadde1fed8af@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 04:23:08PM +0200, Andrew Lunn wrote:
> On Thu, Aug 10, 2023 at 02:54:58PM +0100, Russell King (Oracle) wrote:
> > On Thu, Aug 10, 2023 at 03:49:24PM +0200, Andrew Lunn wrote:
> > > > > What will be the best way to solve this issue for DSA switches attached to
> > > > > MAC with RGMII RXC requirements?
> > > > 
> > > > I have no idea - the problem there is the model that has been adopted
> > > > in Linux is that there is no direct relationship between the DSA switch
> > > > and the MAC like there is with a PHY.
> > > 
> > > A clock provider/consumer relationship can be expressed in DT. The DSA
> > > switch port would provide the clock, rather than the PHY.
> > 
> > Then we'll be in to people wanting to do it for PHYs as well, and as
> > we've recently discussed that isn't something we want because of the
> > dependencies it creates between mdio drivers and mac drivers.
> > 
> > Wouldn't the same dependency issue also apply for a DSA switch on a
> > MDIO bus, where the MDIO bus is part of the MAC driver?
> 
> We already have some level of circular dependencies with DSA, e.g. the
> MAC driver provides the MDIO bus with the switch on it. It registers
> the MDIO bus, causing the switch to probe. That probe fails because
> the MAC driver has not registered its interface yet, which is the CPU
> interface. We end up deferring the switch probe, and by the second
> attempt, the MAC is fully registered and the switch probes.

If that sequence occurs with a MAC that wants a clock from DSA, then
we're at a loss...

The DSA driver probe fails because the MAC hasn't fully registered
itself, so doesn't create the clock. The MAC driver tries to get the
clock but it doesn't exist, so it defers, tearing down the MDIO bus
in the process.

> The circular dependency with a clock consumer/provider between the MAC
> and switch will be worse. We would need to avoid getting the clock in
> the probe function. It would need to happen in during open, by which
> time the switch should be present. MAC drivers also typically connect
> to their PHY during open, not probe, so i don't see this as being too
> big a problem.

Providing nothing is happening in the MAC driver initialisation which
requires that clock, then that would be fine.

Removal should be possible provided the MAC driver doesn't need
anything before it removes the MDIO bus.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

