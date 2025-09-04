Return-Path: <netdev+bounces-219884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F48B43963
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389271C80281
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3985C2FAC05;
	Thu,  4 Sep 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hceoe2W9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BB29B233;
	Thu,  4 Sep 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983501; cv=none; b=lNnGwC4Dr6RnnU9rlyoZxeC2xKrOYgXyZigCgoNPm1+F3ImpKHP27S3Ld7FouwzzZuHxeUuG++gpNd/8Uy0ITwOg3gFuHVOmsZ9pLUZSUzLkKZqh7l6LWBfZ+MH3+Z1WpUK680Ms3SaqyL1Jcf+Ol6jG8EXs9nS6AKUa6NcikbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983501; c=relaxed/simple;
	bh=otwBCMWbzbMUnF3uxye8IWWKXIFYIahmm24+U7WrjCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJgQZyQN348RUmBlw56doQ+Au3ZA9wYV5jjiYGRbjzcU8bPdZXZTzGiWg23TTpHcuwJTkK/Mm1M+4VzaybwC14nGHFLodfJj/XDzrWNRHvShFen2R3FQzjNhVinqy5GU4cwgh/faoYvJarKC1q8a+4OFyYPIbCynPmDTA5Fk79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Hceoe2W9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0+dGMtdtbtPkJn14dHatEx4CiUjsN+rJYDHVha04vms=; b=Hceoe2W9SjDvm+/UrrvyknUWpK
	4OF4nbG9zdLI7FmDlGd4t+cGFfcNs4Cb8m8ZMZN5iNhs7TbMrSp1O+UEOs7eA8XtUpg2yyV58e8GO
	ty2qX1Aqn19LOsV34Jjou2Xa1/fCJIv199mdEXYheDlPIa3WJzmRRg+I80XTOf5K64kX0tXQqb1y2
	YcmwP26pbT0FzdCxUylGypZw8MXNbEi8scU3mmHiw1kQnlK+IRXmCjIyuiXgXQqrtI2gpe0xjLb0F
	yJx9lmSLgBdwv/wouAniGZcCnEH9x4OiFPa0ZYqUqtVeIq7C6w77gA3OX8EuCUmVUUCyiptzkgim6
	HL889VZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu7fN-000000001r8-1SFK;
	Thu, 04 Sep 2025 11:58:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu7fM-000000001S6-0098;
	Thu, 04 Sep 2025 11:58:08 +0100
Date: Thu, 4 Sep 2025 11:58:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
References: <20250904031222.40953-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904031222.40953-3-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
>  	if (plat->phy_node) {
>  		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>  		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> -		/* If it is not integrated_phy, clk_phy is optional */
> +		/*
> +		 * If it is not integrated_phy, clk_phy is optional. But we must
> +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
> +		 * the error code could be wrongly taken as an invalid pointer.
> +		 */

I'm concerned by this. This code is getting the first clock from the DT
description of the PHY. We don't know what type of PHY it is, or what
the DT description of that PHY might suggest that the first clock would
be.

However, we're geting it and setting it to 50MHz. What if the clock is
not what we think it is?

I'm not sure we should be delving in to some other device's DT
properties to then get resources that it _uses_ to then effectively
take control those resources.

I think we need way more detail on what's going on. Commit da114122b83
merely stated:

    For external phy, clk_phy should be optional, and some external phy
    need the clock input from clk_phy. This patch adds support for setting
    clk_phy for external phy.

If the external PHY requires a clock supplied to it, shouldn't the PHY
driver itself be getting that clock and setting it appropriately?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

