Return-Path: <netdev+bounces-125799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6379196EACD
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BE281CC4
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD813AD2A;
	Fri,  6 Sep 2024 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="itOb+F/9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF77316E;
	Fri,  6 Sep 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604706; cv=none; b=N1Nh71aGflSmEXxgLsF4KXbE7O1F0fuwrMODFeVzIYbi7t4eCG5dpsr9CFx271P/4Whwo3VrNk+ksTpm9T5cHaW47wIt8e2FoKb32I99IUUBqd/YG/jXZ6WptapbetDLodbdTQ2h5l9fzLFMDjBLKpgM9zmCOqnXsDMuv2butio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604706; c=relaxed/simple;
	bh=qd/beez0wMtEPBIVJlKu9wSj3zolrl8ynt67URABGSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYMqpUtEMvO1nvGWz4GpVThfu0i0bH76wIdSPGLVmHljRz+5OdCsb8/b9MInPpHKkVRzUZdXJDDBLH3uOCdYGUb5XbNhq7NkJzV9/X6q7H+uUutLXSQf63viZUrBnyC+erf7PDLWVie9nYwB/PbA7sREgzFs0/l83NLjCYXhRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=itOb+F/9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725604704; x=1757140704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qd/beez0wMtEPBIVJlKu9wSj3zolrl8ynt67URABGSg=;
  b=itOb+F/9u12UIb/cODGnSdK2lkJxMTm023rbUIv04HzSQB+/6uk1S/MT
   2rEIagvCyMx32tNwbZY6/gDIOtfX5LKsfm/O/SVnR3iIgMlDODX7yM1Qs
   2T45P8/Auem4t1sVHvH1WqY42o8Bb9YbDXj+zNEtxjNhEDHb5wTJH7KjU
   GkKih10e5vkQPvUf978iw2/+vQ/37OJUugMN7POQynN/aadN8wvxmiYa6
   wm6sebgtVHYbSCB39YICGo5kEKVMUm89LvayKURn/AwMJfP1cn97uaN4u
   bSJ5HwTbf3sAPEKAc/LLy8FyHyGbl2ZA1Z+KBOCDERQqiq3fsEvGReNQc
   g==;
X-CSE-ConnectionGUID: HOkuecBUQRmphM/4lFZiaA==
X-CSE-MsgGUID: 5fzohW5bST2FNgv4v/J4Ng==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34521855"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 23:38:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 23:37:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 23:37:47 -0700
Date: Fri, 6 Sep 2024 08:37:23 +0200
From: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To: Parthiban Veerasooran - I17164 <Parthiban.Veerasooran@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ramon.nordin.rodriguez@ferroamp.se"
	<ramon.nordin.rodriguez@ferroamp.se>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, UNGLinuxDriver
	<UNGLinuxDriver@microchip.com>, Thorsten Kummermehr - M21127
	<Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Message-ID: <20240906063723.uvegx4m4zb4dfs6m@DEN-DL-M31836.microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-3-Parthiban.Veerasooran@microchip.com>
 <20240903063311.4uyadgqxx5x7z5e7@DEN-DL-M31836.microchip.com>
 <ceaf5895-edfa-4af1-9ab1-b228eb8f956d@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ceaf5895-edfa-4af1-9ab1-b228eb8f956d@microchip.com>

