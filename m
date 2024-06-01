Return-Path: <netdev+bounces-99915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB798D6FD0
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11666B21E92
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BE14F9E8;
	Sat,  1 Jun 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugZ44SuL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D61E481;
	Sat,  1 Jun 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246271; cv=none; b=jAhK0i1kC6O3VA6fMcXkTjn/0VeCgHTldJQQVfct/4X5IyWpmuq/qKrbUDAvdKgpOQd3ET2Q0xC3r94YiL5mKVsI1giJ3WOBfJYQt06yK2dmmTNIxsWc/+52As7s/Ds0GeiQoBQ496N4spaHAz8nxFc7KgkZ47WkdzQ4F7uUYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246271; c=relaxed/simple;
	bh=IzVE8C5YnZqN4O/Tp+wPp3Yj9q5vgoAeBWNn9VqOA40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkdnHF8usyiGpZ0HedsakKc3stJpzFCSBF9k8t3HIb+lHDsO3091JkpRl+mm/Z3nSmewyWNbookkWM33sukXRUJ+Y0JyPeip7zupgH3bRn1VN+z7Zmh0IiTT8MDPycWiG9/6G7rgX7sYV0tmXfTvZZA/6yOXSaSJBQ7f6UqJ4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugZ44SuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58518C116B1;
	Sat,  1 Jun 2024 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717246271;
	bh=IzVE8C5YnZqN4O/Tp+wPp3Yj9q5vgoAeBWNn9VqOA40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugZ44SuLkf2nnIYZlKqk7L03OHlHheoG4Me5zcNB7IszGH03C2Mx7je8pWFwWl9xj
	 V2ZZowVtql7AsGfCxzRDb+NgzH3t2d/qKQ2f2sdjeYSpF4GDVLHCsKBAVl+sNlcR6s
	 dnlheMQuFIXUIpaMMiv+qZLZ73qEtYjTXy3MYot3lnIUkr4XHWOH2uoGigf8ooMLjd
	 SMShVhenf3y/P7QVCfB67ncRbUGP3Th0a+jqhQzs+rBqw7aASG9Qg1wWnRmQtTeY/q
	 RX0sFMVXhPS7CsGPaO7ASsDQ6bXc3neZuCOLLMsD6sSLJ6SyQ/2kTznDa8/LItddZ2
	 jkj8r+Ww1HPDw==
Date: Sat, 1 Jun 2024 13:51:05 +0100
From: Simon Horman <horms@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <20240601125105.GJ491852@kernel.org>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
 <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530034844.11176-6-SkyLake.Huang@mediatek.com>

On Thu, May 30, 2024 at 11:48:44AM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> v1:
> Add support for internal 2.5Gphy on MT7988. This driver will load
> necessary firmware, add appropriate time delay and figure out LED.
> Also, certain control registers will be set to fix link-up issues.
> 
> v2:
> 1. Move md32_en_cfg_base & pmb_addr detection in probe function.
> 2. Do not read PMB & MD32_EN_CFG base addresses from dts. We won't
> change that from board to board. Leave them in driver code. Also,
> release those addresses after firmware is triggered.
> 3. Remove half duplex code which leads to ambiguity. Those are for
> testing & developing previously.
> 4. Use correct BMCR definitions.
> 5. Correct config_aneg / get_features / read_status functions.
> 6. Change mt7988_2p5ge prefix to mt798x_2p5ge in case that our next
> platform uses this 2.5Gphy driver.
> 
> v3:
> 1. Add range check for firmware.
> 2. Fix c45_ids.mmds_present in probe function.
> 3. Still use genphy_update_link() in read_status because
> genphy_c45_read_link() can't correct detect link on this phy.
> 
> v4:
> 1. Move firmware loading function to mt798x_2p5ge_phy_load_fw()
> 2. Add AN disable warning in mt798x_2p5ge_phy_config_aneg()
> 3. Clarify the HDX comments in mt798x_2p5ge_phy_get_features()
> 
> v5:
> 1. Move md32_en_cfg_base & pmb_addr to local variables to achieve
> symmetric code.
> 2. Print out firmware date code & version.
> 3. Don't return error if LED pinctrl switching fails. Also, add
> comments to this unusual operations.
> 4. Return -EOPNOTSUPP for AN off case in config_aneg().
> 

Hi Sky,

