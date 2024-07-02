Return-Path: <netdev+bounces-108545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F49924233
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE63B296E0
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72B1BBBC4;
	Tue,  2 Jul 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fIy0Fp7u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204B1BBBD4;
	Tue,  2 Jul 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933506; cv=none; b=Hb2ACRXKxdcF61XsEKYADjBXQQV9H8+oVLH4A3JbUgWo5VUvO1jHjmmp5tGjLtrLgH1nxhgUNAPqdIRR2peQs+1uhH996VFpo2d3OsoxWIfD/01dUZ5VlhKWe260Kqls3H3G+TOl599cRrLCoB9U8q06JmEjTZUWFnHBnPhxj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933506; c=relaxed/simple;
	bh=a6DJ7pH4tyR5wo6kY04rlVL0se2e8oprnZgwDLceYoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3NbUzRDv5hyNOMyKcvCJLWd7xLX6nPoz1XaiqOHZL+6fAT3CKYSf9BjQemvA5DS5Sw0Pb+aa23e6XslOe1czl5xy8YjJ7zTsRvXLyB/wuTO0iwMIVTOe8X/qGIwPgnN9H9IJm8Xzp5yBgiIJ1z+PEFPPKkK/6M0QvEAfwK7x+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fIy0Fp7u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kdUn47/gq6g+0qOd86yp+fwhZ5S0l2vA+NvLBe75a20=; b=fIy0Fp7u5sxPEOhwX8NOknchNn
	LsVEPC2dQbGzBQAXsd73cbN23SzeiSX7MFwZlNa8awublHmuM0WUmasnv4XE3tDELi1wWAdyhaEmy
	aQRyif/AqdSdnWSdDeNnQ/V7LNPQbSB/1knB4fgi0k0N2vb5ZyJDNE4y6+I4JRcTiEnG2t/vzjAzm
	dTA8z5xHabOI1/zqstctbanZayg0TZfzISOlYdAKmEv8udT93hbPELlIeBmzvJCoQ/p9BQxPVXzXw
	gb8Er9APQwJscwvVxg/7tTTAn5bNwcr/8dpGaeOq9UFU7fIZZ3PhUsU8ze0jRqAar5YxvFpKR7PRE
	WBzWf12w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOfGm-00044t-0E;
	Tue, 02 Jul 2024 16:18:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOfGo-00022N-DG; Tue, 02 Jul 2024 16:18:14 +0100
Date: Tue, 2 Jul 2024 16:18:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Message-ID: <ZoQaNnbYJ1c5SH0c@shell.armlinux.org.uk>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
 <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
 <2273795.iZASKD2KPV@fw-rgant>
 <b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 02, 2024 at 03:21:09PM +0200, Andrew Lunn wrote:
> The SFP PHY is however a PHY which phylib is managing. And you have
> phylink on top of that, which knows about both PHYs. Architecturally,
> i really think phylink should be dealing with all this
> configuration.
> 
> The MAC driver has told phylink its pause capabilities.
> phylink_bringup_phy() will tell phylib these capabilities by calling
> phy_support_asym_pause(). Why does this not work for the SFP PHY?
> 
> phylink knows when the SFP PHY is plugged in, and knows if the link is
> admin up. It should be starting the state machine, not the PHY.

phylink only knows about SFPs that are directly connected to the
MAC/PCS. It has no knowledge of SFPs that are behind a PHY (like
on the Macchiatobin with 88x3310 PHYs.)

Due to the structure of the networking layer, I don't see how we
could sanely make stacked PHYs work - we expect the ethtool APIs
to target the media PHY, but in the case of a platform such as
Macchiatobin, we potentially have _two_ media facing PHYs on one
network interface. There's the 88x3310 which has its own RJ45
socket, and then if one plugs in a copper SFP, you get another
media-facing PHY with its own RJ45 socket. Which PHY should
ethtool ksettings_set interact with?

The ethtool API wasn't designed for this kind of thing!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

