Return-Path: <netdev+bounces-21735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00576484D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF71C214FC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19866C2E2;
	Thu, 27 Jul 2023 07:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020ACC2C8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:18:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFE883C2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:18:11 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8BxHOsyGsJkHpwKAA--.21313S3;
	Thu, 27 Jul 2023 15:18:10 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB80wGsJkNLc8AA--.24390S2;
	Thu, 27 Jul 2023 15:18:09 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v2 02/10] net: stmmac: dwmac1000: Allow platforms to choose some register offsets
Date: Thu, 27 Jul 2023 15:18:04 +0800
Message-Id: <067f87d9785849c13f2f8733d457ffe8616a1aa0.1690439335.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1690439335.git.chenfeiyang@loongson.cn>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxB80wGsJkNLc8AA--.24390S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfGFyUKr48Jw4fWr4UCryrKrX_yoW8WFW8Go
	ZrJFZIvr48Kw1xCr4DCr1rWr90yr1kJa13Ja1rGrWkZa9agryDGFW5JFyfuF43tryxKF45
	Aw1xtF1DA34Yv3Z5l-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYZ7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6rWY6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVWrXDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some platforms have dwmac1000 implementations that have a different
address space layout than the default. Extend the macro to allow a
platform driver to choose the appropriate register offsets.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  14 +-
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |   3 +
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 205 +++++++++---------
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  41 ++++
 include/linux/stmmac.h                        |  48 ++++
 5 files changed, 210 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index b52793edf62f..9015a61f804c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -19,6 +19,7 @@
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
+#include "dwmac_dma.h"
 
 static void dwmac1000_core_init(struct mac_device_info *hw,
 				struct net_device *dev)
@@ -527,12 +528,10 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
 
-int dwmac1000_setup(struct stmmac_priv *priv)
+static int _dwmac1000_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
 
-	dev_info(priv->device, "\tDWMAC1000\n");
-
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 	mac->pcsr = priv->ioaddr;
 	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
@@ -558,3 +557,12 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 
 	return 0;
 }
