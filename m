Return-Path: <netdev+bounces-269046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGqZDcG9ummqbQIAu9opvQ
	(envelope-from <netdev+bounces-269046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:59:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4D2BDB30
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D53203046448
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AB33DC4B2;
	Wed, 18 Mar 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppPerBNK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA63CEBBA;
	Wed, 18 Mar 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844802; cv=none; b=E1yZRfY66hDUJ1bTIR9QfF3Gc88RaEEnyMvh5d1yzVBeh63zCq7A7IPF24o/v84IziFWaiuORRl707uhiE9b0Ms5eUCdwkQPAzeIAjF0n2L5E9+ynURQxq4Sz4BsNO373FwdhZ25rFBeZCj5kZ0idQ68SyBLnngcOKYPmat6qH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844802; c=relaxed/simple;
	bh=lTmvcD4MKOhdnWf0ncRKcsBRvwfwpCt6pbrFgMkwmEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqNL4Ns+vBz+AoWyibJqGeEYxdD4g2aBCnHjcJBeBji8KKvYgwXPG8vQmwpunlkbtZyskkO/xWy14DoKONrsL9HqOmHv5V/xnFhSxz42qiTwLzDhqJnYI73GQSXDHrPxZd/DL2FWQNquQTdKq2dqRE2iYo4mDL4UHahGkFbgk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppPerBNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A28C19421;
	Wed, 18 Mar 2026 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844801;
	bh=lTmvcD4MKOhdnWf0ncRKcsBRvwfwpCt6pbrFgMkwmEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppPerBNKpDEGlFSD0eIGgFdqKHMmTNWGY3zGsy5tvajnPyn+rmcrcCvj5XUAyuQJt
	 MnV4m8ZgUmFgFeW3iEPmNoFfDdc1T2Gd3zgUWQ7ZXpwS36lRQmvuinvtNyRhUvKnck
	 ced/ZBisvBKL+YUxDrJDIur0GATS0eIAX/5JyWb2H2D6n2X3qOlWMrfem8eDJOeXqK
	 B/scLD2UWCuoNVrkyDGUPRJnqqGxmHu6puDaqtoJ8dcuo1qZWefKiBe0HIiyXQ3JY9
	 kr/foja6rZeHkdOqh8IPifayS5S+hZAHWlEqLLDOrd5degRj9o0qU5Fq2Wl9PBDPwa
	 ysnACeo7yK53w==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	vladimir.oltean@nxp.com,
	kuba@kernel.org,
	f.fainelli@gmail.com,
	krzk+dt@kernel.org,
	claudiu.manoil@nxp.com,
	robh@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	chleroy@kernel.org,
	devicetree@vger.kernel.org,
	pabeni@redhat.com,
	imx@lists.linux.dev
Subject: Re: [net-next,10/14] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
Date: Wed, 18 Mar 2026 14:39:30 +0000
Message-ID: <20260318143930.1890017-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-11-wei.fang@nxp.com>
References: <20260316094152.1558671-11-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lunn.ch,google.com,nxp.com,gmail.com,lists.ozlabs.org,davemloft.net,armlinux.org.uk,redhat.com,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-269046-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.919];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 38C4D2BDB30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: introduce NXP NETC switch driver for i.MX94

