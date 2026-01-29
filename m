Return-Path: <netdev+bounces-254753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH1uILA+e2l+CwIAu9opvQ
	(envelope-from <netdev+bounces-254753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:04:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B49AF5CD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E13C13012B34
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC33385ECF;
	Thu, 29 Jan 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pGJpzxNP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="saXoKusS"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855D3859E3;
	Thu, 29 Jan 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684573; cv=none; b=KD1XySDW6ez3WJpoCVxlTNSW1kt/ALJyPzbpbhHeoV8OTEtJYwGlXT35eL6WMKBn+xAhm9Bmv0fNp6YIVpQNNjpGm8lrJ1H1bSuR2VnY64UVKP3I9gqT50fFz7AwS1MUiLanw6yvu0Eqp8ClO5iULfJgbvU89WDygB6uDMwOms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684573; c=relaxed/simple;
	bh=GEKhR9HBkoSdgyDdTZf0bKFt7zLfEgOiLwzrNrXuI8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzSir2FbUHsxSjGqdE7v5ZpWZqbuRUPsoTLvLPrt3HQyAx3Z99PEQv4eYb3AdZ4kbifGe4Zw9xt6W25axjZvFQwpwQYT/48YjYhFYzkvHKjZjd3NaXmnN/FcNTKM2usdUD9vSDCeI57rjfOldRqo1kicZXeBU218OGMZs+m+9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pGJpzxNP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=saXoKusS; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1x7Y4Qffz9vCQ;
	Thu, 29 Jan 2026 12:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769684569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBwZfnApXcexxhZjxmPmH0CD3Bf/poqikou2YO/JfTw=;
	b=pGJpzxNPpGYf6Mb/Ldl3o0AEOSzDg29xwaAzHYhEf/biSXdTG6H+/nzZlAnWvskntxIgJ8
	b3G69ibiPk2w6pDTG6ovnSnxmwtPS0FoLkasjsj/9gcHhVS2CtaQo2MdZ5BrXp6+6SPuTg
	ZwrhvAVuhfBCo+wxTgF7FmNH6SNGgOsk+LeIUlq5ceaHDf9ij2UC+X6gu5OZIS7C6IppU7
	iFabkCq4ZRwlSxuYTKPyV2v10Qf4SS4RmeNH7ynaSs05/VpK60DwtFc3EUC7pTUdNv27iu
	1pk3OyAPpcGA3OcaXnLiR/CjRsCgJWrqFptdz/uklcM4IRtKAV2Zad5PpXNC5Q==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769684567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBwZfnApXcexxhZjxmPmH0CD3Bf/poqikou2YO/JfTw=;
	b=saXoKusSzLYlDWCGWgcnoOmAqAA2dq/wPKR4MulXzkvq0xZC3GtoBcvNq6nxb1/6nL9klr
	ZPSL+7dJl865xMcb97OnsoHfpwpICuE3wN267E97ehPMqOXlChuRIeNRfQBz58bgc14Rj5
	61hBgphJnXgvo6KrAnkJGzG7nFYNgZ9jXsExjKFdmHW+bTEoRVHdIZFGcjSLjvyVXTpUAb
	gFM353lH93vij9NeMT3mSq4G1/Vsb+eSHx81fObtsmNDG5p0BaacbXz2BZij1NVQWnAM/k
	VgUB38ZYpqxINliaeQwjoFCN0rOkZuxDyUXNKg2OYjwcAfrZXlnnFm+fA4XUJA==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v21 4/7] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Thu, 29 Jan 2026 12:01:51 +0100