+
+int dwmac1000_setup(struct stmmac_priv *priv)
+{
+	dev_info(priv->device, "\tDWMAC1000\n");
+
+	priv->plat->dwmac_regs = &dwmac_default_dma_regs;
+
+	return _dwmac1000_setup(priv);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index c03623edeb75..73ee16549775 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include "stmmac.h"
 #include "dwmac100.h"
+#include "dwmac_dma.h"
 
 static void dwmac100_core_init(struct mac_device_info *hw,
 			       struct net_device *dev)
@@ -177,6 +178,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 
 	dev_info(priv->device, "\tDWMAC100\n");
 
+	priv->plat->dwmac_regs = &dwmac_default_dma_regs;
+
 	mac->pcsr = priv->ioaddr;
 	mac->link.duplex = MAC_CONTROL_F;
 	mac->link.speed10 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index e7aef136824b..915a4d70fd3b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -11,38 +11,49 @@
 #ifndef __DWMAC_DMA_H__
 #define __DWMAC_DMA_H__
 
-/* DMA CRS Control and Status Register Mapping */
-#define DMA_BUS_MODE		0x00001000	/* Bus Mode */
-#define DMA_XMT_POLL_DEMAND	0x00001004	/* Transmit Poll Demand */
-#define DMA_RCV_POLL_DEMAND	0x00001008	/* Received Poll Demand */
-#define DMA_RCV_BASE_ADDR	0x0000100c	/* Receive List Base */
-#define DMA_TX_BASE_ADDR	0x00001010	/* Transmit List Base */
-#define DMA_STATUS		0x00001014	/* Status Register */
-#define DMA_CONTROL		0x00001018	/* Ctrl (Operational Mode) */
-#define DMA_INTR_ENA		0x0000101c	/* Interrupt Enable */
-#define DMA_MISSED_FRAME_CTR	0x00001020	/* Missed Frame Counter */
+#include "stmmac.h"
 
-/* SW Reset */
-#define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
+#define _REGS			(priv->plat->dwmac_regs)
 
-/* Rx watchdog register */
+/* DMA CRS Control and Status Register Mapping */
+#define DMA_CHAN_OFFSET		(_REGS->addrs->chan_offset)
+#define DMA_BUS_MODE		0x00001000
+#define DMA_XMT_POLL_DEMAND	0x00001004
+#define DMA_RCV_POLL_DEMAND	0x00001008
+#define DMA_RCV_BASE_ADDR	(_REGS->addrs->rcv_base_addr)
+#define DMA_RCV_BASE_ADDR_HI	(DMA_RCV_BASE_ADDR + 0x4)
+#define DMA_TX_BASE_ADDR	(_REGS->addrs->tx_base_addr)
+#define DMA_TX_BASE_ADDR_HI	(DMA_TX_BASE_ADDR + 0x4)
+#define DMA_STATUS		0x00001014
+#define DMA_CONTROL		0x00001018
+#define DMA_INTR_ENA		0x0000101c
+#define DMA_MISSED_FRAME_CTR	0x00001020
 #define DMA_RX_WATCHDOG		0x00001024
-
-/* AXI Master Bus Mode */
 #define DMA_AXI_BUS_MODE	0x00001028
+#define DMA_HW_FEATURE		0x00001058
+#define DMA_FUNC_CONFIG		0x00001080
+#define DMA_FUNC_CONFIG_HI	(DMA_FUNC_CONFIG + 0x4)
+#define DMA_CUR_TX_BUF_ADDR	(_REGS->addrs->cur_tx_buf_addr)
+#define DMA_CUR_TX_BUF_ADDR_HI	(DMA_CUR_TX_BUF_ADDR + 0x4)
+#define DMA_CUR_RX_BUF_ADDR	(_REGS->addrs->cur_rx_buf_addr)
+#define DMA_CUR_RX_BUF_ADDR_HI	(DMA_CUR_RX_BUF_ADDR + 0x4)
+#define DMA_RCV_BASE_ADDR_SHADOW1	0x00001068
+#define DMA_RCV_BASE_ADDR_SHADOW2	0x000010a8
+
+/* SW Reset */
+#define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
 
 #define DMA_AXI_EN_LPI		BIT(31)
 #define DMA_AXI_LPI_XIT_FRM	BIT(30)
-#define DMA_AXI_WR_OSR_LMT	GENMASK(23, 20)
-#define DMA_AXI_WR_OSR_LMT_SHIFT	20
-#define DMA_AXI_WR_OSR_LMT_MASK	0xf
-#define DMA_AXI_RD_OSR_LMT	GENMASK(19, 16)
-#define DMA_AXI_RD_OSR_LMT_SHIFT	16
-#define DMA_AXI_RD_OSR_LMT_MASK	0xf
-
-#define DMA_AXI_OSR_MAX		0xf
-#define DMA_AXI_MAX_OSR_LIMIT ((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
-			       (DMA_AXI_OSR_MAX << DMA_AXI_RD_OSR_LMT_SHIFT))
+#define DMA_AXI_WR_OSR_LMT	(_REGS->axi->wr_osr_lmt)
+#define DMA_AXI_WR_OSR_LMT_SHIFT	(_REGS->axi->wr_osr_lmt_shift)
+#define DMA_AXI_WR_OSR_LMT_MASK	(_REGS->axi->wr_osr_lmt_mask)
+#define DMA_AXI_RD_OSR_LMT	(_REGS->axi->rd_osr_lmt)
+#define DMA_AXI_RD_OSR_LMT_SHIFT	(_REGS->axi->rd_osr_lmt_shift)
+#define DMA_AXI_RD_OSR_LMT_MASK	(_REGS->axi->rd_osr_lmt_mask)
+#define DMA_AXI_OSR_MAX		(_REGS->axi->osr_max)
+#define DMA_AXI_MAX_OSR_LIMIT	((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
+				 (DMA_AXI_OSR_MAX << DMA_AXI_RD_OSR_LMT_SHIFT))
 #define	DMA_AXI_1KBBE		BIT(13)
 #define DMA_AXI_AAL		BIT(12)
 #define DMA_AXI_BLEN256		BIT(7)
