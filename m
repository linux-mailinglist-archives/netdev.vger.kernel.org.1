Return-Path: <netdev+bounces-286916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JXeGtqLAmrzuAEAu9opvQ
	(envelope-from <netdev+bounces-286916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:09:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 007AA518B60
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFF20303989A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45130BF70;
	Tue, 12 May 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5qB95du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98672308F1D;
	Tue, 12 May 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551729; cv=none; b=bSYc1v+19pfyK/efTVV7i7qfvhe4tC2aM+AXYTUVieORvVKFlc5UoQLHUXBCWQSz3FowOdn1IGPniXNwF7326B1j2rjv13AQu898wtHCSLdTPsU2qdAUj3lj7USwKbz+Bk3x+CAXop7a2+KFbFiFp+eJFZQ+WP/3QeecqGy9zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551729; c=relaxed/simple;
	bh=82dK58KE+X6Oi6ezoFAIdeH0gF/I8wGORz9rUXggHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT6mwGsyMh8wSecJJ7G1K/Bq7/5R/evo3NB6lQKFtVlE9hmPmhI4DMb519r8r+k3UfLp6CodD1xfaGvPiP5C+Q9J9p1VltpdkautC7kTuw0SHyQLsUh0ZMtYvjM8wE1C93z4EXRfggos6FsRct4inbzMJLkrdoxY+QyJ9zAhJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5qB95du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC9C2BCB0;
	Tue, 12 May 2026 02:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551729;
	bh=82dK58KE+X6Oi6ezoFAIdeH0gF/I8wGORz9rUXggHWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5qB95dutYZb072hnh98e7ySfh4xEBs7hoW6duqk+YNTh/6Uv1p67TfHKtdXPP6zZ
	 m9CZb145Jd7SovudExt9Il1zIG/bgxuZrW2pL6HBgTmj4EdvUxK2yHrOu/tOLAU1Ul
	 uvxhei6mkn1CxvxIAqPDUd2kz/csvPbRUtO4YKQ19jnNlN+VsJMmublG8w/ppR0t4f
	 s0W8VulcTUS5RTx7ZeRh7rQHxhI+aRy4oLfAcGvi6fnjIKO4h2c0Cx3pWzPoopXLfe
	 O8Gv04GF1SqvRmxODhKYWJGs2W98OZXuHvZPmeHjLI5Zn1zYqbTraEPaxPEBazF8tn
	 7WhoGbwhvARMg==
From: Jakub Kicinski <kuba@kernel.org>
To: thangaraj.s@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] net: lan743x: Add support to software-nodes for SFP
Date: Mon, 11 May 2026 19:08:48 -0700
Message-ID: <20260512020848.839006-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508052150.11852-4-thangaraj.s@microchip.com>
References: <20260508052150.11852-4-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 007AA518B60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286916-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: lan743x: Add support to software-nodes for SFP

This change registers a software-node hierarchy (GPIO/I2C/SFP/phylink)
for the LAN743x so that SFP cages on PCI11x1x devices can be described
to phylink/sfp. It wires the lan743x probe to the sibling pci1xxxx I2C
and GPIO peripheral drivers by walking the PCIe topology and dereferencing
their drvdata.

A few questions on the patch below.

> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> index ee046468652c..a83db3c7404f 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -50,6 +50,8 @@ config LAN743X
>  	select CRC16
>  	select CRC32
>  	select PHYLINK
> +	select I2C_PCI1XXXX
> +	select GP_PCI1XXXX
>  	help
>  	  Support for the Microchip LAN743x and PCI11x1x families of PCI
>  	  Express Ethernet devices

[High]
Should LAN743X inherit the dependencies of the symbols it now selects?

GP_PCI1XXXX in drivers/misc/mchp_pci1xxxx/Kconfig carries:

    depends on PCI
    depends on GPIOLIB
    depends on NVMEM_SYSFS

and I2C_PCI1XXXX is sourced inside an "if I2C" block in drivers/i2c/Kconfig,
so it has an implicit depends on I2C. The LAN743X entry here does not
depend on I2C, GPIOLIB, or NVMEM_SYSFS. On configurations where any of
those are disabled (randconfig, allmodconfig variants), would this
produce unmet-direct-dependency warnings from sym_warn_unmet_dep() and
potentially fail to link because the selected drivers' helpers are not
built?

