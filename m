Return-Path: <netdev+bounces-172772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C265DA55E98
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1631816188E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967020C476;
	Fri,  7 Mar 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TzBThiMe"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0611624D2;
	Fri,  7 Mar 2025 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318384; cv=none; b=FbCcgnbUI3WnDhDxF4D3n9VsfU0f6v9HHBFAWsk3SbN51wVxNeBxyKQ294gxsHhg+Jo2Gv56ci93ulHoL8xIy2MfEeaYM8PkXGn3I2dYwOdlf05aZBqOXxKuiJhMq1MrCL29Hp4Ay98CU+L2LhGMvElNyuLJA/ZtvcubhnrGABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318384; c=relaxed/simple;
	bh=uJRHDByjeJKpcm1RRQDMtX5q5gQYySQJ21C9o9fUwbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPCuRiriaJwB4SeUEmRAFXcL+GZ6gG03QoLfgdiIpPXnYzdozxRuMogDf3J4nMJnJb21XVuzGnpnSHyW4yDeWCDPgoiS1Biwhfunob0wSHjAyM6IvrDUP6YdI8dJKqJqGCzK9tdG4MRPcCB/liKvRjUKXRjrFpVoZU5CVRlzH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TzBThiMe; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d87255c8fb0411efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JdUvuu1xXmReKTbsqxB1s759tm3UAfJE98e7X92kfc0=;
	b=TzBThiMeXdMgBHOgZd15228mdOca8BVnfbInxSshs2r97uwwzuiapGHG9t+TN6aWzvjfD+T54JuWfOPhWfWtvtSJLFl2CjmIw9ze9D3f/BFgSzaWtCvBnPtQT6CeSKJFxijaKkJdpG83LiCqvJh04tlH6lKna/2hQueESNm6slw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b7e90255-b0ef-426a-b4c3-a59276785165,IP:0,UR
	L:0,TC:0,Content:33,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:33
X-CID-META: VersionHash:0ef645f,CLOUDID:7d28cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d87255c8fb0411efaae1fd9735fae912-20250307
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1174859120; Fri, 07 Mar 2025 11:32:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:47 +0800
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
Subject: [PATCH 16/26] clk: mediatek: Add MT8196 mdpsys clock support
Date: Fri, 7 Mar 2025 11:27:12 +0800
Message-ID: <20250307032942.10447-17-guangjie.song@mediatek.com>
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

Add MT8196 mdpsys clock controller which provides clock gate control
for media display.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Kconfig             |   7 +
 drivers/clk/mediatek/Makefile            |   1 +
 drivers/clk/mediatek/clk-mt8196-mdpsys.c | 357 +++++++++++++++++++++++
 3 files changed, 365 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 4473feebae40..8763cc1480a3 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1031,6 +1031,13 @@ config COMMON_CLK_MT8196_MCUSYS
 	help
 	  This driver supports MediaTek MT8196 mcusys clocks.
 
+config COMMON_CLK_MT8196_MDPSYS
+	tristate "Clock driver for MediaTek MT8196 mdpsys"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 mdpsys clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 1f6717569609..dccc6d84941c 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-apmixedsys
 obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
+obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-mdpsys.c b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
new file mode 100644
index 000000000000..ef591efa9fec
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Guangjie Song <guangjie.song@mediatek.com>
+ */
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8196-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs mdp10_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mdp11_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs mdp12_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+#define GATE_MDP10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp10_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_MDP10_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_MDP11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp11_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_MDP11_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_MDP12(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp12_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_MDP12_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate mdp1_clks[] = {
+	/* MDP10 */
+	GATE_MDP10(CLK_MDP1_MDP_MUTEX0, "mdp1_mdp_mutex0", "ck2_mdp_ck", 0),
+	GATE_MDP10_V(CLK_MDP1_MDP_MUTEX0_MML, "mdp1_mdp_mutex0_mml", "mdp1_mdp_mutex0"),
+	GATE_MDP10(CLK_MDP1_SMI0, "mdp1_smi0", "ck2_mdp_ck", 1),
+	GATE_MDP10_V(CLK_MDP1_SMI0_SMI, "mdp1_smi0_smi", "mdp1_smi0"),
+	GATE_MDP10(CLK_MDP1_APB_BUS, "mdp1_apb_bus", "ck2_mdp_ck", 2),
+	GATE_MDP10_V(CLK_MDP1_APB_BUS_MML, "mdp1_apb_bus_mml", "mdp1_apb_bus"),
+	GATE_MDP10(CLK_MDP1_MDP_RDMA0, "mdp1_mdp_rdma0", "ck2_mdp_ck", 3),
+	GATE_MDP10_V(CLK_MDP1_MDP_RDMA0_MML, "mdp1_mdp_rdma0_mml", "mdp1_mdp_rdma0"),
+	GATE_MDP10(CLK_MDP1_MDP_RDMA1, "mdp1_mdp_rdma1", "ck2_mdp_ck", 4),
+	GATE_MDP10_V(CLK_MDP1_MDP_RDMA1_MML, "mdp1_mdp_rdma1_mml", "mdp1_mdp_rdma1"),
+	GATE_MDP10(CLK_MDP1_MDP_RDMA2, "mdp1_mdp_rdma2", "ck2_mdp_ck", 5),
+	GATE_MDP10_V(CLK_MDP1_MDP_RDMA2_MML, "mdp1_mdp_rdma2_mml", "mdp1_mdp_rdma2"),
+	GATE_MDP10(CLK_MDP1_MDP_BIRSZ0, "mdp1_mdp_birsz0", "ck2_mdp_ck", 6),
+	GATE_MDP10_V(CLK_MDP1_MDP_BIRSZ0_MML, "mdp1_mdp_birsz0_mml", "mdp1_mdp_birsz0"),
+	GATE_MDP10(CLK_MDP1_MDP_HDR0, "mdp1_mdp_hdr0", "ck2_mdp_ck", 7),
+	GATE_MDP10_V(CLK_MDP1_MDP_HDR0_MML, "mdp1_mdp_hdr0_mml", "mdp1_mdp_hdr0"),
+	GATE_MDP10(CLK_MDP1_MDP_AAL0, "mdp1_mdp_aal0", "ck2_mdp_ck", 8),
+	GATE_MDP10_V(CLK_MDP1_MDP_AAL0_MML, "mdp1_mdp_aal0_mml", "mdp1_mdp_aal0"),
+	GATE_MDP10(CLK_MDP1_MDP_RSZ0, "mdp1_mdp_rsz0", "ck2_mdp_ck", 9),
+	GATE_MDP10_V(CLK_MDP1_MDP_RSZ0_MML, "mdp1_mdp_rsz0_mml", "mdp1_mdp_rsz0"),
+	GATE_MDP10(CLK_MDP1_MDP_RSZ2, "mdp1_mdp_rsz2", "ck2_mdp_ck", 10),
+	GATE_MDP10_V(CLK_MDP1_MDP_RSZ2_MML, "mdp1_mdp_rsz2_mml", "mdp1_mdp_rsz2"),
+	GATE_MDP10(CLK_MDP1_MDP_TDSHP0, "mdp1_mdp_tdshp0", "ck2_mdp_ck", 11),
+	GATE_MDP10_V(CLK_MDP1_MDP_TDSHP0_MML, "mdp1_mdp_tdshp0_mml", "mdp1_mdp_tdshp0"),
+	GATE_MDP10(CLK_MDP1_MDP_COLOR0, "mdp1_mdp_color0", "ck2_mdp_ck", 12),
+	GATE_MDP10_V(CLK_MDP1_MDP_COLOR0_MML, "mdp1_mdp_color0_mml", "mdp1_mdp_color0"),
+	GATE_MDP10(CLK_MDP1_MDP_WROT0, "mdp1_mdp_wrot0", "ck2_mdp_ck", 13),
+	GATE_MDP10_V(CLK_MDP1_MDP_WROT0_MML, "mdp1_mdp_wrot0_mml", "mdp1_mdp_wrot0"),
+	GATE_MDP10(CLK_MDP1_MDP_WROT1, "mdp1_mdp_wrot1", "ck2_mdp_ck", 14),
+	GATE_MDP10_V(CLK_MDP1_MDP_WROT1_MML, "mdp1_mdp_wrot1_mml", "mdp1_mdp_wrot1"),
+	GATE_MDP10(CLK_MDP1_MDP_WROT2, "mdp1_mdp_wrot2", "ck2_mdp_ck", 15),
+	GATE_MDP10_V(CLK_MDP1_MDP_WROT2_MML, "mdp1_mdp_wrot2_mml", "mdp1_mdp_wrot2"),
+	GATE_MDP10(CLK_MDP1_MDP_FAKE_ENG0, "mdp1_mdp_fake_eng0", "ck2_mdp_ck", 16),
+	GATE_MDP10_V(CLK_MDP1_MDP_FAKE_ENG0_MML, "mdp1_mdp_fake_eng0_mml", "mdp1_mdp_fake_eng0"),
+	GATE_MDP10(CLK_MDP1_APB_DB, "mdp1_apb_db", "ck2_mdp_ck", 17),
+	GATE_MDP10_V(CLK_MDP1_APB_DB_MML, "mdp1_apb_db_mml", "mdp1_apb_db"),
+	GATE_MDP10(CLK_MDP1_MDP_DLI_ASYNC0, "mdp1_mdp_dli_async0", "ck2_mdp_ck", 18),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLI_ASYNC0_MML, "mdp1_mdp_dli_async0_mml", "mdp1_mdp_dli_async0"),
+	GATE_MDP10(CLK_MDP1_MDP_DLI_ASYNC1, "mdp1_mdp_dli_async1", "ck2_mdp_ck", 19),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLI_ASYNC1_MML, "mdp1_mdp_dli_async1_mml", "mdp1_mdp_dli_async1"),
+	GATE_MDP10(CLK_MDP1_MDP_DLO_ASYNC0, "mdp1_mdp_dlo_async0", "ck2_mdp_ck", 20),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLO_ASYNC0_MML, "mdp1_mdp_dlo_async0_mml", "mdp1_mdp_dlo_async0"),
+	GATE_MDP10(CLK_MDP1_MDP_DLO_ASYNC1, "mdp1_mdp_dlo_async1", "ck2_mdp_ck", 21),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLO_ASYNC1_MML, "mdp1_mdp_dlo_async1_mml", "mdp1_mdp_dlo_async1"),
+	GATE_MDP10(CLK_MDP1_MDP_DLI_ASYNC2, "mdp1_mdp_dli_async2", "ck2_mdp_ck", 22),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLI_ASYNC2_MML, "mdp1_mdp_dli_async2_mml", "mdp1_mdp_dli_async2"),
+	GATE_MDP10(CLK_MDP1_MDP_DLO_ASYNC2, "mdp1_mdp_dlo_async2", "ck2_mdp_ck", 23),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLO_ASYNC2_MML, "mdp1_mdp_dlo_async2_mml", "mdp1_mdp_dlo_async2"),
+	GATE_MDP10(CLK_MDP1_MDP_DLO_ASYNC3, "mdp1_mdp_dlo_async3", "ck2_mdp_ck", 24),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLO_ASYNC3_MML, "mdp1_mdp_dlo_async3_mml", "mdp1_mdp_dlo_async3"),
+	GATE_MDP10(CLK_MDP1_IMG_DL_ASYNC0, "mdp1_img_dl_async0", "ck2_mdp_ck", 25),
+	GATE_MDP10_V(CLK_MDP1_IMG_DL_ASYNC0_MML, "mdp1_img_dl_async0_mml", "mdp1_img_dl_async0"),
+	GATE_MDP10(CLK_MDP1_MDP_RROT0, "mdp1_mdp_rrot0", "ck2_mdp_ck", 26),
+	GATE_MDP10_V(CLK_MDP1_MDP_RROT0_MML, "mdp1_mdp_rrot0_mml", "mdp1_mdp_rrot0"),
+	GATE_MDP10(CLK_MDP1_MDP_MERGE0, "mdp1_mdp_merge0", "ck2_mdp_ck", 27),
+	GATE_MDP10_V(CLK_MDP1_MDP_MERGE0_MML, "mdp1_mdp_merge0_mml", "mdp1_mdp_merge0"),
+	GATE_MDP10(CLK_MDP1_MDP_C3D0, "mdp1_mdp_c3d0", "ck2_mdp_ck", 28),
+	GATE_MDP10_V(CLK_MDP1_MDP_C3D0_MML, "mdp1_mdp_c3d0_mml", "mdp1_mdp_c3d0"),
+	GATE_MDP10(CLK_MDP1_MDP_FG0, "mdp1_mdp_fg0", "ck2_mdp_ck", 29),
+	GATE_MDP10_V(CLK_MDP1_MDP_FG0_MML, "mdp1_mdp_fg0_mml", "mdp1_mdp_fg0"),
+	GATE_MDP10(CLK_MDP1_MDP_CLA2, "mdp1_mdp_cla2", "ck2_mdp_ck", 30),
+	GATE_MDP10_V(CLK_MDP1_MDP_CLA2_MML, "mdp1_mdp_cla2_mml", "mdp1_mdp_cla2"),
+	GATE_MDP10(CLK_MDP1_MDP_DLO_ASYNC4, "mdp1_mdp_dlo_async4", "ck2_mdp_ck", 31),
+	GATE_MDP10_V(CLK_MDP1_MDP_DLO_ASYNC4_MML, "mdp1_mdp_dlo_async4_mml", "mdp1_mdp_dlo_async4"),
+	/* MDP11 */
+	GATE_MDP11(CLK_MDP1_VPP_RSZ0, "mdp1_vpp_rsz0", "ck2_mdp_ck", 0),
+	GATE_MDP11_V(CLK_MDP1_VPP_RSZ0_MML, "mdp1_vpp_rsz0_mml", "mdp1_vpp_rsz0"),
+	GATE_MDP11(CLK_MDP1_VPP_RSZ1, "mdp1_vpp_rsz1", "ck2_mdp_ck", 1),
+	GATE_MDP11_V(CLK_MDP1_VPP_RSZ1_MML, "mdp1_vpp_rsz1_mml", "mdp1_vpp_rsz1"),
+	GATE_MDP11(CLK_MDP1_MDP_DLO_ASYNC5, "mdp1_mdp_dlo_async5", "ck2_mdp_ck", 2),
+	GATE_MDP11_V(CLK_MDP1_MDP_DLO_ASYNC5_MML, "mdp1_mdp_dlo_async5_mml", "mdp1_mdp_dlo_async5"),
+	GATE_MDP11(CLK_MDP1_IMG0, "mdp1_img0", "ck2_mdp_ck", 3),
+	GATE_MDP11_V(CLK_MDP1_IMG0_MML, "mdp1_img0_mml", "mdp1_img0"),
+	GATE_MDP11(CLK_MDP1_F26M, "mdp1_f26m", "ck_f26m_ck", 27),
+	GATE_MDP11_V(CLK_MDP1_F26M_MML, "mdp1_f26m_mml", "mdp1_f26m"),
+	/* MDP12 */
+	GATE_MDP12(CLK_MDP1_IMG_DL_RELAY0, "mdp1_img_dl_relay0", "ck2_mdp_ck", 0),
+	GATE_MDP12_V(CLK_MDP1_IMG_DL_RELAY0_MML, "mdp1_img_dl_relay0_mml", "mdp1_img_dl_relay0"),
+	GATE_MDP12(CLK_MDP1_IMG_DL_RELAY1, "mdp1_img_dl_relay1", "ck2_mdp_ck", 8),
+	GATE_MDP12_V(CLK_MDP1_IMG_DL_RELAY1_MML, "mdp1_img_dl_relay1_mml", "mdp1_img_dl_relay1"),
+};
+
+static const struct mtk_clk_desc mdp1_mcd = {
+	.clks = mdp1_clks,
+	.num_clks = ARRAY_SIZE(mdp1_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct mtk_gate_regs mdp0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mdp1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs mdp2_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+#define GATE_MDP0(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mdp0_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_MDP0_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_MDP1(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mdp1_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_MDP1_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_MDP2(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &mdp2_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_MDP2_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate mdp_clks[] = {
+	/* MDP0 */
+	GATE_MDP0(CLK_MDP_MDP_MUTEX0, "mdp_mdp_mutex0", "ck2_mdp_ck", 0),
+	GATE_MDP0_V(CLK_MDP_MDP_MUTEX0_MML, "mdp_mdp_mutex0_mml", "mdp_mdp_mutex0"),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "ck2_mdp_ck", 1),
+	GATE_MDP0_V(CLK_MDP_SMI0_MML, "mdp_smi0_mml", "mdp_smi0"),
+	GATE_MDP0_V(CLK_MDP_SMI0_SMI, "mdp_smi0_smi", "mdp_smi0"),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "ck2_mdp_ck", 2),
+	GATE_MDP0_V(CLK_MDP_APB_BUS_MML, "mdp_apb_bus_mml", "mdp_apb_bus"),
+	GATE_MDP0(CLK_MDP_MDP_RDMA0, "mdp_mdp_rdma0", "ck2_mdp_ck", 3),
+	GATE_MDP0_V(CLK_MDP_MDP_RDMA0_MML, "mdp_mdp_rdma0_mml", "mdp_mdp_rdma0"),
+	GATE_MDP0(CLK_MDP_MDP_RDMA1, "mdp_mdp_rdma1", "ck2_mdp_ck", 4),
+	GATE_MDP0_V(CLK_MDP_MDP_RDMA1_MML, "mdp_mdp_rdma1_mml", "mdp_mdp_rdma1"),
+	GATE_MDP0(CLK_MDP_MDP_RDMA2, "mdp_mdp_rdma2", "ck2_mdp_ck", 5),
+	GATE_MDP0_V(CLK_MDP_MDP_RDMA2_MML, "mdp_mdp_rdma2_mml", "mdp_mdp_rdma2"),
+	GATE_MDP0(CLK_MDP_MDP_BIRSZ0, "mdp_mdp_birsz0", "ck2_mdp_ck", 6),
+	GATE_MDP0_V(CLK_MDP_MDP_BIRSZ0_MML, "mdp_mdp_birsz0_mml", "mdp_mdp_birsz0"),
+	GATE_MDP0(CLK_MDP_MDP_HDR0, "mdp_mdp_hdr0", "ck2_mdp_ck", 7),
+	GATE_MDP0_V(CLK_MDP_MDP_HDR0_MML, "mdp_mdp_hdr0_mml", "mdp_mdp_hdr0"),
+	GATE_MDP0(CLK_MDP_MDP_AAL0, "mdp_mdp_aal0", "ck2_mdp_ck", 8),
+	GATE_MDP0_V(CLK_MDP_MDP_AAL0_MML, "mdp_mdp_aal0_mml", "mdp_mdp_aal0"),
+	GATE_MDP0(CLK_MDP_MDP_RSZ0, "mdp_mdp_rsz0", "ck2_mdp_ck", 9),
+	GATE_MDP0_V(CLK_MDP_MDP_RSZ0_MML, "mdp_mdp_rsz0_mml", "mdp_mdp_rsz0"),
+	GATE_MDP0(CLK_MDP_MDP_RSZ2, "mdp_mdp_rsz2", "ck2_mdp_ck", 10),
+	GATE_MDP0_V(CLK_MDP_MDP_RSZ2_MML, "mdp_mdp_rsz2_mml", "mdp_mdp_rsz2"),
+	GATE_MDP0(CLK_MDP_MDP_TDSHP0, "mdp_mdp_tdshp0", "ck2_mdp_ck", 11),
+	GATE_MDP0_V(CLK_MDP_MDP_TDSHP0_MML, "mdp_mdp_tdshp0_mml", "mdp_mdp_tdshp0"),
+	GATE_MDP0(CLK_MDP_MDP_COLOR0, "mdp_mdp_color0", "ck2_mdp_ck", 12),
+	GATE_MDP0_V(CLK_MDP_MDP_COLOR0_MML, "mdp_mdp_color0_mml", "mdp_mdp_color0"),
+	GATE_MDP0(CLK_MDP_MDP_WROT0, "mdp_mdp_wrot0", "ck2_mdp_ck", 13),
+	GATE_MDP0_V(CLK_MDP_MDP_WROT0_MML, "mdp_mdp_wrot0_mml", "mdp_mdp_wrot0"),
+	GATE_MDP0(CLK_MDP_MDP_WROT1, "mdp_mdp_wrot1", "ck2_mdp_ck", 14),
+	GATE_MDP0_V(CLK_MDP_MDP_WROT1_MML, "mdp_mdp_wrot1_mml", "mdp_mdp_wrot1"),
+	GATE_MDP0(CLK_MDP_MDP_WROT2, "mdp_mdp_wrot2", "ck2_mdp_ck", 15),
+	GATE_MDP0_V(CLK_MDP_MDP_WROT2_MML, "mdp_mdp_wrot2_mml", "mdp_mdp_wrot2"),
+	GATE_MDP0(CLK_MDP_MDP_FAKE_ENG0, "mdp_mdp_fake_eng0", "ck2_mdp_ck", 16),
+	GATE_MDP0_V(CLK_MDP_MDP_FAKE_ENG0_MML, "mdp_mdp_fake_eng0_mml", "mdp_mdp_fake_eng0"),
+	GATE_MDP0(CLK_MDP_APB_DB, "mdp_apb_db", "ck2_mdp_ck", 17),
+	GATE_MDP0_V(CLK_MDP_APB_DB_MML, "mdp_apb_db_mml", "mdp_apb_db"),
+	GATE_MDP0(CLK_MDP_MDP_DLI_ASYNC0, "mdp_mdp_dli_async0", "ck2_mdp_ck", 18),
+	GATE_MDP0_V(CLK_MDP_MDP_DLI_ASYNC0_MML, "mdp_mdp_dli_async0_mml", "mdp_mdp_dli_async0"),
+	GATE_MDP0(CLK_MDP_MDP_DLI_ASYNC1, "mdp_mdp_dli_async1", "ck2_mdp_ck", 19),
+	GATE_MDP0_V(CLK_MDP_MDP_DLI_ASYNC1_MML, "mdp_mdp_dli_async1_mml", "mdp_mdp_dli_async1"),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC0, "mdp_mdp_dlo_async0", "ck2_mdp_ck", 20),
+	GATE_MDP0_V(CLK_MDP_MDP_DLO_ASYNC0_MML, "mdp_mdp_dlo_async0_mml", "mdp_mdp_dlo_async0"),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC1, "mdp_mdp_dlo_async1", "ck2_mdp_ck", 21),
+	GATE_MDP0_V(CLK_MDP_MDP_DLO_ASYNC1_MML, "mdp_mdp_dlo_async1_mml", "mdp_mdp_dlo_async1"),
+	GATE_MDP0(CLK_MDP_MDP_DLI_ASYNC2, "mdp_mdp_dli_async2", "ck2_mdp_ck", 22),
+	GATE_MDP0_V(CLK_MDP_MDP_DLI_ASYNC2_MML, "mdp_mdp_dli_async2_mml", "mdp_mdp_dli_async2"),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC2, "mdp_mdp_dlo_async2", "ck2_mdp_ck", 23),
+	GATE_MDP0_V(CLK_MDP_MDP_DLO_ASYNC2_MML, "mdp_mdp_dlo_async2_mml", "mdp_mdp_dlo_async2"),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC3, "mdp_mdp_dlo_async3", "ck2_mdp_ck", 24),
+	GATE_MDP0_V(CLK_MDP_MDP_DLO_ASYNC3_MML, "mdp_mdp_dlo_async3_mml", "mdp_mdp_dlo_async3"),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC0, "mdp_img_dl_async0", "ck2_mdp_ck", 25),
+	GATE_MDP0_V(CLK_MDP_IMG_DL_ASYNC0_MML, "mdp_img_dl_async0_mml", "mdp_img_dl_async0"),
+	GATE_MDP0(CLK_MDP_MDP_RROT0, "mdp_mdp_rrot0", "ck2_mdp_ck", 26),
+	GATE_MDP0_V(CLK_MDP_MDP_RROT0_MML, "mdp_mdp_rrot0_mml", "mdp_mdp_rrot0"),
+	GATE_MDP0(CLK_MDP_MDP_MERGE0, "mdp_mdp_merge0", "ck2_mdp_ck", 27),
+	GATE_MDP0_V(CLK_MDP_MDP_MERGE0_MML, "mdp_mdp_merge0_mml", "mdp_mdp_merge0"),
+	GATE_MDP0(CLK_MDP_MDP_C3D0, "mdp_mdp_c3d0", "ck2_mdp_ck", 28),
+	GATE_MDP0_V(CLK_MDP_MDP_C3D0_MML, "mdp_mdp_c3d0_mml", "mdp_mdp_c3d0"),
+	GATE_MDP0(CLK_MDP_MDP_FG0, "mdp_mdp_fg0", "ck2_mdp_ck", 29),
+	GATE_MDP0_V(CLK_MDP_MDP_FG0_MML, "mdp_mdp_fg0_mml", "mdp_mdp_fg0"),
+	GATE_MDP0(CLK_MDP_MDP_CLA2, "mdp_mdp_cla2", "ck2_mdp_ck", 30),
+	GATE_MDP0_V(CLK_MDP_MDP_CLA2_MML, "mdp_mdp_cla2_mml", "mdp_mdp_cla2"),
+	GATE_MDP0(CLK_MDP_MDP_DLO_ASYNC4, "mdp_mdp_dlo_async4", "ck2_mdp_ck", 31),
+	GATE_MDP0_V(CLK_MDP_MDP_DLO_ASYNC4_MML, "mdp_mdp_dlo_async4_mml", "mdp_mdp_dlo_async4"),
+	/* MDP1 */
+	GATE_MDP1(CLK_MDP_VPP_RSZ0, "mdp_vpp_rsz0", "ck2_mdp_ck", 0),
+	GATE_MDP1_V(CLK_MDP_VPP_RSZ0_MML, "mdp_vpp_rsz0_mml", "mdp_vpp_rsz0"),
+	GATE_MDP1(CLK_MDP_VPP_RSZ1, "mdp_vpp_rsz1", "ck2_mdp_ck", 1),
+	GATE_MDP1_V(CLK_MDP_VPP_RSZ1_MML, "mdp_vpp_rsz1_mml", "mdp_vpp_rsz1"),
+	GATE_MDP1(CLK_MDP_MDP_DLO_ASYNC5, "mdp_mdp_dlo_async5", "ck2_mdp_ck", 2),
+	GATE_MDP1_V(CLK_MDP_MDP_DLO_ASYNC5_MML, "mdp_mdp_dlo_async5_mml", "mdp_mdp_dlo_async5"),
+	GATE_MDP1(CLK_MDP_IMG0, "mdp_img0", "ck2_mdp_ck", 3),
+	GATE_MDP1_V(CLK_MDP_IMG0_MML, "mdp_img0_mml", "mdp_img0"),
+	GATE_MDP1(CLK_MDP_F26M, "mdp_f26m", "ck_f26m_ck", 27),
+	GATE_MDP1_V(CLK_MDP_F26M_MML, "mdp_f26m_mml", "mdp_f26m"),
+	/* MDP2 */
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY0, "mdp_img_dl_relay0", "ck2_mdp_ck", 0),
+	GATE_MDP2_V(CLK_MDP_IMG_DL_RELAY0_MML, "mdp_img_dl_relay0_mml", "mdp_img_dl_relay0"),
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY1, "mdp_img_dl_relay1", "ck2_mdp_ck", 8),
+	GATE_MDP2_V(CLK_MDP_IMG_DL_RELAY1_MML, "mdp_img_dl_relay1_mml", "mdp_img_dl_relay1"),
+};
+
+static const struct mtk_clk_desc mdp_mcd = {
+	.clks = mdp_clks,
+	.num_clks = ARRAY_SIZE(mdp_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_mdpsys[] = {
+	{ .compatible = "mediatek,mt8196-mdpsys1", .data = &mdp1_mcd, },
+	{ .compatible = "mediatek,mt8196-mdpsys", .data = &mdp_mcd, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_mdpsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-mdpsys",
+		.of_match_table = of_match_clk_mt8196_mdpsys,
+	},
+};
+
+module_platform_driver(clk_mt8196_mdpsys_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


