Return-Path: <netdev+bounces-113370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515593DF2C
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E723B22DE1
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167915579F;
	Sat, 27 Jul 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="urBFO0Uq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693A4204B;
	Sat, 27 Jul 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722080204; cv=none; b=X7Rq7gxGU8T9r4xxrk6MXBlvqGPIjT8QV90AM7WTXcNduH7+gU2pTTXIJTk3BRZRRXx9PQXngsYhslORx1rkDNitLy92JsdBalN6dUUrkkVnEYJG/qzgTZnPKlJedLAVftS+qwSqu9v/BEgrEGEo1jRk8U7AgNssNgyIWwbLeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722080204; c=relaxed/simple;
	bh=5YYMZLLx2P9UK49B7UON1nmQlF7P0LtKe0zNJ/gBbV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBgv2/1f0JAqDBAOILy6AJOX07GLzSTtejajT6YUC29YiBxpu4gxKK3paJURuXYPJ7+LOrP6lGeV+8T5SUvnWWYvtzGYRtqltWdFMqHw9kCD3SsuPoBvtlqnQyx8SLIIYjSM2gBi9YEb7yVlg+UelqwqEmhg0z8SV2ge1onJOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=urBFO0Uq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xh6Pz/JmDqczwozccFWy61OPZD8kJgJxezbXQwZ8ipg=; b=urBFO0Uq7ySikkxlc3UpKl2vkt
	fNojBqmEgDpjyEKj2pVH50hEFQZ1i2hP7dDBIZm6fnnJ0MZyMIZUdhUw8b279ZETRS5h0BqsjdOOg
	JzvLwPIZjb0GqKYzwq8ZPh/P5e4DKQKD+yjrl+w6DSn5YeEn8koLCGn/kOi8zYWpkgI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sXfir-003LPP-St; Sat, 27 Jul 2024 13:36:25 +0200
Date: Sat, 27 Jul 2024 13:36:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Frank.Sae" <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux@armlinux.org.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com, xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G
 ethernet phy
Message-ID: <fa2a7a4a-a5fc-4b05-b012-3818f65631c4@lunn.ch>
References: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>

On Sat, Jul 27, 2024 at 02:20:31AM -0700, Frank.Sae wrote:
>  Add a driver for the motorcomm yt8821 2.5G ethernet phy.
>  Verified the driver on
>  BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
>  which is developed by Guangdong Bipai Technology Co., Ltd..
>  On the board, yt8821 2.5G ethernet phy works in
>  AUTO_BX2500_SGMII or FORCE_BX2500 interface,
>  supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
>  Since some functions of yt8821 are similar to YT8521
>  so some functions for yt8821 can be reused.

No leading space please.

> 
> Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>
> ---
>  drivers/net/phy/motorcomm.c | 639 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 636 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 7a11fdb687cc..a432b27dd849 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Motorcomm 8511/8521/8531/8531S PHY driver.
> + * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
>   *
>   * Author: Peter Geis <pgwipeout@gmail.com>
>   * Author: Frank <Frank.Sae@motor-comm.com>
> @@ -16,7 +16,7 @@
>  #define PHY_ID_YT8521		0x0000011a
>  #define PHY_ID_YT8531		0x4f51e91b
>  #define PHY_ID_YT8531S		0x4f51e91a
> -
> +#define PHY_ID_YT8821		0x4f51ea19
>  /* YT8521/YT8531S Register Overview
>   *	UTP Register space	|	FIBER Register space
>   *  ------------------------------------------------------------
> @@ -52,6 +52,15 @@
>  #define YTPHY_SSR_SPEED_10M			0x0
>  #define YTPHY_SSR_SPEED_100M			0x1
>  #define YTPHY_SSR_SPEED_1000M			0x2
> +/* bit9 as speed_mode[2], bit15:14 as Speed_mode[1:0]
> + * Speed_mode[2:0]:
> + * 100 = 2P5G
> + * 011 = 10G
> + * 010 = 1000 Mbps
> + * 001 = 100 Mbps
> + * 000 = 10 Mbps
> + */
> +#define YT8821_SSR_SPEED_2500M			0x4

If these bits are spread around, why 0x4? Ahh, because you extract the
bits and reform the value. Maybe:

#define YTPHY_SSR_SPEED_10M			(0x0 << 14)
#define YTPHY_SSR_SPEED_100M			(0x1 << 14)
#define YTPHY_SSR_SPEED_1000M			(0x2 << 14)
#define YTPHY_SSR_SPEED_10G			(0x3 << 14)
#define YT8821_SSR_SPEED_2500M			(0x0 << 14) | BIT(9)
#define YTPHY_SSR_SPEED_MASK			(0x3 << 14) | BIT(9)

