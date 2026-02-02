Return-Path: <netdev+bounces-255716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI+uEzFEgGkE5gIAu9opvQ
	(envelope-from <netdev+bounces-255716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:29:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EDC8AC2
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B2723005585
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9239B2FD1CA;
	Mon,  2 Feb 2026 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jSfBLWkN"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25E2D8DB1;
	Mon,  2 Feb 2026 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013732; cv=none; b=m2MYyEp5S8Ug5geqWb1ac8VOC+OUjuJLBBKa2M3xJysm8bN0UMpiB7nsaugBV4XoFoJ2doSK9xRD+Qcf35glEjmD/f7zgSxIJKJKlldi4NRNbs4391TQjWkHUPBbXSAbM3tMK7p2aoX1/yzkeUum/zbwoP2c5HMU0Khw2txOiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013732; c=relaxed/simple;
	bh=yy4EqIVDDj+an7aMIZ0jbyCSJDgvKGKiZ5herPmzJw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYkGBCic5zsPsnSwsb7g74LI+VL90RXXcVHFBUysv5nrR1307hvXzw5MzPipV/cl/BVs02W8XaY1Zr5UlPKDOpXu++REaKZEpgQE2nLTCasGsiuXu1PSR9wKMv1UejLNQ5bkRTAAYbYrIUqDB65jdFT9E5ouflXq+K/MBmf8PK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jSfBLWkN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6d099858000011f185319dbc3099e8fb-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jpfPzB9CGeEzDJ3hnSG8fv+pZKTEiqaxkUJRxUt0HJY=;
	b=jSfBLWkNIXLQAFYwLMGmfSiX5SnGD+T4tDl3FZywf3x5N/1GdScFxnTzyRwmjE9Jc5cMGRUFkBOB6nvMy6Ug738pVxM5j5SEffbwdYa6fV/Rz1zmPs4qAnjBh4DrCqbOSo++9+JtZUelkN/5jYHCvpdz7BQiXMQnWWXUFn2rnFc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ca429bec-92df-46f9-87e8-3a71fe67d2c8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:20c838f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6d099858000011f185319dbc3099e8fb-20260202
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2057714166; Mon, 02 Feb 2026 14:28:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 14:28:44 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Feb 2026 14:28:44 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu
 Tsai <wenst@chromium.org>, Miles Chen <miles.chen@mediatek.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Qiqi Wang
	<qiqi.wang@mediatek.com>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<irving-ch.lin@mediatek.com>
Subject: [PATCH v5 09/18] clk: mediatek: Add MT8189 dbgao clock support
Date: Mon, 2 Feb 2026 14:28:16 +0800
Message-ID: <20260202062840.342707-10-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255716-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]
X-Rspamd-Queue-Id: 380EDC8AC2
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 dbgao clock controller,
which provides clock gate control for debug-system.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig            | 10 +++
 drivers/clk/mediatek/Makefile           |  1 +
 drivers/clk/mediatek/clk-mt8189-dbgao.c | 94 +++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 0665255a29fd..89f68cb56bb3 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -850,6 +850,16 @@ config COMMON_CLK_MT8189_CAM
 	  that relies on this SoC and you want to control its clocks, say Y or M
 	  to include this driver in your kernel build.
 
+config COMMON_CLK_MT8189_DBGAO
+	tristate "Clock driver for MediaTek MT8189 debug ao"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the debug function
+	  on MediaTek MT8189 SoCs. This includes enabling and disabling
+	  vcore debug system clocks. If you want to control its clocks, say Y or M
+	  to include this driver in your kernel build.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 95a8f4ae05ee..eabe2cab4b8d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -127,6 +127,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o
 				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
 obj-$(CONFIG_COMMON_CLK_MT8189_CAM) += clk-mt8189-cam.o
+obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-dbgao.c b/drivers/clk/mediatek/clk-mt8189-dbgao.c
new file mode 100644
index 000000000000..543321ae5e65
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-dbgao.c
@@ -0,0 +1,94 @@
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
+static const struct mtk_gate_regs dbgao_cg_regs = {
+	.set_ofs = 0x70,
+	.clr_ofs = 0x70,
+	.sta_ofs = 0x70,
+};
+
+#define GATE_DBGAO(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &dbgao_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate dbgao_clks[] = {
+	GATE_DBGAO(CLK_DBGAO_ATB_EN, "dbgao_atb_en", "atb_sel", 0),
+};
+
+static const struct mtk_clk_desc dbgao_mcd = {
+	.clks = dbgao_clks,
+	.num_clks = ARRAY_SIZE(dbgao_clks),
+};
+
+static const struct mtk_gate_regs dem0_cg_regs = {
+	.set_ofs = 0x2c,
+	.clr_ofs = 0x2c,
+	.sta_ofs = 0x2c,
+};
+
+static const struct mtk_gate_regs dem1_cg_regs = {
+	.set_ofs = 0x30,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x30,
+};
+
+static const struct mtk_gate_regs dem2_cg_regs = {
+	.set_ofs = 0x70,
+	.clr_ofs = 0x70,
+	.sta_ofs = 0x70,
+};
+
+#define GATE_DEM0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &dem0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_DEM1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &dem1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_DEM2(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &dem2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate dem_clks[] = {
+	/* DEM0 */
+	GATE_DEM0(CLK_DEM_BUSCLK_EN, "dem_busclk_en", "axi_sel", 0),
+	/* DEM1 */
+	GATE_DEM1(CLK_DEM_SYSCLK_EN, "dem_sysclk_en", "axi_sel", 0),
+	/* DEM2 */
+	GATE_DEM2(CLK_DEM_ATB_EN, "dem_atb_en", "atb_sel", 0),
+};
+
+static const struct mtk_clk_desc dem_mcd = {
+	.clks = dem_clks,
+	.num_clks = ARRAY_SIZE(dem_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_dbgao[] = {
+	{ .compatible = "mediatek,mt8189-dbg-ao", .data = &dbgao_mcd },
+	{ .compatible = "mediatek,mt8189-dem", .data = &dem_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_dbgao);
+
+static struct platform_driver clk_mt8189_dbgao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-dbgao",
+		.of_match_table = of_match_clk_mt8189_dbgao,
+	},
+};
+
+module_platform_driver(clk_mt8189_dbgao_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 dbgao system clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


