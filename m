Return-Path: <netdev+bounces-130930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471F98C1B5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0902866B7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F451C8FD5;
	Tue,  1 Oct 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRnAGpol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08133D5;
	Tue,  1 Oct 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796807; cv=none; b=b0mEFbcd482reHWkJiCuMEWIqkTjeGRrQtPbf558rxDdwsDl8CJMgqsjKCeqgHeAfQ1CmzezW8xnqqXlZ4Y0CTjzQc8kaM/dkrJUu7vvLFixVKniCUIQk+vnsL+q2k/Q1UBk+JQPMpDuMPUhfJayVO0wS6nK/+rpHh9nEvx1ZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796807; c=relaxed/simple;
	bh=nLTKBPE3egM3cM2GmtfMGdSmv1giffXTVqpl54+94A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0CEu1kAO85ckbz0n0X2Pj5U0iYD2kGrDfbBFyn7raas/tfCGG9gFRIMK6wTzeFuW6zxTjJq8dzsj4H+rdkLm3CD4rFDG7zXP444XolKpVLqKEJPXkL3Erjs58/a6/YG3dzLHTbuv5C7UR7icIjm1lPJ4L1lj4MqUOrpb203O14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRnAGpol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC1C4CEC6;
	Tue,  1 Oct 2024 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727796807;
	bh=nLTKBPE3egM3cM2GmtfMGdSmv1giffXTVqpl54+94A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRnAGpolzfvixC5vb1/oandiuEE3W+/HJQB9akBW2x0bf0b5L9Z6TU9qjHRRhicap
	 rZKAHYvM4TDo4b9FwB9pVZGC852fOlqFGR0BhHEskGM/qeZySYBReq0d99hPCdfhdK
	 ixJobsBwUPrWztiEe/nNh+26lqlVsd0rOIxMKSKvw9NX6SW0y2f0oXzho03+Q7Yb2l
	 d05wIE4zHkTG59c+7qzM8/oczyQxKa3gcvp2mSOiaZ1V1jV4G3YOsfSazRn/0VCNs5
	 asPkIdeIFJt1yRCcpEyqgeVAp3I0DpufbtqmbKdvOnvkDiJyyG0/qHqKNyXLGEvyow
	 BOg8IlfD24MtA==
Date: Tue, 1 Oct 2024 16:33:23 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, olek2@wp.pl, shannon.nelson@amd.com
Subject: Re: [PATCH net-next 7/9] net: lantiq_etop: remove struct resource
Message-ID: <20241001153323.GT1310185@kernel.org>
References: <20240930202434.296960-1-rosenp@gmail.com>
 <20240930202434.296960-8-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202434.296960-8-rosenp@gmail.com>

On Mon, Sep 30, 2024 at 01:24:32PM -0700, Rosen Penev wrote:
> All of this can be simplified with devm_platformn_ioremap_resource. No
> need for extra code.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/lantiq_etop.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index bc97b189785e..0cb5d536f351 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -90,7 +90,6 @@ struct ltq_etop_priv {
>  	struct net_device *netdev;
>  	struct platform_device *pdev;
>  	struct ltq_eth_data *pldata;
> -	struct resource *res;
>  
>  	struct mii_bus *mii_bus;
>  
> @@ -620,28 +619,13 @@ ltq_etop_probe(struct platform_device *pdev)
>  {
>  	struct net_device *dev;
>  	struct ltq_etop_priv *priv;
> -	struct resource *res;
>  	int err;
>  	int i;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to get etop resource");
> -		return -ENOENT;
> -	}
> -
> -	res = devm_request_mem_region(&pdev->dev, res->start,
> -				      resource_size(res), dev_name(&pdev->dev));
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to request etop resource");
> -		return -EBUSY;
> -	}
> -
> -	ltq_etop_membase = devm_ioremap(&pdev->dev, res->start,
> -					resource_size(res));
> -	if (!ltq_etop_membase) {
> +	ltq_etop_membase = devm_platformn_ioremap_resource(pdev, 0);

Hi Rosen,

I believe this should be devm_platform_ioremap_resource()

> +	if (IS_ERR(ltq_etop_membase)) {
>  		dev_err(&pdev->dev, "failed to remap etop engine %d", pdev->id);
> -		return -ENOMEM;
> +		return PTR_ERR(ltq_etop_membase);
>  	}
>  
>  	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
> @@ -651,7 +635,6 @@ ltq_etop_probe(struct platform_device *pdev)
>  	dev->netdev_ops = &ltq_eth_netdev_ops;
>  	dev->ethtool_ops = &ltq_etop_ethtool_ops;
>  	priv = netdev_priv(dev);
> -	priv->res = res;
>  	priv->pdev = pdev;
>  	priv->pldata = dev_get_platdata(&pdev->dev);
>  	priv->netdev = dev;

-- 
pw-bot: changes-requested

