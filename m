Return-Path: <netdev+bounces-143014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402919C0E34
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B172B1F21849
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A6216A0F;
	Thu,  7 Nov 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1RWJBjlJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAD366;
	Thu,  7 Nov 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006156; cv=none; b=PUe0Py1r0doKwEHeHEAjTnLytDFE+gcQk62ULB4jCPeIB5BHY0kRmdfYcrR+9UcndTWpIU4NmhCZdsnfRhokoXnuCUP+0ZmOEn5MSXu08BILMj4OHFj6nCbIlHjT713JlyxOTXJ+g0W6lf5KSiCyfEtn5qTVQCBzSM31+ssvMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006156; c=relaxed/simple;
	bh=nZzW/WmHhbcFiTDTjmWVfg5PMyUrdYtAi+hApHDAZ50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzEbwjHrrd2auKK2o9QfUt6SsgkcOiikvZ1olu+Ds8fer3NTR0PWGYJstx1jiLO+jQpIn9qOeh/0O7gJmSGL3QxL0edMsrdgMyjV6NaWNhvU9IQlCbd3jr5GTkxhja8LzVGriFsQy137lF01XQqxbctbLUHfeD4adtdKBbYGvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1RWJBjlJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wbtR0ny7uZ7DabtPLCIyVCVQ9iNTWLvZH7ebTrF+ygk=; b=1RWJBjlJTPHRC1amVHb1o0wi2+
	eCqS8BAENhcoHRKwrd+1PfB+BmF7j50imtp7xcYZGDX0v3+qWhfGZEka24/As618VaP15jSoP6jFL
	KZ2Char2XLW+P1O7Sxpra4N9fhycQACVSh6Nah5IdXfdxH7Q80pEWvp2DIQf5kcCbeImNH845nrmb
	LgOJg/3UAgAdngYjapBay2oTzseBkjxqY4Fo3PEVGhjGbKpMxefww2Ke2eFR9+6WuCtCYt+B+56R/
	zO2Nu1+exYqS9QUNNFhpXQqgesGmcxVOCTk7agTeGu0Mn1sUDXixDWyJJ8aF3gx0ALSRoqUPQPYD0
	Cj8hJdzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43716)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t97ls-0003fj-0w;
	Thu, 07 Nov 2024 19:02:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t97lp-0001WC-03;
	Thu, 07 Nov 2024 19:02:17 +0000
Date: Thu, 7 Nov 2024 19:02:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Message-ID: <Zy0OuPMbUaZtIosj@shell.armlinux.org.uk>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Fri, Nov 01, 2024 at 06:32:51PM +0800, Lei Wei wrote:
> +static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
> +			       phy_interface_t interface)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* Configure PCS interface mode */
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		/* Select Qualcomm SGMII AN mode */
> +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
> +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
> +					 PCS_MODE_SGMII);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PHY_INTERFACE_MODE_QSGMII:
> +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
> +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
> +					 PCS_MODE_QSGMII);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(qpcs->dev,
> +			"Unsupported interface %s\n", phy_modes(interface));
> +		return -EOPNOTSUPP;
> +	}

I think:

	unsigned int mode;

	switch (interface) {
	case PHY_INTERFACE_MODE_SGMII:
		/* Select Qualcomm SGMII AN mode */
		mode = PCS_MODE_SGMII;
		break;

	case PHY_INTERFACE_MODE_QSGMII:
		mode = PCS_MODE_QSGMII;
		break;

	default:
		...
	}

	ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
				 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE, mode);
	if (ret)
		return ret;

might be easier to read? I notice that in patch 4, the USXGMII case
drops PCS_MODE_AN_MODE from the mask, leaving this bit set to whatever
value it previously was. Is that intentional?

> +static int ipq_pcs_link_up_config_sgmii(struct ipq_pcs *qpcs,
> +					int index,
> +					unsigned int neg_mode,
> +					int speed)
> +{
> +	int ret;
> +
> +	/* PCS speed need not be configured if in-band autoneg is enabled */
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		goto pcs_adapter_reset;
> +
> +	/* PCS speed set for force mode */
> +	switch (speed) {
> +	case SPEED_1000:
> +		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
> +					 PCS_MII_SPEED_MASK,
> +					 PCS_MII_SPEED_1000);
> +		if (ret)
> +			return ret;
> +		break;
> +	case SPEED_100:
> +		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
> +					 PCS_MII_SPEED_MASK, PCS_MII_SPEED_100);
> +		if (ret)
> +			return ret;
> +		break;
> +	case SPEED_10:
> +		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
> +					 PCS_MII_SPEED_MASK, PCS_MII_SPEED_10);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(qpcs->dev, "Invalid SGMII speed %d\n", speed);
> +		return -EINVAL;
> +	}

