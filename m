Return-Path: <netdev+bounces-172764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE43A55E79
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB311895B2B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB31ACECD;
	Fri,  7 Mar 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j5R6lLIo"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456781A314E;
	Fri,  7 Mar 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318376; cv=none; b=ndnaC1j7etVxB/KJxDv8CZnQMWIlR+S/AG9X2uIT4H5WMs4hVovA5r8FXN5Xqqd0nQmfjrKFZ4B7urkl0lGdCEn9dXvpbqpKkOUahXOzsnmA/8XTuoUZj/+UXCzwD4G6wBKtHP2VSDacA5nATY1Kb6hDVXPwyjudHrQd+JxaTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318376; c=relaxed/simple;
	bh=SByWSHzwv9B8UWYOvvm+zxpb8nPYZiHcT3PKoMx8PUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1arFHS9LaEPhYjVYKJP9jLnogfVdlnXH3Fpflb+yGsZ2OL/uAZFUGYuoc0UiYjlvckB5jQdFTdbuAnlTt4hsOundhuLtUKlmJRKSC22twAqSS0ofAbSpkDdEMDrwJQrxKWgJ2YqypJHRMq/jA+jc5KE9BENxu8h+Zm7bMhee90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j5R6lLIo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d63840b0fb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jMCt0E0Coh53qsaI+t68S2AOrh2oPxT/rPCegbhSZec=;
	b=j5R6lLIog6vTVOUvG/uOusMu3/WwZ5kOnuowkH7EOTin1AViMlt+sKVZiodg+ALYs3mzZme87m0XK9A9VNKfpFlrvEH8rG/sAQ/YoVK1YOPvobSWaF/6iKWpNYneMk3UE4EmoRUWqfYlYPU1yX8ND7oZXuYqi5W1V170jKdhj3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:03119e2d-2833-4ef7-8216-9c33991ae313,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:2fe307c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d63840b0fb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 422085566; Fri, 07 Mar 2025 11:32:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:44 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Guangjie Song
	<guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 12/26] clk: mediatek: Add MT8196 peripheral clock support
Date: Fri, 7 Mar 2025 11:27:08 +0800
Message-ID: <20250307032942.10447-13-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307032942.10447-1-guangjie.song@mediatek.com>
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add MT8196 peripheral clock controller which provides clock gate control
for dma/flashif/msdc/pwm/spi/uart.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Makefile             |   3 +-
 drivers/clk/mediatek/clk-mt8196-peri_ao.c | 218 ++++++++++++++++++++++
 2 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-peri_ao.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 583e5b9a7d40..c95e45356b78 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -151,7 +151,8 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-apmixedsys_gp2.o \
