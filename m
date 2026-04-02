Return-Path: <netdev+bounces-274354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEUOA0vkzWlVigYAu9opvQ
	(envelope-from <netdev+bounces-274354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:36:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E738333F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A6CC308F543
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19635CB60;
	Thu,  2 Apr 2026 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulCTD6qx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9A21773D;
	Thu,  2 Apr 2026 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100666; cv=none; b=e/bVtPxIL4oW7Je2/R7XGGmCMPrvZNd98Xxmo4UYRmlBzxyrfgLiEO9sS7fcYBicVQKqS1A4CYGUXN0q8PEChMjH8sXREI/dgEGm+D7yYAmbp0g6w5xzURT67T7iOrUXjBeSZEEdwdqKKIa0O3N5+0kzdmt+lG7EIWet5Oa7+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100666; c=relaxed/simple;
	bh=ECK83Xkm17xXdMn3X/dFsz7dxU/tgQQCJAsEIjOSJCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpBL8QrBM/j8+IXFp4ghFc3oSK20uKLWrofq2nO+wANUNT9HjALzzDbJTpEpsNI2xZaW4a3YRnofVWBE9bLJNrrF3rodsAnwn5W6fREcFWitGSQnGpNUUqux2Ju2jbf8ZvmSPxrmGJOXjbOhFdI6ea2yxjQzKifIQXCqF7H/e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulCTD6qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F063C4CEF7;
	Thu,  2 Apr 2026 03:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100666;
	bh=ECK83Xkm17xXdMn3X/dFsz7dxU/tgQQCJAsEIjOSJCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulCTD6qxuN0cts0VmeVZ/knFu7EfpF6mh3e8pn5+5oG+1qW5w5aNhKDb9opYOpqVa
	 Gf5PV3n9mnmBd72GK9QuElnT0KY/QGfWonpdaQxwNFUBuDHeJU0xon6dprHHDnUvrt
	 ChbIDrMrpoiyFwSGRbLx7tpkuFnALObFYY6ZHoYKS/mqo1P+wtxYjnEPYksQaW3zXR
	 xgcJjaQ6/xHZhny92tmf1N8UvqcZjGKZyWCzSIqziwMdWPc9zd/TIxe8fdRmsOJERg
	 Ya7ZjlPC9mutGUQPPDHCYdEmbxb0P6eitkowozty6h+WyMc+X1abL7EXzJc7wCaD8a
	 YZzvT7IxO2aKw==
From: Jakub Kicinski <kuba@kernel.org>
To: joey@tinyisr.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	andrew@lunn.ch,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dsa: initial support for MT7628 embedded switch
Date: Wed,  1 Apr 2026 20:31:03 -0700
Message-ID: <20260402033103.911409-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330184017.766200-5-joey@tinyisr.com>
References: <20260330184017.766200-5-joey@tinyisr.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274354-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 650E738333F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: initial support for MT7628 embedded switch

Add support for the MT7628 embedded switch.
The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
port that is internally attached to the SoCs CPU MAC and serves as the
CPU port.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -28,6 +28,14 @@ source "drivers/net/dsa/hirschmann/Kconfig"
>  
>  source "drivers/net/dsa/lantiq/Kconfig"
>  
> +config NET_DSA_MT7628
> +	tristate "MediaTek MT7628 Embedded Ethernet switch support"
> +	select NET_DSA_TAG_MT7628
> +	select MEDIATEK_FE_SOC_PHY

Does this configuration need to select NET_DSA_TAG_8021Q?

The driver relies on the tag_8021q mechanism for switch port isolation. If
the kernel is configured without NET_DSA_TAG_8021Q, dsa_tag_8021q_register()
will return -EOPNOTSUPP, causing the switch to boot with broken port
isolation.

> +	help
> +	  This enables support for the built-in Ethernet switch found
> +	  in the MT7628 SoC.
> +
[ ... ]
> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> --- /dev/null
> +++ b/drivers/net/dsa/mt7628.c
[ ... ]
> +static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       !(val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);

Will this polling logic cause an MDIO timeout?

If RD_DONE is a completion status bit that remains 1 after a successful
operation, this first poll will wait indefinitely for the bit to become 0.

If RD_DONE is an active-low busy bit, the second poll below waits for the
controller to become busy instead of waiting for it to be idle.

> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "read failed. MDIO timeout?\n");
> +		return ret;
> +	}
> +	return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);
> +}
> +
> +static int mt7628_mii_write(struct mii_bus *bus, int port, int regnum, u16 dat)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       !(val & MT7628_ESW_PCR1_WT_DONE), 10,
> +				       5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_WT_NWAY_DATA, dat) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_WT_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_WT_DONE), 10,
> +				       5000);

