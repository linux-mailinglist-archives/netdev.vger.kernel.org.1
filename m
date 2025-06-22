Return-Path: <netdev+bounces-200059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC4AE2F1F
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AC67A539C
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993E1D61BB;
	Sun, 22 Jun 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="L26q/jy6"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DC1DFE0B;
	Sun, 22 Jun 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750585116; cv=none; b=GcdOFxQRhrAchU7oDkwcG4GoBZMdNunKmjpOXTJ7xiyFYpO29eoareYUf9Z/o4I3Bp91w81kCH1D9Cg8T6zdwCayJb/b8Rt7SGbb1Qun9JsHIIzY2sy5nn8i7LzgyOVDU7DIkSDcXGth1Gbu99uPgf+jbaK3Bnk4lvAFAK0feMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750585116; c=relaxed/simple;
	bh=DYdOy5lABm31kq6y/I8VLBbT9ks4C2rjf3hNWWOLp0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxocL+y1LMD38XtfyHg0xJ39iJ/cOCRPBHUn2oXUBWhIp3gD2bY5usAgeiEU6GXdhRDeiey4qKWfysB5appcjNcPQiOKY7E//EmaSi96fbFtIj8axucjYN6SpTAsz4ZM7bGEynxeldLzZQSLJMHK8V0CcydqHAWQqQBv67YLuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=L26q/jy6; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1308310240A1F;
	Sun, 22 Jun 2025 11:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750585112; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=j4BpMxyOF15UQAmT2F1U9wzdJA6yVoOtBPOoNqyp8Tk=;
	b=L26q/jy63KhRMoVk+ckg0L9gSVJVPFO/6TV8icAoqsj2dHd7akk57tHFCM85iV7RBkRVtM
	+Y60v0j/lHwUYwyOFZ/O2gNILvH5KM9HvdRyi73jol6JPVltNldDhrDSuCHO9hCgxtQoQ+
	7JdMt61T+sylaiDgL+79ScFV+wp8xS1dIvipp3UXBPc4CvwJfRPh/FcHBBlLgR6mvBILhd
	1bP7F0gz7GCWJJo1IHeIeLdJVkdTOQQekBhostSCmMRHipRLLUrghzPmYNdfuicWoGI3/1
	Fcwma5y3u9KcdtNnukEqcvIPomcHeqOs+cV4WEcaSI71VTW/+gL3MEeQLDc/Lw==
From: Lukasz Majewski <lukma@denx.de>
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
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v13 05/11] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Sun, 22 Jun 2025 11:37:50 +0200
Message-Id: <20250622093756.2895000-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622093756.2895000-1-lukma@denx.de>
References: <20250622093756.2895000-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch provides callbacks for struct net_device_ops for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 273 ++++++++++++++++++
 1 file changed, 273 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 5142f647d939..813cd39d6d56 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -43,6 +43,15 @@
 
 #include "mtipl2sw.h"
 
+static void swap_buffer(void *bufaddr, int len)
+{
+	int i;
+	unsigned int *buf = bufaddr;
+
+	for (i = 0; i < len; i += 4, buf++)
+		swab32s(buf);
+}
+
 /* Set the last buffer to wrap */
 static void mtip_set_last_buf_to_wrap(struct cbd_t *bdp)
 {
@@ -444,6 +453,128 @@ static void mtip_config_switch(struct switch_enet_private *fep)
 	       fep->hwp + ESW_IMR);
 }
 
