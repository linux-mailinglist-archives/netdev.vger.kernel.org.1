Return-Path: <netdev+bounces-23994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FAA76E6DA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A60D1C2048F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5C1D2E3;
	Thu,  3 Aug 2023 11:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E641ADF1
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:29:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923AC1981
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:29:01 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8CxLOt6j8tkrKwPAA--.30998S3;
	Thu, 03 Aug 2023 19:28:58 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCN1j8tk4R1HAA--.33555S4;
	Thu, 03 Aug 2023 19:28:57 +0800 (CST)
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
Subject: [PATCH v3 02/16] net: stmmac: dwmac1000: Allow platforms to choose some register offsets
Date: Thu,  3 Aug 2023 19:28:04 +0800
Message-Id: <787569df0c389f5a1d2695d7fb9d282842686d1c.1691047285.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1691047285.git.chenfeiyang@loongson.cn>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxLCN1j8tk4R1HAA--.33555S4
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfKr13ZrykCr4DCryDuF1Utwc_yoW8uF4fZo
	ZxJF9agrWrKw1xJrs7Kr18Jryaqrn5Xa13AF48G3ykZa9avayUZFWrt3Z3uF12vr1xKF15
	Aryxt3WDA34aq3Z5l-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYZ7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some platforms have dwmac1000 implementations that have a different
address space layout than the default. Add new struct dwmac_regs to
allow a platform driver to choose the appropriate register offsets.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  3 +
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 25 +++--
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  3 +
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    | 22 +++--
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 55 +----------
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 97 ++++++++++++++++---
 include/linux/stmmac.h                        | 61 ++++++++++++
 7 files changed, 187 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index b52793edf62f..6b28f08c8640 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -19,6 +19,7 @@
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
+#include "dwmac_dma.h"
 
 static void dwmac1000_core_init(struct mac_device_info *hw,
 				struct net_device *dev)
@@ -533,6 +534,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 
 	dev_info(priv->device, "\tDWMAC1000\n");
 
+	priv->plat->dwmac_regs = &dwmac_default_dma_regs;
+
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 	mac->pcsr = priv->ioaddr;
 	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index ce0e6ca6f3a2..3996dea4b1e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -15,10 +15,12 @@
 #include <asm/io.h>
 #include "dwmac1000.h"
 #include "dwmac_dma.h"
+#include "stmmac.h"
 
 static void dwmac1000_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
 			      struct stmmac_axi *axi)
 {
+	const struct dwmac_dma_axi *dma_axi = priv->plat->dwmac_regs->axi;
 	u32 value = readl(ioaddr + DMA_AXI_BUS_MODE);
 	int i;
 
@@ -30,13 +32,13 @@ static void dwmac1000_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (axi->axi_xit_frm)
 		value |= DMA_AXI_LPI_XIT_FRM;
 
-	value &= ~DMA_AXI_WR_OSR_LMT;
-	value |= (axi->axi_wr_osr_lmt & DMA_AXI_WR_OSR_LMT_MASK) <<
-		 DMA_AXI_WR_OSR_LMT_SHIFT;
+	value &= ~dma_axi->wr_osr_lmt;
+	value |= (axi->axi_wr_osr_lmt & dma_axi->wr_osr_lmt_mask) <<
+		 dma_axi->wr_osr_lmt_shift;
 
-	value &= ~DMA_AXI_RD_OSR_LMT;
-	value |= (axi->axi_rd_osr_lmt & DMA_AXI_RD_OSR_LMT_MASK) <<
-		 DMA_AXI_RD_OSR_LMT_SHIFT;
+	value &= ~dma_axi->rd_osr_lmt;
+	value |= (axi->axi_rd_osr_lmt & dma_axi->rd_osr_lmt_mask) <<
+		 dma_axi->rd_osr_lmt_shift;
 
 	/* Depending on the UNDEF bit the Master AXI will perform any burst
 	 * length according to the BLEN programmed (by default all BLEN are
@@ -74,6 +76,7 @@ static void dwmac1000_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
 static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       struct stmmac_dma_cfg *dma_cfg, int atds)
 {
+	u32 mask = priv->plat->dwmac_regs->intr_ena->default_mask;
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
@@ -108,7 +111,7 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(value, ioaddr + DMA_BUS_MODE);
 
 	/* Mask interrupts by writing to CSR7 */
-	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
+	writel(mask, ioaddr + DMA_INTR_ENA);
 }
 
 static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
