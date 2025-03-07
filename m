Return-Path: <netdev+bounces-172773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850EA55E9C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D9E3AA1BB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136D20DD4B;
	Fri,  7 Mar 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hZcS4kQh"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1E2054E2;
	Fri,  7 Mar 2025 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318385; cv=none; b=AiYNVVLGB72zgVknECDoHjnlXECG223Em9HIJEKbkCv4emhn5ZaidQj+nTaFhiKQEEyvtNT16SIXtDB4EzH0vKc3VL5KUBzqGtYm4E1BnNf1VwY2Tq/o02KSvUksiXOKGhJYK21oMlj5VcqIkTsN8bpfmRFZz0I2AXt2ZXzaaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318385; c=relaxed/simple;
	bh=rXNbW7+AyzYRFkTxd8ArGZ9NLDm2J4VUdnnRbBBwB3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKBhUfUF5tq++qwzy18DiE94oVWYlJlUhr43Db3r+OnyssAwgP7Dovb2+QvT/AFqV0c27APZ81getI1EjxdooW8QOCaPxtKUT18xDJn6l8ux/mlm986pVzDlQ7WhbWhIf0NJg7/SDr4lrKIX8YZjjFOtR3z3CYANVJJ1w28Mt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hZcS4kQh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dcf40ecafb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ys+Z3XZrVwmpLpc6Hy5rZdPiEPv1YQZi+/Nfmbq4RRA=;
	b=hZcS4kQhKQih5OtonnbKW5DN3itMJNcPb7E6Fu+i1JRjksqLpMCy4ozX+USnXgwHsJXhm+zlbl5E0UdMteXvyUttdzIL37y69evsQjEhjxQEa+7TuX95UL54abDENX4GY6Fr+4UwoSOTP/uKXHrPIJ/o20P2eBKDhwHra020S2k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:62ee1f69-f55f-4eb6-acb0-f495c6446ddc,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:2d6521ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dcf40ecafb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 29502451; Fri, 07 Mar 2025 11:32:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:55 +0800
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
Subject: [PATCH 24/26] clk: mediatek: Add MT8196 ufssys clock support
Date: Fri, 7 Mar 2025 11:27:20 +0800
Message-ID: <20250307032942.10447-25-guangjie.song@mediatek.com>
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

Add MT8196 ufssys clock controller which provides clock gate control
for ufs.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Kconfig             |   7 ++
 drivers/clk/mediatek/Makefile            |   1 +
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c | 107 +++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2aafba083835..5fc24f52762a 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1059,6 +1059,13 @@ config COMMON_CLK_MT8196_PEXTPSYS
 	help
 	  This driver supports MediaTek MT8196 pextpsys clocks.
 
+config COMMON_CLK_MT8196_UFSSYS
+	tristate "Clock driver for MediaTek MT8196 ufssys"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 ufssys clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 3058e7855ff3..e5b4a3a61ef7 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -161,6 +161,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o clk-mt8196-vdisp_ao.o \
 					 clk-mt8196-ovl0.o clk-mt8196-ovl1.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
+obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-ufs_ao.c b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
new file mode 100644
index 000000000000..107522759bd2
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
@@ -0,0 +1,107 @@
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
+static const struct mtk_gate_regs ufsao0_cg_regs = {
+	.set_ofs = 0x108,
+	.clr_ofs = 0x10c,
+	.sta_ofs = 0x104,
+};
+
+static const struct mtk_gate_regs ufsao1_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSAO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ufsao0_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_UFSAO0_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_UFSAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ufsao1_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_UFSAO1_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate ufsao_clks[] = {
+	/* UFSAO0 */
+	GATE_UFSAO0(CLK_UFSAO_UFSHCI_UFS, "ufsao_ufshci_ufs", "ck_ck", 0),
+	GATE_UFSAO0_V(CLK_UFSAO_UFSHCI_UFS_UFS, "ufsao_ufshci_ufs_ufs", "ufsao_ufshci_ufs"),
+	GATE_UFSAO0(CLK_UFSAO_UFSHCI_AES, "ufsao_ufshci_aes", "ck_aes_ufsfde_ck", 1),
+	GATE_UFSAO0_V(CLK_UFSAO_UFSHCI_AES_UFS, "ufsao_ufshci_aes_ufs", "ufsao_ufshci_aes"),
+	/* UFSAO1 */
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_TX_SYM, "ufsao_unipro_tx_sym", "ck_f26m_ck", 0),
+	GATE_UFSAO1_V(CLK_UFSAO_UNIPRO_TX_SYM_UFS, "ufsao_unipro_tx_sym_ufs",
+		      "ufsao_unipro_tx_sym"),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM0, "ufsao_unipro_rx_sym0", "ck_f26m_ck", 1),
+	GATE_UFSAO1_V(CLK_UFSAO_UNIPRO_RX_SYM0_UFS, "ufsao_unipro_rx_sym0_ufs",
+		      "ufsao_unipro_rx_sym0"),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM1, "ufsao_unipro_rx_sym1", "ck_f26m_ck", 2),
+	GATE_UFSAO1_V(CLK_UFSAO_UNIPRO_RX_SYM1_UFS, "ufsao_unipro_rx_sym1_ufs",
+		      "ufsao_unipro_rx_sym1"),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_SYS, "ufsao_unipro_sys", "ck_ck", 3),
+	GATE_UFSAO1_V(CLK_UFSAO_UNIPRO_SYS_UFS, "ufsao_unipro_sys_ufs", "ufsao_unipro_sys"),
+	GATE_UFSAO1(CLK_UFSAO_UNIPRO_SAP, "ufsao_unipro_sap", "ck_f26m_ck", 4),
+	GATE_UFSAO1_V(CLK_UFSAO_UNIPRO_SAP_UFS, "ufsao_unipro_sap_ufs", "ufsao_unipro_sap"),
+	GATE_UFSAO1(CLK_UFSAO_PHY_SAP, "ufsao_phy_sap", "ck_f26m_ck", 8),
+	GATE_UFSAO1_V(CLK_UFSAO_PHY_SAP_UFS, "ufsao_phy_sap_ufs", "ufsao_phy_sap"),
+};
+
+static const struct mtk_clk_desc ufsao_mcd = {
+	.clks = ufsao_clks,
+	.num_clks = ARRAY_SIZE(ufsao_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8196_ufs_ao[] = {
+	{ .compatible = "mediatek,mt8196-ufscfg_ao", .data = &ufsao_mcd, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_ufs_ao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-ufs_ao",
+		.of_match_table = of_match_clk_mt8196_ufs_ao,
+	},
+};
+
+module_platform_driver(clk_mt8196_ufs_ao_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