> +#define YT8821_SDS_EXT_CSR_CTRL_REG			0x23
> +#define YT8821_SDS_EXT_CSR_PLL_SETTING			0x8605
> +#define YT8821_UTP_EXT_FFE_IPR_CTRL_REG			0x34E
> +#define YT8821_UTP_EXT_FFE_SETTING			0x8080
> +#define YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG		0x4D2
> +#define YT8821_UTP_EXT_VGA_LPF1_CAP_SHT_SETTING		0x5200
> +#define YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG		0x4D3
> +#define YT8821_UTP_EXT_VGA_LPF2_CAP_SHT_SETTING		0x5200
> +#define YT8821_UTP_EXT_TRACE_CTRL_REG			0x372
> +#define YT8821_UTP_EXT_TRACE_LNG_MED_GAIN_THR_SETTING	0x5A3C
> +#define YT8821_UTP_EXT_IPR_CTRL_REG			0x374
> +#define YT8821_UTP_EXT_IPR_ALPHA_IPR_SETTING		0x7C6C
> +#define YT8821_UTP_EXT_ECHO_CTRL_REG			0x336
> +#define YT8821_UTP_EXT_ECHO_SETTING			0xAA0A
> +#define YT8821_UTP_EXT_GAIN_CTRL_REG			0x340
> +#define YT8821_UTP_EXT_AGC_MED_GAIN_SETTING		0x3022
> +#define YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG		0x36A
> +#define YT8821_UTP_EXT_TH_20DB_2500_SETTING		0x8000
> +#define YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG		0x4B3
> +#define YT8821_UTP_EXT_MU_COARSE_FR_FFE_GN_DC_SETTING	0x7711
> +#define YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG		0x4B5
> +#define YT8821_UTP_EXT_MU_FINE_FR_FFE_GN_DC_SETTING	0x2211
> +#define YT8821_UTP_EXT_ANALOG_CFG7_CTRL_REG		0x56
> +#define YT8821_UTP_EXT_ANALOG_CFG7_RESET		0x20
> +#define YT8821_UTP_EXT_ANALOG_CFG7_PI_CLK_SEL_AFE	0x3F
> +#define YT8821_UTP_EXT_VCT_CFG6_CTRL_REG		0x97
> +#define YT8821_UTP_EXT_VCT_CFG6_FECHO_AMP_TH_SETTING	0x380C
> +#define YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG		0x660
> +#define YT8821_UTP_EXT_TXGE_NFR_FR_SETTING		0x112A
> +#define YT8821_UTP_EXT_PLL_CTRL_REG			0x450
> +#define YT8821_UTP_EXT_PLL_SPARE_SETTING		0xE9
> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL23_CTRL_REG	0x466
> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL23_SETTING	0x6464
> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL01_CTRL_REG	0x467
> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL01_SETTING	0x6464
> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_CTRL_REG	0x468
> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_SETTING	0x6464
> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_CTRL_REG	0x469
> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_SETTING	0x6464

All these _SETTING are magic numbers. Can you document any of them?

