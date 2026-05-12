Return-Path: <netdev+bounces-286918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPzmOAyMAmrzuAEAu9opvQ
	(envelope-from <netdev+bounces-286918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:10:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63270518B94
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4325A30509AE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2032F748;
	Tue, 12 May 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvV22kOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC332692B;
	Tue, 12 May 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551732; cv=none; b=Y1dmwtQD9Ii0XTpMeBudschIgVt68v+C5euNeIpLmpdJSNkDKD63l0LfXRT/lFUzHfExJmcuh6JMBcBuPQr4M/4+Z1KcETQ9cE9wvjw6OaQn3skJOsR3T49uQhzqPSzy6S6Q7F7zEF+vhFONFL9qBnZMkG+0CNGfJfjh2/w0d58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551732; c=relaxed/simple;
	bh=9YHeJCp7aCV0gDz+cZgsWduJeVKpG8HROteJtCMbCIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTSRKYiL6Rr1T+O5COMPAVB1UPKsP84ePfdkYr2QQRPdH+NyncZkidAm82aW/nzUwABahDkDYJ6+yu0L6FGXHVf2oPsQEKKYlAh3j+eq5yS4hawRs8acb8pyOeBimrkJNFuEUz6g7YZNz9h/ceBXag1z63pz5VC6az7+qo8Hvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvV22kOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D184FC2BCB0;
	Tue, 12 May 2026 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551732;
	bh=9YHeJCp7aCV0gDz+cZgsWduJeVKpG8HROteJtCMbCIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvV22kOCA5JCqe/qsGKFAtTDvRn0oxtfr9r1QIq+shv5L/OP6FvvbBlnuGVzpXIE+
	 qYOzp3Ut3M/2wcXy2RTFaTZt1zcGrlqmAmGl/gnqRxgUqCXu3GYeaHcuf13iiyux6x
	 xI2wBjnaTtIH/oyZcqADZpq5xaw0Y7veNlmozrxSZZmWmdbBlOuujrOaJRJn5GWlbq
	 7Yvxd30MrOM9ZSJIMEOSdkOzoLS+GVGSwS0dP3BN1xBLnW2wuI696uDu2UkUH1mhqB
	 kpozQhrLdy08X7JHXgQxbDv0Li22UpewMm4g3oPxXhwa10MJ312WdK3wKL0mF3p2Rh
	 dUCUX783q8ptQ==
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
Subject: Re: [PATCH net-next v3 5/5] net: lan743x: Add PCS/XPCS support for SFP on PCI11x1x
Date: Mon, 11 May 2026 19:08:51 -0700
Message-ID: <20260512020851.839084-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508052150.11852-6-thangaraj.s@microchip.com>
References: <20260508052150.11852-6-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63270518B94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286918-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: lan743x: Add PCS/XPCS support for SFP on PCI11x1x

Adds a dedicated PCS mdiobus and an XPCS instance driven through the
existing SGMII register access helpers, integrates the xpcs with phylink
via mac_select_pcs, and extends phylink support to cover SGMII and
2500BASE-X for SFP modules on PCI11x1x.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 88a2d11552f8..485fbc678481 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c

[ ... ]

> @@ -3806,6 +3845,42 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>  	return 0;
>  }
>  
> +static int lan743x_pcs_mdiobus_init(struct lan743x_adapter *adapter)
> +{
> +	struct phylink_pcs *pcs;
> +	int ret;
> +
> +	adapter->pcs_mdiobus = devm_mdiobus_alloc(&adapter->pdev->dev);
> +	if (!(adapter->pcs_mdiobus)) {
> +		ret = -ENOMEM;
> +		goto return_error;
> +	}
> +
> +	adapter->pcs_mdiobus->priv = (void *)adapter;
> +	adapter->pcs_mdiobus->read_c45 = pci11x1x_pcs_read;
> +	adapter->pcs_mdiobus->write_c45 = pci11x1x_pcs_write;
> +	adapter->pcs_mdiobus->name = "lan743x-pcs-mdiobus-c45";
> +	netif_dbg(adapter, drv, adapter->netdev, "lan743x-pcs-mdiobus-c45\n");
> +	sn printf(adapter->pcs_mdiobus->id, MII_BUS_ID_SIZE, "pci-pcs-%s", pci_name(adapter->pdev));
> +
> +	if (!adapter->phy_interface)
> +		lan743x_phy_interface_select(adapter);
> +
> +	pcs = xpcs_create_pcs_mdiodev(adapter->pcs_mdiobus, 0);

[Critical]
Is this pcs_mdiobus ever registered?  The bus is obtained from
devm_mdiobus_alloc() and then handed straight to xpcs_create_pcs_mdiodev()
without a mdiobus_register()/devm_mdiobus_register() call in between, so
it stays in MDIOBUS_ALLOCATED state.

bus->mdio_lock is only initialized by __mdiobus_register():

    drivers/net/phy/mdio_bus_provider.c:__mdiobus_register() {
        ...
        mutex_init(&bus->mdio_lock);
        ...
    }

mdiobus_alloc_size() does not initialize it. xpcs_create_pcs_mdiodev()
flows into xpcs_create() -> xpcs_init_id() -> xpcs_identify() and each
C45 read grabs bus->mdio_lock via mutex_lock().

Can this end up locking an uninitialized mutex during probe on
CONFIG_DEBUG_MUTEXES or lockdep kernels, and silently corrupting state
otherwise?

Similarly, mdio_device_create() sets mdiodev->dev.parent = &bus->dev on
a struct device that has never been through device_register(), which
other xpcs consumers (txgbe_mdio_pcs_init, ksz9477_pcs_create,
sja1105_mdiobus_pcs_register) avoid by registering the bus first.

> +	if (IS_ERR(pcs)) {
> +		netdev_err(adapter->netdev, "failed to create xpcs\n");
> +		ret = PTR_ERR(pcs);
> +		goto return_error;
> +	}
> +
> +	adapter->xpcs = pcs;
> +	return 0;
> +
> +return_error:
> +	mdiobus_free(adapter->pcs_mdiobus);
> +	return ret;
> +}

