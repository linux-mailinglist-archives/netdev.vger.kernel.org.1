Return-Path: <netdev+bounces-256072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Kj7AZ5SgWmLFgMAu9opvQ
	(envelope-from <netdev+bounces-256072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:42:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7CD3734
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52A5300F9F8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2327B34C;
	Tue,  3 Feb 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkMqDTml"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994221770A;
	Tue,  3 Feb 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082967; cv=none; b=e1qfFRFuOM7HlYeOMJPHLGmoPeDTRS2eazBRcQ4QCYQjw2kExy3JeJLNtkQwJZJrDskep/piPrKwG1s0eMk7phzMbEkl58a0cUPe3LcjKC+iFvO6XL7odggzCgpRam9CBKXx3QSSSXjuR3NXkz5ZcCBTgVkOvqx1vlBXnH3mjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082967; c=relaxed/simple;
	bh=M6dfXGmTDI2qS11FVYcguptyp9yxuSb1Ycd1hUZco3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh9SWAkKSlLEYgTQcwlcgPVicTbWg/tFrgnYsi/0TK4o4z7BBLkeswm7ToPnK82M7WEXc1pXQMDv6h9reb4AGv1gpApvAWTNsBKf11vAS8gRuimgn/zjRFRaumR6PeoW+DB3r+WSIZTVpMS8SWhn3d9uZWkXDX18OLkLOf82bEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkMqDTml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED73CC116C6;
	Tue,  3 Feb 2026 01:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770082966;
	bh=M6dfXGmTDI2qS11FVYcguptyp9yxuSb1Ycd1hUZco3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkMqDTmlAEHtjakKThZ2kq5d/smQHELd0Of7144U3zmrdJt4Thaozo5aCUNnR1UtT
	 UBWP03nNSWSSLTqt6e3vIPdP2a6IdT+Nj8pMoNm/XU+lyvFwiJsUAf36Pgr81nhzI2
	 /ZifN8mKpIE+z+RACve0isqL2iBFmy12cMaUk4vvwHLSTKQkhQyTLPitkQxXHysc01
	 anS+lT0Ynh8OdiI3MIevvNdVE/7A4vkF383rRhjs1q7+5Go3XflVkuwAseVyhOqQ1c
	 5LbMpNqJoKGEdSD5xvST7QN99JR9XiX7vUkTMoKORnu8fz0TW4hTGN+/6GllOu6QiJ
	 oL+m6PhEWSVvg==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	shawnguo@kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	conor+dt@kernel.org,
	horms@kernel.org,
	richardcochran@gmail.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	wahrenst@gmx.net,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: Re: [net-next,v22,2/7] net: mtip: The L2 switch driver for imx287
Date: Mon,  2 Feb 2026 17:39:10 -0800
Message-ID: <20260203013909.822898-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233459.1625279-3-lukasz.majewski@mailbox.org>
References: <20260131233459.1625279-3-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-256072-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,i.mx:url]
X-Rspamd-Queue-Id: 53D7CD3734
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: The L2 switch driver for imx287

This patch adds support for the More Than IP L2 switch embedded in the
imx287 SoC. This is a two-port switch placed between uDMA and MAC-NET
blocks, which can be used for offloading network traffic.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> new file mode 100644
> index 000000000000..a6fbdb59854f
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config FEC_MTIP_L2SW
> +	tristate "MoreThanIP L2 switch support to FEC driver"
> +	depends on OF
> +	depends on NET_SWITCHDEV
> +	depends on BRIDGE
> +	depends on SOC_IMX28 || COMPILE_TEST
> +	help
> +	  This enables support for the MoreThan IP L2 switch on i.MX
> +	  SoCs (e.g. iMX287). It offloads bridging to this IP block's
> +	  hardware and allows switch management with standard Linux tools.
> +	  This switch driver can be used interchangeable with the already
                                                  ^^^^^^^^^^^

This isn't a bug, but there's a grammar error: "can be used interchangeable
with" should be "can be used interchangeably with" (adverb, not adjective).