Message-Id: <20260129110154.1699976-5-lukasz.majewski@mailbox.org>
In-Reply-To: <20260129110154.1699976-1-lukasz.majewski@mailbox.org>
References: <20260129110154.1699976-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0751da6d9cbc8e8f18d
X-MBO-RS-META: t9g19un8he79osckwni1kyymfi99ijky
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,mailbox.org:server fail];
	TAGGED_FROM(0.00)[bounces-254753-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:dkim,mailbox.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2B49AF5CD
X-Rspamd-Action: no action

This patch provides callbacks for struct net_device_ops for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>

---
Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14:
- Add read memory barier (rmb) before reading current descriptor
- Use proper locking primitives

Changes for v15 - v15:
- None

Changes for v16:
- Enable MTIP ports to support bridge offloading
- Use dev_err_ratelimited() instead of plain dev_err()
- Move skb storage and tx ring buffer modifications after
  dma mapping code.
- Do not increase tx_errors when frames are dropped after
  failed dma_mapping.
- Refactor the code for better readability
- Remove legacy call to netif_trans_update()
- Remove not needed rmb() - synchronized data read already assured by
  coherent DMA allocation
- Replace spin_{un}lock() with _bh variant

Changes for v17:
- Add missing _bh() variant of spin_unlock
- Avoid reverse christmas tree in swap_buffer()
- Print error message after unlock
- Add DO_ONCE() and a separate function to print state of switch HW
- Remove dev->stats.tx_errors++

Changes for v18 - v19:
- None

Changes for v20:
- Perform data swap on SKB data only when it is copied to a separate
  buffer.
- Clean up the comment
- Stop both network interfaces' TX queues when no resources for
  transmission available (uDMA0 descriptors)
- Do not use fep->skb_cur and fep->tx_full

Changes for v21:
- None
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 284 ++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index e242f6b90068..364ba9010db4 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -43,6 +43,15 @@
 
 #include "mtipl2sw.h"
 
+static void swap_buffer(void *bufaddr, int len)
+{
+	unsigned int *buf = bufaddr;
+	int i;
+
+	for (i = 0; i < len; i += 4, buf++)
+		swab32s(buf);
+}
+
 /* Set the last buffer to wrap */
 static void mtip_set_last_buf_to_wrap(struct cbd_t *bdp)
 {
@@ -454,6 +463,120 @@ static void mtip_config_switch(struct switch_enet_private *fep)
 	       fep->hwp + ESW_IMR);
 }
 
