Return-Path: <netdev+bounces-58309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79AB815C93
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 00:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99329B23197
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785F37169;
	Sat, 16 Dec 2023 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g/Z0c/jx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B73035B;
	Sat, 16 Dec 2023 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gFPfZefQvB16Ck50ZBFNAfLpHddhdBF8xQnSlz9P0sA=; b=g/Z0c/jxyulZar4Lsf8noLHiho
	bPa9EekbpVXgLUqfSGNLry+BkCQKfrBpoNGFKIUJZMVf86U7Qux/HHlbXvx5dy550tkkquy0OBjle
	WgIb+bVu5FM/uSSkOq0MUk9Krft5H/uNxBUXXgIWHqiYKvmaXmAsUzqofrga/kxoEeLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEe9m-0037pr-Bv; Sun, 17 Dec 2023 00:33:18 +0100
Date: Sun, 17 Dec 2023 00:33:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/2] Add the Airoha EN8811H PHY driver
Message-ID: <370ec3e9-033a-49d4-8f9d-44eedd404be7@lunn.ch>
References: <20231216194432.18963-2-ericwouds@gmail.com>
 <20231216194432.18963-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216194432.18963-3-ericwouds@gmail.com>

> index 107880d13d21..bb89cf57de25 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -409,6 +409,11 @@ config XILINX_GMII2RGMII
>  	  the Reduced Gigabit Media Independent Interface(RGMII) between
>  	  Ethernet physical media devices and the Gigabit Ethernet controller.
>  
> +config AIR_EN8811H_PHY
> +	tristate "Drivers for Airoha EN8811H 2.5 Gigabit PHY"

If you look at the naming pattern, this should be

tristate "Airoha EN8811H 2.5 Gigabit PHY"

and these Kconfig entries are sorted for the tristate value, so this
should be between Analog and aquantia.

> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -95,3 +95,4 @@ obj-$(CONFIG_STE10XP)		+= ste10Xp.o
>  obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
>  obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
>  obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
> +obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o

Makefile is sorted by CONFIG_ so that belongs much earlier.

> + * - Forced speed (AN off) is not supported by hardware (!00Mbps)
> + * - Hardware does not report link-partner 2500Base-T advertisement
> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
> +				    u32 pbus_address, u32 pbus_data)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_EXTENDED_4);
> +	if (ret < 0)
> +		return ret;



> +	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_STANDARD);
> +	if (ret < 0)
> +		return ret;

Please implement the .read_page and .write_page methods in struct phy_driver

> +
> +	return 0;
> +}
> +
> +static int air_buckpbus_reg_write(struct phy_device *phydev,
> +				  u32 pbus_address, u32 pbus_data)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = __air_buckpbus_reg_write(phydev, pbus_address, pbus_data);
> +	phy_unlock_mdio_bus(phydev);

This then becomes:

        saved_page = phy_save_page(phydev);
	ret = __air_buckpbus_reg_write(phydev, pbus_address, pbus_data);
	return phy_restore_page(phydev, saved_page, ret);

and all the locking is performed for you.

> +	for (offset = 0; offset < fw->size; offset += 4) {
> +		val = MAKEWORD(fw->data[offset + 2], fw->data[offset + 3]);

get_unaligned_le16() might do what you want. Its better to use the
existing macros than define your own. They are also more likely to do
the correct thing on big-endian.

> +static int en8811h_load_firmware(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw1, *fw2;
> +	int ret;
> +	unsigned int pbus_value;

netdev uses reverse christmass tree. Longest lines first, shortest
last.

> +static int en8811h_config_aneg(struct phy_device *phydev)
> +{
> +	u32 adv;
> +	bool changed = false;
> +	int ret;
> +
> +	phydev_dbg(phydev, "%s: advertising=%*pb\n", __func__,
> +		   __ETHTOOL_LINK_MODE_MASK_NBITS, phydev->advertising);
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return genphy_c45_pma_setup_forced(phydev);

There is a comment saying AUTONEG Off is not supported?

> +
> +	ret = genphy_c45_an_config_aneg(phydev);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	/* Clause 45 has no standardized support for 1000BaseT, therefore
> +	 * use Clause 22 registers for this mode.
> +	 */
> +	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
> +	ret = phy_modify_changed(phydev, MII_CTRL1000, ADVERTISE_1000FULL, adv);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +

Could genphy_config_advert() be used here for the C22 registers?

> +int en8811h_c45_read_link(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	/* Read link state from known reliable register (latched) */
> +
> +	if (!phy_polling_mode(phydev) || !phydev->link) {
> +		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
> +		if (val < 0)
> +			return val;
> +		phydev->link = !!(val & MDIO_STAT1_LSTATUS);
> +
> +		if (phydev->link)
> +			return 0;
> +	}
> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
> +	if (val < 0)
> +		return val;
> +	phydev->link = !!(val & MDIO_STAT1_LSTATUS);
> +
> +	return 0;
> +}
> +
> +static int en8811h_read_status(struct phy_device *phydev)
> +{
> +	int ret, lpagb;
> +	unsigned int pbus_value;
> +
> +	ret = en8811h_c45_read_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		ret = genphy_c45_read_lpa(phydev);
> +		if (ret)
> +			return ret;
> +
> +		/* Clause 45 has no standardized support for 1000BaseT,
> +		 * therefore use Clause 22 registers for this mode.
> +		 */
> +		lpagb = phy_read(phydev, MII_STAT1000);
> +		if (lpagb < 0)
> +			return lpagb;
> +		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, lpagb);

Can you use genphy_read_lpa() here?

In general, if you can use the genphy_ functions to handle the
10/100/1000 speeds, please do.


    Andrew

---
pw-bot: cr

