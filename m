Return-Path: <netdev+bounces-172650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00879A559EA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CF47A39C5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FFE27CB10;
	Thu,  6 Mar 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IRzhDcZx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108841F4185;
	Thu,  6 Mar 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300661; cv=none; b=e+LiWL2u5RWVFajswP/q9cfXRV0AmhgV+igSgaq4BoSWY4t8mkkblyO8nO8l8U8DA9RkTeVxvx7g0gsZYtx9hhAy1ARFvwkAsjf+ZG7ASCmurq8acOQ5bEZxUXNhX/SKR3EuXAk+dPbFLxLQOIW9Rsc/BLtdUaxPZ0qpQW171bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300661; c=relaxed/simple;
	bh=R8cvFyR/5j2NITIsRkLL8TuNA6KRr6QGmYRfv8pn+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLSznKhuQsQ+oCwEZvFTy4UOalpvLlVigfTPhutV14g4/zi6xcTVoWLcaDxxnSEbyF3Dn2K7Vq4MO2RHqPrxNZdD7QmJQ8h4W2aa2DRg8RL0Hzrllh3KGgDnuZcI9QFBdWnLpj9a+Ct5nlQLQG6b4772bYJmJQC5phSECVz0/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IRzhDcZx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dV4SgXTKPQRxhmfsW6BVI1ffsVoZlfX/2pdna3rupKY=; b=IRzhDcZxrjSQpHJrI0vOG307PI
	4Q3zFT2Lm7742/6V+Zy28VNBTQDyPbga72V/f058fDc2wie/b+PEhFuwl65zKZkyMo5cctlbL8LJY
	ehLYgxrxr1RmotX+87e2e13mIu3sITEu8+lf19srPgserUr4akQURsT8UKxhccoLO+lI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqJqJ-002wLx-Da; Thu, 06 Mar 2025 23:37:27 +0100
Date: Thu, 6 Mar 2025 23:37:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
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

On Thu, Mar 06, 2025 at 09:09:46PM +0000, Jonas Karlman wrote:
> All Rockchip GMAC variants require writing to GRF to configure e.g.
> interface mode and MAC rx/tx delay. The GRF syscon regmap is located
> with help of a rockchip,grf and rockchip,php-grf phandle.

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
> +	}
> +
> +	bsp_priv->php_grf =
> +		syscon_regmap_lookup_by_phandle_optional(dev->of_node,
> +							 "rockchip,php-grf");
> +	if ((of_device_is_compatible(dev->of_node, "rockchip,rk3588-gmac") ||
> +	     of_device_is_compatible(dev->of_node, "rockchip,rk3576-gmac")) &&
> +	    !bsp_priv->php_grf)
> +		bsp_priv->php_grf = ERR_PTR(-ENODEV);

It seems odd you say all variants need this property, and then you
look for two specific variants here and do something different? Why
are these two special?

	Andrew

