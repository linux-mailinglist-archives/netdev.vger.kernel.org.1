Return-Path: <netdev+bounces-17385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8842751676
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12151C21264
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731380A;
	Thu, 13 Jul 2023 02:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E363D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:49:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE1C119A3
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:49:02 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8BxnusdZq9kHUAEAA--.9420S3;
	Thu, 13 Jul 2023 10:49:01 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxswbZq9khJgrAA--.34828S3;
	Thu, 13 Jul 2023 10:49:00 +0800 (CST)
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
Subject: [RFC PATCH 06/10] net: stmmac: dwmac1000: Add Loongson register definitions
Date: Thu, 13 Jul 2023 10:48:51 +0800
Message-Id: <2c37d719568498ab013ea121eeeec355c29c8d72.1689215889.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1689215889.git.chenfeiyang@loongson.cn>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxxswbZq9khJgrAA--.34828S3
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3uw1kur47CF47ur1rJw4fWFX_yoWkWr15pa
	y7Aa45GrW8tF45Za1kJr48XFy5Z3yYkFW7ur4xKw1a9Fs29r9Iqrn0kay5Cr13ZFWDJr12
	gr4jkw13WFn8KwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxxhdUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add definitions for Loongson platform.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |  4 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 43 +++++++---
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 10 ++-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 84 +++++++++++++++++--
 5 files changed, 119 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 4296ddda8aaa..f827bf8f30a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -76,9 +76,9 @@ enum power_event {
 #define LPI_CTRL_STATUS_TLPIEN	0x00000001	/* Transmit LPI Entry */
 
 /* GMAC HW ADDR regs */
-#define GMAC_ADDR_HIGH(reg)	((reg > 15) ? 0x00000800 + (reg - 16) * 8 : \
+#define GMAC_ADDR_HIGH(reg, x)	((reg > 15) ? 0x00000800 + (reg - 16) * 8 * (x) : \
 				 0x00000040 + (reg * 8))
-#define GMAC_ADDR_LOW(reg)	((reg > 15) ? 0x00000804 + (reg - 16) * 8 : \
+#define GMAC_ADDR_LOW(reg, x)	((reg > 15) ? 0x00000804 + (reg - 16) * 8 * (x) : \
 				 0x00000044 + (reg * 8))
 #define GMAC_MAX_PERFECT_ADDRESSES	1
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index a9b42a122ed6..1063865d126e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -24,6 +24,7 @@
 static void dwmac1000_core_init(struct mac_device_info *hw,
 				struct net_device *dev)
 {
+	struct stmmac_priv *priv = netdev_priv(dev);
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONTROL);
 	int mtu = dev->mtu;
@@ -31,6 +32,9 @@ static void dwmac1000_core_init(struct mac_device_info *hw,
 	/* Configure GMAC core */
 	value |= GMAC_CORE_INIT;
 
+	if (priv->plat->dwmac_is_loongson)
+		value |= GMAC_CONTROL_ACS;
+
 	if (mtu > 1500)
 		value |= GMAC_CONTROL_2K;
 	if (mtu > 2000)
@@ -100,9 +104,10 @@ static void dwmac1000_set_umac_addr(struct stmmac_priv *priv,
 				    const unsigned char *addr,
 				    unsigned int reg_n)
 {
+	bool is_loongson = priv->plat->dwmac_is_loongson;
 	void __iomem *ioaddr = hw->pcsr;
-	stmmac_set_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n),
-			    GMAC_ADDR_LOW(reg_n));
+	stmmac_set_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n, !is_loongson),
+			    GMAC_ADDR_LOW(reg_n, !is_loongson));
 }
 
 static void dwmac1000_get_umac_addr(struct stmmac_priv *priv,
@@ -110,9 +115,10 @@ static void dwmac1000_get_umac_addr(struct stmmac_priv *priv,
 				    unsigned char *addr,
 				    unsigned int reg_n)
 {
+	bool is_loongson = priv->plat->dwmac_is_loongson;
 	void __iomem *ioaddr = hw->pcsr;
-	stmmac_get_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n),
-			    GMAC_ADDR_LOW(reg_n));
+	stmmac_get_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n, !is_loongson),
+			    GMAC_ADDR_LOW(reg_n, !is_loongson));
 }
 
 static void dwmac1000_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
