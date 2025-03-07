Return-Path: <netdev+bounces-172766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DACCA55E8F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AF97AA775
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546971DDA15;
	Fri,  7 Mar 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="INfwQZCT"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250331A3171;
	Fri,  7 Mar 2025 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318379; cv=none; b=kJLUuxajlV4zahT65yf30Un3/U8zEUBvV003w6sD4m/7RTJV1BjOlsCCIY5TpeaRIEUnasdQQzLbSTQk/bbv/NV+vBHgUqFpLFQyK2L3TKnFhc3LZJ3ijoaYXBzmkIxyrPFNboJc4HoqYuEqVF1U7XRyr1+pL98tXBEEW82WJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318379; c=relaxed/simple;
	bh=KXOYl3yezSuFzcJr8TWad8v1X5qeqmfhvICdG5E3prY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLK6GHhxYqHr2QH716LGpfluNR8WO3OQTrsxppwW5Lu21OTjUxr0I3bbw/eOY+Mfur4rcu5iSFb6y0wwp/QnpOx8ZgvJH8+Ihb037zuwcFkC+5GPIlKMT0F5e4OJ/dOv+b8+YdON74nfmaJs/aKf50h6F2Eb7W8RSm/rI5Hds0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=INfwQZCT; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d757cdc6fb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KAbOCs5jEptULI+fDudGEiRDMOEH0t+TFmMUXYyAEhI=;
	b=INfwQZCTSz0+3wVwzXq1zfvBHMbhq32XN2d0ohY8yetZTMYChBJOdZm0vN0nUsfnYCw1cC2nShgQZ7py96rVV+QYQypGNQ7NYZJxGsBQpM+3VTJC/LvbCtjKSklUWCj7hMH3KS2hsXnQ+ELs+xigHrqebkox2z7AHugt+7b22B0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:fa19f989-a104-4556-999f-c9c25305834c,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:7128cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d757cdc6fb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1447609083; Fri, 07 Mar 2025 11:32:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:46 +0800
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
Subject: [PATCH 14/26] clk: mediatek: Add MT8196 i2c clock support
Date: Fri, 7 Mar 2025 11:27:10 +0800
Message-ID: <20250307032942.10447-15-guangjie.song@mediatek.com>
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

Add MT8196 i2c clock controller which provides clock gate control for
i2c.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                  |   7 +
 drivers/clk/mediatek/Makefile                 |   1 +
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    | 211 ++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index fe54dca0062e..bc373e9ab589 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1017,6 +1017,13 @@ config COMMON_CLK_MT8196_ADSP
 	help
 	  This driver supports MediaTek MT8196 adsp clocks
 
+config COMMON_CLK_MT8196_IMP_IIC_WRAP
+	tristate "Clock driver for MediaTek MT8196 imp_iic_wrap"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 i2c clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index c0d676930a80..beea4d8eeebe 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-apmixedsys
 				   clk-mt8196-topckgen.o clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
+obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
new file mode 100644
index 000000000000..c514882e957e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
@@ -0,0 +1,211 @@
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
+static const struct mtk_gate_regs impc_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMPC(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &impc_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IMPC_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate impc_clks[] = {
+	GATE_IMPC(CLK_IMPC_I2C11, "impc_i2c11", "ck_i2c_p_ck", 0),
+	GATE_IMPC_V(CLK_IMPC_I2C11_I2C, "impc_i2c11_i2c", "impc_i2c11"),
+	GATE_IMPC(CLK_IMPC_I2C12, "impc_i2c12", "ck_i2c_p_ck", 1),
+	GATE_IMPC_V(CLK_IMPC_I2C12_I2C, "impc_i2c12_i2c", "impc_i2c12"),
+	GATE_IMPC(CLK_IMPC_I2C13, "impc_i2c13", "ck_i2c_p_ck", 2),
+	GATE_IMPC_V(CLK_IMPC_I2C13_I2C, "impc_i2c13_i2c", "impc_i2c13"),
+	GATE_IMPC(CLK_IMPC_I2C14, "impc_i2c14", "ck_i2c_p_ck", 3),
+	GATE_IMPC_V(CLK_IMPC_I2C14_I2C, "impc_i2c14_i2c", "impc_i2c14"),
+};
+
+static const struct mtk_clk_desc impc_mcd = {
+	.clks = impc_clks,
+	.num_clks = ARRAY_SIZE(impc_clks),
+};
+
+static const struct mtk_gate_regs impe_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMPE(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &impe_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_IMPE_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate impe_clks[] = {
+	GATE_IMPE(CLK_IMPE_I2C5, "impe_i2c5", "ck_i2c_east_ck", 0),
+	GATE_IMPE_V(CLK_IMPE_I2C5_I2C, "impe_i2c5_i2c", "impe_i2c5"),
+};
+
+static const struct mtk_clk_desc impe_mcd = {
+	.clks = impe_clks,
+	.num_clks = ARRAY_SIZE(impe_clks),
+};
+
+static const struct mtk_gate_regs impn_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+static const struct mtk_gate_regs impn_vote_regs = {
+	.set_ofs = 0x0000,
+	.clr_ofs = 0x0004,
+	.sta_ofs = 0x2c00,
+};
+
+#define GATE_IMPN(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &impn_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_IMPN_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_VOTE_IMPN(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.vote_comp = "vote-regmap",		\
+		.regs = &impn_cg_regs,			\
+		.vote_regs = &impn_vote_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_vote,		\
+		.dma_ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_USE_VOTE |			\
+			 CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate impn_clks[] = {
+	GATE_IMPN(CLK_IMPN_I2C1, "impn_i2c1", "ck_i2c_north_ck", 0),
+	GATE_IMPN_V(CLK_IMPN_I2C1_I2C, "impn_i2c1_i2c", "impn_i2c1"),
+	GATE_IMPN(CLK_IMPN_I2C2, "impn_i2c2", "ck_i2c_north_ck", 1),
+	GATE_IMPN_V(CLK_IMPN_I2C2_I2C, "impn_i2c2_i2c", "impn_i2c2"),
+	GATE_IMPN(CLK_IMPN_I2C4, "impn_i2c4", "ck_i2c_north_ck", 2),
+	GATE_IMPN_V(CLK_IMPN_I2C4_I2C, "impn_i2c4_i2c", "impn_i2c4"),
+	GATE_VOTE_IMPN(CLK_IMPN_I2C7, "impn_i2c7", "ck_i2c_north_ck", 3),
+	GATE_IMPN_V(CLK_IMPN_I2C7_I2C, "impn_i2c7_i2c", "impn_i2c7"),
+	GATE_IMPN(CLK_IMPN_I2C8, "impn_i2c8", "ck_i2c_north_ck", 4),
+	GATE_IMPN_V(CLK_IMPN_I2C8_I2C, "impn_i2c8_i2c", "impn_i2c8"),
+	GATE_IMPN(CLK_IMPN_I2C9, "impn_i2c9", "ck_i2c_north_ck", 5),
+	GATE_IMPN_V(CLK_IMPN_I2C9_I2C, "impn_i2c9_i2c", "impn_i2c9"),
+};
+
+static const struct mtk_clk_desc impn_mcd = {
+	.clks = impn_clks,
+	.num_clks = ARRAY_SIZE(impn_clks),
+};
+
+static const struct mtk_gate_regs impw_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMPW(_id, _name, _parent, _shift) {\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &impw_cg_regs,		\
+		.shift = _shift,		\
+		.flags = CLK_OPS_PARENT_ENABLE,	\
+		.ops = &mtk_clk_gate_ops_setclr,\
+	}
+
+#define GATE_IMPW_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate impw_clks[] = {
+	GATE_IMPW(CLK_IMPW_I2C0, "impw_i2c0", "ck_i2c_west_ck", 0),
+	GATE_IMPW_V(CLK_IMPW_I2C0_I2C, "impw_i2c0_i2c", "impw_i2c0"),
+	GATE_IMPW(CLK_IMPW_I2C3, "impw_i2c3", "ck_i2c_west_ck", 1),
+	GATE_IMPW_V(CLK_IMPW_I2C3_I2C, "impw_i2c3_i2c", "impw_i2c3"),
+	GATE_IMPW(CLK_IMPW_I2C6, "impw_i2c6", "ck_i2c_west_ck", 2),
+	GATE_IMPW_V(CLK_IMPW_I2C6_I2C, "impw_i2c6_i2c", "impw_i2c6"),
+	GATE_IMPW(CLK_IMPW_I2C10, "impw_i2c10", "ck_i2c_west_ck", 3),
+	GATE_IMPW_V(CLK_IMPW_I2C10_I2C, "impw_i2c10_i2c", "impw_i2c10"),
+};
+
+static const struct mtk_clk_desc impw_mcd = {
+	.clks = impw_clks,
+	.num_clks = ARRAY_SIZE(impw_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8196_imp_iic_wrap[] = {
+	{ .compatible = "mediatek,mt8196-imp_iic_wrap_c", .data = &impc_mcd, },
+	{ .compatible = "mediatek,mt8196-imp_iic_wrap_e", .data = &impe_mcd, },
+	{ .compatible = "mediatek,mt8196-imp_iic_wrap_n", .data = &impn_mcd, },
+	{ .compatible = "mediatek,mt8196-imp_iic_wrap_w", .data = &impw_mcd, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_imp_iic_wrap_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-imp_iic_wrap",
+		.of_match_table = of_match_clk_mt8196_imp_iic_wrap,
+	},
+};
+
+module_platform_driver(clk_mt8196_imp_iic_wrap_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


