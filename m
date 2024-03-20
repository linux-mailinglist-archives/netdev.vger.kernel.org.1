Return-Path: <netdev+bounces-80792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE088115D
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B408B21F5B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574D3B19D;
	Wed, 20 Mar 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH871Gt8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21052628D
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935678; cv=none; b=E1hBpukoTx63kcS+RptwzB5pSNThFoIenqpiBpTl5ov+3lVroPeCx/dY3FDjQw3s3mA4IRp6/gLUxvDfF+KlrMNYObJStB9g3FbbX61OJneL9WTYfcZvj86HXte6U0yP32kitIQbiPR8aLIJhpoQg50eg0LwHYygFa1KZLNBmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935678; c=relaxed/simple;
	bh=ENg/EnELawJjM6QXBATTqI6UYj2sEaNTlXVLqVI/rUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n79RDTSrqEXy8f/iq7PNnAQI3NI4snbKutJnUZNE0CXVPW4wV44UhZ94HSXY+LQEdbzZoXZF21I7E0FT5/h4g5hUL7Q6leZi+ZyXHP25qi9aSyil/ObgDFJkIyvKtrn+XsIITSQnoQR+aw6mjPjCn7Vcj1vN/3UpngNHC83yUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH871Gt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9CAC433C7;
	Wed, 20 Mar 2024 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710935678;
	bh=ENg/EnELawJjM6QXBATTqI6UYj2sEaNTlXVLqVI/rUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SH871Gt8P6P/HWXlEBbuGDUdj4DXAjRLBwO6dhqh1PfvUH2UtamejGwTddLNAuVs2
	 X57UxvJvOAYFq06G8XRlmYYfafWwWiSNr8kjTyhy86htJnPqSENP1AE+fD/GXD5r5M
	 LtafNtO21uNZZZr4URRQKoypODztJPnrZtDW9XnWJa4Uicsv+cdMPZIjgVn0xgscQt
	 Iz8igp611OU4HA5TF/tMzu/zY6xFvr1QEtWYCxWMU+XEgihXaGdCRT2Vi6ZfuxRQBc
	 Ur6Co43vjGhLmdsF1WbX0BthkWVmjytsCeib7W57Qld1RKRbKP83CWmp2CQ4zUDGYA
	 0kESm4GmOjfYg==
Date: Wed, 20 Mar 2024 11:54:33 +0000
From: Simon Horman <horms@kernel.org>
To: Claus Hansen Ries <chr@terma.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, Alex Elder <elder@linaro.org>,
	Wei Fang <wei.fang@nxp.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>, Wang Hai <wanghai38@huawei.com>
Subject: Re: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
Message-ID: <20240320115433.GT185808@kernel.org>
References: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>

+ Eric Dumazet, Jakub Kicinski, Paolo Abeni, Michal Simek, Alex Elder
  Wei Fang, Uwe Kleine-König, Dan Carpenter, Rob Herring, Wang Hai

On Tue, Mar 19, 2024 at 07:45:26PM +0000, Claus Hansen Ries wrote:
> From: Claus Hansen ries <chr@terma.com>
> 
> devm_platform_ioremap_resource_byname is called using 0 as name, which eventually 
> ends up in platform_get_resource_byname, where it causes a null pointer in strcmp.
> 
>                 if (type == resource_type(r) && !strcmp(r->name, name))
> 
> The correct function is devm_platform_ioremap_resource.

Hi Claus,

It is curious that this wasn't noticed earlier - does the driver
function in some circumstances without this change?

> 
> Fixes: bd69058 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()")

nit: Fixes tags should use 12 or more characters for the hash.

Fixes: bd69058f50d5 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()")

> Signed-off-by: Claus H. Ries <chr@terma.com>
> Cc: stable@vger.kernel.org

Unfortunately the patch does not apply - it seems that tabs have been
replaced by spaces somewhere along the way. It would be best to repost
with that addressed. Using git send-email usually works.

Also, as this is a fix, please target it at the net tree.
That means it should be based on that tree (that part is fine :)
and designated as being for net in the subject.

	Subject: [PATCH net] ...

Lastly, please run get_maintainer.pl on your patch to provide the list
of parties to CC.

https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index 9df39cf8b097..1072e2210aed 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *pdev)
>         }
>           /* map device registers */
> -       lp->regs = devm_platform_ioremap_resource_byname(pdev, 0);
> +       lp->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(lp->regs)) {
>                 dev_err(&pdev->dev, "could not map TEMAC registers\n");
>                 return -ENOMEM;
> 
> base-commit: d95fcdf4961d27a3d17e5c7728367197adc89b8d
> --  2.39.3 (Apple Git-146)
> 
> 
> 

-- 
pw-bot: changes-requested