> +	  available FEC driver, depending on the use case's requirements.

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> new file mode 100644
> index 000000000000..45a7dfd253de
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static void mtip_read_atable(struct switch_enet_private *fep, int index,
> +			     u32 *read_lo, u32 *read_hi)
> +{
> +	struct addr_table64b_entry __iomem *atable_base =
> +		fep->hwentry->mtip_table64b_entry;
> +
> +	*read_lo = readl(&atable_base[index].lo);
> +	*read_hi = readl(&atable_base[index].hi);
> +}
> +
> +static void mtip_write_atable(struct switch_enet_private *fep, int index,
> +			      u32 write_lo, u32 write_hi)
> +{
> +	struct addr_table64b_entry __iomem *atable_base =
> +		fep->hwentry->mtip_table64b_entry;
> +
> +	writel(write_lo, &atable_base[index].lo);
> +	writel(write_hi, &atable_base[index].hi);
> +}

Can these functions race with concurrent access? Looking at the callers,
mtip_write_atable is called from two different paths:

1. Static entry updates: mtip_config_switch -> esw_mac_addr_static ->
   mtip_update_atable_static -> mtip_write_atable (no lock held)

2. Dynamic entry updates: timer callback -> mtip_mgnt_timer ->
   mtip_atable_dynamicms_learn_migration -> mtip_update_atable_dynamic1 ->
   mtip_write_atable (learn_lock held)

The learn_lock only protects the dynamic entry path. The static entry path
runs during link changes (mtip_switch_restart called from mtip_adjust_link)
without lock protection.

Both paths can access the same hash block in the address table (determined
by GET_BLOCK_PTR(hash)). If the timer fires during a link change callback,
both can concurrently access the table, potentially causing torn reads
(reading .lo from one entry version and .hi from another) or torn writes
(the entry is in an inconsistent state between the two writel calls).

Would extending learn_lock to protect all address table access work, or is
a separate hw_lock needed for hardware register access?

> +static bool mtip_update_atable_dynamic1(u32 write_lo, u32 write_hi,
> +					int block_index, unsigned int port,
> +					unsigned int curr_time,
> +					struct switch_enet_private *fep)
> +{

[ ... ]

> +	/* No more entry available in block overwrite oldest */
> +	timeold = 0;
> +	indexold = 0;
                 ^^

Does this initialization cause the wrong entry to be overwritten? The
function searches for the oldest entry within a specific hash block (from
block_index to index_end). When all 8 slots in the block are full, it
finds the oldest entry to overwrite.

If all entries in the block have timestamps equal to curr_time (meaning
they were all updated in the current time interval), the condition at
time > timeold is never true, and indexold never gets updated from 0.

This causes the write to go to entry 0 in the global address table, which
may be in a completely different hash block than the intended block_index.
For example, if block_index is 8 (second block), but all entries have the
same timestamp, the code will incorrectly write to entry 0 (first block)
instead of entry 8.

Should indexold be initialized to block_index instead of 0?

> +	for (entry = block_index; entry < index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		time = FIELD_GET(AT_TIMESTAMP_MASK, read_hi);
> +		dev_dbg(&fep->pdev->dev, "%s : time %x currtime %x\n",
> +			__func__, time, curr_time);
> +		time = mtip_timedelta(curr_time, time);
> +		if (time > timeold) {
> +			/* is it older ? */
> +			timeold = time;
> +			indexold = entry;
> +		}
> +	}
> +
> +	mtip_write_atable(fep, indexold, write_lo, conf);
> +
> +	/* Statistics (do it inbetween writing to .lo and .hi */
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This isn't a bug, but the comment doesn't match the code. The comment says
"do it inbetween writing to .lo and .hi" but the statistics increment
happens after mtip_write_atable completes. Looking at mtip_write_atable,
it writes both .lo and .hi registers in sequence before returning, so the
statistics are updated after both register writes complete, not between
them.

> +	fep->at_block_overflows++;
> +	dev_err(&fep->pdev->dev, "%s update time, at_block_overflows %x\n",
> +		__func__, fep->at_block_overflows);
> +	/* newly inserted */
> +	return true;
> +}

[ ... ]

