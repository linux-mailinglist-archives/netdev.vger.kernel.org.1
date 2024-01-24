Return-Path: <netdev+bounces-65619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0DD83B25C
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C0F2838C1
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F2132C2F;
	Wed, 24 Jan 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxDS71Ds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B995131E39
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125061; cv=none; b=QaCQw68BkvVkwQb08CGKwIub/HFEUtT/1KxRQOW5YFLBc7+7LP+Ct9wULDudlp76xDnP2AgNf3QhrlQcQ5IqNElLOMo8hl1G9apIaKgu/zzTvYlp7+viJl/teGwPSrIGXbxQs9v78gQNuHJFiCikMZzHEYRNVEiUOmqElve18Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125061; c=relaxed/simple;
	bh=KEQcf4L+83wloAGkIQFHp2z/ggH7lFjkiHoyimp8/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLnYK0/TzLHsCy0vKBNbdVo3MJLyFmNfsadCL6sZAA7zocXL5WJhsJUBJZhWM6W7MLR7+7H4zLWplVzcMCuUmVbl+SEdybLxdfcXu/U2Wuqp67b7HTbqxyxnOUt7fj9u4Q+pPCIjJjD3Zpgl3nn16Ykrbsnyj5HLMrMGfcaVhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxDS71Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE0BC433F1;
	Wed, 24 Jan 2024 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706125060;
	bh=KEQcf4L+83wloAGkIQFHp2z/ggH7lFjkiHoyimp8/NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxDS71DsBXLnQHjOgR8akk4fVzgRgK513j3HMLsS76jaMhaUPrjk/4TMGm6pU9JgY
	 B4aSEEfMC3nC+YwHZvPSMi4vrWuOZ79zJZTjElyRGNF0vGGTY4iIRbJQVKCtTmmJ02
	 HGif5+a/dO1U5GRwrS+mZLMQ+IBW/6jzDsiDHs7xoRTXjqazq42njVylA+bZeZkRgD
	 S0szveItHFLbXyoC+IFhzyvPS/Qo/9nn3hn3voBP504lyxIVDc0vQS9lKux+2QeWwr
	 RdYsAvSqze6S0t8zqBy9cD64hi5DYhyvPITsY6azrS/OiTtDFcZisEz4MLn/P8DQSY
	 arTtBCH11IMwg==
Date: Wed, 24 Jan 2024 19:37:35 +0000
From: Simon Horman <horms@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH 03/11] net: dsa: realtek: convert variants into real
 drivers
Message-ID: <20240124193735.GA217708@kernel.org>
References: <20240123214420.25716-1-luizluca@gmail.com>
 <20240123214420.25716-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123214420.25716-4-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:44:11PM -0300, Luiz Angelo Daros de Luca wrote:

...

Hi Luiz,

some minor feedback from my side.

> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c

...

> @@ -140,7 +141,20 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
>  	.disable_locking = true,
>  };
>  
> -static int realtek_mdio_probe(struct mdio_device *mdiodev)
> +/**
> + * realtek_mdio_probe() - Probe a platform device for an MDIO-connected switch
> + * @pdev: platform_device to probe on.

nit: this should document @mdiodev rather than @pdev

There are similar problems elswhere in this patch,
and in patch 5/11 of this series.

'/scripts/kernel-doc -none' is useful for finding such problems.

> + *
> + * This function should be used as the .probe in an mdio_driver. It
> + * initializes realtek_priv and read data from the device-tree node. The switch
> + * is hard resetted if a method is provided. It checks the switch chip ID and,

nit: reset

...

> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c

...

> -static int realtek_smi_probe(struct platform_device *pdev)
> +/**
> + * realtek_smi_probe() - Probe a platform device for an SMI-connected switch
> + * @pdev: platform_device to probe on.
> + *
> + * This function should be used as the .probe in a platform_driver. It
> + * initializes realtek_priv and read data from the device-tree node. The switch
> + * is hard resetted if a method is provided. It checks the switch chip ID and,

nit: reset

> + * finally, a DSA switch is registered.
> + *
> + * Context: Any context. Takes and releases priv->map_lock.
> + * Return: Returns 0 on success, a negative error on failure.
> + *
> + */
> +int realtek_smi_probe(struct platform_device *pdev)
>  {
>  	const struct realtek_variant *var;
>  	struct device *dev = &pdev->dev;

...

