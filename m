Return-Path: <netdev+bounces-184608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186B8A965E1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A0C3AB12A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871C2116EB;
	Tue, 22 Apr 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hmibpaJQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A164F510;
	Tue, 22 Apr 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317590; cv=none; b=Gx/Qkl6LTOhrSDgeU5C4s+3PafEpEijRbnbvo9V1nlyiXq/B3NKEfJ/EVQVcZmX+KmIc60O4eGIWGvWXyW4Ttxg0kNMwB6UGzII1G3qgMh27EIfTowLgKFbDy8CDX3uODOBEK+Dj0gCKXcomyTL9Xu1mZhUcobZQexYbzv7TUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317590; c=relaxed/simple;
	bh=YqWYyAx8wFfLAqMZkhCl82gepw008Z3BzNjGaTOcJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s33pPmDnVdOQI7eKV4iNu1oMY7UjllG2OJQ6cYP7Iqo6xSe7n+gTSl3SktpHILQbHL2rWivPLoG3zhOcSAE/tA5r0efPiw58GhE5jDDTVJPDpKfm28UEhN7eKsrHbqD9gyxHhgrbPwf7/NPNHmlyJifjkugWH28ZFHgnOrtstgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hmibpaJQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CjTX9sSLA5APr26oD3oIvumjEEJaT08iYbGX+c3YqhQ=; b=hmibpaJQjafVjg/TfxQRzmQGmP
	VNbw2ltDqE/oXry3qBL68JLB9s7RUpgmQ+y6A6geZM6nULubvbmvUYIrEltC5wngYJ25K/z/3Ku9T
	XJn7ylB9dncRVw1lZjyTu2tq+MBLggbp7XoskY6PQGqczQkZgnyF5B39iDyF/HBbtmNmkjg/a58J+
	ihQdDdgJ4TkLSoSTwlQzr7amSpH7Ae3NuLj+vza1xxZh+O4XLRTixUsr8L/f1I1vZXRQLh5UGRlGf
	+fuNrkFCC8ZbuaHunIqY9YRL1pIvrxt96kMzooTAWiYwIzCLKpVFrlEkoXmUKULr3ZIo2fdy+hrK6
	7I9VULUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60956)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7Apc-0004Cl-1S;
	Tue, 22 Apr 2025 11:26:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7Apb-0007PM-0x;
	Tue, 22 Apr 2025 11:26:23 +0100
Date: Tue, 22 Apr 2025 11:26:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net 2/3] net: stmmac: socfpga: Don't check for phy to
 enable the SGMII adapter
Message-ID: <aAduzwMTLvaeyQkb@shell.armlinux.org.uk>
References: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
 <20250422094701.49798-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422094701.49798-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 11:46:56AM +0200, Maxime Chevallier wrote:
> The SGMII adapter needs to be enabled for both Cisco SGMII and 1000BaseX
> operations. It doesn't make sense to check for an attached phydev here,
> as we simply might not have any, in particular if we're using the
> 1000BaseX interface mode.
> 
> So, check only for the presence of a SGMII adapter to re-enable it after
> a link config.

I wonder whether:

	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dwmac->dev));

	if ((priv->plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
	     priv->plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) &&
	    sgmii_adapter_base)
 		writew(SGMII_ADAPTER_ENABLE,
 		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);

would describe the required functionality here better, making it clear
under which interface modes we expect to set the enable bits.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

