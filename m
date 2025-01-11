Return-Path: <netdev+bounces-157401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512E9A0A291
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 11:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BEA7A2FF2
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4617A5BE;
	Sat, 11 Jan 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BA+eJEq7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E1224D7
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736589728; cv=none; b=oe4aYgEENhbBiHPjdWaENYytFGTTRzO5t9Za6vi0b/xwU4uFKOC73/12435cdygg8nmVklt2VrcuVdo/P/MaEo55zg/yRWs7UHueLLPhfiWNqrgzeeLCXkKVML06WlCCLRcq221jfe7AISTexbtEWISqS/pt5JicH6ugGuyAbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736589728; c=relaxed/simple;
	bh=NF5za0BArxv4lF/3B6FSt2VbhgvfekPrDjw+xB0Rt4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3R6XOgInWH1uyKV/PxSFzxQArb25gXDut/sA79Rh7rOqLv6skuDBAEJhFJimo2Tts1ZIjy+UuBT3NVzny4Gt948fRrrIB2n3wUF12ha3Avkl884A0hjjiXEXwl/+krXho4GUdpl2QNNel6vzCeSskYTC9L3ksmqidtxLCIGrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BA+eJEq7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bp9MrtnHpJ/ofZ+QhEP8v4uuSTbm/2afaj7se19CfHU=; b=BA+eJEq7pkanJ8OILoi38BLj2e
	oZvx283mZmbMbpyFBwuFnVbFxWGI2Bh7T1976L+lZgX9SEuyJgA60IfH9bAd+esxmTHew7p9qhhiW
	RG0fxVRYWWiCyRVZKnpF+m1js90h/FNcSkxGBPli5ZjTenfYnWn7xgxoC0o5w/6mu6onZn/we0xBz
	vFoJRvyZAu3+DIMATwQPG4KNuQFYS4M6Hcd6GPuKXuTOJVRPsKRFqCil4c/gkBhAAanIbaW967z3V
	6+hpx3vhHXZEbmfg3u/C9+x2RTBn6KyxpEIQ1arvT9DDOCRuJr6G20PoZSoUPMXECBiN07Pqv9R6a
	bUkclYqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53752)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tWYJb-0004Vi-1q;
	Sat, 11 Jan 2025 10:01:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tWYJZ-0000pY-2r;
	Sat, 11 Jan 2025 10:01:57 +0000
Date: Sat, 11 Jan 2025 10:01:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
Message-ID: <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
 <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 11, 2025 at 10:44:25AM +0100, Heiner Kallweit wrote:
> On 11.01.2025 10:21, Russell King (Oracle) wrote:
> > On Sat, Jan 11, 2025 at 10:06:02AM +0100, Heiner Kallweit wrote:
> >> Link modes in phydev->eee_disabled_modes are filtered out by
> >> genphy_c45_write_eee_adv() and won't be advertised. Therefore
> >> don't accept such modes from userspace.
> > 
> > Why do we need this? Surely if the MAC doesn't support modes, then they
> > should be filtered out of phydev->supported_eee so that userspace knows
> > that the mode is not supported by the network interface as a whole, just
> > like we do for phydev->supported.
> > 
> > That would give us the checking here.
> > 
> Removing EEE modes to be disabled from supported_eee is problematic
> because of how genphy_c45_write_eee_adv() works.
> 
> Let's say we have a 2.5Gbps PHY and want to disable EEE at 2.5Gbps. If we
> remove 2.5Gbps from supported_eee, then the following check is false:
> if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES))
> What would result in the 2.5Gbps mode not getting disabled.

Ok. Do we at least remove the broken modes from the supported mask
reported to userspace?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

