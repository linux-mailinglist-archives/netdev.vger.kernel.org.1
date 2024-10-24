Return-Path: <netdev+bounces-138516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9B9ADF92
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5D92812FE
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1181B0F32;
	Thu, 24 Oct 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS+C2wpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8B5258;
	Thu, 24 Oct 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760272; cv=none; b=G/ZuNTowSt8W6ASl031b0KZ3hNB1fHDNnucGKXjvwsD4O+wSpgeEzkzlX8TdhHwHXI6wIVtZ9zo/c41aTaqN3FVky1LK/bFOOa1syS81pJ2bvlj43jXead9UemQ/mU2RpPGXmU9JSg/aDExIhw8IKxus5iK/SAUaIqcuXRWH0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760272; c=relaxed/simple;
	bh=PrBYLT5b8ZzjBgPxQ/nPHuRbxqOVIfhBqVL43LbjUxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCEXSsDbOE1bc9MHjWwJL2TanXDg7y2TQjPbf3icS6ycMtzuN8lWogYFKh9l/vp5KNhMKKOjrOZmij9M8TJMsQe0de+habLxg4EzpLzN3ocz/lkg4EVxL9NwYJnaDTkdSQJXPllspP442SUqIoVOI06J/9WXrj4QZFn9uLH1ZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rS+C2wpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72784C4CEC7;
	Thu, 24 Oct 2024 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729760272;
	bh=PrBYLT5b8ZzjBgPxQ/nPHuRbxqOVIfhBqVL43LbjUxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rS+C2wpP+Q8VK9rs/WonpelZURWxB5Y38IGmhrb8r4b8TH8DJFYq8ioV96eKVsvxr
	 fHOdspNaKvdHDmTKnkmwc3dy69AWjrSJ1Jzludgyfqou+wv6xw40/5QdhFaXzIrdBM
	 GKdVN/ZfzhkBt+fEV2MZm6DAifgT07T1PDY6hyEdEnICJVZDroS6epFWPb6CrkoJe/
	 DCVxbpmw4ZDw5LeYNAEyq95/WvkcE1GmA4mVxas54o7C47/WaZDdJx06S0O8oTP2nu
	 ZqDQgTu0a0QbpnbqRIoo3I5RKvn3Dzf0JgbT1+jgmg88DzsCRVJ0iU5+N4r+nnFgik
	 9jHJKWA2AWwTg==
Date: Thu, 24 Oct 2024 09:57:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [net-next v3] net: ftgmac100: refactor getting phy device handle
Message-ID: <20241024085748.GH402847@kernel.org>
References: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>

+ Russell

On Tue, Oct 22, 2024 at 04:42:14PM +0800, Jacky Chou wrote:
> Consolidate the handling of dedicated PHY and fixed-link phy by taking
> advantage of logic in of_phy_get_and_connect() which handles both of
> these cases, rather than open coding the same logic in ftgmac100_probe().
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> v2:
>   - enable mac asym pause support for fixed-link PHY
>   - remove fixes information
> v3:
>   - Adjust the commit message

Thanks for the updates.

Probably this should also be reviewed by Andrew or Russell (CCed).
But it looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 28 +++++-------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 10c1a2f11000..17ec35e75a65 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1918,35 +1918,17 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "Connecting PHY failed\n");
>  			goto err_phy_connect;
>  		}
> -	} else if (np && of_phy_is_fixed_link(np)) {
> -		struct phy_device *phy;
> -
> -		err = of_phy_register_fixed_link(np);
> -		if (err) {
> -			dev_err(&pdev->dev, "Failed to register fixed PHY\n");
> -			goto err_phy_connect;
> -		}
> -
> -		phy = of_phy_get_and_connect(priv->netdev, np,
> -					     &ftgmac100_adjust_link);
> -		if (!phy) {
> -			dev_err(&pdev->dev, "Failed to connect to fixed PHY\n");
> -			of_phy_deregister_fixed_link(np);
> -			err = -EINVAL;
> -			goto err_phy_connect;
> -		}
> -
> -		/* Display what we found */
> -		phy_attached_info(phy);
> -	} else if (np && of_get_property(np, "phy-handle", NULL)) {
> +	} else if (np && (of_phy_is_fixed_link(np) ||
> +			  of_get_property(np, "phy-handle", NULL))) {
>  		struct phy_device *phy;
>  
>  		/* Support "mdio"/"phy" child nodes for ast2400/2500 with
>  		 * an embedded MDIO controller. Automatically scan the DTS for
>  		 * available PHYs and register them.
>  		 */
> -		if (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
> -		    of_device_is_compatible(np, "aspeed,ast2500-mac")) {
> +		if (of_get_property(np, "phy-handle", NULL) &&
> +		    (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
> +		     of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
>  			err = ftgmac100_setup_mdio(netdev);
>  			if (err)
>  				goto err_setup_mdio;
> -- 
> 2.25.1
> 
> 

