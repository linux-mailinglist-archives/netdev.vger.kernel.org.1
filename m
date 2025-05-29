Return-Path: <netdev+bounces-194180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADBAC7B3E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885AD3B264D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A126C3B9;
	Thu, 29 May 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QZQy4S+j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178BF26C39F;
	Thu, 29 May 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511656; cv=none; b=sNIqlg45/sox8xhGjhn8mg3bMhB4/FFe2VxEbx4BrRdUo8gKGzM1i1Qh9BVz+sr6dW9jiiE2pj2yauomZ6CHZPlVjA0769ezZWKjTLwx8F7wl3iD9WJrGZDsPh/KGu/w4QBoCFNjL6dULuvDMI328a7+isEOU9oo+uxfyEuNA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511656; c=relaxed/simple;
	bh=/kjav/+bPaoZVE53qCcjzniWgN+ZFHEb8BrZDJLHJL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msrayiRAprxENLdDtLPXyLq2NpW3ftzn3NIqXVyVXJp3QCOR8tR8R4H0n0QakGBYqXkcVAtPdOqLKROf5r3OGhwnPWGAdXXVLeK9rBxl1osZLxoNoqk3aj7lu0RY9c2uLOZmh1diuyvtEcL7TA2P09N3d4spCmhwLGecciiXByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QZQy4S+j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=62BhX69mt+FQ1/nAowHZZeanKaiAAITWTNXpapK76TM=; b=QZQy4S+jSFdT1G4qH1jtTKXTOD
	lR8nYl95sgn39OWK5pGfqFmkCqc0xzJGoFWVa+uZj8edkdflc4whX+K0QDMWeFrGV21x04XlvgDCF
	1xSWYA4vSVInQg+J74NM6QmErNMDvNNXEKSiSQ55chLmIUdU2CVDumOowl4P5wgclk1VUxwpXUpjL
	M60fXXjEKMJRA29pIlWk9DNtfaPnS9eRyYACu4vnogjU3m4a93hH678R1x24PDc5L8o9FJYO602eZ
	fy61JMEkdHF17UHHWvLxebiLQtpGAvVMiBw13AiluwLevN3/NzFFY7XbbiRM3eGRPNCZQPi76NU6p
	HCMxvAHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41504)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uKZkc-0001CY-2z;
	Thu, 29 May 2025 10:40:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uKZkY-0003Ln-2W;
	Thu, 29 May 2025 10:40:34 +0100
Date: Thu, 29 May 2025 10:40:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>
Subject: Re: [PATCH net-next v5 07/13] net: phy: phy_caps: Allow looking-up
 link caps based on speed and duplex
Message-ID: <aDgrkog2BcLjF1VV@shell.armlinux.org.uk>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-8-maxime.chevallier@bootlin.com>
 <5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 29, 2025 at 05:36:11PM +0800, Jijie Shao wrote:
> Hi Maxime,  fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex") might have different behavior than the modification.
> My case is set 10M Half with disable autoneg both sides and I expect it is
> link in 10M Half. But now, it is link in 10M Full，which is not what I
> expect.
> 
> I used followed command and trace how phy worked.
> 	ethtool -s eth1 autoneg off speed 10 duplex half
> The log is showed as followed:
> ethtool-13127	[067]	6164.771853: phy_ethtool_ksettings set: (phy_ethtool ksettings set+0x0/0x200) duplex=0 speed=10
> kworker/u322:2-11096	[070]	6164.771853:	_phy_start_aneq: ( _phy_start_aneg+0x0/0xb8) duplex=0 speed=10
> kworker/u322:2-11096	[070]	6164.771854:	phy_caps_lookup: (phy_caps_lookup+0x0/0xf0) duplex=0 speed=10
> kworker/u322:2-11096	[070]	6164.771855:	phy_config_aneg: (phy_config_aneg+0x0/0x70) duplex=1 speed=10
> kworker/u322:2-11096	[070]	6164.771856:	genphy_config_aneg:	(__genphy_config_aneg+0X0/0X270) duplex=1 speed=10
> 
> I also try to fixed it and it works. Do you have any idea about it.
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 0e762fc3a529..2986c41c42a8 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -258,7 +258,7 @@ static void phy_sanitize_settings(struct phy_device *phydev)
>         const struct link_capabilities *c;
> 
>         c = phy_caps_lookup(phydev->speed, phydev->duplex, phydev->supported,
> -                           false);
> +                           true);

This isn't the correct fix, as:

+ * When @exact is not set, we return either an exact match, or matching capabilities
+ * at lower speed, or the lowest matching speed, or NULL.

So it isn't returning the exact match but apparently ignoring the
duplex.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

