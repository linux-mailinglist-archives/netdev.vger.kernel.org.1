Return-Path: <netdev+bounces-125801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B687D96EAE4
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0F72850A4
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76C14AD3D;
	Fri,  6 Sep 2024 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CjJDB3WL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3613E3EF;
	Fri,  6 Sep 2024 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605108; cv=none; b=WwosQPbptLRXPN9o2OkJxgP9YAfEO+quIk05CgPZTymToLCNAhRrXZVxrWqrzBEwrsMN952bvX9PBqsypgjmpWV1+nYO0jyRAO9S5IJWblTR0CD8BuxplM6a2EWVSX6OaMlBWm4PQ+Zvi0DO2p8HLPxj4LXqSGHfeeNgu6EX5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605108; c=relaxed/simple;
	bh=S/IVeASMItFAOYJ3NC2v4DBgo3IQ+wQbo7GO2y+iWfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0MiEsihtTu54I8JmeJ+h6KZha+zJ0pvxvDWGrtvyPeI5AAQhwmZjWCMLNiwp+C8uM3ooccXzp/vg3tiFMzsdphLywMp/ie/DHWRmWjQZ4uxC811+Gc+ggYC5TBIQlMz60eJcqXKre1t3Sg18wkaVFAy/NDq7QL/mwk8m1yhSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CjJDB3WL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725605100; x=1757141100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/IVeASMItFAOYJ3NC2v4DBgo3IQ+wQbo7GO2y+iWfw=;
  b=CjJDB3WLJs+WNLNrxzXKdRzjttCyTNKg/Z6UwinSor0up48eed358qsB
   uGvvPeqQK3O0D4DOJAEnru/+n5J8BnD4vcUVClm/qOCAujI1563nTCWzu
   KhDHBo46FCtMsuzQ6f/VEjhMA+dhm7Onrr9HoP6LizQcavWCKpueoGQTt
   ci9+6mg0q0oKlF65tQpcW9OlHZjkUOpk5BwX2r5GYVfJc/O5bGy0Hi/WI
   9lH+8WqnZidzw0FjHNrovWNw4xGQ5hzBaUjUt+ZeQcmh+vvaquOs+b1nq
   rC046+VP7t5jyeXAyatkK+LgkqRdg6MTfiM0xlYfeV71uoaFwXDpgBJ9r
   g==;
X-CSE-ConnectionGUID: WJExBVRsSimvkFk6L16zUg==
X-CSE-MsgGUID: fywENUV8QD2Glu87hZFE0Q==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="31321712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 23:44:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 23:44:21 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 23:44:21 -0700
Date: Fri, 6 Sep 2024 08:43:58 +0200
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
Subject: Re: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure
 collision detection based on PLCA mode
Message-ID: <20240906064358.xmqbs7fzf6kd7ydp@DEN-DL-M31836.microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-8-Parthiban.Veerasooran@microchip.com>
 <20240903064312.2vsoqkoiiuaywg3w@DEN-DL-M31836.microchip.com>
 <d8b880ad-28c2-4fea-9dc6-3adde9dfe8c0@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d8b880ad-28c2-4fea-9dc6-3adde9dfe8c0@microchip.com>

The 09/04/2024 11:46, Parthiban Veerasooran - I17164 wrote:
> Hi Horatiu,
> 
> On 03/09/24 12:13 pm, Horatiu Vultur wrote:
> > The 09/02/2024 20:04, Parthiban Veerasooran wrote:
> > 
> > Hi Parthiban,
> > 
> >> As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024))
> >> and LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)),
> >> under normal operation, the device should be operated in PLCA mode.
> >> Disabling collision detection is recommended to allow the device to
> >> operate in noisy environments or when reflections and other inherent
> >> transmission line distortion cause poor signal quality. Collision
> >> detection must be re-enabled if the device is configured to operate in
> >> CSMA/CD mode.
> > 
> > Is this something that applies only to Microchip PHYs or is something
> > generic that applies to all the PHYs.
> Yes, the behavior is common for all the PHYs but it is purely up to the 
> PHY chip design specific.
> 
> 1. Some vendors will enable this feature in the chip level by latching 
> the register bits. There we don't need software interface.
> 2. Some vendors need software interface to enable this feature like our 
> Microchip PHY does.