@@ -116,8 +119,10 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_rx_phy, u32 chan)
 {
+	u32 addr = priv->plat->dwmac_regs->addrs->rcv_base_addr;
+
 	/* RX descriptor base address list must be written into DMA CSR3 */
-	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
+	writel(lower_32_bits(dma_rx_phy), ioaddr + addr);
 }
 
 static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
@@ -125,8 +130,10 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_tx_phy, u32 chan)
 {
+	u32 addr = priv->plat->dwmac_regs->addrs->tx_base_addr;
+
 	/* TX descriptor base address list must be written into DMA CSR4 */
-	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
+	writel(lower_32_bits(dma_tx_phy), ioaddr + addr);
 }
 
 static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index e6ae230fa453..be9e8fad69f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -17,32 +17,39 @@
 #include <asm/io.h>
 #include "dwmac100.h"
 #include "dwmac_dma.h"
+#include "stmmac.h"
 
 static void dwmac100_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 			      struct stmmac_dma_cfg *dma_cfg, int atds)
 {
+	u32 mask = priv->plat->dwmac_regs->intr_ena->default_mask;
+
 	/* Enable Application Access by writing to DMA CSR0 */
 	writel(DMA_BUS_MODE_DEFAULT | (dma_cfg->pbl << DMA_BUS_MODE_PBL_SHIFT),
 	       ioaddr + DMA_BUS_MODE);
 
 	/* Mask interrupts by writing to CSR7 */
-	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
+	writel(mask, ioaddr + DMA_INTR_ENA);
 }
 
 static void dwmac100_dma_init_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 struct stmmac_dma_cfg *dma_cfg,
 				 dma_addr_t dma_rx_phy, u32 chan)
 {
+	u32 addr = priv->plat->dwmac_regs->addrs->rcv_base_addr;
+
 	/* RX descriptor base addr lists must be written into DMA CSR3 */
-	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
+	writel(lower_32_bits(dma_rx_phy), ioaddr + addr);
 }
 
 static void dwmac100_dma_init_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 struct stmmac_dma_cfg *dma_cfg,
 				 dma_addr_t dma_tx_phy, u32 chan)
 {
+	u32 addr = priv->plat->dwmac_regs->addrs->tx_base_addr;
+
 	/* TX descriptor base addr lists must be written into DMA CSR4 */
-	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
+	writel(lower_32_bits(dma_tx_phy), ioaddr + addr);
 }
 
 /* Store and Forward capability is not used at all.
@@ -69,16 +76,17 @@ static void dwmac100_dma_operation_mode_tx(struct stmmac_priv *priv,
 static void dwmac100_dump_dma_regs(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 *reg_space)
 {
+	const struct dwmac_dma_addrs *addrs = priv->plat->dwmac_regs->addrs;
 	int i;
 
 	for (i = 0; i < NUM_DWMAC100_DMA_REGS; i++)
 		reg_space[DMA_BUS_MODE / 4 + i] =
 			readl(ioaddr + DMA_BUS_MODE + i * 4);
 
-	reg_space[DMA_CUR_TX_BUF_ADDR / 4] =
-		readl(ioaddr + DMA_CUR_TX_BUF_ADDR);
-	reg_space[DMA_CUR_RX_BUF_ADDR / 4] =
-		readl(ioaddr + DMA_CUR_RX_BUF_ADDR);
+	reg_space[addrs->cur_tx_buf_addr / 4] =
+		readl(ioaddr + addrs->cur_tx_buf_addr);
+	reg_space[addrs->cur_rx_buf_addr / 4] =
+		readl(ioaddr + addrs->cur_rx_buf_addr);
 }
 
 /* DMA controller has two counters to track the number of the missed frames. */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 77141391bd2f..b2b75b5b6d50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -15,8 +15,6 @@
 #define DMA_BUS_MODE		0x00001000	/* Bus Mode */
 #define DMA_XMT_POLL_DEMAND	0x00001004	/* Transmit Poll Demand */
 #define DMA_RCV_POLL_DEMAND	0x00001008	/* Received Poll Demand */
