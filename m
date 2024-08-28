Return-Path: <netdev+bounces-122835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DAA962B45
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55580286E5B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCE1A2573;
	Wed, 28 Aug 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpuTNP4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1421A4B70;
	Wed, 28 Aug 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857653; cv=none; b=QocOCDpYqTWkUnNdQbUoLGZN3klWEsRIVyQBydDyTD436f6ECZU10Pi3SxnyQ6Vscf/MTQw82JgLCdmWQNgdEtEfBcEFO2DQrC08712hXh2j87oQwWr+4Ge2bhN3Tyjx8Tuv/hekFQIEKc29qWphvU9mtEg12PXhtHc3He2aBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857653; c=relaxed/simple;
	bh=DAsIpKGxKORGVuqid/qCfL7Vg/Pa11P5AKYZi+C4fx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCd/rs3zWrI13BYwPc7ky7/XUKBfw4iSWVk/A1f3dxr1MtxacicCiWFerOZRhhVKxaaUgASGET42H8Jnf1TWRxS+45juT85FWSiGrZzu2UL6frfDLNBkfGFAXg+cQKdO7cCdEPTzd0qOmdgQWKAYugGb1aVJoD6PDJaXUaYO3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpuTNP4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A391FC4CEC8;
	Wed, 28 Aug 2024 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724857652;
	bh=DAsIpKGxKORGVuqid/qCfL7Vg/Pa11P5AKYZi+C4fx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpuTNP4Ze6qCXLDuHXyPx4BCrogv/xzpYZjZXFAEhsX0F6PfSUaPfCvFNumI0Lydj
	 /ebsAXvG4wvWbg2kuL07PF/RfZnHZE/JhwruJKJebfb3rLDh5FTML4skv64F9x5bWE
	 aURYBML2v0B8cvo9JiDRDUxxWCLwoxN9kHNkGwxyOJVtNHV5ctS4NAii6kS4jh5Mo7
	 5rozwhNNCgWSHddzy4U7gl+Vg5Gtt6lrma3tRT3E76yyeXx63FWI70NmQa3vvh2Ft/
	 Os5kqb/KBTTzlwM8vvIlzCLQf5/s6OykY4JjS/xucjZRD1zXe1oTvPf9uKMHOf7ukR
	 1NuDuXoUmGbFA==
Date: Wed, 28 Aug 2024 16:07:28 +0100
From: Simon Horman <horms@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: m.grzeschik@pengutronix.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyanming@ieisystem.com
Subject: Re: [PATCH] arcnet: com20020-pci:Check devm_kasprintf() returned
 value
Message-ID: <20240828150728.GP1368797@kernel.org>
References: <20240828061941.8173-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828061941.8173-1-hanchunchao@inspur.com>

On Wed, Aug 28, 2024 at 02:19:41PM +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked.
> 
> Fix this lack and check the returned value.
> 
> Fixes: 8890624a4e8c ("arcnet: com20020-pci: add led trigger support")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

nit: I think there should be a space after each ':' in the subject.
     Also, IMHO, return value is a bit more natural.

Subject: [PATCH] arcnet: com20020-pci: Check devm_kasprintf() return value

> ---
>  drivers/net/arcnet/com20020-pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
> index c5e571ec94c9..ca393f9658e9 100644
> --- a/drivers/net/arcnet/com20020-pci.c
> +++ b/drivers/net/arcnet/com20020-pci.c
> @@ -254,6 +254,10 @@ static int com20020pci_probe(struct pci_dev *pdev,
>  			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  							"pci:green:tx:%d-%d",
>  							dev->dev_id, i);
> +			if (!card->tx_led.default_trigger || !card->tx_led.name) {
> +				ret = -ENOMEM;
> +				goto err_free_arcdev;
> +			}

I'd prefer if the error values were checked one by one.

			card->tx_led.default_trigger = ...
			if (!card->tx_led.default_trigger) {
				...
			}

			card->tx_led.name = ...
			if (!card->tx_led.default_trigger) {
				...
			}

>  
>  			card->tx_led.dev = &dev->dev;
>  			card->recon_led.brightness_set = led_recon_set;
> @@ -263,6 +267,11 @@ static int com20020pci_probe(struct pci_dev *pdev,
>  			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  							"pci:red:recon:%d-%d",
>  							dev->dev_id, i);
> +			if (!card->recon_led.default_trigger || !card->recon_led.name) {

Ditto.

> +				ret = -ENOMEM;
> +				goto err_free_arcdev;
> +			}
> +
>  			card->recon_led.dev = &dev->dev;
>  
>  			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);

