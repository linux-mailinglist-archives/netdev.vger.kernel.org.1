Return-Path: <netdev+bounces-172771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA95AA55E95
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69A417830D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9FA20C000;
	Fri,  7 Mar 2025 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f37yceHk"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A041E1DF5;
	Fri,  7 Mar 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318383; cv=none; b=d/2npzWmewLEOkozpkaSnXiiTvWrsgHWkTlfZlO/WtDS1aF0LfshiI0TjwlVYxYw8J3ywfLcuHm0DP32HPRfmLNQ8Qt/ywh+at/RVDDgAsu98rvnQXnCMhq+f6xOuaQobfqARCj4nYElADV/qTdnSlrWOBcyrXA5oaFkZYlHXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318383; c=relaxed/simple;
	bh=dfQGBzZ6XKymq2twEmj/rEDnSSt8bNZP+tj0oW3zdzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1dwPQFx4b3UbavDettVjxH+Ke+926UmAPSCn4otl6Uo3YgEKht4dxWVAlih139Arfh/wcTMzVRFqFEiHFqalwrPcECPrzNqhlHo6Z6+9c+EYdM2xZf6Moq4tGCBhh5lntD4KFYcmfjnGRF5/bvUvFgTPGHeENzJ8+muBrJldhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f37yceHk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da223a28fb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/DJKjuvkBUkY0AdD/NuTscHxZi/ozZsiolcbJW1OhmE=;
	b=f37yceHk+2e0ZdfbgcTKdPIbgIeUX9Y6nNbBDS307I/CCZRa6CF4VmOffFcSaHHO9FGMZmEic2J5CAnZbUGoJVYCA7jQv140sk6ErwxxUqMmTNopugsm7ylI5vCECxUgi9CezPOsXKWAKkPJn+wpB+vuSyWknLIXHVznbp765JQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a6077f7c-4658-48df-af77-8e54c0657efb,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:90e307c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: da223a28fb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 879138105; Fri, 07 Mar 2025 11:32:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:51 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:50 +0800
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
Subject: [PATCH 19/26] clk: mediatek: Add MT8196 disp1 clock support
Date: Fri, 7 Mar 2025 11:27:15 +0800
Message-ID: <20250307032942.10447-20-guangjie.song@mediatek.com>
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

Add MT8196 disp1 clock controller which provides clock gate control in
display system. This is integrated with mtk-mmsys driver which will
populate device by platform_device_register_data to start disp1 clock
driver.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Makefile           |   2 +-
 drivers/clk/mediatek/clk-mt8196-disp1.c | 260 ++++++++++++++++++++++++
 2 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp1.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 881061f1e259..7eb4af39029c 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -158,7 +158,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
-obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-disp1.c b/drivers/clk/mediatek/clk-mt8196-disp1.c
new file mode 100644
index 000000000000..5acc589812be
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-disp1.c
@@ -0,0 +1,260 @@
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
+static const struct mtk_gate_regs mm10_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm10_vote_regs = {
+	.set_ofs = 0x0010,
+	.clr_ofs = 0x0014,
+	.sta_ofs = 0x2c08,
+};
+
+static const struct mtk_gate_regs mm11_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs mm11_vote_regs = {
+	.set_ofs = 0x0018,
+	.clr_ofs = 0x001c,
+	.sta_ofs = 0x2c0c,
+};
+
+#define GATE_MM10(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mm10_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_MM10_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_MM10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &mm10_cg_regs,			\
+		.vote_regs = &mm10_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote,		\
+		.dma_ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_MM11(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mm11_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_MM11_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_MM11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &mm11_cg_regs,			\
+		.vote_regs = &mm11_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote,		\
+		.dma_ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mm1_clks[] = {
+	/* MM10 */
+	GATE_VOTE_MM10(CLK_MM1_DISPSYS1_CONFIG, "mm1_dispsys1_config", "ck2_disp_ck", 0),
+	GATE_MM10_V(CLK_MM1_DISPSYS1_CONFIG_DISP, "mm1_dispsys1_config_disp",
+		    "mm1_dispsys1_config"),
+	GATE_VOTE_MM10(CLK_MM1_DISPSYS1_S_CONFIG, "mm1_dispsys1_s_config", "ck2_disp_ck", 1),
+	GATE_MM10_V(CLK_MM1_DISPSYS1_S_CONFIG_DISP, "mm1_dispsys1_s_config_disp",
+		    "mm1_dispsys1_s_config"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_MUTEX0, "mm1_disp_mutex0", "ck2_disp_ck", 2),
+	GATE_MM10_V(CLK_MM1_DISP_MUTEX0_DISP, "mm1_disp_mutex0_disp", "mm1_disp_mutex0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC20, "mm1_disp_dli_async20", "ck2_disp_ck", 3),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC20_DISP, "mm1_disp_dli_async20_disp",
+		    "mm1_disp_dli_async20"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC21, "mm1_disp_dli_async21", "ck2_disp_ck", 4),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC21_DISP, "mm1_disp_dli_async21_disp",
+		    "mm1_disp_dli_async21"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC22, "mm1_disp_dli_async22", "ck2_disp_ck", 5),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC22_DISP, "mm1_disp_dli_async22_disp",
+		    "mm1_disp_dli_async22"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC23, "mm1_disp_dli_async23", "ck2_disp_ck", 6),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC23_DISP, "mm1_disp_dli_async23_disp",
+		    "mm1_disp_dli_async23"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC24, "mm1_disp_dli_async24", "ck2_disp_ck", 7),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC24_DISP, "mm1_disp_dli_async24_disp",
+		    "mm1_disp_dli_async24"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC25, "mm1_disp_dli_async25", "ck2_disp_ck", 8),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC25_DISP, "mm1_disp_dli_async25_disp",
+		    "mm1_disp_dli_async25"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC26, "mm1_disp_dli_async26", "ck2_disp_ck", 9),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC26_DISP, "mm1_disp_dli_async26_disp",
+		    "mm1_disp_dli_async26"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC27, "mm1_disp_dli_async27", "ck2_disp_ck", 10),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC27_DISP, "mm1_disp_dli_async27_disp",
+		    "mm1_disp_dli_async27"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DLI_ASYNC28, "mm1_disp_dli_async28", "ck2_disp_ck", 11),
+	GATE_MM10_V(CLK_MM1_DISP_DLI_ASYNC28_DISP, "mm1_disp_dli_async28_disp",
+		    "mm1_disp_dli_async28"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_RELAY0, "mm1_disp_relay0", "ck2_disp_ck", 12),
+	GATE_MM10_V(CLK_MM1_DISP_RELAY0_DISP, "mm1_disp_relay0_disp", "mm1_disp_relay0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_RELAY1, "mm1_disp_relay1", "ck2_disp_ck", 13),
+	GATE_MM10_V(CLK_MM1_DISP_RELAY1_DISP, "mm1_disp_relay1_disp", "mm1_disp_relay1"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_RELAY2, "mm1_disp_relay2", "ck2_disp_ck", 14),
+	GATE_MM10_V(CLK_MM1_DISP_RELAY2_DISP, "mm1_disp_relay2_disp", "mm1_disp_relay2"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_RELAY3, "mm1_disp_relay3", "ck2_disp_ck", 15),
+	GATE_MM10_V(CLK_MM1_DISP_RELAY3_DISP, "mm1_disp_relay3_disp", "mm1_disp_relay3"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DP_INTF0, "mm1_DP_CLK", "ck2_disp_ck", 16),
+	GATE_MM10_V(CLK_MM1_DISP_DP_INTF0_DISP, "mm1_dp_clk_disp", "mm1_DP_CLK"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DP_INTF1, "mm1_disp_dp_intf1", "ck2_disp_ck", 17),
+	GATE_MM10_V(CLK_MM1_DISP_DP_INTF1_DISP, "mm1_disp_dp_intf1_disp", "mm1_disp_dp_intf1"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSC_WRAP0, "mm1_disp_dsc_wrap0", "ck2_disp_ck", 18),
+	GATE_MM10_V(CLK_MM1_DISP_DSC_WRAP0_DISP, "mm1_disp_dsc_wrap0_disp", "mm1_disp_dsc_wrap0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSC_WRAP1, "mm1_disp_dsc_wrap1", "ck2_disp_ck", 19),
+	GATE_MM10_V(CLK_MM1_DISP_DSC_WRAP1_DISP, "mm1_disp_dsc_wrap1_disp", "mm1_disp_dsc_wrap1"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSC_WRAP2, "mm1_disp_dsc_wrap2", "ck2_disp_ck", 20),
+	GATE_MM10_V(CLK_MM1_DISP_DSC_WRAP2_DISP, "mm1_disp_dsc_wrap2_disp", "mm1_disp_dsc_wrap2"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSC_WRAP3, "mm1_disp_dsc_wrap3", "ck2_disp_ck", 21),
+	GATE_MM10_V(CLK_MM1_DISP_DSC_WRAP3_DISP, "mm1_disp_dsc_wrap3_disp", "mm1_disp_dsc_wrap3"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSI0, "mm1_CLK0", "ck2_disp_ck", 22),
+	GATE_MM10_V(CLK_MM1_DISP_DSI0_DISP, "mm1_clk0_disp", "mm1_CLK0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSI1, "mm1_CLK1", "ck2_disp_ck", 23),
+	GATE_MM10_V(CLK_MM1_DISP_DSI1_DISP, "mm1_clk1_disp", "mm1_CLK1"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DSI2, "mm1_CLK2", "ck2_disp_ck", 24),
+	GATE_MM10_V(CLK_MM1_DISP_DSI2_DISP, "mm1_clk2_disp", "mm1_CLK2"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_DVO0, "mm1_disp_dvo0", "ck2_disp_ck", 25),
+	GATE_MM10_V(CLK_MM1_DISP_DVO0_DISP, "mm1_disp_dvo0_disp", "mm1_disp_dvo0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_GDMA0, "mm1_disp_gdma0", "ck2_disp_ck", 26),
+	GATE_MM10_V(CLK_MM1_DISP_GDMA0_DISP, "mm1_disp_gdma0_disp", "mm1_disp_gdma0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_MERGE0, "mm1_disp_merge0", "ck2_disp_ck", 27),
+	GATE_MM10_V(CLK_MM1_DISP_MERGE0_DISP, "mm1_disp_merge0_disp", "mm1_disp_merge0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_MERGE1, "mm1_disp_merge1", "ck2_disp_ck", 28),
+	GATE_MM10_V(CLK_MM1_DISP_MERGE1_DISP, "mm1_disp_merge1_disp", "mm1_disp_merge1"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_MERGE2, "mm1_disp_merge2", "ck2_disp_ck", 29),
+	GATE_MM10_V(CLK_MM1_DISP_MERGE2_DISP, "mm1_disp_merge2_disp", "mm1_disp_merge2"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_ODDMR0, "mm1_disp_oddmr0", "ck2_disp_ck", 30),
+	GATE_MM10_V(CLK_MM1_DISP_ODDMR0_PQ, "mm1_disp_oddmr0_pq", "mm1_disp_oddmr0"),
+	GATE_VOTE_MM10(CLK_MM1_DISP_POSTALIGN0, "mm1_disp_postalign0", "ck2_disp_ck", 31),
+	GATE_MM10_V(CLK_MM1_DISP_POSTALIGN0_PQ, "mm1_disp_postalign0_pq", "mm1_disp_postalign0"),
+	/* MM11 */
+	GATE_VOTE_MM11(CLK_MM1_DISP_DITHER2, "mm1_disp_dither2", "ck2_disp_ck", 0),
+	GATE_MM11_V(CLK_MM1_DISP_DITHER2_PQ, "mm1_disp_dither2_pq", "mm1_disp_dither2"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_R2Y0, "mm1_disp_r2y0", "ck2_disp_ck", 1),
+	GATE_MM11_V(CLK_MM1_DISP_R2Y0_DISP, "mm1_disp_r2y0_disp", "mm1_disp_r2y0"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_SPLITTER0, "mm1_disp_splitter0", "ck2_disp_ck", 2),
+	GATE_MM11_V(CLK_MM1_DISP_SPLITTER0_DISP, "mm1_disp_splitter0_disp", "mm1_disp_splitter0"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_SPLITTER1, "mm1_disp_splitter1", "ck2_disp_ck", 3),
+	GATE_MM11_V(CLK_MM1_DISP_SPLITTER1_DISP, "mm1_disp_splitter1_disp", "mm1_disp_splitter1"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_SPLITTER2, "mm1_disp_splitter2", "ck2_disp_ck", 4),
+	GATE_MM11_V(CLK_MM1_DISP_SPLITTER2_DISP, "mm1_disp_splitter2_disp", "mm1_disp_splitter2"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_SPLITTER3, "mm1_disp_splitter3", "ck2_disp_ck", 5),
+	GATE_MM11_V(CLK_MM1_DISP_SPLITTER3_DISP, "mm1_disp_splitter3_disp", "mm1_disp_splitter3"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_VDCM0, "mm1_disp_vdcm0", "ck2_disp_ck", 6),
+	GATE_MM11_V(CLK_MM1_DISP_VDCM0_DISP, "mm1_disp_vdcm0_disp", "mm1_disp_vdcm0"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_WDMA1, "mm1_disp_wdma1", "ck2_disp_ck", 7),
+	GATE_MM11_V(CLK_MM1_DISP_WDMA1_DISP, "mm1_disp_wdma1_disp", "mm1_disp_wdma1"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_WDMA2, "mm1_disp_wdma2", "ck2_disp_ck", 8),
+	GATE_MM11_V(CLK_MM1_DISP_WDMA2_DISP, "mm1_disp_wdma2_disp", "mm1_disp_wdma2"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_WDMA3, "mm1_disp_wdma3", "ck2_disp_ck", 9),
+	GATE_MM11_V(CLK_MM1_DISP_WDMA3_DISP, "mm1_disp_wdma3_disp", "mm1_disp_wdma3"),
+	GATE_VOTE_MM11(CLK_MM1_DISP_WDMA4, "mm1_disp_wdma4", "ck2_disp_ck", 10),
+	GATE_MM11_V(CLK_MM1_DISP_WDMA4_DISP, "mm1_disp_wdma4_disp", "mm1_disp_wdma4"),
+	GATE_VOTE_MM11(CLK_MM1_MDP_RDMA1, "mm1_mdp_rdma1", "ck2_disp_ck", 11),
+	GATE_MM11_V(CLK_MM1_MDP_RDMA1_DISP, "mm1_mdp_rdma1_disp", "mm1_mdp_rdma1"),
+	GATE_VOTE_MM11(CLK_MM1_SMI_LARB0, "mm1_smi_larb0", "ck2_disp_ck", 12),
+	GATE_MM11_V(CLK_MM1_SMI_LARB0_SMI, "mm1_smi_larb0_smi", "mm1_smi_larb0"),
+	GATE_VOTE_MM11(CLK_MM1_MOD1, "mm1_mod1", "ck_f26m_ck", 13),
+	GATE_MM11_V(CLK_MM1_MOD1_DISP, "mm1_mod1_disp", "mm1_mod1"),
+	GATE_VOTE_MM11(CLK_MM1_MOD2, "mm1_mod2", "ck_f26m_ck", 14),
+	GATE_MM11_V(CLK_MM1_MOD2_DISP, "mm1_mod2_disp", "mm1_mod2"),
+	GATE_VOTE_MM11(CLK_MM1_MOD3, "mm1_mod3", "ck_f26m_ck", 15),
+	GATE_MM11_V(CLK_MM1_MOD3_DISP, "mm1_mod3_disp", "mm1_mod3"),
+	GATE_VOTE_MM11(CLK_MM1_MOD4, "mm1_mod4", "ck2_dp0_ck", 16),
+	GATE_MM11_V(CLK_MM1_MOD4_DISP, "mm1_mod4_disp", "mm1_mod4"),
+	GATE_VOTE_MM11(CLK_MM1_MOD5, "mm1_mod5", "ck2_dp1_ck", 17),
+	GATE_MM11_V(CLK_MM1_MOD5_DISP, "mm1_mod5_disp", "mm1_mod5"),
+	GATE_VOTE_MM11(CLK_MM1_MOD6, "mm1_mod6", "ck2_dp1_ck", 18),
+	GATE_MM11_V(CLK_MM1_MOD6_DISP, "mm1_mod6_disp", "mm1_mod6"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG0, "mm1_cg0", "ck2_disp_ck", 20),
+	GATE_MM11_V(CLK_MM1_CK_CG0_DISP, "mm1_cg0_disp", "mm1_cg0"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG1, "mm1_cg1", "ck2_disp_ck", 21),
+	GATE_MM11_V(CLK_MM1_CK_CG1_DISP, "mm1_cg1_disp", "mm1_cg1"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG2, "mm1_cg2", "ck2_disp_ck", 22),
+	GATE_MM11_V(CLK_MM1_CK_CG2_DISP, "mm1_cg2_disp", "mm1_cg2"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG3, "mm1_cg3", "ck2_disp_ck", 23),
+	GATE_MM11_V(CLK_MM1_CK_CG3_DISP, "mm1_cg3_disp", "mm1_cg3"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG4, "mm1_cg4", "ck2_disp_ck", 24),
+	GATE_MM11_V(CLK_MM1_CK_CG4_DISP, "mm1_cg4_disp", "mm1_cg4"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG5, "mm1_cg5", "ck2_disp_ck", 25),
+	GATE_MM11_V(CLK_MM1_CK_CG5_DISP, "mm1_cg5_disp", "mm1_cg5"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG6, "mm1_cg6", "ck2_disp_ck", 26),
+	GATE_MM11_V(CLK_MM1_CK_CG6_DISP, "mm1_cg6_disp", "mm1_cg6"),
+	GATE_VOTE_MM11(CLK_MM1_CK_CG7, "mm1_cg7", "ck2_disp_ck", 27),
+	GATE_MM11_V(CLK_MM1_CK_CG7_DISP, "mm1_cg7_disp", "mm1_cg7"),
+	GATE_VOTE_MM11(CLK_MM1_F26M, "mm1_f26m_ck", "ck_f26m_ck", 28),
+	GATE_MM11_V(CLK_MM1_F26M_DISP, "mm1_f26m_ck_disp", "mm1_f26m_ck"),
+};
+
+static const struct mtk_clk_desc mm1_mcd = {
+	.clks = mm1_clks,
+	.num_clks = ARRAY_SIZE(mm1_clks),
+};
+
+static const struct platform_device_id clk_mt8196_disp1_id_table[] = {
+	{ .name = "clk-mt8196-disp1", .driver_data = (kernel_ulong_t)&mm1_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt8196_disp1_id_table);
+
+static struct platform_driver clk_mt8196_disp1_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-disp1",
+	},
+	.id_table = clk_mt8196_disp1_id_table,
+};
+
+module_platform_driver(clk_mt8196_disp1_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