Is this second poll waiting for the controller to become busy instead of
idle, similar to the read function?

> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "write failed. MDIO timeout?\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int mt7628_setup_internal_mdio(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct device_node *mdio;
> +	struct mii_bus *bus;
> +	int ret = 0;
> +
> +	mdio = of_get_available_child_by_name(ds->dev->of_node, "mdio");
> +
> +	bus = devm_mdiobus_alloc(esw->dev);

Can allocating devm_ resources in the DSA .setup callback cause a sysfs name
collision?

The .setup callback is executed whenever the DSA tree binds. Since devm_
resources are tied to the platform device (esw->dev) rather than the DSA
tree lifecycle, they are not released when the DSA tree unbinds. On a
subsequent re-bind, allocating a new MDIO bus with the same ID will fail
because the original bus was never unregistered.

> +	if (!bus) {
> +		ret = -ENOMEM;
> +		goto out_put_node;
> +	}
> +
> +	bus->name = "MT7628 internal MDIO bus";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(ds->dev));
> +	bus->priv = esw;
> +	bus->read = mt7628_mii_read;
> +	bus->write = mt7628_mii_write;
> +	bus->parent = esw->dev;
> +	if (!mdio) {
> +		ds->user_mii_bus = bus;
> +		bus->phy_mask = ~ds->phys_mii_mask;
> +	}
> +
> +	ret = devm_of_mdiobus_register(esw->dev, bus, mdio);
> +
> +out_put_node:
> +	of_node_put(mdio);
> +	return ret;
> +}
[ ... ]
> +static int mt7628_setup(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	int ret;
> +
> +	reset_control_reset(esw->rst_esw);
> +	usleep_range(1000, 2000);
> +	reset_control_reset(esw->rst_ephy);
> +	usleep_range(1000, 2000);
> +	/*
> +	 * all MMIO reads hang if esw is not out of reset
> +	 * ephy needs extra time to get out of reset or it ends up misconfigured
> +	 */
> +	mt7628_switch_init(ds);
> +	rtnl_lock();
> +	dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));

Is it safe to ignore the return value of dsa_tag_8021q_register()?

If the registration fails, the core function frees the allocated context but
does not clear ds->tag_8021q_ctx. The setup will continue, and the DSA core
will later dereference the non-NULL ds->tag_8021q_ctx, leading to a
use-after-free crash.

Also, if mt7628_setup_internal_mdio() below fails, the setup returns an
error without unregistering the tagger, which leaks the tag_8021q context.

> +	rtnl_unlock();
> +
> +	ret = mt7628_setup_internal_mdio(ds);
> +	return ret;
> +}
[ ... ]
> +static struct dsa_switch_ops mt7628_switch_ops = {
> +	.get_tag_protocol = mt7628_get_tag_proto,
> +	.setup = mt7628_setup,

Does this switch ops structure need a .teardown callback?

Without calling dsa_tag_8021q_unregister() in a .teardown callback, the
tag_8021q context memory allocated during .setup will be permanently leaked
whenever the DSA switch is unbound or the module is removed.

> +	.port_enable = mt7628_port_enable,
> +	.port_disable = mt7628_port_disable,
> +	.phylink_get_caps = mt7628_phylink_get_caps,
> +	.tag_8021q_vlan_add = mt7628_dsa_8021q_vlan_add,
> +	.tag_8021q_vlan_del = mt7628_dsa_8021q_vlan_del,
> +};
-- 
pw-bot: cr

