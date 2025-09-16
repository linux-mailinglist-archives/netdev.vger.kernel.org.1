Return-Path: <netdev+bounces-223312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB2B58B42
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492B61B23FB2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934521DE8AF;
	Tue, 16 Sep 2025 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FQtlvW6b"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E7A926;
	Tue, 16 Sep 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986367; cv=none; b=sziu1UBvcXvWe66GQlF+leD+ycoeGPiHqJtv1lw6PVqHTmfIeRA8bpXJPTVAdulLvKryQSu5VgIEu/n5C+ekDkCjFW3vkEZJy0zNAfOPfMZbwQz768nL8xw2ozA7pOlryQIZX0rk5rysaSR4tdJl/kg3ibv6XAlsSKlmhNta/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986367; c=relaxed/simple;
	bh=G1WqzWtXUB4zxrQCn6edtkHVKrL8Cb+GbqttULeM1Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNLoF4pqg8ECU5z3zaAddMGWlR50MBU+qjcXL6KQYmd+Gn9UhUKVBTYaxQBOmuD2cSJEL5iPtR1HuNjVM+RpAFave0dla86i97WepkWq3FL0zFTJm+72mUdOZNg8x4nKCqYd/BsEw6vADex1DRSI3Hdo1y6K4CxFNu14haE9oaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FQtlvW6b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oY14XZ2Z7z++1I8o6fF7rrev0IZz53dJj48DzfI0j2E=; b=FQtlvW6bR59oA8scA/LGP+uw3x
	KUJAaEcCAxxK0vUyS7ygP1a331P0rRqvA1+/+ixseo4QTwNZPhHtWCVuprBdawyfVpdLy51YuEhu2
	wAlbAYevJOnL0KvxGtEwv5vsXTMiD8Nsl9qWuYRo9JuaUIKBMNX0zkUzNnzEVxONqefE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyKYc-008VSo-HB; Tue, 16 Sep 2025 03:32:34 +0200
Date: Tue, 16 Sep 2025 03:32:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <daccdb60-1503-4fcc-87dc-754fb8bf9109@lunn.ch>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913044404.63641-4-mmyangfl@gmail.com>

> +static int
> +yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		ctrl = YT921X_PORT_SPEED_10;
> +		break;
> +	case SPEED_100:
> +		ctrl = YT921X_PORT_SPEED_100;
> +		break;
> +	case SPEED_1000:
> +		ctrl = YT921X_PORT_SPEED_1000;
> +		break;
> +	case SPEED_10000:
> +		ctrl = YT921X_PORT_SPEED_10000;
> +		break;
> +	case SPEED_2500:
> +		ctrl = YT921X_PORT_SPEED_2500;
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported speed %d\n", speed);
> +		/* compile complains about uninitialized variable */
> +		ctrl = 0;
> +		break;

If this should not happen, it is better to return -EINVAL.

I would also suggest sorting these numerically. 10G after 2.5G.

