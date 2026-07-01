Return-Path: <netdev+bounces-303666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y/z7C2MbRWpx7AoAu9opvQ
	(envelope-from <netdev+bounces-303666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63E6EE5B9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:51:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=A8G3LMPV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303666-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3573F32B9F67
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24D4A2E0D;
	Wed,  1 Jul 2026 13:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9604921A6;
	Wed,  1 Jul 2026 13:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911501; cv=none; b=spi3v0Xsj7LKZF6dPMlpNQKMEazZ0LuV/vmxLVGqgm/MB46sZvTTQTgyRB6M/jp8Pl/Ac5GcCvU2tsjphvDi24BoTq10DurXukgCe97j53pi4oJyR2PAen5efEug3Dve09LV0DXi6U8K0Lnw3TESDMt6tTC2DS5fFirTGSxO/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911501; c=relaxed/simple;
	bh=idHbCObBbdJ9+i/5PsaHs4jJfR5QMaovt3fy20RvFKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaGlqJ2NyDk7UEpVOS6rMFj7l4dyue/A3u5Ik8Nu5C3Ezhk3mQdhF04FmXWPSnOeqlCbudyq03zoAkusWlM3Ln7OHyO3sQMwF3eeFfacwkJA1C4V1PBl5Sj6kgPB5z+aj8CkRwoTB0DE5Cd2ic2b0PNe2SSEIYVe2t3jKpXCSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A8G3LMPV; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782911497;
	bh=idHbCObBbdJ9+i/5PsaHs4jJfR5QMaovt3fy20RvFKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A8G3LMPVgfNU+VELPcM5K7bBQGQ60qO+YL7b3zxADFdxEV1s3AUDO1X4OTJXb3ToJ
	 3S7HypWbw0kXx+c6oth3UfyYFwMYADZm3/v3e45m8TM+dr1DfP2yI8D1ywvLN+DCbp
	 m3Fl/Bvfve50j5TDfXgpgmjYJ2OP9bYWsDwpiStXmB6Lb+Ws9r4QD1+Tyulm8OyE8j
	 cNjS6hk6QwuPJUf92YTrILzi18mGqPghCmOTDkWc/wBvLuyTF6i3UB9AnuvF1ohz05
	 pYDR9wi47P1uTX7hMD7FgwYtSmMMtYsVsLNN4v9iSrr6lpBITMNpRa7wL6D1liH8H7
	 w9lIXA+gzfBZQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6DDF517E023C;
	Wed,  1 Jul 2026 15:11:36 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 15:11:20 +0200
Subject: [PATCH 15/15] clk: mediatek: Add MT8189 ufs clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8189-clocks-system-base-v1-15-2b048feea50a@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782911477; l=7242;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=idHbCObBbdJ9+i/5PsaHs4jJfR5QMaovt3fy20RvFKI=;
 b=Zy+78vcrFuphfSl+9WpeEpPJln0BTwYXbVnQY9EdM4Q7DaahfqQrFVRHyYb7tGwbAzuGG4jvB
 HfyMJ2dHoT7CGiBIyXgubueLsjQV86bndpNQBfYX58X+z+ChDIvYCQ4
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
	TAGGED_FROM(0.00)[bounces-303666-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,vger.kernel.org:from_smtp,collabora.com:dkim,collabora.com:email,collabora.com:mid,collabora.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B63E6EE5B9

Add support for the MT8189 ufs clock controller,
which provides clock gate control for Universal Flash Storage.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |  12 +++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8189-ufs.c | 133 ++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 919a916f1f4f..34a270a377cc 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -882,6 +882,18 @@ config COMMON_CLK_MT8189_SCP
 	  management for SCP-related features, ensuring proper clock
 	  distribution and gating for power efficiency and functionality.
 
+config COMMON_CLK_MT8189_UFS
+	tristate "Clock driver for MediaTek MT8189 ufs"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the Universal Flash
+	  Storage (UFS) interface on MediaTek MT8189 SoCs. This includes
+	  clock sources, dividers, and gates that are specific to the UFS
+	  feature of the MT8189 platform. It is recommended to enable this
+	  option if the system includes a UFS device that relies on the MT8189
+	  SoC for clock management.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index a3a93a16b369..1aa9f4265225 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
 obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
+obj-$(CONFIG_COMMON_CLK_MT8189_UFS) += clk-mt8189-ufs.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-ufs.c b/drivers/clk/mediatek/clk-mt8189-ufs.c
new file mode 100644
index 000000000000..85afab04420f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-ufs.c
@@ -0,0 +1,133 @@
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
+#include <dt-bindings/reset/mediatek,mt8189-resets.h>
+
+#define MT8189_UFSCFG_AO_RST0_SET_OFFSET	0x48
+#define MT8189_UFSCFG_PDN_RST0_SET_OFFSET	0x48
+
+static const struct mtk_gate_regs ufscfg_ao_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_AO_REG(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &ufscfg_ao_reg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ufscfg_ao_reg_clks[] = {
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM,
+			   "ufscfg_ao_unipro_tx_sym", "clk26m", 1),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0,
+			   "ufscfg_ao_unipro_rx_sym0", "clk26m", 2),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1,
+			   "ufscfg_ao_unipro_rx_sym1", "clk26m", 3),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_SYS,
+			   "ufscfg_ao_unipro_sys", "ufs_sel", 4),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_SAP_CFG,
+			   "ufscfg_ao_u_sap_cfg", "clk26m", 5),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS,
+			   "ufscfg_ao_u_phy_ahb_s_bus", "axi_u_sel", 6),
+};
+
+static u16 ufscfg_ao_rst_ofs[] = {
+	MT8189_UFSCFG_AO_RST0_SET_OFFSET,
+};
+
+static u16 ufscfg_ao_rst_idx_map[] = {
+	[MT8189_UFSAO_RST_UFS_MPHY] = 8,
+};
+
+static const struct mtk_clk_rst_desc ufscfg_ao_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = ufscfg_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(ufscfg_ao_rst_ofs),
+	.rst_idx_map = ufscfg_ao_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(ufscfg_ao_rst_idx_map),
+};
+
+static const struct mtk_clk_desc ufscfg_ao_reg_mcd = {
+	.clks = ufscfg_ao_reg_clks,
+	.num_clks = ARRAY_SIZE(ufscfg_ao_reg_clks),
+	.rst_desc = &ufscfg_ao_rst_desc,
+};
+
+static const struct mtk_gate_regs ufscfg_pdn_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_PDN_REG(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &ufscfg_pdn_reg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ufscfg_pdn_reg_clks[] = {
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_UFS,
+			    "ufscfg_ufshci_ufs", "ufs_sel", 0),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_AES,
+			    "ufscfg_ufshci_aes", "aes_ufsfde_sel", 1),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AHB,
+			    "ufscfg_ufshci_u_ahb", "axi_u_sel", 3),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AXI,
+			    "ufscfg_ufshci_u_axi", "mem_sub_u_sel", 5),
+};
+
+static u16 ufscfg_pdn_rst_ofs[] = {
+	MT8189_UFSCFG_PDN_RST0_SET_OFFSET,
+};
+
+static u16 ufscfg_pdn_rst_idx_map[] = {
+	[MT8189_UFSPDN_RST_UFS_UNIPRO] = 0,
+	[MT8189_UFSPDN_RST_UFS_CRYPTO] = 1,
+	[MT8189_UFSPDN_RST_UFS_HCI] = 2,
+};
+
+static const struct mtk_clk_rst_desc ufscfg_pdn_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = ufscfg_pdn_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(ufscfg_pdn_rst_ofs),
+	.rst_idx_map = ufscfg_pdn_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(ufscfg_pdn_rst_idx_map),
+};
+
+static const struct mtk_clk_desc ufscfg_pdn_reg_mcd = {
+	.clks = ufscfg_pdn_reg_clks,
+	.num_clks = ARRAY_SIZE(ufscfg_pdn_reg_clks),
+	.rst_desc = &ufscfg_pdn_rst_desc,
+};
+
+static const struct of_device_id of_match_clk_mt8189_ufs[] = {
+	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = &ufscfg_ao_reg_mcd },
+	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = &ufscfg_pdn_reg_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_ufs);
+
+static struct platform_driver clk_mt8189_ufs_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-ufs",
+		.of_match_table = of_match_clk_mt8189_ufs,
+	},
+};
+module_platform_driver(clk_mt8189_ufs_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 ufs clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0


