Return-Path: <netdev+bounces-284653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOMwOHmd+mk+QQMAu9opvQ
	(envelope-from <netdev+bounces-284653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:46:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480054D5657
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02183303F053
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF2280325;
	Wed,  6 May 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI8fD7N3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCA27FD49;
	Wed,  6 May 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031957; cv=none; b=bizeA+fBmi+ZUVEJjhENtawAQ/68xbY4LdlvNdAp/U1Zid/VUE4BKSsQLnUDdmrMwacy/hl/zfwT0kF/+nGTLsTfyjKnrA/3faL4bOaYHRmpu8hQD5wZxXMN1fD3Vvozs7HPd/Jh77qFMHM4g78RobiB/fwmdRn4rk2mckofL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031957; c=relaxed/simple;
	bh=J8HiwRQgEJs3xRquXR3TNrdCUXYnZuF7/eaDi1afRuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNLNgcTjVIHHoxhfAUO08Ft7KJgjy1pNB9LcCJ73qdQrQ9R0mFvSGuqPSy+Hcn2fuiUPIQMbSK01Eppekp8koP6kvQJnLJGdsxP746hsZHqV7vqkduNd7sp2nZ5Ubm/BrvTai2EHzA085fJ88EgnCFRihB93JsAAu5DmNuGmYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI8fD7N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C22C2BCB9;
	Wed,  6 May 2026 01:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031957;
	bh=J8HiwRQgEJs3xRquXR3TNrdCUXYnZuF7/eaDi1afRuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SI8fD7N3i+Pm8twjPez31E9Q5hb5Q9Q2vZ5HeBed8pgnwSUMJP9ZDAH6czO+fBTUk
	 UaMB0JuWXVOjZJoIqfbOEJB4xI7wDGMu2nVs76pKuh7+Ufd4zV3Bhp0XhlhW+ypVgw
	 emcE89asv69lVxsmzrKEfzPHOJ6yXua4CBJAKSjieTPgs+j7VHm+2IKtAml0Nn4yjR
	 Myca/AuIutW0vJZl6YKfDlvLwsMFCw0Yhoj2khMd3G95OTxMNKwSScQGSjCW5khJAA
	 6zKz1QZAGHWNaLwOor+l53oQDqiApWSUHDgd/cy7NWrujUql3/erMFW0oRcYZ6sEOi
	 B01TpPfN/jJzA==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/9] net: dsa: lan9645x: add basic dsa driver for LAN9645X
Date: Tue,  5 May 2026 18:45:55 -0700
Message-ID: <20260506014555.1616575-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-4-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-4-f1b6005fa8b7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 480054D5657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-284653-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add basic dsa driver for LAN9645X

This patch introduces a new DSA driver for the Microchip LAN9645X switch
family, covering probe/setup/teardown, NPI CPU port wiring, per-port
initialisation, and phylink MAC integration. A few questions inline.

> diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig b/drivers/net/dsa/microchip/lan9645x/Kconfig
> new file mode 100644
> index 000000000000..4d9fdf34104e
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NET_DSA_MICROCHIP_LAN9645X
> +	tristate "Microchip Lan9645x switch support"
> +	depends on NET_DSA
> +	select NET_DSA_TAG_LAN9645X
> +	help
> +	  This driver adds DSA support for Microchip Lan9645x switch chips.

The driver is non-functional without a parent MFD that registers the named
regmaps ("gcb", "qs", "chip_top", "rew", "sys", "hsio", "dev", "dev1" ..
"dev8", "qsys", "afi", "ana") consumed by lan9645x_request_target_regmaps().

Should this Kconfig depend on the parent provider symbol so that selecting
this option without the parent driver does not produce a module whose probe
always fails?

Is there a companion parent-driver patch this patch depends on? If so,
would it be worth naming it in the commit message and documenting the
ordering?

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> new file mode 100644
> index 000000000000..6fd66ea67cfd
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -0,0 +1,423 @@

[ ... ]

