Return-Path: <netdev+bounces-303661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQq1LNYXRWp36woAu9opvQ
	(envelope-from <netdev+bounces-303661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:36:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7906EE31A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:36:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b="Fed/GUOy";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303661-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEF63285798
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558E748C8B2;
	Wed,  1 Jul 2026 13:11:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C24921AD;
	Wed,  1 Jul 2026 13:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911495; cv=none; b=KHjOTQP80i793xdgxcyDp76vZSIIILrYXEvgg1rPYxaO5UA2JhmsWOXhFarOzrCp/Lzo/sH+sjcKrUTKpETu5pGdNMYIgbg66if0s4dC7pJT3rWqtkLA/69fcPd6JPwB5Lkw3uzlV74OkhuunqZzBgaW/sqOjQIhuxHxKHE/9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911495; c=relaxed/simple;
	bh=VizwCM+hDplfjmbntbcucyABDJKY5/A9WedcG2u+Zo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptkWVFcprC7NP3wFcJOK6ty7mCI/HP12qYHggHvrQlG9G0UY7ejRh4vJlhCR2fDzqiBy554vAf/AJNTVwr8Bl+GP9aXUC/W0BaHZTydmdrRSNwL4ODwrd1o5mYshY5qFCq4rhQRImNW2XPuyVhw8L4Y2dUuffFBbyOJ+I/ejOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fed/GUOy; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782911491;
	bh=VizwCM+hDplfjmbntbcucyABDJKY5/A9WedcG2u+Zo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fed/GUOyze5k3fUCn4BXeVCo0A2yhZdZuNiaZ3661DY7R9DX5N2dnYznzCnV/iAYy
	 0mq4ROJO72nEyfoPjSGXna4Qk07aVYc2iBx2xKigb398fIowGVsCDvx4MENoAhP/5e
	 MHjBoHbqfX3EC4QhmJV5KTCuix1lgwt4U7fJiWcG2JCoK8G5ji3/qYshLUfivUWCmZ
	 SQkRXEDehyYAdlPqm8uhJhYZeTE9HwfydZz9dlup6qjcA4Amz/Wqzq9olVc292QIao
	 U0iEJv+r560thhAEC8ndKfiQPEl9CFpzZSYMtdlINpgwN8sLNNpW8TCrhAKA8GRClN
	 M1N03a0Y7xJ3A==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FE3017E35D6;
	Wed,  1 Jul 2026 15:11:30 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 15:11:15 +0200
Subject: [PATCH 10/15] clk: mediatek: Add MT8189 bus clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8189-clocks-system-base-v1-10-2b048feea50a@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782911477; l=12220;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=VizwCM+hDplfjmbntbcucyABDJKY5/A9WedcG2u+Zo0=;
 b=aDaNkcXLNx5UrSDorWgbdrsMZ6Sp3CpSXujBUt6q4MpXX9mN1FMIaXZP4P7ycH06Jj8dRCJue
 2m+recml6e4D08cC2F83gcMzmRzKN00L5kLZ7krdywhvIXRyNnjyrOA
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303661-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,collabora.com:from_mime,mediatek.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B7906EE31A

Add support for the MT8189 bus clock controller,
which provides clock gate control for infra/peri IPs
(such as spi, uart, msdc, flashif ...).

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |  11 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8189-bus.c | 200 ++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index f67dfb6cd019..8eba45f05968 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -828,6 +828,17 @@ config COMMON_CLK_MT8189
 	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
 	  clock speeds and power consumption.
 
+config COMMON_CLK_MT8189_BUS
+	tristate "Clock driver for MediaTek MT8189 bus"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this configuration option to support the clock framework for
+	  MediaTek MT8189 SoC bus clocks. It includes the necessary clock
+	  management for bus-related peripherals and interconnects within the
+	  MT8189 chipset, ensuring that all bus-related components receive the
+	  correct clock signals for optimal performance.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d9279b237b7b..aabfb42cb1b2 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
 				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
+obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-bus.c b/drivers/clk/mediatek/clk-mt8189-bus.c
new file mode 100644
index 000000000000..494f25e85d11
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-bus.c
@@ -0,0 +1,200 @@
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
+static const struct mtk_gate_regs ifrao0_cg_regs = {
+	.set_ofs = 0x80,
+	.clr_ofs = 0x84,
+	.sta_ofs = 0x90,
+};
+
+static const struct mtk_gate_regs ifrao1_cg_regs = {
+	.set_ofs = 0x88,
+	.clr_ofs = 0x8c,
+	.sta_ofs = 0x94,
+};
+
+static const struct mtk_gate_regs ifrao2_cg_regs = {
+	.set_ofs = 0xa4,
+	.clr_ofs = 0xa8,
+	.sta_ofs = 0xac,
+};
+
+#define GATE_IFRAO0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &ifrao0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_IFRAO1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &ifrao1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_IFRAO2(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &ifrao2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ifrao_clks[] = {
+	/* IFRAO0 */
+	GATE_IFRAO0(CLK_IFRAO_CQ_DMA_FPC, "ifrao_dma", "ap2con", 28),
+	/* IFRAO1 */
+	GATE_IFRAO1(CLK_IFRAO_DEBUGSYS, "ifrao_debugsys", "axi_sel", 24),
+	GATE_IFRAO1(CLK_IFRAO_DBG_TRACE, "ifrao_dbg_trace", "axi_sel", 29),
+	/* IFRAO2 */
+	GATE_IFRAO2(CLK_IFRAO_CQ_DMA, "ifrao_cq_dma", "axi_sel", 27),
+};
+
+static const struct mtk_clk_desc ifrao_mcd = {
+	.clks = ifrao_clks,
+	.num_clks = ARRAY_SIZE(ifrao_clks),
+};
+
+static const struct mtk_gate_regs perao0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs perao1_cg_regs = {
+	.set_ofs = 0x2c,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x14,
+};
+
+static const struct mtk_gate_regs perao2_cg_regs = {
+	.set_ofs = 0x34,
+	.clr_ofs = 0x38,
+	.sta_ofs = 0x18,
+};
+
+#define GATE_PERAO0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &perao0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_PERAO1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &perao1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_PERAO2(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &perao2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate perao_clks[] = {
+	/* PERAO0 */
+	GATE_PERAO0(CLK_PERAO_UART0, "perao_uart0", "uart_sel", 0),
+	GATE_PERAO0(CLK_PERAO_UART1, "perao_uart1", "uart_sel", 1),
+	GATE_PERAO0(CLK_PERAO_UART2, "perao_uart2", "uart_sel", 2),
+	GATE_PERAO0(CLK_PERAO_UART3, "perao_uart3", "uart_sel", 3),
+	GATE_PERAO0(CLK_PERAO_PWM_H, "perao_pwm_h", "axi_peri_sel", 4),
+	GATE_PERAO0(CLK_PERAO_PWM_B, "perao_pwm_b", "pwm_sel", 5),
+	GATE_PERAO0(CLK_PERAO_PWM_FB1, "perao_pwm_fb1", "pwm_sel", 6),
+	GATE_PERAO0(CLK_PERAO_PWM_FB2, "perao_pwm_fb2", "pwm_sel", 7),
+	GATE_PERAO0(CLK_PERAO_PWM_FB3, "perao_pwm_fb3", "pwm_sel", 8),
+	GATE_PERAO0(CLK_PERAO_PWM_FB4, "perao_pwm_fb4", "pwm_sel", 9),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM0, "perao_disp_pwm0", "disp_pwm_sel", 10),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM1, "perao_disp_pwm1", "disp_pwm_sel", 11),
+	GATE_PERAO0(CLK_PERAO_SPI0_B, "perao_spi0_b", "spi0_sel", 12),
+	GATE_PERAO0(CLK_PERAO_SPI1_B, "perao_spi1_b", "spi1_sel", 13),
+	GATE_PERAO0(CLK_PERAO_SPI2_B, "perao_spi2_b", "spi2_sel", 14),
+	GATE_PERAO0(CLK_PERAO_SPI3_B, "perao_spi3_b", "spi3_sel", 15),
+	GATE_PERAO0(CLK_PERAO_SPI4_B, "perao_spi4_b", "spi4_sel", 16),
+	GATE_PERAO0(CLK_PERAO_SPI5_B, "perao_spi5_b", "spi5_sel", 17),
+	GATE_PERAO0(CLK_PERAO_SPI0_H, "perao_spi0_h", "axi_peri_sel", 18),
+	GATE_PERAO0(CLK_PERAO_SPI1_H, "perao_spi1_h", "axi_peri_sel", 19),
+	GATE_PERAO0(CLK_PERAO_SPI2_H, "perao_spi2_h", "axi_peri_sel", 20),
+	GATE_PERAO0(CLK_PERAO_SPI3_H, "perao_spi3_h", "axi_peri_sel", 21),
+	GATE_PERAO0(CLK_PERAO_SPI4_H, "perao_spi4_h", "axi_peri_sel", 22),
+	GATE_PERAO0(CLK_PERAO_SPI5_H, "perao_spi5_h", "axi_peri_sel", 23),
+	GATE_PERAO0(CLK_PERAO_AXI, "perao_axi", "mem_sub_peri_sel", 24),
+	GATE_PERAO0(CLK_PERAO_AHB_APB, "perao_ahb_apb", "axi_peri_sel", 25),
+	GATE_PERAO0(CLK_PERAO_TL, "perao_tl", "pcie_mac_tl_sel", 26),
+	GATE_PERAO0(CLK_PERAO_REF, "perao_ref", "pcie_f26m", 27),
+	GATE_PERAO0(CLK_PERAO_I2C, "perao_i2c", "axi_peri_sel", 28),
+	GATE_PERAO0(CLK_PERAO_DMA_B, "perao_dma_b", "axi_peri_sel", 29),
+	/* PERAO1 */
+	GATE_PERAO1(CLK_PERAO_SSUSB0_REF, "perao_ssusb0_ref", "usb2_26m_p0_en", 1),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_FRMCNT, "perao_ssusb0_frmcnt", "fmcnt_p0_en", 2),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_SYS, "perao_ssusb0_sys", "usb_p0_sel", 4),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_XHCI, "perao_ssusb0_xhci", "ssusb_xhci_p0_sel", 5),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_F, "perao_ssusb0_f", "axi_peri_sel", 6),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_H, "perao_ssusb0_h", "axi_peri_sel", 7),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_REF, "perao_ssusb1_ref", "usb2_26m_p1_en", 8),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_FRMCNT, "perao_ssusb1_frmcnt", "fmcnt_p1_en", 9),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_SYS, "perao_ssusb1_sys", "usb_p1_sel", 11),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_XHCI, "perao_ssusb1_xhci", "ssusb_xhci_p1_sel", 12),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_F, "perao_ssusb1_f", "axi_peri_sel", 13),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_H, "perao_ssusb1_h", "axi_peri_sel", 14),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_REF, "perao_ssusb2_ref", "usb2_26m_p2_en", 15),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_FRMCNT, "perao_ssusb2_frmcnt", "fmcnt_p2_en", 16),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_SYS, "perao_ssusb2_sys", "usb_p2_sel", 18),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_XHCI, "perao_ssusb2_xhci", "ssusb_xhci_p2_sel", 19),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_F, "perao_ssusb2_f", "axi_peri_sel", 20),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_H, "perao_ssusb2_h", "axi_peri_sel", 21),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_REF, "perao_ssusb3_ref", "usb2_26m_p3_en", 23),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_FRMCNT, "perao_ssusb3_frmcnt", "fmcnt_p3_en", 24),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_SYS, "perao_ssusb3_sys", "usb_p3_sel", 26),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_XHCI, "perao_ssusb3_xhci", "ssusb_xhci_p3_sel", 27),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_F, "perao_ssusb3_f", "axi_peri_sel", 28),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_H, "perao_ssusb3_h", "axi_peri_sel", 29),
+	/* PERAO2 */
+	GATE_PERAO2(CLK_PERAO_SSUSB4_REF, "perao_ssusb4_ref", "usb2_26m_p4_en", 0),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_FRMCNT, "perao_ssusb4_frmcnt", "fmcnt_p4_en", 1),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_SYS, "perao_ssusb4_sys", "usb_p4_sel", 3),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_XHCI, "perao_ssusb4_xhci", "ssusb_xhci_p4_sel", 4),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_F, "perao_ssusb4_f", "axi_peri_sel", 5),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_H, "perao_ssusb4_h", "axi_peri_sel", 6),
+	GATE_PERAO2(CLK_PERAO_MSDC0, "perao_msdc0", "msdc50_0_sel", 7),
+	GATE_PERAO2(CLK_PERAO_MSDC0_H, "perao_msdc0_h", "msdc5hclk_sel", 8),
+	GATE_PERAO2(CLK_PERAO_MSDC0_FAES, "perao_msdc0_faes", "aes_msdcfde_sel", 9),
+	GATE_PERAO2(CLK_PERAO_MSDC0_MST_F, "perao_msdc0_mst_f", "axi_peri_sel", 10),
+	GATE_PERAO2(CLK_PERAO_MSDC0_SLV_H, "perao_msdc0_slv_h", "axi_peri_sel", 11),
+	GATE_PERAO2(CLK_PERAO_MSDC1, "perao_msdc1", "msdc30_1_sel", 12),
+	GATE_PERAO2(CLK_PERAO_MSDC1_H, "perao_msdc1_h", "msdc30_1_h_sel", 13),
+	GATE_PERAO2(CLK_PERAO_MSDC1_MST_F, "perao_msdc1_mst_f", "axi_peri_sel", 14),
+	GATE_PERAO2(CLK_PERAO_MSDC1_SLV_H, "perao_msdc1_slv_h", "axi_peri_sel", 15),
+	GATE_PERAO2(CLK_PERAO_MSDC2, "perao_msdc2", "msdc30_2_sel", 16),
+	GATE_PERAO2(CLK_PERAO_MSDC2_H, "perao_msdc2_h", "msdc30_2_h_sel", 17),
+	GATE_PERAO2(CLK_PERAO_MSDC2_MST_F, "perao_msdc2_mst_f", "axi_peri_sel", 18),
+	GATE_PERAO2(CLK_PERAO_MSDC2_SLV_H, "perao_msdc2_slv_h", "axi_peri_sel", 19),
+	GATE_PERAO2(CLK_PERAO_SFLASH, "perao_sflash", "sflash_sel", 20),
+	GATE_PERAO2(CLK_PERAO_SFLASH_F, "perao_sflash_f", "axi_peri_sel", 21),
+	GATE_PERAO2(CLK_PERAO_SFLASH_H, "perao_sflash_h", "axi_peri_sel", 22),
+	GATE_PERAO2(CLK_PERAO_SFLASH_P, "perao_sflash_p", "axi_peri_sel", 23),
+	GATE_PERAO2(CLK_PERAO_AUDIO0, "perao_audio0", "axi_peri_sel", 24),
+	GATE_PERAO2(CLK_PERAO_AUDIO1, "perao_audio1", "axi_peri_sel", 25),
+	GATE_PERAO2(CLK_PERAO_AUDIO2, "perao_audio2", "aud_intbus_sel", 26),
+	GATE_PERAO2(CLK_PERAO_AUXADC_26M, "perao_auxadc_26m", "clk26m", 27),
+};
+
+static const struct mtk_clk_desc perao_mcd = {
+	.clks = perao_clks,
+	.num_clks = ARRAY_SIZE(perao_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_bus[] = {
+	{ .compatible = "mediatek,mt8189-infra-ao", .data = &ifrao_mcd },
+	{ .compatible = "mediatek,mt8189-peri-ao", .data = &perao_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_bus);
+
+static struct platform_driver clk_mt8189_bus_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-bus",
+		.of_match_table = of_match_clk_mt8189_bus,
+	},
+};
+module_platform_driver(clk_mt8189_bus_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 bus/peripheral clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0


