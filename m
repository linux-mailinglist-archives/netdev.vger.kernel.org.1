Return-Path: <netdev+bounces-210224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4611B126CF
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D70163D80
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB424C07A;
	Fri, 25 Jul 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOLR8Ymm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2BEAF9;
	Fri, 25 Jul 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481911; cv=none; b=ABPBgO3W/rUPJ2eGe9KcjSHbMkNlfRrXruI5Gk2pa7i42w6KGO4u7xHQq8hfkVgyPUsW+Jp171ouqpwbe5wYbO/PBIpiEtNDi1bEZ8J8VfBRkZTgWLEF9rMkZTe5+qAfjdiC+nnD+hGGAjlsd8UUrqENjfT+S56uX+xwUynnkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481911; c=relaxed/simple;
	bh=CGiveRG0F4ZRe38E+iuFBLXGZzwDIfze3JyfGxabL28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfqLksAOyZ6u+dqzODSq+D5cLvKbYW+UxGJE0SOxu1njOASzEtoky1AaYwwGxoox2AAUfLxaW3PvAov5tQh7yix05ttt5itZy/+T4zPJV+qjGCyewv/nWu9KtFOIcKHIL/1ph7qjmSHY81ipt5EhcNllO20tNXXAakl2mD4sm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOLR8Ymm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE6DC4CEE7;
	Fri, 25 Jul 2025 22:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481911;
	bh=CGiveRG0F4ZRe38E+iuFBLXGZzwDIfze3JyfGxabL28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WOLR8Ymm6P4gOv/050K6B7gAqqQ522Hc4yVFoRh0Txi/+d6pnHEvinr6VyqQaqiEA
	 bxQnFJuEEnj7oYMsnEMoEErRuOv/lEKf4G8F8o4I8JgGJJe7tQJ7TPu30EPv5TtPmB
	 TgFF13w2d8O/ZVN2wSV1XMPdxfekwZwndLuw7WOmF8YUgK8WGy8nS8+2MoQ3miW9D5
	 h/j0GodhjKDmBrmN9c4cHX3EL7TIzRTUnEBkaEgjEbwvM9pyADb2unstM7FKhhIKCt
	 zPXGo3Ns7XsRtMSkFLuV5KImnLI+gKqqIo0FE0sRPdPOzyoddQDDDdZbcBO92/XWBj
	 9siEB3HNpDhtw==
Date: Fri, 25 Jul 2025 15:18:29 -0700
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
Subject: Re: [net-next v16 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250725151829.40bd5f4e@kernel.org>
In-Reply-To: <20250724223318.3068984-5-lukma@denx.de>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 00:33:10 +0200 Lukasz Majewski wrote:
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		fep->ndev[i] = alloc_netdev(sizeof(struct mtip_ndev_priv),
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
> +		if (ret) {
> +			dev_err(&fep->ndev[i]->dev,
> +				"%s: ndev %s register err: %d\n", __func__,
> +				fep->ndev[i]->name, ret);
> +			break;
> +		}

Error handling in case of register_netdev() still buggy, AFAICT.
-- 
pw-bot: cr