> +static const char *lan9645x_resource_names[NUM_TARGETS + 1] = {
> +	[TARGET_GCB]          = "gcb",
> +	[TARGET_QS]           = "qs",
> +	[TARGET_CHIP_TOP]     = "chip_top",
> +	[TARGET_REW]          = "rew",
> +	[TARGET_SYS]          = "sys",
> +	[TARGET_HSIO]         = "hsio",
> +	[TARGET_DEV]          = "dev",
> +	[TARGET_DEV + 1]      = "dev1",
> +	[TARGET_DEV + 2]      = "dev2",
> +	[TARGET_DEV + 3]      = "dev3",
> +	[TARGET_DEV + 4]      = "dev4",
> +	[TARGET_DEV + 5]      = "dev5",
> +	[TARGET_DEV + 6]      = "dev6",
> +	[TARGET_DEV + 7]      = "dev7",
> +	[TARGET_DEV + 8]      = "dev8",

The first DEV instance is named "dev", while the rest are "dev1" through
"dev8". Is this asymmetry intentional, or should the first be "dev0" to
match the natural per-port numbering? Without the parent driver available
in this series, it is hard to tell which naming scheme the parent actually
registers.

If the parent registers "dev0".."dev8" then dev_get_regmap(parent, "dev")
returns NULL and probe fails with -ENODEV.

[ ... ]

> +static void lan9645x_set_feat_dis(struct lan9645x *lan9645x)
> +{
> +	u32 feat_dis;
> +
> +	/* The features which can be physically disabled on some SKUs are:
> +	 * 1) Number of ports can be 5, 7 or 9. Any ports can be used, the chip
> +	 *    tracks how many are active.
> +	 * 2) HSR/PRP. The duplicate discard table can be disabled.
> +	 * 3) TAS, frame preemption and PSFP can be disabled.
> +	 */
> +	feat_dis = lan_rd(lan9645x, GCB_FEAT_DISABLE);
> +
> +	lan9645x->num_port_dis =
> +		GCB_FEAT_DISABLE_FEAT_NUM_PORTS_DIS_GET(feat_dis);
> +	lan9645x->dd_dis = GCB_FEAT_DISABLE_FEAT_DD_DIS_GET(feat_dis);
> +	lan9645x->tsn_dis = GCB_FEAT_DISABLE_FEAT_TSN_DIS_GET(feat_dis);
> +}

Where are num_port_dis, dd_dis and tsn_dis consulted after this read?

ds->num_ports is hardcoded to NUM_PHYS_PORTS (9) in lan9645x_probe(), and
there does not appear to be any rejection of TSN or HSR/PRP configuration
on SKUs where tsn_dis=1 or dd_dis=1 in this patch. On a 5-port SKU
(num_port_dis=4), would the driver still register 9 DSA ports and allow
DT to bring up a fused-off port?

> +static int lan9645x_setup(struct dsa_switch *ds)
> +{

[ ... ]

> +	dev_info(lan9645x->dev,
> +		 "SKU features: tsn_dis=%d hsr_dis=%d max_ports=%d\n",
> +		 lan9645x->tsn_dis, lan9645x->dd_dis,
> +		 lan9645x->num_phys_ports - lan9645x->num_port_dis);

The log prints the field called dd_dis in struct lan9645x under the name
hsr_dis. Should the label in the format string match the struct field
name, or should the field be renamed?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> new file mode 100644
> index 000000000000..9eac32ca342c
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> @@ -0,0 +1,383 @@

[ ... ]

> +/* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
> +#define RGMII_IDX(port) ((port) == 8 ? 1 : 0)
> +
> +void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
> +			       struct phylink_config *c)
> +{
> +	c->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> +			      MAC_100 | MAC_1000FD | MAC_2500FD;
> +
> +	switch (port) {
> +	case 0 ... 3:
> +		__set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interfaces);
> +		break;
> +	case 4:
> +		__set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interfaces);
> +		phy_interface_set_rgmii(c->supported_interfaces);
> +		break;
> +	case 5 ... 6:
> +		/* SerDes ports: QSGMII/SGMII/1000BASEX/2500BASEX modes
> +		 * require PCS support which is not yet implemented.
> +		 */
> +		break;
> +	case 7 ... 8:
> +		/* QSGMII mode on ports 7-8 requires SerDes PCS support,
> +		 * which is not yet implemented.
> +		 */
> +		phy_interface_set_rgmii(c->supported_interfaces);
> +		break;
> +	default:
> +		break;
> +	}
> +}

mac_capabilities advertises MAC_2500FD for every port, but none of the
supported_interfaces entries allow negotiating 2.5 Gb/s. GMII and RGMII
do not carry 2.5 Gb/s, and ports 5-6 have an empty supported_interfaces
bitmap. Should MAC_2500FD be dropped until a PCS-capable interface is
added, or should it be set only on ports that will actually support it?

For ports 5 and 6, supported_interfaces is left empty. Will phylink_create()
succeed for those ports given no interface mode is permitted, or will they
be silently unusable?

The commit message states:

    The lan9645x switch is a multi-port Gigabit AVB/TSN Ethernet Switch
    with five integrated 10/100/1000Base-T PHYs. In addition to the
    integrated PHYs, it supports up to 2 RGMII/RMII, up to 2
    BASE-X/SERDES/2.5GBASE-X and one Quad-SGMII/Quad-USGMII interfaces.

Given ports 5-6 have no supported_interfaces and ports 7-8 expose only
RGMII in this patch, would it help to note in the commit message that
SerDes, QSGMII/USGMII and 2.5GBASE-X are not wired up yet?

