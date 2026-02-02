Return-Path: <netdev+bounces-255722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP3eE8VEgGkE5gIAu9opvQ
	(envelope-from <netdev+bounces-255722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:31:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CDC8BC8
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C115E302D0F8
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC4309DDF;
	Mon,  2 Feb 2026 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tzl/2CKh"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D52FFFAB;
	Mon,  2 Feb 2026 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013736; cv=none; b=jAwnawAnq/ij4Kz774+Kun/2RX7zeT9UQja2gWzz16zMmjutQ/ZYRkZ9+M9q7/iw0HRQqwC0e5irxY0M1DR8pNLedg+uGHCSG1vv8sUTSMZfLaLw6Jb05cyaqcUcWBgrnwCe3pIET+SRjBz8gPcWZcDlLwU5DJ+LbwrMq42cmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013736; c=relaxed/simple;
	bh=JvFEWzggZyJFvAxFNTM77Ver94o1CalxRaOSpDIgnP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYPRtF+15ixkW6CGwaC5lHNQSd0IEFHzIHWoFjzCPjs4fzC59lWc3/i42dZipFnm1DVsrUaCOd2ZtidIheDMrOaOlB9U+f8HS/f/Uf9ryJkG7m49GH7kmpMxxRUsAvaUJGhitQwDxQK6FqzqdOOHes/kTHpA4d2lM0GFm0qmcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tzl/2CKh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6de0a1d6000011f185319dbc3099e8fb-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F1pUF+Odb9JwOgmgIejWqT76RTSUI8Y3I87OzgXfUHQ=;
	b=Tzl/2CKhve42uY+GZTajBFW14n4dSasdl/+k2unwt5Wp3mlYs0uchBD0Y8pHcTVZh9E350qlAAJ5VtykazeWKWZYiBZ788w7xQPXQsFiYDH4mHSrsLmYA77UP5fxx0i0qN4Xrbc2zP+d8Kcb63zd8SziL/RzwGklXe+ApOaI1ko=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:4d8e8194-d8d6-4f0a-bd63-2833d0ec21c5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:df347b7a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6de0a1d6000011f185319dbc3099e8fb-20260202
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1907201905; Mon, 02 Feb 2026 14:28:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 14:28:45 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Feb 2026 14:28:45 +0800
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
Subject: [PATCH v5 16/18] clk: mediatek: Add MT8189 scp clock support
Date: Mon, 2 Feb 2026 14:28:23 +0800
Message-ID: <20260202062840.342707-17-irving-ch.lin@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255722-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]
X-Rspamd-Queue-Id: 107CDC8BC8
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 scp clock controller,
which provides clock gate control for System Control Processor.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          | 10 ++++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8189-scp.c | 73 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index cb1b8bc49033..4bf111c9efb5 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -929,6 +929,16 @@ config COMMON_CLK_MT8189_MMSYS
 	  ensure that these components receive the correct clock frequencies
 	  for proper operation.
 
+config COMMON_CLK_MT8189_SCP
+	tristate "Clock driver for MediaTek MT8189 scp"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock framework for the System Control
+	  Processor (SCP) in the MediaTek MT8189 SoC. This includes clock
+	  management for SCP-related features, ensuring proper clock
+	  distribution and gating for power efficiency and functionality.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 21a9e6264b84..819c67395e1b 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MMSYS) += clk-mt8189-dispsys.o
+obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-scp.c b/drivers/clk/mediatek/clk-mt8189-scp.c
new file mode 100644
index 000000000000..efa00de90215
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-scp.c
@@ -0,0 +1,73 @@
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
+static const struct mtk_gate_regs scp_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_SCP(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &scp_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate scp_clks[] = {
+	GATE_SCP(CLK_SCP_SET_SPI0, "scp_set_spi0", "clk26m", 0),
+	GATE_SCP(CLK_SCP_SET_SPI1, "scp_set_spi1", "clk26m", 1),
+};
+
+static const struct mtk_clk_desc scp_mcd = {
+	.clks = scp_clks,
+	.num_clks = ARRAY_SIZE(scp_clks),
+};
+
+static const struct mtk_gate_regs scp_iic_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_SCP_IIC(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &scp_iic_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate scp_iic_clks[] = {
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C0_W1S, "scp_iic_i2c0_w1s", "vlp_scp_iic_sel", 0),
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C1_W1S, "scp_iic_i2c1_w1s", "vlp_scp_iic_sel", 1),
+};
+
+static const struct mtk_clk_desc scp_iic_mcd = {
+	.clks = scp_iic_clks,
+	.num_clks = ARRAY_SIZE(scp_iic_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_scp[] = {
+	{ .compatible = "mediatek,mt8189-scp-clk", .data = &scp_mcd },
+	{ .compatible = "mediatek,mt8189-scp-i2c-clk", .data = &scp_iic_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_scp);
+
+static struct platform_driver clk_mt8189_scp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-scp",
+		.of_match_table = of_match_clk_mt8189_scp,
+	},
+};
+
+module_platform_driver(clk_mt8189_scp_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 scp clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


