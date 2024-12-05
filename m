Return-Path: <netdev+bounces-149453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597619E5B18
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A8518863D4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D13221448;
	Thu,  5 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R7e3yP1s"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD122144F;
	Thu,  5 Dec 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415160; cv=none; b=EP4bSXLObJdf5wQePOOj9wR9Jx7BJyJNYYeZn+QO7M1Cv/HaeIqTxML+1vBHA4yjFPUwb2ECuFPAml83pUmFYsNxG2oS+YWjpHyDNBat6y5Qyx7GI4pzUzq3FVL1An7Afjt4C7fETKDTkBBqL/2JXsrqDgEh3EO8qg1QQJgwgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415160; c=relaxed/simple;
	bh=cQUIFYxlw46OI3Z3Z/2bd1StA2Rxjg0kOG9OboAvitM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2faWwEfzPYvGWdJ+0iL6rxlGsiMr+dUpkDxsWO2taJKxOEAQKtnDItuyzvANNackax615Us9nsNhc9v6zWzhcRsHF8/TLPyfwpWyYUnfHPrRy0+ZXGM46cUV0jdjTGMkUgcdUUXdIqkT1ktMjr8ihdMDRvEQZeo23vfk8/sHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R7e3yP1s; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EehYtkeIKrb/s7hdchyO11JnXC4NAFBZra2+ddU3v1g=; b=R7e3yP1spiSfG+DS+PRUHAJJ1S
	2DZl8tXRPvvMYUYT0ZDW8ljYYhnu0yruoYKgW2v1CPRRSrAm9Na4VxI7LfydqihCxQaxEIOq6DRzI
	iv4n3FMoNL3g8gPagyLIMUEzcUoX3spRzRVFw8nGAWf1X5EBTOsMIfOgZkKfmLqQbt2tOjLT4Jnuq
	9Bo74n/xZ9gSG3d1KEBxdMNGdCKekGHtgWrW3lJ5eqEDn70DeYexfLoBUKNs9b4mh2jRbUxOa3FI+
	0g23qHo+/b9E/hJV8DmEQ8DXMZDnak/Xuice190NzK4T7gyWlrbA0/QZg3we/tDTayQZbYLJdJ5wk
	YrJUObWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56826)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJESV-00056t-0E;
	Thu, 05 Dec 2024 16:12:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJESR-0006gP-0X;
	Thu, 05 Dec 2024 16:12:03 +0000
Date: Thu, 5 Dec 2024 16:12:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <Z1HQ0zYV4aPpW48X@shell.armlinux.org.uk>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205145142.29278-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

hi Christian,

On Thu, Dec 05, 2024 at 03:51:33PM +0100, Christian Marangi wrote:
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 2d10b4d6cfbb..6b6d0b7bae72 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -24,6 +24,15 @@ config NET_DSA_LOOP
>  	  This enables support for a fake mock-up switch chip which
>  	  exercises the DSA APIs.
>  
> +

Niggle - no need for the extra blank line.

> +static int an8855_set_mac_eee(struct dsa_switch *ds, int port,
> +			      struct ethtool_keee *eee)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	u32 reg;
> +	int ret;
> +
> +	if (eee->eee_enabled) {
> +		ret = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
> +		if (ret)
> +			return ret;
> +		/* Force enable EEE if force mode and LINK */
> +		if (reg & AN8855_PMCR_FORCE_MODE &&
> +		    reg & AN8855_PMCR_FORCE_LNK) {
> +			switch (reg & AN8855_PMCR_FORCE_SPEED) {
> +			case AN8855_PMCR_FORCE_SPEED_1000:
> +				reg |= AN8855_PMCR_FORCE_EEE1G;
> +				break;
> +			case AN8855_PMCR_FORCE_SPEED_100:
> +				reg |= AN8855_PMCR_FORCE_EEE100;
> +				break;
> +			default:
> +				break;
> +			}

Does this forcing force EEE to be enabled for the port, irrespective
of the negotiation?

> +			ret = regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> +			if (ret)
> +				return ret;
> +		}
> +		ret = regmap_update_bits(priv->regmap, AN8855_PMEEECR_P(port),
> +					 AN8855_LPI_MODE_EN,
> +					 eee->tx_lpi_enabled ? AN8855_LPI_MODE_EN : 0);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
> +					AN8855_PMCR_FORCE_EEE1G |
> +					AN8855_PMCR_FORCE_EEE100);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_clear_bits(priv->regmap, AN8855_PMEEECR_P(port),
> +					AN8855_LPI_MODE_EN);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int an8855_get_mac_eee(struct dsa_switch *ds, int port,
> +			      struct ethtool_keee *eee)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	u32 reg;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, AN8855_PMEEECR_P(port), &reg);
> +	if (ret)
> +		return ret;
> +	eee->tx_lpi_enabled = reg & AN8855_LPI_MODE_EN;
> +
> +	ret = regmap_read(priv->regmap, AN8855_CKGCR, &reg);
> +	if (ret)
> +		return ret;
> +	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
> +	eee->tx_lpi_timer = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) / 500;