[ ... ]

> +static int lan9645x_phylink_mac_prepare(struct phylink_config *config,
> +					unsigned int mode,
> +					phy_interface_t iface)
> +{
> +	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
> +	struct lan9645x *lan9645x = p->lan9645x;
> +	int port = p->chip_port;
> +	bool is_rgmii;
> +	u32 mask;
> +
> +	if (port == 5 || port == 6 || port > 8)
> +		return -EINVAL;
> +
> +	mask = HSIO_HW_CFG_GMII_ENA_SET(BIT(port));
> +	lan_rmw(mask, mask, lan9645x, HSIO_HW_CFG);
> +
> +	is_rgmii = phy_interface_mode_is_rgmii(iface);
> +	if (port == 4)
> +		lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(is_rgmii),
> +			HSIO_HW_CFG_RGMII_0_CFG,
> +			lan9645x, HSIO_HW_CFG);
> +
> +	return 0;
> +}

The HSIO_HW_CFG_RGMII_0_CFG bit is only written when port == 4, but the
comment above RGMII_IDX() states:

    /* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
    #define RGMII_IDX(port) ((port) == 8 ? 1 : 0)

Port 7 also maps to RGMII_0. If port 7 is configured for RGMII, does the
RGMII_0 mux ever get routed to port 7? And if port 4 is later configured
in GMII mode, the write HSIO_HW_CFG_RGMII_0_CFG_SET(0) would run and
appear to reroute RGMII_0 away from port 7.

Is there meant to be mutual-exclusion between port 4 and port 7 in RGMII
mode, and a write path for port 7 as well?

> +static void lan9645x_rgmii_dll_config(struct lan9645x_port *p)
> +{
> +	u32 rx_idx, tx_idx;
> +
> +	/* DLL register layout:
> +	 * (N*2):   RGMII_N_RX
> +	 * (N*2)+1: RGMII_N_TX
> +	 */
> +	rx_idx = RGMII_IDX(p->chip_port) * 2;
> +	tx_idx = RGMII_IDX(p->chip_port) * 2 + 1;
> +
> +	/* Enable DLL in RGMII clock paths, deassert DLL reset, and start the
> +	 * delay tune FSM.
> +	 */
> +	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> +		HSIO_DLL_CFG_DLL_RST_SET(0) |
> +		HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
> +		HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),
> +		HSIO_DLL_CFG_DLL_CLK_ENA |
> +		HSIO_DLL_CFG_DLL_RST |
> +		HSIO_DLL_CFG_DLL_ENA |
> +		HSIO_DLL_CFG_DELAY_ENA,
> +		p->lan9645x, HSIO_DLL_CFG(rx_idx));
> +
> +	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> +		HSIO_DLL_CFG_DLL_RST_SET(0) |
> +		HSIO_DLL_CFG_DLL_ENA_SET(p->tx_internal_delay) |
> +		HSIO_DLL_CFG_DELAY_ENA_SET(p->tx_internal_delay),
> +		HSIO_DLL_CFG_DLL_CLK_ENA |
> +		HSIO_DLL_CFG_DLL_RST |
> +		HSIO_DLL_CFG_DLL_ENA |
> +		HSIO_DLL_CFG_DELAY_ENA,
> +		p->lan9645x, HSIO_DLL_CFG(tx_idx));
> +}

This function consults only p->rx_internal_delay and p->tx_internal_delay
and never looks at the phy_interface_t. Phylink expects the MAC to apply
internal delay only when the interface is RGMII_ID, RGMII_TXID or
RGMII_RXID, and not when the interface is plain PHY_INTERFACE_MODE_RGMII
(where the PHY provides delay).

With a DT that specifies phy-mode = "rgmii" and nonzero
rx-internal-delay-ps, will both the PHY and the MAC add delay?

And with phy-mode = "rgmii-id" but no {rx,tx}-internal-delay-ps property
in DT, will the MAC fail to add delay on either side?

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> new file mode 100644
> index 000000000000..394a20ee678f
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c

[ ... ]

> +int lan9645x_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	if (dp->dn) {
> +		u32 val;
> +
> +		if (!of_property_read_u32(dp->dn, "rx-internal-delay-ps", &val))
> +			p->rx_internal_delay = val > 0;
> +
> +		if (!of_property_read_u32(dp->dn, "tx-internal-delay-ps", &val))
> +			p->tx_internal_delay = val > 0;
> +	}

The u32 picosecond value from DT is collapsed to a boolean via "val > 0",
discarding the tap selection. Is the discarded precision intentional, and
if so, why read the value as u32 in the first place rather than using
of_property_read_bool() on a differently-named property?