-#define DMA_RCV_BASE_ADDR	0x0000100c	/* Receive List Base */
-#define DMA_TX_BASE_ADDR	0x00001010	/* Transmit List Base */
 #define DMA_STATUS		0x00001014	/* Status Register */
 #define DMA_CONTROL		0x00001018	/* Ctrl (Operational Mode) */
 #define DMA_INTR_ENA		0x0000101c	/* Interrupt Enable */
@@ -33,16 +31,6 @@
 
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
 #define	DMA_AXI_1KBBE		BIT(13)
 #define DMA_AXI_AAL		BIT(12)
 #define DMA_AXI_BLEN256		BIT(7)
@@ -61,26 +49,20 @@
 
 #define DMA_AXI_BURST_LEN_MASK	0x000000FE
 
-#define DMA_CUR_TX_BUF_ADDR	0x00001050	/* Current Host Tx Buffer */
-#define DMA_CUR_RX_BUF_ADDR	0x00001054	/* Current Host Rx Buffer */
 #define DMA_HW_FEATURE		0x00001058	/* HW Feature Register */
+#define DMA_FUNC_CONFIG		0x00001080
 
 /* DMA Control register defines */
 #define DMA_CONTROL_ST		0x00002000	/* Start/Stop Transmission */
 #define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
 
 /* DMA Normal interrupt */
-#define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
 #define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
 #define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
 #define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
 #define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
 
-#define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
-			DMA_INTR_ENA_TIE)
-
 /* DMA Abnormal interrupt */
-#define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
 #define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
 #define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
 #define DMA_INTR_ENA_RWE 0x00000200	/* Receive Watchdog */
@@ -91,30 +73,17 @@
 #define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
 #define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
 
-#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
-				DMA_INTR_ENA_UNE)
-
 /* DMA default interrupt mask */
-#define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
 #define DMA_INTR_DEFAULT_RX	(DMA_INTR_ENA_RIE)
 #define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
 
 /* DMA Status register defines */
-#define DMA_STATUS_GLPII	0x40000000	/* GMAC LPI interrupt */
 #define DMA_STATUS_GPI		0x10000000	/* PMT interrupt */
 #define DMA_STATUS_GMI		0x08000000	/* MMC interrupt */
 #define DMA_STATUS_GLI		0x04000000	/* GMAC Line interface int */
-#define DMA_STATUS_EB_MASK	0x00380000	/* Error Bits Mask */
 #define DMA_STATUS_EB_TX_ABORT	0x00080000	/* Error Bits - TX Abort */
 #define DMA_STATUS_EB_RX_ABORT	0x00100000	/* Error Bits - RX Abort */
-#define DMA_STATUS_TS_MASK	0x00700000	/* Transmit Process State */
-#define DMA_STATUS_TS_SHIFT	20
-#define DMA_STATUS_RS_MASK	0x000e0000	/* Receive Process State */
-#define DMA_STATUS_RS_SHIFT	17
-#define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
-#define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
 #define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
-#define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
 #define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
 #define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
 #define DMA_STATUS_RPS	0x00000100	/* Receive Process Stopped */
@@ -128,30 +97,12 @@
 #define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
 #define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
 
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
-
 #define NUM_DWMAC100_DMA_REGS	9
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
 
+extern const struct dwmac_regs dwmac_default_dma_regs;
+
 void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 053a8af6d0e1..6411be0f3612 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -10,9 +10,82 @@
 #include <linux/iopoll.h>
 #include "common.h"
 #include "dwmac_dma.h"
+#include "stmmac.h"
 
 #define GMAC_HI_REG_AE		0x80000000
 
