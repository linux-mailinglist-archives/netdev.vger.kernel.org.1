Return-Path: <netdev+bounces-255717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNZaDUhEgGkE5gIAu9opvQ
	(envelope-from <netdev+bounces-255717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:29:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B539C8AF0
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F6B8300469E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727902FF664;
	Mon,  2 Feb 2026 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MJyoj4nA"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5502DB782;
	Mon,  2 Feb 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013733; cv=none; b=kJTgEJbyrYeKqt+8V+tIxalIV3uSRDPB8XbI3a2MXGPL36udkLDbsFQGZn7Zqbt/zZ+2xDzLIYJdu581YHtkitilb/uFKQZJiv/0dEUQ2QSfCqNOiC2a4/PaV7V8g7VMTYcyJYVQMO1nurkkX1ugLsAVPyiGb7UOWbbGcKnY8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013733; c=relaxed/simple;
	bh=onm+DI7gLOHtRskaBzVGFrBWMZHbsxd12V+RgyMOJhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YygubXFcp8pOq3kfIiSLHuxmb/48bte9dkLjhQq/PZd2dUxb4lqNi9BnC7IRWjSPU+dyqIRRMABt2EletqL4t0wKOJ5ppuWiQgilJVlQ5JQOcOuDCGDvXj/N1Oa380rrEmU3nixddpQWWBU460ug1V/Y+7VQ5icp866szzdMCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MJyoj4nA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6d27e894000011f185319dbc3099e8fb-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0tPokiXZlW+HYG1DX+dbiowxBxLPUafss9siq+Yk1l4=;
	b=MJyoj4nAF3jR2tQimqXzZ1vmDisz0oXY6psAcYk5ogJVsir92km2S37Uv32OdHfwNkB511ktFyF3rQaV7gEapVqWx98x+HeTR/TJg2v1s+eOg9lh22pT5v4vwaE3tAkrw1XdtlvcVSd20DaN+F6hAo8aUB+txYguEfzKc3EbqHo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:c709f3bd-e147-4d39-96b5-6dd80342b71f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:5844d25a-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6d27e894000011f185319dbc3099e8fb-20260202
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1411301831; Mon, 02 Feb 2026 14:28:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 14:28:45 +0800
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
Subject: [PATCH v5 13/18] clk: mediatek: Add MT8189 mdp clock support
Date: Mon, 2 Feb 2026 14:28:20 +0800
Message-ID: <20260202062840.342707-14-irving-ch.lin@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255717-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]
X-Rspamd-Queue-Id: 4B539C8AF0
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 mdp clock controller,
which provides clock gate control for display system.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig             | 12 ++++
 drivers/clk/mediatek/Makefile            |  1 +
 drivers/clk/mediatek/clk-mt8189-mdpsys.c | 91 ++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index e6c5d8a69607..bd50e18e48f4 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -894,6 +894,18 @@ config COMMON_CLK_MT8189_IMG
 	  are building a kernel for a device that uses the MT8189 SoC and requires
 	  image processing capabilities, say Y or M to include this driver.
 
