Return-Path: <netdev+bounces-200239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40382AE3CC8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFD81896186
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769825CC7B;
	Mon, 23 Jun 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DPpjcYcJ"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32525C71C;
	Mon, 23 Jun 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674668; cv=none; b=OL+3a2drOlt5NKLdnjC9Yi8jq0P2i+Cdw11qI9GsYZpgU7JCJtAZ3VqdQJw7A6Uv6zvn5xCqvxt87VV4Pq0WXmu/yWQ5jekAhIlJyUnkMrBGLtESn4oaV98GolQ8zFnztHgCw1buOEp6MZcfei3ZZZQ2t2jIJL8HPT9dQ4wL7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674668; c=relaxed/simple;
	bh=3rLFJ1DSNQK8xVprilTYSRnopXqh1Sfb9L31LzR2SD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJQFkh041WW/A+fdqFGvuAAJLrb34L8qhPPQkdfMgOOulginCzTaKKgUV9lUKE2EhT/3aOf2aytbpIazUciLHJPsmAILvBPHL0631o1TVRd3LxsCknfekZXu2rZrWglOpJRO4XlB+qoUKBkSn+6+VxfJERUzii3WXIq2w3wS68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DPpjcYcJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674664;
	bh=3rLFJ1DSNQK8xVprilTYSRnopXqh1Sfb9L31LzR2SD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPpjcYcJoieJb3MhAisSoKFAiD2NwRc8Ia3a7nrHe60shtfTi/8Zx+XjBVD0J1KSk
	 Q+S3Qf5YV9rGrmxtQHy9bOMx8JlLYWgEEZBkfHQ051+p3oMFPpA2b24HiTduw1C3jW
	 Y+jLpE9JhhxjtLh/UVfVnDEp57U+89jB/1wCNJDHxhL87+WppxanNjnQGhqKogNBZb
	 JEHTp3jaQK7ie4TD2aVrUY8m4OjLRbirJIO/c3LuMyzbCZMq1znh2Zcd5+Y3kOJefi
	 1NPI2Qohx3SsgQGyROX+ay727UwoGObQNV57EkHQdLxjr9KqY/JPF8XINtfhKO2rDO
	 Farfj4jUEUbBg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 48B6617E05BD;
	Mon, 23 Jun 2025 12:31:03 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 28/30] clk: mediatek: Add MT8196 vencsys clock support
Date: Mon, 23 Jun 2025 12:29:38 +0200
Message-Id: <20250623102940.214269-29-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623102940.214269-1-laura.nao@collabora.com>
References: <20250623102940.214269-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MT8196 vencsys clock controller, which provides
clock gate control for the video encoder.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/Kconfig           |   7 +
 drivers/clk/mediatek/Makefile          |   1 +
 drivers/clk/mediatek/clk-mt8196-venc.c | 235 +++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-venc.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index fc20942a547e..84b91e7bc8f6 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1131,6 +1131,13 @@ config COMMON_CLK_MT8196_VDECSYS
 	help
 	  This driver supports MediaTek MT8196 vdecsys clocks.
 
+config COMMON_CLK_MT8196_VENCSYS
+	tristate "Clock driver for MediaTek MT8196 vencsys"
+	depends on COMMON_CLK_MT8196
+	default m
+	help
+	  This driver supports MediaTek MT8196 vencsys clocks.
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 5d3b68649a53..069cca024cd1 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -173,6 +173,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-mt8196-disp1.o c
 obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
 obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8196_VDECSYS) += clk-mt8196-vdec.o
