Return-Path: <netdev+bounces-216213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB446B3291F
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5128B3BF508
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5662A1B4248;
	Sat, 23 Aug 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WyEtgVxm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5801DF756;
	Sat, 23 Aug 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959065; cv=none; b=R6Oo+t0PWDjpXH4W9QP0PaTAuGmyT3ksFYMrJt60dXfsWjm+nWoyXKLD4wTiJA38v1UUDiADXH5WFEXvdISFp1Bq96jpd4oXqi4LUFc9Xb78gManIXSixUK85z/gUPIXzD4Vqz3CoCKSwZxJBSb4g6gIuhGrTI87n8HpVr6YBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959065; c=relaxed/simple;
	bh=d4KRSvpm6IFTz3lYPyYZ6DVLrPoMUFcpAfLIPktkdVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddtv4M4HidVLcw4qhGt35M791TNNZr77CVhuis+/KwOIbyY2r0SquOmsj4T/NBrpEvmnQqX6cGhHA0i9f+TRgxzg6mQiu60labsjDXaBlezIU/YEIs4VVcS6lvzzOI5NY3ewON4FTRox5ew1qfLHMiYaJ2ct56pALCmOvYogGrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WyEtgVxm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9jD+xDE70g8iGy1GF2aioLLMzeI9ldwxuhRXoKaVxYo=; b=WyEtgVxmgm9N6EtHKhv/I2E+H8
	vtJ2uWdMrDGWlypDSgz+uWqfOqWDgBM9uwFCKhUUARN/ILf2+hkphUXUdgKfrC6JwrSqUn9tjh1X7
	rf2QwzWtzrzVDsh/PFr352KUUi7COPQUXHsKVEhBiABmowxvQNkG6sSFnPelICGL7M04flEEBBNpf
	PQmJEztkfGh9SA2IjCsQaJHFeTDz3UYw8zi9Pf2DxSsTg19J3AU914gNp2o4nkQT3dbEuwU6GZoPj
	D4jYD4qcoQAzR08lEAA+rdnb0C079Z+x/b5LZQUr9CpDpczkHl2AAM8v0AnvEAfZY2Jy4pJ/fWzF6
	Sq87tjwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43170)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uppA5-000000004ok-1hdC;
	Sat, 23 Aug 2025 15:24:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uppA1-000000003A4-2Sji;
	Sat, 23 Aug 2025 15:24:01 +0100
Date: Sat, 23 Aug 2025 15:24:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: marvell: 88e1111: define gigabit
 features
Message-ID: <aKnPAamqRIDS-5kP@shell.armlinux.org.uk>
References: <20250823-cisco-1g-sfp-phy-features-v1-1-3b3806b89a22@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823-cisco-1g-sfp-phy-features-v1-1-3b3806b89a22@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Aug 23, 2025 at 04:03:12PM +0200, Josua Mayer wrote:
> When connecting RJ45 SFP modules to Linux an ethernet phy is expected -
> and probed on the i2c bus when possible. Once the PHY probed, phylink
> populates the supported link modes for the netdev based on bmsr
> register bits set at the time (see phy_device.c: phy_probe).

No, phy*lib* does this.

> Marvell phy driver probe function only allocates memory, leaving actual
> configuration for config_init callback.
> This means the supported link modes of the netdev depend entirely on the
> power-on status of the phy bmsr register.
> 
> Certain Cisco SFP modules such as GLC-T and GLC-TE have invalid
> configuration at power-on: MII_M1111_HWCFG_MODE_COPPER_1000X_AN
> This means fiber with automatic negotiation to copper. As the module
> exhibits a physical RJ45 connector this configuration is wrong.
> As a consequence after power-on the bmsr does not set bits for 10/100
> modes.
> 
> During config_init marvell phy driver identifies the correct intended
> MII_M1111_HWCFG_MODE_SGMII_NO_CLK which means sgmii with automatic
> negotiation to copper, and configures the phy accordingly.
> 
> At this point the bmsr register correctly indicates support for 10/100
> link modes - however the netedev supported modes bitmask is never
> updated.
> 
> Hence the netdev fails to negotiate or link-up at 10/100
> speeds, limiting to 1000 links only.
> 
> Explicitly define features for 88e1111 phy to ensure that all supported
> modes are available at runtime even when phy power-on configuration was
> invalid.

So we have a PHY which changes what it's capable of depending on its
configuration, which gives us a chicken-and-egg problem when it comes
to working out whether a PHY (on a SFP module) can be used with a
MAC, because it's not clear from reading its abilities what it might
actually be capable of.

So yes, I think this is the right approach for the common case - but
if we really do have a PHY that's using 1000base-X -to- Copper mode,
this change will be wrong.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