I think it's worth having the same structure here, and with fewer lines
(and fewer long lines) maybe:

	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
		switch (speed) {
		...
		}

		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
					 PCS_MII_SPEED_MASK, ctrl);
		if (ret)
			return ret;
	}

means you don't need the pcs_adapter_reset label.

> +
> +pcs_adapter_reset:
> +	/* PCS adapter reset */
> +	ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
> +				 PCS_MII_ADPT_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
> +				  PCS_MII_ADPT_RESET, PCS_MII_ADPT_RESET);
> +}
> +
> +static void ipq_pcs_get_state(struct phylink_pcs *pcs,
> +			      struct phylink_link_state *state)
> +{
> +	struct ipq_pcs_mii *qpcs_mii = phylink_pcs_to_qpcs_mii(pcs);
> +	struct ipq_pcs *qpcs = qpcs_mii->qpcs;
> +	int index = qpcs_mii->index;
> +
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_QSGMII:
> +		ipq_pcs_get_state_sgmii(qpcs, index, state);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	dev_dbg(qpcs->dev,
> +		"mode=%s/%s/%s link=%u\n",
> +		phy_modes(state->interface),
> +		phy_speed_to_str(state->speed),
> +		phy_duplex_to_str(state->duplex),
> +		state->link);

This will get very noisy given that in polling mode, phylink will call
this once a second - and I see you are using polling mode.

> +/**
> + * ipq_pcs_create() - Create an IPQ PCS MII instance
> + * @np: Device tree node to the PCS MII
> + *
> + * Description: Create a phylink PCS instance for the given PCS MII node @np
> + * and enable the MII clocks. This instance is associated with the specific
> + * MII of the PCS and the corresponding Ethernet netdevice.
> + *
> + * Return: A pointer to the phylink PCS instance or an error-pointer value.
> + */
> +struct phylink_pcs *ipq_pcs_create(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct ipq_pcs_mii *qpcs_mii;
> +	struct device_node *pcs_np;
> +	struct ipq_pcs *qpcs;
> +	int i, ret;
> +	u32 index;
> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (of_property_read_u32(np, "reg", &index))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (index >= PCS_MAX_MII_NRS)
> +		return ERR_PTR(-EINVAL);
> +
> +	pcs_np = of_get_parent(np);
> +	if (!pcs_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_device_is_available(pcs_np)) {
> +		of_node_put(pcs_np);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	pdev = of_find_device_by_node(pcs_np);
> +	of_node_put(pcs_np);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	qpcs = platform_get_drvdata(pdev);
> +	put_device(&pdev->dev);
> +
> +	/* If probe is not yet completed, return DEFER to
> +	 * the dependent driver.
> +	 */
> +	if (!qpcs)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	qpcs_mii = kzalloc(sizeof(*qpcs_mii), GFP_KERNEL);
> +	if (!qpcs_mii)
> +		return ERR_PTR(-ENOMEM);
> +
> +	qpcs_mii->qpcs = qpcs;
> +	qpcs_mii->index = index;
> +	qpcs_mii->pcs.ops = &ipq_pcs_phylink_ops;
> +	qpcs_mii->pcs.neg_mode = true;
> +	qpcs_mii->pcs.poll = true;
> +
> +	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
> +		qpcs_mii->clk[i] = of_clk_get_by_name(np, pcs_mii_clk_name[i]);
> +		if (IS_ERR(qpcs_mii->clk[i])) {
> +			dev_err(qpcs->dev,
> +				"Failed to get MII %d interface clock %s\n",
> +				index, pcs_mii_clk_name[i]);
> +			goto err_clk_get;
> +		}
> +
> +		ret = clk_prepare_enable(qpcs_mii->clk[i]);
> +		if (ret) {
> +			dev_err(qpcs->dev,
> +				"Failed to enable MII %d interface clock %s\n",
> +				index, pcs_mii_clk_name[i]);
> +			goto err_clk_en;
> +		}

Do you always need the clock prepared and enabled? If not, you could
do this in the pcs_enable() method, and turn it off in pcs_disable().

I think phylink may need a tweak to "unuse" the current PCS when
phylink_stop() is called to make that more effective at disabling the
PCS, which is something that should be done - that's a subject for a
separate patch which I may send.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