[Critical, Critical]
Can this error path dereference a NULL pointer and also double-free the
bus?

When devm_mdiobus_alloc() returns NULL, adapter->pcs_mdiobus is NULL and
the code still jumps to return_error, which calls mdiobus_free():

    drivers/net/phy/mdio_bus_provider.c:mdiobus_free() {
        if (bus->state == MDIOBUS_ALLOCATED) {
            kfree(bus);
            return;
        }
        ...
    }

There is no NULL guard, so the OOM path dereferences NULL.

On the xpcs-create failure path, the bus was allocated by
devm_mdiobus_alloc(), which registers devm_mdiobus_free() as a devres
destructor that calls mdiobus_free() at device teardown
(drivers/net/phy/mdio_devres.c). Calling mdiobus_free() here manually
frees the bus (state == MDIOBUS_ALLOCATED takes the kfree(bus) path),
and then devres runs again on the same pointer.

Would it be simpler to drop the return_error cleanup entirely and just
return the error, letting devres free the bus?

> +
>  static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
>  {
>  	int ret;
> @@ -3927,6 +4002,11 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto cleanup_hardware;
>  
> +	if (adapter->is_sfp_support_en) {
> +		ret = lan743x_pcs_mdiobus_init(adapter);
> +		if (ret)
> +			goto cleanup_hardware;
> +	}

[High]
Is cleanup_hardware the right target here?

lan743x_mdiobus_init() was just called above and has already invoked
mdiobus_register(adapter->mdiobus), so adapter->mdiobus is in state
MDIOBUS_REGISTERED. Jumping to cleanup_hardware skips cleanup_mdiobus
-> lan743x_mdiobus_cleanup() -> mdiobus_unregister(adapter->mdiobus).

The bus is then torn down only by the devm_mdiobus_free devres
destructor, which reaches mdiobus_free() on a still-registered bus and
trips:

    drivers/net/phy/mdio_bus_provider.c:mdiobus_free() {
        ...
        WARN(bus->state != MDIOBUS_UNREGISTERED,
             "%s: not in UNREGISTERED state\n", bus->id);
        ...
    }

device_del() on the bus device is never called. Should this instead
goto cleanup_mdiobus?

[Medium]
On PCI11x1x, pci11x1x_strap_get_status() can leave is_sfp_support_en
true while is_pcs_en is false (SFP strap set, SGMII strap cleared) with
only a netif_err().  In that case lan743x_hardware_init() takes the
SGMII-disabled path and writes SGMII_CTL with SGMII_CTL_SGMII_POWER_DN_
set and SGMII_CTL_SGMII_ENABLE_ cleared.

Then lan743x_pcidev_probe() still enters this branch because
is_sfp_support_en is true, invoking lan743x_pcs_mdiobus_init() which
drives xpcs_create_pcs_mdiodev() -> xpcs_identify() -> multiple C45
reads through pci11x1x_pcs_read() -> lan743x_sgmii_read():

    drivers/net/ethernet/microchip/lan743x_main.c:lan743x_sgmii_read() {
        ...
        lan743x_csr_write(adapter, SGMII_ACC, mmd_access);
        ret = lan743x_sgmii_wait_till_not_busy(adapter);
        ...
    }

With the SGMII block powered down, can the busy bit ever clear, or will
every read hit the 1-second readx_poll_timeout, producing an extremely
slow probe and a bogus xpcs identification?

>  	adapter->netdev->netdev_ops = &lan743x_netdev_ops;
>  	adapter->netdev->ethtool_ops = &lan743x_ethtool_ops;
>  	adapter->netdev->features = NETIF_F_SG | NETIF_F_TSO |

