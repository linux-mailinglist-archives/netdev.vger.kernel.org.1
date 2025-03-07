Return-Path: <netdev+bounces-172765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43DAA55E7C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6841782B6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B721AE876;
	Fri,  7 Mar 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V6qXNzU1"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBB1A3148;
	Fri,  7 Mar 2025 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318376; cv=none; b=bxfQyqKRkNC2jXCfg6gndq5Qk402UpcqYBILIXAYwD9EMI/zzxIQBv0esK+fazv6Z3LD2dOHm1SoMuHmKWDeOhVasxpVZzXmUYUIIfCwljOccS6GdGXH2IzlElhfgVYLqrEG8V+pbe4oN2hLZNgV0ZjJkIDC6hG5LTgj2Oi6BbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318376; c=relaxed/simple;
	bh=bf3Cplv8LX6DBfjivymF07yp/EbceRzlZDIKzacweyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOubhrEnVuMJap2dURzqtbRbw0TElKxGyqyapMB2NUtcbd2t+7mSHsPxLW0fVyL8iFebgFa44MP/h4os+JrCJYLUSyzH0psCgS3zgN7C1qVy6DHOAR+dUFmN9JouzmHQb6pJgwPuEfH50kIeQiGWzNymXzFpXia48KWO0zSEBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V6qXNzU1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6b4773efb0411efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o/e4KW2pQeQ99Ykm78szc0RMNWR/dwVdm2VF3DviRDM=;
	b=V6qXNzU1qPkJKNgYuJQ9je1uTEWUIRtyVAuPRsyVLygXtp8ZUNOw0WPDKdSnYRpJGU+FY45YlDPhXdNK5FpADkrH8H5KIy+U0kpUE6YBfbHRohq5k/ROMTrBxTtcip352uV90lMnHykXu6Pmlm8zUHZ8Q6hjGCxYWcSV7MsbBdY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1ef8ff30-d950-4537-b486-a700d4b64930,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:8d6421ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6b4773efb0411efaae1fd9735fae912-20250307
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1841239013; Fri, 07 Mar 2025 11:32:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:45 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Guangjie Song
	<guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 13/26] clk: mediatek: Add MT8196 adsp clock support
Date: Fri, 7 Mar 2025 11:27:09 +0800
Message-ID: <20250307032942.10447-14-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307032942.10447-1-guangjie.song@mediatek.com>
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add MT8196 adsp clock controller which provides clock gate control for
Audio DSP.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Kconfig           |   7 +
 drivers/clk/mediatek/Makefile          |   1 +
 drivers/clk/mediatek/clk-mt8196-adsp.c | 291 +++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 1e0c6f177ecd..fe54dca0062e 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1010,6 +1010,13 @@ config COMMON_CLK_MT8196
 	help
 	  This driver supports MediaTek MT8196 basic clocks.
 
+config COMMON_CLK_MT8196_ADSP
+	tristate "Clock driver for MediaTek MT8196 adsp"
+	depends on COMMON_CLK_MT8196
+	default COMMON_CLK_MT8196
+	help
+	  This driver supports MediaTek MT8196 adsp clocks
+
 config COMMON_CLK_MT8365
 	tristate "Clock driver for MediaTek MT8365"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index c95e45356b78..c0d676930a80 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-apmixedsys_gp2.o \
 				   clk-mt8196-topckgen.o clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
 				   clk-mt8196-peri_ao.o