> +	}
> +	if (duplex == DUPLEX_FULL)
> +		ctrl |= YT921X_PORT_DUPLEX_FULL;
> +	if (tx_pause)
> +		ctrl |= YT921X_PORT_TX_PAUSE;
> +	if (rx_pause)
> +		ctrl |= YT921X_PORT_RX_PAUSE;
> +	ctrl |= YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
> +	res = yt921x_reg_write(priv, YT921X_PORTn_CTRL(port), ctrl);
> +	if (res)
> +		return res;
> +
> +	if (yt921x_port_is_external(port)) {
> +		mask = YT921X_SGMII_SPEED_M;
> +		switch (speed) {
> +		case SPEED_10:
> +			ctrl = YT921X_SGMII_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			ctrl = YT921X_SGMII_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			ctrl = YT921X_SGMII_SPEED_1000;
> +			break;
> +		case SPEED_10000:
> +			ctrl = YT921X_SGMII_SPEED_10000;
> +			break;
> +		case SPEED_2500:
> +			ctrl = YT921X_SGMII_SPEED_2500;
> +			break;
> +		default:
> +			ctrl = 0;
> +			break;

Same here.

> +		}
> +		mask |= YT921X_SGMII_DUPLEX_FULL;
> +		if (duplex == DUPLEX_FULL)
> +			ctrl |= YT921X_SGMII_DUPLEX_FULL;
> +		mask |= YT921X_SGMII_TX_PAUSE;
> +		if (tx_pause)
> +			ctrl |= YT921X_SGMII_TX_PAUSE;
> +		mask |= YT921X_SGMII_RX_PAUSE;
> +		if (rx_pause)
> +			ctrl |= YT921X_SGMII_RX_PAUSE;
> +		mask |= YT921X_SGMII_LINK;
> +		ctrl |= YT921X_SGMII_LINK;
> +		res = yt921x_reg_update_bits(priv, YT921X_SGMIIn(port),
> +					     mask, ctrl);
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_XMII_LINK;
> +		res = yt921x_reg_set_bits(priv, YT921X_XMIIn(port), mask);
> +		if (res)
> +			return res;
> +
> +		switch (speed) {
> +		case SPEED_10:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_1000;
> +			break;
> +		case SPEED_10000:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_10000;
> +			break;
> +		case SPEED_2500:
> +			ctrl = YT921X_MDIO_POLLING_SPEED_2500;
> +			break;
> +		default:
> +			ctrl = 0;
> +			break;

and again.


> +static int
> +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> +		   phy_interface_t interface)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	if (!yt921x_port_is_external(port)) {
> +		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
> +			dev_err(dev, "Wrong mode %d on port %d\n",
> +				interface, port);
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	switch (interface) {
> +	/* SGMII */
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:

This comment is wrong. Only the first is SGMII.

> +static void
> +yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	int port = dp->index;
> +	int res;
> +
> +	cancel_delayed_work(&priv->ports[port].mib_read);

Should that be cancel_delayed_work_sync() ? Does it matter if the work
is running on a different CPU?

> +static void
> +yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
> +			    struct phylink_config *config)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	const struct yt921x_info *info = priv->info;
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000;
> +
> +	if ((info->internal_mask & BIT(port)) != 0) {
> +		/* Port 10 for MCU should probably go here too. But since that
> +		 * is untested yet, turn it down for the moment by letting it
> +		 * fall to the default branch.
> +		 */
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +	} else if ((info->external_mask & BIT(port)) != 0) {
> +		/* TODO: external ports may support SGMII only, XMII only, or
> +		 * SGMII + XMII depending on the chip. However, we can't get
> +		 * the accurate config table due to lack of document, thus
> +		 * we simply declare SGMII + XMII and rely on the correctness
> +		 * of devicetree for now.
> +		 */
> +
> +		/* SGMII */
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_100BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_2500FD;

And again

> +static int yt921x_chip_detect(struct yt921x_priv *priv)
> +{
> +	struct device *dev = to_device(priv);
> +	const struct yt921x_info *info;
> +	u8 extmode;
> +	u32 chipid;
> +	u32 major;
> +	u32 mode;
> +	int res;
> +
> +	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
> +	if (res)
> +		return res;
> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +
> +	for (info = yt921x_infos; info->name; info++)
> +		if (info->major == major)
> +			goto found_major;
> +
> +	dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
> +	return -ENODEV;
> +
> +found_major:
> +	res = yt921x_reg_read(priv, YT921X_CHIP_MODE, &mode);
> +	if (res)
> +		return res;
> +	res = yt921x_edata_read(priv, YT921X_EDATA_EXTMODE, &extmode);
> +	if (res)
> +		return res;
> +
> +	for (; info->name; info++)
> +		if (info->major == major && info->mode == mode &&
> +		    info->extmode == extmode)
> +			goto found_chip;
> +
> +	dev_err(dev, "Unsupported chipid 0x%x with chipmode 0x%x 0x%x\n",
> +		chipid, mode, extmode);
> +	return -ENODEV;
> +
> +found_chip:
> +	/* Print chipid here since we are interested in lower 16 bits */
> +	dev_info(dev,
> +		 "Motorcomm %s ethernet switch, chipid: 0x%x, "
> +		 "chipmode: 0x%x 0x%x\n",
> +		 info->name, chipid, mode, extmode);
> +
> +	priv->info = info;
> +	return 0;

The use of gotos here is backwards to normal. They are pretty much
only used in Linux to jump to the end to do cleanup on error. I don't
know of any other driver which uses goto on success. Please change
this.

> +	/* Register the internal mdio bus. Nodes for internal ports should have
> +	 * proper phy-handle pointing to their PHYs. Not enabling the internal
> +	 * bus is possible, though pretty wired, if internal ports are not used.

weird, not wired. 

    Andrew

---
pw-bot: cr

