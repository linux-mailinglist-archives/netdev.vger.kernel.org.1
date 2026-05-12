Return-Path: <netdev+bounces-286917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JrdN/OLAmrbuAEAu9opvQ
	(envelope-from <netdev+bounces-286917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CBB518B7D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A14CF302DFBB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D763168EF;
	Tue, 12 May 2026 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezfMw5hS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E369313E10;
	Tue, 12 May 2026 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551731; cv=none; b=mksV5kcmSdiUko69mpNXzTKf61GTKERV9Q+zfd5WVFD5swSLf1vrbrXqt/U+UxFcd2bUC9TXM038Bn7hcotR1Xqq3dQ29J2vuGmRlIq3FGZgBhvdsFwEEHPcL5OTCZv+Q0WgG+Gr8yowbfSa+IqbiQZ/nvqi6VColzg0zrco9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551731; c=relaxed/simple;
	bh=ztSEipSmw7kdHol/XHuIfa7O8FvWOPHastms5tWMW9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8iIg8liRudlQpLRkWMjWZVjrDlT1G1tamY72b6aBeKyxYJEWMzNNLAO27vF2X+jBJW4MyA54/Wnmi+//VwyiqrkuQffAxdeq2WgN2l8wubnh6DKCpAk3WsHY3nfYdxMbNEQZYgP25GeoGCPZUCe4jOLKQsXavvu3e3CIf0hXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezfMw5hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D60C2BCF5;
	Tue, 12 May 2026 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551730;
	bh=ztSEipSmw7kdHol/XHuIfa7O8FvWOPHastms5tWMW9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezfMw5hS9hCm/dMkcciCgEcna06KoAzU2WwqZ50N7pKW+2LnN2UMsdxsmqKhrjKMh
	 bM3iVNTfTTgoOxi0GW5x43qWxp7N8O8sxzFmM+ocIzGp9FakML2iOtv0sbb5O4KNHZ
	 1QJ/u3bArAu+nL6lTnuJUIytpkmtm3t9m6fuW/dK95cnidJ6eSUg+lKM+ODOSy/ZB7
	 hcpy1D1bP/vrLxNOJTgvII76xFlLMhet9b9GZw7fU1s95zq55On6blJagwnHHvvko2
	 B3dksQoWQZtnCDdw6P7AZwEPIq2+3EyJsXgIfvVj8os5Lpt7EE1zAI4bJklOox177q
	 8Ht6K0PFIabNw==
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
Subject: Re: [PATCH net-next v3 4/5] net: lan743x: Register SFP platform device for PCI11x1x
Date: Mon, 11 May 2026 19:08:49 -0700
Message-ID: <20260512020849.839044-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508052150.11852-5-thangaraj.s@microchip.com>
References: <20260508052150.11852-5-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55CBB518B7D
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
	TAGGED_FROM(0.00)[bounces-286917-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sfp_info.id:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: lan743x: Register SFP platform device for PCI11x1x

This commit registers an SFP platform device for PCI11x1x when SFP support
is enabled, using the SFP software node as its firmware node and associating
the I2C adapter with its own software node for module management.

> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> index a83db3c7404f..9857053dabf8 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -52,6 +52,7 @@ config LAN743X
>  	select PHYLINK
>  	select I2C_PCI1XXXX
>  	select GP_PCI1XXXX
> +	select SFP

[Medium]
Does this select need to inherit SFP's own dependencies?  In
drivers/net/pse-pd/Kconfig the SFP symbol is declared as:

    config SFP
        tristate "SFP cage support"
        depends on NETDEVICES && PHYLIB
        depends on HWMON || HWMON=n
        ...

With HWMON=m and LAN743X=y, select SFP forces SFP=y, which violates
the HWMON || HWMON=n constraint and produces an unmet direct
dependencies warning.

For comparison, drivers/net/ethernet/wangxun/Kconfig uses:

    select HWMON if TXGBE=y
    select SFP

Would adding either depends on HWMON || HWMON=n to LAN743X, or a
conditional HWMON select, be preferable here?

>  	help
>  	  Support for the Microchip LAN743x and PCI11x1x families of PCI
>  	  Express Ethernet devices
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index b90b35cef2e6..88a2d11552f8 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3066,6 +3066,31 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
>  	return software_node_register_node_group(nodes->group);
>  }
>  
> +static int lan743x_sfp_register(struct lan743x_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct platform_device_info sfp_info;
> +	struct platform_device *sfp_dev;
> +
> +	memset(&sfp_info, 0, sizeof(sfp_info));
> +	sfp_info.parent = &adapter->pdev->dev;
> +	sfp_info.fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_SFP]);
> +	sfp_info.name = "sfp";
> +	sfp_info.id = (pdev->bus->number << 8) | pdev->devfn;

