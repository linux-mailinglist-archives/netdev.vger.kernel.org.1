Return-Path: <netdev+bounces-249973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3923D21C42
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67CC730213DF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD437F8BC;
	Wed, 14 Jan 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tmFj3/IC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA17392C57;
	Wed, 14 Jan 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433457; cv=none; b=swQZLP6jl46923YbrQn69YvX9kGO2ZCyee17Ss89CHFggCHtj+PvXT+DsixvKixHQfJexnXi8KbFurNYACiq0aXDeM01MWwnJ7zSbFXW7ejNOtEXCWZfahjk+EliiTYdt2+LgwsE/58XzRdWM+eyeaFtIxp6LSqNFddEtw7LP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433457; c=relaxed/simple;
	bh=Aj1V3oEaM4lxPepI3F6k0D5zGVB8AuaiOkjv8+QRYnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVAwr9144aprNVWNPgHvxwp/3t7Jx2PGrAqBm/Z1RpnZG474PQqemDwMVrvTbwvvErTN8/Nhoyzw+NMYB75nfGAug0bre2Hpo9TIYD52DoaFXqbQ/wqU8tkngAeT+HtIqtBnN2HC0+wcJ4UrAsV8V3xe6CIRBMmSXo0SoEEJSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tmFj3/IC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+iYzsvx/P00phS6sz+zC58IgyrS6IJI8Js8SxN6/qjQ=; b=tmFj3/IC6B2WZ2ItUrngVjA7P1
	HfI3BvrqJ91qhk+k+VFqXjVCYxD+IA0VgfMMW25KEaIqQ37lX3f/Pt4oSo1Y9M437bWhWESEQRimy
	qth2Y8iC2lWB6gteqiliOKJqum7DVg02+fPkYpilrCLEabbVaKul0R3Jxv9UgyBld3dGyGKfvsS8g
	GetJn9J9pEr2SrsVz0Vmg1HzdrBedqGpUJJSZdaFQQ6iD6qZLAsuZnlmall63p6dardPNFIacj3LJ
	WKZmYkIwPmnlvqfy0FJXuEKhjayZoE6p7r3GskBusQ5ueyEaVatKcSBlApzPLqJJqOfqWN8MpynnL
	Hb5DX76Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgAK2-000000000lM-1Gx7;
	Wed, 14 Jan 2026 23:30:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgAJz-0000000023M-0Qqr;
	Wed, 14 Jan 2026 23:30:39 +0000
Date: Wed, 14 Jan 2026 23:30:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 2/6] net: phylink: Allow more interfaces in SFP
 interface selection
Message-ID: <aWgnHo01j38TF3lp@shell.armlinux.org.uk>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
 <20260114225731.811993-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114225731.811993-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 14, 2026 at 11:57:24PM +0100, Maxime Chevallier wrote:
> When phylink handles an SFP module that contains a PHY, it selects a
> phy_interface to use to communicate with it. This selection ensures that
> the highest speed gets achieved, based on the linkmodes we want to
> support in the module.
> 
> This approach doesn't take into account the supported interfaces
> reported by the module

This is intentional by design, because the capabilities of the PHY
override in this case. Unfortunately, as I've said previously, the
rush to throw in a regurgitated version of my obsoleted
"host_interfaces" rather messed up my replacement patch set which
had the PHY driver advertising the interface capabilities of the
PHY, which were then going to be used to make the PHY interface
selection when attaching the PHY.

I've still got the code, but I can't now push it into mainline
because, with the obsolete host_interfaces stuff merged, we will end
up with two competing solutions.

In any case, I really would appreciate people looking through
http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue

before doing development on SFP and phylink to see whether I've
already something that solves their issue. Quite simply, I don't have
the time to push every patch out that I have, especially as I'm up to
my eyeballs with the crappy stmmac driver now, but also because I
have work items from Oracle that reduce the time I can work on
mainline. BTW, the "age" stated in cgit is based on the commit time
(which gets reset when rebased) not the initial merge time. You will
see that the "supported_interfaces" stuff dates from 2019, not 2025.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

