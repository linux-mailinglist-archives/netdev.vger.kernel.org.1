Return-Path: <netdev+bounces-254782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEr1Iw5Te2nRDwIAu9opvQ
	(envelope-from <netdev+bounces-254782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:31:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6EFB0120
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65C0630120F2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F6285C80;
	Thu, 29 Jan 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H5bTkDZO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771119F135;
	Thu, 29 Jan 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689865; cv=none; b=OKo8tH7QllgqE6RMJPWDOXoGCE0jxuEdAPinGFxvVqhJi8cHu4SoFIXe7UeNaiFwQ5tcMbrIeZ9U1UDi9J38UZy0yKYfIIZSQ+UfbhAwSfzqx4AFAylDO21ngdPnMeFiO0E4hf0d45n8UYAAXR5VgDQZ7e3fhy0+VP5u3FVxx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689865; c=relaxed/simple;
	bh=Ezgjf3HNBlK6ULVIu3q6aD7kL5SR71nA6GX8cZl1c1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiuEx9QLSEPrm9QBxnXg7HMAvlp7ToSAIstmUyH9Wqsp5MuyUHSVuweJyJZQq5zzL9wzs78vcleikPQOgCWU2rruHd+p+GyasjBucEUy8kp/dti+htMydKzO+hCzTi5Ub6xXxTjuAy0b6nb54quZlrHm2q/+UOIJCY0W58inYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H5bTkDZO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/UbOPmiGUE8d97rtMWaWw7ob/TEhIfpkNDFbJPKxO3E=; b=H5bTkDZOpfGmqdIl3EsQqY/tVE
	ZPNsPGO/JrEFVVUgxK1n4KpWSn9C0TRWMGMO6wKvGFQsC3yjpsBCtq0HQbJJAxrgay0qypb5++X+N
	AeIDoNrotYbB/J6l1S8JLKOf6xuYw2sCzaWGtbtbixxy5AFlIqUQfHE+od08y4iFUZGJSisQO22i2
	HTrzZWra8X2gu714vdUGRfmXL686jtvh10cMIQy80+z0qxfYyRmnLdDLDD6OyowsejnpAjHNUiDjh
	xws/nmWZk8Q9mcZ1Afatr2K+1a/AjOB9kLD/YxI9YuyCp5Mcgs8la2287Cvqop2jYeAVXUe5M2IfX
	ebnL6FMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47446)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlRAi-000000008V3-1xqK;
	Thu, 29 Jan 2026 12:30:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlRAg-000000007xk-05ol;
	Thu, 29 Jan 2026 12:30:50 +0000
Date: Thu, 29 Jan 2026 12:30:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com,
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 3/4] phy: s32g: Add serdes xpcs subsystem
Message-ID: <aXtS-Yan4HkXZlDD@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-4-vincent.guittot@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-254782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,armlinux.org.uk:url,nxp.com:email]
X-Rspamd-Queue-Id: 7B6EFB0120
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:58AM +0100, Vincent Guittot wrote:
> s32g SoC family includes 2 serdes subsystems which are made of one PCIe
> controller, 2 XPCS and one Phy. The Phy got 2 lanes that can be configure
> to output PCIe lanes and/or SGMII.
> 
> Add XPCS and SGMII support.
> 
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

I'm not doing a full review for this patch yet.

