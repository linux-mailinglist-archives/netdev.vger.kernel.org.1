Return-Path: <netdev+bounces-172758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB675A55E61
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D3E17806A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2999C19C575;
	Fri,  7 Mar 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YnNLcLV3"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3660192B9D;
	Fri,  7 Mar 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318370; cv=none; b=Ym0os1UN8jlMB/oCJ8TrxP4vUg+bOsK3jALzayxxRC3CPGUG/7a8R/icqXCD6HQHdPuzX+t1Ltu6pzoI45trx5/afrOHhEHBJYpwnyKl2XpukrMRrU/DagYKxCYjut+EFZ3YLsyxu/2chcJBdMu6no+Fq9GqHquwgPgQ4p8AO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318370; c=relaxed/simple;
	bh=cLR3XO7kWZQYktYmvXmdrEC9BRbL1a8Da4ICelZdX28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szQbJ0wIqsE9OVrDoVgsCrCpHe1NikOS8KtDRbU0ul5uPdAZyj5vnLi1ULM/orvPoHuBaKo+m0usBzpIs0KVhUlSIYOvuTkdczTo0U0Tr2o0yXHpamLaJ+/glUS4qMtT8Km3iIXrk1hNynRVrt0BMYPSdhtbYgROTL5yJszBEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YnNLcLV3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d347dd70fb0411efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GtnWzm5tVhkbSXaJox6KjZh8VSTYXm1my6FBXe3meLc=;
	b=YnNLcLV3+IFrbF5P3EFWmNB4/6qqi3rpvKlf8SW8LUhF2wEMJ8oXY8999VY8/NxlLp1jXLLAKA1fgeTiS4chLmgvTS4xd5NDhrFqWLuOF1PVB/MuEoyB1XSCWtz5Ykqi2HiC2a+WBZStThodV1CsGcHG05c3kL0FGCaqUlvSy7o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:7392aed1-91dd-4971-8775-910bdaa1cb88,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:0e6421ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d347dd70fb0411efaae1fd9735fae912-20250307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1512619247; Fri, 07 Mar 2025 11:32:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:39 +0800
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
Subject: [PATCH 07/26] clk: mediatek: Add MT8196 apmixedsys clock support
Date: Fri, 7 Mar 2025 11:27:03 +0800
Message-ID: <20250307032942.10447-8-guangjie.song@mediatek.com>
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

Add MT8196 apmixedsys clock controller which provides pll generated from
SoC 26m.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                 |   8 +
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c | 146 +++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5f8e6d68fa14..1e0c6f177ecd 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1002,6 +1002,14 @@ config COMMON_CLK_MT8195_VENCSYS
 	help
 	  This driver supports MediaTek MT8195 vencsys clocks.
 
+config COMMON_CLK_MT8196
+	tristate "Clock driver for MediaTek MT8196"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	help
+	  This driver supports MediaTek MT8196 basic clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6efec95406bd..6144fdce3f9a 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS) += clk-mt8195-vdo0.o clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
new file mode 100644
index 000000000000..3aa62eec07f7
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
@@ -0,0 +1,146 @@
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
+#define MAINPLL_CON0	0x250
+#define MAINPLL_CON1	0x254
+#define MAINPLL_CON2	0x258
+#define MAINPLL_CON3	0x25c
+#define UNIVPLL_CON0	0x264
+#define UNIVPLL_CON1	0x268
+#define UNIVPLL_CON2	0x26c
+#define UNIVPLL_CON3	0x270
+#define MSDCPLL_CON0	0x278
+#define MSDCPLL_CON1	0x27c
+#define MSDCPLL_CON2	0x280
+#define MSDCPLL_CON3	0x284
+#define ADSPPLL_CON0	0x28c
+#define ADSPPLL_CON1	0x290
+#define ADSPPLL_CON2	0x294
+#define ADSPPLL_CON3	0x298
+#define EMIPLL_CON0	0x2a0
+#define EMIPLL_CON1	0x2a4
+#define EMIPLL_CON2	0x2a8
+#define EMIPLL_CON3	0x2ac
+#define EMIPLL2_CON0	0x2b4
+#define EMIPLL2_CON1	0x2b8
+#define EMIPLL2_CON2	0x2bc
+#define EMIPLL2_CON3	0x2c0
+
+#define MT8196_PLL_FMAX		(3800UL * MHZ)
+#define MT8196_PLL_FMIN		(1500UL * MHZ)
+#define MT8196_INTEGER_BITS	8
+
+#define PLL_FENC(_id, _name, _reg, _fenc_sta_ofs, _fenc_sta_bit,	\
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
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_FENC(CLK_APMIXED_MAINPLL, "mainpll", MAINPLL_CON0,
+		 0x003c, 7, PLL_AO,
+		 MAINPLL_CON1, 24,
+		 MAINPLL_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED_UNIVPLL, "univpll", UNIVPLL_CON0,
+		 0x003c, 6, 0,
+		 UNIVPLL_CON1, 24,
+		 UNIVPLL_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED_MSDCPLL, "msdcpll", MSDCPLL_CON0,
+		 0x003c, 5, 0,
+		 MSDCPLL_CON1, 24,
+		 MSDCPLL_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED_ADSPPLL, "adsppll", ADSPPLL_CON0,
+		 0x003c, 4, 0,
+		 ADSPPLL_CON1, 24,
+		 ADSPPLL_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED_EMIPLL, "emipll", EMIPLL_CON0,
+		 0x003c, 3, PLL_AO,
+		 EMIPLL_CON1, 24,
+		 EMIPLL_CON1, 0, 22),
+	PLL_FENC(CLK_APMIXED_EMIPLL2, "emipll2", EMIPLL2_CON0,
+		 0x003c, 2, PLL_AO,
+		 EMIPLL2_CON1, 24,
+		 EMIPLL2_CON1, 0, 22),
+};
+
+static int clk_mt8196_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int num_plls = ARRAY_SIZE(apmixed_plls);
+	int r;
+
+	clk_data = mtk_alloc_clk_data(num_plls);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, apmixed_plls, num_plls, clk_data);
+	if (r) {
+		mtk_free_clk_data(clk_data);
+		return r;
+	}
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r) {
+		mtk_clk_unregister_plls(apmixed_plls, num_plls, clk_data);
+		mtk_free_clk_data(clk_data);
+		return r;
+	}
+
+	return 0;
+}
+
+static void clk_mt8196_apmixed_remove(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt8196_apmixed[] = {
+	{ .compatible = "mediatek,mt8196-apmixedsys", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_apmixed_drv = {
+	.probe = clk_mt8196_apmixed_probe,
+	.remove = clk_mt8196_apmixed_remove,
+	.driver = {
+		.name = "clk-mt8196-apmixed",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_clk_mt8196_apmixed,
+	},
+};
+
+module_platform_driver(clk_mt8196_apmixed_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