+obj-$(CONFIG_COMMON_CLK_MT8196_VENCSYS) += clk-mt8196-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-venc.c b/drivers/clk/mediatek/clk-mt8196-venc.c
new file mode 100644
index 000000000000..ecbd42629e9f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-venc.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8196-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs ven10_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs ven10_hwv_regs = {
+	.set_ofs = 0x00b8,
+	.clr_ofs = 0x00bc,
+	.sta_ofs = 0x2c5c,
+};
+
+static const struct mtk_gate_regs ven11_cg_regs = {
+	.set_ofs = 0x10,
+	.clr_ofs = 0x14,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs ven11_hwv_regs = {
+	.set_ofs = 0x00c0,
+	.clr_ofs = 0x00c4,
+	.sta_ofs = 0x2c60,
+};
+
+#define GATE_VEN10(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven10_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_HWV_VEN10_FLAGS(_id, _name, _parent, _shift, _flags) {	\
+		.id = _id,						\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.regs = &ven10_cg_regs,					\
+		.hwv_regs = &ven10_hwv_regs,				\
+		.shift = _shift,					\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,		\
+		.flags = (_flags) |					\
+			 CLK_OPS_PARENT_ENABLE,				\
+	}
+
+#define GATE_HWV_VEN10(_id, _name, _parent, _shift)	\
+	GATE_HWV_VEN10_FLAGS(_id, _name, _parent, _shift, 0)
+
+#define GATE_HWV_VEN11(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven11_cg_regs,			\
+		.hwv_regs = &ven11_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE		\
+	}
+
+static const struct mtk_gate ven1_clks[] = {
+	/* VEN10 */
+	GATE_HWV_VEN10(CLK_VEN1_CKE0_LARB, "ven1_larb", "venc", 0),
+	GATE_HWV_VEN10(CLK_VEN1_CKE1_VENC, "ven1_venc", "venc", 4),
+	GATE_VEN10(CLK_VEN1_CKE2_JPGENC, "ven1_jpgenc", "venc", 8),
+	GATE_VEN10(CLK_VEN1_CKE3_JPGDEC, "ven1_jpgdec", "venc", 12),
+	GATE_VEN10(CLK_VEN1_CKE4_JPGDEC_C1, "ven1_jpgdec_c1", "venc", 16),
+	GATE_HWV_VEN10(CLK_VEN1_CKE5_GALS, "ven1_gals", "venc", 28),
+	GATE_HWV_VEN10(CLK_VEN1_CKE29_VENC_ADAB_CTRL, "ven1_venc_adab_ctrl",
+			"venc", 29),
+	GATE_HWV_VEN10_FLAGS(CLK_VEN1_CKE29_VENC_XPC_CTRL,
+			      "ven1_venc_xpc_ctrl", "venc", 30,
+			      CLK_IGNORE_UNUSED),
+	GATE_HWV_VEN10(CLK_VEN1_CKE6_GALS_SRAM, "ven1_gals_sram", "venc", 31),
+	/* VEN11 */
+	GATE_HWV_VEN11(CLK_VEN1_RES_FLAT, "ven1_res_flat", "venc", 0),
+};
+
+static const struct mtk_clk_desc ven1_mcd = {
+	.clks = ven1_clks,
+	.num_clks = ARRAY_SIZE(ven1_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct mtk_gate_regs ven20_hwv_regs = {
+	.set_ofs = 0x00c8,
+	.clr_ofs = 0x00cc,
+	.sta_ofs = 0x2c64,
+};
+
+static const struct mtk_gate_regs ven21_hwv_regs = {
+	.set_ofs = 0x00d0,
+	.clr_ofs = 0x00d4,
+	.sta_ofs = 0x2c68,
+};
+
+#define GATE_VEN20(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven10_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_HWV_VEN20(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven10_cg_regs,			\
+		.hwv_regs = &ven20_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_VEN21(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven11_cg_regs,			\
+		.hwv_regs = &ven21_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE		\
+	}
+
+static const struct mtk_gate ven2_clks[] = {
+	/* VEN20 */
+	GATE_HWV_VEN20(CLK_VEN2_CKE0_LARB, "ven2_larb", "venc", 0),
+	GATE_HWV_VEN20(CLK_VEN2_CKE1_VENC, "ven2_venc", "venc", 4),
+	GATE_VEN20(CLK_VEN2_CKE2_JPGENC, "ven2_jpgenc", "venc", 8),
+	GATE_VEN20(CLK_VEN2_CKE3_JPGDEC, "ven2_jpgdec", "venc", 12),
+	GATE_HWV_VEN20(CLK_VEN2_CKE5_GALS, "ven2_gals", "venc", 28),
+	GATE_HWV_VEN20(CLK_VEN2_CKE29_VENC_XPC_CTRL, "ven2_venc_xpc_ctrl", "venc", 30),
+	GATE_HWV_VEN20(CLK_VEN2_CKE6_GALS_SRAM, "ven2_gals_sram", "venc", 31),
+	/* VEN21 */
+	GATE_HWV_VEN21(CLK_VEN2_RES_FLAT, "ven2_res_flat", "venc", 0),
+};
+
+static const struct mtk_clk_desc ven2_mcd = {
+	.clks = ven2_clks,
+	.num_clks = ARRAY_SIZE(ven2_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct mtk_gate_regs ven_c20_hwv_regs = {
+	.set_ofs = 0x00d8,
+	.clr_ofs = 0x00dc,
+	.sta_ofs = 0x2c6c,
+};
+
+static const struct mtk_gate_regs ven_c21_hwv_regs = {
+	.set_ofs = 0x00e0,
+	.clr_ofs = 0x00e4,
+	.sta_ofs = 0x2c70,
+};
+
+#define GATE_HWV_VEN_C20(_id, _name, _parent, _shift) {\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven10_cg_regs,		\
+		.hwv_regs = &ven_c20_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr_inv,\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_HWV_VEN_C21(_id, _name, _parent, _shift) {\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven11_cg_regs,		\
+		.hwv_regs = &ven_c21_hwv_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ven_c2_clks[] = {
+	/* VEN_C20 */
+	GATE_HWV_VEN_C20(CLK_VEN_C2_CKE0_LARB, "ven_c2_larb", "venc", 0),
+	GATE_HWV_VEN_C20(CLK_VEN_C2_CKE1_VENC, "ven_c2_venc", "venc", 4),
+	GATE_HWV_VEN_C20(CLK_VEN_C2_CKE5_GALS, "ven_c2_gals", "venc", 28),
+	GATE_HWV_VEN_C20(CLK_VEN_C2_CKE29_VENC_XPC_CTRL, "ven_c2_venc_xpc_ctrl",
+			  "venc", 30),
+	GATE_HWV_VEN_C20(CLK_VEN_C2_CKE6_GALS_SRAM, "ven_c2_gals_sram", "venc", 31),
+	/* VEN_C21 */
+	GATE_HWV_VEN_C21(CLK_VEN_C2_RES_FLAT, "ven_c2_res_flat", "venc", 0),
+};
+
+static const struct mtk_clk_desc ven_c2_mcd = {
+	.clks = ven_c2_clks,
+	.num_clks = ARRAY_SIZE(ven_c2_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_venc[] = {
+	{ .compatible = "mediatek,mt8196-vencsys", .data = &ven1_mcd },
+	{ .compatible = "mediatek,mt8196-vencsys-c1", .data = &ven2_mcd },
+	{ .compatible = "mediatek,mt8196-vencsys-c2", .data = &ven_c2_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_venc);
+
+static struct platform_driver clk_mt8196_venc_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-venc",
+		.of_match_table = of_match_clk_mt8196_venc,
+	},
+};
+module_platform_driver(clk_mt8196_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8196 Video Encoders clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


