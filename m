Return-Path: <netdev+bounces-231670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735DBFC619
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308246274E0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6E280CD2;
	Wed, 22 Oct 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E34GmBMa"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA83469FB
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140613; cv=none; b=u6ZPaelOA8ZDU5H+wSFzimgfNr10b5ddcsc2IqGn8nRb6nVplzoKAHKuhNwKsEMqRSY0fcHWh+y77QrUEDfbRftvOcvwrjeOJz0z0gr1F7RrLBQnCR223m5zbkJsAuVfFo0l/bFWjUN6fYUqdCt69t49hLmMOKpcMF9o5wA5MHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140613; c=relaxed/simple;
	bh=32tf5k7nVMi2oOymn3ZonS9XDF5FSJs6bMkE0AIguYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td43tgY+N4Mha/Z2jnbFwQOJNFHI1jqcOCsyc0IyDkmReU1ZOdHfBtnwAcvEhsyHK/nxnmCaMQRYEazSq06Le8w6IxUhfmB4xh3GLj2Skv6gV3ljzkrQX++OQlowwrHKTNjxDd57BF7NzLX4aPuWYJCPUAM61DHcv4eezlkHCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E34GmBMa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 88414C0AFF6;
	Wed, 22 Oct 2025 13:43:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E3B6606DC;
	Wed, 22 Oct 2025 13:43:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 860B5102F242F;
	Wed, 22 Oct 2025 15:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761140607; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GBJUNGHNoCsZ2OCx56e6rdnetXjqjXfaSWdUSlMOnE4=;
	b=E34GmBMaVokVRFK9/DcbPWDvEDixYvzU/DHT/1OEDLbtWJFAnPGC1EHS/MxGfWSnM9PgkL
	SXUV+mfvrCrAG9D8UIVahsR0HZuwrhkfxR2amBTyvS+XLjusMJ19Fq41f8eSa3d14QVMmQ
	LVl+gTbgKkIjhkbuclL0SYlTqQAA0y4znWe0Ot047ghc71tmrY+AcE+nckzSTy/BtJFFIL
	ZFCwFuGTDhGKHEFKFTrxCCSxqJUAXCh14aIg52tKcon3o3lLQiz4MK3IRYeg9PG7IQKpp3
	zj/58g+NPeZGFWHsc5MioHlSQI69YMiLiaUXGrwUJXDhMPc0RYzpCIaF3r1lzA==
Message-ID: <ad16837d-6a30-4b3d-ab9a-99e31523867f@bootlin.com>
Date: Wed, 22 Oct 2025 15:43:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: phy: add phy_may_wakeup()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 17/10/2025 14:04, Russell King (Oracle) wrote:
> Add phy_may_wakeup() which uses the driver model's device_may_wakeup()
> when the PHY driver has marked the device as wakeup capable in the
> driver model, otherwise use phy_drv_wol_enabled().
> 
> Replace the sites that used to call phy_drv_wol_enabled() with this
> as checking the driver model will be more efficient than checking the
> WoL state.
> 
> Export phy_may_wakeup() so that phylink can use it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phy_device.c | 14 ++++++++++++--
>  include/linux/phy.h          |  9 +++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 7a67c900e79a..b7feaf0cb1df 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -251,6 +251,16 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
>  	return wol.wolopts != 0;
>  }
>  
> +bool phy_may_wakeup(struct phy_device *phydev)
> +{
> +	/* If the PHY is using driver-model based wakeup, use that state. */
> +	if (phy_can_wakeup(phydev))
> +		return device_may_wakeup(&phydev->mdio.dev);
> +
> +	return phy_drv_wol_enabled(phydev);
> +}
> +EXPORT_SYMBOL_GPL(phy_may_wakeup);
> +
>  static void phy_link_change(struct phy_device *phydev, bool up)
>  {
>  	struct net_device *netdev = phydev->attached_dev;
> @@ -302,7 +312,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  	/* If the PHY on the mido bus is not attached but has WOL enabled
>  	 * we cannot suspend the PHY.
>  	 */
> -	if (!netdev && phy_drv_wol_enabled(phydev))
> +	if (!netdev && phy_may_wakeup(phydev))
>  		return false;
>  
>  	/* PHY not attached? May suspend if the PHY has not already been
> @@ -1909,7 +1919,7 @@ int phy_suspend(struct phy_device *phydev)
>  	if (phydev->suspended || !phydrv)
>  		return 0;
>  
> -	phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
> +	phydev->wol_enabled = phy_may_wakeup(phydev) ||
>  			      (netdev && netdev->ethtool->wol_enabled);
>  	/* If the device has WOL enabled, we cannot suspend the PHY */
>  	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3eeeaec52832..801356da1fb2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1391,6 +1391,15 @@ static inline bool phy_can_wakeup(struct phy_device *phydev)
>  	return device_can_wakeup(&phydev->mdio.dev);
>  }
>  
> +/**
> + * phy_may_wakeup() - indicate whether PHY has driver model wakeup is enabled
> + * @phydev: The phy_device struct
> + *
> + * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
> + * setting.

That's not exactly what's happening, this suggest this is merely a
wrapper around device_may_wakeup().

I don't think it's worth blocking the series though, but if you need to
respin maybe this could be reworded.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> + */
> +bool phy_may_wakeup(struct phy_device *phydev);
> +
>  void phy_resolve_aneg_pause(struct phy_device *phydev);
>  void phy_resolve_aneg_linkmode(struct phy_device *phydev);
>  

Maxime