+static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
+					struct net_device *dev, int port)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status;
+	unsigned int index;
+	struct cbd_t *bdp;
+	void *bufaddr;
+
+	spin_lock_bh(&fep->hw_lock);
+
+	if (!fep->link[0] && !fep->link[1]) {
+		/* Link is down or autonegotiation is in progress. */
+		mtip_netif_stop_queues(fep);
+		spin_unlock_bh(&fep->hw_lock);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = fep->cur_tx;
+	status = bdp->cbd_sc;
+
+	if (status & BD_ENET_TX_READY) {
+		/* All transmit buffers are full. Bail out. */
+		mtip_netif_stop_queues(fep);
+		spin_unlock_bh(&fep->hw_lock);
+		dev_err_ratelimited(&fep->pdev->dev, "%s: tx queue full!.\n",
+				    dev->name);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Clear all of the status flags */
+	status &= ~BD_ENET_TX_STATS;
+
+	/* Set buffer length and buffer pointer */
+	bufaddr = skb->data;
+	bdp->cbd_datlen = skb->len;
+
+	index = bdp - fep->tx_bd_base;
+	/* On some FEC implementations data must be aligned on
+	 * 4-byte boundaries. Use bounce buffers to copy data
+	 * and get it aligned.
+	 */
+	if ((unsigned long)bufaddr & MTIP_ALIGNMENT ||
+	    fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		memcpy(fep->tx_bounce[index], skb->data, skb->len);
+		bufaddr = fep->tx_bounce[index];
+
+		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+			swap_buffer(bufaddr, skb->len);
+	}
+
+	/* Push the data cache so the CPM does not get stale memory
+	 * data.
+	 */
+	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
+					  MTIP_SWITCH_TX_FRSIZE,
+					  DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr))) {
+		dev_err(&fep->pdev->dev,
+			"Failed to map descriptor tx buffer\n");
+		dev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		goto err;
+	}
+
+	/* Save skb pointer. */
+	fep->tx_skbuff[index] = skb;
+
+	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	 * it's the last BD of the frame, and to put the CRC on the end.
+	 */
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR | BD_ENET_TX_LAST |
+		   BD_ENET_TX_TC);
+
+	/* Synchronize all descriptor writes */
+	wmb();
+	bdp->cbd_sc = status;
+
+	skb_tx_timestamp(skb);
+
+	dev->stats.tx_bytes += skb->len;
+	/* If this was the last BD in the ring,
+	 * start at the beginning again.
+	 */
+	if (status & BD_ENET_TX_WRAP)
+		bdp = fep->tx_bd_base;
+	else
+		bdp++;
+
+	fep->cur_tx = bdp;
+	/* When TX descriptors' ring buffer is full stop both interfaces */
+	if (fep->cur_tx == fep->dirty_tx)
+		mtip_netif_stop_queues(fep);
+
+	/* Trigger transmission start */
+	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
+
+ err:
+	spin_unlock_bh(&fep->hw_lock);
+
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t mtip_start_xmit(struct sk_buff *skb,
+				   struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+
+	return mtip_start_xmit_port(skb, dev, priv->portnum);
+}
+
 static void mtip_configure_enet_mii(struct switch_enet_private *fep, int port)
 {
 	struct phy_device *phydev = fep->phy_dev[port - 1];
@@ -609,6 +732,74 @@ static void mtip_switch_restart(struct net_device *dev, int duplex0,
 	mtip_config_switch(fep);
 }
 
+static void mtip_print_hw_state(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	bool tx_full;
+	int i;
+
+	spin_lock_bh(&fep->hw_lock);
+	tx_full = fep->dirty_tx == fep->cur_tx &&
+		mtip_netif_queues_stopped(fep);
+
+	dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
+	dev_info(&dev->dev,
+		 "Ring data: cur_tx 0x%p%s, dirty_tx 0x%p cur_rx: 0x%p\n",
+		 fep->cur_tx, tx_full ? " (full)" : "", fep->dirty_tx,
+		 fep->cur_rx);
+
+	bdp = fep->tx_bd_base;
+	dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		dev_info(&dev->dev, "  0x%p: %04x %04x %08x\n",
+			 bdp, bdp->cbd_sc, bdp->cbd_datlen,
+			 (int)bdp->cbd_bufaddr);
+		bdp++;
+	}
+
+	bdp = fep->rx_bd_base;
+	dev_info(&dev->dev, " rx: %lu buffers\n", RX_RING_SIZE);
+	for (i = 0 ; i < RX_RING_SIZE; i++) {
+		dev_info(&dev->dev, "  0x%p: %04x %04x %08x\n",
+			 bdp, bdp->cbd_sc, bdp->cbd_datlen,
+			 (int)bdp->cbd_bufaddr);
+		bdp++;
+	}
+	spin_unlock_bh(&fep->hw_lock);
+}
+
+static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+
+	dev->stats.tx_errors++;
+	DO_ONCE(mtip_print_hw_state, dev);
+
+	schedule_work(&priv->tx_timeout_work);
+}
+
+static void mtip_timeout_work(struct work_struct *work)
+{
+	struct mtip_ndev_priv *priv =
+		container_of(work, struct mtip_ndev_priv, tx_timeout_work);
+	struct switch_enet_private *fep = priv->fep;
+	struct net_device *dev = priv->dev;
+
+	rtnl_lock();
+	if (netif_device_present(dev) || netif_running(dev)) {
+		napi_disable(&fep->napi);
+		netif_tx_lock_bh(dev);
+		mtip_switch_restart(dev, fep->full_duplex[0],
+				    fep->full_duplex[1]);
+		netif_tx_wake_all_queues(dev);
+		netif_tx_unlock_bh(dev);
+		napi_enable(&fep->napi);
+	}
+	rtnl_unlock();
+}
+
 static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
 {
 	struct switch_enet_private *fep = ptr_fep;
@@ -1089,6 +1280,92 @@ static int mtip_close(struct net_device *dev)
 	return 0;
 }
 
