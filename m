Return-Path: <netdev+bounces-274831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULunFWsWz2lZswYAu9opvQ
	(envelope-from <netdev+bounces-274831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8738FFD8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241BA30B97C1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAB92765F8;
	Fri,  3 Apr 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeW8Fp7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25B1BBBE5;
	Fri,  3 Apr 2026 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179062; cv=none; b=FmMS839mrOlfPVV461rrZmWfDWAiyD1nqPXglFyrumbdzCoDSugbRbCA8S2GPED/mAxQFVP9y8hqCWrPkCz1vlIfqqkYgdlbBiMbIE9rirZnZx1+U2JUGMcrYu4Wlf7K2dAUwR+xvVxosnIsMWMSOdTXyYBiu9AkUqCvku7nc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179062; c=relaxed/simple;
	bh=Qo5WYyKMeV7hp8RN7S6hSeBu5J+1l7VvgvLybc0R8cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djidv0D7yvwK+JyAfPRYjNWhhlaIrTJxHIAItREfPGUNqcMon4iARbfb+pp4k4DhrirWTg2EcDssoedDNS7zEuR1SciZB9SO+xnch6FTj9wCBP/C8nBi67UYZubZx3wdETruCfXdPv+2YK8USV951oj4ueGusmP8pncFVicflMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeW8Fp7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A65CC116C6;
	Fri,  3 Apr 2026 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179060;
	bh=Qo5WYyKMeV7hp8RN7S6hSeBu5J+1l7VvgvLybc0R8cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeW8Fp7eYP/CuVWuq7dX7B7pzgPFmvM6dhFAaKmM3gWLSO5f10MO+Ya+UeyMCy2YF
	 RRZQYOk8eN60TuEF8jSk08eoCCq/3IF0kk/7O61DqFW67UypRKbQbISlfYAWNZr7E9
	 nr3FvErd9D8PQ7uME3Uq6cvez2SrwAIjs3uKBuu3XKk0pNJXhhNjkfJT7LgS3l0haC
	 RMhTu+dCGe2kSF15x7CnfeRL2plx6wC8AsMMZ+VXNq4RFhDgBl8teFOTqGYOD39298
	 xiNAmGPb/zcB/kITk2cuLUWYuMvQm0RaehPff/7mLMgao/b+Sc/RykYvKTArOyNW+U
	 l48zSk6T+aIMw==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 10/14] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
Date: Thu,  2 Apr 2026 18:17:38 -0700
Message-ID: <20260403011738.1795644-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-11-wei.fang@nxp.com>
References: <20260331113025.1566878-11-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274831-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8B8738FFD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: netc: introduce NXP NETC switch driver for i.MX94
    