@@ -61,38 +72,30 @@
 
 #define DMA_AXI_BURST_LEN_MASK	0x000000FE
 
-#define DMA_CUR_TX_BUF_ADDR	0x00001050	/* Current Host Tx Buffer */
-#define DMA_CUR_RX_BUF_ADDR	0x00001054	/* Current Host Rx Buffer */
-#define DMA_HW_FEATURE		0x00001058	/* HW Feature Register */
-
-/* DMA Control register defines */
-#define DMA_CONTROL_ST		0x00002000	/* Start/Stop Transmission */
-#define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
-
 /* DMA Normal interrupt */
-#define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
-#define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
-#define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
-#define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
-#define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
+#define DMA_INTR_ENA_NIE	(_REGS->intr_ena->nie)
+#define DMA_INTR_ENA_TIE	0x00000001
+#define DMA_INTR_ENA_TUE	0x00000004
+#define DMA_INTR_ENA_RIE	0x00000040
+#define DMA_INTR_ENA_ERE	0x00004000
 
-#define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
-			DMA_INTR_ENA_TIE)
+#define DMA_INTR_NORMAL		(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
+				 DMA_INTR_ENA_TIE)
 
 /* DMA Abnormal interrupt */
-#define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
-#define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
-#define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
-#define DMA_INTR_ENA_RWE 0x00000200	/* Receive Watchdog */
-#define DMA_INTR_ENA_RSE 0x00000100	/* Receive Stopped */
-#define DMA_INTR_ENA_RUE 0x00000080	/* Receive Buffer Unavailable */
-#define DMA_INTR_ENA_UNE 0x00000020	/* Tx Underflow */
-#define DMA_INTR_ENA_OVE 0x00000010	/* Receive Overflow */
-#define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
-#define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
+#define DMA_INTR_ENA_AIE	(_REGS->intr_ena->aie)
+#define DMA_INTR_ENA_FBE	0x00002000
+#define DMA_INTR_ENA_ETE	0x00000400
+#define DMA_INTR_ENA_RWE	0x00000200
+#define DMA_INTR_ENA_RSE	0x00000100
+#define DMA_INTR_ENA_RUE	0x00000080
+#define DMA_INTR_ENA_UNE	0x00000020
+#define DMA_INTR_ENA_OVE	0x00000010
+#define DMA_INTR_ENA_TJE	0x00000008
+#define DMA_INTR_ENA_TSE	0x00000002
 
 #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
-				DMA_INTR_ENA_UNE)
+				 DMA_INTR_ENA_UNE)
 
 /* DMA default interrupt mask */
 #define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
@@ -100,58 +103,64 @@
 #define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
 
 /* DMA Status register defines */
