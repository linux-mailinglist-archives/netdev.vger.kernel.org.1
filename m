Return-Path: <netdev+bounces-148910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88939E363B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BED428240A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167319CC37;
	Wed,  4 Dec 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YCaw6Fc/"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3C1A38E3;
	Wed,  4 Dec 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303373; cv=none; b=mR83+PTmPH22SEkZxuEeVnwcbkgbe5tsh8ThTXjNzA18YO0DWUTbQ6FRrpdsxeS/DxDj5gkjpmAS05M1D4kWOSg2HH+wTHi9IWiGPNIphEY/LVwHKnv5WltI2NxRxTzBVmMPjTriwkc1+AeCWaE015OKCdthViObRJpkdmF12Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303373; c=relaxed/simple;
	bh=WhoqPz6Jxg9f87AQLHw5HCwegCgtZ74V9S4MRVnBudU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUL1q0SFzblxzcbYPa8dwR9qmSxIgjqDPKGEimaUmROH6/GpIJDteJZsAlaQEwUBmXoDNOwvhDbNKuHks6fH3CpSORAKu/POY+2ZdYcpO3QKHM9h4QgED13CDQDdHhRdjFvD9SPOL0Ubq4tobjML+4pPcnMlxRQqaJGbj+UIAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YCaw6Fc/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98FA7240004;
	Wed,  4 Dec 2024 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733303366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fywQARLQqPzOXhYD+b1Ce9/W0hDXDCqDWdz8vmA66M4=;
	b=YCaw6Fc/RGBGvo8xdSWC1VNUeGKAdnys9pYcanXev9zGLhERyOqLwMr6Gnbc2Ju0gkYSEG
	4U91p4FQyvOTnqf/DAHgZVUGaPpCiU5ZL+RheAQJV7AzdAUD80VODL18weg1YbTLkr3MLW
	/tFJZfvnVKldYtrIpyt/q1wQqnREzMqV5fY+bx3VlnvV7+OSYTi/de3zERHUv2KI5/m5pb
	cuSNQKxV4ZMGQPLqvD6u3ueVsUFpOgRqDoixIsFGPXGeLKpWMXKpvrEGZD7M43EvCSPLXl
	UoEdX0UDjzBxDoWEOujnZqYKjAHoZJOUR3n7bbZOHS1BbHUz9k+101ENu+iL4w==
Date: Wed, 4 Dec 2024 10:09:22 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241204100922.0af25d7e@fedora.home>
In-Reply-To: <20241204072427.17778-4-ansuelsmth@gmail.com>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
	<20241204072427.17778-4-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Christian,

On Wed,  4 Dec 2024 08:24:10 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Add Airoha AN8855 5-Port Gigabit DSA switch.
> 
> The switch is also a nvmem-provider as it does have EFUSE to calibrate
> the internal PHYs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

[...]

My two-cents review below :)

> +static void
> +an8855_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct an8855_priv *priv;
> +	int port = dp->index;
> +
> +	priv = ds->priv;
> +
> +	if (port != 5) {
> +		if (port > 5)
> +			dev_err(ds->dev, "unsupported port: %d", port);
> +		return;
> +	}

Looks like the above condition can be simplified to :

	if (port > 5)
		dev_err(...);


> +
> +	regmap_update_bits(priv->regmap, AN8855_PMCR_P(port),
> +			   AN8855_PMCR_IFG_XMIT | AN8855_PMCR_MAC_MODE |
> +			   AN8855_PMCR_BACKOFF_EN | AN8855_PMCR_BACKPR_EN,
> +			   FIELD_PREP(AN8855_PMCR_IFG_XMIT, 0x1) |
> +			   AN8855_PMCR_MAC_MODE | AN8855_PMCR_BACKOFF_EN |
> +			   AN8855_PMCR_BACKPR_EN);
> +}
> +
> +static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	switch (port) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		__set_bit(PHY_INTERFACE_MODE_GMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	case 5:
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		break;
> +	}
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000FD;

For port 5, you may also add the MAC_2500FD capability as it supports
2500BASEX ?

> +}
> +

[...]

> +
> +static void
> +an8855_phylink_mac_link_up(struct phylink_config *config,
> +			   struct phy_device *phydev, unsigned int mode,
> +			   phy_interface_t interface, int speed, int duplex,
> +			   bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +	int port = dp->index;
> +	u32 reg;
> +
> +	reg = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
> +	if (phylink_autoneg_inband(mode)) {
> +		reg &= ~AN8855_PMCR_FORCE_MODE;
> +	} else {
> +		reg |= AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK;
> +
> +		reg &= ~AN8855_PMCR_FORCE_SPEED;
> +		switch (speed) {
> +		case SPEED_10:
> +			reg |= AN8855_PMCR_FORCE_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			reg |= AN8855_PMCR_FORCE_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			reg |= AN8855_PMCR_FORCE_SPEED_1000;
> +			break;
> +		case SPEED_2500:
> +			reg |= AN8855_PMCR_FORCE_SPEED_2500;
> +			break;
> +		case SPEED_5000:
> +			reg |= AN8855_PMCR_FORCE_SPEED_5000;
> +			break;

There's no mention of any mode that can give support for the 5000Mbps
speed, is it a leftover from previous work on the driver ?

> +		}
> +
> +		reg &= ~AN8855_PMCR_FORCE_FDX;
> +		if (duplex == DUPLEX_FULL)
> +			reg |= AN8855_PMCR_FORCE_FDX;
> +
> +		reg &= ~AN8855_PMCR_RX_FC_EN;
> +		if (rx_pause || dsa_port_is_cpu(dp))
> +			reg |= AN8855_PMCR_RX_FC_EN;
> +
> +		reg &= ~AN8855_PMCR_TX_FC_EN;
> +		if (rx_pause || dsa_port_is_cpu(dp))
> +			reg |= AN8855_PMCR_TX_FC_EN;
> +
> +		/* Disable any EEE options */
> +		reg &= ~(AN8855_PMCR_FORCE_EEE5G | AN8855_PMCR_FORCE_EEE2P5G |
> +			 AN8855_PMCR_FORCE_EEE1G | AN8855_PMCR_FORCE_EEE100);
> +	}
> +
> +	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
> +
> +	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> +}
> +
> +static void an8855_pcs_get_state(struct phylink_pcs *pcs,
> +				 struct phylink_link_state *state)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, AN8855_PMSR_P(AN8855_CPU_PORT), &val);
> +	if (ret < 0) {
> +		state->link = false;
> +		return;
> +	}
> +
> +	state->link = !!(val & AN8855_PMSR_LNK);
> +	state->an_complete = state->link;
> +	state->duplex = (val & AN8855_PMSR_DPX) ? DUPLEX_FULL :
> +						  DUPLEX_HALF;
> +
> +	switch (val & AN8855_PMSR_SPEED) {
> +	case AN8855_PMSR_SPEED_10:
> +		state->speed = SPEED_10;
> +		break;
> +	case AN8855_PMSR_SPEED_100:
> +		state->speed = SPEED_100;
> +		break;
> +	case AN8855_PMSR_SPEED_1000:
> +		state->speed = SPEED_1000;
> +		break;
> +	case AN8855_PMSR_SPEED_2500:
> +		state->speed = SPEED_2500;
> +		break;
> +	case AN8855_PMSR_SPEED_5000:
> +		state->speed = SPEED_5000;

Same here for the SPEED_5000, unless i'm missing something :)

Thanks,

Maxime

