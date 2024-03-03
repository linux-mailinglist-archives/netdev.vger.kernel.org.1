Return-Path: <netdev+bounces-76899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6086F520
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 14:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E574B22254
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B84F9C1;
	Sun,  3 Mar 2024 13:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966CC8E0
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472625; cv=none; b=dMxn2iVIssYf2EFC30CsrjTs3D6+soG7lxt6dAOwgSoaGzh9VZHdC0ViLc5RufWMTSRBaSRwo4+Z56Vvbm9gFy7YC7PiwxT8ub/MqeP6RAD9W2ArMh6QRFS0K0xpGWLPPfOySvr9D5KKLapq/nY/E5l/0mfiBBZ5j7Dt/NP4pkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472625; c=relaxed/simple;
	bh=Ya0QUUNzV6b9+YF0UynShN9DuphKcrGT10A31NOpI9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WouAPhPPRnv9ZNgW8LLR27R9XaPiHowGMlr+4u+orliuD/yjXqPlYzQ9qWUEAgnbKwBgv9WHySHCfOWEF1aY9HSUjGktXFx9vuBLBws9XXM35uloZswn3jY7i+y3oKXxEBbQ9oBntiAFiMqOJfRd9mZnCeFZ0zBuVLrTKKW8jcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rgluq-0005O6-0F;
	Sun, 03 Mar 2024 13:30:08 +0000
Date: Sun, 3 Mar 2024 13:29:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH v2 net-next 1/7] net: phy: realtek: configure SerDes mode
 for rtl822x/8251b PHYs
Message-ID: <ZeR7Vs8als7yaWax@makrotopia.org>
References: <20240303102848.164108-1-ericwouds@gmail.com>
 <20240303102848.164108-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303102848.164108-2-ericwouds@gmail.com>

On Sun, Mar 03, 2024 at 11:28:42AM +0100, Eric Woudstra wrote:
> From: Alexander Couzens <lynxis@fe80.eu>
> 
> The rtl822x series and rtl8251b support switching SerDes mode between
> 2500base-x and sgmii based on the negotiated copper speed.
> 
> Configure this switching mode according to SerDes modes supported by
> host.
> 
> There is an additional datasheet for RTL8226B/RTL8221B called
> "SERDES MODE SETTING FLOW APPLICATION NOTE" where this sequence to
> setup interface and rate adapter mode.

Gramar doesn't parse, missing verb.

> 
> However, there is no documentation about the meaning of registers
> and bits, it's literally just magic numbers and pseudo-code.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> [ refactored, dropped HiSGMII mode and changed commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> [ changed rtl822x_update_interface() to use vendor register ]
> [ always fill in possible interfaces ]
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 99 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 1fa70427b2a2..8a876e003774 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -54,6 +54,16 @@
>  						 RTL8201F_ISR_LINK)
>  #define RTL8201F_IER				0x13
>  
> +#define RTL822X_VND1_SERDES_OPTION			0x697a
> +#define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
> +#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
> +#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX		2
> +
> +#define RTL822X_VND1_SERDES_CTRL3			0x7580
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_MASK		GENMASK(5, 0)
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
> +
>  #define RTL8366RB_POWER_SAVE			0x15
>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>  
> @@ -659,6 +669,60 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
>  	return ret;
>  }
>  
> +static int rtl822x_config_init(struct phy_device *phydev)
> +{
> +	bool has_2500, has_sgmii;
> +	u16 mode;
> +	int ret;
> +
> +	has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			    phydev->host_interfaces) ||
> +		   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
> +
> +	has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
> +			     phydev->host_interfaces) ||
> +		    phydev->interface == PHY_INTERFACE_MODE_SGMII;
> +
> +	/* fill in possible interfaces */
> +	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
> +		     has_2500);
> +	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
> +		     has_sgmii);
> +
> +	if (!has_2500 && !has_sgmii)
> +		return 0;
> +
> +	/* determine SerDes option mode */
> +	if (has_2500 && !has_sgmii)
> +		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
> +	else
> +		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
> +
> +	/* the following sequence with magic numbers sets up the SerDes
> +	 * option mode
> +	 */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
> +				     RTL822X_VND1_SERDES_OPTION,
> +				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
> +				     mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
> +}
> +
>  static int rtl822x_get_features(struct phy_device *phydev)
>  {
>  	int val;
> @@ -695,6 +759,28 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>  	return __genphy_config_aneg(phydev, ret);
>  }
>  
> +static void rtl822x_update_interface(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	if (!phydev->link)
> +		return;
> +
> +	/* Change interface according to serdes mode */
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CTRL3);
> +	if (val < 0)
> +		return;
> +
> +	switch (val & RTL822X_VND1_SERDES_CTRL3_MODE_MASK) {
> +	case RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX:
> +		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
> +		break;
> +	case RTL822X_VND1_SERDES_CTRL3_MODE_SGMII:
> +		phydev->interface = PHY_INTERFACE_MODE_SGMII;
> +		break;
> +	}
> +}
> +
>  static int rtl822x_read_status(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -709,11 +795,13 @@ static int rtl822x_read_status(struct phy_device *phydev)
>  						  lpadv);
>  	}
>  
> -	ret = genphy_read_status(phydev);
> +	ret = rtlgen_read_status(phydev);
>  	if (ret < 0)
>  		return ret;
>  
> -	return rtlgen_get_speed(phydev);
> +	rtl822x_update_interface(phydev);
> +
> +	return 0;
>  }
>  
>  static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
> @@ -976,6 +1064,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.match_phy_device = rtl8226_match_phy_device,
>  		.get_features	= rtl822x_get_features,
>  		.config_aneg	= rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status	= rtl822x_read_status,
>  		.suspend	= genphy_suspend,
>  		.resume		= rtlgen_resume,
> @@ -988,6 +1077,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
>  		.get_features	= rtl822x_get_features,
>  		.config_aneg	= rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status	= rtl822x_read_status,
>  		.suspend	= genphy_suspend,
>  		.resume		= rtlgen_resume,
> @@ -1000,6 +1090,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8226-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> @@ -1010,6 +1101,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> @@ -1019,6 +1111,7 @@ static struct phy_driver realtek_drvs[] = {
>  		PHY_ID_MATCH_EXACT(0x001cc849),
>  		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
> +		.config_init    = rtl822x_config_init,
>  		.config_aneg    = rtl822x_config_aneg,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
> @@ -1030,6 +1123,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> @@ -1040,6 +1134,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8251B 5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,

Have you tested this on RTL8251B?
This PHY usually uses 5GBase-R link mode with rate-adapter mode for
lower speeds. Hence I'm pretty sure that also setting up SerDes mode
register will be a bit different.

>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> -- 
> 2.42.1
> 

