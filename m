Return-Path: <netdev+bounces-24003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBEA76E6F0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608111C21577
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369FA1F179;
	Thu,  3 Aug 2023 11:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB11ADF1
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:30:24 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 483821981
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:30:22 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8DxqOrMj8tkJa0PAA--.26853S3;
	Thu, 03 Aug 2023 19:30:20 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSPJj8tkgx5HAA--.33765S4;
	Thu, 03 Aug 2023 19:30:19 +0800 (CST)
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
Subject: [PATCH v3 10/16] net: stmmac: Add Loongson HWIF entry
Date: Thu,  3 Aug 2023 19:30:04 +0800
Message-Id: <3fc6c764fc8e6aa8aa4bafeaa5f3bb6bd3f2880b.1691047285.git.chenfeiyang@loongson.cn>
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
X-CM-TRANSID:AQAAf8BxXSPJj8tkgx5HAA--.33765S4
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFyfKF1xur1DGr4Dur4Utrc_yoW5ur4Dpa
	yDAa4jvryxtr1Ivan7Aw4kZF98Ga4fKr1UWa1xK39xWFsFkry2qryaqFW5CrnrJFWjgFy3
	tw1j9w1DCF4DAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxNeODUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new entries to HWIF table for Loongson.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c    | 37 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index b8e102346f87..967652c9a6ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -549,6 +549,7 @@ int dwmac1000_setup(struct stmmac_priv *priv);
 int dwmac4_setup(struct stmmac_priv *priv);
 int dwxgmac2_setup(struct stmmac_priv *priv);
 int dwxlgmac2_setup(struct stmmac_priv *priv);
+int dwmac_loongson_setup(struct stmmac_priv *priv);
 
 void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 			 unsigned int high, unsigned int low);
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index c5768bbec38e..26c35ed4782d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -61,7 +61,8 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
 		dev_info(priv->device, "Enhanced/Alternate descriptors\n");
 
 		/* GMAC older than 3.50 has no extended descriptors */
-		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
+		if (priv->synopsys_id >= DWMAC_CORE_3_50 ||
+		    priv->synopsys_id == DWLGMAC_CORE_1_00) {
 			dev_info(priv->device, "Enabled extended descriptors\n");
 			priv->extend_desc = 1;
 		} else {
@@ -267,6 +268,40 @@ static const struct stmmac_hwif_entry {
 		.mmc = &dwxgmac_mmc_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
+	}, {
+		.gmac = true,
+		.gmac4 = false,
+		.xgmac = false,
+		.min_id = DWLGMAC_CORE_1_00,
+		.regs = {
+			.ptp_off = PTP_GMAC3_X_OFFSET,
+			.mmc_off = MMC_GMAC3_X_OFFSET,
+		},
+		.desc = NULL,
+		.dma = &dwmac1000_dma_ops,
+		.mac = &dwmac1000_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = NULL,
+		.setup = dwmac1000_setup,
+		.quirks = stmmac_dwmac1_quirks,
+	}, {
+		.gmac = true,
+		.gmac4 = false,
+		.xgmac = false,
+		.min_id = DWMAC_CORE_3_50,
+		.regs = {
+			.ptp_off = PTP_GMAC3_X_OFFSET,
+			.mmc_off = MMC_GMAC3_X_OFFSET,
+		},
+		.desc = NULL,
+		.dma = &dwmac1000_dma_ops,
+		.mac = &dwmac1000_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = NULL,
+		.setup = dwmac1000_setup,
+		.quirks = stmmac_dwmac1_quirks,
 	},
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7abe3bb8c626..5eafb08e2332 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6938,6 +6938,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	 * riwt_off field from the platform.
 	 */
 	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
+	    (priv->synopsys_id == DWLGMAC_CORE_1_00) ||
 	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
 		priv->use_riwt = 1;
 		dev_info(priv->device,
-- 
2.39.3


