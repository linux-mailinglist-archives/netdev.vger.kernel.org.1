Return-Path: <netdev+bounces-23997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CE76E6DF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70677282101
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D61EA7E;
	Thu,  3 Aug 2023 11:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD518C05
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:29:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 491981982
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:29:37 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8Dxfeufj8tk8awPAA--.33965S3;
	Thu, 03 Aug 2023 19:29:35 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzM6dj8tkKx5HAA--.52441S3;
	Thu, 03 Aug 2023 19:29:34 +0800 (CST)
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
Subject: [PATCH v3 05/16] net: stmmac: dwmac1000: Add Loongson register definitions
Date: Thu,  3 Aug 2023 19:29:25 +0800
Message-Id: <007d8dcd32e25471c1f91f28550c1274eff58085.1691047285.git.chenfeiyang@loongson.cn>
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
X-CM-TRANSID:AQAAf8DxzM6dj8tkKx5HAA--.52441S3
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr15Kry7CF17KFy7Gw1kXrc_yoWxtr4xpa
	9rAa45CrWxtr4rXws5Aw48XFy5G3yYkFZrur4xKwnI9FWqv34qq34jkFW7CFnxJFW7JryS
	gF4jvwnrWFs0kwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add definitions for Loongson platform.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 +
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  7 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 88 +++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 90a7784f71cb..b8e102346f87 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -29,11 +29,13 @@
 /* Synopsys Core versions */
 #define	DWMAC_CORE_3_40		0x34
 #define	DWMAC_CORE_3_50		0x35
+#define	DWMAC_CORE_3_70		0x37
 #define	DWMAC_CORE_4_00		0x40
 #define DWMAC_CORE_4_10		0x41
 #define DWMAC_CORE_5_00		0x50
 #define DWMAC_CORE_5_10		0x51
 #define DWMAC_CORE_5_20		0x52
+#define DWLGMAC_CORE_1_00	0x10
 #define DWXGMAC_CORE_2_10	0x21
 #define DWXLGMAC_CORE_2_00	0x20
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 6b28f08c8640..abcce58e9c29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -534,7 +534,12 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 
 	dev_info(priv->device, "\tDWMAC1000\n");
 
-	priv->plat->dwmac_regs = &dwmac_default_dma_regs;
+	if (priv->synopsys_id == DWLGMAC_CORE_1_00)
+		priv->plat->dwmac_regs = &dwmac_loongson_dma_regs;
+	else if (priv->plat->dma_cfg->dma64)
+		priv->plat->dwmac_regs = &dwmac_loongson64_dma_regs;
+	else
+		priv->plat->dwmac_regs = &dwmac_default_dma_regs;
 
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 	mac->pcsr = priv->ioaddr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index b2b75b5b6d50..2da5888342fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -102,6 +102,8 @@
 #define NUM_DWMAC4_DMA_REGS	27
 
 extern const struct dwmac_regs dwmac_default_dma_regs;
+extern const struct dwmac_regs dwmac_loongson_dma_regs;
+extern const struct dwmac_regs dwmac_loongson64_dma_regs;
 
 void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 chan);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index cf9e3e7b6b3f..fc0da4336e4e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -21,6 +21,25 @@ static const struct dwmac_dma_addrs default_dma_addrs = {
 	.cur_rx_buf_addr = 0x00001054,
 };
 
