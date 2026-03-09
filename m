Return-Path: <netdev+bounces-265504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCpYICy5rmlIIQIAu9opvQ
	(envelope-from <netdev+bounces-265504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:12:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D26722388D8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E9433095200
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD403ACA4B;
	Mon,  9 Mar 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qNR4lIoG"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EC3A9635;
	Mon,  9 Mar 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057929; cv=none; b=fDE2dlBIGQoQjGTSUv+RuvJdeQilux0mh0yOqprF1H6oZOy5jXgJEIoWOudvY7SCFjCfHKtQboFGf0Cr3iVJ4SlIvomOErTXxjJ572GwHy9V6VUXtYkJppIcnQ3PqwYYjzzIMdlTZMY92K01V3zpyNTps9/C6PCJ2dDZfvN0as4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057929; c=relaxed/simple;
	bh=akClU+dxQ869+SKcEWLXtsyxin7K6PI4gTCwZBYdwXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVMbjlKldy2qaHx259ViqSL5u7cmZcfNetBL2VgmvktZ9JrLzwJjpFI3TmR9oopTQuS/4ceuxA9yB2kiBsqlAL2ANQg8M8d3+YELzemWGLhtfUiROJb2WHCgyQ8nZX5aTaNDa4DtLqeSQrCgTRJtKpvhVsVRrEl4MLjGCze3IKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qNR4lIoG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3e714c221bb011f1a02d4725871ece0b-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2MO5pAeKaDnZlEBZfBK1faXM6L5WkJmGw9Ae7P9JBmk=;
	b=qNR4lIoGrvukvBkAcf1+4fHJcTXjCCWEwZriT2fUKbJXIf65gKnymaNzqjAXUZCdeeibH1CHX7yNidwMoBoHbF63clBX6ssWSqCTU6yJOLnIVFfLs/5L3QhmynNb3Levzvd/5kuWTLUIMVAfNsYpsDcmBeaWkwC+Q1hc8IZpXnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:bba3fad9-f670-4e61-a8cc-d3bdd387149c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:741f6ff1-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3e714c221bb011f1a02d4725871ece0b-20260309
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 725730763; Mon, 09 Mar 2026 20:05:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 20:05:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Mar 2026 20:05:18 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, "Chen-Yu
 Tsai" <wenst@chromium.org>, Miles Chen <miles.chen@mediatek.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Qiqi Wang
	<qiqi.wang@mediatek.com>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<irving-ch.lin@mediatek.com>
Subject: [PATCH v6 08/18] clk: mediatek: Add MT8189 cam clock support
Date: Mon, 9 Mar 2026 20:04:50 +0800
Message-ID: <20260309120512.3624804-9-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
References: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: D26722388D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265504-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irving-ch.lin@mediatek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 cam clock controller,
which provides clock gate control for camera.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  11 +++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8189-cam.c | 108 ++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 47172623f29f..0665255a29fd 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -839,6 +839,17 @@ config COMMON_CLK_MT8189_BUS
 	  MT8189 chipset, ensuring that all bus-related components receive the
 	  correct clock signals for optimal performance.
 
+config COMMON_CLK_MT8189_CAM
+	tristate "Clock driver for MediaTek MT8189 cam"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the camera interface
+	  on MediaTek MT8189 SoCs. This includes enabling, disabling, and
+	  setting the rate for camera-related clocks. If you have a camera
+	  that relies on this SoC and you want to control its clocks, say Y or M
+	  to include this driver in your kernel build.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index aabfb42cb1b2..95a8f4ae05ee 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
 				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
+obj-$(CONFIG_COMMON_CLK_MT8189_CAM) += clk-mt8189-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-cam.c b/drivers/clk/mediatek/clk-mt8189-cam.c
new file mode 100644
index 000000000000..d65ac08cedd6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-cam.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs cam_m_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_M(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &cam_m_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
+static const struct mtk_gate cam_m_clks[] = {
+	GATE_CAM_M(CLK_CAM_M_LARB13, "cam_m_larb13", "cam_sel", 0),
+	GATE_CAM_M(CLK_CAM_M_LARB14, "cam_m_larb14", "cam_sel", 2),
+	GATE_CAM_M(CLK_CAM_M_CAMSYS_MAIN_CAM, "cam_m_camsys_main_cam", "cam_sel", 6),
+	GATE_CAM_M(CLK_CAM_M_CAMSYS_MAIN_CAMTG, "cam_m_camsys_main_camtg", "cam_sel", 7),
+	GATE_CAM_M(CLK_CAM_M_SENINF, "cam_m_seninf", "cam_sel", 8),
+	GATE_CAM_M(CLK_CAM_M_CAMSV1, "cam_m_camsv1", "cam_sel", 10),
+	GATE_CAM_M(CLK_CAM_M_CAMSV2, "cam_m_camsv2", "cam_sel", 11),
+	GATE_CAM_M(CLK_CAM_M_CAMSV3, "cam_m_camsv3", "cam_sel", 12),
+	GATE_CAM_M(CLK_CAM_M_FAKE_ENG, "cam_m_fake_eng", "cam_sel", 17),
+	GATE_CAM_M(CLK_CAM_M_CAM2MM_GALS, "cam_m_cam2mm_gals", "cam_sel", 19),
+	GATE_CAM_M(CLK_CAM_M_CAMSV4, "cam_m_camsv4", "cam_sel", 20),
+	GATE_CAM_M(CLK_CAM_M_PDA, "cam_m_pda", "cam_sel", 21),
+};
+
+static const struct mtk_clk_desc cam_m_mcd = {
+	.clks = cam_m_clks,
+	.num_clks = ARRAY_SIZE(cam_m_clks),
+};
+
+static const struct mtk_gate_regs cam_ra_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_RA(_id, _name, _parent, _shift)			\
+	GATE_MTK_FLAGS(_id, _name, _parent, &cam_ra_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
+static const struct mtk_gate cam_ra_clks[] = {
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_LARBX, "cam_ra_camsys_rawa_larbx", "cam_sel", 0),
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_CAM, "cam_ra_camsys_rawa_cam", "cam_sel", 1),
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_CAMTG, "cam_ra_camsys_rawa_camtg", "cam_sel", 2),
+};
+
+static const struct mtk_clk_desc cam_ra_mcd = {
+	.clks = cam_ra_clks,
+	.num_clks = ARRAY_SIZE(cam_ra_clks),
+};
+
+static const struct mtk_gate_regs cam_rb_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_RB(_id, _name, _parent, _shift)			\
+	GATE_MTK_FLAGS(_id, _name, _parent, &cam_rb_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
+static const struct mtk_gate cam_rb_clks[] = {
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_LARBX, "cam_rb_camsys_rawb_larbx", "cam_sel", 0),
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_CAM, "cam_rb_camsys_rawb_cam", "cam_sel", 1),
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_CAMTG, "cam_rb_camsys_rawb_camtg", "cam_sel", 2),
+};
+
+static const struct mtk_clk_desc cam_rb_mcd = {
+	.clks = cam_rb_clks,
+	.num_clks = ARRAY_SIZE(cam_rb_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_cam[] = {
+	{ .compatible = "mediatek,mt8189-camsys-main", .data = &cam_m_mcd },
+	{ .compatible = "mediatek,mt8189-camsys-rawa", .data = &cam_ra_mcd },
+	{ .compatible = "mediatek,mt8189-camsys-rawb", .data = &cam_rb_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_cam);
+
+static struct platform_driver clk_mt8189_cam_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-cam",
+		.of_match_table = of_match_clk_mt8189_cam,
+	},
+};
+
+module_platform_driver(clk_mt8189_cam_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 cam clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


