Return-Path: <netdev+bounces-257401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKZgM3hRhWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:27:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F113F9496
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF17D300C028
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0526ED3D;
	Fri,  6 Feb 2026 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je7HVDGF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B226E6E1;
	Fri,  6 Feb 2026 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344805; cv=none; b=HC0BBWlDxO5sbKn+cNMHA9fDphbn4oznU2+9HBycnUpzYLaxBJrQGn/mAUlttA8+UzC1XJgPceaxXYMxISiHyIBh/+7tfaYoiCifrtjKncYx8U9FJnaHTFAd+WfCFVTtuDo4geDxWkMoYM8rFqsTrszudI0Q5arUnhsRFusuT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344805; c=relaxed/simple;
	bh=4qPaqb0aOYjpeDtbgDXCpqKQsP3lR0Pf36lTaq1kiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVZpPA7pYgxsVxfQR4fmjadcYHb6HHIcbEY5AimCHmFc6Ro7Y4r8V7D0nFYcLrNAdo1dtFbibkJ9d7aOz/Ka3DrUfwrzFmfdNyaliDFWe9j9eX/EDr/do/LUgFSoePTugFFfM5s+Jp8uN01AfLYIy3VSQbct0lsVfzwLHiALYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je7HVDGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC99CC4CEF7;
	Fri,  6 Feb 2026 02:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344805;
	bh=4qPaqb0aOYjpeDtbgDXCpqKQsP3lR0Pf36lTaq1kiBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=je7HVDGFE0hcT8cVZD/T8uXMz8pQQqDlMZd95T1gMzNt/ixaNmncGpygfKjD95IfV
	 N0RI9P5auBeyI3I0+aEXQaeyDzKplMlyA55rKBfgY6yE/U6wQfpn04b58roj4tmAmv
	 t3eGbhE6k4INPGXcM/ngpTDK7Ap3yBxq/FLJQ/Bwf9ZiJZuWrr8Ar6alHvpg9cF63l
	 UApZ2LNOWGItsTVuoKQsbNgL97BHd+4nXNeDIoUZUxvdY3Yu8M/9yWrd6mb2JBvZDo
	 jJzBQj0+nYxI0j70IXeKMFQ64KTsP/8QJfAwayfCWpcdxySW9Cdv49eflGd9cAmii2
	 hOQDkDKbrkwyw==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	imx@lists.linux.dev,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	davem@davemloft.net,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	festevam@gmail.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	pabeni@redhat.com,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wahrenst@gmx.net,
	richardcochran@gmail.com,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	edumazet@google.com,
	robh@kernel.org
Subject: Re: [net-next,v23,4/7] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Thu,  5 Feb 2026 18:26:43 -0800
Message-ID: <20260206022643.3197165-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204232135.1024665-5-lukasz.majewski@mailbox.org>
References: <20260204232135.1024665-5-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,lunn.ch,vger.kernel.org,davemloft.net,pengutronix.de,gmail.com,redhat.com,lists.infradead.org,gmx.net,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-257401-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 7F113F9496
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Add net_device_ops functions to the L2 switch driver

This patch provides callbacks for struct net_device_ops for MTIP L2
switch.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index d209501a99b0..4c64681602d6 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> @@ -618,6 +741,73 @@ static void mtip_switch_restart(struct net_device *dev, int duplex0,
>  	mtip_config_switch(fep);
>  }
>
> +static void mtip_print_hw_state(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct cbd_t *bdp;
> +	bool tx_full;
> +	int i;
> +
> +	spin_lock_bh(&fep->hw_lock);
> +	tx_full = fep->dirty_tx == fep->cur_tx &&
> +		mtip_netif_queues_stopped(fep);
> +
> +	dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
> +	dev_info(&dev->dev,
> +		 "Ring data: cur_tx 0x%p%s, dirty_tx 0x%p cur_rx: 0x%p\n",
> +		 fep->cur_tx, tx_full ? " (full)" : "", fep->dirty_tx,
> +		 fep->cur_rx);
> +
> +	bdp = fep->tx_bd_base;
> +	dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
> +	for (i = 0; i < TX_RING_SIZE; i++) {
> +		dev_info(&dev->dev, "  0x%p: %04x %04x %08x\n",
> +			 bdp, bdp->cbd_sc, bdp->cbd_datlen,
> +			 (int)bdp->cbd_bufaddr);
> +		bdp++;
> +	}
> +
> +	bdp = fep->rx_bd_base;
> +	dev_info(&dev->dev, " rx: %lu buffers\n", RX_RING_SIZE);
> +	for (i = 0 ; i < RX_RING_SIZE; i++) {
> +		dev_info(&dev->dev, "  0x%p: %04x %04x %08x\n",
> +			 bdp, bdp->cbd_sc, bdp->cbd_datlen,
> +			 (int)bdp->cbd_bufaddr);
> +		bdp++;
> +	}
> +	spin_unlock_bh(&fep->hw_lock);
> +}
> +
> +static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +
> +	DO_ONCE(mtip_print_hw_state, dev);
> +
> +	schedule_work(&priv->tx_timeout_work);
              ^^^^

