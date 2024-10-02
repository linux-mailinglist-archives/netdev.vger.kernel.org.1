Return-Path: <netdev+bounces-131132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D398CDC2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB51F22858
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7171714DF;
	Wed,  2 Oct 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Aa9vbx2p"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA025771;
	Wed,  2 Oct 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854191; cv=none; b=KlP8VNu43ixxUE3U6SVjiR4GXDoeOHgzqJMXm2JwvgfiIkenW+1ekWI2g9RzykdH5ZFyxRP9uZCkesfwhehgfnXwuEM27yvR/BLDUJcqhlBB/3u5QYT2hXIxANzTeoxOPRGEviGPld8Ph8F6U1tmAF4ukOl+Eo7p4tO5BDLUxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854191; c=relaxed/simple;
	bh=zE7hkTcDKkEtiZsWVXy3gpOuc28jPukMpk3tf7nK2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY6cBsla7BPGMzhfOkx4s2MeKAmjThWsvLrtX9Q3WraUk6Uohknk7O3pL5anMH9AkAcl8r7oi/2GfmE8w77el5iyeqOQaw4pHTlIBO/I5Uo6s4K8FfalQCvHFCs4MZe19cXLeRkOoYmm3Y2sMxxu4xK+lNh7+AzKZeC5jOkfKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Aa9vbx2p; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DFD6E0007;
	Wed,  2 Oct 2024 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727854188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aliU+UL3zdATjQzRpoMCmgsHtgjCZoiB4hHT68ATL6Y=;
	b=Aa9vbx2p1CJZt5ftveLx/TmBWTqQUeBZvSSMiLAYjDz4Kgk4vZdZD7sxHQsBMF7f5/wJtk
	xC3zZgUsCvcywcBkOLqs2QPX6QeM8JRSxiwtbnSEfwBU40gH2EANlnkYjh5xYH0c9h8jiW
	qnCxtn7rNx5msBST7OmKkHSBDgWvEVkwTtfyM87RfYbJ+BKs5U2buaTgmaRgACup8Lu5ly
	QomHIwOU1S80Gyw0bvdmm1YXHhj9kef4k/EHGYozIYZMmlgp32rLdJqTpH2fiZBl9CaYD5
	aCjFjCXs3qF0AIwwXVezTob11OgESXGlGt5LYis4u9/6o0PuznhjwDkTJ7osGw==
Date: Wed, 2 Oct 2024 09:29:46 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 4/6] net: gianfar: use devm for register_netdev
Message-ID: <20241002092946.63236b11@fedora.home>
In-Reply-To: <20241001212204.308758-5-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-5-rosenp@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Tue,  1 Oct 2024 14:22:02 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Avoids manual unregister netdev.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 66818d63cced..07936dccc389 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -3272,7 +3272,7 @@ static int gfar_probe(struct platform_device *ofdev)
>  	/* Carrier starts down, phylib will bring it up */
>  	netif_carrier_off(dev);
>  
> -	err = register_netdev(dev);
> +	err = devm_register_netdev(&ofdev->dev, dev);

I wonder if this is not a good opportunity to also move the
registration at the end of this function. Here, the netdev is
registered but some configuration is still being done afterwards, such
as WoL init and internal filter configuration.

There's the ever so slightly chance that traffic can start flowing
before these filters are configured, which could lead to unexpected
side effects. We usually register the netdev as a very last step, once
all initial configuration is done and the device is ready to be used.

As you're doing some cleanup on the registration code itself, it seems
like a good opportunity to change that.

Thanks,

Maxime



