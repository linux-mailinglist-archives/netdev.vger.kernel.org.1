Return-Path: <netdev+bounces-293836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODf6BI21HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:38:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF30622AE8
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981E5300A8F6
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F32F12AD;
	Mon,  1 Jun 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SZbsmljs"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014E2E7631
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331189; cv=none; b=NMGA4ERF5bAQ1ve3imE2HE/QCik8zemlfCXvxv0NrDXNAkEzTQeBlUz9Ifaj6pGqOArbxfTHM9Ev9T2DQhySEgYVU0ZdegvmKhdOLU7zjJTnT14VC0qZZ9vPIcX5a7NYje6yXSUQcIYJN6FrIvqEqVJulZdIWeswdwRkeUKt5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331189; c=relaxed/simple;
	bh=nj4fzgifisduH7ZGG0fhR1LVwW6MnBf2N9g1XHJ/Cmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kPMim0NAeErCFGUm/H8iG7lHxyZcUtUXj3SUSOfowSloHTST8uxVhrN4Bw5IldpSKsNP2Xmboq3sx92hdigxLFMCQ+DOalbaIFv5UFGqxQTuPSLiXZgidqsXRCUffG7l6K+WgfPsKXaRzkEierWmLiUFXEBuQzUBwB1GjaC3TsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SZbsmljs; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260601162619euoutp01272d6f4463e5915455c5c85410889294~1AcZbNYTU1194511945euoutp01f
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260601162619euoutp01272d6f4463e5915455c5c85410889294~1AcZbNYTU1194511945euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331179;
	bh=c2isF21Vx5gYj71XrYM1D5hx1FyWGJqKZ9gQBxw/ppQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZbsmljswokUQTTRQ5KO1yV4UxCfbVON7YZ1tVFOXi5KFsmfv799tz7MsPM+iHArT
	 UREj8TTYIwdlxWuG7WH112CyxC+6YKLnIFmsahnoTvskeUw6c7c/9RfbqngNFOUHjH
	 3S2YxIbSx+WFkS8HuxjFIo5+28e1AeLAlfltQzfs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28~1AcYoMQ751910019100eucas1p1N;
	Mon,  1 Jun 2026 16:26:18 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162617eusmtip159a7951e408ec0c843e72e8b46bcbb5f~1AcXxW42R0826608266eusmtip1d;
	Mon,  1 Jun 2026 16:26:17 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 1/3] net/stmmac/dwxgmac: Modify DMA functions
 for future hardware
Date: Mon,  1 Jun 2026 18:25:35 +0200
Message-Id: <20260601162537.553512-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601162537.553512-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
X-EPHeader: CA
X-CMS-RootMailID: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28@eucas1p1.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293836-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: 6CF30622AE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Datasheet for newer hardware of XGMAC (3.20a and 3.40a) list support for
up to 16 DMA/MTL queues. Currently maximum amount of queues in 8 set by
STMMAC_CH_MAX, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES macros.
But before we set these to higher value there are changes to be made.

While newer hardware supports up to 16 MTL/DMA queues, there is support only
for 8 TC's (traffic control) entries. Current source assumes these are equal,
which might not be true. While in some cases it would be just incorrect value,
there are possible wrong memory accesses.