> +/*
> + * Note: This function should be compatible with phylink.
> + * That means it should only modify link, duplex, speed
> + * an_complete, pause.
> + */
> +static int s32g_xpcs_get_state(struct s32g_xpcs *xpcs,
> +			       struct phylink_link_state *state)
> +{
> +	struct device *dev = xpcs->dev;
> +	unsigned int mii_ctrl, val, ss;
> +	bool ss6, ss13, an_enabled, intr_en;
> +
> +	mii_ctrl = s32g_xpcs_read(xpcs, SR_MII_CTRL);
> +	an_enabled = !!(mii_ctrl & AN_ENABLE);
> +	intr_en = !!(s32g_xpcs_read(xpcs, VR_MII_AN_CTRL) & MII_AN_INTR_EN);
> +
> +	/* Check this important condition */
> +	if (an_enabled && !intr_en) {
> +		dev_err(dev, "Invalid SGMII AN config interrupt is disabled\n");
> +		return -EINVAL;
> +	}

This isn't an interrupt handler. Phylink calls it from the state
resolver, which _may_ be triggered by an interrupt handler, but will
also be called at other times.

> +
> +	if (an_enabled) {
> +		/* MLO_AN_INBAND */
> +		state->speed = SPEED_UNKNOWN;
> +		state->link = 0;
> +		state->duplex =  DUPLEX_UNKNOWN;
> +		state->an_complete = 0;
> +		state->pause = MLO_PAUSE_NONE;

Have you looked at the initial state that phylink sets up before
calling the .pcs_get_state() method? See phylink_mac_pcs_get_state().

speed/duplex/pause/an_complete are already setup like that for you if
autoneg is enabled. link is the only member you'd need to touch.

> +		val = s32g_xpcs_read(xpcs, VR_MII_AN_INTR_STS);
> +
> +		/* Interrupt is raised with each SGMII AN that is in cases
> +		 * Link down - Every SGMII link timer expire
> +		 * Link up - Once before link goes up
> +		 * So either linkup or raised interrupt mean AN was completed
> +		 */
> +		if ((val & CL37_ANCMPLT_INTR) || (val & CL37_ANSGM_STS_LINK)) {
> +			state->an_complete = 1;
> +			if (val & CL37_ANSGM_STS_LINK)
> +				state->link = 1;
> +			else
> +				return 0;
> +			if (val & CL37_ANSGM_STS_DUPLEX)
> +				state->duplex = DUPLEX_FULL;
> +			else
> +				state->duplex = DUPLEX_HALF;
> +			ss = FIELD_GET(CL37_ANSGM_STS_SPEED_MASK, val);
> +		} else {
> +			return 0;
> +		}
> +
> +	} else {
> +		/* MLO_AN_FIXED, MLO_AN_PHY */

This function won't be called in those modes, so this is a misleading
comment. It can be called in MLO_AN_INBAND but when autoneg is disabled.

> +		val = s32g_xpcs_read(xpcs, SR_MII_STS);
> +		state->link = !!(val & LINK_STS);
> +		state->an_complete = 0;
> +		state->pause = MLO_PAUSE_NONE;
> +
> +		if (mii_ctrl & DUPLEX_MODE)
> +			state->duplex = DUPLEX_FULL;
> +		else
> +			state->duplex = DUPLEX_HALF;
> +
> +		/*
> +		 * Build similar value as CL37_ANSGM_STS_SPEED with
> +		 * SS6 and SS13 of SR_MII_CTRL:
> +		 *   - 0 for 10 Mbps
> +		 *   - 1 for 100 Mbps
> +		 *   - 2 for 1000 Mbps
> +		 */
> +		ss6 = !!(mii_ctrl & SS6);
> +		ss13 = !!(mii_ctrl & SS13);
> +		ss = ss6 << 1 | ss13;
> +	}
> +
> +	switch (ss) {
> +	case CL37_ANSGM_10MBPS:
> +		state->speed = SPEED_10;
> +		break;
> +	case CL37_ANSGM_100MBPS:
> +		state->speed = SPEED_100;
> +		break;
> +	case CL37_ANSGM_1000MBPS:
> +		state->speed = SPEED_1000;
> +		break;
> +	default:
> +		dev_err(dev, "Failed to interpret the value of SR_MII_CTRL\n");
> +		break;
> +	}
> +
> +	val = s32g_xpcs_read(xpcs, VR_MII_DIG_CTRL1);
> +	if ((val & EN_2_5G_MODE) && state->speed == SPEED_1000)
> +		state->speed = SPEED_2500;
> +
> +	/* Cover SGMII AN inability to distigunish between 1G and 2.5G */
> +	if ((val & EN_2_5G_MODE) &&
> +	    state->speed != SPEED_2500 && an_enabled) {
> +		dev_err(dev, "Speed not supported in SGMII AN mode\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int s32g_xpcs_config_an(struct s32g_xpcs *xpcs,
> +			       const struct phylink_link_state state)
> +{
> +	bool an_enabled = false;
> +
> +	an_enabled = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +				       state.advertising);
> +	if (!an_enabled)
> +		return 0;

Don't check the autoneg bit. This is the media-side autoneg, not
the PCS autoneg.

> +
> +	s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> +			     CL37_TMR_OVRRIDE, CL37_TMR_OVRRIDE);
> +
> +	s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
> +			     PCS_MODE_MASK | MII_AN_INTR_EN,
> +			     FIELD_PREP(PCS_MODE_MASK, PCS_MODE_SGMII) | MII_AN_INTR_EN);
> +	/* Enable SGMII AN */
> +	s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, AN_ENABLE);
> +	/* Enable SGMII AUTO SW */
> +	s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> +			     MAC_AUTO_SW, MAC_AUTO_SW);
> +
> +	return 0;
> +}
> +
> +static int s32g_xpcs_config(struct s32g_xpcs *xpcs,
> +			    const struct phylink_link_state state)
> +{
> +	struct device *dev = xpcs->dev;
> +	unsigned int val = 0, duplex = 0;
> +	int ret = 0;
> +	int speed = state.speed;
> +	bool an_enabled;
> +
> +	/* Configure adaptive MII width */
> +	s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_CTRL, 0);
> +
> +	an_enabled = !!(s32g_xpcs_read(xpcs, SR_MII_CTRL) & AN_ENABLE);
> +
> +	dev_dbg(dev, "xpcs_%d: speed=%u duplex=%d an=%d\n", xpcs->id,
> +		speed, state.duplex, an_enabled);
> +
> +	if (an_enabled) {
> +		switch (speed) {
> +		case SPEED_10:
> +		case SPEED_100:
> +		case SPEED_1000:
> +			s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x2faf);
> +			break;
> +		case SPEED_2500:
> +			s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x7a1);
> +			s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, MAC_AUTO_SW, 0);