> +static void mtip_mgnt_timer(struct timer_list *t)
> +{
> +	struct switch_enet_private *fep = timer_container_of(fep, t,
                                              ^^^^^^^^^^^^^^^^^^

Is timer_container_of the correct kernel API? The standard kernel API for
timer callbacks is from_timer, not timer_container_of. This will likely
cause compilation errors or undefined behavior depending on how
timer_container_of is defined.

The correct usage should be:
    struct switch_enet_private *fep = from_timer(fep, t, timer_mgnt);

> +							     timer_mgnt);
> +
> +	mtip_atable_dynamicms_learn_migration(fep, mtip_get_time(),
> +					      NULL, NULL);
> +	mod_timer(&fep->timer_mgnt,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
> +}

[ ... ]

> +static int mtip_mii_init(struct switch_enet_private *fep,
> +			 struct platform_device *pdev)
> +{
> +	struct device_node *node;
> +	int err = -ENXIO;

[ ... ]

> +	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
> +	if (node)
> +		dev_err(&fep->pdev->dev, "%s: PHY name: %s\n",
                ^^^^^^^^

This isn't a bug, but is dev_err the right log level here? Finding the
MDIO node is expected normal behavior during probe, not an error. Using
dev_err will cause unnecessary error-level log messages during normal
operation. Should this be dev_dbg instead?

> +			__func__, node->name);
> +
> +	err = of_mdiobus_register(fep->mii_bus, node);

> +static void mtip_ndev_cleanup(struct switch_enet_private *fep)
> +{
> +	struct mtip_ndev_priv *priv;
> +	int i;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		if (fep->ndev[i]) {
> +			priv = netdev_priv(fep->ndev[i]);
> +			cancel_work_sync(&priv->tx_timeout_work);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this work queue ever initialized? Looking through the code,
tx_timeout_work is never initialized with INIT_WORK or similar. Calling
cancel_work_sync on an uninitialized work structure will operate on
garbage memory and cause undefined behavior or crashes.

Should tx_timeout_work be initialized in mtip_ndev_init, or should this
cancel_work_sync call be removed if the work queue is not actually used?

> +
> +			unregister_netdev(fep->ndev[i]);
> +			free_netdev(fep->ndev[i]);
> +			fep->ndev[i] = NULL;
> +		}
> +	}
> +}

[ ... ]

> +static int mtip_ndev_init(struct switch_enet_private *fep,
> +			  struct platform_device *pdev)
> +{
> +	struct mtip_ndev_priv *priv;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
> +		fep->ndev[i] = alloc_netdev(sizeof(struct mtip_ndev_priv),
> +					    fep->ndev_name[i], NET_NAME_USER,
> +					    ether_setup);
> +		if (!fep->ndev[i]) {
> +			ret = -ENOMEM;
> +			goto cleanup_created_ndev;
> +		}
> +
> +		fep->ndev[i]->ethtool_ops = &mtip_ethtool_ops;
> +		fep->ndev[i]->netdev_ops = &mtip_netdev_ops;
> +		SET_NETDEV_DEV(fep->ndev[i], &pdev->dev);
> +
> +		priv = netdev_priv(fep->ndev[i]);
> +		priv->dev = fep->ndev[i];
> +		priv->fep = fep;
> +		priv->portnum = i + 1;
> +		fep->ndev[i]->irq = fep->irq;
> +
> +		mtip_setup_mac(fep->ndev[i]);
> +
> +		ret = register_netdev(fep->ndev[i]);
> +		if (ret) {
> +			dev_err(&fep->ndev[i]->dev,
> +				"%s: ndev %s register err: %d\n", __func__,
> +				fep->ndev[i]->name, ret);
> +			free_netdev(fep->ndev[i]);
> +			fep->ndev[i] = NULL;
> +			goto cleanup_created_ndev;
> +		}
> +
> +		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
> +			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
> +	}
> +
> +	return 0;
> +
> + cleanup_created_ndev:
> +	if (i == SWITCH_EPORT_NUMBER - 1)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Does this condition cause a resource leak? The cleanup code only calls
mtip_ndev_cleanup if the failure occurs when processing the last device
(i==1 for 2 devices). If the failure occurs on device 0 (i==0), the
condition is false and mtip_ndev_cleanup is not called, leaking the
successfully created network device.

For example, if device 0 is successfully created and registered, but device
1 fails during alloc_netdev, then i=1 and the condition (1 == 1) is true,
so cleanup happens. But if register_netdev fails for device 0, we free that
device and set fep->ndev[0]=NULL, then goto cleanup with i=0, and the
condition (0 == 1) is false, so no cleanup happens for any other
successfully created devices before the failure point.

Should mtip_ndev_cleanup be called unconditionally, or should the cleanup
logic track which devices need cleanup?

jakub: not sure there's a bug here, but AI is right that this is an odd pattern

> +		mtip_ndev_cleanup(fep);
> +
> +	return ret;
> +}

