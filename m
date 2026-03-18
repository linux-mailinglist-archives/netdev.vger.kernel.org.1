Return-Path: <netdev+bounces-269049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNEJI+C7ummqbQIAu9opvQ
	(envelope-from <netdev+bounces-269049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:51:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BA2BD89C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 470AC3026506
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D263E0C42;
	Wed, 18 Mar 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNEXEXFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F703E0244;
	Wed, 18 Mar 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845231; cv=none; b=m15NT7Xs9l6ueOIe2taveL9ggq+SxfT90FtPO7g/6ThLHdHzRB30F2qeWI/SOpHkHIVg/M31n5Gu4XbMVVIrFT10YYR4UcBOBD4I+RNvcymZLsVC1buuwRGkvWXyUR9TbxQljs+OClDA7as3Qw7fFuGGo9NpSA7oTGpBtirLapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845231; c=relaxed/simple;
	bh=sOGhleK/nOFjGylRZPX91uK0mo+r2D9Kaglk5zGCV1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcIuTbDSTGG6VTb5DooQgxFEl/n6mZWaoNO8diLTGVqkdIjdnygfMaZbY7g4gjDH2INBaNswhnzUEjFxZAzUZKBnvIqRB19974hN7MCYkT1lyHWC0HZ3y1QNCnr3P3u4Hi0JLqLBoNtKEvIkOXpKPDOugDbtSo+1MtMC73TaKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNEXEXFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE2C19421;
	Wed, 18 Mar 2026 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845231;
	bh=sOGhleK/nOFjGylRZPX91uK0mo+r2D9Kaglk5zGCV1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNEXEXFHtHqqr5+jSR8/WPIZ+t95wCNVVoFyFK6S3X5ngF1Z0hz/dGpE0/8EVWyzB
	 7mFxzM+0bUnUaAhTlEuc+9AknVBfSI9p5RHBxJWrrAvHGw/j+0E6tA3hZYfaqyW8OI
	 3qeaNgswbe4lvpsnrdMYYgKytxx1PEPv7MSrbOGaa3g8CmFStN9NXTdAjn8hQtLhjO
	 8VQ1bPGUgw/WxjL8g9punuvgQVYnky6+kVtBTz+q+WuZUomr0+eYyGnze5a5zLO7rs
	 Xul8ho2Ds77F5cnV2Odc+IaNBY2ZPyljYTpCY3FqWe/wRWhVHahuEr8FNWykrSONbu
	 lV9haUJJi9Hxg==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	f.fainelli@gmail.com,
	krzk+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux@armlinux.org.uk,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	chleroy@kernel.org,
	edumazet@google.com,
	frank.li@nxp.com,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	robh@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Subject: Re: [net-next,11/14] net: dsa: netc: add phylink MAC operations
Date: Wed, 18 Mar 2026 14:46:51 +0000
Message-ID: <20260318144651.1891670-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-12-wei.fang@nxp.com>
References: <20260316094152.1558671-12-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,nxp.com,lists.infradead.org,armlinux.org.uk,redhat.com,google.com,lists.ozlabs.org,davemloft.net,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-269049-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.941];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E1BA2BD89C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: add phylink MAC operations

This commit adds phylink MAC operations to the NETC DSA switch driver,
including support for different PHY interface modes (RGMII, RMII, MII,
REVMII, SGMII, 2500BASE-X).

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index bc7d48b99610..884ee899fc89 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -595,10 +595,221 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
>  	priv->revision = val & IPBRR0_IP_REV;
>  }
>
> +static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
> +				  struct phylink_config *config)
> +{
> +	struct netc_switch *priv = ds->priv;
> +
> +	priv->info->phylink_get_caps(port, config);
> +}
> +
> +static void netc_port_set_mac_mode(struct netc_port *np,
> +				   unsigned int mode,
> +				   phy_interface_t phy_mode)
> +{
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= IFMODE_RGMII;
> +		/* Enable auto-negotiation for the MAC if its
> +		 * RGMII interface supports In-Band status.
> +		 */
> +		if (phylink_autoneg_inband(mode))
> +			val |= PM_IF_MODE_ENA;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		val |= IFMODE_RMII;
> +		break;
> +	case PHY_INTERFACE_MODE_REVMII:
> +		val |= PM_IF_MODE_REVMII;
> +		fallthrough;
> +	case PHY_INTERFACE_MODE_MII:
> +		val |= IFMODE_MII;
> +		break;

Does the mask need to include PM_IF_MODE_REVMII? Looking at
netc_port_set_mac_mode(), the mask is set to:

    u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;

which expands to GENMASK(2,0) | BIT(15) = 0x8007. When the REVMII
case sets val |= PM_IF_MODE_REVMII (BIT(3)), this makes val = 0x9.

In netc_mac_port_rmw(), there's a check:

    WARN_ON((mask | val) != mask)

This check would fire on every REVMII configuration since 0x800F != 0x8007.

Additionally, REVMII is reachable because imx94_switch_phylink_get_caps()
advertises PHY_INTERFACE_MODE_REVMII as supported for port 2. When
transitioning FROM REVMII to another mode, PM_IF_MODE_REVMII (BIT(3))
won't be cleared since it's not in the mask, leaving stale configuration.

Should the mask be:

    u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII | PM_IF_MODE_ENA;

> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		val |= IFMODE_SGMII;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}

