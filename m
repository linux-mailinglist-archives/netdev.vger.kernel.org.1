Return-Path: <netdev+bounces-232912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB71C09E83
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983783BD7A8
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621A3016E1;
	Sat, 25 Oct 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gaVbIZmg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A02E764A;
	Sat, 25 Oct 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417880; cv=none; b=hN/gH8zqTmvCpKOIlhR7VjPnrZkhmvywfGoeCq756jxqaQBdkieYc698UfgZ+AnQCCH9pVtO/Mi6x2jbFyCuNL2L1dZgBVLKiEZZuW61oSqu/2KawgnoHkRRtzR/O6OY3psvYUhYkbxML+f5NccMOXtokJK2orU+P5ndM6oZ4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417880; c=relaxed/simple;
	bh=NhyFd3x0IcU36FVuiepdWTEQQ9K0ZZsa5YqEuNGaKE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnGF/ERgBuACb4xvWUER1uR+DE6j1aoYlDbvitWKfa6QPvi//cgspJ8x2S+EHco/YG7ZBEUiBpLEd2LMfaPf5zaRN2hNgf+92Xz84x03cCNREh2NdiLzD7iH2nEHwf96ByUkxLHqsHAA7qP42ZNf7Gvi5XnuwFoM8In6rLcedgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gaVbIZmg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PRsPHEz/DrVccg8l2DF/sDU8Gr7i5rfnTkQZ55zTx8E=; b=gaVbIZmgKEOK/wzt5X/J3Q7Tj9
	PgT5SAo7NpImvMEF18QVk4/DMapCq/+hdTnmFd/jRAEzRNyoYMNNtgMHO4Z2frkx2aPrlVmAr4h0Q
	HSrsVYs1HhU3eBpGX7CB4HHcmTWZuLGUqoDSNLH0t1BJeGo6X5uiSiBigZGueGT292QCUu2GtAGZQ
	I5FxS1VUqnA+plfpHGbkBCkqNKeYFmehwThavgFaiKcg7LgZJ3Xwwi/AcK5U1JUuYdopn8WmA0uj5
	uzD5dfwNNB9pR0ttH49cRBFvpQqC74TWfiqrV3tUFrCkU9uCmkBIu/zvo8rw0ybLtFNDPWJwuPRbm
	9z7TLAZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCjFR-000000000Ha-2LEv;
	Sat, 25 Oct 2025 19:44:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCjFM-000000003tk-00ZH;
	Sat, 25 Oct 2025 19:44:12 +0100
Date: Sat, 25 Oct 2025 19:44:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 13/13] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <aP0ae1rxKnaJUO-_@shell.armlinux.org.uk>
References: <cover.1761402873.git.daniel@makrotopia.org>
 <5a586b0441a18a1e0eca9ebe77668d6ebde79d1c.1761402873.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a586b0441a18a1e0eca9ebe77668d6ebde79d1c.1761402873.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 25, 2025 at 03:51:23PM +0100, Daniel Golle wrote:
> +static int gsw1xx_sgmii_pcs_config(struct phylink_pcs *pcs,
> +				   unsigned int neg_mode,
> +				   phy_interface_t interface,
> +				   const unsigned long *advertising,
> +				   bool permit_pause_to_mac)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +	bool sgmii_mac_mode = dsa_is_user_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
> +	u16 txaneg, anegctl, val, nco_ctrl;
> +	int ret;
> +
> +	/* Assert and deassert SGMII shell reset */
> +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +			      GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +				GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;

So this is disruptive. Overall, at this point, having added every other
comment below, this code has me wondering whether you are aware of the
documentation I have written in phylink.h for pcs_config(). This code
goes against this paragraph in that documentation:

"
 * pcs_config() will be called when configuration of the PCS is required
 * or when the advertisement is possibly updated. It must not unnecessarily
 * disrupt an established link.
"

Low quality implementations lead to poor user experiences.

