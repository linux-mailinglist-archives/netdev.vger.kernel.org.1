Return-Path: <netdev+bounces-265506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLL8Cly4rmlIIQIAu9opvQ
	(envelope-from <netdev+bounces-265506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:09:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4F238793
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B0CC30338AA
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD93AE715;
	Mon,  9 Mar 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VCvcv/Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AA3A9633;
	Mon,  9 Mar 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057931; cv=none; b=W7skm99wVJ9fFRD3udUjnPANN9ImCepFjtuj27PMwD7c9ZqHlcccWHgRIPkhJHaZwSN1cVILSsngYMLqJRdkwAYOn5Z/9DSJXatPiWWJJUybI/O2xldUWIrKafRvPzCI+aUdLSWH7RHVG9XI2iuSlRD8qWK8Bhf1EMMfinZb9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057931; c=relaxed/simple;
	bh=Fu4Xs/s3ZnOMt/kK1Gnd/xFl4GdnJw0Te7gVPWXdFic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdK/0YAjjuWYpOo7yp6KGja6IcJNBJzOPjbUigH494r1iuSc6DyHnVHb+I19pbKf7MWhLJrc6zyIMnvPTBf61lK1gTebC7K6KLKlSQJtCKbnocGkooi/KPqP2c00FIkNLk37B5ARvwRauzhtcEMBkAN+wblUzw9AXu85WxfRZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VCvcv/Ix; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3f32cda21bb011f1a39cd589f645bc18-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8vZpSVSS3D0bXJgywFJDdgLjfmBvxYjDe/YSEZspGMM=;
	b=VCvcv/Ix0eIIcliCJzw7hI9/93CYSNl7AWHke4rj+PYKeJZOOuJ9VxZ67sgQosgeVprGIc8kAlDqEwe7M99Tzp8oTZb52zYIXadx5wvMjsRKaMyQywcPpoZ+cR9Z/bSOkKFkmZkFd4AFL/FpUfYcygSITLlizImGuVGM36Xymsg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:d9579134-9103-4251-ab9c-fe447e73137e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:701f6ff1-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f32cda21bb011f1a39cd589f645bc18-20260309
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 658092658; Mon, 09 Mar 2026 20:05:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 20:05:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Mar 2026 20:05:19 +0800
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
Subject: [PATCH v6 15/18] clk: mediatek: Add MT8189 dispsys clock support
Date: Mon, 9 Mar 2026 20:04:57 +0800
Message-ID: <20260309120512.3624804-16-irving-ch.lin@mediatek.com>
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
X-Rspamd-Queue-Id: DDB4F238793
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
	TAGGED_FROM(0.00)[bounces-265506-lists,netdev=lfdr.de];
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

Add support for the MT8189 dispsys clock controller,
which provides clock gate control for display system.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig              |  12 ++
 drivers/clk/mediatek/Makefile             |   1 +
 drivers/clk/mediatek/clk-mt8189-dispsys.c | 172 ++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dispsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index e2eb74d79cfd..cb1b8bc49033 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -917,6 +917,18 @@ config COMMON_CLK_MT8189_MFG
 	  the MT8189 chipset. Enabling this will allow the manufacturing mode of
 	  the chipset to function correctly with the appropriate clock settings.
 
+config COMMON_CLK_MT8189_MMSYS
+	tristate "Clock driver for MediaTek MT8189 mmsys"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock framework for MediaTek MT8189
+	  multimedia systems (mmsys). This driver is responsible for managing
+	  the clocks for various multimedia components within the SoC, such as
+	  video, audio, and image processing units. Enabling this option will
+	  ensure that these components receive the correct clock frequencies
+	  for proper operation.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 07f11760cf68..21a9e6264b84 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MMSYS) += clk-mt8189-dispsys.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-dispsys.c b/drivers/clk/mediatek/clk-mt8189-dispsys.c
new file mode 100644
index 000000000000..4c101cf66f91
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-dispsys.c
@@ -0,0 +1,172 @@
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
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x04,
+	.clr_ofs = 0x08,
+	.sta_ofs = 0x00,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x14,
+	.clr_ofs = 0x18,
+	.sta_ofs = 0x10,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_DISP_OVL0_4L, "mm_disp_ovl0_4l", "disp0_sel", 0),
+	GATE_MM0(CLK_MM_DISP_OVL1_4L, "mm_disp_ovl1_4l", "disp0_sel", 1),
+	GATE_MM0(CLK_MM_VPP_RSZ0, "mm_vpp_rsz0", "disp0_sel", 2),
+	GATE_MM0(CLK_MM_VPP_RSZ1, "mm_vpp_rsz1", "disp0_sel", 3),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "disp0_sel", 4),
+	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1", "disp0_sel", 5),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "disp0_sel", 6),
+	GATE_MM0(CLK_MM_DISP_COLOR1, "mm_disp_color1", "disp0_sel", 7),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "disp0_sel", 8),
+	GATE_MM0(CLK_MM_DISP_CCORR1, "mm_disp_ccorr1", "disp0_sel", 9),
+	GATE_MM0(CLK_MM_DISP_CCORR2, "mm_disp_ccorr2", "disp0_sel", 10),
+	GATE_MM0(CLK_MM_DISP_CCORR3, "mm_disp_ccorr3", "disp0_sel", 11),
+	GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "disp0_sel", 12),
+	GATE_MM0(CLK_MM_DISP_AAL1, "mm_disp_aal1", "disp0_sel", 13),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "disp0_sel", 14),
+	GATE_MM0(CLK_MM_DISP_GAMMA1, "mm_disp_gamma1", "disp0_sel", 15),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "disp0_sel", 16),
+	GATE_MM0(CLK_MM_DISP_DITHER1, "mm_disp_dither1", "disp0_sel", 17),
+	GATE_MM0(CLK_MM_DISP_DSC_WRAP0, "mm_disp_dsc_wrap0", "disp0_sel", 18),
+	GATE_MM0(CLK_MM_VPP_MERGE0, "mm_vpp_merge0", "disp0_sel", 19),
+	GATE_MM0(CLK_MMSYS_0_DISP_DVO, "mmsys_0_disp_dvo", "disp0_sel", 20),
+	GATE_MM0(CLK_MMSYS_0_DISP_DSI0, "mmsys_0_CLK0", "disp0_sel", 21),
+	GATE_MM0(CLK_MM_DP_INTF0, "mm_dp_intf0", "disp0_sel", 22),
+	GATE_MM0(CLK_MM_DPI0, "mm_dpi0", "disp0_sel", 23),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "disp0_sel", 24),
+	GATE_MM0(CLK_MM_DISP_WDMA1, "mm_disp_wdma1", "disp0_sel", 25),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0", "disp0_sel", 26),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG1, "mm_disp_fake_eng1", "disp0_sel", 27),
+	GATE_MM0(CLK_MM_SMI_LARB, "mm_smi_larb", "disp0_sel", 28),
+	GATE_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0", "disp0_sel", 29),
+	GATE_MM0(CLK_MM_DIPSYS_CONFIG, "mm_dipsys_config", "disp0_sel", 30),
+	GATE_MM0(CLK_MM_DUMMY, "mm_dummy", "disp0_sel", 31),
+	/* MM1 */
+	GATE_MM1(CLK_MMSYS_1_DISP_DSI0, "mmsys_1_CLK0", "dsi_occ_sel", 0),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER, "mmsys_1_lvds_encoder", "pll_dpix_sel", 1),
+	GATE_MM1(CLK_MMSYS_1_DPI0, "mmsys_1_dpi0", "pll_dpix_sel", 2),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO, "mmsys_1_disp_dvo", "edp_sel", 3),
+	GATE_MM1(CLK_MM_DP_INTF, "mm_dp_intf", "dp_sel", 4),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER_CTS, "mmsys_1_lvds_encoder_cts", "vdstx_dg_cts_sel", 5),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO_AVT, "mmsys_1_disp_dvo_avt", "edp_favt_sel", 6),
+};
+
+static const struct mtk_clk_desc mm_mcd = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
+
+static const struct mtk_gate_regs gce_d_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_GCE_D(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &gce_d_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate gce_d_clks[] = {
+	GATE_GCE_D(CLK_GCE_D_TOP, "gce_d_top", "mminfra_gce_d", 16),
+};
+
+static const struct mtk_clk_desc gce_d_mcd = {
+	.clks = gce_d_clks,
+	.num_clks = ARRAY_SIZE(gce_d_clks),
+};
+
+static const struct mtk_gate_regs gce_m_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_GCE_M(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &gce_m_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate gce_m_clks[] = {
+	GATE_GCE_M(CLK_GCE_M_TOP, "gce_m_top", "mminfra_gce_m", 16),
+};
+
+static const struct mtk_clk_desc gce_m_mcd = {
+	.clks = gce_m_clks,
+	.num_clks = ARRAY_SIZE(gce_m_clks),
+};
+
+static const struct mtk_gate_regs mminfra_config0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mminfra_config1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MMINFRA_CONFIG0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mminfra_config0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MMINFRA_CONFIG1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mminfra_config1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mminfra_config_clks[] = {
+	/* MMINFRA_CONFIG0 */
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_D, "mminfra_gce_d", "mminfra_sel", 0),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_M, "mminfra_gce_m", "mminfra_sel", 1),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_SMI, "mminfra_smi", "mminfra_sel", 2),
+	/* MMINFRA_CONFIG1 */
+	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, "mminfra_gce_26m", "mminfra_sel", 17),
+};
+
+static const struct mtk_clk_desc mminfra_config_mcd = {
+	.clks = mminfra_config_clks,
+	.num_clks = ARRAY_SIZE(mminfra_config_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_dispsys[] = {
+	{ .compatible = "mediatek,mt8189-dispsys", .data = &mm_mcd },
+	{ .compatible = "mediatek,mt8189-gce-d", .data = &gce_d_mcd },
+	{ .compatible = "mediatek,mt8189-gce-m", .data = &gce_m_mcd },
+	{ .compatible = "mediatek,mt8189-mm-infra", .data = &mminfra_config_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_dispsys);
+
+static struct platform_driver clk_mt8189_dispsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-dispsys",
+		.of_match_table = of_match_clk_mt8189_dispsys,
+	},
+};
+
+module_platform_driver(clk_mt8189_dispsys_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 display clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