This commit introduces the initial NXP NETC switch driver for the i.MX94
series. It supports basic probe and remove functionality for the integrated
802.1Q Ethernet switch. The switch includes 3 user ports and 1 CPU port
connected to an internal ENETC.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> new file mode 100644
> index 000000000000..5828fd3e342e
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_main.c
[ ... ]
> +static int netc_port_create_emdio_bus(struct netc_port *np,
> +				      struct device_node *node)
> +{
[ ... ]
> +	err = devm_of_mdiobus_register(dev, bus, node);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Cannot register EMDIO bus\n");
> +
> +	np->emdio = bus;
> +
> +	return 0;
> +}
[ ... ]
> +static int netc_init_switch_id(struct netc_switch *priv)
> +{
> +	struct netc_switch_regs *regs = &priv->regs;
> +	struct dsa_switch *ds = priv->ds;
> +
> +	/* The value of 0 is reserved for the VEPA switch and cannot
> +	 * be used.
> +	 */
> +	if (ds->index > SWCR_SWID || !ds->index) {
> +		dev_err(priv->dev, "Switch index %d out of range\n",
> +			ds->index);
> +		return -ERANGE;
> +	}

Does this check cause the probe to fail unconditionally for standard
single-switch topologies?

The DSA core typically assigns ds->index = 0 by default for the first switch.
Because !ds->index evaluates to true for index 0, this setup function will
always fail unless the dsa,member property is explicitly overridden in the
device tree.

Could the driver translate the hardware ID internally, for example by writing
ds->index + 1 to NETC_SWCR, rather than forcing this hardware-specific
restriction onto the software DSA index?

> +
> +	netc_base_wr(regs, NETC_SWCR, ds->index);
> +
> +	return 0;
> +}
[ ... ]
> +static bool netc_port_is_emdio_consumer(struct device_node *node)
> +{
> +	struct device_node *mdio_node;
> +
> +	/* If the port node has phy-handle property and it does
> +	 * not contain a mdio child node, then the port is the
> +	 * EMDIO consumer.
> +	 */
> +	mdio_node = of_get_child_by_name(node, "mdio");
> +	if (!mdio_node)
> +		return true;
> +
> +	of_node_put(mdio_node);
> +
> +	return false;
> +}
> +
> +/* Currently, phylink_of_phy_connect() is called by dsa_user_create(),
> + * so if the switch uses the external MDIO controller (like the EMDIO
> + * function) to manage the external PHYs. The MDIO bus may not be
> + * created when phylink_of_phy_connect() is called, so it will return
> + * an error and cause the switch driver to fail to probe.
> + * This workaround can be removed when DSA phylink_of_phy_connect()
> + * calls are moved from probe() to ndo_open().
> + */
> +static int netc_switch_check_emdio_is_ready(struct device *dev)
> +{
[ ... ]
> +	for_each_available_child_of_node_scoped(ports, child) {
> +		/* If the node does not have phy-handle property, then
> +		 * the port does not connect to a PHY, so the port is
> +		 * not the EMDIO consumer.
> +		 */
> +		phy_node = of_parse_phandle(child, "phy-handle", 0);
> +		if (!phy_node)
> +			continue;
> +
> +		if (!netc_port_is_emdio_consumer(child)) {
> +			of_node_put(phy_node);
> +			continue;
> +		}
> +
> +		phydev = of_phy_find_device(phy_node);
> +		of_node_put(phy_node);
> +		if (!phydev) {
> +			err = -EPROBE_DEFER;
> +			goto out;
> +		}

Could this logic cause an infinite probe deferral loop for ports sharing an
internal MDIO bus?

The netc_port_is_emdio_consumer() function assumes any port node without an
mdio child is an EMDIO consumer waiting for an external controller. However,
if multiple sibling ports on the same switch share a single internal MDIO bus
defined under one port, the other ports will lack an mdio child node.

This would cause those ports to be mistakenly treated as external EMDIO
consumers, calling of_phy_find_device(). Because the internal MDIO bus is not
registered until later in netc_setup(), the PHY device cannot be found, and
the driver returns -EPROBE_DEFER.

Since netc_setup() is never reached, the MDIO bus is never registered,
causing an infinite deferral loop. Could the driver more accurately identify
whether the PHY belongs to its own switch before deferring?

> +
> +		put_device(&phydev->mdio.dev);
> +	}
> +
> +out:
> +	of_node_put(ports);
> +
> +	return err;
> +}
> +
> +static int netc_switch_pci_init(struct pci_dev *pdev)
> +{
[ ... ]
> +	regs->base = pci_ioremap_bar(pdev, NETC_REGS_BAR);
> +	if (!regs->base) {
> +		err = -ENXIO;
> +		dev_err(dev, "pci_ioremap_bar() failed\n");
> +		goto release_mem_regions;
> +	}
[ ... ]
> +static void netc_switch_pci_destroy(struct pci_dev *pdev)
> +{
> +	struct netc_switch *priv = pci_get_drvdata(pdev);
> +
> +	iounmap(priv->regs.base);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}

Does unmapping the memory here introduce a use-after-unmap issue when the
MDIO bus is unregistered?

The driver registers the MDIO bus using devm_of_mdiobus_register(), meaning
devres cleans it up asynchronously after the remove function returns or when
probe fails.

However, in netc_switch_pci_destroy(), the driver explicitly unmaps the PCI
I/O memory via iounmap(). Since netc_switch_pci_destroy() is called
synchronously inside the remove function and probe error paths, the memory is
unmapped before the MDIO bus is unregistered by devres.

When devres eventually unregisters the MDIO bus, it detaches PHY devices,
which often perform MDIO transactions during removal. Because the underlying
memory priv->regs.base is already unmapped, these MDIO read/write callbacks
could trigger a synchronous external abort or kernel panic.

Would it be better to use pcim_iomap() to tie the memory mapping lifecycle to
devres, ensuring it outlives the MDIO bus?