This is a somewhat unusual way to arrange a patch description.

Usually the description describes the change, particularly why
the change is being made.

While the per-version changes are listed below the scissors ("---").

> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

...

> diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c

...

> +static int mt798x_2p5ge_phy_load_fw(struct phy_device *phydev)
> +{
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> +	void __iomem *md32_en_cfg_base, *pmb_addr;
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw;
> +	int ret, i;
> +	u16 reg;
> +
> +	if (priv->fw_loaded)
> +		return 0;
> +
> +	pmb_addr = ioremap(MT7988_2P5GE_PMB_BASE, MT7988_2P5GE_PMB_LEN);
> +	if (!pmb_addr)
> +		return -ENOMEM;
> +	md32_en_cfg_base = ioremap(MT7988_2P5GE_MD32_EN_CFG_BASE, MT7988_2P5GE_MD32_EN_CFG_LEN);

nit: Networking still prefers code to be 80 columns wide or less.
     It looks like that can be trivially achieved here and
     several other places in this patch.

     OTOH, I don't think there is no need to break lines to meet this
     requirement where it is particularly awkward to do so.

     Flagged by checkpatch.pl --max-line-length=80

> +	if (!md32_en_cfg_base) {
> +		ret = -ENOMEM;
> +		goto free_pmb;
> +	}
> +
> +	ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to load firmware: %s, ret: %d\n",
> +			MT7988_2P5GE_PMB, ret);
> +		goto free;
> +	}
> +
> +	if (fw->size != MT7988_2P5GE_PMB_SIZE) {
> +		dev_err(dev, "Firmware size 0x%zx != 0x%x\n",
> +			fw->size, MT7988_2P5GE_PMB_SIZE);
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	reg = readw(md32_en_cfg_base);
> +	if (reg & MD32_EN) {
> +		phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +		usleep_range(10000, 11000);
> +	}
> +	phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
> +
> +	/* Write magic number to safely stall MCU */
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
> +
> +	for (i = 0; i < MT7988_2P5GE_PMB_SIZE - 1; i += 4)
> +		writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
> +	release_firmware(fw);
> +	dev_info(dev, "Firmware date code: %x/%x/%x, version: %x.%x\n",
> +		 be16_to_cpu(*((uint16_t *)(fw->data + MT7988_2P5GE_PMB_SIZE - 8))),

If the data at fw->data + MT7988_2P5GE_PMB_SIZE - 8 is a 16-bit
Big Endian value, then I think the cast should be to __be16 rather
than uint16_t (and in any case u16 would be preferred to uint16_t
as this is Kernel code).

Flagged by Sparse.

> +		 *(fw->data + MT7988_2P5GE_PMB_SIZE - 6),
> +		 *(fw->data + MT7988_2P5GE_PMB_SIZE - 5),
> +		 *(fw->data + MT7988_2P5GE_PMB_SIZE - 2),
> +		 *(fw->data + MT7988_2P5GE_PMB_SIZE - 1));
> +
> +	writew(reg & ~MD32_EN, md32_en_cfg_base);
> +	writew(reg | MD32_EN, md32_en_cfg_base);
> +	phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +	/* We need a delay here to stabilize initialization of MCU */
> +	usleep_range(7000, 8000);
> +	dev_info(dev, "Firmware loading/trigger ok.\n");
> +
> +	priv->fw_loaded = true;
> +
> +free:
> +	iounmap(md32_en_cfg_base);
> +free_pmb:
> +	iounmap(pmb_addr);
> +
> +	return ret ? ret : 0;
> +}

...

> +static int mt798x_2p5ge_phy_led_blink_set(struct phy_device *phydev, u8 index,
> +					  unsigned long *delay_on,
> +					  unsigned long *delay_off)
> +{
> +	bool blinking = false;
> +	int err = 0;
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;

nit: Please consider arranging local variables in reverse xmas tree order - 
     longest line to shortest.

     Edward Cree's tool can be helpful:
     https://github.com/ecree-solarflare/xmastree

> +
> +	if (index > 1)
> +		return -EINVAL;
> +
> +	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
> +		blinking = true;
> +		*delay_on = 50;
> +		*delay_off = 50;
> +	}
> +
> +	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, blinking);
> +	if (err)
> +		return err;
> +
> +	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
> +				     MTK_2P5GPHY_LED_ON_MASK, false);
> +}

...