This isn't a regression, but as noted in your v22 response, timeouts are
already counted by the network stack and exposed per-queue in sysfs. Does
this driver need additional counting beyond what the stack provides?

> +}
> +
> +static void mtip_timeout_work(struct work_struct *work)
> +{
> +	struct mtip_ndev_priv *priv =
> +		container_of(work, struct mtip_ndev_priv, tx_timeout_work);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct net_device *dev = priv->dev;
> +
> +	rtnl_lock();
> +	if (netif_device_present(dev) || netif_running(dev)) {
> +		napi_disable(&fep->napi);
> +		netif_tx_lock_bh(dev);
> +		mtip_switch_restart(dev, fep->full_duplex[0],
> +				    fep->full_duplex[1]);
> +		netif_tx_wake_all_queues(dev);
> +		netif_tx_unlock_bh(dev);
> +		napi_enable(&fep->napi);
> +	}
> +	rtnl_unlock();
> +}

[ ... ]

> @@ -1096,6 +1286,92 @@ static int mtip_close(struct net_device *dev)
>  	return 0;
>  }
>
> +#define FEC_HASH_BITS	6		/* #bits in hash */
> +static void mtip_set_multicast_list(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	unsigned int hash_high = 0, hash_low = 0, crc;
> +	struct switch_enet_private *fep = priv->fep;
> +	void __iomem *enet_addr = fep->enet_addr;
> +	struct netdev_hw_addr *ha;
> +	unsigned char hash;
> +
> +	if (priv->portnum == 2)
> +		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
> +
> +	if (dev->flags & IFF_PROMISC) {
> +		/* Promisc mode is required for switch - it is
> +		 * already enabled during driver's probe.
> +		 */
> +		dev_dbg(&dev->dev, "%s: IFF_PROMISC\n", __func__);
> +		return;
> +	}
> +
> +	if (dev->flags & IFF_ALLMULTI) {
> +		dev_dbg(&dev->dev, "%s: IFF_ALLMULTI\n", __func__);
> +
> +		/* Allow all multicast addresses */
> +		writel(0xFFFFFFFF, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
> +		writel(0xFFFFFFFF, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
> +
> +		return;
> +	}
> +
> +	netdev_for_each_mc_addr(ha, dev) {
> +		/* Calculate crc32 value of mac address */
> +		crc = ether_crc_le(dev->addr_len, ha->addr);
> +
> +		/* Only upper 6 bits (FEC_HASH_BITS) are used
> +		 * which point to specific bit in the hash registers
> +		 */
> +		hash = (crc >> (32 - FEC_HASH_BITS)) & 0x3F;
> +
> +		if (hash > 31)
> +			hash_high |= 1 << (hash - 32);
> +		else
> +			hash_low |= 1 << hash;
> +	}
> +
> +	writel(hash_high, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
> +	writel(hash_low, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
> +}
> +
> +static int mtip_set_mac_address(struct net_device *dev, void *p)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	void __iomem *enet_addr = fep->enet_addr;
> +	struct sockaddr *addr = p;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +	eth_hw_addr_set(dev, addr->sa_data);
> +
> +	if (priv->portnum == 2)
> +		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
> +
> +	writel(dev->dev_addr[3] | (dev->dev_addr[2] << 8) |
> +	       (dev->dev_addr[1] << 16) | (dev->dev_addr[0] << 24),
> +	       enet_addr + MCF_FEC_PALR);
> +	writel((dev->dev_addr[5] << 16) | (dev->dev_addr[4] << 24),
> +	       enet_addr + MCF_FEC_PAUR);
> +
> +	return mtip_update_atable_static((unsigned char *)dev->dev_addr,
> +					 7, 7, fep);
                                         ^^^^

If mtip_update_atable_static() returns an error (like -ENOSPC when the
address table is full), the device MAC address has already been updated
by eth_hw_addr_set() and the hardware registers have been written.

This leaves the system with a MAC address in dev->dev_addr and the
hardware registers that isn't in the switch's address table. Should the
MAC address change be rolled back on error, or should the address table
be updated first before committing the MAC change?

> +}

[ ... ]

> @@ -1210,6 +1492,8 @@ static int mtip_ndev_init(struct switch_enet_private *fep,
>  			goto cleanup_created_ndev;
>  		}
>
> +		INIT_WORK(&priv->tx_timeout_work, mtip_timeout_work);
                 ^^^^

Could there be a race if a TX timeout occurs between register_netdev()
(which happens a few lines above at line 1488) and INIT_WORK() here?

At line 1478, netdev_ops is set to &mtip_netdev_ops which includes
.ndo_tx_timeout = mtip_timeout. Then register_netdev() is called at line
1488, making the device active. If a TX timeout occurs before
INIT_WORK() initializes the work struct, mtip_timeout() would call
schedule_work() on an uninitialized work struct.

Should INIT_WORK() be moved before register_netdev()?

> +
>  		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
>  			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
>  	}