> +
> +	/* Hardware Bringup FSM Enable  */
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_HWBU_CTRL,
> +			   GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM |
> +			   GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure SGMII PHY Receiver */
> +	val = FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_EQ,
> +			 GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF) |
> +	      GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN |
> +	      GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN |
> +	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
> +			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
> +
> +	// if (!priv->dts.sgmii_rx_invert)
> +		val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Reset and Release TBI */
> +	val = GSW1XX_SGMII_TBI_TBICTL_INITTBI | GSW1XX_SGMII_TBI_TBICTL_ENTBI |
> +	      GSW1XX_SGMII_TBI_TBICTL_CRSTRR | GSW1XX_SGMII_TBI_TBICTL_CRSOFF;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TBICTL, val);
> +	if (ret < 0)
> +		return ret;
> +	val &= ~GSW1XX_SGMII_TBI_TBICTL_INITTBI;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TBICTL, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Release Tx Data Buffers */
> +	ret = regmap_set_bits(priv->sgmii, GSW1XX_SGMII_PCS_TXB_CTL,
> +			      GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_PCS_TXB_CTL,
> +				GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Release Rx Data Buffers */
> +	ret = regmap_set_bits(priv->sgmii, GSW1XX_SGMII_PCS_RXB_CTL,
> +			      GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_PCS_RXB_CTL,
> +				GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB);
> +	if (ret < 0)
> +		return ret;
> +
> +	anegctl = GSW1XX_SGMII_TBI_ANEGCTL_OVRANEG;
> +	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		anegctl |= GSW1XX_SGMII_TBI_ANEGCTL_OVRABL;

override aneg and override able? What's this doing?

> +
> +	switch (phylink_get_link_timer_ns(interface)) {
> +	case 10000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_10US);
> +		break;
> +	case 1600000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_1_6MS);
> +		break;
> +	case 5000000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_5MS);
> +		break;
> +	case 10000000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_10MS);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (interface == PHY_INTERFACE_MODE_SGMII) {
> +		txaneg = ADVERTISE_SGMII;
> +		if (sgmii_mac_mode) {
> +			txaneg |= BIT(14); /* MAC should always send BIT 14 */

Bit 14 is ADVERTISE_LPACK.

I think I'd prefer:

			txaneg = ADVERTISE_SGMII | ADVERTISE_LPACK;

and...

> +			anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> +					      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_MAC);
> +		} else {
> +			txaneg |= LPA_SGMII_1000FULL;

			txaneg = LPA_SGMII | LPA_SGMII_1000FULL;

here.

> +			anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> +					      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_PHY);

So this seems to be yet another case of reverse SGMII. Andrew, please
can we get to a conclusion on PHY_INTERFACE_MODE_REVSGMII before we
end up with a crapshow of drivers doing their own stuff *exactly*
like we see here?

> +		if (neg_mode & PHYLINK_PCS_NEG_INBAND)
> +			anegctl |= GSW1XX_SGMII_TBI_ANEGCTL_ANEGEN;

Please add a comment describing what is going on here. What does this
register bit do...

> +	} else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> +		   interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		txaneg = BIT(5) | BIT(7);

ADVERTISE_1000XFULL | ADVERTISE_1000XPAUSE ?

> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_1000BASEX);
> +	} else {
> +		dev_err(priv->gswip.dev, "%s: SGMII wrong interface mode %s\n",
> +			__func__, phy_modes(interface));
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TXANEGH,
> +			   FIELD_GET(GENMASK(15, 8), txaneg));
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TXANEGL,
> +			   FIELD_GET(GENMASK(7, 0), txaneg));
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL, anegctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* setup SerDes clock speed */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
> +	else
> +		nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
> +
> +	ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
> +				 GSW1XX_SGMII_HSP_MASK | GSW1XX_SGMII_SEL,
> +				 nco_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	ret = gsw1xx_sgmii_phy_xaui_write(priv, 0x30, 0x80);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void gsw1xx_sgmii_pcs_link_up(struct phylink_pcs *pcs,
> +				     unsigned int neg_mode,
> +				     phy_interface_t interface, int speed,
> +				     int duplex)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +	u16 lpstat;
> +
> +	/* When in-band AN is enabled hardware will set lpstat */
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		return;
> +
> +	/* Force speed and duplex settings */
> +	if (interface == PHY_INTERFACE_MODE_SGMII) {
> +		if (speed == SPEED_10)
> +			lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
> +					    GSW1XX_SGMII_TBI_LPSTAT_SPEED_10);
> +		else if (speed == SPEED_100)
> +			lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
> +					    GSW1XX_SGMII_TBI_LPSTAT_SPEED_100);
> +		else
> +			lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
> +					    GSW1XX_SGMII_TBI_LPSTAT_SPEED_1000);
> +	} else {
> +		lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
> +				    GSW1XX_SGMII_TBI_LPSTAT_SPEED_NOSGMII);
> +	}
> +
> +	if (duplex == DUPLEX_FULL)
> +		lpstat |= GSW1XX_SGMII_TBI_LPSTAT_DUPLEX;
> +
> +	regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_LPSTAT, lpstat);
> +}
> +
> +static void gsw1xx_sgmii_pcs_get_state(struct phylink_pcs *pcs,
> +				       unsigned int neg_mode,
> +				       struct phylink_link_state *state)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(priv->sgmii, GSW1XX_SGMII_TBI_TBISTAT, &val);
> +	if (ret < 0)
> +		return;
> +
> +	state->link = !!(val & GSW1XX_SGMII_TBI_TBISTAT_LINK);
> +	state->an_complete = !!(val & GSW1XX_SGMII_TBI_TBISTAT_AN_COMPLETE);
> +
> +	ret = regmap_read(priv->sgmii, GSW1XX_SGMII_TBI_LPSTAT, &val);
> +	if (ret < 0)
> +		return;
> +
> +	state->duplex = (val & GSW1XX_SGMII_TBI_LPSTAT_DUPLEX) ?
> +			 DUPLEX_FULL : DUPLEX_HALF;
> +	if (val & GSW1XX_SGMII_TBI_LPSTAT_PAUSE_RX)
> +		state->pause |= MLO_PAUSE_RX;
> +
> +	if (val & GSW1XX_SGMII_TBI_LPSTAT_PAUSE_TX)
> +		state->pause |= MLO_PAUSE_TX;
> +
> +	switch (FIELD_GET(GSW1XX_SGMII_TBI_LPSTAT_SPEED, val)) {
> +	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_10:
> +		state->speed = SPEED_10;
> +		break;
> +	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_100:
> +		state->speed = SPEED_100;
> +		break;
> +	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_1000:
> +		state->speed = SPEED_1000;
> +		break;
> +	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_NOSGMII:
> +		if (state->interface == PHY_INTERFACE_MODE_1000BASEX)
> +			state->speed = SPEED_1000;
> +		else if (state->interface == PHY_INTERFACE_MODE_2500BASEX)
> +			state->speed = SPEED_2500;
> +		else
> +			state->speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +}
> +
> +static void gsw1xx_sgmii_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +
> +	regmap_set_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
> +			GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
> +}
> +
> +static int gsw1xx_sgmii_pcs_enable(struct phylink_pcs *pcs)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +
> +	/* Deassert SGMII shell reset */
> +	return regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +				 GSW1XX_RST_REQ_SGMII_SHELL);
> +}
> +
> +static void gsw1xx_sgmii_pcs_disable(struct phylink_pcs *pcs)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +
> +	/* Assert SGMII shell reset */
> +	regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +			GSW1XX_RST_REQ_SGMII_SHELL);
> +}
> +
> +static const struct phylink_pcs_ops gsw1xx_sgmii_pcs_ops = {
> +	.pcs_an_restart = gsw1xx_sgmii_pcs_an_restart,
> +	.pcs_config = gsw1xx_sgmii_pcs_config,
> +	.pcs_disable = gsw1xx_sgmii_pcs_disable,
> +	.pcs_enable = gsw1xx_sgmii_pcs_enable,
> +	.pcs_get_state = gsw1xx_sgmii_pcs_get_state,
> +	.pcs_link_up = gsw1xx_sgmii_pcs_link_up,

Please order these in the same order as they appear in the struct, and
please order your functions above in the same order. This makes it
easier in future if new methods need to be added.

Also, please add the .pcs_inband_caps method to describe the
capabilities of the PCS.

It seems to me that this is not just a Cisco SGMII PCS, but also
supports IEEE 802.3 1000BASE-X. "SGMII" is an ambiguous term. Please
avoid propagating this ambigutiy to the kernel. I think in this case
merely "gsw1xx_pcs_xyz" will do.

> +};
> +
> +static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	struct gswip_priv *priv = ds->priv;
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000;
> +
> +	switch (port) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	case 4: /* port 4: SGMII */
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		if (priv->hw_info->supports_2500m) {
> +			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +				  config->supported_interfaces);
> +			config->mac_capabilities |= MAC_2500FD;
> +		}
> +		return; /* no support for EEE on SGMII port */
> +	case 5: /* port 5: RGMII or RMII */
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  config->supported_interfaces);
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		break;
> +	}
> +
> +	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
> +	config->lpi_timer_default = 20;
> +	memcpy(config->lpi_interfaces, config->supported_interfaces,
> +	       sizeof(config->lpi_interfaces));
> +}
> +
> +static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
> +							 phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct gswip_priv *gswip_priv = dp->ds->priv;
> +	struct gsw1xx_priv *gsw1xx_priv = container_of(gswip_priv,
> +						       struct gsw1xx_priv,
> +						       gswip);

