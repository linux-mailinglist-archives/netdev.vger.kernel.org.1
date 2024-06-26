Return-Path: <netdev+bounces-107044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400FE918ED3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C5EB21B2C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D19155A26;
	Wed, 26 Jun 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lELR/PhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F01862B7;
	Wed, 26 Jun 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427947; cv=none; b=KdfgR8Hu+RZCARHczmAVxFCDzP8i9Fsn21L5150runCqbkXu0iWp2Cb6OIao8d4y6gvcl1cIenW0QFTL2EpOKf3h8Ruixp4IntDoGGZXlIE1APuPppH2mPR97XdNTfyQaF1/oUuUwHXI04j25h3PLhkvCsl/3r17fdJCjBmaIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427947; c=relaxed/simple;
	bh=arfeAdJQl0tn49AvIWCZjkwj/e3VAizf6wmeTBPu+mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkBbiRLFIP3wrNLxK9J1obFB0lplS9Ra9n2K5YojMSLYTCT4QHPlRLboUnO7mYWhPLJkxOSnUN2+eRlv0+jauZ5V1R0dOqBfrulX9ZzIC5E8diCWjCm8OWYYkJxkOu8lzbMPfM5WyOgU6sBrO/aOa4lhikBNenpaDN2yLTsTeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lELR/PhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CAC116B1;
	Wed, 26 Jun 2024 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719427946;
	bh=arfeAdJQl0tn49AvIWCZjkwj/e3VAizf6wmeTBPu+mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lELR/PhRsylNyrKFENzI+z5+7Uy+ZtJI+JUCN5pUoA9HKpEvBbXCbRVZiPrdUFqWY
	 UnQR3vXH9MS7yCgQn4OYGkLKzyWGuH+PMc2k1l/e9CpKxFuPz4Rb8C8SzQ3T9BA4cv
	 F5XH23e+DbZFCI1XMOeHKj8wGtkNN3/qYHRTk4xHnsJ9ADz+JmVKQUyea8DJv6M1uf
	 YkhrSq5qpOLmzQgpU/fpvrOibkC9i49hMXuPSvb7jgd7xaJO3iPBUmJ/Op8vYUZU+J
	 /aw8IplnRxbEmlzz0tzh+CVOVNhLX6cPSiSv6dFu/rdvAawHXwxQa/xYUjLRR1iuB7
	 UzKF9SDaMw75A==
Date: Wed, 26 Jun 2024 19:52:21 +0100
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
Subject: Re: [PATCH net-next v9 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <20240626185221.GC3104@kernel.org>
References: <20240626104329.11426-1-SkyLake.Huang@mediatek.com>
 <20240626104329.11426-12-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104329.11426-12-SkyLake.Huang@mediatek.com>

On Wed, Jun 26, 2024 at 06:43:27PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Add support for internal 2.5Gphy on MT7988. This driver will load
> necessary firmware, add appropriate time delay and figure out LED.
> Also, certain control registers will be set to fix link-up issues.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

...

Hi Sky,

Sorry for not providing this review earlier in the process.

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
> +	pmb_addr = ioremap(MT7988_2P5GE_PMB_FW_BASE, MT7988_2P5GE_PMB_FW_LEN);
> +	if (!pmb_addr)
> +		return -ENOMEM;
> +	md32_en_cfg_base = ioremap(MT7988_2P5GE_MD32_EN_CFG_BASE,
> +				   MT7988_2P5GE_MD32_EN_CFG_LEN);
> +	if (!md32_en_cfg_base) {
> +		ret = -ENOMEM;
> +		goto free_pmb;
> +	}
> +
> +	ret = request_firmware(&fw, MT7988_2P5GE_PMB_FW, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to load firmware: %s, ret: %d\n",
> +			MT7988_2P5GE_PMB_FW, ret);
> +		goto free;
> +	}
> +
> +	if (fw->size != MT7988_2P5GE_PMB_FW_SIZE) {
> +		dev_err(dev, "Firmware size 0x%zx != 0x%x\n",
> +			fw->size, MT7988_2P5GE_PMB_FW_SIZE);
> +		ret = -EINVAL;
> +		goto free;

It seems that this leaks any resources allocated by request_firmware():
I think a call to release_firmware() is needed in this unwind path.

Flagged by Smatch.

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
> +	for (i = 0; i < MT7988_2P5GE_PMB_FW_SIZE - 1; i += 4)
> +		writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
> +	release_firmware(fw);
> +	dev_info(dev, "Firmware date code: %x/%x/%x, version: %x.%x\n",
> +		 be16_to_cpu(*((__be16 *)(fw->data +
> +					  MT7988_2P5GE_PMB_FW_SIZE - 8))),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 6),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 5),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 2),
> +		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 1));
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

I'm feeling that I'm missing something incredibly obvious,
but could this simply be:

	return ret;

> +}

...