Fix this by saving number of TC supported by hardware in mac_device_info and
verify it in related functions. Also use TC count rather than MTL_MAX values
where it applies.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 46 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 15 +++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 5 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 927ea6230073..359a76d3658c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -620,6 +620,7 @@ struct mac_device_info {
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
 	const struct stmmac_vlan_ops *vlan;
+	struct stmmac_priv *priv_data;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..dbedf31bb2ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -97,11 +97,19 @@ static void dwxgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
+	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
+	struct net_device *ndev = hw->priv_data->dev;
 	void __iomem *ioaddr = hw->pcsr;
 	u32 clear_mask = 0;
 	u32 ctrl2, ctrl3;
 	int i;
 
+	if (queue >= numtc) {
+		netdev_err(ndev, "%s: invalid TC queue %d, supported %d\n",
+			   __func__, queue, numtc);
+		return;
+	}
+
 	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
 	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
 
@@ -138,9 +146,17 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
+	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
+	struct net_device *ndev = hw->priv_data->dev;
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
+	if (queue >= numtc) {
+		netdev_err(ndev, "%s: invalid TC queue %d, supported %d\n",
+			   __func__, queue, numtc);
+		return;
+	}
+
 	reg = (queue < 4) ? XGMAC_TC_PRTY_MAP0 : XGMAC_TC_PRTY_MAP1;
 	if (queue >= 4)
 		queue -= 4;
@@ -207,6 +223,7 @@ static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
 static void dwxgmac2_prog_mtl_tx_algorithms(struct mac_device_info *hw,
 					    u32 tx_alg)
 {
+	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
 	void __iomem *ioaddr = hw->pcsr;
 	bool ets = true;
 	u32 value;
@@ -233,7 +250,7 @@ static void dwxgmac2_prog_mtl_tx_algorithms(struct mac_device_info *hw,
 	writel(value, ioaddr + XGMAC_MTL_OPMODE);
 
 	/* Set ETS if desired */
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+	for (i = 0; i < numtc; i++) {
 		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
 		value &= ~XGMAC_TSA;
 		if (ets)
@@ -246,8 +263,15 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
 					     struct mac_device_info *hw,
 					     u32 weight, u32 queue)
 {
+	const unsigned int numtc = priv->dma_cap.numtc;
 	void __iomem *ioaddr = hw->pcsr;
 
+	if (queue >= numtc) {
+		netdev_err(priv->dev, "%s: invalid TC queue %d, supported %d\n",
+			   __func__, queue, numtc);
+		return;
+	}
+
 	writel(weight, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
 }
 
@@ -273,9 +297,16 @@ static void dwxgmac2_config_cbs(struct stmmac_priv *priv,
 				u32 send_slope, u32 idle_slope,
 				u32 high_credit, u32 low_credit, u32 queue)
 {
+	const unsigned int numtc = priv->dma_cap.numtc;
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
+	if (queue >= numtc) {
+		netdev_err(priv->dev, "%s: invalid TC queue %d, supported %d\n",
+			   __func__, queue, numtc);
+		return;
+	}
+
 	writel(send_slope, ioaddr + XGMAC_MTL_TCx_SENDSLOPE(queue));
 	writel(idle_slope, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
 	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(queue));
@@ -357,6 +388,8 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 			       unsigned int fc, unsigned int pause_time,
 			       u8 tx_cnt)
 {
+	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
+	struct net_device *ndev = hw->priv_data->dev;
 	void __iomem *ioaddr = hw->pcsr;
 	u8 i;
 
@@ -366,6 +399,17 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 		for (i = 0; i < tx_cnt; i++) {
 			u32 value = XGMAC_TFE;
 
+			if (i >= numtc) {
+				netdev_err(ndev,
+					   "%s: invalid TC queue %d, supported %d\n",
+					   __func__, i, numtc);
+				/* This will skip all other wrong channels,
+				 * but triggering this is preceded by warnings
+				 * from other functions, so limit the spam.
+				 */
+				break;
+			}
+
 			if (duplex)
 				value |= FIELD_PREP(XGMAC_PT, pause_time);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..f70eaa181dad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -204,8 +204,19 @@ static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 		value = u32_replace_bits(value, ttc, XGMAC_TTC);
 	}
 
-	/* Use static TC to Queue mapping */
-	value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);
+	/* Newer XGMAC hardware does support up to 16 MTL/DMA queues but
+	 * only 8 traffic class queues. Redirect these, but this is error in
+	 * configuration.
+	 */
+	if (channel >= priv->dma_cap.numtc) {
+		netdev_err(priv->dev,
+			   "%s: Wrong channel set for TX mode redirecting to TC 0\n",
+			   __func__);
+		value |= FIELD_PREP(XGMAC_Q2TCMAP, 0);
+	} else {
+		/* Use static TC to Queue mapping */
+		value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);
+	}
 
 	if (qmode != MTL_QUEUE_AVB)
 		txqen = 0x2;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 511b0fd5e834..52842366ae0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -368,6 +368,9 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Assign priv struct internally for easier processing */
+	mac->priv_data = priv;
+
 	/* Only use generic HW helpers if needed */
 	mac->desc = mac->desc ? : entry->desc;
 	mac->dma = mac->dma ? : entry->dma;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..5917bf47c7de 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4140,7 +4140,7 @@ static int __stmmac_open(struct net_device *dev,
 	u8 chan;
 	int ret;
 
-	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
+	for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
-- 
2.34.1


