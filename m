Return-Path: <netdev+bounces-124405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7A9693FB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57EB1F22243
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027281D54CD;
	Tue,  3 Sep 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ftM1yxXt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1A1D27A9;
	Tue,  3 Sep 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345836; cv=none; b=OUUd0qoq1nC2re7cFk44MYBcOjqdbfUVNJuc7FcnjPb7M8wnbAlohJzF8EperYVqYd+PJTGu4DyOpC86Pbaq/IdFbenJaHfV6A2nk0zRplaHKeslYogpa/jTUgMtPQvBGchHKJ4HtNKIyaRxCivtVrBkSXS6GyyzGFutQ5G9trM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345836; c=relaxed/simple;
	bh=UYOSld3RdgVG/JgNtQR4um3ltCdGncoqgUAdSmmP4ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwCzB2HL4KjpO3V7kFiOLo+Enxgg6xTN9naBNeTLO0UCTJt901EdKrcNIoqkfQ37E88NQh/4NaUDO6Eqq351JRTej+vIUN5HOtYqbXDWsJbgWOctu2HKwU7++iT+pusSgwPqN2qTuS7hhv+qOBVEm1+bVYON0WqCdUnK1Uoyr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ftM1yxXt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345835; x=1756881835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UYOSld3RdgVG/JgNtQR4um3ltCdGncoqgUAdSmmP4ho=;
  b=ftM1yxXtcmghxK0P3agoEb+Wpg/TtOr5oEsKp1kfC1jJuaeoCWPNyk6I
   RFUWzfaWEIgagSMutp9WqHvACMIvZ9Wyb7iIq5UTMUSAV3LVaG6QkrR/W
   Eb24I/UsnNvjehOHsUBOF7BSvUd+iE+uh4SezjJkCRRn+zX3P4MHm7FUx
   uktx85X+hHTUbO/OQAFi/5G/tjtkYpqN7FAFG0+QFiFGfUB08xVjKJlJH
   tGKLknIvmKKo9/PBKDsmAr1u0+xuv+fKf3UnyQsDJhEBZCLHK9Cz+Jci/
   PswsLEt7N539ai6ErGAe8UPgnoPtZmgL+TKXAHIZ7yPmahVJRvT8lGXDS
   g==;
X-CSE-ConnectionGUID: w0XD3/wMSFyhROlOuEJiOA==
X-CSE-MsgGUID: sD8PG/cxQZuPCoTTZPHEDw==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="34305846"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:43:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:43:32 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 23:43:32 -0700
Date: Tue, 3 Sep 2024 08:43:12 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure
 collision detection based on PLCA mode
Message-ID: <20240903064312.2vsoqkoiiuaywg3w@DEN-DL-M31836.microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-8-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240902143458.601578-8-Parthiban.Veerasooran@microchip.com>

The 09/02/2024 20:04, Parthiban Veerasooran wrote:

Hi Parthiban,

> As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024))
> and LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)),
> under normal operation, the device should be operated in PLCA mode.
> Disabling collision detection is recommended to allow the device to
> operate in noisy environments or when reflections and other inherent
> transmission line distortion cause poor signal quality. Collision
> detection must be re-enabled if the device is configured to operate in
> CSMA/CD mode.

Is this something that applies only to Microchip PHYs or is something
generic that applies to all the PHYs.

> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/phy/microchip_t1s.c | 42 ++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index bd0c768df0af..a0565508d7d2 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c
> @@ -26,6 +26,12 @@
>  #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
>  #define LAN865X_REG_STS2 0x0019
>  
> +/* Collision Detector Control 0 Register */
> +#define LAN86XX_REG_COL_DET_CTRL0	0x0087
> +#define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
> +#define COL_DET_ENABLE			BIT(15)
> +#define COL_DET_DISABLE			0x0000
> +
>  #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
>  
>  /* The arrays below are pulled from the following table from AN1699
> @@ -370,6 +376,36 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
> + * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
> + * normal operation, the device should be operated in PLCA mode. Disabling
> + * collision detection is recommended to allow the device to operate in noisy
> + * environments or when reflections and other inherent transmission line
> + * distortion cause poor signal quality. Collision detection must be re-enabled
> + * if the device is configured to operate in CSMA/CD mode.
> + *
> + * AN1760: https://www.microchip.com/en-us/application-notes/an1760
> + * AN1699: https://www.microchip.com/en-us/application-notes/an1699
> + */
> +static int lan86xx_plca_set_cfg(struct phy_device *phydev,
> +				const struct phy_plca_cfg *plca_cfg)
> +{
> +	int ret;
> +
> +	ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
> +	if (ret)
> +		return ret;
> +
> +	if (plca_cfg->enabled)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      LAN86XX_REG_COL_DET_CTRL0,
> +				      COL_DET_CTRL0_ENABLE_BIT_MASK,
> +				      COL_DET_DISABLE);
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> +			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
> +}
> +
>  static int lan86xx_read_status(struct phy_device *phydev)
>  {
>  	/* The phy has some limitations, namely:
> @@ -403,7 +439,7 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.config_init        = lan867x_revc_config_init,
>  		.read_status        = lan86xx_read_status,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
> -		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> +		.set_plca_cfg	    = lan86xx_plca_set_cfg,
>  		.get_plca_status    = genphy_c45_plca_get_status,
>  	},
>  	{
> @@ -413,7 +449,7 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.config_init        = lan867x_revc_config_init,
>  		.read_status        = lan86xx_read_status,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
> -		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> +		.set_plca_cfg	    = lan86xx_plca_set_cfg,
>  		.get_plca_status    = genphy_c45_plca_get_status,
>  	},
>  	{
> @@ -423,7 +459,7 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.config_init        = lan865x_revb_config_init,
>  		.read_status        = lan86xx_read_status,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
> -		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> +		.set_plca_cfg	    = lan86xx_plca_set_cfg,
>  		.get_plca_status    = genphy_c45_plca_get_status,
>  	},
>  };
> -- 
> 2.34.1
> 

-- 
/Horatiu