The 09/04/2024 10:20, Parthiban Veerasooran - I17164 wrote:
> Hi Horatiu,
> 
> Thanks for reviewing the patches.
> 
> On 03/09/24 12:03 pm, Horatiu Vultur wrote:
> > The 09/02/2024 20:04, Parthiban Veerasooran wrote:
> >> This patch configures the new/improved initial settings from the latest
> >> configuration application note AN1760 released for LAN8650/1 Rev.B0
> >> Revision F (DS60001760G - June 2024).
> >> https://www.microchip.com/en-us/application-notes/an1760
> >>
> >> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> >> ---
> >>   drivers/net/phy/microchip_t1s.c | 119 ++++++++++++++++++++++----------
> >>   1 file changed, 83 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> >> index 0110f3357489..fb651cfa3ee0 100644
> >> --- a/drivers/net/phy/microchip_t1s.c
> >> +++ b/drivers/net/phy/microchip_t1s.c
> >> @@ -59,29 +59,45 @@ static const u16 lan867x_revb1_fixup_masks[12] = {
> >>   	0x0600, 0x7F00, 0x2000, 0xFFFF,
> >>   };
> >>   
> >> -/* LAN865x Rev.B0 configuration parameters from AN1760 */
> >> -static const u32 lan865x_revb0_fixup_registers[28] = {
> >> -	0x0091, 0x0081, 0x0043, 0x0044,
> >> -	0x0045, 0x0053, 0x0054, 0x0055,
> >> -	0x0040, 0x0050, 0x00D0, 0x00E9,
> >> -	0x00F5, 0x00F4, 0x00F8, 0x00F9,
> >> +/* LAN865x Rev.B0 configuration parameters from AN1760
> >> + * As per the Configuration Application Note AN1760 published in the below link,
> >> + * https://www.microchip.com/en-us/application-notes/an1760
> >> + * Revision F (DS60001760G - June 2024)
> >> + */
> >> +static const u32 lan865x_revb0_fixup_registers[17] = {
> >> +	0x00D0, 0x00E0, 0x00E9, 0x00F5,
> >> +	0x00F4, 0x00F8, 0x00F9, 0x0081,
> >> +	0x0091, 0x0043, 0x0044, 0x0045,
> >> +	0x0053, 0x0054, 0x0055, 0x0040,
> >> +	0x0050,
> >> +};
> >> +
> >> +static const u16 lan865x_revb0_fixup_values[17] = {
> >> +	0x3F31, 0xC000, 0x9E50, 0x1CF8,
> >> +	0xC020, 0xB900, 0x4E53, 0x0080,
> >> +	0x9660, 0x00FF, 0xFFFF, 0x0000,
> >> +	0x00FF, 0xFFFF, 0x0000, 0x0002,
> >> +	0x0002,
> >> +};
> >> +
> >> +static const u16 lan865x_revb0_fixup_cfg_regs[2] = {
> >> +	0x0084, 0x008A,
> >> +};
> >> +
> >> +static const u32 lan865x_revb0_sqi_fixup_regs[12] = {
> >>   	0x00B0, 0x00B1, 0x00B2, 0x00B3,
> >>   	0x00B4, 0x00B5, 0x00B6, 0x00B7,
> >>   	0x00B8, 0x00B9, 0x00BA, 0x00BB,
> >>   };
> >>   
> >> -static const u16 lan865x_revb0_fixup_values[28] = {
> >> -	0x9660, 0x00C0, 0x00FF, 0xFFFF,
> >> -	0x0000, 0x00FF, 0xFFFF, 0x0000,
> >> -	0x0002, 0x0002, 0x5F21, 0x9E50,
> >> -	0x1CF8, 0xC020, 0x9B00, 0x4E53,
> >> +static const u16 lan865x_revb0_sqi_fixup_values[12] = {
> >>   	0x0103, 0x0910, 0x1D26, 0x002A,
> >>   	0x0103, 0x070D, 0x1720, 0x0027,
> >>   	0x0509, 0x0E13, 0x1C25, 0x002B,
> >>   };
> >>   
> >> -static const u16 lan865x_revb0_fixup_cfg_regs[5] = {
> >> -	0x0084, 0x008A, 0x00AD, 0x00AE, 0x00AF
> >> +static const u16 lan865x_revb0_sqi_fixup_cfg_regs[3] = {
> >> +	0x00AD, 0x00AE, 0x00AF,
> >>   };
> >>   
> >>   /* Pulled from AN1760 describing 'indirect read'
> >> @@ -121,6 +137,8 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
> >>   		ret = lan865x_revb0_indirect_read(phydev, fixup_regs[i]);
> >>   		if (ret < 0)
> >>   			return ret;
> >> +
> >> +		ret &= 0x1F;
> > 
> > Is this diff supposed to be part of this patch?
> Yes.

Just for my understanding, why this is needed now and not before?
Because I can see that now you always & the offset with 0x3f. Is it
because you might get overflow because the value is signed?

> > Also you can use GENMASK here.
> Ah ok, it is GENMASK(4, 0) then.
> 
> Best regards,
> Parthiban V
> > 
> >>   		if (ret & BIT(4))
> >>   			offsets[i] = ret | 0xE0;
> >>   		else
> >> @@ -163,59 +181,88 @@ static int lan865x_write_cfg_params(struct phy_device *phydev,
> >>   	return 0;
> >>   }
> >>   
> >> -static int lan865x_setup_cfgparam(struct phy_device *phydev)
> >> +static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
> >>   {
> >>   	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
> >>   	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
> >> -	s8 offsets[2];
> >>   	int ret;
> >>   
> >> -	ret = lan865x_generate_cfg_offsets(phydev, offsets);
> >> +	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> >> +				      cfg_params, ARRAY_SIZE(cfg_params));
> >>   	if (ret)
> >>   		return ret;
> >>   
> >> -	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> >> +	cfg_results[0] = FIELD_PREP(GENMASK(15, 10), (9 + offsets[0]) & 0x3F) |
> >> +			 FIELD_PREP(GENMASK(15, 4), (14 + offsets[0]) & 0x3F) |
> >> +			 0x03;
> >> +	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), (40 + offsets[1]) & 0x3F);
> >> +
> >> +	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> >> +					cfg_results, ARRAY_SIZE(cfg_results));
> >> +}
> >> +
> >> +static int lan865x_setup_sqi_cfgparam(struct phy_device *phydev, s8 offsets[])
> >> +{
> >> +	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
> >> +	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
> >> +	int ret;
> >> +
> >> +	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_sqi_fixup_cfg_regs,
> >>   				      cfg_params, ARRAY_SIZE(cfg_params));
> >>   	if (ret)
> >>   		return ret;
> >>   
> >> -	cfg_results[0] = (cfg_params[0] & 0x000F) |
> >> -			  FIELD_PREP(GENMASK(15, 10), 9 + offsets[0]) |
> >> -			  FIELD_PREP(GENMASK(15, 4), 14 + offsets[0]);
> >> -	cfg_results[1] = (cfg_params[1] & 0x03FF) |
> >> -			  FIELD_PREP(GENMASK(15, 10), 40 + offsets[1]);
> >> -	cfg_results[2] = (cfg_params[2] & 0xC0C0) |
> >> -			  FIELD_PREP(GENMASK(15, 8), 5 + offsets[0]) |
> >> -			  (9 + offsets[0]);
> >> -	cfg_results[3] = (cfg_params[3] & 0xC0C0) |
> >> -			  FIELD_PREP(GENMASK(15, 8), 9 + offsets[0]) |
> >> -			  (14 + offsets[0]);
> >> -	cfg_results[4] = (cfg_params[4] & 0xC0C0) |
> >> -			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
> >> -			  (22 + offsets[0]);
> >> +	cfg_results[0] = FIELD_PREP(GENMASK(15, 8), (5 + offsets[0]) & 0x3F) |
> >> +			 ((9 + offsets[0]) & 0x3F);
> >> +	cfg_results[1] = FIELD_PREP(GENMASK(15, 8), (9 + offsets[0]) & 0x3F) |
> >> +			 ((14 + offsets[0]) & 0x3F);
> >> +	cfg_results[2] = FIELD_PREP(GENMASK(15, 8), (17 + offsets[0]) & 0x3F) |
> >> +			 ((22 + offsets[0]) & 0x3F);
> >>   
> >> -	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
> >> +	return lan865x_write_cfg_params(phydev,
> >> +					lan865x_revb0_sqi_fixup_cfg_regs,
> >>   					cfg_results, ARRAY_SIZE(cfg_results));
> >>   }
> >>   
> >>   static int lan865x_revb0_config_init(struct phy_device *phydev)
> >>   {
> >> +	s8 offsets[2];
> >>   	int ret;
> >>   
> >>   	/* Reference to AN1760
> >>   	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8650-1-Configuration-60001760.pdf
> >>   	 */
> >> +	ret = lan865x_generate_cfg_offsets(phydev, offsets);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>   	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_registers); i++) {
> >>   		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> >>   				    lan865x_revb0_fixup_registers[i],
> >>   				    lan865x_revb0_fixup_values[i]);
> >>   		if (ret)
> >>   			return ret;
> >> +
> >> +		if (i == 1) {
> >> +			ret = lan865x_setup_cfgparam(phydev, offsets);
> >> +			if (ret)
> >> +				return ret;
> >> +		}
> >>   	}
> >> -	/* Function to calculate and write the configuration parameters in the
> >> -	 * 0x0084, 0x008A, 0x00AD, 0x00AE and 0x00AF registers (from AN1760)
> >> -	 */
> >> -	return lan865x_setup_cfgparam(phydev);
> >> +
> >> +	ret = lan865x_setup_sqi_cfgparam(phydev, offsets);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_sqi_fixup_regs); i++) {
> >> +		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> >> +				    lan865x_revb0_sqi_fixup_regs[i],
> >> +				    lan865x_revb0_sqi_fixup_values[i]);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	return 0;
> >>   }
> >>   
> >>   static int lan867x_revb1_config_init(struct phy_device *phydev)
> >> -- 
> >> 2.34.1
> >>
> > 
> 

-- 
/Horatiu

