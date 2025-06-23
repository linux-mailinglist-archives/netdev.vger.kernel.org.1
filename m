Return-Path: <netdev+bounces-200392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA430AE4CA7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA83B75DE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5B29CB39;
	Mon, 23 Jun 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UQWMLTC/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13657F4F1;
	Mon, 23 Jun 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702733; cv=none; b=nkUpR+UJXw5hz85QsUYMoUI1kVIbfi9UGDn8IxJEYNQoi8/Iq+N5o769xTv+LU8TL7boDc8RKG+KagnwFJmOjp/S7/yS0FriZlYTlgGmXD5KP7Gv84MZeK8+EeRdd0msq4H2ATIIwPj5rGOjwcrVUy2e7MFfkEPdPPyP4K5JiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702733; c=relaxed/simple;
	bh=LRg203HjqpXqGj5igh6y7EQ9fNWriKYbUf8Swp8VaL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF/HO0TqCbjPeGIJHpCHRuxHSdzTzhuBSulJwYGSxYYW15UxkZ2Cyg/N7AXpmrrf4joSLM2C4KppLv7c7Lw89Zr3xbQYC6PfMuKqWbrpkEU0sAAAKBmkx3GC1frLzJvlHTF53Nj3kl10etVkkxSQB3XzBj4Jo13dKQ8Zb2MOAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UQWMLTC/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hZucWyu2YRnBxb3pgEyb43gTVvvxosFS8u9z4rrVDbU=; b=UQWMLTC/oqQWY6Y8QHGRiW6Let
	MsTTOl6+8AX7NRzgreK/WBaxWfpBCMAC58j3Ji5onl7DrWkRUHs9I6DOVUYVhpwx3HKKNeY7ldCzm
	HjEe58G+pEYDZyBvPunm7cJpOaSpijWYeUMBbOFzNcxpLiKIwxExhI1CUAVSEakXk9TPlo9CJr0yc
	76q4Cmjw1wpxxtpaOZ1M5sebAis8Vwo8HuSBaWGHkq4bYKMcDErKHlimmi7A9GxuJNHAY0+Qu4F3m
	d3auJYsAWQuxw41mk5j33oVxOkKpEfgF8AfYrsFKbObbRXDou5fxwIybqYIp+kPfIIXP0uLERRi5b
	iFhlYgIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55424)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uTlkc-0004Xi-0m;
	Mon, 23 Jun 2025 19:18:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uTlkY-0003fJ-03;
	Mon, 23 Jun 2025 19:18:34 +0100
Date: Mon, 23 Jun 2025 19:18:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite
 mode
Message-ID: <aFmaeY7Ibw5xSEl9@shell.armlinux.org.uk>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-2-kamilh@axis.com>
 <20250623175135.5ddee2ea@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
 <8735eb08-92de-4489-9e52-fee91c9ed23e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735eb08-92de-4489-9e52-fee91c9ed23e@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 23, 2025 at 07:55:03PM +0200, Andrew Lunn wrote:
> On Mon, Jun 23, 2025 at 05:51:35PM +0200, Maxime Chevallier wrote:
> > Hi Kamil,
> > 
> > On Mon, 23 Jun 2025 17:10:46 +0200
> > Kamil Horák - 2N <kamilh@axis.com> wrote:
> > 
> > > From: Kamil Horák (2N) <kamilh@axis.com>
> > > 
> > > The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
> > > simplified MII mode, without TXER, RXER, CRS and COL signals as defined
> > > for the MII. While the PHY can be strapped for MII mode, the selection
> > > between MII and MII-Lite must be done by software.
> > > The MII-Lite mode can be used with some Ethernet controllers, usually
> > > those used in automotive applications. The absence of COL signal
> > > makes half-duplex link modes impossible but does not interfere with
> > > BroadR-Reach link modes on Broadcom PHYs, because they are full-duplex
> > > only. The MII-Lite mode can be also used on an Ethernet controller with
> > > full MII interface by just leaving the input signals (RXER, CRS, COL)
> > > inactive.
> > 
> > I'm following-up to Andrew's suggestion of making it a dedicated
> > phy-mode. You say that this requires only phy-side configuration,
> > however you also say that with MII-lite, you can't do half-duplex.
> > 
> > Looking at the way we configure the MAC to PHY link, how can the MAC
> > driver know that HD isn't available if this is a phy-only property ?
> 
> One would hope that when the PHY is configured to -lite, it changes
> its abilities register to indicate it does not support half duplex
> modes? But without looking at the datasheet, i've no idea if it
> actually does.
> 
> There is also an ordering issuer, it needs to be put into -lite mode
> before phy_probe reads the abilities, which is after the probe()
> method is called. However, at this point, we don't know the interface
> mode, that only comes later.
> 
> So this gets interesting, and there is no indication in the commit
> message this has been thought about.

... which is another reaosn for using phylink, because phylink
restricts the abilities of the PHY (and its advertisement) according
to the PHY interface mode.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

