Return-Path: <netdev+bounces-143737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0E9C3E7A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D9F1F223E9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BDE18A6C0;
	Mon, 11 Nov 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8am7y0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CB158DC8;
	Mon, 11 Nov 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328531; cv=none; b=laBiRZ2zKgUb1zA3KJtgvRAP7q91PDBGkhvtmkxiECykJWGduO0JgV30Ry3mwMSiT1+lpyeOG1vBtNmG3qBvmn1U/iNV329cOZzAaCQuVnoaIauVtX9wcdkFM1II4d9XAltqT5sPKd3nGR/eaQBX7U91t6BrLg9spd0dWKSBPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328531; c=relaxed/simple;
	bh=i9voRhb74pdjPwgxBkOD5HhlaonuoaF7PQGI1+Kem3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdmAAwJmWUenj56Tj8mJTOIe9NSvExG1hOIleKMRoNAlIPvZjAOonstjcSP+p8wM7tJi/z6nZFf4tO8NNd4jyaLORGPMCgFdMP847Z8QqtWupd4z2EQSge0oYxsWZbmzcE7y7sAXok1EpdpAWUJ7VkczLIsgRonnzJf8Z9qhUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8am7y0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57FCC4CECF;
	Mon, 11 Nov 2024 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731328531;
	bh=i9voRhb74pdjPwgxBkOD5HhlaonuoaF7PQGI1+Kem3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8am7y0qE7dn4HtcXfhvQGqq/xaiuoWcoU+7dpkL3TOeth35yEkccyHiyTEKa5KIJ
	 x6D5qQ7fSPBZ1U8XImp0RqHwKpT+XJO04Kekkin1/ie4yt8BLYSi4UsN3eFtzVUrId
	 Whz1uY8Yv+NzTAhaVDWZy6I8SZCWR5wUoG8r/1vahvrMvEgfBcVN84u/pGw/mlmhSe
	 JCCOJyf8LVxeHO1o8dBWKo36U1Q/JOGQ1BFk6UtmbpxCjzgYlhizY4CmlQ9AgATFC3
	 2wxdUGjOScaLxnIYrRC+zYcSWWfVt6oBDdSrTclDMs+beTrHYRXHO0JXJXc3T/UZM8
	 FzNdtVKibx61w==
Date: Mon, 11 Nov 2024 12:35:26 +0000
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	ratbert@faraday-tech.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 3/3] net: ftgmac100: Support for AST2700
Message-ID: <20241111123526.GC4507@kernel.org>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111500.4066517-4-jacky_chou@aspeedtech.com>

On Thu, Nov 07, 2024 at 07:15:00PM +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed, featuring three GPIO
> controllers that are support 64-bit DMA capability.
> Adding features is shown in the following list.
> 1.Support 64-bit DMA
>   Add the high address (63:32) registers for description address and the
>   description field for packet buffer with high address part.
>   These registers and fields in legacy Aspeed SoC are reserved.
>   This 64-bit DMA changing has verified on legacy Aspeed Soc, like
>   AST2600.
> 2.Set RMII pin strap in AST2700 compitable
>   Use bit 20 of MAC 0x50 to represent the pin strap of AST2700 RMII and
>   RGMII. Set to 1 is RMII pin, otherwise is RGMII.
>   This bis is also reserved in legacy Aspeed SoC.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

...

> @@ -1965,16 +1980,27 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  			dev_err(priv->dev, "MII probe failed!\n");
>  			goto err_ncsi_dev;
>  		}
> -
>  	}
>  
>  	if (priv->is_aspeed) {
> +		struct reset_control *rst;
> +
>  		err = ftgmac100_setup_clk(priv);
>  		if (err)
>  			goto err_phy_connect;
>  
> -		/* Disable ast2600 problematic HW arbitration */
> -		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
> +		rst = devm_reset_control_get_optional(priv->dev, NULL);
> +		if (IS_ERR(rst))

Hi Jacky,

Should err be set to ERR_PTR(rst) here so that value is returned by
the function?

> +			goto err_register_netdev;
> +
> +		priv->rst = rst;
> +		err = reset_control_assert(priv->rst);
> +		mdelay(10);
> +		err = reset_control_deassert(priv->rst);
> +
> +		/* Disable some aspeed platform problematic HW arbitration */
> +		if (of_device_is_compatible(np, "aspeed,ast2600-mac") ||
> +		    of_device_is_compatible(np, "aspeed,ast2700-mac"))
>  			iowrite32(FTGMAC100_TM_DEFAULT,
>  				  priv->base + FTGMAC100_OFFSET_TM);
>  	}

