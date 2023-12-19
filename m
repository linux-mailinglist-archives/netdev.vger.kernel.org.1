Return-Path: <netdev+bounces-58927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C98189FB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C651F253B7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6B37863;
	Tue, 19 Dec 2023 14:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59C374FC
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8DxE_A0qIFlTaMCAA--.13377S3;
	Tue, 19 Dec 2023 22:27:00 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxneQxqIFlbHUAAA--.3423S2;
	Tue, 19 Dec 2023 22:26:58 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	fancer.lancer@gmail.com,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v7 5/9] net: stmmac: Add Loongson-specific register definitions
Date: Tue, 19 Dec 2023 22:26:45 +0800
Message-Id: <bbc826f622b501bc490e838644c9c502185a78df.1702990507.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1702990507.git.siyanteng@loongson.cn>
References: <cover.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxneQxqIFlbHUAAA--.3423S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Zr17AFy7Ar48ZFykCFW7GFX_yoW8JF1Duo
	ZxJF9aqFWrKw18ur4kKrn5WrW3Xrn8Xw43tFs7Gry8u39a9w15Way5Ja4fZr13tr1fGr9x
	Cw1ftF4DJw4aqrn5l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYt7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxxhdUUUUU=

There are two types of Loongson DWGMAC. The first type shares the same
register definitions and has similar logic as dwmac1000. The second type
uses several different register definitions, we think it is necessary to
distinguish rx and tx, so we split these bits into two.

Simply put, we split some single bit fields into double bits fileds:

     Name              Tx          Rx

DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
DMA_STATUS_FBI   = 0x00002000 | 0x00001000;

Therefore, when using, TX and RX must be set at the same time.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 ++
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 10 ++++--
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 35 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 35 +++++++++++++++----
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  1 +
 include/linux/stmmac.h                        |  1 +
 8 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..48ab21243b26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -34,6 +34,7 @@
 #define DWMAC_CORE_5_00		0x50
 #define DWMAC_CORE_5_10		0x51
 #define DWMAC_CORE_5_20		0x52
+#define DWLGMAC_CORE_1_00	0x10
 #define DWXGMAC_CORE_2_10	0x21
 #define DWXGMAC_CORE_2_20	0x22
 #define DWXLGMAC_CORE_2_00	0x20
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 0d79104d7fd3..fb7506bbc21b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -101,6 +101,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		plat->mdio_bus_data->needs_reset = true;
 	}
 
+	plat->flags |= STMMAC_FLAG_HAS_LGMAC;
+
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
 	if (ret) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 0fb48e683970..a01fe6b7540a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -118,7 +118,10 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 	u32 dma_intr_mask;
 
 	/* Mask interrupts by writing to CSR7 */
-	dma_intr_mask = DMA_INTR_DEFAULT_MASK;
+	if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC)
+		dma_intr_mask = DMA_INTR_DEFAULT_MASK_LOONGSON;
+	else
+		dma_intr_mask = DMA_INTR_DEFAULT_MASK;
 
 	dma_config(ioaddr + DMA_BUS_MODE, ioaddr + DMA_INTR_ENA,
 			  dma_cfg, dma_intr_mask, atds);
@@ -130,7 +133,10 @@ static void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *i
 	u32 dma_intr_mask;
 
 	/* Mask interrupts by writing to CSR7 */
-	dma_intr_mask = DMA_INTR_DEFAULT_MASK;
+	if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC)
+		dma_intr_mask = DMA_INTR_DEFAULT_MASK_LOONGSON;
+	else
+		dma_intr_mask = DMA_INTR_DEFAULT_MASK;
 
 	if (dma_cfg->multi_msi_en)
 		dma_config(ioaddr + DMA_CHAN_BUS_MODE(chan),
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 395d5e4c3922..7d33798c0e72 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -70,16 +70,23 @@
 #define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
 
 /* DMA Normal interrupt */
+#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000	/* Normal Loongson Tx Summary */
+#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000	/* Normal Loongson Rx Summary */
 #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
 #define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
 #define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
 #define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
 #define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
 
+#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
+			 DMA_INTR_ENA_NIE_RX_LOONGSON | DMA_INTR_ENA_RIE | \
+			 DMA_INTR_ENA_TIE)
 #define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
 			DMA_INTR_ENA_TIE)
 
 /* DMA Abnormal interrupt */
+#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000	/* Abnormal Loongson Tx Summary */
+#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000	/* Abnormal Loongson Rx Summary */
 #define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
 #define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
 #define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
@@ -91,10 +98,14 @@
 #define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
 #define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
 
+#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
+				DMA_INTR_ENA_AIE_RX_LOONGSON | DMA_INTR_ENA_FBE | \
+				DMA_INTR_ENA_UNE)
 #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
 				DMA_INTR_ENA_UNE)
 
 /* DMA default interrupt mask */
+#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
 #define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
 #define DMA_INTR_DEFAULT_RX	(DMA_INTR_ENA_RIE)
 #define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
@@ -111,9 +122,15 @@
 #define DMA_STATUS_TS_SHIFT	20
 #define DMA_STATUS_RS_MASK	0x000e0000	/* Receive Process State */
 #define DMA_STATUS_RS_SHIFT	17
+#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000	/* Normal Loongson Tx Interrupt Summary */
+#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000	/* Normal Loongson Rx Interrupt Summary */
 #define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
+#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000	/* Abnormal Loongson Tx Interrupt Summary */
+#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000	/* Abnormal Loongson Rx Interrupt Summary */
 #define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
 #define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
+#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000	/* Fatal Loongson Tx Bus Error Interrupt */
+#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000	/* Fatal Loongson Rx Bus Error Interrupt */
 #define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
 #define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
 #define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