@@ -144,6 +150,7 @@ static void dwmac1000_set_filter(struct stmmac_priv *priv,
 				 struct mac_device_info *hw,
 				 struct net_device *dev)
 {
+	bool is_loongson = priv->plat->dwmac_is_loongson;
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
 	unsigned int value = 0;
 	unsigned int perfect_addr_number = hw->unicast_filter_entries;
@@ -156,7 +163,9 @@ static void dwmac1000_set_filter(struct stmmac_priv *priv,
 	memset(mc_filter, 0, sizeof(mc_filter));
 
 	if (dev->flags & IFF_PROMISC) {
-		value = GMAC_FRAME_FILTER_PR | GMAC_FRAME_FILTER_PCF;
+		value = GMAC_FRAME_FILTER_PR;
+		if (!is_loongson)
+			value |= GMAC_FRAME_FILTER_PCF;
 	} else if (dev->flags & IFF_ALLMULTI) {
 		value = GMAC_FRAME_FILTER_PM;	/* pass all multi */
 	} else if (!netdev_mc_empty(dev) && (mcbitslog2 == 0)) {
@@ -200,14 +209,14 @@ static void dwmac1000_set_filter(struct stmmac_priv *priv,
 
 		netdev_for_each_uc_addr(ha, dev) {
 			stmmac_set_mac_addr(ioaddr, ha->addr,
-					    GMAC_ADDR_HIGH(reg),
-					    GMAC_ADDR_LOW(reg));
+					    GMAC_ADDR_HIGH(reg, !is_loongson),
+					    GMAC_ADDR_LOW(reg, !is_loongson));
 			reg++;
 		}
 
 		while (reg < perfect_addr_number) {
-			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
-			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
+			writel(0, ioaddr + GMAC_ADDR_HIGH(reg, !is_loongson));
+			writel(0, ioaddr + GMAC_ADDR_LOW(reg, !is_loongson));
 			reg++;
 		}
 	}
@@ -562,8 +571,20 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 {
 	dev_info(priv->device, "\tDWMAC1000\n");
 
-	priv->plat->dwmac_is_loongson = false;
-	priv->plat->dwmac_regs = &dwmac_default_dma_regs;
+	if (priv->plat->dma_cfg->dma64)
+		priv->plat->dwmac_regs = &dwmac_loongson64_dma_regs;
+	else
+		priv->plat->dwmac_regs = &dwmac_default_dma_regs;
+
+	return _dwmac1000_setup(priv);
+}
+
+int dwmac_loongson_setup(struct stmmac_priv *priv)
+{
+	dev_info(priv->device, "\tDWMAC1000(LOONGSON)\n");
+
+	priv->plat->dwmac_is_loongson = true;
+	priv->plat->dwmac_regs = &dwmac_loongson_dma_regs;
 
 	return _dwmac1000_setup(priv);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 632c4f110d01..7aa450d6a81a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -329,8 +329,14 @@ static int dwmac1000_get_hw_feature(struct stmmac_priv *priv,
 	dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
 	dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
 	/* TX and RX number of channels */
-	dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
-	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
+	if (priv->plat->dwmac_is_loongson &&
+	    ((hw_cap & (DMA_HW_FEAT_RXCHCNT | DMA_HW_FEAT_TXCHCNT)) >> 20) == 0) {
+		dma_cap->number_rx_channel = 8;
+		dma_cap->number_tx_channel = 8;
+	} else {
+		dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
+		dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
+	}
 	/* Alternate (enhanced) DESC mode */
 	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 915a4d70fd3b..3828902baa80 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -160,6 +160,8 @@
 #define NUM_DWMAC4_DMA_REGS	27
 
 extern const struct dwmac_regs dwmac_default_dma_regs;
+extern const struct dwmac_regs dwmac_loongson_dma_regs;
+extern const struct dwmac_regs dwmac_loongson64_dma_regs;
 
 void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 chan);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 99838497b183..7911eab175d9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -20,6 +20,21 @@ static const struct dwmac_dma_addrs default_dma_addrs = {
 	.cur_rx_buf_addr = 0x00001054
 };
 
+static const struct dwmac_dma_addrs loongson_dma_addrs = {
+	.chan_offset = 0x100,
+	.rcv_base_addr = 0x0000100c,
+	.tx_base_addr = 0x00001010,
+	.cur_tx_buf_addr = 0x00001050,
+	.cur_rx_buf_addr = 0x00001054
+};
+
+static const struct dwmac_dma_addrs loongson64_dma_addrs = {
+	.rcv_base_addr = 0x00001090,
+	.tx_base_addr = 0x00001098,
+	.cur_tx_buf_addr = 0x000010b0,
+	.cur_rx_buf_addr = 0x000010b8
+};
+
 static const struct dwmac_dma_axi default_dma_axi = {
 	.wr_osr_lmt = GENMASK(23, 20),
 	.wr_osr_lmt_shift = 20,
@@ -30,11 +45,26 @@ static const struct dwmac_dma_axi default_dma_axi = {
 	.osr_max = 0xf
 };
 
+static const struct dwmac_dma_axi loongson_dma_axi = {
+	.wr_osr_lmt = BIT(20),
+	.wr_osr_lmt_shift = 20,
+	.wr_osr_lmt_mask = 0x1,
+	.rd_osr_lmt = BIT(16),
+	.rd_osr_lmt_shift = 16,
+	.rd_osr_lmt_mask = 0x1,
+	.osr_max = 0x1
+};
+
 static const struct dwmac_dma_intr_ena default_dma_intr_ena = {
 	.nie = 0x00010000,
 	.aie = 0x00008000
 };
 
+static const struct dwmac_dma_intr_ena loongson_dma_intr_ena = {
+	.nie = 0x00060000,
+	.aie = 0x00018000
+};
+
 static const struct dwmac_dma_status default_dma_status = {
 	.glpii = 0x40000000,
 	.eb_mask = 0x00380000,
@@ -47,6 +77,18 @@ static const struct dwmac_dma_status default_dma_status = {
 	.fbi = 0x00002000
 };
 
+static const struct dwmac_dma_status loongson_dma_status = {
+	.glpii = 0x10000000,
+	.eb_mask = 0x0e000000,
+	.ts_mask = 0x01c00000,
+	.ts_shift = 22,
+	.rs_mask = 0x00380000,
+	.rs_shift = 19,
+	.nis = 0x00040000 | 0x00020000,
+	.ais = 0x00010000 | 0x00008000,
+	.fbi = 0x00002000 | 0x00001000
+};
+
 const struct dwmac_regs dwmac_default_dma_regs = {
 	.addrs = &default_dma_addrs,
 	.axi = &default_dma_axi,
@@ -54,17 +96,37 @@ const struct dwmac_regs dwmac_default_dma_regs = {
 	.status = &default_dma_status
 };
 
+const struct dwmac_regs dwmac_loongson_dma_regs = {
+	.addrs = &loongson_dma_addrs,
+	.axi = &loongson_dma_axi,
+	.intr_ena = &loongson_dma_intr_ena,
+	.status = &loongson_dma_status
+};
+
+const struct dwmac_regs dwmac_loongson64_dma_regs = {
+	.addrs = &loongson64_dma_addrs,
+	.axi = &loongson_dma_axi,
+	.intr_ena = &default_dma_intr_ena,
+	.status = &default_dma_status
+};
+
 int dwmac_dma_reset(void __iomem *ioaddr)
 {
+	int err;
+	int cnt = 5;
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 
 	/* DMA SW reset */
-	value |= DMA_BUS_MODE_SFT_RESET;
-	writel(value, ioaddr + DMA_BUS_MODE);
+	do {
+		value |= DMA_BUS_MODE_SFT_RESET;
+		writel(value, ioaddr + DMA_BUS_MODE);
+
+		err = readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
+					 !(value & DMA_BUS_MODE_SFT_RESET),
+					 10000, 200000);
+	} while (cnt-- && err);
 
-	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
-				 !(value & DMA_BUS_MODE_SFT_RESET),
-				 10000, 200000);
+	return err;
 }
 
 /* CSR1 enables the transmit DMA to check for new descriptor */
@@ -267,12 +329,16 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->rx_early_irq++;
 	}
 	/* Optional hardware blocks, interrupts should be disabled */
-	if (unlikely(intr_status &
-		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
+	if (!priv->plat->dwmac_is_loongson &&
+	    unlikely(intr_status & (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
 		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
 
-	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
-	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
+	if (priv->plat->dwmac_is_loongson)
+		writel((intr_status & 0x7ffff), ioaddr + DMA_STATUS);
+	else {
+		/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
+		writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
+	}
 
 	return ret;
 }
-- 
2.39.3


