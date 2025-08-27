Return-Path: <netdev+bounces-217345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8780B38687
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BFE1BA774D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC07286D69;
	Wed, 27 Aug 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJD9ReNm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60F2798EA;
	Wed, 27 Aug 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308319; cv=none; b=BCvBEdSNiSyouJLOtvdf8V7UXgVZFkehvWtWE/G5uiDxh6M46//NCnDWJGpACVJ/xO8fl19OuWPUEmWdDtLNwkiQFRNVluSOIAAeoxvEoLE+Yin7pFnRhsKOjGvG3xCG/C3GCTgzOwrfOL6Z6zsCn64ATeC90kFuQWOzsX4twIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308319; c=relaxed/simple;
	bh=14L8M25SaW2aPUTqSHRR4gzXBnSAFwq0n1Xg8omLQ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvZds+2tTAIt43+mpH3yJQuasvI1eXsIe63qRFlz4TZpnv5e+s+EQI6BJXiPEy5NkyQZBzo+sKV5gZgjJfIN2cfsoU65uyx7uesCXKZzUfRhqbfXSlvYUbtOvytA9rWuXz9T1e6qLkZk77UogKEEmz4ZiYF7StFlgJFxrE9Z7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJD9ReNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE64C4CEF6;
	Wed, 27 Aug 2025 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756308318;
	bh=14L8M25SaW2aPUTqSHRR4gzXBnSAFwq0n1Xg8omLQ0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FJD9ReNmvkx/PjHuiCSIMgnDPw7AGDLXsNC+aNtZfFJOsJNOUGGLs3s+DHjWewFjn
	 MMVjmTgtzZNNIJZ3EOnprAq2nm6161YzsevTliap9sts5eCoUFn7fQdDBtOA+Sz2XT
	 kGBhfYVl7bXOD9jSttCOfNeBOLHe4mktsKiqfQ/onHaiL2owSYFSEhPlAUegNnmrfO
	 /4nJFIwZO9RaLHtz/wkZu6jP8D+0vaDyMWVtzGZ/Vk5JacR6jFaOzay9/MA1Lyfr49
	 YoAIzMVUTjj6eEv+e5bAMvgDa1Dsx+TH2nl0RuhMZI0Qi+7a4qurZSM4ja04MzW8MB
	 OY9ZhtdAjXS9w==
Date: Wed, 27 Aug 2025 08:25:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v19 5/7] net: mtip: Add mtip_switch_{rx|tx} functions
 to the L2 switch driver
Message-ID: <20250827082517.01a3bdfa@kernel.org>
In-Reply-To: <20250824220736.1760482-6-lukasz.majewski@mailbox.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-6-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 00:07:34 +0200 Lukasz Majewski wrote:
>  static void mtip_switch_tx(struct net_device *dev)
>  {
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;

> +		} else {
> +			dev->stats.tx_packets++;
> +		}
> +
> +		if (status & BD_ENET_TX_READY)
> +			dev_err(&fep->pdev->dev,
> +				"Enet xmit interrupt and TX_READY.\n");

per-pkt print, needs rl

> +		/* Free the sk buffer associated with this last transmit */
> +		dev_consume_skb_irq(skb);

why _irq()? this now runs from NAPI, so it's in BH. Just stick 
to dev_comsume_skb_any(), it's the safest choice..