[ ... ]

> +static int mtip_parse_of(struct switch_enet_private *fep,
> +			 struct device_node *np)
> +{
> +	struct device_node *p;
> +	unsigned int port_num;
> +	int ret = 0;
> +
> +	p = of_get_child_by_name(np, "ethernet-ports");
> +
> +	for_each_available_child_of_node_scoped(p, port) {
> +		if (of_property_read_u32(port, "reg", &port_num))
> +			continue;
> +
> +		if (!(port_num == 1 || port_num == 2)) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: The switch supports up to %d ports!\n",
> +				__func__, SWITCH_EPORT_NUMBER);
> +			goto of_get_err;
> +		}
> +
> +		fep->n_ports = port_num;
> +		ret = of_get_mac_address(port, &fep->mac[port_num - 1][0]);
> +		if (ret)
> +			dev_dbg(&fep->pdev->dev,
> +				"of_get_mac_address(%pOF) failed (%d)!\n",
> +				port, ret);
> +
> +		ret = of_property_read_string(port, "label",
> +					      &fep->ndev_name[port_num - 1]);
> +		if (ret < 0) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: Cannot get ethernet port name (%d)!\n",
> +				__func__, ret);
> +			goto of_get_err;
> +		}
> +
> +		ret = of_get_phy_mode(port, &fep->phy_interface[port_num - 1]);
> +		if (ret < 0) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: Cannot get PHY mode (%d)!\n", __func__,
> +				ret);
> +			goto of_get_err;
> +		}
> +
> +		fep->phy_np[port_num - 1] = of_parse_phandle(port,
> +							     "phy-handle", 0);
                                                             ^^^^^^^^^^^^^^^^^^

Can these device_node references leak on probe failure? The function
acquires references via of_parse_phandle and stores them in fep->phy_np.
If the function fails after successfully obtaining one or more references,
or if a later function in mtip_sw_probe fails, these references are never
released.

The references are only released in mtip_mii_remove which is called from
mtip_sw_remove. However, if probe fails, remove is never called.

For example:
1. mtip_parse_of successfully calls of_parse_phandle for port 0, storing
   reference in fep->phy_np[0]
2. Either mtip_parse_of fails on port 1, or mtip_parse_of succeeds but a
   later step in mtip_sw_probe fails (e.g., mtip_switch_dma_init,
   mtip_mii_init, or mtip_ndev_init)
3. mtip_sw_probe returns error
4. Device probe fails, so mtip_sw_remove is never called
5. mtip_mii_remove is never called, so fep->phy_np[0] reference is never
   released with of_node_put

Should proper cleanup of phy_np references be added in mtip_parse_of error
path and/or in mtip_sw_probe error paths?

> +		if (!fep->phy_np[port_num - 1]) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: PHY handle not defined!\n", __func__);
> +			ret = -ENODEV;
> +			goto of_get_err;
> +		}
> +	}
> +
> + of_get_err:
> +	of_node_put(p);
> +
> +	return ret;
> +}

[ ... ]

> +static void mtip_sw_remove(struct platform_device *pdev)
> +{
> +	struct switch_enet_private *fep = platform_get_drvdata(pdev);
> +
> +	mtip_ndev_cleanup(fep);
> +
> +	mtip_mii_remove(fep);
> +
> +	dma_free_coherent(&fep->pdev->dev, PAGE_SIZE, fep->rx_bd_base,
> +			  fep->bd_dma);
> +	fep->rx_bd_base = NULL;
> +	fep->tx_bd_base = NULL;
> +
> +	timer_delete_sync(&fep->timer_mgnt);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Does the timer get deleted too late in the cleanup sequence? The timer
callback mtip_mgnt_timer accesses fep->hwp, fep->hwentry, and
fep->pdev->dev. However, timer_delete_sync is called after
mtip_ndev_cleanup, mtip_mii_remove, and dma_free_coherent.

If the timer fires between these cleanup operations and timer_delete_sync,
it will access freed or cleaned resources, causing use-after-free and
potential crashes.

Should the timer be deleted first before any other cleanup operations?

Correct order would be:
1. timer_delete_sync(&fep->timer_mgnt);
2. mtip_ndev_cleanup(fep);
3. mtip_mii_remove(fep);
4. dma_free_coherent(...);

> +	platform_set_drvdata(pdev, NULL);
> +}
-- 
pw-bot: cr

