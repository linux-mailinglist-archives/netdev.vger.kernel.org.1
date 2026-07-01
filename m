Return-Path: <netdev+bounces-303662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g7chLeUXRWqN6woAu9opvQ
	(envelope-from <netdev+bounces-303662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:36:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5D6EE32D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:36:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=QNED6o07;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303662-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A182B328AF17
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE649552F;
	Wed,  1 Jul 2026 13:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9A480DFE;
	Wed,  1 Jul 2026 13:11:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911496; cv=none; b=ew7OuQvkzWvPH6sEtHtDx6S5VbgnvjJR/Yg8Ey2Q4eX3gcNachiRbSd5rV9STZZ/rge195olkUI1SOvBOVuJeK6290mS73Z2HwrUweHBC+yAB+IIfxwVojCQ5BJEE9z9ofEfqFWZr+pU8ELp6Rj9vUSFvsPlys9Zy1qhfHqRu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911496; c=relaxed/simple;
	bh=HpFbZzsbx9RqdZe/2RCMVf6+wyxTZuB36EdBjiod/EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr0SFE5dyveTIrkEbxcTHsWi0O2Pdm6RNEf+v/4McHT4CJKc6OQsaw9ZVs61fBIk7eWHtdZnu3xUXlqAzYz2XBRNSWiA1eP2qE8Tyvzl0DzJamo3T1N2sEPfJowjYIdklq/XxbGN+8vquIfaFg+OriPHIYmRTmtM7XuXHdL4Jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QNED6o07; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782911492;
	bh=HpFbZzsbx9RqdZe/2RCMVf6+wyxTZuB36EdBjiod/EU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QNED6o07BXbvTw4F5Fp0renuYXHNns8LIru0KCodzfKVQc1wuwjLEr0S3zSMCWy9u
	 AQgxGFScNwZcTkgXFwy0jgFIDJJDjmsNZh8p+TF65oJZgW2MMgkWCQWUlfycWQfDQW
	 tSij8wMguZJOw+gqJgUi7ZgcyA0zMTe+2r264AHos9D5pqYI50fIxriq5DQezwBz5F
	 UUJOba3Qh6LAK+1/yACOB5z2Ik+UA3gb1Ek0cFiqFyw81rPiHUJj6IorOSHgnl1mxC
	 zeNlpsMOCnOK9iAtQrUOklDTr+3vDXrRJWZDf6aH6PGagqCz3s78p1gGf3/HPOxCEo
	 PBiiKQbIJHNXA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B36417E35DB;
	Wed,  1 Jul 2026 15:11:31 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 15:11:16 +0200
Subject: [PATCH 11/15] clk: mediatek: Add MT8189 dbgao clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8189-clocks-system-base-v1-11-2b048feea50a@collabora.com>
References: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
In-Reply-To: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782911477; l=5596;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=HpFbZzsbx9RqdZe/2RCMVf6+wyxTZuB36EdBjiod/EU=;
 b=dvpbTPT3FlLetF7tLrmiRIZrlbwtJVUQ4/Ukv0PqIBT+8G29MN9O98mDYvxn2KiuDnHQxxmDn
 MhgIMCA6GSlC6xq/SUD+gnkupch63/PY22hQ/Lnwzm5uZN/GYxKfCb0
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303662-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:irving-ch.lin@mediatek.com,m:louisalexis.eyraud@collabora.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,collabora.com:from_mime,mediatek.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59A5D6EE32D

Add support for the MT8189 dbgao clock controller,
which provides clock gate control for debug-system.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig            | 10 ++++
 drivers/clk/mediatek/Makefile           |  1 +
 drivers/clk/mediatek/clk-mt8189-dbgao.c | 98 +++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 8eba45f05968..635b0109ec07 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -839,6 +839,16 @@ config COMMON_CLK_MT8189_BUS
 	  MT8189 chipset, ensuring that all bus-related components receive the
 	  correct clock signals for optimal performance.
 
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
index aabfb42cb1b2..6ab6df7ebf2a 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
 				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
+obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-dbgao.c b/drivers/clk/mediatek/clk-mt8189-dbgao.c
new file mode 100644
index 000000000000..40307bdc93eb
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-dbgao.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025-2026 MediaTek Inc.
+ *                    Qiqi Wang <qiqi.wang@mediatek.com>
+ *                    Irving-CH Lin <irving-ch.lin@mediatek.com>
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
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
+module_platform_driver(clk_mt8189_dbgao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 dbgao system clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0