There is no point setting tx_lpi_enabled and tx_lpi_timer, as phylib
will immediately overwrite then in its phy_ethtool_get_eee() method.
In fact, there's no point to the DSA get_mac_eee() method.

> +
> +	ret = regmap_read(priv->regmap, AN8855_PMSR_P(port), &reg);
> +	if (ret)
> +		return ret;

What's the purpose of this read?

> +
> +	return 0;
> +}

Overall, I would suggest not implementing EEE just yet - I sent out a
22 patch RFC patch set last week which implements EEE support in
phylink, and I have another bunch of patches that clean up DSA that
I didn't send, which includes getting rid of the DSA get_mac_eee()
method.

Now that the bulk of the phylink in-band changes have been merged, my
plan is to work through getting the RFC patch set merged - I've sent
out the first four patches today for final review and merging.

I stated some questions in the RFC cover message that everyone ignored,
maybe you could look at that and give your views on the points I raised
there?

> +static struct phylink_pcs *
> +an8855_phylink_mac_select_pcs(struct phylink_config *config,
> +			      phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return &priv->pcs;
> +	default:
> +		return NULL;
> +	}

Great, exactly what I like to see in mac_select_pcs()!

> +}
> +
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
> +	/* Nothing to configure for internal ports */
> +	if (port != 5)
> +		return;
> +
> +	regmap_update_bits(priv->regmap, AN8855_PMCR_P(port),
> +			   AN8855_PMCR_IFG_XMIT | AN8855_PMCR_MAC_MODE |
> +			   AN8855_PMCR_BACKOFF_EN | AN8855_PMCR_BACKPR_EN,
> +			   FIELD_PREP(AN8855_PMCR_IFG_XMIT, 0x1) |
> +			   AN8855_PMCR_MAC_MODE | AN8855_PMCR_BACKOFF_EN |
> +			   AN8855_PMCR_BACKPR_EN);
> +}

This looks much better, thanks.

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
> +				   MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
> +}
> +
> +static void
> +an8855_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +
> +	/* With autoneg just disable TX/RX else also force link down */
> +	if (phylink_autoneg_inband(mode)) {
> +		regmap_clear_bits(priv->regmap, AN8855_PMCR_P(dp->index),
> +				  AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
> +	} else {
> +		regmap_update_bits(priv->regmap, AN8855_PMCR_P(dp->index),
> +				   AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN |
> +				   AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK,
> +				   AN8855_PMCR_FORCE_MODE);
> +	}
> +}
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
> +			dev_err(priv->dev, "Missing support for 5G speed. Aborting...\n");
> +			return;
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

All the above looks fine to me.

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
> +		dev_err(priv->dev, "Missing support for 5G speed. Setting Unknown.\n");
> +		fallthrough;
> +	default:
> +		state->speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	if (val & AN8855_PMSR_RX_FC)
> +		state->pause |= MLO_PAUSE_RX;
> +	if (val & AN8855_PMSR_TX_FC)
> +		state->pause |= MLO_PAUSE_TX;
> +}
> +
> +static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +	u32 val;
> +	int ret;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +			dev_err(priv->dev, "in-band negotiation unsupported");
> +			return -EINVAL;
> +		}
> +		break;