[Medium]
Should the platform device id incorporate pci_domain_nr(pdev->bus)?
PCI bus numbers are only unique within a PCI domain, so on a
multi-domain system two PCI11x1x devices in different domains that
happen to share the same bus/devfn would both try to register as
sfp.<same_id>.

The second platform_device_add() would then fail with -EEXIST from
device_add() and SFP would not come up on that device.  Something
like:

    sfp_info.id = (pci_domain_nr(pdev->bus) << 16) |
                  (pdev->bus->number << 8) | pdev->devfn;

would avoid that collision.

> +	sfp_dev = platform_device_register_full(&sfp_info);
> +	if (IS_ERR(sfp_dev)) {
> +		netif_err(adapter, drv, adapter->netdev,
> +			  "Failed to register SFP device\n");
> +		return PTR_ERR(sfp_dev);
> +	}
> +
> +	adapter->sfp_dev = sfp_dev;
> +	netif_dbg(adapter, drv, adapter->netdev,
> +		  "SFP platform device registered");
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -3682,6 +3707,12 @@ static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
>  static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
>  {
>  	unregister_netdev(adapter->netdev);
> +	if (adapter->sfp_dev) {
> +		platform_device_unregister(adapter->sfp_dev);
> +		adapter->sfp_dev = NULL;
> +	}
> +	if (adapter->i2c_adap)
> +		adapter->i2c_adap = NULL;

[High]
Can this leave a dangling fwnode on the i2c_adap device?  The
i2c_adap is fetched from a different PCI function (the pci1xxxx_i2c
driver via pci1xxxx_i2c_adapter_get()) and outlives the lan743x
instance.

In lan743x_pcidev_probe() the code does:

    adapter->i2c_adap->dev.fwnode =
        software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);

But on teardown only the local pointer is cleared:

    if (adapter->i2c_adap)
        adapter->i2c_adap = NULL;

Meanwhile lan743x_destroy_phylink() calls
lan743x_swnodes_unregister() which invokes
software_node_unregister_node_group() and frees adapter->nodes.
After that, i2c_adap->dev.fwnode still references the released
swnode-backed fwnode.

Any subsequent access to i2c_adap->dev.fwnode (driver unload/rebind
of pci1xxxx_i2c, sysfs reads, fwnode iteration, or fwnode ops
dispatch) would then dereference freed memory.

Should the teardown also restore i2c_adap->dev.fwnode to what it was
before the probe-side assignment, symmetric to the mutation done in
lan743x_pcidev_probe()?

>  
>  	lan743x_destroy_phylink(adapter);
>  	lan743x_mdiobus_cleanup(adapter);
> @@ -3909,11 +3940,29 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
>  		goto cleanup_mdiobus;
>  	}
>  
> +	if (adapter->is_sfp_support_en) {
> +		adapter->i2c_adap->dev.fwnode =
> +			software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
> +
> +		ret = lan743x_sfp_register(adapter);
> +		if (ret < 0) {
> +			netif_err(adapter, probe, netdev,
> +				  "failed to sfp register (%d)\n", ret);
> +			goto cleanup_phylink;
> +		}
> +	}
> +
>  	ret = register_netdev(adapter->netdev);
>  	if (ret < 0)
> -		goto cleanup_phylink;
> +		goto cleanup_sfp;
>  	return 0;
>  
> +cleanup_sfp:
> +	if (adapter->sfp_dev) {
> +		platform_device_unregister(adapter->sfp_dev);
> +		adapter->sfp_dev = NULL;
> +	}
> +
>  cleanup_phylink:
>  	lan743x_destroy_phylink(adapter);
>

