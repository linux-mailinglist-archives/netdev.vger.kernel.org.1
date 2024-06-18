Return-Path: <netdev+bounces-104527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1990CF3E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AF21F21B64
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167515CD40;
	Tue, 18 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq7FLMPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD050297;
	Tue, 18 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714774; cv=none; b=oZYwIrAkLhFquqnjfLtyV171f0spf6558kz3aiQwO+WBiEYApY/mKC9kVni/EMl1XclMDnrUJjsYV5hg7TfdH844Lsw6P4bCvBk1t24Qjk1Lf7COVQa+qNM7WAF/3b1WZNwTVlJ29v8BJ7r7YB37ruRDjc+3o0gDlPaJeCNcj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714774; c=relaxed/simple;
	bh=QCngadtoE4VKjayI+GFG7V10hXE4SfjWwY3nE5aHu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlvdX0Jvumz/Ny8usK8cHMZVmLfJ9jye2+7vdlp3ueKYKbxr+b4FQkPqZnpmfrOyAhYsq7Wt4kitTsRoiu178ZJoIYza+/9q7Aq2vy9LI/FZv2OfF9skz8BREZs8O4tJDIbtbbN+LmT/UrLekCeKqJ4KlZ1PHJlWXDWjmnh4ZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq7FLMPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F01DC3277B;
	Tue, 18 Jun 2024 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714774;
	bh=QCngadtoE4VKjayI+GFG7V10hXE4SfjWwY3nE5aHu4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mq7FLMPAaB1kzN+wisXx1EZf36Er4LGukxc2CkD8W1xxQC5ek4DwHSDpizxs7zzv4
	 wiRnGjY2LW7ligSi51TsMwhtNuAaJXOVNdCPHqrhpRjoeh+rSNe1WW8rvGTZ3/7Op1
	 WHzInCEBRfZ05Y4MiPB+JVk+OyliKIWRIcdORGNdtut2Xual8kDiStUfi0ixHHs72/
	 Arn0IgRh1Aqj5JI77vR997T4H4XppmzEhXtd7qh8gcHxYBfvGxdiYTN0mwpgQ9Gze3
	 +rz/q0bpPGQAMNZc220CId8+o8l4Ks5/Ovso1BCrdsNSOR9zBOL3Gi5ZRhpPg2aan2
	 TifJ34hJv0qbg==
Date: Tue, 18 Jun 2024 13:46:10 +0100
From: Simon Horman <horms@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v10 17/38] net: cirrus: add DT support for Cirrus EP93xx
Message-ID: <20240618124610.GN8447@kernel.org>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <20240617-ep93xx-v10-17-662e640ed811@maquefel.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-ep93xx-v10-17-662e640ed811@maquefel.me>

On Mon, Jun 17, 2024 at 12:36:51PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - add OF ID match table
> - get phy_id from the device tree, as part of mdio
> - copy_addr is now always used, as there is no SoC/board that aren't
> - dropped platform header
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Hi Nikita,

Some minor feedback from my side.

...

> @@ -786,27 +766,47 @@ static void ep93xx_eth_remove(struct platform_device *pdev)
>  
>  static int ep93xx_eth_probe(struct platform_device *pdev)
>  {
> -	struct ep93xx_eth_data *data;
>  	struct net_device *dev;
>  	struct ep93xx_priv *ep;
>  	struct resource *mem;
> +	void __iomem *base_addr;
> +	struct device_node *np;
> +	u32 phy_id;
>  	int irq;
>  	int err;

nit: Please consider maintaining reverse xmas tree order - longest line
     to shortest - for local variable declarations. As preferred in
     Networking code.

     Edward Cree's tool can be of assistance here.
     https://github.com/ecree-solarflare/xmastree

>  
>  	if (pdev == NULL)
>  		return -ENODEV;
> -	data = dev_get_platdata(&pdev->dev);
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (!mem || irq < 0)
>  		return -ENXIO;
>  
> -	dev = ep93xx_dev_alloc(data);
> +	base_addr = ioremap(mem->start, resource_size(mem));
> +	if (!base_addr)
> +		return dev_err_probe(&pdev->dev, -EIO, "Failed to ioremap ethernet registers\n");

nit: Please consider line-wrapping to limiting lines to 80 columns wide
     where it can be trivially achieved, which seems to be the case here.
     80 columns is still preferred for Networking code.

     Flagged by checkpatch.pl --max-line-length=80

> +
> +	np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> +	if (!np)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Please provide \"phy-handle\"\n");
> +
> +	err = of_property_read_u32(np, "reg", &phy_id);
> +	of_node_put(np);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, -ENOENT, "Failed to locate \"phy_id\"\n");
> +
> +	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
>  	if (dev == NULL) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
> +
> +	eth_hw_addr_set(dev, base_addr + 0x50);

base_addr is an __iomem address. As such I don't think it is correct
to pass it (+ offset) to eth_hw_addr_set. Rather, I would expect base_addr
to be read using a suitable iomem accessor, f.e. readl. And one possible
solution would be to use readl to read the mac address into a buffer
which is passed to eth_hw_addr_set.

Flagged by Sparse.

> +	dev->ethtool_ops = &ep93xx_ethtool_ops;
> +	dev->netdev_ops = &ep93xx_netdev_ops;
> +	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
> +
>  	ep = netdev_priv(dev);
>  	ep->dev = dev;
>  	SET_NETDEV_DEV(dev, &pdev->dev);

...

