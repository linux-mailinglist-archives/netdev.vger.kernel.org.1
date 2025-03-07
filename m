Return-Path: <netdev+bounces-172778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC201A55EAC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234C2167393
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA972144DB;
	Fri,  7 Mar 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JTfQ75PI"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4720C463;
	Fri,  7 Mar 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318389; cv=none; b=BHjZobDKh+FTpKT2ryGJCWGK9F2wVqWrTtBIttWQpytWXms7oSrlnBWl4ublcPOLRFbdO6Ez4p5kO5u1j81OBco2ex3hooyoJ/tgJgQuTvYAjblZRxPKdZK9MYCrrks5R4MsPjMrGzNhas4P1kIS1yGWjulfqm969OJcu/MgmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318389; c=relaxed/simple;
	bh=Rule1vr6gKjDc4lib6B9nNK0wSUe26QE5MqmCOsdsxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDKnswq37VnM23D4++maBLJCpfEjIQEsa/MLEq1xc/1gasllJQ/LJdPhMWVJRyei9QuFsiiOBgnff3GSEchZ0fWCfAIiNJ7RB0bhRHS/aPW+Bt/dffSfcTLa9+LVcxgnnibeqJ+/liyDJQFyTN73GOZQ9SYJ4AFnmIJtp/KSLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JTfQ75PI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dbcb6becfb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hZhckn9gyP4M2IPTSDwfQq5+G3auKeR0MAGY+Ye5TuI=;
	b=JTfQ75PIv0pxhgwHqzvAxMNICpV3jtwmc4NHrZZnnDySUYIYVfzhXcEduCE3FyKnAyldvfrKPSCK9JrHbMupUePD9bHkX+nNj4xJX1ZCw60BIa+jKU4nMz+inXgJYBoAwV5biVl59DZ+9hobjNdcpxJUcsSa/Mf7Uk5sczowkP8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6c95ab1a-e654-403d-b467-dd2dc984c838,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:bbe307c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dbcb6becfb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1759122767; Fri, 07 Mar 2025 11:32:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:53 +0800
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
Subject: [PATCH 22/26] clk: mediatek: Add MT8196 ovl1 clock support
Date: Fri, 7 Mar 2025 11:27:18 +0800
Message-ID: <20250307032942.10447-23-guangjie.song@mediatek.com>
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

Add MT8196 ovl1 clock controller which provides clock gate control in
display system. This is integrated with mtk-mmsys driver which will
populate device by platform_device_register_data to start ovl1 clock
driver.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-mt8196-ovl1.c | 255 +++++++++++++++++++++++++
 2 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl1.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6766811e67d9..472462cd8711 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -159,7 +159,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o clk-mt8196-vdisp_ao.o \
