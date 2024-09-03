Return-Path: <netdev+bounces-124402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6F9693B8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED2F1F24546
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80231D54D0;
	Tue,  3 Sep 2024 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FHFAeXi0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D951CF28D;
	Tue,  3 Sep 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345223; cv=none; b=iWcPxUymb275Yvvw/7KemUDTiu1QxOlGW8vVwUYJ8j4WV2yWl7daijidx/adHs0yKcALcHsXhi1kIMO1zemtxhSPV/1J3Y3AJT4Agu2TpRyJdNoF+furPUdYAtaGMKz9MacrjtySVaoUdnBLklitu7tpKLIAuSvSnIhfbssh8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345223; c=relaxed/simple;
	bh=y8n8xc9G6Y+NDtl0W5jbHfNf0XRTT0ohSPJ/oTynn1Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQwMYpKSvoUiQzpsBwLprCg1vG/TBv/cgYdrXQ1LaUNgDU8LCru1HB4wlP/j47cFt9RJHCcCHXWFMHztx3VJN2Tyft+o+ezW8mnQ+Hg1Ieno6u8s+bmcKqC75mECdkrflQ6r5E8W38IexGckOaMY53fvJekgnlzydw3rgF8FfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FHFAeXi0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345222; x=1756881222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y8n8xc9G6Y+NDtl0W5jbHfNf0XRTT0ohSPJ/oTynn1Y=;
  b=FHFAeXi0SWCBPNryZIXmF18nZrh2HUFwNcCyhPXiHD+g4kh85hGVZx6f
   goe4pg9beXltNBsweWok0Tn/9eiTz08TmbQVjm2zSNYErHUeJ76KF+6rN
   RljmwSF7+16urGwk2vi8EUng75R039CJFQwGkg6Xa+RODfoFdc8tTpX1L
   y/4xN2I7eqlhurh3zyhT/8gzGVeZZYPrJJB4itby/SLR9Tz7CCoeJREIr
   Cg+xufoLBvY9AhGENSFxC+oR1YDWsTQiYLr+BzSOhegFCYnquAO3iTcOF
   iy1mRnmfk8U4SZP8qgEu88pLk3bOL7o9xeqqkSnBl3fl32lsBCQNy/7r4
   w==;
X-CSE-ConnectionGUID: PervR/ZQSxWpPOA2vCVUYw==
X-CSE-MsgGUID: 0PtNh9LgQlivB08MQK9jpw==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="262173981"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:33:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:33:31 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 23:33:30 -0700
Date: Tue, 3 Sep 2024 08:33:11 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Message-ID: <20240903063311.4uyadgqxx5x7z5e7@DEN-DL-M31836.microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-3-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240902143458.601578-3-Parthiban.Veerasooran@microchip.com>