Reverse christmas tree?

> +static int gsw1xx_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct gsw1xx_priv *priv;
> +	u32 version;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mdio_dev = mdiodev;
> +	priv->smdio_badr = GSW1XX_SMDIO_BADR_UNKNOWN;
> +
> +	priv->gswip.dev = dev;
> +	priv->gswip.hw_info = of_device_get_match_data(dev);
> +	if (!priv->gswip.hw_info)
> +		return -EINVAL;
> +
> +	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
> +					       GSW1XX_SWITCH_BASE, 0xfff);
> +	if (IS_ERR(priv->gswip.gswip))
> +		return PTR_ERR(priv->gswip.gswip);
> +
> +	priv->gswip.mdio = gsw1xx_regmap_init(priv, "mdio", GSW1XX_MMDIO_BASE,
> +					      0xff);
> +	if (IS_ERR(priv->gswip.mdio))
> +		return PTR_ERR(priv->gswip.mdio);
> +
> +	priv->gswip.mii = gsw1xx_regmap_init(priv, "mii", GSW1XX_RGMII_BASE,
> +					     0xff);
> +	if (IS_ERR(priv->gswip.mii))
> +		return PTR_ERR(priv->gswip.mii);
> +
> +	priv->sgmii = gsw1xx_regmap_init(priv, "sgmii", GSW1XX_SGMII_BASE,
> +					 0xfff);
> +	if (IS_ERR(priv->sgmii))
> +		return PTR_ERR(priv->sgmii);
> +
> +	priv->gpio = gsw1xx_regmap_init(priv, "gpio", GSW1XX_GPIO_BASE, 0xff);
> +	if (IS_ERR(priv->gpio))
> +		return PTR_ERR(priv->gpio);
> +
> +	priv->clk = gsw1xx_regmap_init(priv, "clk", GSW1XX_CLK_BASE, 0xff);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->shell = gsw1xx_regmap_init(priv, "shell", GSW1XX_SHELL_BASE,
> +					 0xff);
> +	if (IS_ERR(priv->shell))
> +		return PTR_ERR(priv->shell);
> +
> +	priv->sgmii_pcs.ops = &gsw1xx_sgmii_pcs_ops;
> +	priv->sgmii_pcs.poll = 1;

This is declared as a C99 'bool'. It takes true/false values in
preference to 0/1.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

