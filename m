Return-Path: <netdev+bounces-118848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C805952FEB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0E1C24B62
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C11A08DD;
	Thu, 15 Aug 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2J1mX0Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDC17C9B1;
	Thu, 15 Aug 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729033; cv=none; b=jDS2NwXA5oLJA0TCUQTevx9bTW7dyy2mnOzx0otqem/VDlLvty20AaYwKfvDQ4HhSk7rJisRRONmfIbVsPWJu84c0bP0x20VwZXDvlEAOVzViJQQh59KRh5ioM5Z7jV/Qc2mEBbQrGURQWAgqNM9dwLbMdNrxK5gvwvC3NBVigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729033; c=relaxed/simple;
	bh=ivC/ql9DARdAAo0IB7lg/JhsrAxajGb+vtXbPgNHmas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJh9oiNmf44m4pyys+U8WZAsqNirT+ks2ien9HHBCdwy4k+PHO8+xsI8WQq5wCLcfCVoYfAsBkXKYaocLEcB7IV9S9Ju4CSSIztBqRrM1O1Y2q5ggwmJwyKvPeFrwSHCKjIg3ysGpNjI0drQSLeVj7wCLiSDnxoq531QyLG/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2J1mX0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11039C32786;
	Thu, 15 Aug 2024 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723729033;
	bh=ivC/ql9DARdAAo0IB7lg/JhsrAxajGb+vtXbPgNHmas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2J1mX0QqPihWT1BGfkat5NUtQaSKe/MEFK7z1BE0Upu2oEvvgpbu6A/ap+tK+TlM
	 WehdY6KkqcJjmrtAU4y0qxlF5KJsxAdDEf3nMz1enH1XaK1qNcGPIZsoWk08R+DVb/
	 DrSm+uCmfD8rbeFmny+a7VSO39mP+t3UZMLTOi9p//9ApCPoXtlgeUXbwnCv4HO1na
	 0aWhm0Za20AWmTeY+mcO0WTL3AmTlxKaX/GJIYqPl8tMktE2A95IIicauKjKTDhDd5
	 vgiSuhZ7OLw/sGGG6n+W+egniW0nfLKD7y6aYXjW0IDdDhkY9YstJ7VaMp6egWnjkX
	 dMjJcvziwy0XQ==
Date: Thu, 15 Aug 2024 14:37:07 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,reverse-mode"
Message-ID: <20240815133707.GC632411@kernel.org>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815055126.137437-3-wei.fang@nxp.com>

On Thu, Aug 15, 2024 at 01:51:25PM +0800, Wei Fang wrote:
> As the new property "nxp,reverse-mode" is added to instead of the
> "nxp,rmii-refclk-in" property, so replace the "nxp,rmii-refclk-in"
> property used in the driver with the "nxp,reverse-mode" property
> and make slight modifications.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/phy/nxp-tja11xx.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
> index 2c263ae44b4f..a3721f91689b 100644
> --- a/drivers/net/phy/nxp-tja11xx.c
> +++ b/drivers/net/phy/nxp-tja11xx.c
> @@ -78,8 +78,7 @@
>  #define MII_COMMCFG			27
>  #define MII_COMMCFG_AUTO_OP		BIT(15)
>  
> -/* Configure REF_CLK as input in RMII mode */
> -#define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
> +#define TJA11XX_REVERSE_MODE		BIT(0)
>  
>  struct tja11xx_priv {
>  	char		*hwmon_name;
> @@ -274,10 +273,10 @@ static int tja11xx_get_interface_mode(struct phy_device *phydev)
>  		mii_mode = MII_CFG1_REVMII_MODE;
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
> -		if (priv->flags & TJA110X_RMII_MODE_REFCLK_IN)
> -			mii_mode = MII_CFG1_RMII_MODE_REFCLK_IN;
> -		else
> +		if (priv->flags & TJA11XX_REVERSE_MODE)
>  			mii_mode = MII_CFG1_RMII_MODE_REFCLK_OUT;
> +		else
> +			mii_mode = MII_CFG1_RMII_MODE_REFCLK_IN;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -517,8 +516,8 @@ static int tja11xx_parse_dt(struct phy_device *phydev)
>  	if (!IS_ENABLED(CONFIG_OF_MDIO))
>  		return 0;
>  
> -	if (of_property_read_bool(node, "nxp,rmii-refclk-in"))
> -		priv->flags |= TJA110X_RMII_MODE_REFCLK_IN;

Hi,

I am curious to know if there are any backwards compatibility
issues to be considered in making this change.

> +	if (of_property_read_bool(node, "nxp,reverse-mode"))
> +		priv->flags |= TJA11XX_REVERSE_MODE;
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
> 