-					 clk-mt8196-ovl0.o
+					 clk-mt8196-ovl0.o clk-mt8196-ovl1.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-ovl1.c b/drivers/clk/mediatek/clk-mt8196-ovl1.c
new file mode 100644
index 000000000000..ca590be53199
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-ovl1.c
@@ -0,0 +1,255 @@
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
+static const struct mtk_gate_regs ovl10_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs ovl10_vote_regs = {
+	.set_ofs = 0x0050,
+	.clr_ofs = 0x0054,
+	.sta_ofs = 0x2c28,
+};
+
+static const struct mtk_gate_regs ovl11_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs ovl11_vote_regs = {
+	.set_ofs = 0x0058,
+	.clr_ofs = 0x005c,
+	.sta_ofs = 0x2c2c,
+};
+
+#define GATE_OVL10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ovl10_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_OVL10_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_OVL10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &ovl10_cg_regs,			\
+		.vote_regs = &ovl10_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote,		\
+		.dma_ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_OVL11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ovl11_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_OVL11_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_OVL11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &ovl11_cg_regs,			\
+		.vote_regs = &ovl11_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote,		\
+		.dma_ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ovl1_clks[] = {
+	/* OVL10 */
+	GATE_VOTE_OVL10(CLK_OVL1_OVLSYS_CONFIG, "ovl1_ovlsys_config", "ck2_disp_ck", 0),
+	GATE_OVL10_V(CLK_OVL1_OVLSYS_CONFIG_DISP, "ovl1_ovlsys_config_disp", "ovl1_ovlsys_config"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_FAKE_ENG0, "ovl1_ovl_fake_eng0", "ck2_disp_ck", 1),
+	GATE_OVL10_V(CLK_OVL1_OVL_FAKE_ENG0_DISP, "ovl1_ovl_fake_eng0_disp", "ovl1_ovl_fake_eng0"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_FAKE_ENG1, "ovl1_ovl_fake_eng1", "ck2_disp_ck", 2),
+	GATE_OVL10_V(CLK_OVL1_OVL_FAKE_ENG1_DISP, "ovl1_ovl_fake_eng1_disp", "ovl1_ovl_fake_eng1"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_MUTEX0, "ovl1_ovl_mutex0", "ck2_disp_ck", 3),
+	GATE_OVL10_V(CLK_OVL1_OVL_MUTEX0_DISP, "ovl1_ovl_mutex0_disp", "ovl1_ovl_mutex0"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA0, "ovl1_ovl_exdma0", "ck2_disp_ck", 4),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA0_DISP, "ovl1_ovl_exdma0_disp", "ovl1_ovl_exdma0"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA1, "ovl1_ovl_exdma1", "ck2_disp_ck", 5),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA1_DISP, "ovl1_ovl_exdma1_disp", "ovl1_ovl_exdma1"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA2, "ovl1_ovl_exdma2", "ck2_disp_ck", 6),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA2_DISP, "ovl1_ovl_exdma2_disp", "ovl1_ovl_exdma2"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA3, "ovl1_ovl_exdma3", "ck2_disp_ck", 7),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA3_DISP, "ovl1_ovl_exdma3_disp", "ovl1_ovl_exdma3"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA4, "ovl1_ovl_exdma4", "ck2_disp_ck", 8),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA4_DISP, "ovl1_ovl_exdma4_disp", "ovl1_ovl_exdma4"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA5, "ovl1_ovl_exdma5", "ck2_disp_ck", 9),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA5_DISP, "ovl1_ovl_exdma5_disp", "ovl1_ovl_exdma5"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA6, "ovl1_ovl_exdma6", "ck2_disp_ck", 10),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA6_DISP, "ovl1_ovl_exdma6_disp", "ovl1_ovl_exdma6"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA7, "ovl1_ovl_exdma7", "ck2_disp_ck", 11),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA7_DISP, "ovl1_ovl_exdma7_disp", "ovl1_ovl_exdma7"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA8, "ovl1_ovl_exdma8", "ck2_disp_ck", 12),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA8_DISP, "ovl1_ovl_exdma8_disp", "ovl1_ovl_exdma8"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_EXDMA9, "ovl1_ovl_exdma9", "ck2_disp_ck", 13),
+	GATE_OVL10_V(CLK_OVL1_OVL_EXDMA9_DISP, "ovl1_ovl_exdma9_disp", "ovl1_ovl_exdma9"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER0, "ovl1_ovl_blender0", "ck2_disp_ck", 14),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER0_DISP, "ovl1_ovl_blender0_disp", "ovl1_ovl_blender0"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER1, "ovl1_ovl_blender1", "ck2_disp_ck", 15),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER1_DISP, "ovl1_ovl_blender1_disp", "ovl1_ovl_blender1"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER2, "ovl1_ovl_blender2", "ck2_disp_ck", 16),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER2_DISP, "ovl1_ovl_blender2_disp", "ovl1_ovl_blender2"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER3, "ovl1_ovl_blender3", "ck2_disp_ck", 17),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER3_DISP, "ovl1_ovl_blender3_disp", "ovl1_ovl_blender3"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER4, "ovl1_ovl_blender4", "ck2_disp_ck", 18),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER4_DISP, "ovl1_ovl_blender4_disp", "ovl1_ovl_blender4"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER5, "ovl1_ovl_blender5", "ck2_disp_ck", 19),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER5_DISP, "ovl1_ovl_blender5_disp", "ovl1_ovl_blender5"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER6, "ovl1_ovl_blender6", "ck2_disp_ck", 20),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER6_DISP, "ovl1_ovl_blender6_disp", "ovl1_ovl_blender6"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER7, "ovl1_ovl_blender7", "ck2_disp_ck", 21),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER7_DISP, "ovl1_ovl_blender7_disp", "ovl1_ovl_blender7"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER8, "ovl1_ovl_blender8", "ck2_disp_ck", 22),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER8_DISP, "ovl1_ovl_blender8_disp", "ovl1_ovl_blender8"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_BLENDER9, "ovl1_ovl_blender9", "ck2_disp_ck", 23),
+	GATE_OVL10_V(CLK_OVL1_OVL_BLENDER9_DISP, "ovl1_ovl_blender9_disp", "ovl1_ovl_blender9"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_OUTPROC0, "ovl1_ovl_outproc0", "ck2_disp_ck", 24),
+	GATE_OVL10_V(CLK_OVL1_OVL_OUTPROC0_DISP, "ovl1_ovl_outproc0_disp", "ovl1_ovl_outproc0"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_OUTPROC1, "ovl1_ovl_outproc1", "ck2_disp_ck", 25),
+	GATE_OVL10_V(CLK_OVL1_OVL_OUTPROC1_DISP, "ovl1_ovl_outproc1_disp", "ovl1_ovl_outproc1"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_OUTPROC2, "ovl1_ovl_outproc2", "ck2_disp_ck", 26),
+	GATE_OVL10_V(CLK_OVL1_OVL_OUTPROC2_DISP, "ovl1_ovl_outproc2_disp", "ovl1_ovl_outproc2"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_OUTPROC3, "ovl1_ovl_outproc3", "ck2_disp_ck", 27),
+	GATE_OVL10_V(CLK_OVL1_OVL_OUTPROC3_DISP, "ovl1_ovl_outproc3_disp", "ovl1_ovl_outproc3"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_OUTPROC4, "ovl1_ovl_outproc4", "ck2_disp_ck", 28),
+	GATE_OVL10_V(CLK_OVL1_OVL_OUTPROC4_DISP, "ovl1_ovl_outproc4_disp", "ovl1_ovl_outproc4"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_OUTPROC5, "ovl1_ovl_outproc5", "ck2_disp_ck", 29),
+	GATE_OVL10_V(CLK_OVL1_OVL_OUTPROC5_DISP, "ovl1_ovl_outproc5_disp", "ovl1_ovl_outproc5"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_MDP_RSZ0, "ovl1_ovl_mdp_rsz0", "ck2_disp_ck", 30),
+	GATE_OVL10_V(CLK_OVL1_OVL_MDP_RSZ0_DISP, "ovl1_ovl_mdp_rsz0_disp", "ovl1_ovl_mdp_rsz0"),
+	GATE_VOTE_OVL10(CLK_OVL1_OVL_MDP_RSZ1, "ovl1_ovl_mdp_rsz1", "ck2_disp_ck", 31),
+	GATE_OVL10_V(CLK_OVL1_OVL_MDP_RSZ1_DISP, "ovl1_ovl_mdp_rsz1_disp", "ovl1_ovl_mdp_rsz1"),
+	/* OVL11 */
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_DISP_WDMA0, "ovl1_ovl_disp_wdma0", "ck2_disp_ck", 0),
+	GATE_OVL11_V(CLK_OVL1_OVL_DISP_WDMA0_DISP, "ovl1_ovl_disp_wdma0_disp", "ovl1_ovl_disp_wdma0"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_DISP_WDMA1, "ovl1_ovl_disp_wdma1", "ck2_disp_ck", 1),
+	GATE_OVL11_V(CLK_OVL1_OVL_DISP_WDMA1_DISP, "ovl1_ovl_disp_wdma1_disp", "ovl1_ovl_disp_wdma1"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_UFBC_WDMA0, "ovl1_ovl_ufbc_wdma0", "ck2_disp_ck", 2),
+	GATE_OVL11_V(CLK_OVL1_OVL_UFBC_WDMA0_DISP, "ovl1_ovl_ufbc_wdma0_disp", "ovl1_ovl_ufbc_wdma0"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_MDP_RDMA0, "ovl1_ovl_mdp_rdma0", "ck2_disp_ck", 3),
+	GATE_OVL11_V(CLK_OVL1_OVL_MDP_RDMA0_DISP, "ovl1_ovl_mdp_rdma0_disp", "ovl1_ovl_mdp_rdma0"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_MDP_RDMA1, "ovl1_ovl_mdp_rdma1", "ck2_disp_ck", 4),
+	GATE_OVL11_V(CLK_OVL1_OVL_MDP_RDMA1_DISP, "ovl1_ovl_mdp_rdma1_disp", "ovl1_ovl_mdp_rdma1"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_BWM0, "ovl1_ovl_bwm0", "ck2_disp_ck", 5),
+	GATE_OVL11_V(CLK_OVL1_OVL_BWM0_DISP, "ovl1_ovl_bwm0_disp", "ovl1_ovl_bwm0"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI0, "ovl1_dli0", "ck2_disp_ck", 6),
+	GATE_OVL11_V(CLK_OVL1_DLI0_DISP, "ovl1_dli0_disp", "ovl1_dli0"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI1, "ovl1_dli1", "ck2_disp_ck", 7),
+	GATE_OVL11_V(CLK_OVL1_DLI1_DISP, "ovl1_dli1_disp", "ovl1_dli1"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI2, "ovl1_dli2", "ck2_disp_ck", 8),
+	GATE_OVL11_V(CLK_OVL1_DLI2_DISP, "ovl1_dli2_disp", "ovl1_dli2"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI3, "ovl1_dli3", "ck2_disp_ck", 9),
+	GATE_OVL11_V(CLK_OVL1_DLI3_DISP, "ovl1_dli3_disp", "ovl1_dli3"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI4, "ovl1_dli4", "ck2_disp_ck", 10),
+	GATE_OVL11_V(CLK_OVL1_DLI4_DISP, "ovl1_dli4_disp", "ovl1_dli4"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI5, "ovl1_dli5", "ck2_disp_ck", 11),
+	GATE_OVL11_V(CLK_OVL1_DLI5_DISP, "ovl1_dli5_disp", "ovl1_dli5"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI6, "ovl1_dli6", "ck2_disp_ck", 12),
+	GATE_OVL11_V(CLK_OVL1_DLI6_DISP, "ovl1_dli6_disp", "ovl1_dli6"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI7, "ovl1_dli7", "ck2_disp_ck", 13),
+	GATE_OVL11_V(CLK_OVL1_DLI7_DISP, "ovl1_dli7_disp", "ovl1_dli7"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLI8, "ovl1_dli8", "ck2_disp_ck", 14),
+	GATE_OVL11_V(CLK_OVL1_DLI8_DISP, "ovl1_dli8_disp", "ovl1_dli8"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO0, "ovl1_dlo0", "ck2_disp_ck", 15),
+	GATE_OVL11_V(CLK_OVL1_DLO0_DISP, "ovl1_dlo0_disp", "ovl1_dlo0"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO1, "ovl1_dlo1", "ck2_disp_ck", 16),
+	GATE_OVL11_V(CLK_OVL1_DLO1_DISP, "ovl1_dlo1_disp", "ovl1_dlo1"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO2, "ovl1_dlo2", "ck2_disp_ck", 17),
+	GATE_OVL11_V(CLK_OVL1_DLO2_DISP, "ovl1_dlo2_disp", "ovl1_dlo2"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO3, "ovl1_dlo3", "ck2_disp_ck", 18),
+	GATE_OVL11_V(CLK_OVL1_DLO3_DISP, "ovl1_dlo3_disp", "ovl1_dlo3"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO4, "ovl1_dlo4", "ck2_disp_ck", 19),
+	GATE_OVL11_V(CLK_OVL1_DLO4_DISP, "ovl1_dlo4_disp", "ovl1_dlo4"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO5, "ovl1_dlo5", "ck2_disp_ck", 20),
+	GATE_OVL11_V(CLK_OVL1_DLO5_DISP, "ovl1_dlo5_disp", "ovl1_dlo5"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO6, "ovl1_dlo6", "ck2_disp_ck", 21),
+	GATE_OVL11_V(CLK_OVL1_DLO6_DISP, "ovl1_dlo6_disp", "ovl1_dlo6"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO7, "ovl1_dlo7", "ck2_disp_ck", 22),
+	GATE_OVL11_V(CLK_OVL1_DLO7_DISP, "ovl1_dlo7_disp", "ovl1_dlo7"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO8, "ovl1_dlo8", "ck2_disp_ck", 23),
+	GATE_OVL11_V(CLK_OVL1_DLO8_DISP, "ovl1_dlo8_disp", "ovl1_dlo8"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO9, "ovl1_dlo9", "ck2_disp_ck", 24),
+	GATE_OVL11_V(CLK_OVL1_DLO9_DISP, "ovl1_dlo9_disp", "ovl1_dlo9"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO10, "ovl1_dlo10", "ck2_disp_ck", 25),
+	GATE_OVL11_V(CLK_OVL1_DLO10_DISP, "ovl1_dlo10_disp", "ovl1_dlo10"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO11, "ovl1_dlo11", "ck2_disp_ck", 26),
+	GATE_OVL11_V(CLK_OVL1_DLO11_DISP, "ovl1_dlo11_disp", "ovl1_dlo11"),
+	GATE_VOTE_OVL11(CLK_OVL1_DLO12, "ovl1_dlo12", "ck2_disp_ck", 27),
+	GATE_OVL11_V(CLK_OVL1_DLO12_DISP, "ovl1_dlo12_disp", "ovl1_dlo12"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVLSYS_RELAY0, "ovl1_ovlsys_relay0", "ck2_disp_ck", 28),
+	GATE_OVL11_V(CLK_OVL1_OVLSYS_RELAY0_DISP, "ovl1_ovlsys_relay0_disp", "ovl1_ovlsys_relay0"),
+	GATE_VOTE_OVL11(CLK_OVL1_OVL_INLINEROT0, "ovl1_ovl_inlinerot0", "ck2_disp_ck", 29),
+	GATE_OVL11_V(CLK_OVL1_OVL_INLINEROT0_DISP, "ovl1_ovl_inlinerot0_disp", "ovl1_ovl_inlinerot0"),
+	GATE_VOTE_OVL11(CLK_OVL1_SMI, "ovl1_smi", "ck2_disp_ck", 30),
+	GATE_OVL11_V(CLK_OVL1_SMI_SMI, "ovl1_smi_smi", "ovl1_smi"),
+};
+
+static const struct mtk_clk_desc ovl1_mcd = {
+	.clks = ovl1_clks,
+	.num_clks = ARRAY_SIZE(ovl1_clks),
+};
+
+static const struct platform_device_id clk_mt8196_ovl1_id_table[] = {
+	{ .name = "clk-mt8196-ovl1", .driver_data = (kernel_ulong_t)&ovl1_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt8196_ovl1_id_table);
+
+static struct platform_driver clk_mt8196_ovl1_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt8196-ovl1",
+	},
+	.id_table = clk_mt8196_ovl1_id_table,
+};
+
+module_platform_driver(clk_mt8196_ovl1_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