+static const struct dwmac_dma_addrs default_dma_addrs = {
+	.rcv_base_addr = 0x0000100c,
+	.tx_base_addr = 0x00001010,
+	.cur_tx_buf_addr = 0x00001050,
+	.cur_rx_buf_addr = 0x00001054,
+};
+
+static const struct dwmac_dma_axi default_dma_axi = {
+	.wr_osr_lmt = GENMASK(23, 20),
+	.wr_osr_lmt_shift = 20,
+	.wr_osr_lmt_mask = 0xf,
+	.rd_osr_lmt = GENMASK(19, 16),
+	.rd_osr_lmt_shift = 16,
+	.rd_osr_lmt_mask = 0xf,
+	.osr_max = 0xf,
+	/* max_osr_limit = (osr_max << wr_osr_lmt_shift) |
+	 *                 (osr_max << rd_osr_lmt_shift)
+	 */
+	.max_osr_limit = (0xf << 20) | (0xf << 16),
+};
+
+static const struct dwmac_dma_intr_ena default_dma_intr_ena = {
+	.nie = 0x00010000,
+	/* normal = nie | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE */
+	.normal = 0x00010000 | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE,
+	.aie = 0x00008000,
+	/* abnormal = aie | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE */
+	.abnormal = 0x00008000 | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE,
+	/* default_mask = normal | abnormal */
+	.default_mask = (0x00010000 | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE) |
+			(0x00008000 | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE),
+};
+
+static const struct dwmac_dma_status default_dma_status = {
+	.glpii = 0x40000000,
+	.gpi = 0x10000000,
+	.gmi = 0x08000000,
+	.gli = 0x04000000,
+	.intr_mask = 0x1ffff,
+	.eb_mask = 0x00380000,
+	.ts_mask = 0x00700000,
+	.ts_shift = 20,
+	.rs_mask = 0x000e0000,
+	.rs_shift = 17,
+	.nis = 0x00010000,
+	.ais = 0x00008000,
+	.fbi = 0x00002000,
+	/* msk_common = nis | ais | fbi */
+	.msk_common = 0x00010000 | 0x00008000 | 0x00002000,
+	/* msk_rx = DMA_STATUS_ERI | DMA_STATUS_RWT |  DMA_STATUS_RPS |
+	 *          DMA_STATUS_RU | DMA_STATUS_RI | DMA_STATUS_OVF |
+	 *          msk_common
+	 */
+	.msk_rx = DMA_STATUS_ERI | DMA_STATUS_RWT | DMA_STATUS_RPS |
+		  DMA_STATUS_RU | DMA_STATUS_RI | DMA_STATUS_OVF |
+		  0x00010000 | 0x00008000 | 0x00002000,
+	/* msk_tx = DMA_STATUS_ETI | DMA_STATUS_UNF | DMA_STATUS_TJT |
+	 *          DMA_STATUS_TU | DMA_STATUS_TPS | DMA_STATUS_TI |
+	 *          msk_common
+	 */
+	.msk_tx = DMA_STATUS_ETI | DMA_STATUS_UNF | DMA_STATUS_TJT |
+		  DMA_STATUS_TU | DMA_STATUS_TPS | DMA_STATUS_TI |
+		  0x00010000 | 0x00008000 | 0x00002000,
+};
+
+const struct dwmac_regs dwmac_default_dma_regs = {
+	.addrs = &default_dma_addrs,
+	.axi = &default_dma_axi,
+	.intr_ena = &default_dma_intr_ena,
+	.status = &default_dma_status,
+};
+
 int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