+#define FEC_HASH_BITS	6		/* #bits in hash */
+static void mtip_set_multicast_list(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	unsigned int hash_high = 0, hash_low = 0, crc;
+	struct switch_enet_private *fep = priv->fep;
+	void __iomem *enet_addr = fep->enet_addr;
+	struct netdev_hw_addr *ha;
+	unsigned char hash;
+
+	if (priv->portnum == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	if (dev->flags & IFF_PROMISC) {
+		/* Promisc mode is required for switch - it is
+		 * already enabled during driver's probe.
+		 */
+		dev_dbg(&dev->dev, "%s: IFF_PROMISC\n", __func__);
+		return;
+	}
+
+	if (dev->flags & IFF_ALLMULTI) {
+		dev_dbg(&dev->dev, "%s: IFF_ALLMULTI\n", __func__);
+
+		/* Allow all multicast addresses */
+		writel(0xFFFFFFFF, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
+		writel(0xFFFFFFFF, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
+
+		return;
+	}
+
+	netdev_for_each_mc_addr(ha, dev) {
+		/* Calculate crc32 value of mac address */
+		crc = ether_crc_le(dev->addr_len, ha->addr);
+
+		/* Only upper 6 bits (FEC_HASH_BITS) are used
+		 * which point to specific bit in the hash registers
+		 */
+		hash = (crc >> (32 - FEC_HASH_BITS)) & 0x3F;
+
+		if (hash > 31)
+			hash_high |= 1 << (hash - 32);
+		else
+			hash_low |= 1 << hash;
+	}
+
+	writel(hash_high, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
+	writel(hash_low, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
+}
+
+static int mtip_set_mac_address(struct net_device *dev, void *p)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	void __iomem *enet_addr = fep->enet_addr;
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+	eth_hw_addr_set(dev, addr->sa_data);
+
+	if (priv->portnum == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	writel(dev->dev_addr[3] | (dev->dev_addr[2] << 8) |
+	       (dev->dev_addr[1] << 16) | (dev->dev_addr[0] << 24),
+	       enet_addr + MCF_FEC_PALR);
+	writel((dev->dev_addr[5] << 16) | (dev->dev_addr[4] << 24),
+	       enet_addr + MCF_FEC_PAUR);
+
+	return mtip_update_atable_static((unsigned char *)dev->dev_addr,
+					 7, 7, fep);
+}
+
+static int mtip_get_port_parent_id(struct net_device *ndev,
+				   struct netdev_phys_item_id *ppid)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev);
+	struct switch_enet_private *fep = priv->fep;
+
+	ppid->id_len = sizeof(fep->mac[0]);
+	memcpy(&ppid->id, &fep->mac[0], ppid->id_len);
+
+	return 0;
+}
+
 static const struct ethtool_ops mtip_ethtool_ops = {
 	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
 	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
@@ -1100,6 +1377,11 @@ static const struct ethtool_ops mtip_ethtool_ops = {
 static const struct net_device_ops mtip_netdev_ops = {
 	.ndo_open		= mtip_open,
 	.ndo_stop		= mtip_close,
+	.ndo_start_xmit	= mtip_start_xmit,
+	.ndo_set_rx_mode	= mtip_set_multicast_list,
+	.ndo_tx_timeout	= mtip_timeout,
+	.ndo_set_mac_address	= mtip_set_mac_address,
+	.ndo_get_port_parent_id	= mtip_get_port_parent_id,
 };
 
 bool mtip_is_switch_netdev_port(const struct net_device *ndev)
@@ -1204,6 +1486,8 @@ static int mtip_ndev_init(struct switch_enet_private *fep,
 			goto cleanup_created_ndev;
 		}
 
+		INIT_WORK(&priv->tx_timeout_work, mtip_timeout_work);
+
 		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
 			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
 	}
-- 
2.39.5