Configuring the link timer _after_ the link has already come up looks
completely wrong to me... this should be done when .pcs_config() detects
that the PHY interface mode has changed.

> +			break;
> +		default:
> +			dev_err(dev, "Speed not recognized. Can't setup xpcs\n");
> +			return -EINVAL;
> +		}
> +
> +		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, RESTART_AN, RESTART_AN);

As this is called from the .pcs_link_up() method, expect the link to
go bouncey bouncy bouncy if you restart AN _after_ the link has
come up.

> +
> +		ret = s32g_xpcs_wait_an_done(xpcs);
> +		if (ret)
> +			dev_warn(dev, "AN did not finish for XPCS%d", xpcs->id);
> +
> +		/* Clear the AN CMPL intr */
> +		s32g_xpcs_write_bits(xpcs, VR_MII_AN_INTR_STS, CL37_ANCMPLT_INTR, 0);
> +	} else {
> +		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
> +		s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_AN_INTR_EN, 0);
> +
> +		switch (speed) {
> +		case SPEED_10:
> +			break;
> +		case SPEED_100:
> +			val = SS13;
> +			break;
> +		case SPEED_1000:
> +			val = SS6;
> +			break;
> +		case SPEED_2500:
> +			val = SS6;
> +			break;
> +		default:
> +			dev_err(dev, "Speed not supported\n");
> +			break;
> +		}
> +
> +		if (state.duplex == DUPLEX_FULL)
> +			duplex = DUPLEX_MODE;
> +
> +		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, duplex);
> +
> +		if (speed == SPEED_2500) {
> +			ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLB);
> +			if (ret)
> +				dev_err(dev, "Switch to PLLB failed\n");
> +		} else {
> +			ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLA);
> +			if (ret)
> +				dev_err(dev, "Switch to PLLA failed\n");
> +		}
> +
> +		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, SS6 | SS13, val);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * phylink_pcs_ops fops

They are not "fops" which commonly refers to struct file_operations

> + */
> +
> +static void s32cc_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> +					struct phylink_link_state *state)
> +{
> +	struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
> +
> +	s32g_xpcs_get_state(xpcs, state);
> +}

Seems to me a pointless wrapper.

> +
> +static int s32cc_phylink_pcs_config(struct phylink_pcs *pcs,
> +				    unsigned int neg_mode,
> +				    phy_interface_t interface,
> +				    const unsigned long *advertising,
> +				    bool permit_pause_to_mac)
> +{
> +	struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
> +	struct phylink_link_state state  = { 0 };
> +
> +	if (!(neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED))
> +		return 0;
> +
> +	linkmode_copy(state.advertising, advertising);
> +
> +	return s32g_xpcs_config_an(xpcs, state);

Given this is the only callsite for this function, and the only thing
you pass is the advertising mask, why pass a struct phylink_link_state
rather than the advertising mask?

> +}
> +
> +static void s32cc_phylink_pcs_restart_an(struct phylink_pcs *pcs)
> +{
> +	/* Not yet */
> +}
> +
> +static void s32cc_phylink_pcs_link_up(struct phylink_pcs *pcs,
> +				      unsigned int neg_mode,
> +				      phy_interface_t interface, int speed,
> +				      int duplex)
> +{
> +	struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
> +	struct phylink_link_state state = { 0 };
> +
> +	state.speed = speed;
> +	state.duplex = duplex;
> +	state.an_complete = false;

an_complete is never an "input" to drivers. It's a state from PCS
drivers back to phylink. Also, s32g_xpcs_config never looks at this.

> +
> +	s32g_xpcs_config(xpcs, state);

Again, the only things that this function uses are the speed and
duplex, so why wrap them up into a struct?

> +}
> +
> +static const struct phylink_pcs_ops s32cc_phylink_pcs_ops = {
> +	.pcs_get_state = s32cc_phylink_pcs_get_state,
> +	.pcs_config = s32cc_phylink_pcs_config,
> +	.pcs_an_restart = s32cc_phylink_pcs_restart_an,
> +	.pcs_link_up = s32cc_phylink_pcs_link_up,
> +};

Please implement .pcs_inband_caps. As you don't support disabling
inband for SGMII, that means you can't support MLO_AN_PHY mode
reliably.

Also note that there are PHYs out there that do _not_ provide SGMII
inband, which means if you have it enabled, and you're relying on it
to complete, you won't be able to interface with those PHYs. There's
such a PHY on a SFP module.

If this driver is purely for a network PCS, then please locate it in
drivers/net/pcs.

I'm pretty sure there's other stuff I've missed as far as the phylink
API goes, so please expect further review once you've addressed the
comments above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