-				   clk-mt8196-topckgen.o clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o
+				   clk-mt8196-topckgen.o clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
+				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-peri_ao.c b/drivers/clk/mediatek/clk-mt8196-peri_ao.c
new file mode 100644
index 000000000000..775d77159641
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-peri_ao.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Guangjie Song <guangjie.song@mediatek.com>
+ */
+#include <dt-bindings/clock/mt8196-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs perao0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs perao1_cg_regs = {
+	.set_ofs = 0x2c,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x14,
+};
+
+static const struct mtk_gate_regs perao1_vote_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x000c,
+	.sta_ofs = 0x2c04,
+};
+
+static const struct mtk_gate_regs perao2_cg_regs = {
+	.set_ofs = 0x34,
+	.clr_ofs = 0x38,
+	.sta_ofs = 0x18,
+};
+
+#define GATE_PERAO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao0_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_PERAO0_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_PERAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao1_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_PERAO1_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_PERAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "vote-regmap",		\
+		.regs = &perao1_cg_regs,		\
+		.vote_regs = &perao1_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote,		\
+		.dma_ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_PERAO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao2_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_PERAO2_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate perao_clks[] = {
+	/* PERAO0 */
+	GATE_PERAO0(CLK_PERAO_UART0_BCLK, "perao_uart0_bclk", "ck_uart_ck", 0),
+	GATE_PERAO0_V(CLK_PERAO_UART0_BCLK_UART, "perao_uart0_bclk_uart", "perao_uart0_bclk"),
+	GATE_PERAO0(CLK_PERAO_UART1_BCLK, "perao_uart1_bclk", "ck_uart_ck", 1),
+	GATE_PERAO0_V(CLK_PERAO_UART1_BCLK_UART, "perao_uart1_bclk_uart", "perao_uart1_bclk"),
+	GATE_PERAO0(CLK_PERAO_UART2_BCLK, "perao_uart2_bclk", "ck_uart_ck", 2),
+	GATE_PERAO0_V(CLK_PERAO_UART2_BCLK_UART, "perao_uart2_bclk_uart", "perao_uart2_bclk"),
+	GATE_PERAO0(CLK_PERAO_UART3_BCLK, "perao_uart3_bclk", "ck_uart_ck", 3),
+	GATE_PERAO0_V(CLK_PERAO_UART3_BCLK_UART, "perao_uart3_bclk_uart", "perao_uart3_bclk"),
+	GATE_PERAO0(CLK_PERAO_UART4_BCLK, "perao_uart4_bclk", "ck_uart_ck", 4),
+	GATE_PERAO0_V(CLK_PERAO_UART4_BCLK_UART, "perao_uart4_bclk_uart", "perao_uart4_bclk"),
+	GATE_PERAO0(CLK_PERAO_UART5_BCLK, "perao_uart5_bclk", "ck_uart_ck", 5),
+	GATE_PERAO0_V(CLK_PERAO_UART5_BCLK_UART, "perao_uart5_bclk_uart", "perao_uart5_bclk"),
+	GATE_PERAO0(CLK_PERAO_PWM_X16W_HCLK, "perao_pwm_x16w", "ck_p_axi_ck", 12),
+	GATE_PERAO0_V(CLK_PERAO_PWM_X16W_HCLK_PWM, "perao_pwm_x16w_pwm", "perao_pwm_x16w"),
+	GATE_PERAO0(CLK_PERAO_PWM_X16W_BCLK, "perao_pwm_x16w_bclk", "ck_pwm_ck", 13),
+	GATE_PERAO0_V(CLK_PERAO_PWM_X16W_BCLK_PWM, "perao_pwm_x16w_bclk_pwm",
+		      "perao_pwm_x16w_bclk"),
+	GATE_PERAO0(CLK_PERAO_PWM_PWM_BCLK0, "perao_pwm_pwm_bclk0", "ck_pwm_ck", 14),
+	GATE_PERAO0_V(CLK_PERAO_PWM_PWM_BCLK0_PWM, "perao_pwm_pwm_bclk0_pwm",
+		      "perao_pwm_pwm_bclk0"),
+	GATE_PERAO0(CLK_PERAO_PWM_PWM_BCLK1, "perao_pwm_pwm_bclk1", "ck_pwm_ck", 15),
+	GATE_PERAO0_V(CLK_PERAO_PWM_PWM_BCLK1_PWM, "perao_pwm_pwm_bclk1_pwm",
+		      "perao_pwm_pwm_bclk1"),
+	GATE_PERAO0(CLK_PERAO_PWM_PWM_BCLK2, "perao_pwm_pwm_bclk2", "ck_pwm_ck", 16),
+	GATE_PERAO0_V(CLK_PERAO_PWM_PWM_BCLK2_PWM, "perao_pwm_pwm_bclk2_pwm",
+		      "perao_pwm_pwm_bclk2"),
+	GATE_PERAO0(CLK_PERAO_PWM_PWM_BCLK3, "perao_pwm_pwm_bclk3", "ck_pwm_ck", 17),
+	GATE_PERAO0_V(CLK_PERAO_PWM_PWM_BCLK3_PWM, "perao_pwm_pwm_bclk3_pwm",
+		      "perao_pwm_pwm_bclk3"),
+	/* PERAO1 */
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI0_BCLK, "perao_spi0_bclk", "ck_spi0_b_ck", 0),
+	GATE_PERAO1_V(CLK_PERAO_SPI0_BCLK_SPI, "perao_spi0_bclk_spi", "perao_spi0_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI1_BCLK, "perao_spi1_bclk", "ck_spi1_b_ck", 2),
+	GATE_PERAO1_V(CLK_PERAO_SPI1_BCLK_SPI, "perao_spi1_bclk_spi", "perao_spi1_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI2_BCLK, "perao_spi2_bclk", "ck_spi2_b_ck", 3),
+	GATE_PERAO1_V(CLK_PERAO_SPI2_BCLK_SPI, "perao_spi2_bclk_spi", "perao_spi2_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI3_BCLK, "perao_spi3_bclk", "ck_spi3_b_ck", 4),
+	GATE_PERAO1_V(CLK_PERAO_SPI3_BCLK_SPI, "perao_spi3_bclk_spi", "perao_spi3_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI4_BCLK, "perao_spi4_bclk", "ck_spi4_b_ck", 5),
+	GATE_PERAO1_V(CLK_PERAO_SPI4_BCLK_SPI, "perao_spi4_bclk_spi", "perao_spi4_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI5_BCLK, "perao_spi5_bclk", "ck_spi5_b_ck", 6),
+	GATE_PERAO1_V(CLK_PERAO_SPI5_BCLK_SPI, "perao_spi5_bclk_spi", "perao_spi5_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI6_BCLK, "perao_spi6_bclk", "ck_spi6_b_ck", 7),
+	GATE_PERAO1_V(CLK_PERAO_SPI6_BCLK_SPI, "perao_spi6_bclk_spi", "perao_spi6_bclk"),
+	GATE_VOTE_PERAO1(CLK_PERAO_SPI7_BCLK, "perao_spi7_bclk", "ck_spi7_b_ck", 8),
+	GATE_PERAO1_V(CLK_PERAO_SPI7_BCLK_SPI, "perao_spi7_bclk_spi", "perao_spi7_bclk"),
+	GATE_PERAO1(CLK_PERAO_FLASHIF_FLASH, "perao_flashif_flash", "ck_sflash_ck", 18),
+	GATE_PERAO1_V(CLK_PERAO_FLASHIF_FLASH_FLASHIF, "perao_flashif_flash_flashif",
+		      "perao_flashif_flash"),
+	GATE_PERAO1(CLK_PERAO_FLASHIF_27M, "perao_flashif_27m", "ck_sflash_ck", 19),
+	GATE_PERAO1_V(CLK_PERAO_FLASHIF_27M_FLASHIF, "perao_flashif_27m_flashif",
+		      "perao_flashif_27m"),
+	GATE_PERAO1(CLK_PERAO_FLASHIF_DRAM, "perao_flashif_dram", "ck_p_axi_ck", 20),
+	GATE_PERAO1_V(CLK_PERAO_FLASHIF_DRAM_FLASHIF, "perao_flashif_dram_flashif",
+		      "perao_flashif_dram"),
+	GATE_PERAO1(CLK_PERAO_FLASHIF_AXI, "perao_flashif_axi", "ck_p_axi_ck", 21),
+	GATE_PERAO1_V(CLK_PERAO_FLASHIF_AXI_FLASHIF, "perao_flashif_axi_flashif",
+		      "perao_flashif_axi"),
+	GATE_PERAO1(CLK_PERAO_FLASHIF_BCLK, "perao_flashif_bclk", "ck_p_axi_ck", 22),
+	GATE_PERAO1_V(CLK_PERAO_FLASHIF_BCLK_FLASHIF, "perao_flashif_bclk_flashif",
+		      "perao_flashif_bclk"),
+	GATE_PERAO1(CLK_PERAO_AP_DMA_X32W_BCLK, "perao_ap_dma_x32w_bclk", "ck_p_axi_ck", 26),
+	GATE_PERAO1_V(CLK_PERAO_AP_DMA_X32W_BCLK_UART, "perao_ap_dma_x32w_bclk_uart",
+		      "perao_ap_dma_x32w_bclk"),
+	GATE_PERAO1_V(CLK_PERAO_AP_DMA_X32W_BCLK_I2C, "perao_ap_dma_x32w_bclk_i2c",
+		      "perao_ap_dma_x32w_bclk"),
+	/* PERAO2 */
+	GATE_PERAO2(CLK_PERAO_MSDC1_MSDC_SRC, "perao_msdc1_msdc_src", "ck_msdc30_1_ck", 1),
+	GATE_PERAO2_V(CLK_PERAO_MSDC1_MSDC_SRC_MSDC1, "perao_msdc1_msdc_src_msdc1",
+		      "perao_msdc1_msdc_src"),
+	GATE_PERAO2(CLK_PERAO_MSDC1_HCLK, "perao_msdc1", "ck_msdc30_1_ck", 2),
+	GATE_PERAO2_V(CLK_PERAO_MSDC1_HCLK_MSDC1, "perao_msdc1_msdc1", "perao_msdc1"),
+	GATE_PERAO2(CLK_PERAO_MSDC1_AXI, "perao_msdc1_axi", "ck_p_axi_ck", 3),
+	GATE_PERAO2_V(CLK_PERAO_MSDC1_AXI_MSDC1, "perao_msdc1_axi_msdc1", "perao_msdc1_axi"),
+	GATE_PERAO2(CLK_PERAO_MSDC1_HCLK_WRAP, "perao_msdc1_h_wrap", "ck_p_axi_ck", 4),
+	GATE_PERAO2_V(CLK_PERAO_MSDC1_HCLK_WRAP_MSDC1, "perao_msdc1_h_wrap_msdc1",
+		      "perao_msdc1_h_wrap"),
+	GATE_PERAO2(CLK_PERAO_MSDC2_MSDC_SRC, "perao_msdc2_msdc_src", "ck_msdc30_2_ck", 10),
+	GATE_PERAO2_V(CLK_PERAO_MSDC2_MSDC_SRC_MSDC2, "perao_msdc2_msdc_src_msdc2",
+		      "perao_msdc2_msdc_src"),
+	GATE_PERAO2(CLK_PERAO_MSDC2_HCLK, "perao_msdc2", "ck_msdc30_2_ck", 11),
+	GATE_PERAO2_V(CLK_PERAO_MSDC2_HCLK_MSDC2, "perao_msdc2_msdc2", "perao_msdc2"),
+	GATE_PERAO2(CLK_PERAO_MSDC2_AXI, "perao_msdc2_axi", "ck_p_axi_ck", 12),
+	GATE_PERAO2_V(CLK_PERAO_MSDC2_AXI_MSDC2, "perao_msdc2_axi_msdc2", "perao_msdc2_axi"),
+	GATE_PERAO2(CLK_PERAO_MSDC2_HCLK_WRAP, "perao_msdc2_h_wrap", "ck_p_axi_ck", 13),
+	GATE_PERAO2_V(CLK_PERAO_MSDC2_HCLK_WRAP_MSDC2, "perao_msdc2_h_wrap_msdc2",
+		      "perao_msdc2_h_wrap"),
+};
+
+static const struct mtk_clk_desc perao_mcd = {
+	.clks = perao_clks,
+	.num_clks = ARRAY_SIZE(perao_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8196_peri_ao[] = {
+	{ .compatible = "mediatek,mt8196-pericfg_ao", .data = &perao_mcd, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_peri_ao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-peri_ao",
+		.of_match_table = of_match_clk_mt8196_peri_ao,
+	},
+};
+
+module_platform_driver(clk_mt8196_peri_ao_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


