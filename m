Return-Path: <netdev+bounces-251355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09802D3BE8F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7DD4EAAFB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614BF35A94F;
	Tue, 20 Jan 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AY8/+hKP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868335A922;
	Tue, 20 Jan 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768885049; cv=none; b=L5iySRZHUOPEwtc3qBoBBAg9gLls4ZTyOjmP2a40zp/GjCuUXDrm1DAYgduZHFe+oBRTY47AMDywmCpDi5QkhAEPhj8FdHER8aNgBHFMBZ1mHU2/cGLMmhjuEOQvJn+eL8VMVa9BJxYlKCWOZQgCAVKMZSulIJuowghnhO9yqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768885049; c=relaxed/simple;
	bh=fiNWZq5xxOcnxD1HP6NM7qs0sNpl8HJ6I8DM9E1c/xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfUfJD4hwLr2DQ+BBYyRc21eu7BctSphObDVf6x6hUBTR27PgtN1ss8LMNvNF8qVBTbBNmyETkjm9WsSsnHdgKzLYcqZwm4PZiKn2R7zQiDT/lQMUX3nuiFPe824gbi9TKdeXZRSb4pvKo+qap7j3AmQ9by2zh2cbAUdlEuF8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AY8/+hKP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SXPo8bwtf9qN2jtL95UMWclkUppnt2yJ6sNk7llHuWA=; b=AY8/+hKPuLS7V6sGeREJlqYc42
	njM+nvbRUjCCla3reFcqIeDt8wH6lIwGmpgTrO6G6Eclk9AVzViDCbwMS1mG9I2Q2yuf9lU1m3pHo
	dvHY/+a+MCdgtpL30bzkPPZPS5hscx41Ow1BiSv5GQHnYGG7sKQeL/crNbLsqSdpwVSJtzJo334u/
	Qi8cgLNzU3DRAK7n/qrDdIzFkZDdEyWFwvLWn3jKiPO8g4JyqosQ7F6BPXCglLfcniBna57i7lSwY
	0z9kb5X1Kz8DO/gof3q+lg7aeW78bzBMu56kUNaWVY7qCcVwKsMmRv+hPn535Smw/oD3KLefqaygo
	3mGdbuwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vi3nK-000000005q6-3P48;
	Tue, 20 Jan 2026 04:56:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vi3n6-000000007Ae-2ALf;
	Tue, 20 Jan 2026 04:56:32 +0000
Date: Tue, 20 Jan 2026 04:56:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aW8LAFhCRWlMVemz@shell.armlinux.org.uk>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120043609.910302-4-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 20, 2026 at 12:36:08PM +0800, Inochi Amaoto wrote:
> Adds Spacemit dwmac driver support on the Spacemit K3 SoC.

Some more information would be useful. E.g. describing why you need to
fix the RGMII mode.

> +/* ctrl register bits */
> +#define PHY_INTF_RGMII			BIT(3)
> +#define PHY_INTF_MII			BIT(4)
> +
> +#define WAKE_IRQ_EN			BIT(9)
> +#define PHY_IRQ_EN			BIT(12)
> +
> +/* dline register bits */
> +#define RGMII_RX_DLINE_EN		BIT(0)
> +#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
> +#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
> +#define RGMII_TX_DLINE_EN		BIT(16)
> +#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
> +#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
> +
> +#define MAX_DLINE_DELAY_CODE		0xff
> +
> +struct spacemit_dwmac {
> +	struct device *dev;
> +	struct clk *tx;
> +};

This structure seems unused.

> +
> +/* Note: the delay step value is at 0.1ps */
> +static const unsigned int k3_delay_step_10x[4] = {
> +	367, 493, 559, 685
> +};
> +
> +static int spacemit_dwmac_set_delay(struct regmap *apmu,
> +				    unsigned int dline_offset,
> +				    unsigned int tx_code, unsigned int tx_config,
> +				    unsigned int rx_code, unsigned int rx_config)
> +{
> +	unsigned int mask, val;
> +
> +	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> +	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> +	val = FIELD_PREP(RGMII_TX_DLINE_CODE, tx_config) |
> +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> +	      FIELD_PREP(RGMII_TX_DLINE_CODE, rx_config) |
> +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;

These FIELD_PREP() fields look wrong. Did you mean to use DLINE_CODE
both tx_config and tx_code, and did you mean to use TX_DLINE_CODE for
rx_config ?

> +	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> +	if (IS_ERR(plat_dat->clk_tx_i))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
> +				     "failed to get tx clock\n");

You set plat_dat->clk_tx_i, but you don't point
plat_dat->set_clk_tx_rate at anything, which means the stmmac core
does nothing with this.

Given the last two points, has RGMII mode been tested on this
hardware?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