+static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
+					struct net_device *dev, int port)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status;
+	struct cbd_t *bdp;
+	void *bufaddr;
+
+	spin_lock_bh(&fep->hw_lock);
+
+	if (!fep->link[0] && !fep->link[1]) {
+		/* Link is down or autonegotiation is in progress. */
+		netif_stop_queue(dev);
+		spin_unlock_bh(&fep->hw_lock);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = fep->cur_tx;
+
+	status = bdp->cbd_sc;
+
+	if (status & BD_ENET_TX_READY) {
+		/* All transmit buffers are full. Bail out.
+		 * This should not happen, since dev->tbusy should be set.
+		 */
+		netif_stop_queue(dev);
+		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n", dev->name);
+		spin_unlock_bh(&fep->hw_lock);
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
+	/* On some FEC implementations data must be aligned on
+	 * 4-byte boundaries. Use bounce buffers to copy data
+	 * and get it aligned.spin
+	 */
+	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
+		unsigned int index;
+
+		index = bdp - fep->tx_bd_base;
+		memcpy(fep->tx_bounce[index],
+		       (void *)skb->data, skb->len);
+		bufaddr = fep->tx_bounce[index];
+	}
+
+	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		swap_buffer(bufaddr, skb->len);
+
+	/* Save skb pointer. */
+	fep->tx_skbuff[fep->skb_cur] = skb;
+
+	fep->skb_cur = (fep->skb_cur + 1) & TX_RING_MOD_MASK;
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
+		dev->stats.tx_errors++;
+		dev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		goto err;
+	}
+
+	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	 * it's the last BD of the frame, and to put the CRC on the end.
+	 */
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
+			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
+
+	/* Synchronize all descriptor writes */
+	wmb();
+	bdp->cbd_sc = status;
+
+	netif_trans_update(dev);
+	skb_tx_timestamp(skb);
+
+	/* Trigger transmission start */
+	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
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
+	if (bdp == fep->dirty_tx) {
+		fep->tx_full = 1;
+		netif_stop_queue(dev);
+	}
+
+	fep->cur_tx = bdp;
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
@@ -601,6 +732,68 @@ static void mtip_switch_restart(struct net_device *dev, int duplex0,
 	mtip_config_switch(fep);
 }
 
+static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	int i;
+
+	dev->stats.tx_errors++;
+
+	if (IS_ENABLED(CONFIG_SWITCH_DEBUG)) {
+		dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
+		dev_info(&dev->dev,
+			 "Ring data: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
+			 (unsigned long)fep->cur_tx,
+			 fep->tx_full ? " (full)" : "",
+			 (unsigned long)fep->dirty_tx,
+			 (unsigned long)fep->cur_rx);
+
+		bdp = fep->tx_bd_base;
+		dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
+		for (i = 0; i < TX_RING_SIZE; i++) {
+			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
+				 (kernel_ulong_t)bdp, bdp->cbd_sc,
+				 bdp->cbd_datlen, (int)bdp->cbd_bufaddr);
+			bdp++;
+		}
+
+		bdp = fep->rx_bd_base;
+		dev_info(&dev->dev, " rx: %lu buffers\n",
+			 (unsigned long)RX_RING_SIZE);
+		for (i = 0 ; i < RX_RING_SIZE; i++) {
+			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
+				 (kernel_ulong_t)bdp,
+				 bdp->cbd_sc, bdp->cbd_datlen,
+				 (int)bdp->cbd_bufaddr);
+			bdp++;
+		}
+	}
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
@@ -1080,6 +1273,80 @@ static int mtip_close(struct net_device *dev)
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
 static const struct ethtool_ops mtip_ethtool_ops = {
 	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
 	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
@@ -1091,6 +1358,10 @@ static const struct ethtool_ops mtip_ethtool_ops = {
 static const struct net_device_ops mtip_netdev_ops = {
 	.ndo_open		= mtip_open,
 	.ndo_stop		= mtip_close,
+	.ndo_start_xmit	= mtip_start_xmit,
+	.ndo_set_rx_mode	= mtip_set_multicast_list,
+	.ndo_tx_timeout	= mtip_timeout,
+	.ndo_set_mac_address	= mtip_set_mac_address,
 };
 
 bool mtip_is_switch_netdev_port(const struct net_device *ndev)
@@ -1192,6 +1463,8 @@ static int mtip_ndev_init(struct switch_enet_private *fep,
 			break;
 		}
 
+		INIT_WORK(&priv->tx_timeout_work, mtip_timeout_work);
+
 		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
 			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
 	}
-- 
2.39.5


