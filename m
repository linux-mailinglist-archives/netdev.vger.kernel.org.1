Return-Path: <netdev+bounces-197796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5EAD9E80
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17F1170E90
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674371C6FF3;
	Sat, 14 Jun 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEK2F54o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D334CDD;
	Sat, 14 Jun 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749922312; cv=none; b=CjamVokgpvgUy5Dv1H9Yt15vOPm0P+u/g8OaxatoFaPuMVzlTqSssbVCJODL63MYvlSllvBf9W3wIBnnD98umw/ljGTH9NYsqrqnzZPprjf4oifPFCyIvCmX0GxAHm3pPITwP48iuzQQqoPwvJTl3KsfT4M4ObMimChPt7IPoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749922312; c=relaxed/simple;
	bh=P+BrB0OUaNa56UdWZa5rw+h39uQANByq8vbDPUy1nj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC77aQSdOnGVeO+HSgl79iY8Y2BmHBfjrpNZhniDRFCFwtVRZ4e5p9LZHSyax4LtmDIG32sHL+tDnJDeagNMaCX2y41YBpy6mDcshLzu28ME4SfjrElLmQ15ZyjxQE1lRAVBHi90QJlkgKaLL9EK4qTthCk1hQEPRjmQsv1aj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEK2F54o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57780C4CEEB;
	Sat, 14 Jun 2025 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749922311;
	bh=P+BrB0OUaNa56UdWZa5rw+h39uQANByq8vbDPUy1nj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEK2F54o22UzFG65tTbJ0eJGLwzvYnr6MZ41HqaI59pUgP2Zly4XuWFz69wDN8ulW
	 iKgkQs6AaOiwhD7ccKHcvA00mJNvfXunBjN3bqDjTLxiPUjaYgTTflO9iDVVlJPbsX
	 TjwJiRD7yjb5o/JIE94Rl6fdJkh2kgbjPsab8NyZX+qq3erJAulFWnyzf9WCSwcg3t
	 UU7buH17UGkxBTsAcPyLq5H0kHVyqrifUHUYfCCW48Shq1BI1us0m4dpFYMRRZbAJO
	 QcU9Hov5TXQq/rly29O/IfUeXEp+Ztik2FbHxoLOtkDqNHhTxJ/c0ewPG5KR6tHm0Y
	 mAQgU5wjymq8w==
Date: Sat, 14 Jun 2025 18:31:48 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org
Subject: Re: [net-next v1] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <20250614173148.GV414686@horms.kernel.org>
References: <20250613144525.53305-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613144525.53305-1-linux@fw-web.de>

On Fri, Jun 13, 2025 at 04:45:23PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add named interrupts and keep index based fallback for exiting devicetrees.
> 
> Currently only rx and tx IRQs are defined to be used with mt7988, but
> later extended with RSS/LRO support.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 24 +++++++++++++--------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index b76d35069887..fcec5f95685e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5106,17 +5106,23 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	for (i = 0; i < 3; i++) {
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] = eth->irq[0];
> -		else
> -			eth->irq[i] = platform_get_irq(pdev, i);
> -		if (eth->irq[i] < 0) {
> -			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> -			err = -ENXIO;
> -			goto err_wed_exit;
> +	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
> +	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
> +	if (eth->irq[1] < 0 || eth->irq[2] < 0) {
> +		for (i = 0; i < 3; i++) {
> +			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> +				eth->irq[i] = eth->irq[0];
> +			else
> +				eth->irq[i] = platform_get_irq(pdev, i);
> +
> +			if (eth->irq[i] < 0) {
> +				dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> +				err = -ENXIO;
> +				goto err_wed_exit;
> +			}
>  		}
>  	}
> +

Thanks Frank,

The above looks correct to me. But I do think it could be improved by moving
the irq lookup logic - either the unnamed portion or all of it - into a
helper.

That suggestion notwithstanding,
Reviewed-by: Simon Horman <horms@kernel.org>

>  	for (i = 0; i < ARRAY_SIZE(eth->clks); i++) {
>  		eth->clks[i] = devm_clk_get(eth->dev,
>  					    mtk_clks_source_name[i]);
> -- 
> 2.43.0
> 
> 