[ ... ]

> +static void netc_port_force_set_rgmii_mac(struct netc_port *np,
> +					  int speed, int duplex)
> +{
> +	u32 mask, val;
> +
> +	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
> +	       PM_IF_MODE_M10 | PM_IF_MODE_REVMII;
> +
> +	switch (speed) {
> +	default:
> +	case SPEED_1000:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
> +		break;
> +	case SPEED_100:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
> +		break;
> +	case SPEED_10:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
> +		break;
> +	}
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}
> +
> +static void net_port_set_rmii_mii_mac(struct netc_port *np,

This isn't a bug, but should this function be named
netc_port_set_rmii_mii_mac() instead of net_port_set_rmii_mii_mac()?
All other functions in this driver use the netc_ prefix
(netc_port_set_speed, netc_port_force_set_rgmii_mac,
netc_port_set_mac_mode, etc.).

> +				      int speed, int duplex)
> +{
> +	u32 mask, val = 0;
> +
> +	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
> +	       PM_IF_MODE_M10;
> +
> +	if (speed == SPEED_10)
> +		val |= PM_IF_MODE_M10;
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}

[ ... ]

> +static void netc_mac_link_up(struct phylink_config *config,
> +			     struct phy_device *phy, unsigned int mode,
> +			     phy_interface_t interface, int speed,
> +			     int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct netc_port *np;
> +
> +	np = NETC_PORT(dp->ds, dp->index);
> +	netc_port_set_speed(np, speed);
> +
> +	if (phy_interface_mode_is_rgmii(interface) &&
> +	    !phylink_autoneg_inband(mode)) {
> +		netc_port_force_set_rgmii_mac(np, speed, duplex);
> +	}
> +
> +	if (interface == PHY_INTERFACE_MODE_RMII ||
> +	    interface == PHY_INTERFACE_MODE_REVMII ||
> +	    interface == PHY_INTERFACE_MODE_MII) {
> +		net_port_set_rmii_mii_mac(np, speed, duplex);
> +	}
> +
> +	netc_port_set_hd_flow_control(np, duplex == DUPLEX_HALF);
> +	netc_port_mac_rx_enable(np);
> +}
> +
> +static void netc_mac_link_down(struct phylink_config *config,
> +			       unsigned int mode,
> +			       phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	netc_port_mac_rx_graceful_stop(NETC_PORT(dp->ds, dp->index));
> +}
> +
> +static const struct phylink_mac_ops netc_phylink_mac_ops = {
> +	.mac_config		= netc_mac_config,
> +	.mac_link_up		= netc_mac_link_up,
> +	.mac_link_down		= netc_mac_link_down,
> +};
> +
>  static const struct dsa_switch_ops netc_switch_ops = {
>  	.get_tag_protocol		= netc_get_tag_protocol,
>  	.setup				= netc_setup,
>  	.teardown			= netc_teardown,
> +	.phylink_get_caps		= netc_phylink_get_caps,
>  };
>
>  static int netc_switch_probe(struct pci_dev *pdev,
> @@ -639,6 +850,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
>  	ds->num_ports = priv->info->num_ports;
>  	ds->num_tx_queues = NETC_TC_NUM;
>  	ds->ops = &netc_switch_ops;
> +	ds->phylink_mac_ops = &netc_phylink_mac_ops;
>  	ds->priv = priv;
>
>  	priv->ds = ds;

[ ... ]

