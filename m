Return-Path: <netdev+bounces-172618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E4A558AC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E673A780A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44D207DF3;
	Thu,  6 Mar 2025 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="guMhklL/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E620469E;
	Thu,  6 Mar 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296102; cv=none; b=DiEDcjvzhgFteC76fVzOorit8Po8lT2ZbeSt4rY0LoQQvVGBpWGNPFwptXkd8+or9m/yI/ahKB5ADNdr4d5m6S0D8hhsQS2l68zl2c2V5r59YRIYxy2p8+HEIhJfLB+W0T0VJMQ9XMOuQ88JpZ5R11O7KXvuuqB8DNOprRpEUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296102; c=relaxed/simple;
	bh=dG3d9aBGMx3DfnzuFFKM0PvgEVAcQQKTYUoYLJZ2bfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpxH2YtPeLbSPFeG7XI+1y0btE78hs2KV8g4qh5I+ENIpjoWxM7/OtEb/tbl54mPuz4a+k72Fd1iY+14xuTtGwy3KvtQNgF8v8M9TEsDv8BqO4ZQyoEusMYkdW2xpaEj/V9m9/EdM/yliq/xMdAxivPZ7+yhCS8jfU0QKbrXCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=guMhklL/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9H78NGtDgrJN8almAooGMPfIHicQD7QyEml+BfISIgg=; b=guMhklL/+BIxtizh+xS6aUCkcs
	xiqV6+jRMkvDCFI1Sdi2vxBbaC8HFPmkFSPNomuM1DaFuR9gXBO5W5pyVze8dw4T1rail/m4jEtUx
	Sl+bfrPyvulBDrN60FqU93ZP8sEOV2aYu0DUfALLj08VQcaukP31Ov9Z/eDXCzgNeMYfJ7JgOoYxm
	LPp2dr+vWeNh/k4dbT3BM/AH62dODYTy86qE4hCFZTafmDcEGEjAArTWjqtWhJCGRgRQU2TGorsuO
	lhbZjQJ6ndCqIFdVoMdRuVoKtIzDJrHoh05ZDgdAg/TKTa1NWtUgxeKTc/aq5QAwqsoVm3sVyDVdT
	vzH1AxrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqIeb-0006Vr-05;
	Thu, 06 Mar 2025 21:21:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqIeW-00078z-38;
	Thu, 06 Mar 2025 21:21:12 +0000
Date: Thu, 6 Mar 2025 21:21:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
Message-ID: <Z8oRyHThun9mLgx8@shell.armlinux.org.uk>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306210950.1686713-3-jonas@kwiboo.se>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 06, 2025 at 09:09:46PM +0000, Jonas Karlman wrote:
> @@ -1813,8 +1564,24 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
>  
>  	bsp_priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>  							"rockchip,grf");
> -	bsp_priv->php_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> -							    "rockchip,php-grf");
> +	if (IS_ERR(bsp_priv->grf)) {
> +		ret = PTR_ERR(bsp_priv->grf);
> +		dev_err_probe(dev, ret, "failed to lookup rockchip,grf\n");
> +		return ERR_PTR(ret);

Did you consider using ERR_CAST() for these, which would look like this:

		dev_err_probe(dev, PTR_ERR(bsp_priv->grf),
			      "failed to lookup rockchip,grf\n");
		return ERR_CAST(bsp_priv->grf);

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

