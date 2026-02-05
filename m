Return-Path: <netdev+bounces-257098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBcFHUplhGkh2wMAu9opvQ
	(envelope-from <netdev+bounces-257098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:39:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A11F0E9B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B92530062F6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475339E6D7;
	Thu,  5 Feb 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QHr++8aD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199F1D54FA;
	Thu,  5 Feb 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284359; cv=none; b=OZMARobJysErkzcMK6UnkdLQ9hpx6CIKrfksM2ctOBoV4IUXuCmIApoEbMOdyUpU9oDci0UL/p4siAah+UBWLKzB6rTqQ28DwHm+7TBmT+hmlf5fkbF3my1yPTJ0uuMfndU8IeM+I5nspPQjEFyStHXOOFYDZirF5KJMRdszLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284359; c=relaxed/simple;
	bh=kb+3kQ580ml4OH6hQlmA3xJo8+oAUlMwpEGFqGt8DlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqcLIpJu7qieurci8KSrJAuvN7l7C2Vt4DYUKpbCnUuIO5XjAOuBfk5akbXMSD+SLGnFOqXjzrxbUFvpAwh/5uHgs5Db2TOtHEQYa9XMY+V0JBXtBiBo9JZGseeMpUnJMYIKC/m6xPZ/obm+X6yTcCfyamqUjHbAuAygVQ/WclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QHr++8aD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dpdEjTwUa2nIvssyS9tGP8C8RHluBGKgaX0/8wOSLqY=; b=QHr++8aDpN/fqF0E0cSew5phMI
	eOaaHQaJem+IazKxQZH7RxAdBMUpjfUNxVqyhuRscxO36yvJg+GRBQyAoHUH0WcBLhHyiRRsh1RgQ
	beaCJEKCRn3JxrS1R7cpvCkJXtetHGrGo0Fd9ettY94gAuW7M50+Jt2adpl6dnSqhCPom978IV6W7
	VAEnODHHo+wjSFRjfnNdunhiVM15F0PIx9pI57/uRyKMaVfYVz/JtqMEmNchlvHblcysBhFfLMpOz
	s2/Onlz03KvzKqJ2rFt/pZcWV8xcYc2aTEb33F0p+axybcHjHIBmTrf0MB+Ma6NM4tdfDXmJzFoID
	xij5+MNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnvpA-0000000077B-0RIT;
	Thu, 05 Feb 2026 09:38:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnvp4-000000006FN-2Zn1;
	Thu, 05 Feb 2026 09:38:50 +0000
Date: Thu, 5 Feb 2026 09:38:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v11 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <aYRlKk-cCIhqGWX7@shell.armlinux.org.uk>
References: <20260205014006.735408-1-a0987203069@gmail.com>
 <20260205014006.735408-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205014006.735408-4-a0987203069@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3A11F0E9B
X-Rspamd-Action: no action

Hi,

On Thu, Feb 05, 2026 at 09:40:05AM +0800, Joey Lu wrote:
> +
> +struct nvt_priv_data {
> +	struct platform_device *pdev;

This looks to me like it's write-only, does it serve a useful purpose?

> +	struct regmap *regmap;

This doesn't seem to be used outside of nvt_gmac_setup().

> +};

Given the above two comments, do you actually need struct nvt_priv_data ?

> +
> +static struct nvt_priv_data *
> +nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct nvt_priv_data *bsp_priv;
> +	phy_interface_t phy_mode;
> +	u32 macid, arg, reg;
> +	u32 tx_delay_step;
> +	u32 rx_delay_step;
> +	u32 miscr;
> +
> +	bsp_priv = devm_kzalloc(dev, sizeof(*bsp_priv), GFP_KERNEL);
> +	if (!bsp_priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bsp_priv->regmap =
> +		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
> +	if (IS_ERR(bsp_priv->regmap))
> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bsp_priv->regmap),
> +				     "Failed to get sys register\n"));
> +	if (macid > 1) {
> +		dev_err(dev, "Invalid sys arguments\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
> +		tx_delay_step = 0;
> +	} else {
> +		if (arg <= 2000) {
> +			tx_delay_step = (arg == 2000) ? 0xf : (arg / NVT_PATH_DELAY_STEP);
> +			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay_step);
> +		} else {
> +			dev_err(dev, "Invalid Tx path delay argument.\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +	if (of_property_read_u32(dev->of_node, "rx-internal-delay-ps", &arg)) {
> +		rx_delay_step = 0;
> +	} else {
> +		if (arg <= 2000) {
> +			rx_delay_step = (arg == 2000) ? 0xf : (arg / NVT_PATH_DELAY_STEP);
> +			dev_dbg(dev, "Set Rx path delay to 0x%x\n", rx_delay_step);
> +		} else {
> +			dev_err(dev, "Invalid Rx path delay argument.\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}

Each of these could be moved into a separate function:

static int nvt_gmac_get_delay(struct device *dev, const char *property)
{
	u32 arg;

	if (of_property_read_u32(dev->of_node, property, &arg))
		return 0;

	if (arg > 2000) {
		dev_err(dev, "Invalid %s argument.\n", property);
		return -EINVAL;
	}

	if (arg == 2000)
		return 15;

	return arg / NVT_PATH_DELAY_STEP;
}

then:
	int ret;

	ret = nvt_gmac_get_delay(dev, "tx-internal-delay-ps");
	if (ret < 0)
		return ERR_PTR(ret);

	tx_delay = ret;

	ret = nvt_gmac_get_delay(dev, "rx-internal-delay-ps");
	if (ret < 0)
		return ERR_PTR(ret);

	rx_delay = ret;

> +
> +	miscr = (macid == 0) ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR;
> +	regmap_read(bsp_priv->regmap, miscr, &reg);
> +	reg &= ~(NVT_TX_DELAY_MASK | NVT_RX_DELAY_MASK);
> +
> +	if (of_get_phy_mode(pdev->dev.of_node, &phy_mode)) {
> +		dev_err(dev, "missing phy mode property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		reg &= ~NVT_MISCR_RMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		reg |= NVT_MISCR_RMII;
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported phy-mode (%d)\n", phy_mode);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!(reg & NVT_MISCR_RMII)) {
> +		reg |= FIELD_PREP(NVT_TX_DELAY_MASK, tx_delay_step);
> +		reg |= FIELD_PREP(NVT_RX_DELAY_MASK, rx_delay_step);

You can move this inside the switch above under the RGMII case. Theses
delays are, after all, only for RGMII.

> +	}
> +
> +	regmap_write(bsp_priv->regmap, miscr, reg);

Consider:

	regmap_update_bits(bsp_priv->regmap, miscr,
			   NVT_TX_DELAY_MASK | NVT_RX_DELAY_MASK |
			   NVT_MISCR_RMII, reg);

> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return PTR_ERR(plat_dat);
> +
> +	/* Nuvoton DWMAC configs */
> +	plat_dat->core_type = DWMAC_CORE_GMAC;

Is the hardware not compatible with any of the compatible types that
devm_stmmac_probe_config_dt() will automatically set this for you?
Which version of the core do you have?

> +	plat_dat->tx_fifo_size = 2048;
> +	plat_dat->rx_fifo_size = 4096;

There are tx-fifo-depth / rx-fifo-depth properties that can be used to
describe these in DT.

> +	plat_dat->multicast_filter_bins = 0;
> +	plat_dat->unicast_filter_entries = 8;

If this core is v3.50, v3.70 or v3.72, then there are
snps,multicast-filter-bins and snps,perfect-filter-entries which
can be used to describe both of these.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