Would adding "depends on I2C && GPIOLIB && NVMEM_SYSFS" (or gating the
SFP glue behind a nested Kconfig symbol) be appropriate here?

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 867310dbe9ba..b90b35cef2e6 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -112,6 +113,91 @@ static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
> +static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapter,
> +					u16 perif_id)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct pci_bus *perif_bus;
> +	struct pci_dev *perif_dev;
> +	struct pci_dev *br_dev;
> +	struct pci_bus *br_bus;
> +	struct pci_dev *dev;
[ ... ]
> +	br_bus = br_dev->bus;
> +	list_for_each_entry(dev, &br_bus->devices, bus_list) {
> +		if (dev->vendor == PCI1XXXX_VENDOR_ID &&
> +		    (dev->device & ~PCI1XXXX_DEV_MASK) == PCI1XXXX_BR_PERIF_ID) {
> +			perif_bus = dev->subordinate;
> +			list_for_each_entry(perif_dev, &perif_bus->devices,
> +					    bus_list) {
> +				if (perif_dev->vendor == PCI1XXXX_VENDOR_ID &&
> +				    (perif_dev->device & ~PCI1XXXX_DEV_MASK) ==
> +				     perif_id)
> +					return pci_get_drvdata(perif_dev);
> +			}
> +		}
> +	}

[High]
Is it safe to walk br_bus->devices and perif_bus->devices without
holding pci_bus_sem?

Both pci_device_add() and pci_destroy_dev() take down_write(&pci_bus_sem)
when mutating pci_bus->devices, and pci_walk_bus() / other in-tree
consumers either wrap the iteration in down_read(&pci_bus_sem) or assert
lockdep_assert_held(&pci_bus_sem). If a PCI hotplug or sibling
bind/unbind happens concurrently here, could the traversal corrupt, loop,
or step through a pci_dev that is being freed?

Relatedly, pci_get_drvdata(perif_dev) is returned directly with no
reference acquired on the peer device or its driver. Can the following
sequence occur?

    lan743x probe stores adapter->i2c_adap = &i2c_drvdata->adap
    user unbinds i2c-mchp-pci1xxxx via sysfs
    i2c_drvdata (and its embedded i2c_adapter) is freed
    SFP EEPROM access via the software-node fwnode still dereferences it

Would using pci_get_device() (or pci_dev_get() under pci_bus_sem) plus a
device_link_add() from the peer device to the lan743x consumer be a more
robust pairing, or alternatively routing this coupling through the
auxiliary bus?