-#define DMA_STATUS_GLPII	0x40000000	/* GMAC LPI interrupt */
-#define DMA_STATUS_GPI		0x10000000	/* PMT interrupt */
-#define DMA_STATUS_GMI		0x08000000	/* MMC interrupt */
-#define DMA_STATUS_GLI		0x04000000	/* GMAC Line interface int */
-#define DMA_STATUS_EB_MASK	0x00380000	/* Error Bits Mask */
-#define DMA_STATUS_EB_TX_ABORT	0x00080000	/* Error Bits - TX Abort */
-#define DMA_STATUS_EB_RX_ABORT	0x00100000	/* Error Bits - RX Abort */
-#define DMA_STATUS_TS_MASK	0x00700000	/* Transmit Process State */
-#define DMA_STATUS_TS_SHIFT	20
-#define DMA_STATUS_RS_MASK	0x000e0000	/* Receive Process State */
-#define DMA_STATUS_RS_SHIFT	17
-#define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
-#define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
-#define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
-#define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
-#define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
-#define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
-#define DMA_STATUS_RPS	0x00000100	/* Receive Process Stopped */
-#define DMA_STATUS_RU	0x00000080	/* Receive Buffer Unavailable */
-#define DMA_STATUS_RI	0x00000040	/* Receive Interrupt */
-#define DMA_STATUS_UNF	0x00000020	/* Transmit Underflow */
-#define DMA_STATUS_OVF	0x00000010	/* Receive Overflow */
-#define DMA_STATUS_TJT	0x00000008	/* Transmit Jabber Timeout */
-#define DMA_STATUS_TU	0x00000004	/* Transmit Buffer Unavailable */
-#define DMA_STATUS_TPS	0x00000002	/* Transmit Process Stopped */
-#define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
-#define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
-
-#define DMA_STATUS_MSK_COMMON		(DMA_STATUS_NIS | \
-					 DMA_STATUS_AIS | \
-					 DMA_STATUS_FBI)
-
-#define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
-					 DMA_STATUS_RWT | \
-					 DMA_STATUS_RPS | \
-					 DMA_STATUS_RU | \
-					 DMA_STATUS_RI | \
-					 DMA_STATUS_OVF | \
-					 DMA_STATUS_MSK_COMMON)
-
-#define DMA_STATUS_MSK_TX		(DMA_STATUS_ETI | \
-					 DMA_STATUS_UNF | \
-					 DMA_STATUS_TJT | \
-					 DMA_STATUS_TU | \
-					 DMA_STATUS_TPS | \
-					 DMA_STATUS_TI | \
-					 DMA_STATUS_MSK_COMMON)
+#define DMA_STATUS_GLPII	(_REGS->status->glpii)
+#define DMA_STATUS_GPI		0x10000000
+#define DMA_STATUS_GMI		0x08000000
+#define DMA_STATUS_GLI		0x04000000
+#define DMA_STATUS_EB_MASK	(_REGS->status->eb_mask)
+#define DMA_STATUS_EB_TX_ABORT	0x00080000
+#define DMA_STATUS_EB_RX_ABORT	0x00100000
+#define DMA_STATUS_TS_MASK	(_REGS->status->ts_mask)
+#define DMA_STATUS_TS_SHIFT	(_REGS->status->ts_shift)
+#define DMA_STATUS_RS_MASK	(_REGS->status->rs_mask)
+#define DMA_STATUS_RS_SHIFT	(_REGS->status->rs_shift)
+#define DMA_STATUS_NIS		(_REGS->status->nis)
+#define DMA_STATUS_AIS		(_REGS->status->ais)
+#define DMA_STATUS_ERI		0x00004000
+#define DMA_STATUS_FBI		(_REGS->status->fbi)
+#define DMA_STATUS_ETI		0x00000400
+#define DMA_STATUS_RWT		0x00000200
+#define DMA_STATUS_RPS		0x00000100
+#define DMA_STATUS_RU		0x00000080
+#define DMA_STATUS_RI		0x00000040
+#define DMA_STATUS_UNF		0x00000020
+#define DMA_STATUS_OVF		0x00000010
+#define DMA_STATUS_TJT		0x00000008
+#define DMA_STATUS_TU		0x00000004
+#define DMA_STATUS_TPS		0x00000002
+#define DMA_STATUS_TI		0x00000001
+
+#define DMA_STATUS_MSK_COMMON	(DMA_STATUS_NIS | \
+				 DMA_STATUS_AIS | \
+				 DMA_STATUS_FBI)
+
+#define DMA_STATUS_MSK_RX	(DMA_STATUS_ERI | \
+				 DMA_STATUS_RWT | \
+				 DMA_STATUS_RPS | \
+				 DMA_STATUS_RU | \
+				 DMA_STATUS_RI | \
+				 DMA_STATUS_OVF | \
+				 DMA_STATUS_MSK_COMMON)
+
+#define DMA_STATUS_MSK_TX	(DMA_STATUS_ETI | \
+				 DMA_STATUS_UNF | \
+				 DMA_STATUS_TJT | \
+				 DMA_STATUS_TU | \
+				 DMA_STATUS_TPS | \
+				 DMA_STATUS_TI | \
+				 DMA_STATUS_MSK_COMMON)
+
+/* DMA Control register defines */
+#define DMA_CONTROL_ST		0x00002000	/* Start/Stop Transmission */
+#define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
+#define DMA_CONTROL_FTF		0x00100000      /* Flush transmit FIFO */
 
 #define NUM_DWMAC100_DMA_REGS	9
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
 