Now that we have the phylink in-band changes merged, along with a new
PCS .pcs_inband_caps() method, please implement this method to indicate
that in-band is not supported in 2500BASE-X mode. Phylink will issue a
warning if it attempts to go against that (particularly when e.g. the
PHY demands in-band but the PCS doesn't support it - a case that likely
will never work in practice.)

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*                   !!! WELCOME TO HELL !!!                   */
> +
> +	/* TX FIR - improve TX EYE */
> +	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_10,
> +				 AN8855_RG_DA_QP_TX_FIR_C2_SEL |
> +				 AN8855_RG_DA_QP_TX_FIR_C2_FORCE |
> +				 AN8855_RG_DA_QP_TX_FIR_C1_SEL |
> +				 AN8855_RG_DA_QP_TX_FIR_C1_FORCE,
> +				 AN8855_RG_DA_QP_TX_FIR_C2_SEL |
> +				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C2_FORCE, 0x4) |
> +				 AN8855_RG_DA_QP_TX_FIR_C1_SEL |
> +				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C1_FORCE, 0x0));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x0;
> +	else
> +		val = 0xd;
> +	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_11,
> +				 AN8855_RG_DA_QP_TX_FIR_C0B_SEL |
> +				 AN8855_RG_DA_QP_TX_FIR_C0B_FORCE,
> +				 AN8855_RG_DA_QP_TX_FIR_C0B_SEL |
> +				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C0B_FORCE, val));
> +	if (ret)
> +		return ret;
> +
> +	/* RX CDR - improve RX Jitter Tolerance */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x5;
> +	else
> +		val = 0x6;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_BOT_LIM,
> +				 AN8855_RG_QP_CDR_LPF_KP_GAIN |
> +				 AN8855_RG_QP_CDR_LPF_KI_GAIN,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_KP_GAIN, val) |
> +				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_KI_GAIN, val));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x1;
> +	else
> +		val = 0x0;
> +	ret = regmap_update_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_1,
> +				 AN8855_RG_TPHY_SPEED,
> +				 FIELD_PREP(AN8855_RG_TPHY_SPEED, val));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - LPF */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_RICO_SEL_INTF |
> +				 AN8855_RG_DA_QP_PLL_FBKSEL_INTF |
> +				 AN8855_RG_DA_QP_PLL_BR_INTF |
> +				 AN8855_RG_DA_QP_PLL_BPD_INTF |
> +				 AN8855_RG_DA_QP_PLL_BPA_INTF |
> +				 AN8855_RG_DA_QP_PLL_BC_INTF,
> +				 AN8855_RG_DA_QP_PLL_RICO_SEL_INTF |
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_FBKSEL_INTF, 0x0) |
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BR_INTF, 0x3) |
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BPD_INTF, 0x0) |
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BPA_INTF, 0x5) |
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BC_INTF, 0x1));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - ICO */
> +	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_4,
> +			      AN8855_RG_DA_QP_PLL_ICOLP_EN_INTF);
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				AN8855_RG_DA_QP_PLL_ICOIQ_EN_INTF);
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - CHP */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x6;
> +	else
> +		val = 0x4;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_IR_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_IR_INTF, val));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - PFD */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_PFD_OFFSET_EN_INTRF |
> +				 AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF |
> +				 AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF, 0x1) |
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF, 0x1));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - POSTDIV */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_POSTDIV_EN_INTF |
> +				 AN8855_RG_DA_QP_PLL_PHY_CK_EN_INTF |
> +				 AN8855_RG_DA_QP_PLL_PCK_SEL_INTF,
> +				 AN8855_RG_DA_QP_PLL_PCK_SEL_INTF);
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - SDM */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, 0x0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				AN8855_RG_DA_QP_PLL_SDM_IFM_INTF);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_SS_LCPLL_PWCTL_SETTING_2,
> +				 AN8855_RG_NCPO_ANA_MSB,
> +				 FIELD_PREP(AN8855_RG_NCPO_ANA_MSB, 0x1));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x7a000000;
> +	else
> +		val = 0x48000000;
> +	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_2,
> +			   FIELD_PREP(AN8855_RG_LCPLL_NCPO_VALUE, val));
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_PCW_1,
> +			   FIELD_PREP(AN8855_RG_LCPLL_PON_HRDDS_PCW_NCPO_GPON, val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_5,
> +				AN8855_RG_LCPLL_NCPO_CHG);
> +	if (ret)
> +		return ret;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0,
> +				AN8855_RG_DA_QP_PLL_SDM_DI_EN_INTF);
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - SS */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_3,
> +				 AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF, 0x0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_4,
> +				 AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF, 0x0));
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_3,
> +				 AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF, 0x0));
> +	if (ret)
> +		return ret;
> +
> +	/* PLL - TDC */
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0,
> +				AN8855_RG_DA_QP_PLL_TDC_TXCK_SEL_INTF);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD,
> +			      AN8855_RG_QP_PLL_SSC_TRI_EN);
> +	if (ret)
> +		return ret;
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD,
> +			      AN8855_RG_QP_PLL_SSC_PHASE_INI);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_RX_DAC_EN,
> +				 AN8855_RG_QP_SIGDET_HF,
> +				 FIELD_PREP(AN8855_RG_QP_SIGDET_HF, 0x2));
> +	if (ret)
> +		return ret;
> +
> +	/* TCL Disable (only for Co-SIM) */
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_0,
> +				AN8855_RG_QP_EQ_RX500M_CK_SEL);
> +	if (ret)
> +		return ret;
> +
> +	/* TX Init */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x4;
> +	else
> +		val = 0x0;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_TX_MODE,
> +				 AN8855_RG_QP_TX_RESERVE |
> +				 AN8855_RG_QP_TX_MODE_16B_EN,
> +				 FIELD_PREP(AN8855_RG_QP_TX_RESERVE, val));
> +	if (ret)
> +		return ret;
> +
> +	/* RX Control/Init */
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_RXAFE_RESERVE,
> +			      AN8855_RG_QP_CDR_PD_10B_EN);
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x1;
> +	else
> +		val = 0x2;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_MJV_LIM,
> +				 AN8855_RG_QP_CDR_LPF_RATIO,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_RATIO, val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_SETVALUE,
> +				 AN8855_RG_QP_CDR_PR_BUF_IN_SR |
> +				 AN8855_RG_QP_CDR_PR_BETA_SEL,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PR_BUF_IN_SR, 0x6) |
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PR_BETA_SEL, 0x1));
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0xf;
> +	else
> +		val = 0xc;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
> +				 AN8855_RG_QP_CDR_PR_DAC_BAND,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PR_DAC_BAND, val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
> +				 AN8855_RG_QP_CDR_PR_KBAND_PCIE_MODE |
> +				 AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK, 0x19));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF,
> +				 AN8855_RG_QP_CDR_PHYCK_SEL |
> +				 AN8855_RG_QP_CDR_PHYCK_RSTB |
> +				 AN8855_RG_QP_CDR_PHYCK_DIV,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PHYCK_SEL, 0x2) |
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PHYCK_DIV, 0x21));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
> +				AN8855_RG_QP_CDR_PR_XFICK_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
> +				 AN8855_RG_QP_CDR_PR_KBAND_DIV,
> +				 FIELD_PREP(AN8855_RG_QP_CDR_PR_KBAND_DIV, 0x4));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_26,
> +				 AN8855_RG_QP_EQ_RETRAIN_ONLY_EN |
> +				 AN8855_RG_LINK_NE_EN |
> +				 AN8855_RG_LINK_ERRO_EN,
> +				 AN8855_RG_QP_EQ_RETRAIN_ONLY_EN |
> +				 AN8855_RG_LINK_ERRO_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_DLY_0,
> +				 AN8855_RG_QP_RX_SAOSC_EN_H_DLY |
> +				 AN8855_RG_QP_RX_PI_CAL_EN_H_DLY,
> +				 FIELD_PREP(AN8855_RG_QP_RX_SAOSC_EN_H_DLY, 0x3f) |
> +				 FIELD_PREP(AN8855_RG_QP_RX_PI_CAL_EN_H_DLY, 0x6f));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_42,
> +				 AN8855_RG_QP_EQ_EN_DLY,
> +				 FIELD_PREP(AN8855_RG_QP_EQ_EN_DLY, 0x150));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_2,
> +				 AN8855_RG_QP_RX_EQ_EN_H_DLY,
> +				 FIELD_PREP(AN8855_RG_QP_RX_EQ_EN_H_DLY, 0x150));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_9,
> +				 AN8855_RG_QP_EQ_LEQOSC_DLYCNT,
> +				 FIELD_PREP(AN8855_RG_QP_EQ_LEQOSC_DLYCNT, 0x1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_8,
> +				 AN8855_RG_DA_QP_SAOSC_DONE_TIME |
> +				 AN8855_RG_DA_QP_LEQOS_EN_TIME,
> +				 FIELD_PREP(AN8855_RG_DA_QP_SAOSC_DONE_TIME, 0x200) |
> +				 FIELD_PREP(AN8855_RG_DA_QP_LEQOS_EN_TIME, 0xfff));
> +	if (ret)
> +		return ret;
> +
> +	/* Frequency meter */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val = 0x10;
> +	else
> +		val = 0x28;
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_5,
> +				 AN8855_RG_FREDET_CHK_CYCLE,
> +				 FIELD_PREP(AN8855_RG_FREDET_CHK_CYCLE, val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_6,
> +				 AN8855_RG_FREDET_GOLDEN_CYCLE,
> +				 FIELD_PREP(AN8855_RG_FREDET_GOLDEN_CYCLE, 0x64));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_7,
> +				 AN8855_RG_FREDET_TOLERATE_CYCLE,
> +				 FIELD_PREP(AN8855_RG_FREDET_TOLERATE_CYCLE, 0x2710));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_0,
> +			      AN8855_RG_PHYA_AUTO_INIT);
> +	if (ret)
> +		return ret;
> +
> +	/* PCS Init */
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
> +					AN8855_RG_SGMII_MODE | AN8855_RG_SGMII_AN_EN);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_HSGMII_PCS_CTROL_1,
> +				AN8855_RG_TBI_10B_MODE);
> +	if (ret)
> +		return ret;
> +
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		/* Set AN Ability - Interrupt */
> +		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN_FORCE_CL37,
> +				      AN8855_RG_FORCE_AN_DONE);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN_13,
> +					 AN8855_SGMII_REMOTE_FAULT_DIS |
> +					 AN8855_SGMII_IF_MODE,
> +					 AN8855_SGMII_REMOTE_FAULT_DIS |
> +					 FIELD_PREP(AN8855_SGMII_IF_MODE, 0xb));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Rate Adaption - GMII path config. */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
> +					AN8855_RG_P0_DIS_MII_MODE);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +			ret = regmap_set_bits(priv->regmap, AN8855_MII_RA_AN_ENABLE,
> +					      AN8855_RG_P0_RA_AN_EN);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = regmap_update_bits(priv->regmap, AN8855_RG_AN_SGMII_MODE_FORCE,
> +						 AN8855_RG_FORCE_CUR_SGMII_MODE |
> +						 AN8855_RG_FORCE_CUR_SGMII_SEL,
> +						 AN8855_RG_FORCE_CUR_SGMII_SEL);
> +			if (ret)
> +				return ret;
> +
> +			ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
> +						AN8855_RG_P0_MII_RA_RX_EN |
> +						AN8855_RG_P0_MII_RA_TX_EN |
> +						AN8855_RG_P0_MII_RA_RX_MODE |
> +						AN8855_RG_P0_MII_RA_TX_MODE);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_set_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
> +				      AN8855_RG_P0_MII_MODE);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0,
> +			      AN8855_RG_RATE_ADAPT_RX_BYPASS |
> +			      AN8855_RG_RATE_ADAPT_TX_BYPASS |
> +			      AN8855_RG_RATE_ADAPT_RX_EN |
> +			      AN8855_RG_RATE_ADAPT_TX_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable AN if not in autoneg */
> +	ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN0, BMCR_ANENABLE,
> +				 neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE :
> +									      0);
> +	if (ret)
> +		return ret;
> +
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_set_bits(priv->regmap, AN8855_PHY_RX_FORCE_CTRL_0,
> +				      AN8855_RG_FORCE_TXC_SEL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Force Speed with fixed-link or 2500base-x as doesn't support aneg */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_2500;
> +		else
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_1000;
> +		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_STS_CTRL_0,
> +					 AN8855_RG_LINK_MODE_P0 |
> +					 AN8855_RG_FORCE_SPD_MODE_P0,
> +					 val | AN8855_RG_FORCE_SPD_MODE_P0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* bypass flow control to MAC */
> +	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_0,
> +			   AN8855_RG_DPX_STS_P3 | AN8855_RG_DPX_STS_P2 |
> +			   AN8855_RG_DPX_STS_P1 | AN8855_RG_TXFC_STS_P0 |
> +			   AN8855_RG_RXFC_STS_P0 | AN8855_RG_DPX_STS_P0);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_2,
> +			   AN8855_RG_RXFC_AN_BYPASS_P3 |
> +			   AN8855_RG_RXFC_AN_BYPASS_P2 |
> +			   AN8855_RG_RXFC_AN_BYPASS_P1 |
> +			   AN8855_RG_TXFC_AN_BYPASS_P3 |
> +			   AN8855_RG_TXFC_AN_BYPASS_P2 |
> +			   AN8855_RG_TXFC_AN_BYPASS_P1 |
> +			   AN8855_RG_DPX_AN_BYPASS_P3 |
> +			   AN8855_RG_DPX_AN_BYPASS_P2 |
> +			   AN8855_RG_DPX_AN_BYPASS_P1 |
> +			   AN8855_RG_DPX_AN_BYPASS_P0);
> +	if (ret)
> +		return ret;

Is the above disruptive to the link if it is executed when the link is
already up? Do you need to re-execute it even when "interface" hasn't
changed?

This gets called to possibly change the PCS advertisement in response
to ethtool -s, so ought not have any link disrupting effects if
nothing has changed.

> +
> +	return 0;
> +}
> +
> +static void an8855_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +
> +	regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN0, BMCR_ANRESTART);

This won't get called for SGMII - Cisco SGMII is merely the PHY telling
the PCS/MAC what was negotiated at the media and how it's going to be
operating the SGMII link. AN restart is a media side thing, so that
would happen at the PHY in that case. I suggest this becomes an empty
no-op function.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

