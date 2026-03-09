Return-Path: <netdev+bounces-265510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPpAKIW4rmlIIQIAu9opvQ
	(envelope-from <netdev+bounces-265510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:09:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217A52387E9
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BCC730374AE
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2693B3C1C;
	Mon,  9 Mar 2026 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qHH9Gj6v"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F03A783A;
	Mon,  9 Mar 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057932; cv=none; b=S4FNr3A1a4wm3lNSIsuOPC0oY4uMryeuE9ED5CeXDCbaTlYATUTFvNkAcPY6pfEBKA3D2TT8tp1rbElxWNJkJjSFzTP++CYEyWZwdbPjTemmaxlEVykfWBV13pO8OTBkPQY58Cfe4PCmHdJlOHBKmFeNqoEza9l4S2zHTzZ7+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057932; c=relaxed/simple;
	bh=kf+QZRLa5AeEXIenp7slqrEVXloDrPvNJ1hmMOgvD10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMfqKFYXAkhnVwUeuRcThQkiUpBa2ZGX2HTE7E6+e4c9F81P+YYJLOAsZ8OMgUO+wj2VoC9c3nvGeD1dnWBDk+3QRtZjUjwx/3jUsSZa0nf1osxBdEXSTVOSJyyi0t69uhbT1yW0DNoKZUfKHJ4N9Ana2ueg7Uc7Hixhc9diGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qHH9Gj6v; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3e5803981bb011f1a02d4725871ece0b-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wA/Xntp944BQZqWnFAFkf3Ai/FRmm57I5brb03Yf2Jg=;
	b=qHH9Gj6vMDtxCDT0qN4GwMCJ61qlXxjuCUp5LCfbBI/TQsqxkGmCVkWOI44c4KN1AFVyEE3IhEmSbisLbL+uYvVFlm4iN322M/QgO1PakiKU1cT8xIIyjbRSzX3Ekz3XhO3pYLQu5+GRlfVmKgduIRUitY7C02lTcNnttn8HRnI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:d7b886c8-068c-470b-880f-71a693fbe176,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:9dc66aea-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3e5803981bb011f1a02d4725871ece0b-20260309
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 128319964; Mon, 09 Mar 2026 20:05:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH v6 07/18] clk: mediatek: Add MT8189 bus clock support
Date: Mon, 9 Mar 2026 20:04:49 +0800
Message-ID: <20260309120512.3624804-8-irving-ch.lin@mediatek.com>
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
X-Rspamd-Queue-Id: 217A52387E9
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
	TAGGED_FROM(0.00)[bounces-265510-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid]
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 bus clock controller,
which provides clock gate control for infra/peri IPs
(such as spi, uart, msdc, flashif ...).

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  11 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8189-bus.c | 196 ++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 80813d7e02af..47172623f29f 100644
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
index 000000000000..c9b83fa98590
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-bus.c
@@ -0,0 +1,196 @@
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
+	GATE_IFRAO0(CLK_IFRAO_CQ_DMA_FPC, "ifrao_dma", "clk26m", 28),
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
+	GATE_PERAO0(CLK_PERAO_REF, "perao_ref", "clk26m", 27),
+	GATE_PERAO0(CLK_PERAO_I2C, "perao_i2c", "axi_peri_sel", 28),
+	GATE_PERAO0(CLK_PERAO_DMA_B, "perao_dma_b", "axi_peri_sel", 29),
+	/* PERAO1 */
+	GATE_PERAO1(CLK_PERAO_SSUSB0_REF, "perao_ssusb0_ref", "clk26m", 1),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_FRMCNT, "perao_ssusb0_frmcnt", "univpll_192m_d4", 2),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_SYS, "perao_ssusb0_sys", "usb_p0_sel", 4),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_XHCI, "perao_ssusb0_xhci", "ssusb_xhci_p0_sel", 5),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_F, "perao_ssusb0_f", "axi_peri_sel", 6),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_H, "perao_ssusb0_h", "axi_peri_sel", 7),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_REF, "perao_ssusb1_ref", "clk26m", 8),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_FRMCNT, "perao_ssusb1_frmcnt", "univpll_192m_d4", 9),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_SYS, "perao_ssusb1_sys", "usb_p1_sel", 11),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_XHCI, "perao_ssusb1_xhci", "ssusb_xhci_p1_sel", 12),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_F, "perao_ssusb1_f", "axi_peri_sel", 13),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_H, "perao_ssusb1_h", "axi_peri_sel", 14),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_REF, "perao_ssusb2_ref", "clk26m", 15),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_FRMCNT, "perao_ssusb2_frmcnt", "univpll_192m_d4", 16),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_SYS, "perao_ssusb2_sys", "usb_p2_sel", 18),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_XHCI, "perao_ssusb2_xhci", "ssusb_xhci_p2_sel", 19),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_F, "perao_ssusb2_f", "axi_peri_sel", 20),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_H, "perao_ssusb2_h", "axi_peri_sel", 21),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_REF, "perao_ssusb3_ref", "clk26m", 23),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_FRMCNT, "perao_ssusb3_frmcnt", "univpll_192m_d4", 24),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_SYS, "perao_ssusb3_sys", "usb_p3_sel", 26),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_XHCI, "perao_ssusb3_xhci", "ssusb_xhci_p3_sel", 27),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_F, "perao_ssusb3_f", "axi_peri_sel", 28),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_H, "perao_ssusb3_h", "axi_peri_sel", 29),
+	/* PERAO2 */
+	GATE_PERAO2(CLK_PERAO_SSUSB4_REF, "perao_ssusb4_ref", "clk26m", 0),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_FRMCNT, "perao_ssusb4_frmcnt", "univpll_192m_d4", 1),
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
+
+module_platform_driver(clk_mt8189_bus_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 bus/peripheral clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


