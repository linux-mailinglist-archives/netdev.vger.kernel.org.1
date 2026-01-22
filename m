Return-Path: <netdev+bounces-252327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAWOI5MacmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:39:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C766BF3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 505EF6CC42F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E533D1CA5;
	Thu, 22 Jan 2026 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bZXi2Bff"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4942D12F5;
	Thu, 22 Jan 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083826; cv=none; b=Ydcf6jnxHKvo+46kbpTkmx078N7Ka95QAmCyK1beWrpFBT7OEybszYbDnsU0TgQqm6xDUL2/QQK7OF5k2fRgvH+wITSpxozweHPB3qeoOfteesc0W9TREuSP9/KrttlSEH9d8d4TIgOlo+6vaK9hDjFXnhPIpwR1rRGv3/IPdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083826; c=relaxed/simple;
	bh=AkSkWa1GedgxarHMhpxFhR6xD0F4XF9+sd/e9zlpiYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3zi+olq0hjvPcS6H0rw+XLZcaUSOjWpmHBdSWQSAxvMOpIFliAVqeB4ap/25Gp66xwJ8xjfe5d5pWX67qoInH5pLgDqiRxs+wVjLUsL83WQ3kty5VRX0aSnOq7oCYCVs+5UIuoujGKJuDlVSXF190G33kdi7mz9vxTSzTrHW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bZXi2Bff; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LnKYuZxa2OHav4X4/qAMbWJzUU3nGMol7ZsPdm054gI=; b=bZXi2BffIUKVQ+I6W1OecHu9SQ
	lPSEtKcPEojXjJcFEjG56INsk2E6jbgFGeu6VTzcB11IFkvIpSkcbfur1ob8HpZeqNcjTgCXsZDlk
	X6j7Rg4jgjY6pnTh2IwsBtG2JoryobN8/Z0ui9FXw+52wLRQ1pU7dfD5JjfC8/WwvHcRbWFKve8wF
	sA41wS4Cl2xdG4JqpYi7BWdHRMbH+AHyAHUA0luNv06b5/7d8jfKIzhiCww6+lhY45Z3Fp08KcFRL
	8/eRa3KxJR5JWpVEj/LJCTVEJM+U+6ygy5FOR8jBI5rZr7NiyIvL+9mxiaxuOGda1DasEQuuK1GuM
	160fe/8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54166)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vitVr-000000000Kr-061Y;
	Thu, 22 Jan 2026 12:10:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vitVk-000000000zN-1Qkh;
	Thu, 22 Jan 2026 12:10:04 +0000
Date: Thu, 22 Jan 2026 12:10:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: Re: [RFC PATCH v2 2/2] net: mdio: rtl9300: setup PHY polling
 registers
Message-ID: <aXITnCLt945xHqaP@shell.armlinux.org.uk>
References: <cover.1769053496.git.daniel@makrotopia.org>
 <680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmx.de];
	TAGGED_FROM(0.00)[bounces-252327-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 414C766BF3
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:00:56AM +0000, Daniel Golle wrote:
> +	/* Detect if PHY has 2.5G/5G/10G capabilities */
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported) ||
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported) ||
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported))
> +		mac_type = SMI_MAC_TYPE_CTRL_2G_PLUS;
> +	else
> +		mac_type = SMI_MAC_TYPE_CTRL_1G;

There are PHYs which change their support depending on how they're
configured, and there are PHYs that aren't configured correctly at
probe time (and thus their ->supported mask is not correct.)

The next thing I'm concerned about is the need to encode register
information into this driver for each PHY that could be connected.
Will there only be a small subset of PHYs that get used with this
switch, or can any PHY be connected? If the latter, then encoding
register information doesn't scale.

So, I don't think this is a good solution.

I'm wondering whether it would be better to have a callback through
the bus when the PHY is connected with a netdev (in other words,
after phy_init_hw() in phy_attach_direct()) which should be when
the ->supported mask is fully up to date. This also means that the
driver is bound, and we could then consider some kind of interface
that would allow data about the PHY to be requested, such as register
information. That would likely eliminate your need to test the
phydev->supported bitmask (which I think is there to determine whether
you need to tell your MDIO polling controller where certain registers
are.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

