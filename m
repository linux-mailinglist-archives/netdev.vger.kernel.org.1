Return-Path: <netdev+bounces-145240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B359CDE27
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B01B2104D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81B1B5EDC;
	Fri, 15 Nov 2024 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgp2erme"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D647D3F4;
	Fri, 15 Nov 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673160; cv=none; b=cvowa4Lo9/Z2KaqyDHwqQrq8VpGNXx7dQ1y3e5TFC9TCyeDlUM+1dh7y4F0/g3YisQLXxS7aLr3T7HTf9yovyIh1LlUjb344I9VsbIQ8KYnqKwGguT5tUD3M3QOGDf9ExG878FRytD1FYr30F1LXRKp/dnU2kDrlxnMVn6p8Ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673160; c=relaxed/simple;
	bh=xYQ9TNp9p5kYBx3sWMGmhMUu5MqStfTQnH3N5bBDZJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ177MoeI3ROUYB0NATMj2oWtR/M+XRHFfyfFeM/v1LbcG8am0LNQOe27MuvoRQjIiS0JJUpgiQ/gDwAptLi4QIYuIMLzRH+8oomJqdRoCcjwJHTit/KPeodSk0lvNVFNUorbDtJANxIYERn9/vWfCAiGu4DxxhHSuSN/wLCBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgp2erme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D463EC4CECF;
	Fri, 15 Nov 2024 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731673159;
	bh=xYQ9TNp9p5kYBx3sWMGmhMUu5MqStfTQnH3N5bBDZJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hgp2ermerQoEtA7rDHw8fmjZvMztpbM6wzYhbqM2dYdaYgpB3s7A2zNC5RUoQUExz
	 EWON/IPsj0QzBO0ybOKrRxgw7bgnE5FrwLJ969oQFLtmAiCWTyxblXbsnBgnXBEwDD
	 KV2XdzQ0Mjfo0DisVOxFYLAVidMOxlVPpJX9P/ruVUaefgrxnm9bWc9WVUSZEPWOzW
	 tFZQbG9M083rPlm8lnCUzkoa7tXVuqzvA3MyGheGxFQMxbtpGKjBniaL659U2akiQC
	 kxwl+CVy45uP7aIZUqT+wynK25ye9nFWmWqai+3yguXZzNZf9g9PGuYzBMzCkWnYwK
	 OAyU/ogCBDf7w==
Date: Fri, 15 Nov 2024 12:19:14 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 01/10] net: freescale: ucc_geth: Drop support
 for the "interface" DT property
Message-ID: <20241115121914.GL1062410@kernel.org>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
 <20241114153603.307872-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114153603.307872-2-maxime.chevallier@bootlin.com>

On Thu, Nov 14, 2024 at 04:35:52PM +0100, Maxime Chevallier wrote:
> In april 2007, ucc_geth was converted to phylib with :
> 
> commit 728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib").
> 
> In that commit, the device-tree property "interface", that could be used to
> retrieve the PHY interface mode was deprecated.
> 
> DTS files that still used that property were converted along the way, in
> the following commit, also dating from april 2007 :
> 
> commit 0fd8c47cccb1 ("[POWERPC] Replace undocumented interface properties in dts files")
> 
> 17 years later, there's no users of that property left and I hope it's
> safe to say we can remove support from that in the ucc_geth driver,
> making the probe() function a bit simpler.
> 
> Should there be any users that have a DT that was generated when 2.6.21 was
> cutting-edge, print an error message with hints on how to convert the
> devicetree if the 'interface' property is found.
> 
> With that property gone, we can greatly simplify the parsing of the
> phy-interface-mode from the devicetree by using of_get_phy_mode(),
> allowing the removal of the open-coded parsing in the driver.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V2: No changes
> 
>  drivers/net/ethernet/freescale/ucc_geth.c | 63 +++++------------------
>  1 file changed, 12 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c

...

> @@ -3627,18 +3588,17 @@ static int ucc_geth_probe(struct platform_device* ofdev)
>  	/* Find the TBI PHY node.  If it's not there, we don't support SGMII */
>  	ug_info->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
>  
> -	/* get the phy interface type, or default to MII */
> -	prop = of_get_property(np, "phy-connection-type", NULL);
> -	if (!prop) {
> -		/* handle interface property present in old trees */
> -		prop = of_get_property(ug_info->phy_node, "interface", NULL);
> -		if (prop != NULL) {
> -			phy_interface = enet_to_phy_interface[*prop];
> -			max_speed = enet_to_speed[*prop];
> -		} else
> -			phy_interface = PHY_INTERFACE_MODE_MII;
> -	} else {
> -		phy_interface = to_phy_interface((const char *)prop);
> +	prop = of_get_property(ug_info->phy_node, "interface", NULL);
> +	if (prop) {
> +		dev_err(&ofdev->dev,
> +			"Device-tree property 'interface' is no longer supported. Please use 'phy-connection-type' instead.");
> +		goto err_put_tbi;

Hi Maxime,

This goto will result in err being returned by this function.
But here err is 0. Should it be set to an error value instead?

Flagged by Smatch.

> +	}
> +
> +	err = of_get_phy_mode(np, &phy_interface);
> +	if (err) {
> +		dev_err(&ofdev->dev, "Invalid phy-connection-type");
> +		goto err_put_tbi;
>  	}
>  
>  	/* get speed, or derive from PHY interface */
> @@ -3746,6 +3706,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
>  err_deregister_fixed_link:
>  	if (of_phy_is_fixed_link(np))
>  		of_phy_deregister_fixed_link(np);
> +err_put_tbi:
>  	of_node_put(ug_info->tbi_node);
>  	of_node_put(ug_info->phy_node);
>  	return err;
> -- 
> 2.47.0
> 
> 