Don't you think then is better to create something more generic so other
PHYs to able to do this?

> 
> Best regards,
> Parthiban V
> > 
> >>
> >> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> >> ---
> >>   drivers/net/phy/microchip_t1s.c | 42 ++++++++++++++++++++++++++++++---
> >>   1 file changed, 39 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> >> index bd0c768df0af..a0565508d7d2 100644
> >> --- a/drivers/net/phy/microchip_t1s.c
> >> +++ b/drivers/net/phy/microchip_t1s.c
> >> @@ -26,6 +26,12 @@
> >>   #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
> >>   #define LAN865X_REG_STS2 0x0019
> >>   
> >> +/* Collision Detector Control 0 Register */
> >> +#define LAN86XX_REG_COL_DET_CTRL0	0x0087
> >> +#define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
> >> +#define COL_DET_ENABLE			BIT(15)
> >> +#define COL_DET_DISABLE			0x0000
> >> +
> >>   #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
> >>   
> >>   /* The arrays below are pulled from the following table from AN1699
> >> @@ -370,6 +376,36 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
> >>   	return 0;
> >>   }
> >>   
> >> +/* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
> >> + * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
> >> + * normal operation, the device should be operated in PLCA mode. Disabling
> >> + * collision detection is recommended to allow the device to operate in noisy
> >> + * environments or when reflections and other inherent transmission line
> >> + * distortion cause poor signal quality. Collision detection must be re-enabled
> >> + * if the device is configured to operate in CSMA/CD mode.
> >> + *
> >> + * AN1760: https://www.microchip.com/en-us/application-notes/an1760
> >> + * AN1699: https://www.microchip.com/en-us/application-notes/an1699
> >> + */
> >> +static int lan86xx_plca_set_cfg(struct phy_device *phydev,
> >> +				const struct phy_plca_cfg *plca_cfg)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (plca_cfg->enabled)
> >> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> >> +				      LAN86XX_REG_COL_DET_CTRL0,
> >> +				      COL_DET_CTRL0_ENABLE_BIT_MASK,
> >> +				      COL_DET_DISABLE);
> >> +
> >> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> >> +			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
> >> +}
> >> +
> >>   static int lan86xx_read_status(struct phy_device *phydev)
> >>   {
> >>   	/* The phy has some limitations, namely:
> >> @@ -403,7 +439,7 @@ static struct phy_driver microchip_t1s_driver[] = {
> >>   		.config_init        = lan867x_revc_config_init,
> >>   		.read_status        = lan86xx_read_status,
> >>   		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
> >> -		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> >> +		.set_plca_cfg	    = lan86xx_plca_set_cfg,
> >>   		.get_plca_status    = genphy_c45_plca_get_status,
> >>   	},
> >>   	{
> >> @@ -413,7 +449,7 @@ static struct phy_driver microchip_t1s_driver[] = {
> >>   		.config_init        = lan867x_revc_config_init,
> >>   		.read_status        = lan86xx_read_status,
> >>   		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
> >> -		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> >> +		.set_plca_cfg	    = lan86xx_plca_set_cfg,
> >>   		.get_plca_status    = genphy_c45_plca_get_status,
> >>   	},
> >>   	{
> >> @@ -423,7 +459,7 @@ static struct phy_driver microchip_t1s_driver[] = {
> >>   		.config_init        = lan865x_revb_config_init,
> >>   		.read_status        = lan86xx_read_status,
> >>   		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
> >> -		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> >> +		.set_plca_cfg	    = lan86xx_plca_set_cfg,
> >>   		.get_plca_status    = genphy_c45_plca_get_status,
> >>   	},
> >>   };
> >> -- 
> >> 2.34.1
> >>
> > 
> 

-- 
/Horatiu

