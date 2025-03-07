Return-Path: <netdev+bounces-172777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E299DA55EAB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1AB164FD6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470E213E87;
	Fri,  7 Mar 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="meS5ayjF"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC862063F1;
	Fri,  7 Mar 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318389; cv=none; b=AxaJjM0vvPRPS6zMFlLr9MKszO6Kw+YOhxT/MHIagwMI6MKf29NG3mpkUxgTyF4mPxXgGg0aV5w82kiKHkxQVlJOEUjuC16VqHi9XQf/E5VevQ2OyjbhLdxru7lo8O3LQp3a3RkbDO4dFiOuhB9/A9lNEq9z9ruWNhfFHdApqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318389; c=relaxed/simple;
	bh=KRCnTQmBonJEkNzLUfUJFySUqv3ttyrnsiyl4ixtcQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7m+Nz7S2GeF+EPF1vZdNRhv95uwZpzNsh6z1obU/n0CKk/iswwQPQOMTR8TYni6jrqGO5GVO0lDQq4zOPN1SYqvjsQoLlzutFSmNfoRt42tJbWA5bMRHkHrP6x2cHqOU9qxYb3mkmu/ekPpLAQrl+nTt9Hfk0mz7RmXoIOCSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=meS5ayjF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dd8782aefb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7huaaaZ4g40mOCnYbg9wrCZiMZ/ymR6uC6Aj1TFRpaM=;
	b=meS5ayjF6CCyTIYjpafuSvK6MuMQNuy6CVxZnGaxHENFoyEMc4QHr5OEyU5KGy4iAmQx4ybfxxAZcjc5P73H44xJ5xRp0dKm7kqm/sipqPJd9YXtkNZbpxE4oppXIxU602lAGwXA4K65L7E8qvhvsY+6IN7QwqI4zqbBbUgfw48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:36740ae2-a75f-4580-9e5c-5ebd033faff7,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:1c6f108c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dd8782aefb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1946614336; Fri, 07 Mar 2025 11:32:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:57 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:56 +0800
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
Subject: [PATCH 25/26] clk: mediatek: Add MT8196 vdecsys clock support
Date: Fri, 7 Mar 2025 11:27:21 +0800
Message-ID: <20250307032942.10447-26-guangjie.song@mediatek.com>
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

Add MT8196 vdecsys clock controller which provides clock gate control
for video decoder.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Kconfig           |   7 +
 drivers/clk/mediatek/Makefile          |   1 +
 drivers/clk/mediatek/clk-mt8196-vdec.c | 449 +++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdec.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5fc24f52762a..0c508a8a9959 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1066,6 +1066,13 @@ config COMMON_CLK_MT8196_UFSSYS
 	help
 	  This driver supports MediaTek MT8196 ufssys clocks.
 
