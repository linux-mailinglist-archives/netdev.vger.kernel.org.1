Return-Path: <netdev+bounces-255483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CS5GRdCfmmtWgIAu9opvQ
	(envelope-from <netdev+bounces-255483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:55:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D17C36F7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE06D301875D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E55364059;
	Sat, 31 Jan 2026 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiHz/z8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D08364042;
	Sat, 31 Jan 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882130; cv=none; b=ehR7ktVtGWGLedQgoC7fB9QbsvRS+HP10seRS0LPGZbk7mbytamNswZyHfZMEAKZTTcnSfWHldhVXBGv0k5higrUtwBUFXv1+WRG5mGUFEkKfBW0jLUcay6osubGCNjspsLsvKf2HfG/AliSBL4UEdIrnsZxXzn2zpzdPMpzomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882130; c=relaxed/simple;
	bh=Z7+3/I6jiIVbes0Ajpxa4+cV1VONvsQL7MJjHuwUuKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjY1UsztqsBehhu2c7ZgcsQIfI0XFAKxNH0VJOsBN33O64Dskuf3YAuqAbOJeR19FGJQiGu5QMa/dhtqStDSrGDDA1LyZLzlERTUC1kzovYUVJDQAsOD3tiyUwAxqTt8MTajb03xyoPVhuzh2yqfkEVz2rhOQBf1iUr0GOprWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiHz/z8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49407C4CEF1;
	Sat, 31 Jan 2026 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769882130;
	bh=Z7+3/I6jiIVbes0Ajpxa4+cV1VONvsQL7MJjHuwUuKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiHz/z8wVdRzM4KxGgdQzZXPLMrVXsK0R8lSQ52rVRMxRAJppXU1mx/antmwqX13k
	 GLD5B50cdyGYtXxIPB1abBCHFubpBjCLvD/f8Vc0kN0SyQPwbH5JyTuXC8TLxHBJAe
	 6eaLTpSZBVVq4KnSoxPfW+gwcv0yA6qXCKThilxaf2beh0us5MZrmBiQlHOGWKk3mq
	 imE/Jl8EWytmolQnaO4NLywoeD4uHxQ8/XHOs4kU9QTjtw3QPA9T/mbgQZH3ei6iEn
	 pV18DbaegeGidAV4w+JjIb1sW0TTyOnSnWOc1yc1FazqKnTbaHfLcpx+g4DQZ4oKeH
	 r7F6p6q3OeSSA==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	lxu@maxlinear.com,
	hkallweit1@gmail.com,
	yweng@maxlinear.com,
	ajayaraman@maxlinear.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	bxu@maxlinear.com,
	olteanv@gmail.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com,
	chad@monroe.io,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	cezary.wilmanski@adtran.com,
	davem@davemloft.net,
	john@phrozen.org,
	frankwu@gmx.de,
	jpovazanec@maxlinear.com,
	linux@armlinux.org.uk,
	fchan@maxlinear.com,
	horms@kernel.org
Subject: Re: [net-next,v11,4/4] net: dsa: add basic initial driver for MxL862xx switches
Date: Sat, 31 Jan 2026 09:52:44 -0800
Message-ID: <20260131175243.1122906-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
References: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,maxlinear.com,gmail.com,lunn.ch,vger.kernel.org,monroe.io,google.com,redhat.com,adtran.com,davemloft.net,phrozen.org,gmx.de,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-255483-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: C3D17C36F7
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: add basic initial driver for MxL862xx switches

Add very basic DSA driver for MaxLinear's MxL862xx switches. In contrast
to previous MaxLinear switches the MxL862xx has a built-in processor that
runs a sophisticated firmware based on Zephyr RTOS. Interaction between
the host and the switch hence is organized using a software API of that
firmware rather than accessing hardware registers directly. Add
descriptions of the most basic firmware API calls to access the built-in
MDIO bus hosting the 2.5GE PHYs, basic port control as well as setting up
the CPU port. Implement a very basic DSA driver using that API which is
sufficient to get packets flowing between the user ports and the CPU port.

> diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
> new file mode 100644
> index 000000000000..3722260da7d8
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NET_DSA_MXL862
> +	tristate "MaxLinear MxL862xx"
> +	depends on NET_DSA
> +	select MAXLINEAR_GPHY
> +	select NET_DSA_TAG_MXL_862XX
> +	help
> +	  This enables support for the MaxLinear MxL862xx switch family.
> +	  These switches have two 10GE SerDes interfaces, one typically
> +	  used as CPU port.
> +	   MxL86282 has eight 2.5 Gigabit PHYs
> +	   MxL86252 has five 2.5 Gigabit PHYs

This isn't a bug, but the last two lines have inconsistent indentation.
The help text lines describing MxL86282 and MxL86252 have three spaces
after the tab while the other help text lines have two spaces.

[Jakub] maybe add a "-" or such in front to make it clear this is a list?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
> new file mode 100644
> index 000000000000..535c37514455
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h

[ ... ]

> +/**
> + * struct mxl862xx_bridge_alloc - Bridge Allocation
> + * @bridge_id: If the bridge allocation is successful, a valid ID will be
> + *             returned in this field. Otherwise, INVALID_HANDLE is
> + *             returned. For bridge free, this field should contain a
> + *             valid ID returned by the bridge allocation. ID 0 is not
> + *             used for historic reasons.
> + *
> + * Used by MXL862XX_BRIDGE_ALLOC and MXL862XX_BRIDGE_FREE.
> + */
> +struct mxl862xx_bridge_alloc {
> +	__le16 bridge_id;
> +} __packed;

[ ... ]

> +/**
> + * struct mxl862xx_bridge_port_alloc - Bridge Port Allocation
> + * @bridge_port_id: If the bridge port allocation is successful, a valid ID
> + *                  will be returned in this field. Otherwise, INVALID_HANDLE
> + *                  is returned. For bridge port free, this field should
> + *                  contain a valid ID returned by the bridge port allocation.
> + *
> + * Used by MXL862XX_BRIDGE_PORT_ALLOC and MXL862XX_BRIDGE_PORT_FREE.
> + */
> +struct mxl862xx_bridge_port_alloc {
> +	__le16 bridge_port_id;
> +};

Is the __packed attribute missing here? The similar struct
mxl862xx_bridge_alloc has __packed, and both structures have identical
layout with a single __le16 field. Both are used for firmware
communication where padding could break the protocol.

[Jakub] please remove the __packed attribute on structs which are
        naturally packed according to C rules.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> new file mode 100644
> index 000000000000..83946b50ea5f
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> +static void mxl862xx_port_disable(struct dsa_switch *ds, int port)
> +{
> +	mxl862xx_port_state(ds, port, false);
> +}

Should the error return from mxl862xx_port_state() be logged?

The function mxl862xx_port_state() can fail and returns an error code,
but mxl862xx_port_disable() ignores this return value. While the DSA
framework defines port_disable as returning void so errors cannot be
propagated to the caller, silently ignoring errors could leave the port's
SDMA or FDMA enabled if the API call fails. The function
mxl862xx_port_fast_age() logs errors when its API call fails.

> +static int mxl862xx_add_single_port_bridge(struct dsa_switch *ds, int port)
> +{
> +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mxl862xx_bridge_alloc br_alloc = {};
> +	int ret;
> +
> +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
> +		return ret;
> +	}
> +
> +	br_port_cfg.bridge_id = br_alloc.bridge_id;
> +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> +	br_port_cfg.src_mac_learning_disable = true;
> +	br_port_cfg.vlan_src_mac_vid_enable = false;
> +	br_port_cfg.vlan_dst_mac_vid_enable = false;
> +	br_port_cfg.bridge_port_map[0] = cpu_to_le16(BIT(dp->cpu_dp->index));

Can this dereference NULL pointers?

The dsa_to_port() function can return NULL if the port is not found in
the switch tree. The code stores the result in dp but doesn't check if
dp is NULL before dereferencing dp->cpu_dp->index.

Looking at include/net/dsa.h, dsa_to_port() returns NULL when the port
is not found:

    static inline struct dsa_port *dsa_to_port(struct dsa_switch *ds, int p)
    {
        struct dsa_switch_tree *dst = ds->dst;
        struct dsa_port *dp;

        list_for_each_entry(dp, &dst->ports, list)
            if (dp->ds == ds && dp->index == p)
                return dp;

        return NULL;
    }

Additionally, even if dp is non-NULL, dp->cpu_dp could also be NULL if
the CPU port hasn't been properly assigned during initialization.

> +static int mxl862xx_setup_mdio(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct device *dev = ds->dev;
> +	struct device_node *mdio_np;
> +	struct mii_bus *bus;
> +	static int idx;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc(dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->priv = priv;
> +	ds->user_mii_bus = bus;
> +	bus->name = KBUILD_MODNAME "-mii";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);

Can concurrent probes race on the idx variable?

The static int idx is shared across all driver instances and accessed
without synchronization. If multiple instances of this driver are probed
concurrently on different CPU cores, they could race on the idx++
operation potentially leading to duplicate MII bus IDs. MII bus IDs must
be unique system-wide.

[ ... ]

> +static int mxl862xx_setup_cpu_bridge(struct dsa_switch *ds, int port)
> +{
> +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> +	struct mxl862xx_priv *priv = ds->priv;
> +	u16 bridge_port_map = 0;
> +	struct dsa_port *dp;
> +
> +	/* CPU port bridge setup */
> +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> +
> +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> +	br_port_cfg.src_mac_learning_disable = false;
> +	br_port_cfg.vlan_src_mac_vid_enable = true;
> +	br_port_cfg.vlan_dst_mac_vid_enable = true;
> +
> +	/* include all assigned user ports in the CPU portmap */
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->cpu_dp->index != port)
> +			continue;

Can dp->cpu_dp be dereferenced safely here?

The code dereferences dp->cpu_dp->index without checking if cpu_dp is
NULL. While the DSA framework should ensure user ports have a CPU port
assigned during initialization, there is no explicit NULL check. If
cpu_dp is NULL for any reason such as incomplete initialization or
configuration error, this will cause a NULL pointer dereference and
kernel crash.

> +	ret = dsa_register_switch(ds);
> +	if (ret)
> +		return ret;

Is dev_set_drvdata() called too early?

The function calls dev_set_drvdata(dev, ds) before calling
dsa_register_switch(ds). If dsa_register_switch() fails, the function
returns the error but leaves the driver data pointing to an unregistered
switch.

This creates a problem for cleanup paths. The mxl862xx_remove() function
retrieves the switch with dev_get_drvdata() and calls
dsa_unregister_switch(ds). If probe failed, ds is not NULL so the check
passes but the switch was never successfully registered. Similarly,
mxl862xx_shutdown() could be called and would also operate on an
unregistered switch. While dsa_switch_shutdown() has a check for
ds->setup flag that provides some protection, this is fragile and could
lead to inconsistent state or crashes in error scenarios.

[Jakub] AI is a bit pedantic about leaving the drvdata pointer in place
        but I guess it's not a bad thing to clean up
-- 
pw-bot: cr

