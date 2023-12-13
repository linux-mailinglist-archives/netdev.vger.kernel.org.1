Return-Path: <netdev+bounces-56802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063FE810DF8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B31F211B9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DF224E5;
	Wed, 13 Dec 2023 10:14:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C7CA5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:14:33 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
	by gateway (Coremail) with SMTP id _____8CxO+kIhHllfaEAAA--.3865S3;
	Wed, 13 Dec 2023 18:14:32 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.254])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx73MAhHll_jMCAA--.14361S3;
	Wed, 13 Dec 2023 18:14:28 +0800 (CST)
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
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v6 5/9] net: stmmac: Add Loongson-specific register definitions
Date: Wed, 13 Dec 2023 18:14:23 +0800
Message-Id: <40eff8db93b02599f00a156b07a0dcdacfc0fbf3.1702458672.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1702458672.git.siyanteng@loongson.cn>
References: <cover.1702458672.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx73MAhHll_jMCAA--.14361S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Zr17AFy7Ar48ZFykCFW7GFX_yoWkur15pa
	47Za98urWktr4xGa1kJ3yrXFy5J345KF9rCa18Xr4Sga93t34Yvryj9FW3JF1DGFW8ua47
	tFWDCw1UKFn8J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVWrXDUUUU

There are two types of Loongson DWGMAC. The first type shares the same
register definitions and has similar logic as dwmac1000. The second type
uses several different register definitions.

Simply put, we split some single bit fields into double bits fileds:

DMA_INTR_ENA_NIE = 0x00040000 + 0x00020000
DMA_INTR_ENA_AIE = 0x00010000 + 0x00008000
DMA_STATUS_NIS = 0x00040000 + 0x00020000
DMA_STATUS_AIS = 0x00010000 + 0x00008000
DMA_STATUS_FBI = 0x00002000 + 0x00001000

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 ++
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 10 ++++--
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 27 ++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 +++++++++++++++----
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  1 +
 include/linux/stmmac.h                        |  1 +
 8 files changed, 67 insertions(+), 10 deletions(-)

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
index 395d5e4c3922..e67769165b05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -70,16 +70,20 @@
 #define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
 
 /* DMA Normal interrupt */
+#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000	/* Normal Loongson Tx/Rx Summary */
 #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
 #define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
 #define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
 #define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
 #define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
 
+#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_LOONGSON | DMA_INTR_ENA_RIE | \
+			DMA_INTR_ENA_TIE)
 #define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
 			DMA_INTR_ENA_TIE)
 
 /* DMA Abnormal interrupt */
+#define DMA_INTR_ENA_AIE_LOONGSON 0x00018000	/* Abnormal Loongson Tx/Rx Summary */
 #define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
 #define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
 #define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
@@ -91,10 +95,13 @@
 #define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
 #define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
 
+#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_ENA_FBE | \
+				DMA_INTR_ENA_UNE)
 #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
 				DMA_INTR_ENA_UNE)
 
 /* DMA default interrupt mask */
+#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
 #define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
 #define DMA_INTR_DEFAULT_RX	(DMA_INTR_ENA_RIE)
 #define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
@@ -111,9 +118,12 @@
 #define DMA_STATUS_TS_SHIFT	20
 #define DMA_STATUS_RS_MASK	0x000e0000	/* Receive Process State */
 #define DMA_STATUS_RS_SHIFT	17
+#define DMA_STATUS_NIS_LOONGSON		0x00060000	/* Normal Loongson Tx/Rx Interrupt Summary */
 #define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
+#define DMA_STATUS_AIS_LOONGSON		0x00018000	/* Abnormal Loongson Tx/Rx Interrupt Summary */
 #define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
 #define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
+#define DMA_STATUS_FBI_LOONGSON		0x00003000	/* Fatal Loongson Tx/Rx Bus Error Interrupt */
 #define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
 #define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
 #define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
@@ -128,10 +138,20 @@
 #define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
 #define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
 
+#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_LOONGSON | \
+					 DMA_STATUS_AIS_LOONGSON | \
+					 DMA_STATUS_FBI_LOONGSON)
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
@@ -140,6 +160,13 @@
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
index 968801c694e9..c3363c8fc3ef 100644
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
@@ -176,13 +179,28 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
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
+		nor_intr_status = intr_status & DMA_STATUS_NIS_LOONGSON;
+		abnor_intr_status = intr_status & DMA_STATUS_AIS_LOONGSON;
+		fb_intr_status = intr_status & DMA_STATUS_FBI_LOONGSON;
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
@@ -205,13 +223,13 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
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