@@ -92,8 +165,9 @@ void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
 #ifdef DWMAC_DMA_DEBUG
 static void show_tx_process_state(unsigned int status)
 {
+	u32 status = priv->plat->dwmac_regs->status;
 	unsigned int state;
-	state = (status & DMA_STATUS_TS_MASK) >> DMA_STATUS_TS_SHIFT;
+	state = (status & status->ts_mask) >> status->ts_shift;
 
 	switch (state) {
 	case 0:
@@ -123,8 +197,9 @@ static void show_tx_process_state(unsigned int status)
 
 static void show_rx_process_state(unsigned int status)
 {
+	u32 status = priv->plat->dwmac_regs->status;
 	unsigned int state;
-	state = (status & DMA_STATUS_RS_MASK) >> DMA_STATUS_RS_SHIFT;
+	state = (status & status->rs_mask) >> status->rs_shift;
 
 	switch (state) {
 	case 0:
@@ -162,6 +237,7 @@ static void show_rx_process_state(unsigned int status)
 int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			struct stmmac_extra_stats *x, u32 chan, u32 dir)
 {
+	const struct dwmac_dma_status *status = priv->plat->dwmac_regs->status;
 	int ret = 0;
 	/* read the status register (CSR5) */
 	u32 intr_status = readl(ioaddr + DMA_STATUS);
@@ -174,12 +250,12 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 #endif
 
 	if (dir == DMA_DIR_RX)
-		intr_status &= DMA_STATUS_MSK_RX;
+		intr_status &= status->msk_rx;
 	else if (dir == DMA_DIR_TX)
-		intr_status &= DMA_STATUS_MSK_TX;
+		intr_status &= status->msk_tx;
 
 	/* ABNORMAL interrupts */
-	if (unlikely(intr_status & DMA_STATUS_AIS)) {
+	if (unlikely(intr_status & status->ais)) {
 		if (unlikely(intr_status & DMA_STATUS_UNF)) {
 			ret = tx_hard_error_bump_tc;
 			x->tx_undeflow_irq++;
@@ -202,13 +278,13 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->tx_process_stopped_irq++;
 			ret = tx_hard_error;
 		}
-		if (unlikely(intr_status & DMA_STATUS_FBI)) {
+		if (unlikely(intr_status & status->fbi)) {
 			x->fatal_bus_error_irq++;
 			ret = tx_hard_error;
 		}
 	}
 	/* TX/RX NORMAL interrupts */
-	if (likely(intr_status & DMA_STATUS_NIS)) {
+	if (likely(intr_status & status->nis)) {
 		x->normal_irq_n++;
 		if (likely(intr_status & DMA_STATUS_RI)) {
 			u32 value = readl(ioaddr + DMA_INTR_ENA);
@@ -226,12 +302,11 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->rx_early_irq++;
 	}
 	/* Optional hardware blocks, interrupts should be disabled */
-	if (unlikely(intr_status &
-		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
+	if (unlikely(intr_status & (status->gpi | status->gmi | status->gli)))
 		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
 
-	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
-	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
+	/* Clear the interrupt by writing a logic 1 to the CSR5 */
+	writel((intr_status & status->intr_mask), ioaddr + DMA_STATUS);
 
 	return ret;
 }
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 06090538fe2d..ab979efd57bf 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -204,6 +204,66 @@ struct dwmac4_addrs {
 	u32 mtl_low_cred_offset;
 };
 
+/* DMA addresses that may be customized by a platform */
+struct dwmac_dma_addrs {
+	u32 chan_offset;
+	u32 rcv_base_addr;
+	u32 rcv_base_addr_shadow1;
+	u32 rcv_base_addr_shadow2;
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
+	u32 max_osr_limit;
+};
+
+/* DMA normal and abnormal interrupt that may be customized by a platform */
+struct dwmac_dma_intr_ena {
+	u32 nie;
+	u32 normal;
+	u32 aie;
+	u32 abnormal;
+	u32 default_mask;
+};
+
+/* DMA Status register that may be customized by a platform */
+struct dwmac_dma_status {
+	u32 glpii;
+	u32 gpi;
+	u32 gmi;
+	u32 gli;
+	u32 intr_mask;
+	u32 eb_mask;
+	u32 ts_mask;
+	u32 ts_shift;
+	u32 rs_mask;
+	u32 rs_shift;
+	u32 nis;
+	u32 ais;
+	u32 fbi;
+	u32 msk_common;
+	u32 msk_rx;
+	u32 msk_tx;
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
@@ -294,5 +354,6 @@ struct plat_stmmacenet_data {
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	bool has_integrated_pcs;
+	const struct dwmac_regs *dwmac_regs;
 };
 #endif
-- 
2.39.3