> +/**
> + * yt8821_probe() - read dts to get chip mode
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns 0 or negative errno code

kerneldoc requires a : after returns.

> + */
> +static int yt8821_probe(struct phy_device *phydev)
> +{
> +	struct device_node *node = phydev->mdio.dev.of_node;
> +	struct device *dev = &phydev->mdio.dev;
> +	struct yt8821_priv *priv;
> +	u8 chip_mode;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
> +	if (of_property_read_u8(node, "motorcomm,chip-mode", &chip_mode))
> +		chip_mode = YT8821_CHIP_MODE_FORCE_BX2500;
> +
> +	switch (chip_mode) {
> +	case YT8821_CHIP_MODE_AUTO_BX2500_SGMII:
> +		priv->chip_mode = YT8821_CHIP_MODE_AUTO_BX2500_SGMII;
> +		break;
> +	case YT8821_CHIP_MODE_FORCE_BX2500:
> +		priv->chip_mode = YT8821_CHIP_MODE_FORCE_BX2500;
> +		break;
> +	default:
> +		phydev_warn(phydev, "chip_mode err:%d\n", chip_mode);
> +		return -EINVAL;

Didn't the binding say it defaults to forced? Yet here it gives an
error?

> + * yt8821_get_rate_matching - read register to get phy chip mode

Why? You have it in priv?

> +/**
> + * yt8821gen_init_paged() - generic initialization according to page
> + * @phydev: a pointer to a &struct phy_device
> + * @page: The reg page(YT8521_RSSR_FIBER_SPACE/YT8521_RSSR_UTP_SPACE) to
> + * operate.
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8821gen_init_paged(struct phy_device *phydev, int page)
> +{
> +	int old_page;
> +	int ret = 0;
> +
> +	old_page = phy_select_page(phydev, page & YT8521_RSSR_SPACE_MASK);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	if (page & YT8521_RSSR_SPACE_MASK) {
> +		/* sds init */
> +		ret = __phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
> +		if (ret < 0)
> +			goto err_restore_page;
> +
> +		ret = ytphy_write_ext(phydev, YT8821_SDS_EXT_CSR_CTRL_REG,
> +				      YT8821_SDS_EXT_CSR_PLL_SETTING);
> +		if (ret < 0)
> +			goto err_restore_page;
> +	} else {
> +		/* utp init */
> +		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_FFE_IPR_CTRL_REG,
> +				      YT8821_UTP_EXT_FFE_SETTING);
> +		if (ret < 0)
> +			goto err_restore_page;
> +

...

> +	}
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}
> +
> +/**
> + * yt8821gen_init() - generic initialization
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8821gen_init(struct phy_device *phydev)
> +{
> +	int ret = 0;
> +
> +	ret = yt8821gen_init_paged(phydev, YT8521_RSSR_FIBER_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return yt8821gen_init_paged(phydev, YT8521_RSSR_UTP_SPACE);

That is odd. Why not have two functions, rather than one with a
parameter. You get better functions names then, making it clearer what
each function is doing.

> +}
> +
> +/**
> + * yt8821_auto_sleep_config() - phy auto sleep config
> + * @phydev: a pointer to a &struct phy_device
> + * @enable: true enable auto sleep, false disable auto sleep
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8821_auto_sleep_config(struct phy_device *phydev, bool enable)
> +{
> +	int old_page;
> +	int ret = 0;
> +
> +	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	ret = ytphy_modify_ext(phydev,
> +			       YT8521_EXTREG_SLEEP_CONTROL1_REG,
> +			       YT8521_ESC1R_SLEEP_SW,
> +			       enable ? 1 : 0);

So each page has its own extension registers?

> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}
> +

> +/**
> + * yt8821_config_init() - phy initializatioin
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8821_config_init(struct phy_device *phydev)
> +{
> +	struct yt8821_priv *priv = phydev->priv;
> +	int ret, val;
> +
> +	phydev->irq = PHY_POLL;

Why do this?

> +
> +	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
> +	if (priv->chip_mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
> +		ret = ytphy_modify_ext_with_lock(phydev,
> +						 YT8521_CHIP_CONFIG_REG,
> +						 YT8521_CCR_MODE_SEL_MASK,
> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 0));
> +		if (ret < 0)
> +			return ret;
> +
> +		__assign_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			     phydev->possible_interfaces,
> +			     true);
> +		__assign_bit(PHY_INTERFACE_MODE_SGMII,
> +			     phydev->possible_interfaces,
> +			     true);
> +
> +		phydev->rate_matching = RATE_MATCH_NONE;
> +	} else if (priv->chip_mode == YT8821_CHIP_MODE_FORCE_BX2500) {
> +		ret = ytphy_modify_ext_with_lock(phydev,
> +						 YT8521_CHIP_CONFIG_REG,
> +						 YT8521_CCR_MODE_SEL_MASK,
> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 1));
> +		if (ret < 0)
> +			return ret;
> +
> +		phydev->rate_matching = RATE_MATCH_PAUSE;
> +	}

The idea of this phydev->possible_interfaces is to allow the core to
figure out what mode is most appropriate. So i would drop the mode in
DT, default to auto, and let the core tell you it wants 2500 BaseX if
that is all the MAC can do.

> +static int yt8821_read_status(struct phy_device *phydev)
> +{
> +	struct yt8821_priv *priv = phydev->priv;
> +	int old_page;
> +	int ret = 0;
> +	int link;
> +	int val;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		int lpadv = phy_read_mmd(phydev,
> +					 MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
> +
> +		if (lpadv < 0)
> +			return lpadv;
> +
> +		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> +						  lpadv);
> +	}
> +
> +	ret = ytphy_write_ext_with_lock(phydev,
> +					YT8521_REG_SPACE_SELECT_REG,
> +					YT8521_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	val = __phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
> +	if (val < 0) {
> +		ret = val;
> +		goto err_restore_page;
> +	}
> +
> +	link = val & YTPHY_SSR_LINK;
> +	if (link)
> +		yt8821_adjust_status(phydev, val);
> +
> +	if (link) {
> +		if (phydev->link == 0)
> +			phydev_info(phydev,
> +				    "%s, phy addr: %d, link up, mii reg 0x%x = 0x%x\n",
> +				    __func__, phydev->mdio.addr,
> +				    YTPHY_SPECIFIC_STATUS_REG,
> +				    (unsigned int)val);

phydev_dbg()?


> +		phydev->link = 1;
> +	} else {
> +		if (phydev->link == 1)
> +			phydev_info(phydev, "%s, phy addr: %d, link down\n",
> +				    __func__, phydev->mdio.addr);

phydev_dbg()?

	Andrew

