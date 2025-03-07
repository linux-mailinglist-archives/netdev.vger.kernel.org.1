Return-Path: <netdev+bounces-172759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9507FA55E69
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EEE3B4B11
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF51A00FA;
	Fri,  7 Mar 2025 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="enU4Ob++"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97439197552;
	Fri,  7 Mar 2025 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318371; cv=none; b=tfACWbp/Nk5GcpY16fI16Szh6Ku4Va3gC9Ehz1uLaHS6YbD//K81k7ghqUs1tATo5DEgsQ2OL7yomCsb2MEyrFRvFMl3XLnRAbyDK/iaYeZrziwOTY+NRf4uMvKvvnv2vuxeP06IZIvfyawWr50GW3Le0xUKm5Z3x0hRFXaSzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318371; c=relaxed/simple;
	bh=/aKHOGJ6lQeJr+mrhBPbs3Y/KuWWLYoVkFa5QWu4US0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLpkJRYfbW5eRifMhZeOpo4BM8mDPFOawZ+XFsUihjfbduWii7yaq8QlUqyE0ebAnYGpwVm7zDMjr09A3/7xcPpQHkuvbx1SlQc9WSsIMjtjL3Kuub8OVU0eOlwGTKCBGzpdhfgXfdFPXRNKkQ6mAkmTAg+0nsNNUbmOVjtt5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=enU4Ob++; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d3dbf942fb0411efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lke6nTx8Kn+xmKD6dSCYG3ajKAm3MT4NJU3X/4qY93E=;
	b=enU4Ob++gu/SsJJf/zNC+/NGCMjyA5kJhAjyWlYMFNyv3RFt2gSNGoGJeRcn6eDLkoqoQDpXEAwavfD6y0Hy3fPIjGcefQHPsQNkQRXQucvpg7Bmf+s0P/jS3NxN+P369B7f5Ud2v+c4P/os4y4Sjf0Xb8X6xm8mWmm8ozC4stc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:242f5bba-149b-40fd-895a-5ff009f84d87,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:d427cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d3dbf942fb0411efaae1fd9735fae912-20250307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1227379568; Fri, 07 Mar 2025 11:32:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:41 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:40 +0800
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
Subject: [PATCH 08/26] clk: mediatek: Add MT8196 apmixedsys_gp2 clock support
Date: Fri, 7 Mar 2025 11:27:04 +0800
Message-ID: <20250307032942.10447-9-guangjie.song@mediatek.com>
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

Add MT8196 apmixedsys_gp2 clock controller which provides pll generated
from SoC 26m

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Makefile                 |   2 +-
 .../clk/mediatek/clk-mt8196-apmixedsys_gp2.c  | 154 ++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys_gp2.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6144fdce3f9a..247bad396cfb 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -150,7 +150,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS) += clk-mt8195-vdo0.o clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
-obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o
+obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-apmixedsys_gp2.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-apmixedsys_gp2.c b/drivers/clk/mediatek/clk-mt8196-apmixedsys_gp2.c
new file mode 100644
index 000000000000..dc895d103bfe
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-apmixedsys_gp2.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Guangjie Song <guangjie.song@mediatek.com>
+ */
+#include <dt-bindings/clock/mt8196-clk.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+/* PLL REG */
+#define MAINPLL2_CON0	0x250
+#define MAINPLL2_CON1	0x254
+#define MAINPLL2_CON2	0x258
+#define MAINPLL2_CON3	0x25c
+#define UNIVPLL2_CON0	0x264
+#define UNIVPLL2_CON1	0x268
+#define UNIVPLL2_CON2	0x26c
+#define UNIVPLL2_CON3	0x270
+#define MMPLL2_CON0	0x278
+#define MMPLL2_CON1	0x27c
+#define MMPLL2_CON2	0x280
+#define MMPLL2_CON3	0x284
+#define IMGPLL_CON0	0x28c
+#define IMGPLL_CON1	0x290
+#define IMGPLL_CON2	0x294
+#define IMGPLL_CON3	0x298
+#define TVDPLL1_CON0	0x2a0
+#define TVDPLL1_CON1	0x2a4
+#define TVDPLL1_CON2	0x2a8
+#define TVDPLL1_CON3	0x2ac
+#define TVDPLL2_CON0	0x2b4
+#define TVDPLL2_CON1	0x2b8
+#define TVDPLL2_CON2	0x2bc
+#define TVDPLL2_CON3	0x2c0
+#define TVDPLL3_CON0	0x2c8
+#define TVDPLL3_CON1	0x2cc
+#define TVDPLL3_CON2	0x2d0
+#define TVDPLL3_CON3	0x2d4
+
+#define MT8196_PLL_FMAX		(3800UL * MHZ)
+#define MT8196_PLL_FMIN		(1500UL * MHZ)
+#define MT8196_INTEGER_BITS	8
+
+#define PLL_FENC(_id, _name, _reg, _fenc_sta_ofs, _fenc_sta_bit,\
+		 _flags, _pd_reg, _pd_shift,			\
+		 _pcw_reg, _pcw_shift, _pcwbits) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.reg = _reg,					\
+		.fenc_sta_ofs = _fenc_sta_ofs,			\
+		.fenc_sta_bit = _fenc_sta_bit,			\
+		.flags = (_flags) | CLK_FENC_ENABLE,		\
+		.fmax = MT8196_PLL_FMAX,			\
+		.fmin = MT8196_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8196_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data apmixed2_plls[] = {
+	PLL_FENC(CLK_APMIXED2_MAINPLL2, "mainpll2", MAINPLL2_CON0,
+		 0x03c, 6, 0,
+		 MAINPLL2_CON1, 24,
+		 MAINPLL2_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED2_UNIVPLL2, "univpll2", UNIVPLL2_CON0,
+		 0x03c, 5, 0,
+		 UNIVPLL2_CON1, 24,
+		 UNIVPLL2_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED2_MMPLL2, "mmpll2", MMPLL2_CON0,
+		 0x03c, 4, 0,
+		 MMPLL2_CON1, 24,
+		 MMPLL2_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED2_IMGPLL, "imgpll", IMGPLL_CON0,
+		 0x03c, 3, 0,
+		 IMGPLL_CON1, 24,
+		 IMGPLL_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED2_TVDPLL1, "tvdpll1", TVDPLL1_CON0,
+		 0x03c, 2, 0,
+		 TVDPLL1_CON1, 24,
+		 TVDPLL1_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED2_TVDPLL2, "tvdpll2", TVDPLL2_CON0,
+		 0x03c, 1, 0,
+		 TVDPLL2_CON1, 24,
+		 TVDPLL2_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED2_TVDPLL3, "tvdpll3", TVDPLL3_CON0,
+		 0x03c, 0, 0,
+		 TVDPLL3_CON1, 24,
+		 TVDPLL3_CON1, 0, 22),
+};
+
+static int clk_mt8196_apmixed2_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int num_plls = ARRAY_SIZE(apmixed2_plls);
+	int r;
+
+	clk_data = mtk_alloc_clk_data(num_plls);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, apmixed2_plls, num_plls, clk_data);
+	if (r) {
+		mtk_free_clk_data(clk_data);
+		return r;
+	}
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r) {
+		mtk_clk_unregister_plls(apmixed2_plls, num_plls, clk_data);
+		mtk_free_clk_data(clk_data);
+		return r;
+	}
+
+	return 0;
+}
+
+static void clk_mt8196_apmixed2_remove(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(apmixed2_plls, ARRAY_SIZE(apmixed2_plls), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt8196_apmixed2[] = {
+	{ .compatible = "mediatek,mt8196-apmixedsys_gp2", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_apmixed2_drv = {
+	.probe = clk_mt8196_apmixed2_probe,
+	.remove = clk_mt8196_apmixed2_remove,
+	.driver = {
+		.name = "clk-mt8196-apmixed2",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_clk_mt8196_apmixed2,
+	},
+};
+
+module_platform_driver(clk_mt8196_apmixed2_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


