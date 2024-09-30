Return-Path: <netdev+bounces-130438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49498A859
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3541C2111F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3541922F5;
	Mon, 30 Sep 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7fycc9d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603518FDDA;
	Mon, 30 Sep 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709713; cv=none; b=DI4uKj94FpLypSN/URMsx9gN1CfTmtT5eseeFHrjqrH5C5oOTK49R5IwI63FQCK9yMSYER1xI0+iCliorupnl6IRZXnRt3eUg4+EQsdEXffsr/BWR5D8sE3c4xan+iMqinCW3BmmAtwK02tZx/3Uw+JL8QA0BNVycc86Qaz9q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709713; c=relaxed/simple;
	bh=O6PAlEcBeLqb//qxewQqvAg+zzu5JiWub7QTSYxU0Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQauqAsV8rj+MKmdaKBmUraX5QQ1SHweRM0zkXRkkBdENiDeHrihUZD7ZMRGHyWiPX+cr6/ztenOJx3FcG40rDDh4NSR5Rjgr1a0ddV562hknN2s/MlJg9FP25uv2dm0vJphrLFA6dcCbrhBKr+1bCdxWBuxv+MtjQZ6OpqOZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7fycc9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F0EC4CEC7;
	Mon, 30 Sep 2024 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727709712;
	bh=O6PAlEcBeLqb//qxewQqvAg+zzu5JiWub7QTSYxU0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7fycc9ddJaYOyuQ6tc7BaA+msFGJTACJ67JrmDzLGN/dyQlstm2TSpB0wDJecNdd
	 6t7qNHmA2uAp5DId91GiCFK9Nv1Er6wU9+v5P/A5Ro7BCl4F04HyoahY94JMVENMnR
	 39sC23bWeiGlytpsOym1QEuIRumfp3QcXbbjPPK1rDmM2bMK9hDvgWjuMnKG9Qk/Xh
	 rTaggLSrH2WeLVK0/jEWypMl7BUSfsvJN2OV5cK0uoJccdcpxICVHIKdIYYZXkXIOA
	 wDOb4Bu1nUBZ3xnZGwDPxw4suGvYFQSzrKushbgGDljCu+kdKVWg5n5jrXJ1z8IIg+
	 aH+4TWQNyvwGQ==
Date: Mon, 30 Sep 2024 16:21:49 +0100
From: Simon Horman <horms@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: m.grzeschik@pengutronix.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: com20020-pci: Add check devm_kasprintf()
 returned value
Message-ID: <20240930152149.GC1310185@kernel.org>
References: <20240929023721.17338-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929023721.17338-1-hanchunchao@inspur.com>

On Sun, Sep 29, 2024 at 10:37:21AM +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this
> returned value in com20020pci_probe() is not checked.
> 
> Fixes: 8890624a4e8c ("arcnet: com20020-pci: add led trigger support")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Hi Charles,

As a fix for Networking code this looks like it should be targeted
at the 'net' tree. Please do that by using 'net' in the subject like this:

        Subject: [PATCH net v2] ...

Link: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  drivers/net/arcnet/com20020-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
> index c5e571ec94c9..6639ee11a7f8 100644
> --- a/drivers/net/arcnet/com20020-pci.c
> +++ b/drivers/net/arcnet/com20020-pci.c
> @@ -254,6 +254,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
>  			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  							"pci:green:tx:%d-%d",
>  							dev->dev_id, i);
> +			if (!card->tx_led.default_trigger || !card->tx_led.name)
> +				return -ENOMEM;

Looking at the rest of this function, I think the
correct unwind procedure is as follows (completely untested!):

			if (!card->tx_led.default_trigger ||
			    !card->tx_led.name) {
				ret = -ENOMEM;
				goto err_free_arcdev;
			}

>  
>  			card->tx_led.dev = &dev->dev;
>  			card->recon_led.brightness_set = led_recon_set;
> @@ -263,6 +265,9 @@ static int com20020pci_probe(struct pci_dev *pdev,
>  			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  							"pci:red:recon:%d-%d",
>  							dev->dev_id, i);
> +			if (!card->recon_led.default_trigger || !card->recon_led.name)

Please line-wrap the line above so that it is <= 80 columns wide,
as is still preferred by Networking code. Checkpatch will flag
this when used with the --max-line-length=80 command line option.

> +				return -ENOMEM;
> +
>  			card->recon_led.dev = &dev->dev;
>  
>  			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);

-- 
pw-bot: changes-requested

