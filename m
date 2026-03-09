Return-Path: <netdev+bounces-265505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J14DzC5rmlIIQIAu9opvQ
	(envelope-from <netdev+bounces-265505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:12:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D122D2388E0
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 814CF30DACE2
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B03ACEEC;
	Mon,  9 Mar 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r0CcnQf1"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FF3A9D80;
	Mon,  9 Mar 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057929; cv=none; b=TTbqAPk0sdKrMDf10clCQPDe8hgGTALoQoZQqHLuj/EtrVnOMrEHv+PIW1/6mS8aEwm31znDKi2uKJVHhRTRTmvTR/L0ylRgIHCEyhFLPgl3Tc8TI7L2sec9cUHvrWc8eRWyALhLiGpqR9CGMG+6mETSsPellftXfDHXbyTiF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057929; c=relaxed/simple;
	bh=fORmmTustIEvK1D+Z67Y0PCbOQj2Feyt26KvZOmyoqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKCr4/ucR9WVB/EFL15K2x/8pJ3uAuIBQSwPJSeuNpE8CTYXlSLg7snB+5SK9p4LZem/DTqHSYFpQBKOVwHD4Hyz05O/zBCWSmAP4RYILSfHO52a3k3HRqyhoGW4dH8NFSJHqJmZ2VqaQRc9gODI77pDZY5z0XPaD2TBtnXMqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r0CcnQf1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3df194141bb011f1a02d4725871ece0b-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FuTvFKC1sI0vZzVUhcV8U+V8J4mnw3QxKN4UV/VOdpY=;
	b=r0CcnQf1/wNTEd0DRVJZFyrffnyVv+pogk/Qyp6jwVdMNoCFxUlhOLLCxqFsyAaCqJXlIOoSP4rC/PNPuo90wvJZQV7cC4bTKS9RkyWmbh44zhKeW6lQYB6znCRWthURaLvurh63mhMyT9FAy+sDdSF/OV/SHmIX3gOnp53un9U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:59283dae-3a8a-4369-9483-ee2009d52322,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:3ea9b17b-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3df194141bb011f1a02d4725871ece0b-20260309
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1209547903; Mon, 09 Mar 2026 20:05:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 20:05:17 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Mar 2026 20:05:17 +0800
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
Subject: [PATCH v6 03/18] clk: mediatek: Add MT8189 apmixedsys clock support
Date: Mon, 9 Mar 2026 20:04:45 +0800
Message-ID: <20260309120512.3624804-4-irving-ch.lin@mediatek.com>
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
X-Rspamd-Queue-Id: D122D2388E0
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
	TAGGED_FROM(0.00)[bounces-265505-lists,netdev=lfdr.de];
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

Add support for the MT8189 apmixedsys clock controller, which provides
PLLs generated from SoC 26m.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                 |  13 ++
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 192 +++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2c09fd729bab..80813d7e02af 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -815,6 +815,19 @@ config COMMON_CLK_MT8188_WPESYS
 	help
 	  This driver supports MediaTek MT8188 Warp Engine clocks.
 
+config COMMON_CLK_MT8189
+	bool "Clock driver for MediaTek MT8189"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	select COMMON_CLK_MEDIATEK_FHCTL
+	default ARCH_MEDIATEK
+	help
+	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
+	  includes handling of all primary clock functions and features specific to the MT8189
+	  platform. Enabling this driver ensures that the system's clock functionality aligns
+	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
+	  clock speeds and power consumption.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d8736a060dbd..66577ccb9b93 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
new file mode 100644
index 000000000000..9c91b7fed87e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-fhctl.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+#define MT8189_PLLEN_OFS	0x70
+#define MT8189_INTEGER_BITS	8
+
+#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
+			_rstb_setclr_bit, _flags, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
+			_pcwbits) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.en_reg = MT8189_PLLEN_OFS,			\
+		.reg = _reg,					\
+		.pll_en_bit = _en_setclr_bit,			\
+		.rst_bar_mask = BIT(_rstb_setclr_bit),		\
+		.flags = _flags,				\
+		.fmax = MT8189_PLL_FMAX,			\
+		.fmin = MT8189_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8189_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
+		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
+		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
+		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
+		   23, HAVE_RST_BAR | PLL_AO,
+		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
+		   23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
+		   23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
+		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
+		   0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
+		   0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
+		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
+		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
+		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 9,
+		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c, 8,
+		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
+		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
+		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
+		   0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
+};
+
+#define FH(_pllid, _fhid, _offset) {				\
+		.data = {					\
+			.pll_id = _pllid,			\
+			.fh_id = _fhid,				\
+			.fh_ver = FHCTL_PLLFH_V2,		\
+			.fhx_offset = _offset,			\
+			.dds_mask = GENMASK(21, 0),		\
+			.slope0_value = 0x6003c97,		\
+			.slope1_value = 0x6003c97,		\
+			.sfstrx_en = BIT(2),			\
+			.frddsx_en = BIT(1),			\
+			.fhctlx_en = BIT(0),			\
+			.tgl_org = BIT(31),			\
+			.dvfs_tri = BIT(31),			\
+			.pcwchg = BIT(31),			\
+			.dt_val = 0x0,				\
+			.df_val = 0x9,				\
+			.updnlmt_shft = 16,			\
+			.msk_frddsx_dys = GENMASK(23, 20),	\
+			.msk_frddsx_dts = GENMASK(19, 16),	\
+		},						\
+	}
+
+static struct mtk_pllfh_data pllfhs[] = {
+	FH(CLK_APMIXED_ARMPLL_LL, 0, 0x003C),
+	FH(CLK_APMIXED_ARMPLL_BL, 1, 0x0050),
+	FH(CLK_APMIXED_CCIPLL, 2, 0x0064),
+	FH(CLK_APMIXED_MAINPLL, 3, 0x0078),
+	FH(CLK_APMIXED_MMPLL, 4, 0x008C),
+	FH(CLK_APMIXED_MFGPLL, 5, 0x00A0),
+	FH(CLK_APMIXED_EMIPLL, 6, 0x00B4),
+	FH(CLK_APMIXED_TVDPLL1, 7, 0x00C8),
+	FH(CLK_APMIXED_TVDPLL2, 8, 0x00DC),
+	FH(CLK_APMIXED_MSDCPLL, 9, 0x00F0),
+	FH(CLK_APMIXED_UFSPLL, 10, 0x0104),
+	FH(CLK_APMIXED_APUPLL, 11, 0x0118),
+	FH(CLK_APMIXED_APUPLL2, 12, 0x012c),
+};
+
+static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
+	{ .compatible = "mediatek,mt8189-apmixedsys" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_apmixed);
+
+static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
+{
+	int r;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	const u8 *fhctl_node = "mediatek,mt8189-fhctl";
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+
+	r = mtk_clk_register_pllfhs(&pdev->dev, apmixed_plls, ARRAY_SIZE(apmixed_plls),
+				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls),
+				clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static void clk_mt8189_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_pllfhs(apmixed_plls, ARRAY_SIZE(apmixed_plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static struct platform_driver clk_mt8189_apmixed_drv = {
+	.probe = clk_mt8189_apmixed_probe,
+	.remove = clk_mt8189_apmixed_remove,
+	.driver = {
+		.name = "clk-mt8189-apmixed",
+		.of_match_table = of_match_clk_mt8189_apmixed,
+	},
+};
+
+module_platform_driver(clk_mt8189_apmixed_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 apmixed clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