+config COMMON_CLK_MT8189_MDPSYS
+	tristate "Clock driver for MediaTek MT8189 mdpsys"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  This driver supports the display system clocks on the MediaTek MT8189
+	  SoC. By enabling this option, it allows for the control of the clocks
+	  related to the display subsystem. This is crucial for the proper
+	  functionality of the display features on devices powered by the MT8189
+	  chipset, ensuring that the display system operates efficiently and
+	  effectively.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index a1eaf123f2f0..9b23e4c5e019 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-mdpsys.c b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
new file mode 100644
index 000000000000..282bfb77b47d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
@@ -0,0 +1,91 @@
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
+static const struct mtk_gate_regs mdp0_cg_regs = {
+	.set_ofs = 0x04,
+	.clr_ofs = 0x08,
+	.sta_ofs = 0x00,
+};
+
+static const struct mtk_gate_regs mdp1_cg_regs = {
+	.set_ofs = 0x14,
+	.clr_ofs = 0x18,
+	.sta_ofs = 0x10,
+};
+
+#define GATE_MDP0(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &mdp0_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
+#define GATE_MDP1(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &mdp1_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
+static const struct mtk_gate mdp_clks[] = {
+	/* MDP0 */
+	GATE_MDP0(CLK_MDP_MUTEX0, "mdp_mutex0", "mdp0_sel", 0),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "mdp0_sel", 1),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "mdp0_sel", 2),
+	GATE_MDP0(CLK_MDP_RDMA0, "mdp_rdma0", "mdp0_sel", 3),
+	GATE_MDP0(CLK_MDP_RDMA2, "mdp_rdma2", "mdp0_sel", 4),
+	GATE_MDP0(CLK_MDP_HDR0, "mdp_hdr0", "mdp0_sel", 5),
+	GATE_MDP0(CLK_MDP_AAL0, "mdp_aal0", "mdp0_sel", 6),
+	GATE_MDP0(CLK_MDP_RSZ0, "mdp_rsz0", "mdp0_sel", 7),
+	GATE_MDP0(CLK_MDP_TDSHP0, "mdp_tdshp0", "mdp0_sel", 8),
+	GATE_MDP0(CLK_MDP_COLOR0, "mdp_color0", "mdp0_sel", 9),
+	GATE_MDP0(CLK_MDP_WROT0, "mdp_wrot0", "mdp0_sel", 10),
+	GATE_MDP0(CLK_MDP_FAKE_ENG0, "mdp_fake_eng0", "mdp0_sel", 11),
+	GATE_MDP0(CLK_MDPSYS_CONFIG, "mdpsys_config", "mdp0_sel", 14),
+	GATE_MDP0(CLK_MDP_RDMA1, "mdp_rdma1", "mdp0_sel", 15),
+	GATE_MDP0(CLK_MDP_RDMA3, "mdp_rdma3", "mdp0_sel", 16),
+	GATE_MDP0(CLK_MDP_HDR1, "mdp_hdr1", "mdp0_sel", 17),
+	GATE_MDP0(CLK_MDP_AAL1, "mdp_aal1", "mdp0_sel", 18),
+	GATE_MDP0(CLK_MDP_RSZ1, "mdp_rsz1", "mdp0_sel", 19),
+	GATE_MDP0(CLK_MDP_TDSHP1, "mdp_tdshp1", "mdp0_sel", 20),
+	GATE_MDP0(CLK_MDP_COLOR1, "mdp_color1", "mdp0_sel", 21),
+	GATE_MDP0(CLK_MDP_WROT1, "mdp_wrot1", "mdp0_sel", 22),
+	GATE_MDP0(CLK_MDP_RSZ2, "mdp_rsz2", "mdp0_sel", 24),
+	GATE_MDP0(CLK_MDP_WROT2, "mdp_wrot2", "mdp0_sel", 25),
+	GATE_MDP0(CLK_MDP_RSZ3, "mdp_rsz3", "mdp0_sel", 28),
+	GATE_MDP0(CLK_MDP_WROT3, "mdp_wrot3", "mdp0_sel", 29),
+	/* MDP1 */
+	GATE_MDP1(CLK_MDP_BIRSZ0, "mdp_birsz0", "mdp0_sel", 3),
+	GATE_MDP1(CLK_MDP_BIRSZ1, "mdp_birsz1", "mdp0_sel", 4),
+};
+
+static const struct mtk_clk_desc mdp_mcd = {
+	.clks = mdp_clks,
+	.num_clks = ARRAY_SIZE(mdp_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_mdpsys[] = {
+	{ .compatible = "mediatek,mt8189-mdpsys", .data = &mdp_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_mdpsys);
+
+static struct platform_driver clk_mt8189_mdpsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-mdpsys",
+		.of_match_table = of_match_clk_mt8189_mdpsys,
+	},
+};
+
+module_platform_driver(clk_mt8189_mdpsys_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 mdpsys clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