The 09/02/2024 20:04, Parthiban Veerasooran wrote:
> This patch configures the new/improved initial settings from the latest
> configuration application note AN1760 released for LAN8650/1 Rev.B0
> Revision F (DS60001760G - June 2024).
> https://www.microchip.com/en-us/application-notes/an1760
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/phy/microchip_t1s.c | 119 ++++++++++++++++++++++----------
>  1 file changed, 83 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 0110f3357489..fb651cfa3ee0 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c
> @@ -59,29 +59,45 @@ static const u16 lan867x_revb1_fixup_masks[12] = {
>  	0x0600, 0x7F00, 0x2000, 0xFFFF,
>  };
>  
> -/* LAN865x Rev.B0 configuration parameters from AN1760 */
> -static const u32 lan865x_revb0_fixup_registers[28] = {
> -	0x0091, 0x0081, 0x0043, 0x0044,
> -	0x0045, 0x0053, 0x0054, 0x0055,
> -	0x0040, 0x0050, 0x00D0, 0x00E9,
> -	0x00F5, 0x00F4, 0x00F8, 0x00F9,
> +/* LAN865x Rev.B0 configuration parameters from AN1760
> + * As per the Configuration Application Note AN1760 published in the below link,
> + * https://www.microchip.com/en-us/application-notes/an1760
> + * Revision F (DS60001760G - June 2024)
> + */
> +static const u32 lan865x_revb0_fixup_registers[17] = {
> +	0x00D0, 0x00E0, 0x00E9, 0x00F5,
> +	0x00F4, 0x00F8, 0x00F9, 0x0081,
> +	0x0091, 0x0043, 0x0044, 0x0045,
> +	0x0053, 0x0054, 0x0055, 0x0040,
> +	0x0050,
> +};
> +
> +static const u16 lan865x_revb0_fixup_values[17] = {
> +	0x3F31, 0xC000, 0x9E50, 0x1CF8,
> +	0xC020, 0xB900, 0x4E53, 0x0080,
> +	0x9660, 0x00FF, 0xFFFF, 0x0000,
> +	0x00FF, 0xFFFF, 0x0000, 0x0002,
> +	0x0002,
> +};
> +
> +static const u16 lan865x_revb0_fixup_cfg_regs[2] = {
> +	0x0084, 0x008A,
> +};
> +
> +static const u32 lan865x_revb0_sqi_fixup_regs[12] = {
>  	0x00B0, 0x00B1, 0x00B2, 0x00B3,
>  	0x00B4, 0x00B5, 0x00B6, 0x00B7,
>  	0x00B8, 0x00B9, 0x00BA, 0x00BB,
>  };
>  
> -static const u16 lan865x_revb0_fixup_values[28] = {
> -	0x9660, 0x00C0, 0x00FF, 0xFFFF,
> -	0x0000, 0x00FF, 0xFFFF, 0x0000,
> -	0x0002, 0x0002, 0x5F21, 0x9E50,
> -	0x1CF8, 0xC020, 0x9B00, 0x4E53,
> +static const u16 lan865x_revb0_sqi_fixup_values[12] = {
>  	0x0103, 0x0910, 0x1D26, 0x002A,
>  	0x0103, 0x070D, 0x1720, 0x0027,
>  	0x0509, 0x0E13, 0x1C25, 0x002B,
>  };
>  
> -static const u16 lan865x_revb0_fixup_cfg_regs[5] = {
> -	0x0084, 0x008A, 0x00AD, 0x00AE, 0x00AF
> +static const u16 lan865x_revb0_sqi_fixup_cfg_regs[3] = {
> +	0x00AD, 0x00AE, 0x00AF,
>  };
>  
>  /* Pulled from AN1760 describing 'indirect read'
> @@ -121,6 +137,8 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
>  		ret = lan865x_revb0_indirect_read(phydev, fixup_regs[i]);
>  		if (ret < 0)
>  			return ret;
> +
> +		ret &= 0x1F;

Is this diff supposed to be part of this patch?
Also you can use GENMASK here.

>  		if (ret & BIT(4))
>  			offsets[i] = ret | 0xE0;
>  		else
> @@ -163,59 +181,88 @@ static int lan865x_write_cfg_params(struct phy_device *phydev,
>  	return 0;
>  }
>  
> -static int lan865x_setup_cfgparam(struct phy_device *phydev)
> +static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
>  {
>  	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
>  	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
> -	s8 offsets[2];
>  	int ret;
>  
> -	ret = lan865x_generate_cfg_offsets(phydev, offsets);
> +	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> +				      cfg_params, ARRAY_SIZE(cfg_params));
>  	if (ret)
>  		return ret;
>  
> -	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> +	cfg_results[0] = FIELD_PREP(GENMASK(15, 10), (9 + offsets[0]) & 0x3F) |
> +			 FIELD_PREP(GENMASK(15, 4), (14 + offsets[0]) & 0x3F) |
> +			 0x03;
> +	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), (40 + offsets[1]) & 0x3F);
> +
> +	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> +					cfg_results, ARRAY_SIZE(cfg_results));
> +}
> +
> +static int lan865x_setup_sqi_cfgparam(struct phy_device *phydev, s8 offsets[])
> +{
> +	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
> +	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
> +	int ret;
> +
> +	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_sqi_fixup_cfg_regs,
>  				      cfg_params, ARRAY_SIZE(cfg_params));
>  	if (ret)
>  		return ret;
>  
> -	cfg_results[0] = (cfg_params[0] & 0x000F) |
> -			  FIELD_PREP(GENMASK(15, 10), 9 + offsets[0]) |
> -			  FIELD_PREP(GENMASK(15, 4), 14 + offsets[0]);
> -	cfg_results[1] = (cfg_params[1] & 0x03FF) |
> -			  FIELD_PREP(GENMASK(15, 10), 40 + offsets[1]);
> -	cfg_results[2] = (cfg_params[2] & 0xC0C0) |
> -			  FIELD_PREP(GENMASK(15, 8), 5 + offsets[0]) |
> -			  (9 + offsets[0]);
> -	cfg_results[3] = (cfg_params[3] & 0xC0C0) |
> -			  FIELD_PREP(GENMASK(15, 8), 9 + offsets[0]) |
> -			  (14 + offsets[0]);
> -	cfg_results[4] = (cfg_params[4] & 0xC0C0) |
> -			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
> -			  (22 + offsets[0]);
> +	cfg_results[0] = FIELD_PREP(GENMASK(15, 8), (5 + offsets[0]) & 0x3F) |
> +			 ((9 + offsets[0]) & 0x3F);
> +	cfg_results[1] = FIELD_PREP(GENMASK(15, 8), (9 + offsets[0]) & 0x3F) |
> +			 ((14 + offsets[0]) & 0x3F);
> +	cfg_results[2] = FIELD_PREP(GENMASK(15, 8), (17 + offsets[0]) & 0x3F) |
> +			 ((22 + offsets[0]) & 0x3F);
>  
> -	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> +	return lan865x_write_cfg_params(phydev,
> +					lan865x_revb0_sqi_fixup_cfg_regs,
>  					cfg_results, ARRAY_SIZE(cfg_results));
>  }
>  
>  static int lan865x_revb0_config_init(struct phy_device *phydev)
>  {
> +	s8 offsets[2];
>  	int ret;
>  
>  	/* Reference to AN1760
>  	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8650-1-Configuration-60001760.pdf
>  	 */
> +	ret = lan865x_generate_cfg_offsets(phydev, offsets);
> +	if (ret)
> +		return ret;
> +
>  	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_registers); i++) {
>  		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
>  				    lan865x_revb0_fixup_registers[i],
>  				    lan865x_revb0_fixup_values[i]);
>  		if (ret)
>  			return ret;
> +
> +		if (i == 1) {
> +			ret = lan865x_setup_cfgparam(phydev, offsets);
> +			if (ret)
> +				return ret;
> +		}
>  	}
> -	/* Function to calculate and write the configuration parameters in the
> -	 * 0x0084, 0x008A, 0x00AD, 0x00AE and 0x00AF registers (from AN1760)
> -	 */
> -	return lan865x_setup_cfgparam(phydev);
> +
> +	ret = lan865x_setup_sqi_cfgparam(phydev, offsets);
> +	if (ret)
> +		return ret;
> +
> +	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_sqi_fixup_regs); i++) {
> +		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +				    lan865x_revb0_sqi_fixup_regs[i],
> +				    lan865x_revb0_sqi_fixup_values[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int lan867x_revb1_config_init(struct phy_device *phydev)
> -- 
> 2.34.1
> 

-- 
/Horatiu