+config COMMON_CLK_MT8196_VDECSYS
+	tristate "Clock driver for MediaTek MT8196 vdecsys"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 vdecsys clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e5b4a3a61ef7..b8bf3f5f8530 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -162,6 +162,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o c
 					 clk-mt8196-ovl0.o clk-mt8196-ovl1.o
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_VDECSYS) += clk-mt8196-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-vdec.c b/drivers/clk/mediatek/clk-mt8196-vdec.c
new file mode 100644
index 000000000000..52accb5b4fb8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-vdec.c
@@ -0,0 +1,449 @@
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
+static const struct mtk_gate_regs vde20_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vde20_vote_regs = {
+	.set_ofs = 0x0088,
+	.clr_ofs = 0x008c,
+	.sta_ofs = 0x2c44,
+};
+
+static const struct mtk_gate_regs vde21_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vde21_vote_regs = {
+	.set_ofs = 0x0080,
+	.clr_ofs = 0x0084,
+	.sta_ofs = 0x2c40,
+};
+
+static const struct mtk_gate_regs vde22_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+static const struct mtk_gate_regs vde22_vote_regs = {
+	.set_ofs = 0x0078,
+	.clr_ofs = 0x007c,
+	.sta_ofs = 0x2c3c,
+};
+
+#define GATE_VDE20(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde20_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE20_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE20(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &vde20_cg_regs,			\
+		.vote_regs = &vde20_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote_inv,	\
+		.dma_ops = &mtk_clk_gate_ops_setclr_inv,\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_VDE21(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde21_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE21_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE21(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &vde21_cg_regs,			\
+		.vote_regs = &vde21_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote_inv,	\
+		.dma_ops = &mtk_clk_gate_ops_setclr_inv,\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_VDE22(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde22_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE22_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE22(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &vde22_cg_regs,			\
+		.vote_regs = &vde22_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote_inv,	\
+		.dma_ops = &mtk_clk_gate_ops_setclr_inv,\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+	}
+
+static const struct mtk_gate vde2_clks[] = {
+	/* VDE20 */
+	GATE_VOTE_VDE20(CLK_VDE2_VDEC_CKEN, "vde2_vdec_cken", "ck2_vdec_ck", 0),
+	GATE_VDE20_V(CLK_VDE2_VDEC_CKEN_VDEC, "vde2_vdec_cken_vdec", "vde2_vdec_cken"),
+	GATE_VOTE_VDE20(CLK_VDE2_VDEC_ACTIVE, "vde2_vdec_active", "ck2_vdec_ck", 4),
+	GATE_VDE20_V(CLK_VDE2_VDEC_ACTIVE_VDEC, "vde2_vdec_active_vdec", "vde2_vdec_active"),
+	GATE_VOTE_VDE20(CLK_VDE2_VDEC_CKEN_ENG, "vde2_vdec_cken_eng", "ck2_vdec_ck", 8),
+	GATE_VDE20_V(CLK_VDE2_VDEC_CKEN_ENG_VDEC, "vde2_vdec_cken_eng_vdec", "vde2_vdec_cken_eng"),
+	/* VDE21 */
+	GATE_VOTE_VDE21(CLK_VDE2_LAT_CKEN, "vde2_lat_cken", "ck2_vdec_ck", 0),
+	GATE_VDE21_V(CLK_VDE2_LAT_CKEN_VDEC, "vde2_lat_cken_vdec", "vde2_lat_cken"),
+	GATE_VOTE_VDE21(CLK_VDE2_LAT_ACTIVE, "vde2_lat_active", "ck2_vdec_ck", 4),
+	GATE_VDE21_V(CLK_VDE2_LAT_ACTIVE_VDEC, "vde2_lat_active_vdec", "vde2_lat_active"),
+	GATE_VOTE_VDE21(CLK_VDE2_LAT_CKEN_ENG, "vde2_lat_cken_eng", "ck2_vdec_ck", 8),
+	GATE_VDE21_V(CLK_VDE2_LAT_CKEN_ENG_VDEC, "vde2_lat_cken_eng_vdec", "vde2_lat_cken_eng"),
+	/* VDE22 */
+	GATE_VOTE_VDE22(CLK_VDE2_LARB1_CKEN, "vde2_larb1_cken", "ck2_vdec_ck", 0),
+	GATE_VDE22_V(CLK_VDE2_LARB1_CKEN_VDEC, "vde2_larb1_cken_vdec", "vde2_larb1_cken"),
+	GATE_VDE22_V(CLK_VDE2_LARB1_CKEN_SMI, "vde2_larb1_cken_smi", "vde2_larb1_cken"),
+};
+
+static const struct mtk_clk_desc vde2_mcd = {
+	.clks = vde2_clks,
+	.num_clks = ARRAY_SIZE(vde2_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct mtk_gate_regs vde10_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vde10_vote_regs = {
+	.set_ofs = 0x00a0,
+	.clr_ofs = 0x00a4,
+	.sta_ofs = 0x2c50,
+};
+
+static const struct mtk_gate_regs vde11_cg_regs = {
+	.set_ofs = 0x1e0,
+	.clr_ofs = 0x1e0,
+	.sta_ofs = 0x1e0,
+};
+
+static const struct mtk_gate_regs vde11_vote_regs = {
+	.set_ofs = 0x00b0,
+	.clr_ofs = 0x00b4,
+	.sta_ofs = 0x2c58,
+};
+
+static const struct mtk_gate_regs vde12_cg_regs = {
+	.set_ofs = 0x1ec,
+	.clr_ofs = 0x1ec,
+	.sta_ofs = 0x1ec,
+};
+
+static const struct mtk_gate_regs vde12_vote_regs = {
+	.set_ofs = 0x00a8,
+	.clr_ofs = 0x00ac,
+	.sta_ofs = 0x2c54,
+};
+
+static const struct mtk_gate_regs vde13_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vde13_vote_regs = {
+	.set_ofs = 0x0098,
+	.clr_ofs = 0x009c,
+	.sta_ofs = 0x2c4c,
+};
+
+static const struct mtk_gate_regs vde14_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+static const struct mtk_gate_regs vde14_vote_regs = {
+	.set_ofs = 0x0090,
+	.clr_ofs = 0x0094,
+	.sta_ofs = 0x2c48,
+};
+
+#define GATE_VDE10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde10_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE10_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &vde10_cg_regs,			\
+		.vote_regs = &vde10_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote_inv,	\
+		.dma_ops = &mtk_clk_gate_ops_setclr_inv,\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_VDE11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde11_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE		\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_VDE11_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE11(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.vote_comp = "mm-vote-regmap",			\
+		.regs = &vde11_cg_regs,				\
+		.vote_regs = &vde11_vote_regs,			\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_vote_inv,		\
+		.dma_ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+		.flags = CLK_USE_VOTE |				\
+			 CLK_OPS_PARENT_ENABLE,			\
+	}
+
+#define GATE_VDE12(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde12_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_VDE12_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE12(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.vote_comp = "mm-vote-regmap",			\
+		.regs = &vde12_cg_regs,				\
+		.vote_regs = &vde12_vote_regs,			\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_vote_inv,		\
+		.dma_ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+		.flags = CLK_USE_VOTE |				\
+			 CLK_OPS_PARENT_ENABLE			\
+	}
+
+#define GATE_VDE13(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde13_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE13_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE13(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &vde13_cg_regs,			\
+		.vote_regs = &vde13_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote_inv,	\
+		.dma_ops = &mtk_clk_gate_ops_setclr_inv,\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_VDE14(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde14_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE14_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_VDE14(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "mm-vote-regmap",		\
+		.regs = &vde14_cg_regs,			\
+		.vote_regs = &vde14_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote_inv,	\
+		.dma_ops = &mtk_clk_gate_ops_setclr_inv,\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+	}
+
+static const struct mtk_gate vde1_clks[] = {
+	/* VDE10 */
+	GATE_VOTE_VDE10(CLK_VDE1_VDEC_CKEN, "vde1_vdec_cken", "ck2_vdec_ck", 0),
+	GATE_VDE10_V(CLK_VDE1_VDEC_CKEN_VDEC, "vde1_vdec_cken_vdec", "vde1_vdec_cken"),
+	GATE_VOTE_VDE10(CLK_VDE1_VDEC_ACTIVE, "vde1_vdec_active", "ck2_vdec_ck", 4),
+	GATE_VDE10_V(CLK_VDE1_VDEC_ACTIVE_VDEC, "vde1_vdec_active_vdec", "vde1_vdec_active"),
+	GATE_VOTE_VDE10(CLK_VDE1_VDEC_CKEN_ENG, "vde1_vdec_cken_eng", "ck2_vdec_ck", 8),
+	GATE_VDE10_V(CLK_VDE1_VDEC_CKEN_ENG_VDEC, "vde1_vdec_cken_eng_vdec", "vde1_vdec_cken_eng"),
+	/* VDE11 */
+	GATE_VOTE_VDE11(CLK_VDE1_VDEC_SOC_IPS_EN, "vde1_vdec_soc_ips_en", "ck2_vdec_ck", 0),
+	GATE_VDE11_V(CLK_VDE1_VDEC_SOC_IPS_EN_VDEC, "vde1_vdec_soc_ips_en_vdec",
+		     "vde1_vdec_soc_ips_en"),
+	/* VDE12 */
+	GATE_VOTE_VDE12(CLK_VDE1_VDEC_SOC_APTV_EN, "vde1_aptv_en", "ck2_avs_vdec_ck", 0),
+	GATE_VDE12_V(CLK_VDE1_VDEC_SOC_APTV_EN_VDEC, "vde1_aptv_en_vdec", "vde1_aptv_en"),
+	GATE_VOTE_VDE12(CLK_VDE1_VDEC_SOC_APTV_TOP_EN, "vde1_aptv_topen", "ck2_avs_vdec_ck", 1),
+	GATE_VDE12_V(CLK_VDE1_VDEC_SOC_APTV_TOP_EN_VDEC, "vde1_aptv_topen_vdec", "vde1_aptv_topen"),
+	/* VDE13 */
+	GATE_VOTE_VDE13(CLK_VDE1_LAT_CKEN, "vde1_lat_cken", "ck2_vdec_ck", 0),
+	GATE_VDE13_V(CLK_VDE1_LAT_CKEN_VDEC, "vde1_lat_cken_vdec", "vde1_lat_cken"),
+	GATE_VOTE_VDE13(CLK_VDE1_LAT_ACTIVE, "vde1_lat_active", "ck2_vdec_ck", 4),
+	GATE_VDE13_V(CLK_VDE1_LAT_ACTIVE_VDEC, "vde1_lat_active_vdec", "vde1_lat_active"),
+	GATE_VOTE_VDE13(CLK_VDE1_LAT_CKEN_ENG, "vde1_lat_cken_eng", "ck2_vdec_ck", 8),
+	GATE_VDE13_V(CLK_VDE1_LAT_CKEN_ENG_VDEC, "vde1_lat_cken_eng_vdec", "vde1_lat_cken_eng"),
+	/* VDE14 */
+	GATE_VOTE_VDE14(CLK_VDE1_LARB1_CKEN, "vde1_larb1_cken", "ck2_vdec_ck", 0),
+	GATE_VDE14_V(CLK_VDE1_LARB1_CKEN_VDEC, "vde1_larb1_cken_vdec", "vde1_larb1_cken"),
+	GATE_VDE14_V(CLK_VDE1_LARB1_CKEN_SMI, "vde1_larb1_cken_smi", "vde1_larb1_cken"),
+};
+
+static const struct mtk_clk_desc vde1_mcd = {
+	.clks = vde1_clks,
+	.num_clks = ARRAY_SIZE(vde1_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_vdec[] = {
+	{ .compatible = "mediatek,mt8196-vdecsys", .data = &vde2_mcd, },
+	{ .compatible = "mediatek,mt8196-vdecsys_soc", .data = &vde1_mcd, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-vdec",
+		.of_match_table = of_match_clk_mt8196_vdec,
+	},
+};
+
+module_platform_driver(clk_mt8196_vdec_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