> +static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
> +{
> +	struct pci1xxxx_i2c *i2c_drvdata;
> +
> +	i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
> +	if (!i2c_drvdata)
> +		return -EPROBE_DEFER;
> +
> +	adapter->i2c_adap = &i2c_drvdata->adap;

[Medium]
The cast here relies on struct pci1xxxx_i2c being textually redeclared
in lan743x_main.h, identical to the authoritative definition in
drivers/i2c/busses/i2c-mchp-pci1xxxx.c. Nothing ties the two copies
together at build time (no shared header, no BUILD_BUG_ON on sizeof or
offsetof), and there is no runtime check that perif_dev->driver is the
expected pci_driver before the drvdata is cast.

If the i2c driver later reorders or resizes a field, would
&i2c_drvdata->adap silently read from a wrong offset? And if the peer
PCI function is bound to vfio-pci or any other driver,
pci_get_drvdata() returns an unrelated pointer which is then
dereferenced as struct pci1xxxx_i2c. Would it make sense to add a
narrow accessor exported by the peripheral driver, e.g. something like
pci1xxxx_i2c_get_adapter(pdev), so the layout is not duplicated across
subsystems?

The same question applies to the redeclarations of struct
auxiliary_device_wrapper, struct gp_aux_data_type and struct
aux_bus_device in lan743x_main.h.

> +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
> +{
> +	struct aux_bus_device *aux_bus;
> +	struct device *gpio_dev;
> +
> +	aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
> +	if (!aux_bus)
> +		return -EPROBE_DEFER;
> +
> +	gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;

[Medium]
Is the hardcoded index [1] here guaranteed by anything?

In drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c the wrapper array has
slot 0 = gp_otp_e2p and slot 1 = gp_gpio today, but that ordering is an
internal detail of the GP driver and is not enforced by a shared type,
a name check, or a documented contract. If the GP driver ever reorders
the registration, fails partway so slot 1 is unpopulated, or adds a
new slot, would this dereference pick up the wrong aux_dev (or a NULL)?

Would it be preferable to look up the GPIO aux device by name (e.g.
matching aux_dev.name == "gp_gpio") or expose a named accessor from
the GP driver?

> @@ -2890,6 +2976,96 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
> +static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct lan743x_sw_nodes *nodes;
> +	struct software_node *swnodes;
> +	int ret;
> +	u32 id;
> +
> +	nodes = kzalloc_obj(*nodes);
> +	if (!nodes)
> +		return -ENOMEM;
> +
> +	adapter->nodes = nodes;
> +
> +	ret = pci1xxxx_gpio_dev_get(adapter);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pci1xxxx_i2c_adapter_get(adapter);
> +	if (ret < 0)
> +		return ret;

[High]
Does this leak the lan743x_sw_nodes allocation on error?

adapter->nodes is set unconditionally before the two peripheral lookups,
both of which commonly return -EPROBE_DEFER while the sibling pci1xxxx
drivers are still probing. On that error, lan743x_swnodes_register()
returns without freeing nodes and without clearing adapter->nodes.

The caller in lan743x_phylink_create() handles the failure as:

    ret = lan743x_swnodes_register(adapter);
    if (ret) {
        netdev_err(netdev, "failed to register software nodes\n");
        return ret;
    }

without calling lan743x_swnodes_unregister(). The probe error path
(lan743x_pcidev_probe) then jumps to cleanup_mdiobus, which does not
reach lan743x_destroy_phylink() (the only caller of
lan743x_swnodes_unregister). Each -EPROBE_DEFER retry would allocate a
fresh struct and discard the previous one.

The same concern applies to the software_node_register_node_group()
return at the end of this function: its failure is returned to a caller
that does not call lan743x_swnodes_unregister().

Would cleaning up in lan743x_swnodes_register() itself on every error
path (kfree(nodes); adapter->nodes = NULL) be appropriate?

> +	nodes->gpio_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
> +	swnodes[SWNODE_GPIO] = NODE_PROP(nodes->gpio_name, nodes->gpio_props);
[ ... ]
> +	nodes->i2c_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
> +	swnodes[SWNODE_I2C] = NODE_PROP(nodes->i2c_name, nodes->i2c_props);
[ ... ]
> +	nodes->phylink_props[0] = PROPERTY_ENTRY_STRING("managed",
> +							"in-band-status");
> +	nodes->phylink_props[1] = PROPERTY_ENTRY_REF_ARRAY("sfp",
> +							   nodes->sfp_ref);
> +	swnodes[SWNODE_PHYLINK] = NODE_PROP(nodes->phylink_name,
> +					    nodes->phylink_props);

[High]
Do the property_entry arrays need a trailing NULL sentinel?

The struct definition in lan743x_main.h sizes them to the exact number
of used entries:

    struct property_entry gpio_props[1];
    struct property_entry i2c_props[1];
    struct property_entry sfp_props[8];    /* 7 used + terminator */
    struct property_entry phylink_props[2];

The swnode code in drivers/base/swnode.c iterates with

    for (; prop->name; prop++)

in property_entry_get() and property_entries_dup(), which relies on a
zeroed terminator. Only sfp_props[8] includes such a slot.

Because gpio_props, i2c_props, sfp_props and phylink_props are laid out
contiguously in struct lan743x_sw_nodes, when iteration walks past
gpio_props[0] or i2c_props[0] it would land on the next array's entries
(for example i2c_props[0].name = "pinctrl-names", then sfp_props entries
"compatible"/"sff,sfp", "i2c-bus", ...), only terminating at
sfp_props[7]. The GPIO and I2C software nodes could silently acquire SFP
properties.

For phylink_props[2], iteration would continue into i2c_ref[0], whose
first field swnode is a non-NULL pointer; would that pointer then be
interpreted as prop->name and passed to strcmp() during lookups for
names other than "managed"/"sfp", producing an out-of-bounds read of
kernel memory?

Would sizing each array with +1 for a zero terminator address this?

> @@ -3134,7 +3310,9 @@ static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
>  static int lan743x_phylink_create(struct lan743x_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
> +	struct fwnode_handle *fwnode = NULL;
>  	struct phylink *pl;
> +	int ret;
[ ... ]
> +	if (adapter->is_sfp_support_en) {
> +		ret = lan743x_swnodes_register(adapter);
> +		if (ret) {
> +			netdev_err(netdev, "failed to register software nodes\n");
> +			return ret;
> +		}
> +		fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_PHYLINK]);
> +		if (!fwnode) {
> +			lan743x_swnodes_unregister(adapter);
> +			return -ENODEV;
> +		}
> +	}
>  
> +	pl = phylink_create(&adapter->phylink_config, fwnode,
> +			    adapter->phy_interface, &lan743x_phylink_mac_ops);
>  	if (IS_ERR(pl)) {
>  		netdev_err(netdev, "Could not create phylink (%pe)\n", pl);
> +		lan743x_swnodes_unregister(adapter);
>  		return PTR_ERR(pl);
>  	}

Thanks for reading.