@@ -128,10 +145,21 @@
 #define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
 #define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
 
+#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_TX_LOONGSON | \
+					 DMA_STATUS_NIS_RX_LOONGSON | DMA_STATUS_AIS_TX_LOONGSON | \
+					 DMA_STATUS_AIS_RX_LOONGSON | DMA_STATUS_FBI_TX_LOONGSON | \
+					 DMA_STATUS_FBI_RX_LOONGSON)
 #define DMA_STATUS_MSK_COMMON		(DMA_STATUS_NIS | \
 					 DMA_STATUS_AIS | \
 					 DMA_STATUS_FBI)
 
+#define DMA_STATUS_MSK_RX_LOONGSON		(DMA_STATUS_ERI | \
+					 DMA_STATUS_RWT | \
+					 DMA_STATUS_RPS | \
+					 DMA_STATUS_RU | \
+					 DMA_STATUS_RI | \
+					 DMA_STATUS_OVF | \
+					 DMA_STATUS_MSK_COMMON_LOONGSON)
 #define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
 					 DMA_STATUS_RWT | \
 					 DMA_STATUS_RPS | \
@@ -140,6 +168,13 @@
 					 DMA_STATUS_OVF | \
 					 DMA_STATUS_MSK_COMMON)
 
+#define DMA_STATUS_MSK_TX_LOONGSON		(DMA_STATUS_ETI | \
+					 DMA_STATUS_UNF | \
+					 DMA_STATUS_TJT | \
+					 DMA_STATUS_TU | \
+					 DMA_STATUS_TPS | \
+					 DMA_STATUS_TI | \
+					 DMA_STATUS_MSK_COMMON_LOONGSON)
 #define DMA_STATUS_MSK_TX		(DMA_STATUS_ETI | \
 					 DMA_STATUS_UNF | \
 					 DMA_STATUS_TJT | \
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 968801c694e9..a6e2ab4d0f4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -167,6 +167,9 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
 	int ret = 0;
 	/* read the status register (CSR5) */
+	u32 nor_intr_status;
+	u32 abnor_intr_status;
+	u32 fb_intr_status;
 	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
 
 #ifdef DWMAC_DMA_DEBUG
@@ -176,13 +179,31 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	show_rx_process_state(intr_status);
 #endif
 
-	if (dir == DMA_DIR_RX)
-		intr_status &= DMA_STATUS_MSK_RX;
-	else if (dir == DMA_DIR_TX)
-		intr_status &= DMA_STATUS_MSK_TX;
+	if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC) {
+		if (dir == DMA_DIR_RX)
+			intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
+		else if (dir == DMA_DIR_TX)
+			intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
+
+		nor_intr_status = intr_status & \
+			(DMA_STATUS_NIS_TX_LOONGSON | DMA_STATUS_NIS_RX_LOONGSON);
+		abnor_intr_status = intr_status & \
+			(DMA_STATUS_AIS_TX_LOONGSON | DMA_STATUS_AIS_RX_LOONGSON);
+		fb_intr_status = intr_status & \
+			(DMA_STATUS_FBI_TX_LOONGSON | DMA_STATUS_FBI_RX_LOONGSON);
+	} else {
+		if (dir == DMA_DIR_RX)
+			intr_status &= DMA_STATUS_MSK_RX;
+		else if (dir == DMA_DIR_TX)
+			intr_status &= DMA_STATUS_MSK_TX;
+
+		nor_intr_status = intr_status & DMA_STATUS_NIS;
+		abnor_intr_status = intr_status & DMA_STATUS_AIS;
+		fb_intr_status = intr_status & DMA_STATUS_FBI;
+	}
 
 	/* ABNORMAL interrupts */
-	if (unlikely(intr_status & DMA_STATUS_AIS)) {
+	if (unlikely(abnor_intr_status)) {
 		if (unlikely(intr_status & DMA_STATUS_UNF)) {
 			ret = tx_hard_error_bump_tc;
 			x->tx_undeflow_irq++;
@@ -205,13 +226,13 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->tx_process_stopped_irq++;
 			ret = tx_hard_error;
 		}
-		if (unlikely(intr_status & DMA_STATUS_FBI)) {
+		if (unlikely(intr_status & fb_intr_status)) {
 			x->fatal_bus_error_irq++;
 			ret = tx_hard_error;
 		}
 	}
 	/* TX/RX NORMAL interrupts */
-	if (likely(intr_status & DMA_STATUS_NIS)) {
+	if (likely(nor_intr_status)) {
 		if (likely(intr_status & DMA_STATUS_RI)) {
 			u32 value = readl(ioaddr + DMA_INTR_ENA);
 			/* to schedule NAPI on real RIE event. */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 1bd34b2a47e8..3724cf698de6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -59,7 +59,8 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
 		dev_info(priv->device, "Enhanced/Alternate descriptors\n");
 
 		/* GMAC older than 3.50 has no extended descriptors */
-		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
+		if (priv->synopsys_id >= DWMAC_CORE_3_50 ||
+		    priv->synopsys_id == DWLGMAC_CORE_1_00) {
 			dev_info(priv->device, "Enabled extended descriptors\n");
 			priv->extend_desc = 1;
 		} else {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d868eb8dafc5..9764d2ab7e46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7218,6 +7218,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	 * riwt_off field from the platform.
 	 */
 	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
+		(priv->synopsys_id == DWLGMAC_CORE_1_00) ||
 	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
 		priv->use_riwt = 1;
 		dev_info(priv->device,
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..f07f79d50b06 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -221,6 +221,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
+#define STMMAC_FLAG_HAS_LGMAC			BIT(13)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


