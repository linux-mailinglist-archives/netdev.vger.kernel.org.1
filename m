Return-Path: <netdev+bounces-237882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAEC51218
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148481895E43
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEC2F39BD;
	Wed, 12 Nov 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WHtuunsT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEB2F617C
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936441; cv=none; b=Iye9NsBK6dhjFWzec6P2JEbOD8GnBB+I6bVyKZAFTM6/YoaV+uA2sxdj7oQtCRf+Qw5Gmo0fJLqfWkIwoRsuAFNhJ6MfFmrunjME8cVuecd6Bhw1SmX/6M1BClS04THmme0lLAoR/KcN7hdVZl3UAFOGWX/0lNB5ZR7vtHntq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936441; c=relaxed/simple;
	bh=bokRzc54GVe8W6oduREEJvk/PaKJNo1RzV355x8lVt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IodaYzBXQzYhy6tZ+3HzMu1dxNInXwbxqvJOFsOAebwJ35zCqA2tIyIg6spjqdghI2wRiLBo0wQ1TxQMcg7W44DDb88PGIZvM/2y7Pls4Qsvu1wTRIB4tjsruLxZ5vN9d+bvTHW3GEsghD7K+OzVVlPv8Yct4oeMyFOTomx1aaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WHtuunsT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cf2GYI+/yCcGPnacLcn3Cky5+fe23MqTI2IoOnZsu2s=; b=WHtuunsT1LjisomxJRxpuHtNDN
	9yZEhz+uh0qFoV7gYiGdibgmUt9edS9+MeYCyofZ8VcIDHmJV4HQ2RYhQGAn+t7WB7Xyjlb2TzucV
	VLCfpQ3BpLUIYJvYiYhrUXYLMYkDqTOphW6kAr2lYYqibBHhSakcIuSz2xwmiyk3F1JBylZq2mheC
	I31Rqx0tGFQ+Vy04HzFmqCQ+YqZgO342nFrV9CKsFH0abGvRyW4TRTqdGlFQtl1GN5U1D1xjlfUjo
	bK9ChCJ8IMzt/8AVruuc8+/oGToUsGHVFgQV1SHFSxp93w4TgD+WsN4XtlB9miZdhb2awt9KMQ2AB
	0BPqfOIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39690)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJ6IY-000000003Y3-30kd;
	Wed, 12 Nov 2025 08:33:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJ6IW-000000003jx-1J9a;
	Wed, 12 Nov 2025 08:33:48 +0000
Date: Wed, 12 Nov 2025 08:33:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: phy: TI PHYs use
 phy_get_features_no_eee()
Message-ID: <aRRGbAR26GuyKKZl@shell.armlinux.org.uk>
References: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
 <E1vImhv-0000000DrQi-49UR@rmk-PC.armlinux.org.uk>
 <aRRFDUewyw9x7teC@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRRFDUewyw9x7teC@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 12, 2025 at 09:27:57AM +0100, Oleksij Rempel wrote:
> On Tue, Nov 11, 2025 at 11:38:43AM +0000, Russell King (Oracle) wrote:
> > As TI Gigabit PHYs do not support EEE, use the newly introduced
> > phy_get_features_no_eee() to read the features but mark EEE as
> > disabled.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
...
> > @@ -1196,6 +1198,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
> >  		.name		= (_name),			\
> >  		/* PHY_BASIC_FEATURES */			\
> >  		.probe          = dp83826_probe,		\
> > +		.get_features	= phy_get_features_no_eee,	\
> >  		.soft_reset	= dp83822_phy_reset,		\
> >  		.config_init	= dp83826_config_init,		\
> >  		.get_wol = dp83822_get_wol,			\
> 
> The DP83822/25/26 are all 100 Mbit variants. They all officially claim
> EEE support. Maybe it is too early to give up here?

This is going to be horrid to guarantee getting the correct entry
in the patch - I *absolutely* hate this driver struct array. Please
provide a diff to be squashed into the patch.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