+static const struct dwmac_dma_addrs loongson_dma_addrs = {
+	.chan_offset = 0x100,
+	.rcv_base_addr = 0x0000100c,
+	.tx_base_addr = 0x00001010,
+	.cur_tx_buf_addr = 0x00001050,
+	.cur_rx_buf_addr = 0x00001054,
+	.rcv_base_addr_shadow1 = 0x00001068,
+	.rcv_base_addr_shadow2 = 0x000010a8,
+};
+
+static const struct dwmac_dma_addrs loongson64_dma_addrs = {
+	.rcv_base_addr = 0x00001090,
+	.tx_base_addr = 0x00001098,
+	.cur_tx_buf_addr = 0x000010b0,
+	.cur_rx_buf_addr = 0x000010b8,
+	.rcv_base_addr_shadow1 = 0x00001068,
+	.rcv_base_addr_shadow2 = 0x000010a8,
+};
+
 static const struct dwmac_dma_axi default_dma_axi = {
 	.wr_osr_lmt = GENMASK(23, 20),
 	.wr_osr_lmt_shift = 20,
@@ -35,6 +54,20 @@ static const struct dwmac_dma_axi default_dma_axi = {
 	.max_osr_limit = (0xf << 20) | (0xf << 16),
 };
 
+static const struct dwmac_dma_axi loongson_dma_axi = {
+	.wr_osr_lmt = BIT(20),
+	.wr_osr_lmt_shift = 20,
+	.wr_osr_lmt_mask = 0x1,
+	.rd_osr_lmt = BIT(16),
+	.rd_osr_lmt_shift = 16,
+	.rd_osr_lmt_mask = 0x1,
+	.osr_max = 0x1,
+	/* max_osr_limit = (osr_max << wr_osr_lmt_shift) |
+	 *                 (osr_max << rd_osr_lmt_shift)
+	 */
+	.max_osr_limit = (0x1 << 20) | (0x1 << 16),
+};
+
 static const struct dwmac_dma_intr_ena default_dma_intr_ena = {
 	.nie = 0x00010000,
 	/* normal = nie | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE */
@@ -47,6 +80,18 @@ static const struct dwmac_dma_intr_ena default_dma_intr_ena = {
 			(0x00008000 | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE),
 };
 
+static const struct dwmac_dma_intr_ena loongson_dma_intr_ena = {
+	.nie = 0x00060000,
+	/* normal = nie | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE */
+	.normal = 0x00060000 | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE,
+	.aie = 0x00018000,
+	/* abnormal = aie | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE */
+	.abnormal = 0x00018000 | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE,
+	/* default_mask = normal | abnormal */
+	.default_mask = (0x00060000 | DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE) |
+			(0x00018000 | DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE),
+};
+
 static const struct dwmac_dma_status default_dma_status = {
 	.glpii = 0x40000000,
 	.gpi = 0x10000000,
@@ -79,6 +124,35 @@ static const struct dwmac_dma_status default_dma_status = {
 		  0x00010000 | 0x00008000 | 0x00002000,
 };
 
+static const struct dwmac_dma_status loongson_dma_status = {
+	.glpii = 0x10000000,
+	.intr_mask = 0x7ffff,
+	.eb_mask = 0x0e000000,
+	.ts_mask = 0x01c00000,
+	.ts_shift = 22,
+	.rs_mask = 0x00380000,
+	.rs_shift = 19,
+	.nis = 0x00060000,
+	.ais = 0x00018000,
+	.fbi = 0x00003000,
+	/* msk_common = nis | ais | fbi */
+	.msk_common = 0x00060000 | 0x00018000 | 0x00003000,
+	/* msk_rx = DMA_STATUS_ERI | DMA_STATUS_RWT |  DMA_STATUS_RPS |
+	 *          DMA_STATUS_RU | DMA_STATUS_RI | DMA_STATUS_OVF |
+	 *          msk_common
+	 */
+	.msk_rx = DMA_STATUS_ERI | DMA_STATUS_RWT | DMA_STATUS_RPS |
+		  DMA_STATUS_RU | DMA_STATUS_RI | DMA_STATUS_OVF |
+		  0x00060000 | 0x00018000 | 0x00003000,
+	/* msk_tx = DMA_STATUS_ETI | DMA_STATUS_UNF | DMA_STATUS_TJT |
+	 *          DMA_STATUS_TU | DMA_STATUS_TPS | DMA_STATUS_TI |
+	 *          msk_common
+	 */
+	.msk_tx = DMA_STATUS_ETI | DMA_STATUS_UNF | DMA_STATUS_TJT |
+		  DMA_STATUS_TU | DMA_STATUS_TPS | DMA_STATUS_TI |
+		  0x00060000 | 0x00018000 | 0x00003000,
+};
+
 const struct dwmac_regs dwmac_default_dma_regs = {
 	.addrs = &default_dma_addrs,
 	.axi = &default_dma_axi,
@@ -86,6 +160,20 @@ const struct dwmac_regs dwmac_default_dma_regs = {
 	.status = &default_dma_status,
 };
 
+const struct dwmac_regs dwmac_loongson_dma_regs = {
+	.addrs = &loongson_dma_addrs,
+	.axi = &loongson_dma_axi,
+	.intr_ena = &loongson_dma_intr_ena,
+	.status = &loongson_dma_status,
+};
+
+const struct dwmac_regs dwmac_loongson64_dma_regs = {
+	.addrs = &loongson64_dma_addrs,
+	.axi = &loongson_dma_axi,
+	.intr_ena = &default_dma_intr_ena,
+	.status = &default_dma_status,
+};
+
 int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
-- 
2.39.3