+obj-$(CONFIG_COMMON_CLK_MT8196_ADSP) += clk-mt8196-adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-adsp.c b/drivers/clk/mediatek/clk-mt8196-adsp.c
new file mode 100644
index 000000000000..8272fc481cb1
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-adsp.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Guangjie Song <guangjie.song@mediatek.com>
+ */
+#include <dt-bindings/clock/mt8196-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs afe0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs afe1_cg_regs = {
+	.set_ofs = 0x10,
+	.clr_ofs = 0x10,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs afe2_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+static const struct mtk_gate_regs afe3_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x8,
+};
+
+static const struct mtk_gate_regs afe4_cg_regs = {
+	.set_ofs = 0xc,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0xc,
+};
+
+#define GATE_AFE0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe0_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE0_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_AFE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe1_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE1_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_AFE2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe2_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE2_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_AFE3(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe3_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE3_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+#define GATE_AFE4(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe4_cg_regs,			\
+		.shift = _shift,			\
+		.flags = CLK_OPS_PARENT_ENABLE |	\
+			 CLK_IGNORE_UNUSED,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE4_V(_id, _name, _parent) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &cg_regs_dummy,		\
+		.ops = &mtk_clk_dummy_ops,	\
+	}
+
+static const struct mtk_gate afe_clks[] = {
+	/* AFE0 */
+	GATE_AFE0(CLK_AFE_PCM1, "afe_pcm1", "vlp_aud_clksq_ck", 13),
+	GATE_AFE0_V(CLK_AFE_PCM1_AFE, "afe_pcm1_afe", "afe_pcm1"),
+	GATE_AFE0(CLK_AFE_PCM0, "afe_pcm0", "vlp_aud_clksq_ck", 14),
+	GATE_AFE0_V(CLK_AFE_PCM0_AFE, "afe_pcm0_afe", "afe_pcm0"),
+	GATE_AFE0(CLK_AFE_CM2, "afe_cm2", "vlp_aud_clksq_ck", 16),
+	GATE_AFE0_V(CLK_AFE_CM2_AFE, "afe_cm2_afe", "afe_cm2"),
+	GATE_AFE0(CLK_AFE_CM1, "afe_cm1", "vlp_aud_clksq_ck", 17),
+	GATE_AFE0_V(CLK_AFE_CM1_AFE, "afe_cm1_afe", "afe_cm1"),
+	GATE_AFE0(CLK_AFE_CM0, "afe_cm0", "vlp_aud_clksq_ck", 18),
+	GATE_AFE0_V(CLK_AFE_CM0_AFE, "afe_cm0_afe", "afe_cm0"),
+	GATE_AFE0(CLK_AFE_STF, "afe_stf", "vlp_aud_clksq_ck", 19),
+	GATE_AFE0_V(CLK_AFE_STF_AFE, "afe_stf_afe", "afe_stf"),
+	GATE_AFE0(CLK_AFE_HW_GAIN23, "afe_hw_gain23", "vlp_aud_clksq_ck", 20),
+	GATE_AFE0_V(CLK_AFE_HW_GAIN23_AFE, "afe_hw_gain23_afe", "afe_hw_gain23"),
+	GATE_AFE0(CLK_AFE_HW_GAIN01, "afe_hw_gain01", "vlp_aud_clksq_ck", 21),
+	GATE_AFE0_V(CLK_AFE_HW_GAIN01_AFE, "afe_hw_gain01_afe", "afe_hw_gain01"),
+	GATE_AFE0(CLK_AFE_FM_I2S, "afe_fm_i2s", "vlp_aud_clksq_ck", 24),
+	GATE_AFE0_V(CLK_AFE_FM_I2S_AFE, "afe_fm_i2s_afe", "afe_fm_i2s"),
+	GATE_AFE0(CLK_AFE_MTKAIFV4, "afe_mtkaifv4", "vlp_aud_clksq_ck", 25),
+	GATE_AFE0_V(CLK_AFE_MTKAIFV4_AFE, "afe_mtkaifv4_afe", "afe_mtkaifv4"),
+	/* AFE1 */
+	GATE_AFE1(CLK_AFE_AUDIO_HOPPING, "afe_audio_hopping_ck", "vlp_aud_clksq_ck", 0),
+	GATE_AFE1_V(CLK_AFE_AUDIO_HOPPING_AFE, "afe_audio_hopping_ck_afe", "afe_audio_hopping_ck"),
+	GATE_AFE1(CLK_AFE_AUDIO_F26M, "afe_audio_f26m_ck", "vlp_aud_clksq_ck", 1),
+	GATE_AFE1_V(CLK_AFE_AUDIO_F26M_AFE, "afe_audio_f26m_ck_afe", "afe_audio_f26m_ck"),
+	GATE_AFE1(CLK_AFE_APLL1, "afe_apll1_ck", "ck_aud_1_ck", 2),
+	GATE_AFE1_V(CLK_AFE_APLL1_AFE, "afe_apll1_ck_afe", "afe_apll1_ck"),
+	GATE_AFE1(CLK_AFE_APLL2, "afe_apll2_ck", "ck_aud_2_ck", 3),
+	GATE_AFE1_V(CLK_AFE_APLL2_AFE, "afe_apll2_ck_afe", "afe_apll2_ck"),
+	GATE_AFE1(CLK_AFE_H208M, "afe_h208m_ck", "vlp_audio_h_ck", 4),
+	GATE_AFE1_V(CLK_AFE_H208M_AFE, "afe_h208m_ck_afe", "afe_h208m_ck"),
+	GATE_AFE1(CLK_AFE_APLL_TUNER2, "afe_apll_tuner2", "vlp_aud_engen2_ck", 12),
+	GATE_AFE1_V(CLK_AFE_APLL_TUNER2_AFE, "afe_apll_tuner2_afe", "afe_apll_tuner2"),
+	GATE_AFE1(CLK_AFE_APLL_TUNER1, "afe_apll_tuner1", "vlp_aud_engen1_ck", 13),
+	GATE_AFE1_V(CLK_AFE_APLL_TUNER1_AFE, "afe_apll_tuner1_afe", "afe_apll_tuner1"),
+	/* AFE2 */
+	GATE_AFE2(CLK_AFE_UL2_ADC_HIRES_TML, "afe_ul2_aht", "vlp_audio_h_ck", 12),
+	GATE_AFE2_V(CLK_AFE_UL2_ADC_HIRES_TML_AFE, "afe_ul2_aht_afe", "afe_ul2_aht"),
+	GATE_AFE2(CLK_AFE_UL2_ADC_HIRES, "afe_ul2_adc_hires", "vlp_audio_h_ck", 13),
+	GATE_AFE2_V(CLK_AFE_UL2_ADC_HIRES_AFE, "afe_ul2_adc_hires_afe", "afe_ul2_adc_hires"),
+	GATE_AFE2(CLK_AFE_UL2_TML, "afe_ul2_tml", "vlp_aud_clksq_ck", 14),
+	GATE_AFE2_V(CLK_AFE_UL2_TML_AFE, "afe_ul2_tml_afe", "afe_ul2_tml"),
+	GATE_AFE2(CLK_AFE_UL2_ADC, "afe_ul2_adc", "vlp_aud_clksq_ck", 15),
+	GATE_AFE2_V(CLK_AFE_UL2_ADC_AFE, "afe_ul2_adc_afe", "afe_ul2_adc"),
+	GATE_AFE2(CLK_AFE_UL1_ADC_HIRES_TML, "afe_ul1_aht", "vlp_audio_h_ck", 16),
+	GATE_AFE2_V(CLK_AFE_UL1_ADC_HIRES_TML_AFE, "afe_ul1_aht_afe", "afe_ul1_aht"),
+	GATE_AFE2(CLK_AFE_UL1_ADC_HIRES, "afe_ul1_adc_hires", "vlp_audio_h_ck", 17),
+	GATE_AFE2_V(CLK_AFE_UL1_ADC_HIRES_AFE, "afe_ul1_adc_hires_afe", "afe_ul1_adc_hires"),
+	GATE_AFE2(CLK_AFE_UL1_TML, "afe_ul1_tml", "vlp_aud_clksq_ck", 18),
+	GATE_AFE2_V(CLK_AFE_UL1_TML_AFE, "afe_ul1_tml_afe", "afe_ul1_tml"),
+	GATE_AFE2(CLK_AFE_UL1_ADC, "afe_ul1_adc", "vlp_aud_clksq_ck", 19),
+	GATE_AFE2_V(CLK_AFE_UL1_ADC_AFE, "afe_ul1_adc_afe", "afe_ul1_adc"),
+	GATE_AFE2(CLK_AFE_UL0_ADC_HIRES_TML, "afe_ul0_aht", "vlp_audio_h_ck", 20),
+	GATE_AFE2_V(CLK_AFE_UL0_ADC_HIRES_TML_AFE, "afe_ul0_aht_afe", "afe_ul0_aht"),
+	GATE_AFE2(CLK_AFE_UL0_ADC_HIRES, "afe_ul0_adc_hires", "vlp_audio_h_ck", 21),
+	GATE_AFE2_V(CLK_AFE_UL0_ADC_HIRES_AFE, "afe_ul0_adc_hires_afe", "afe_ul0_adc_hires"),
+	GATE_AFE2(CLK_AFE_UL0_TML, "afe_ul0_tml", "vlp_aud_clksq_ck", 22),
+	GATE_AFE2_V(CLK_AFE_UL0_TML_AFE, "afe_ul0_tml_afe", "afe_ul0_tml"),
+	GATE_AFE2(CLK_AFE_UL0_ADC, "afe_ul0_adc", "vlp_aud_clksq_ck", 23),
+	GATE_AFE2_V(CLK_AFE_UL0_ADC_AFE, "afe_ul0_adc_afe", "afe_ul0_adc"),
+	/* AFE3 */
+	GATE_AFE3(CLK_AFE_ETDM_IN6, "afe_etdm_in6", "vlp_aud_clksq_ck", 7),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN6_AFE, "afe_etdm_in6_afe", "afe_etdm_in6"),
+	GATE_AFE3(CLK_AFE_ETDM_IN5, "afe_etdm_in5", "vlp_aud_clksq_ck", 8),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN5_AFE, "afe_etdm_in5_afe", "afe_etdm_in5"),
+	GATE_AFE3(CLK_AFE_ETDM_IN4, "afe_etdm_in4", "vlp_aud_clksq_ck", 9),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN4_AFE, "afe_etdm_in4_afe", "afe_etdm_in4"),
+	GATE_AFE3(CLK_AFE_ETDM_IN3, "afe_etdm_in3", "vlp_aud_clksq_ck", 10),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN3_AFE, "afe_etdm_in3_afe", "afe_etdm_in3"),
+	GATE_AFE3(CLK_AFE_ETDM_IN2, "afe_etdm_in2", "vlp_aud_clksq_ck", 11),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN2_AFE, "afe_etdm_in2_afe", "afe_etdm_in2"),
+	GATE_AFE3(CLK_AFE_ETDM_IN1, "afe_etdm_in1", "vlp_aud_clksq_ck", 12),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN1_AFE, "afe_etdm_in1_afe", "afe_etdm_in1"),
+	GATE_AFE3(CLK_AFE_ETDM_IN0, "afe_etdm_in0", "vlp_aud_clksq_ck", 13),
+	GATE_AFE3_V(CLK_AFE_ETDM_IN0_AFE, "afe_etdm_in0_afe", "afe_etdm_in0"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT6, "afe_etdm_out6", "vlp_aud_clksq_ck", 15),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT6_AFE, "afe_etdm_out6_afe", "afe_etdm_out6"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT5, "afe_etdm_out5", "vlp_aud_clksq_ck", 16),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT5_AFE, "afe_etdm_out5_afe", "afe_etdm_out5"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT4, "afe_etdm_out4", "vlp_aud_clksq_ck", 17),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT4_AFE, "afe_etdm_out4_afe", "afe_etdm_out4"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT3, "afe_etdm_out3", "vlp_aud_clksq_ck", 18),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT3_AFE, "afe_etdm_out3_afe", "afe_etdm_out3"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT2, "afe_etdm_out2", "vlp_aud_clksq_ck", 19),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT2_AFE, "afe_etdm_out2_afe", "afe_etdm_out2"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT1, "afe_etdm_out1", "vlp_aud_clksq_ck", 20),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT1_AFE, "afe_etdm_out1_afe", "afe_etdm_out1"),
+	GATE_AFE3(CLK_AFE_ETDM_OUT0, "afe_etdm_out0", "vlp_aud_clksq_ck", 21),
+	GATE_AFE3_V(CLK_AFE_ETDM_OUT0_AFE, "afe_etdm_out0_afe", "afe_etdm_out0"),
+	GATE_AFE3(CLK_AFE_TDM_OUT, "afe_tdm_out", "ck_aud_1_ck", 24),
+	GATE_AFE3_V(CLK_AFE_TDM_OUT_AFE, "afe_tdm_out_afe", "afe_tdm_out"),
+	/* AFE4 */
+	GATE_AFE4(CLK_AFE_GENERAL15_ASRC, "afe_general15_asrc", "vlp_aud_clksq_ck", 9),
+	GATE_AFE4_V(CLK_AFE_GENERAL15_ASRC_AFE, "afe_general15_asrc_afe", "afe_general15_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL14_ASRC, "afe_general14_asrc", "vlp_aud_clksq_ck", 10),
+	GATE_AFE4_V(CLK_AFE_GENERAL14_ASRC_AFE, "afe_general14_asrc_afe", "afe_general14_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL13_ASRC, "afe_general13_asrc", "vlp_aud_clksq_ck", 11),
+	GATE_AFE4_V(CLK_AFE_GENERAL13_ASRC_AFE, "afe_general13_asrc_afe", "afe_general13_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL12_ASRC, "afe_general12_asrc", "vlp_aud_clksq_ck", 12),
+	GATE_AFE4_V(CLK_AFE_GENERAL12_ASRC_AFE, "afe_general12_asrc_afe", "afe_general12_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL11_ASRC, "afe_general11_asrc", "vlp_aud_clksq_ck", 13),
+	GATE_AFE4_V(CLK_AFE_GENERAL11_ASRC_AFE, "afe_general11_asrc_afe", "afe_general11_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL10_ASRC, "afe_general10_asrc", "vlp_aud_clksq_ck", 14),
+	GATE_AFE4_V(CLK_AFE_GENERAL10_ASRC_AFE, "afe_general10_asrc_afe", "afe_general10_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL9_ASRC, "afe_general9_asrc", "vlp_aud_clksq_ck", 15),
+	GATE_AFE4_V(CLK_AFE_GENERAL9_ASRC_AFE, "afe_general9_asrc_afe", "afe_general9_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL8_ASRC, "afe_general8_asrc", "vlp_aud_clksq_ck", 16),
+	GATE_AFE4_V(CLK_AFE_GENERAL8_ASRC_AFE, "afe_general8_asrc_afe", "afe_general8_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL7_ASRC, "afe_general7_asrc", "vlp_aud_clksq_ck", 17),
+	GATE_AFE4_V(CLK_AFE_GENERAL7_ASRC_AFE, "afe_general7_asrc_afe", "afe_general7_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL6_ASRC, "afe_general6_asrc", "vlp_aud_clksq_ck", 18),
+	GATE_AFE4_V(CLK_AFE_GENERAL6_ASRC_AFE, "afe_general6_asrc_afe", "afe_general6_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL5_ASRC, "afe_general5_asrc", "vlp_aud_clksq_ck", 19),
+	GATE_AFE4_V(CLK_AFE_GENERAL5_ASRC_AFE, "afe_general5_asrc_afe", "afe_general5_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL4_ASRC, "afe_general4_asrc", "vlp_aud_clksq_ck", 20),
+	GATE_AFE4_V(CLK_AFE_GENERAL4_ASRC_AFE, "afe_general4_asrc_afe", "afe_general4_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL3_ASRC, "afe_general3_asrc", "vlp_aud_clksq_ck", 21),
+	GATE_AFE4_V(CLK_AFE_GENERAL3_ASRC_AFE, "afe_general3_asrc_afe", "afe_general3_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL2_ASRC, "afe_general2_asrc", "vlp_aud_clksq_ck", 22),
+	GATE_AFE4_V(CLK_AFE_GENERAL2_ASRC_AFE, "afe_general2_asrc_afe", "afe_general2_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL1_ASRC, "afe_general1_asrc", "vlp_aud_clksq_ck", 23),
+	GATE_AFE4_V(CLK_AFE_GENERAL1_ASRC_AFE, "afe_general1_asrc_afe", "afe_general1_asrc"),
+	GATE_AFE4(CLK_AFE_GENERAL0_ASRC, "afe_general0_asrc", "vlp_aud_clksq_ck", 24),
+	GATE_AFE4_V(CLK_AFE_GENERAL0_ASRC_AFE, "afe_general0_asrc_afe", "afe_general0_asrc"),
+	GATE_AFE4(CLK_AFE_CONNSYS_I2S_ASRC, "afe_connsys_i2s_asrc", "vlp_aud_clksq_ck", 25),
+	GATE_AFE4_V(CLK_AFE_CONNSYS_I2S_ASRC_AFE, "afe_connsys_i2s_asrc_afe", "afe_connsys_i2s_asrc"),
+};
+
+static const struct mtk_clk_desc afe_mcd = {
+	.clks = afe_clks,
+	.num_clks = ARRAY_SIZE(afe_clks),
+	.need_runtime_pm = true,
+};
+
+static const struct of_device_id of_match_clk_mt8196_adsp[] = {
+	{ .compatible = "mediatek,mt8196-audiosys", .data = &afe_mcd, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_adsp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8196-adsp",
+		.of_match_table = of_match_clk_mt8196_adsp,
+	},
+};
+
+module_platform_driver(clk_mt8196_adsp_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


