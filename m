Return-Path: <netdev+bounces-208295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162DCB0AD2C
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3551C45B76
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E457260A;
	Sat, 19 Jul 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHkrsRYm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42EBA45;
	Sat, 19 Jul 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887430; cv=none; b=ZKdD8Ifyvskw57nFIqVz/l8oK3FD6XIMyUveA+rKDws6uO8RGx0upgs1VRqtwZQU0Ud/6amD0ggWHDIO7YwPFUKeQScq5EdTqK19/bWuuQcezmBP0fsCwp+E4LZFZBjLUyAtOmzV/lFj4fkAwsIFIHCUWxaZRXcyarGvK+4yu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887430; c=relaxed/simple;
	bh=YgyJXRQCWe/ppuZUdi3oQsWjYtd7cJWOV5GRrEP4tkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRXQTF7j0WRCyOBk3gn3OxHG4yB7A7rSPA6Spmn421YP5J3SDvuGbxYvQdkbzsou+5eeidOjO88u5c9BJ9yxCEFKh+Us8sf595SLS7m/W0+zFzmw5bnS9SWj/MMj/zP/ZNfy73uVEF651NoSYcVmII0A1val1KUCssghPKlSkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHkrsRYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BD6C4CEEB;
	Sat, 19 Jul 2025 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752887429;
	bh=YgyJXRQCWe/ppuZUdi3oQsWjYtd7cJWOV5GRrEP4tkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eHkrsRYmWJgNnpXYK7n+ARDjeG5/Oj3FXrAhg2YDW/cArhshfmCNBm5T5r1IQYFyI
	 iPwXwaBObc7NTS10OOhd9c2hU8+G4ZNcaylejIHyD747TrCEyXXCK9RQR8tK402OUV
	 TYtEPK/ATn96lvDKTQtRVP1Ano8u08sHx3ykE3uniBh4tpcWDLFJ4r2CN8k4OFmgZ8
	 7RYXEGHp7PAojyPGXWjZEf4NdHBAHsQUCHeKTE+u7EsMISs3NxTyqQfujYlE7NyDJL
	 ADQ5uqMIwjCjNHLE2tYw5czj82xsF6jaRGFuAW5PnGaU3t73ZFVx5VfegVnu6mPYPy
	 PmDIJTUdImfAA==
Date: Fri, 18 Jul 2025 18:10:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v15 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250718181028.00cda754@kernel.org>
In-Reply-To: <20250716214731.3384273-5-lukma@denx.de>
References: <20250716214731.3384273-1-lukma@denx.de>
	<20250716214731.3384273-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 23:47:23 +0200 Lukasz Majewski wrote:
> +static void mtip_ndev_cleanup(struct switch_enet_private *fep)
> +{
> +	struct mtip_ndev_priv *priv;
> +	int i;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		if (fep->ndev[i]) {

this just checks if netdev is NULL

> +			priv = netdev_priv(fep->ndev[i]);
> +			cancel_work_sync(&priv->tx_timeout_work);
> +
> +			unregister_netdev(fep->ndev[i]);

and if not unregisters

> +			free_netdev(fep->ndev[i]);
> +		}
> +	}
> +}
> +
> +static int mtip_ndev_init(struct switch_enet_private *fep,
> +			  struct platform_device *pdev)
> +{
> +	struct mtip_ndev_priv *priv;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		fep->ndev[i] = alloc_netdev(sizeof(struct mtip_ndev_priv),

but we assign the pointer immediatelly

> +					    fep->ndev_name[i], NET_NAME_USER,
> +					    ether_setup);
> +		if (!fep->ndev[i]) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		fep->ndev[i]->ethtool_ops = &mtip_ethtool_ops;
> +		fep->ndev[i]->netdev_ops = &mtip_netdev_ops;
> +		SET_NETDEV_DEV(fep->ndev[i], &pdev->dev);
> +
> +		priv = netdev_priv(fep->ndev[i]);
> +		priv->dev = fep->ndev[i];
> +		priv->fep = fep;
> +		priv->portnum = i + 1;
> +		fep->ndev[i]->irq = fep->irq;
> +
> +		mtip_setup_mac(fep->ndev[i]);
> +
> +		ret = register_netdev(fep->ndev[i]);

and don't clear it when register fails

> +		if (ret) {
> +			dev_err(&fep->ndev[i]->dev,
> +				"%s: ndev %s register err: %d\n", __func__,
> +				fep->ndev[i]->name, ret);
> +			break;
> +		}
> +
> +		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
> +			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
> +	}
> +
> +	if (ret)
> +		mtip_ndev_cleanup(fep);

You're probably better off handling the unwind on error separately from
the full cleanup function, but I guess that's subjective.

> +	return ret;
> +}

> +static int mtip_sw_probe(struct platform_device *pdev)
> +{

> +	ret = mtip_ndev_init(fep, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Failed to create virtual ndev (%d)\n",
> +			__func__, ret);
> +		goto ndev_init_err;
> +	}
> +
> +	ret = mtip_switch_dma_init(fep);

> +	ret = mtip_mii_init(fep, pdev);

Seems like we're registering the netdevs before fully initializing 
the HW? Is it safe if user (or worse, some other kernel subsystem) 
tries to open the netdevs before the driver finished the init?
 

> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Cannot init phy bus (%d)!\n", __func__,
> +			ret);
> +		goto mii_init_err;
> +	}
> +	/* setup timer for learning aging function */
> +	timer_setup(&fep->timer_mgnt, mtip_mgnt_timer, 0);
> +	mod_timer(&fep->timer_mgnt,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
> +
> +	return 0;
> +
> + mii_init_err:
> + dma_init_err:
> +	mtip_ndev_cleanup(fep);

Please name the labels after the action they jump to, not the location
where they jump from.

> + ndev_init_err:
> +
> +	return ret;
-- 
pw-bot: cr