This commit introduces the initial NETC switch driver for the i.MX94
series. The driver provides basic probe and remove functionality for
the NXP NETC Ethernet switch which has 3 user ports and 1 CPU port.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -0,0 +1,698 @@
> +static int netc_port_create_emdio_bus(struct netc_port *np,
> +				      struct device_node *node)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	struct enetc_mdio_priv *mdio_priv;
> +	struct device *dev = priv->dev;
> +	struct enetc_hw *hw;
> +	struct mii_bus *bus;
> +	int err;
> +
> +	hw = enetc_hw_alloc(dev, np->iobase);
> +	if (IS_ERR(hw))
> +		return dev_err_probe(dev, PTR_ERR(hw),
> +				     "Failed to allocate enetc_hw\n");
> +
> +	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "NXP NETC switch external MDIO Bus";
> +	bus->read = enetc_mdio_read_c22;
> +	bus->write = enetc_mdio_write_c22;
> +	bus->read_c45 = enetc_mdio_read_c45;
> +	bus->write_c45 = enetc_mdio_write_c45;
> +	bus->parent = dev;
> +	mdio_priv = bus->priv;
> +	mdio_priv->hw = hw;
> +	mdio_priv->mdio_base = NETC_EMDIO_BASE;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
> +		 dev_name(dev), np->dp->index);
> +
> +	err = devm_of_mdiobus_register(dev, bus, node);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Cannot register EMDIO bus\n");
> +
> +	np->emdio = bus;
> +
> +	return 0;
> +}
> +
> +static int netc_port_create_mdio_bus(struct netc_port *np,
> +				     struct device_node *node)
> +{
> +	struct device_node *mdio_node;
> +	int err;
> +
> +	mdio_node = of_get_child_by_name(node, "mdio");
> +	if (mdio_node) {
> +		err = netc_port_create_emdio_bus(np, mdio_node);
> +		of_node_put(mdio_node);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void netc_port_free_mdio_bus(struct netc_port *np)
> +{
> +	if (np->emdio)
> +		mdiobus_unregister(np->emdio);
                         ^^^^

Does this cause a double unregister? The MDIO bus is registered with
devm_of_mdiobus_register() in netc_port_create_emdio_bus(), which
installs a devres action that automatically calls mdiobus_unregister()
during device removal.

However, netc_port_free_mdio_bus() also explicitly calls
mdiobus_unregister(np->emdio).

During device removal:

  netc_switch_remove()
    -> dsa_unregister_switch()
      -> dsa_switch_teardown()
        -> netc_teardown()
          -> netc_free_mdio_bus()
            -> netc_port_free_mdio_bus()
              -> mdiobus_unregister()  // first call

Then devres cleanup fires:

  devm_mdiobus_unregister()
    -> mdiobus_unregister()  // second call
      -> WARN_ON_ONCE(bus->state != MDIOBUS_REGISTERED)

The second call triggers a warning at drivers/net/phy/mdio_bus_provider.c:675
because the bus state is already MDIOBUS_UNREGISTERED. With
panic_on_warn=1, this causes a kernel panic.

The same double-unregister occurs on the error path of
netc_init_all_ports(), where netc_free_mdio_bus() is called, but devres
will also fire during device teardown.

> +}

[ ... ]

> +static int netc_switch_pci_init(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_switch_regs *regs;
> +	struct netc_switch *priv;
> +	int err;
> +
> +	pcie_flr(pdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable device\n");
> +
> +	/* The command BD rings and NTMP tables need DMA */
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
                                       ^^^^

Is the return value being checked? The comment states "command BD rings
and NTMP tables need DMA", confirming DMA is essential for this driver.

The function can fail with -EIO when dma_supported() returns false for
the 64-bit mask (from dma_set_mask() in kernel/dma/mapping.c:902).

The sibling enetc driver from the same NXP NETC subsystem checks this
return value in enetc.c:

  err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
  if (err) {
      ...
      goto err_dma;
  }

If the 64-bit DMA mask setup fails, the DMA mask remains at the default,
and subsequent DMA operations for NTMP table management (added in later
commits) may silently fail or produce incorrect results on systems with
memory above 4GB.

> +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (err) {
> +		dev_err(dev, "Failed to request memory regions, err: %pe\n",
> +			ERR_PTR(err));
> +		goto disable_pci_device;
> +	}
> +
> +	pci_set_master(pdev);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}
> +
> +	priv->pdev = pdev;
> +	priv->dev = dev;
> +
> +	regs = &priv->regs;
> +	regs->base = pci_ioremap_bar(pdev, NETC_REGS_BAR);
> +	if (!regs->base) {
> +		err = -ENXIO;
> +		dev_err(dev, "pci_ioremap_bar() failed\n");
> +		goto release_mem_regions;
> +	}
> +
> +	regs->port = regs->base + NETC_REGS_PORT_BASE;
> +	regs->global = regs->base + NETC_REGS_GLOBAL_BASE;
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +release_mem_regions:
> +	pci_release_mem_regions(pdev);
> +disable_pci_device:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}

[ ... ]

