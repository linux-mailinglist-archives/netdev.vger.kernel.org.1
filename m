Return-Path: <netdev+bounces-97052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F78C8F34
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 03:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBD28286A
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 01:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F029AF;
	Sat, 18 May 2024 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qaxxSgnC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615781FBA;
	Sat, 18 May 2024 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715995794; cv=none; b=ZKc51b1E/ViYLCUI8Pj6zG7lMZMQf/CgVrdCOwJYJuoPcXWtIMkyxdyXWxj7mtdeMzV3Qmvn1GVAI5EoBH6jhUJJvoOaDQ2zn9nk2kK/LnjDArGIUdHpehJ5u/4OrGyUU3bQ2dU/6JdWSJAKvn7sIhooU0nzrnxZttHjdXrBbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715995794; c=relaxed/simple;
	bh=e/I2R0ex/+zUSG4fYjgegmsp57FKuxraQDKbhee+BMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Irb0thhuBHt3UMjUL093KaRpZtUXf998i1m2xAUBZxbK1EwawcLMCeRdKnPZiFZ51O2lQr8MrULNDQDN3jIZCjumnuc0MrEyxeGIWxlo1v0HQoj+TLV4mAdG9uuzMcWTZNW1AiqI9mbGhTTKlSRAI75dXsI0e26nNtxzrbY3zkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qaxxSgnC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NEB3yoSgokyYqC55yoEIejaFuqMNPaLcCTzBCdN9PQQ=; b=qaxxSgnCXlcCLI+/FrV6xJZAxS
	5mxZyEe5oJ8EM8eoY1tWDcexDNv6Qu46/jcSe+2w2YxvwrFusByPuIKdmOqLVvqOTNXSjoVuOvMGe
	h0NbUg2pw0OIHfRFJ5nzhiX7PPCUFgJ7R1V+gAOM/tFCNCPJ/EDRCXKW/zTg777ERa2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s88tC-00FbTm-F0; Sat, 18 May 2024 03:29:34 +0200
Date: Sat, 18 May 2024 03:29:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: Re: [PATCH net-next v2 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <cc0f67de-171e-45e1-90d9-b6b40ec71827@lunn.ch>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
 <20240517102908.12079-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517102908.12079-6-SkyLake.Huang@mediatek.com>

> +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw;
> +	struct pinctrl *pinctrl;
> +	int ret, i;
> +	u16 reg;
> +
> +	if (!priv->fw_loaded) {
> +		if (!priv->md32_en_cfg_base || !priv->pmb_addr) {
> +			dev_err(dev, "MD32_EN_CFG base & PMB addresses aren't valid\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
> +		if (ret) {
> +			dev_err(dev, "failed to load firmware: %s, ret: %d\n",
> +				MT7988_2P5GE_PMB, ret);
> +			return ret;
> +		}
> +
> +		reg = readw(priv->md32_en_cfg_base);
> +		if (reg & MD32_EN) {
> +			phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +			usleep_range(10000, 11000);
> +		}
> +		phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
> +
> +		/* Write magic number to safely stall MCU */
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
> +
> +		for (i = 0; i < fw->size - 1; i += 4)
> +			writel(*((uint32_t *)(fw->data + i)), priv->pmb_addr + i);

You should not trust the firmware. At least do a range check. How big
is the SRAM the firmware is being written into? If you are given a
firmware which is 1MB in size, what will happen?

> +		release_firmware(fw);
> +
> +		writew(reg & ~MD32_EN, priv->md32_en_cfg_base);
> +		writew(reg | MD32_EN, priv->md32_en_cfg_base);
> +		phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +		/* We need a delay here to stabilize initialization of MCU */
> +		usleep_range(7000, 8000);
> +		dev_info(dev, "Firmware loading/trigger ok.\n");

Is there a version available anywhere for the firmware?

> +static int mt798x_2p5ge_phy_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* We don't support HDX at MAC layer on mt7988.

That is a MAC limitation, so it should be the MAC which disables this,
not the Phy.

> +	/* FIXME: AN device (MDIO_DEVS_AN)is indeed in this package. However, MDIO_DEVS_AN seems
> +	 * that it won't be set as we detect phydev->c45_ids.mmds_present. So Autoneg_BIT won't be
> +	 * set in genphy_c45_pma_read_abilities(), either. Workaround here temporarily.
> +	 */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
> +
> +	return 0;
> +}
> +
> +static int mt798x_2p5ge_phy_read_status(struct phy_device *phydev)
> +{
> +	u16 bmsr;
> +	int ret;
> +
> +	/* Use this instead of genphy_c45_read_link() because MDIO_DEVS_AN bit isn't set in
> +	 * phydev->c45_ids.mmds_present.

You have this twice now. Is the hardware broken? If so, maybe change
phydev->c45_ids.mmds_present in the probe function to set the bit?

> +	 */
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	/* We'll read link speed through vendor specific registers down below. So remove
> +	 * phy_resolve_aneg_linkmode (AN on) & genphy_c45_read_pma (AN off).
> +	 */
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> +		ret = genphy_c45_read_lpa(phydev);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Clause 45 doesn't define 1000BaseT support. Read the link partner's 1G
> +		 * advertisement via Clause 22
> +		 */
> +		ret = phy_read(phydev, MII_STAT1000);
> +		if (ret < 0)
> +			return ret;
> +		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, ret);
> +	} else if (phydev->autoneg == AUTONEG_DISABLE) {
> +		/* Mask link partner's all advertising capabilities when AN is off. In fact,
> +		 * if we disable antuneg, we can't link up correctly:
> +		 *   2.5G/1G: Need AN to exchange master/slave information.
> +		 *   100M: Without AN, link starts at half duplex, which this phy doesn't support.
> +		 *   10M: Deprecated in this ethernet phy.
> +		 */

So it sounds like phydev->autoneg == AUTONEG_DISABLE is broken with
this hardware. So just don't allow it, return -EOPNOTSUPP in config_aneg()

     Andrew