+extern const struct dwmac_regs dwmac_default_dma_regs;
+
 void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 2dd457032187..266f64148c1a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -13,6 +13,47 @@
 
 #define GMAC_HI_REG_AE		0x80000000
 
+static const struct dwmac_dma_addrs default_dma_addrs = {
+	.rcv_base_addr = 0x0000100c,
+	.tx_base_addr = 0x00001010,
+	.cur_tx_buf_addr = 0x00001050,
+	.cur_rx_buf_addr = 0x00001054
+};
+
+static const struct dwmac_dma_axi default_dma_axi = {
+	.wr_osr_lmt = GENMASK(23, 20),
+	.wr_osr_lmt_shift = 20,
+	.wr_osr_lmt_mask = 0xf,
+	.rd_osr_lmt = GENMASK(19, 16),
+	.rd_osr_lmt_shift = 16,
+	.rd_osr_lmt_mask = 0xf,
+	.osr_max = 0xf
+};
+
+static const struct dwmac_dma_intr_ena default_dma_intr_ena = {
+	.nie = 0x00010000,
+	.aie = 0x00008000
+};
+
+static const struct dwmac_dma_status default_dma_status = {
+	.glpii = 0x40000000,
+	.eb_mask = 0x00380000,
+	.ts_mask = 0x00700000,
+	.ts_shift = 20,
+	.rs_mask = 0x000e0000,
+	.rs_shift = 17,
+	.nis = 0x00010000,
+	.ais = 0x00008000,
+	.fbi = 0x00002000
+};
+
+const struct dwmac_regs dwmac_default_dma_regs = {
+	.addrs = &default_dma_addrs,
+	.axi = &default_dma_axi,
+	.intr_ena = &default_dma_intr_ena,
+	.status = &default_dma_status
+};
+
 int dwmac_dma_reset(void __iomem *ioaddr)
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 06090538fe2d..db61dc7c931d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -204,6 +204,53 @@ struct dwmac4_addrs {
 	u32 mtl_low_cred_offset;
 };
 
+/* DMA addresses that may be customized by a platform */
+struct dwmac_dma_addrs {
+	u32 chan_offset;
+	u32 rcv_base_addr;
+	u32 tx_base_addr;
+	u32 cur_tx_buf_addr;
+	u32 cur_rx_buf_addr;
+};
+
+/* DMA AXI registers that may be customized by a platform */
+struct dwmac_dma_axi {
+	u32 wr_osr_lmt;
+	u32 wr_osr_lmt_shift;
+	u32 wr_osr_lmt_mask;
+	u32 rd_osr_lmt;
+	u32 rd_osr_lmt_shift;
+	u32 rd_osr_lmt_mask;
+	u32 osr_max;
+};
+
+/* DMA normal and abnormal interrupt that may be customized by a platform */
+struct dwmac_dma_intr_ena {
+	u32 nie;
+	u32 aie;
+};
+
+/* DMA Status register that may be customized by a platform */
+struct dwmac_dma_status {
+	u32 glpii;
+	u32 eb_mask;
+	u32 ts_mask;
+	u32 ts_shift;
+	u32 rs_mask;
+	u32 rs_shift;
+	u32 nis;
+	u32 ais;
+	u32 fbi;
+};
+
+/* Registers that may be customized by a platform */
+struct dwmac_regs {
+	const struct dwmac_dma_addrs *addrs;
+	const struct dwmac_dma_axi *axi;
+	const struct dwmac_dma_intr_ena *intr_ena;
+	const struct dwmac_dma_status *status;
+};
+
 struct plat_stmmacenet_data {
 	int bus_id;
 	int phy_addr;
@@ -294,5 +341,6 @@ struct plat_stmmacenet_data {
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	bool has_integrated_pcs;
+	const struct dwmac_regs *dwmac_regs;
 };
 #endif
-- 
2.39.3


