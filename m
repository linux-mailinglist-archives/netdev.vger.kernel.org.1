Return-Path: <netdev+bounces-172762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32AA55E6F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2543A189594F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42361A5B90;
	Fri,  7 Mar 2025 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DV5tIoyu"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5119D08F;
	Fri,  7 Mar 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318373; cv=none; b=eOUpvu6B+bnBgdYh4qM5PTwlru3X63pVIrseJ7/5NDcmUsFmx9gaVenBgh/xKLQhJsCspLTcvrjoaYjJp/YANsXaaf35sMtLiuhp+s839QATQ3KDy7OJ7Vs1cFfJJDDLOPF7WvxQMWMpkMDJN/tAhrq22teto3/7zCyeZy9Foa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318373; c=relaxed/simple;
	bh=4cyoCJ1/WWkJg8BajfTbRUfM993w/DKObB6yKT18/uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKKBKn6yPGMYnln6nFvlUd3oAAPPZ7yqjfTO8sntCQ7dVvrmWNy6qCl/GOcX7lV/4fTmDguNTfR+4JUfyOUaTFAyUDhez2k3RZjuAIW6lhFIMn9Bycnn6a+5y+xprvW7lO4ugrDAslnkpDWvvc627Ta8Gx7nb5DxYdyFeOVUfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DV5tIoyu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d50bde22fb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BDf5VD300wIwIN+uAC+xAuD6Ai9gQTbpTg2f8SjoaPU=;
	b=DV5tIoyuFSvmMXTZDeEdNuD0gymSsJzaavJT2J43pmEjg2WSlY+76vj9jwndNVnqDLoCkjVLgdTiaMgI5bfVCzyZHuWh1bAmzUSH8Xax/YhXI1pBUgDmEIks3eL6gWn5h5S93WOUl8Ml7mIm/Gb4I9kMoZZNFmQWC1PQAkcmV9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2e334439-1391-492f-ad07-b6085a5c3a25,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:1e6e108c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d50bde22fb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 137693419; Fri, 07 Mar 2025 11:32:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:43 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:42 +0800
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
Subject: [PATCH 10/26] clk: mediatek: Add MT8196 topckgen2 clock support
Date: Fri, 7 Mar 2025 11:27:06 +0800
Message-ID: <20250307032942.10447-11-guangjie.song@mediatek.com>
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

Add MT8196 topckgen2 clock controller which provides muxes and dividers
to handle variety clock selection in other IP blocks.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/clk/mediatek/Makefile               |   2 +-
 drivers/clk/mediatek/clk-mt8196-topckgen2.c | 701 ++++++++++++++++++++
 2 files changed, 702 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen2.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index cd6f42a6fd10..5c058b64ff56 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -151,7 +151,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-apmixedsys_gp2.o \
-				   clk-mt8196-topckgen.o
+				   clk-mt8196-topckgen.o clk-mt8196-topckgen2.o
 obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8196-topckgen2.c b/drivers/clk/mediatek/clk-mt8196-topckgen2.c
new file mode 100644
index 000000000000..ae858498db17
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8196-topckgen2.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Guangjie Song <guangjie.song@mediatek.com>
+ */
+#include <dt-bindings/clock/mt8196-clk.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+/* MUX SEL REG */
+#define CKSYS2_CLK_CFG_UPDATE		0x0004
+#define CKSYS2_CLK_CFG_0		0x0010
+#define CKSYS2_CLK_CFG_0_SET		0x0014
+#define CKSYS2_CLK_CFG_0_CLR		0x0018
+#define CKSYS2_CLK_CFG_1		0x0020
+#define CKSYS2_CLK_CFG_1_SET		0x0024
+#define CKSYS2_CLK_CFG_1_CLR		0x0028
+#define CKSYS2_CLK_CFG_2		0x0030
+#define CKSYS2_CLK_CFG_2_SET		0x0034
+#define CKSYS2_CLK_CFG_2_CLR		0x0038
+#define CKSYS2_CLK_CFG_3		0x0040
+#define CKSYS2_CLK_CFG_3_SET		0x0044
+#define CKSYS2_CLK_CFG_3_CLR		0x0048
+#define CKSYS2_CLK_CFG_4		0x0050
+#define CKSYS2_CLK_CFG_4_SET		0x0054
+#define CKSYS2_CLK_CFG_4_CLR		0x0058
+#define CKSYS2_CLK_CFG_5		0x0060
+#define CKSYS2_CLK_CFG_5_SET		0x0064
+#define CKSYS2_CLK_CFG_5_CLR		0x0068
+#define CKSYS2_CLK_CFG_6		0x0070
+#define CKSYS2_CLK_CFG_6_SET		0x0074
+#define CKSYS2_CLK_CFG_6_CLR		0x0078
+#define CKSYS2_CLK_FENC_STATUS_MON_0	0x0174
+
+/* MUX SHIFT */
+#define TOP_MUX_SENINF0_SHIFT		0
+#define TOP_MUX_SENINF1_SHIFT		1
+#define TOP_MUX_SENINF2_SHIFT		2
+#define TOP_MUX_SENINF3_SHIFT		3
+#define TOP_MUX_SENINF4_SHIFT		4
+#define TOP_MUX_SENINF5_SHIFT		5
+#define TOP_MUX_IMG1_SHIFT		6
+#define TOP_MUX_IPE_SHIFT		7
+#define TOP_MUX_CAM_SHIFT		8
+#define TOP_MUX_CAMTM_SHIFT		9
+#define TOP_MUX_DPE_SHIFT		10
+#define TOP_MUX_VDEC_SHIFT		11
+#define TOP_MUX_CCUSYS_SHIFT		12
+#define TOP_MUX_CCUTM_SHIFT		13
+#define TOP_MUX_VENC_SHIFT		14
+#define TOP_MUX_DVO_SHIFT		15
+#define TOP_MUX_DVO_FAVT_SHIFT		16
+#define TOP_MUX_DP1_SHIFT		17
+#define TOP_MUX_DP0_SHIFT		18
+#define TOP_MUX_DISP_SHIFT		19
+#define TOP_MUX_MDP_SHIFT		20
+#define TOP_MUX_MMINFRA_SHIFT		21
+#define TOP_MUX_MMINFRA_SNOC_SHIFT	22
+#define TOP_MUX_MMUP_SHIFT		23
+#define TOP_MUX_MMINFRA_AO_SHIFT	26
+
+/* HW Voter REG */
+#define VOTE_CG_30_SET		0x0058
+#define VOTE_CG_30_CLR		0x005c
+#define VOTE_CG_30_DONE		0x2c2c
+
+#define MM_VOTE_CG_30_SET	0x00f0
+#define MM_VOTE_CG_30_CLR	0x00f4
+#define MM_VOTE_CG_30_DONE	0x2c78
+#define MM_VOTE_CG_31_SET	0x00f8
+#define MM_VOTE_CG_31_CLR	0x00fc
+#define MM_VOTE_CG_31_DONE	0x2c7c
+#define MM_VOTE_CG_32_SET	0x0100
+#define MM_VOTE_CG_32_CLR	0x0104
+#define MM_VOTE_CG_32_DONE	0x2c80
+#define MM_VOTE_CG_33_SET	0x0108
+#define MM_VOTE_CG_33_CLR	0x010c
+#define MM_VOTE_CG_33_DONE	0x2c84
+#define MM_VOTE_CG_34_SET	0x0110
+#define MM_VOTE_CG_34_CLR	0x0114
+#define MM_VOTE_CG_34_DONE	0x2c88
+#define MM_VOTE_CG_35_SET	0x0118
+#define MM_VOTE_CG_35_CLR	0x011c
+#define MM_VOTE_CG_35_DONE	0x2c8c
+#define MM_VOTE_CG_36_SET	0x0120
+#define MM_VOTE_CG_36_CLR	0x0124
+#define MM_VOTE_CG_36_DONE	0x2c90
+#define MM_VOTE_MUX_UPDATE_31_0	0x0240
+
+static DEFINE_SPINLOCK(mt8196_clk_ck2_lock);
+
+static const struct mtk_fixed_factor ck2_divs[] = {
+	FACTOR(CLK_CK2_MAINPLL2_D2, "ck2_mainpll2_d2", "mainpll2", 1, 2),
+	FACTOR(CLK_CK2_MAINPLL2_D3, "ck2_mainpll2_d3", "mainpll2", 1, 3),
+	FACTOR(CLK_CK2_MAINPLL2_D4, "ck2_mainpll2_d4", "mainpll2", 1, 4),
+	FACTOR(CLK_CK2_MAINPLL2_D4_D2, "ck2_mainpll2_d4_d2", "mainpll2", 1, 8),
+	FACTOR(CLK_CK2_MAINPLL2_D4_D4, "ck2_mainpll2_d4_d4", "mainpll2", 1, 16),
+	FACTOR(CLK_CK2_MAINPLL2_D5, "ck2_mainpll2_d5", "mainpll2", 1, 5),
+	FACTOR(CLK_CK2_MAINPLL2_D5_D2, "ck2_mainpll2_d5_d2", "mainpll2", 1, 10),
+	FACTOR(CLK_CK2_MAINPLL2_D6, "ck2_mainpll2_d6", "mainpll2", 1, 6),
+	FACTOR(CLK_CK2_MAINPLL2_D6_D2, "ck2_mainpll2_d6_d2", "mainpll2", 1, 12),
+	FACTOR(CLK_CK2_MAINPLL2_D7, "ck2_mainpll2_d7", "mainpll2", 1, 7),
+	FACTOR(CLK_CK2_MAINPLL2_D7_D2, "ck2_mainpll2_d7_d2", "mainpll2", 1, 14),
+	FACTOR(CLK_CK2_MAINPLL2_D9, "ck2_mainpll2_d9", "mainpll2", 1, 9),
+	FACTOR(CLK_CK2_UNIVPLL2_D3, "ck2_univpll2_d3", "univpll2", 1, 3),
+	FACTOR(CLK_CK2_UNIVPLL2_D4, "ck2_univpll2_d4", "univpll2", 1, 4),
+	FACTOR(CLK_CK2_UNIVPLL2_D4_D2, "ck2_univpll2_d4_d2", "univpll2", 1, 8),
+	FACTOR(CLK_CK2_UNIVPLL2_D5, "ck2_univpll2_d5", "univpll2", 1, 5),
+	FACTOR(CLK_CK2_UNIVPLL2_D5_D2, "ck2_univpll2_d5_d2", "univpll2", 1, 10),
+	FACTOR(CLK_CK2_UNIVPLL2_D6, "ck2_univpll2_d6", "univpll2", 1, 6),
+	FACTOR(CLK_CK2_UNIVPLL2_D6_D2, "ck2_univpll2_d6_d2", "univpll2", 1, 12),
+	FACTOR(CLK_CK2_UNIVPLL2_D6_D4, "ck2_univpll2_d6_d4", "univpll2", 1, 24),
+	FACTOR(CLK_CK2_UNIVPLL2_D7, "ck2_univpll2_d7", "univpll2", 1, 7),
+	FACTOR(CLK_CK2_IMGPLL_D2, "ck2_imgpll_d2", "imgpll", 1, 2),
+	FACTOR(CLK_CK2_IMGPLL_D4, "ck2_imgpll_d4", "imgpll", 1, 4),
+	FACTOR(CLK_CK2_IMGPLL_D5, "ck2_imgpll_d5", "imgpll", 1, 5),
+	FACTOR(CLK_CK2_IMGPLL_D5_D2, "ck2_imgpll_d5_d2", "imgpll", 1, 10),
+	FACTOR(CLK_CK2_MMPLL2_D3, "ck2_mmpll2_d3", "mmpll2", 1, 3),
+	FACTOR(CLK_CK2_MMPLL2_D4, "ck2_mmpll2_d4", "mmpll2", 1, 4),
+	FACTOR(CLK_CK2_MMPLL2_D4_D2, "ck2_mmpll2_d4_d2", "mmpll2", 1, 8),
+	FACTOR(CLK_CK2_MMPLL2_D5, "ck2_mmpll2_d5", "mmpll2", 1, 5),
+	FACTOR(CLK_CK2_MMPLL2_D5_D2, "ck2_mmpll2_d5_d2", "mmpll2", 1, 10),
+	FACTOR(CLK_CK2_MMPLL2_D6, "ck2_mmpll2_d6", "mmpll2", 1, 6),
+	FACTOR(CLK_CK2_MMPLL2_D6_D2, "ck2_mmpll2_d6_d2", "mmpll2", 1, 12),
+	FACTOR(CLK_CK2_MMPLL2_D7, "ck2_mmpll2_d7", "mmpll2", 1, 7),
+	FACTOR(CLK_CK2_MMPLL2_D9, "ck2_mmpll2_d9", "mmpll2", 1, 9),
+	FACTOR(CLK_CK2_TVDPLL1_D4, "ck2_tvdpll1_d4", "tvdpll1", 1, 4),
+	FACTOR(CLK_CK2_TVDPLL1_D8, "ck2_tvdpll1_d8", "tvdpll1", 1, 8),
+	FACTOR(CLK_CK2_TVDPLL1_D16, "ck2_tvdpll1_d16", "tvdpll1", 1, 16),
+	FACTOR(CLK_CK2_TVDPLL2_D2, "ck2_tvdpll2_d2", "tvdpll2", 1, 2),
+	FACTOR(CLK_CK2_TVDPLL2_D4, "ck2_tvdpll2_d4", "tvdpll2", 1, 4),
+	FACTOR(CLK_CK2_TVDPLL2_D8, "ck2_tvdpll2_d8", "tvdpll2", 1, 8),
+	FACTOR(CLK_CK2_TVDPLL2_D16, "ck2_tvdpll2_d16", "tvdpll2", 92, 1473),
+	FACTOR(CLK_CK2_CCUSYS, "ck2_ccusys_ck", "ck2_ccusys_sel", 1, 1),
+	FACTOR(CLK_CK2_VENC, "ck2_venc_ck", "ck2_venc_sel", 1, 1),
+	FACTOR(CLK_CK2_MMINFRA, "ck2_mminfra_ck", "ck2_mminfra_sel", 1, 1),
+	FACTOR(CLK_CK2_IMG1, "ck2_img1_ck", "ck2_img1_sel", 1, 1),
+	FACTOR(CLK_CK2_IPE, "ck2_ipe_ck", "ck2_ipe_sel", 1, 1),
+	FACTOR(CLK_CK2_CAM, "ck2_cam_ck", "ck2_cam_sel", 1, 1),
+	FACTOR(CLK_CK2_CAMTM, "ck2_camtm_ck", "ck2_camtm_sel", 1, 1),
+	FACTOR(CLK_CK2_DPE, "ck2_dpe_ck", "ck2_dpe_sel", 1, 1),
+	FACTOR(CLK_CK2_VDEC, "ck2_vdec_ck", "ck2_vdec_sel", 1, 1),
+	FACTOR(CLK_CK2_DP1, "ck2_dp1_ck", "ck2_dp1_sel", 1, 1),
+	FACTOR(CLK_CK2_DP0, "ck2_dp0_ck", "ck2_dp0_sel", 1, 1),
+	FACTOR(CLK_CK2_DISP, "ck2_disp_ck", "ck2_disp_sel", 1, 1),
+	FACTOR(CLK_CK2_MDP, "ck2_mdp_ck", "ck2_mdp_sel", 1, 1),
+	FACTOR(CLK_CK2_AVS_IMG, "ck2_avs_img_ck", "ck_tck_26m_mx9_ck", 1, 1),
+	FACTOR(CLK_CK2_AVS_VDEC, "ck2_avs_vdec_ck", "ck_tck_26m_mx9_ck", 1, 1),
+	FACTOR(CLK_CK2_TVDPLL3_D2, "ck2_tvdpll3_d2", "tvdpll3", 1, 2),
+	FACTOR(CLK_CK2_TVDPLL3_D4, "ck2_tvdpll3_d4", "tvdpll3", 1, 4),
+	FACTOR(CLK_CK2_TVDPLL3_D8, "ck2_tvdpll3_d8", "tvdpll3", 1, 8),
+	FACTOR(CLK_CK2_TVDPLL3_D16, "ck2_tvdpll3_d16", "tvdpll3", 92, 1473),
+};
+
+static const char * const ck2_seninf0_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"ck2_univpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck_osc_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_univpll2_d5"
+};
+
+static const char * const ck2_seninf1_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"ck2_univpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck_osc_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_univpll2_d5"
+};
+
+static const char * const ck2_seninf2_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"ck2_univpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck_osc_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_univpll2_d5"
+};
+
+static const char * const ck2_seninf3_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"ck2_univpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck_osc_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_univpll2_d5"
+};
+
+static const char * const ck2_seninf4_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"ck2_univpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck_osc_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_univpll2_d5"
+};
+
+static const char * const ck2_seninf5_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d8",
+	"ck_osc_d5",
+	"ck_osc_d4",
+	"ck2_univpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck_osc_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_univpll2_d5"
+};
+
+static const char * const ck2_img1_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck2_mmpll2_d6_d2",
+	"ck_osc_d2",
+	"ck2_imgpll_d5_d2",
+	"ck2_mmpll2_d5_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_mmpll2_d5",
+	"ck2_univpll2_d4",
+	"ck2_imgpll_d4"
+};
+
+static const char * const ck2_ipe_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck_osc_d2",
+	"ck2_univpll2_d6",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_imgpll_d5",
+	"ck_mainpll_d4",
+	"ck2_mmpll2_d5",
+	"ck2_imgpll_d4"
+};
+
+static const char * const ck2_cam_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d10",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck_osc_d2",
+	"ck2_mmpll2_d5_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_univpll2_d7",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_mmpll2_d5",
+	"ck2_univpll2_d4",
+	"ck2_imgpll_d4",
+	"ck2_mmpll2_d4"
+};
+
+static const char * const ck2_camtm_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_univpll2_d6_d4",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck2_univpll2_d6_d2"
+};
+
+static const char * const ck2_dpe_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_mmpll2_d5_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_mmpll2_d5",
+	"ck2_imgpll_d4",
+	"ck2_mmpll2_d4"
+};
+
+static const char * const ck2_vdec_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_mainpll_d5_d2",
+	"ck2_mainpll2_d4_d4",
+	"ck2_mainpll2_d7_d2",
+	"ck2_mainpll2_d6_d2",
+	"ck2_mainpll2_d5_d2",
+	"ck2_mainpll2_d9",
+	"ck2_mainpll2_d4_d2",
+	"ck2_mainpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_univpll2_d6",
+	"ck2_mainpll2_d5",
+	"ck2_mainpll2_d4",
+	"ck2_imgpll_d2"
+};
+
+static const char * const ck2_ccusys_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck_osc_d2",
+	"ck2_mmpll2_d5_d2",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d7",
+	"ck2_univpll2_d6",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_mainpll2_d4",
+	"ck2_mainpll2_d3",
+	"ck2_univpll2_d3"
+};
+
+static const char * const ck2_ccutm_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_univpll2_d6_d4",
+	"ck_osc_d4",
+	"ck_osc_d3",
+	"ck2_univpll2_d6_d2"
+};
+
+static const char * const ck2_venc_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_mainpll2_d5_d2",
+	"ck2_univpll2_d5_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck2_mmpll2_d9",
+	"ck2_univpll2_d4_d2",
+	"ck2_mmpll2_d4_d2",
+	"ck2_mainpll2_d6",
+	"ck2_univpll2_d6",
+	"ck2_mainpll2_d5",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_mainpll2_d4",
+	"ck2_univpll2_d4",
+	"ck2_univpll2_d3"
+};
+
+static const char * const ck2_dp1_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_tvdpll2_d16",
+	"ck2_tvdpll2_d8",
+	"ck2_tvdpll2_d4",
+	"ck2_tvdpll2_d2"
+};
+
+static const char * const ck2_dp0_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_tvdpll1_d16",
+	"ck2_tvdpll1_d8",
+	"ck2_tvdpll1_d4",
+	"ck_tvdpll1_d2"
+};
+
+static const char * const ck2_disp_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_mainpll_d5_d2",
+	"ck_mainpll_d4_d2",
+	"ck_mainpll_d6",
+	"ck2_mainpll2_d5",
+	"ck2_mmpll2_d6",
+	"ck2_mainpll2_d4",
+	"ck2_univpll2_d4",
+	"ck2_mainpll2_d3"
+};
+
+static const char * const ck2_mdp_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_mainpll_d5_d2",
+	"ck2_mainpll2_d5_d2",
+	"ck2_mmpll2_d6_d2",
+	"ck2_mainpll2_d9",
+	"ck2_mainpll2_d4_d2",
+	"ck2_mainpll2_d7",
+	"ck2_mainpll2_d6",
+	"ck2_mainpll2_d5",
+	"ck2_mmpll2_d6",
+	"ck2_mainpll2_d4",
+	"ck2_univpll2_d4",
+	"ck2_mainpll2_d3"
+};
+
+static const char * const ck2_mminfra_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d4",
+	"ck_mainpll_d7_d2",
+	"ck_mainpll_d5_d2",
+	"ck_mainpll_d9",
+	"ck2_mmpll2_d6_d2",
+	"ck2_mainpll2_d4_d2",
+	"ck_mainpll_d6",
+	"ck2_univpll2_d6",
+	"ck2_mainpll2_d5",
+	"ck2_mmpll2_d6",
+	"ck2_univpll2_d5",
+	"ck2_mainpll2_d4",
+	"ck2_univpll2_d4",
+	"ck2_mainpll2_d3",
+	"ck2_univpll2_d3"
+};
+
+static const char * const ck2_mminfra_snoc_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d4",
+	"ck_mainpll_d7_d2",
+	"ck_mainpll_d9",
+	"ck_mainpll_d7",
+	"ck_mainpll_d6",
+	"ck2_mmpll2_d4_d2",
+	"ck_mainpll_d5",
+	"ck_mainpll_d4",
+	"ck2_univpll2_d4",
+	"ck2_mmpll2_d4",
+	"ck2_mainpll2_d3",
+	"ck2_univpll2_d3",
+	"ck2_mmpll2_d3",
+	"ck2_mainpll2_d2"
+};
+
+static const char * const ck2_mmup_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_mainpll2_d6",
+	"ck2_mainpll2_d5",
+	"ck_osc_d2",
+	"ck_osc",
+	"ck_mainpll_d4",
+	"ck2_univpll2_d4",
+	"ck2_mainpll2_d3"
+};
+
+static const char * const ck2_mminfra_ao_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck_osc_d4",
+	"ck_mainpll_d3"
+};
+
+static const char * const ck2_dvo_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_tvdpll3_d16",
+	"ck2_tvdpll3_d8",
+	"ck2_tvdpll3_d4",
+	"ck2_tvdpll3_d2"
+};
+
+static const char * const ck2_dvo_favt_parents[] = {
+	"ck_tck_26m_mx9_ck",
+	"ck2_tvdpll3_d16",
+	"ck2_tvdpll3_d8",
+	"ck2_tvdpll3_d4",
+	"ck_apll1_ck",
+	"ck_apll2_ck",
+	"ck2_tvdpll3_d2"
+};
+
+static const struct mtk_mux ck2_muxes[] = {
+	/* CKSYS2_CLK_CFG_0 */
+	MUX_MULT_VOTE_FENC(CLK_CK2_SENINF0_SEL, "ck2_seninf0_sel", ck2_seninf0_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_30_DONE, MM_VOTE_CG_30_SET, MM_VOTE_CG_30_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF0_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 31),
+	MUX_MULT_VOTE_FENC(CLK_CK2_SENINF1_SEL, "ck2_seninf1_sel", ck2_seninf1_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_30_DONE, MM_VOTE_CG_30_SET, MM_VOTE_CG_30_CLR,
+		8, 4, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF1_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 30),
+	MUX_MULT_VOTE_FENC(CLK_CK2_SENINF2_SEL, "ck2_seninf2_sel", ck2_seninf2_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_30_DONE, MM_VOTE_CG_30_SET, MM_VOTE_CG_30_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF2_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 29),
+	MUX_MULT_VOTE_FENC(CLK_CK2_SENINF3_SEL, "ck2_seninf3_sel", ck2_seninf3_parents,
+		CKSYS2_CLK_CFG_0, CKSYS2_CLK_CFG_0_SET, CKSYS2_CLK_CFG_0_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_30_DONE, MM_VOTE_CG_30_SET, MM_VOTE_CG_30_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF3_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 28),
+	/* CKSYS2_CLK_CFG_1 */
+	MUX_MULT_VOTE_FENC(CLK_CK2_SENINF4_SEL, "ck2_seninf4_sel", ck2_seninf4_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_31_DONE, MM_VOTE_CG_31_SET, MM_VOTE_CG_31_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF4_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 27),
+	MUX_MULT_VOTE_FENC(CLK_CK2_SENINF5_SEL, "ck2_seninf5_sel", ck2_seninf5_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_31_DONE, MM_VOTE_CG_31_SET, MM_VOTE_CG_31_CLR,
+		8, 4, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_SENINF5_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 26),
+	MUX_MULT_VOTE_FENC(CLK_CK2_IMG1_SEL, "ck2_img1_sel", ck2_img1_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_31_DONE, MM_VOTE_CG_31_SET, MM_VOTE_CG_31_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_IMG1_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 25),
+	MUX_MULT_VOTE_FENC(CLK_CK2_IPE_SEL, "ck2_ipe_sel", ck2_ipe_parents,
+		CKSYS2_CLK_CFG_1, CKSYS2_CLK_CFG_1_SET, CKSYS2_CLK_CFG_1_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_31_DONE, MM_VOTE_CG_31_SET, MM_VOTE_CG_31_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_IPE_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 24),
+	/* CKSYS2_CLK_CFG_2 */
+	MUX_MULT_VOTE_FENC(CLK_CK2_CAM_SEL, "ck2_cam_sel", ck2_cam_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_32_DONE, MM_VOTE_CG_32_SET, MM_VOTE_CG_32_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CAM_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 23),
+	MUX_MULT_VOTE_FENC(CLK_CK2_CAMTM_SEL, "ck2_camtm_sel", ck2_camtm_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_32_DONE, MM_VOTE_CG_32_SET, MM_VOTE_CG_32_CLR,
+		8, 3, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CAMTM_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 22),
+	MUX_MULT_VOTE_FENC(CLK_CK2_DPE_SEL, "ck2_dpe_sel", ck2_dpe_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_32_DONE, MM_VOTE_CG_32_SET, MM_VOTE_CG_32_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DPE_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 21),
+	MUX_MULT_VOTE_FENC(CLK_CK2_VDEC_SEL, "ck2_vdec_sel", ck2_vdec_parents,
+		CKSYS2_CLK_CFG_2, CKSYS2_CLK_CFG_2_SET, CKSYS2_CLK_CFG_2_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_32_DONE, MM_VOTE_CG_32_SET, MM_VOTE_CG_32_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_VDEC_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 20),
+	/* CKSYS2_CLK_CFG_3 */
+	MUX_MULT_VOTE_FENC(CLK_CK2_CCUSYS_SEL, "ck2_ccusys_sel", ck2_ccusys_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_33_DONE, MM_VOTE_CG_33_SET, MM_VOTE_CG_33_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CCUSYS_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 19),
+	MUX_MULT_VOTE_FENC(CLK_CK2_CCUTM_SEL, "ck2_ccutm_sel", ck2_ccutm_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_33_DONE, MM_VOTE_CG_33_SET, MM_VOTE_CG_33_CLR,
+		8, 3, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_CCUTM_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 18),
+	MUX_MULT_VOTE_FENC(CLK_CK2_VENC_SEL, "ck2_venc_sel", ck2_venc_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_33_DONE, MM_VOTE_CG_33_SET, MM_VOTE_CG_33_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_VENC_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 17),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_CK2_DVO_SEL, "ck2_dvo_sel", ck2_dvo_parents,
+		CKSYS2_CLK_CFG_3, CKSYS2_CLK_CFG_3_SET, CKSYS2_CLK_CFG_3_CLR,
+		24, 3, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DVO_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 16),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_CK2_DVO_FAVT_SEL, "ck2_dvo_favt_sel", ck2_dvo_favt_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		0, 3, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DVO_FAVT_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 15),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_CK2_DP1_SEL, "ck2_dp1_sel", ck2_dp1_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		8, 3, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DP1_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 14),
+	MUX_GATE_FENC_CLR_SET_UPD(CLK_CK2_DP0_SEL, "ck2_dp0_sel", ck2_dp0_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR,
+		16, 3, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DP0_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 13),
+	MUX_MULT_VOTE_FENC(CLK_CK2_DISP_SEL, "ck2_disp_sel", ck2_disp_parents,
+		CKSYS2_CLK_CFG_4, CKSYS2_CLK_CFG_4_SET, CKSYS2_CLK_CFG_4_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_34_DONE, MM_VOTE_CG_34_SET, MM_VOTE_CG_34_CLR,
+		24, 4, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_DISP_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 12),
+	/* CKSYS2_CLK_CFG_5 */
+	MUX_MULT_VOTE_FENC(CLK_CK2_MDP_SEL, "ck2_mdp_sel", ck2_mdp_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_35_DONE, MM_VOTE_CG_35_SET, MM_VOTE_CG_35_CLR,
+		0, 4, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MDP_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 11),
+	MUX_MULT_VOTE_FENC(CLK_CK2_MMINFRA_SEL, "ck2_mminfra_sel", ck2_mminfra_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_35_DONE, MM_VOTE_CG_35_SET, MM_VOTE_CG_35_CLR,
+		8, 4, 15, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMINFRA_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 10),
+	MUX_MULT_VOTE_FENC(CLK_CK2_MMINFRA_SNOC_SEL, "ck2_mminfra_snoc_sel", ck2_mminfra_snoc_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_35_DONE, MM_VOTE_CG_35_SET, MM_VOTE_CG_35_CLR,
+		16, 4, 23, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMINFRA_SNOC_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 9),
+	MUX_MULT_VOTE_FENC(CLK_CK2_MMUP_SEL, "ck2_mmup_sel", ck2_mmup_parents,
+		CKSYS2_CLK_CFG_5, CKSYS2_CLK_CFG_5_SET, CKSYS2_CLK_CFG_5_CLR, "vote-regmap",
+		VOTE_CG_30_DONE, VOTE_CG_30_SET, VOTE_CG_30_CLR,
+		24, 3, 31, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMUP_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 8),
+	MUX_MULT_VOTE_FENC(CLK_CK2_MMINFRA_AO_SEL, "ck2_mminfra_ao_sel", ck2_mminfra_ao_parents,
+		CKSYS2_CLK_CFG_6, CKSYS2_CLK_CFG_6_SET, CKSYS2_CLK_CFG_6_CLR, "mm-vote-regmap",
+		MM_VOTE_CG_36_DONE, MM_VOTE_CG_36_SET, MM_VOTE_CG_36_CLR,
+		16, 2, 7, CKSYS2_CLK_CFG_UPDATE, TOP_MUX_MMINFRA_AO_SHIFT,
+		CKSYS2_CLK_FENC_STATUS_MON_0, 5),
+};
+
+static int clk_mt8196_ck2_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_CK2_NR_CLK);
+
+	mtk_clk_register_factors(ck2_divs, ARRAY_SIZE(ck2_divs), clk_data);
+
+	mtk_clk_register_muxes(&pdev->dev, ck2_muxes, ARRAY_SIZE(ck2_muxes), node,
+			       &mt8196_clk_ck2_lock, clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		dev_err(&pdev->dev, "%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+	return r;
+}
+
+static void clk_mt8196_ck2_remove(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_muxes(ck2_muxes, ARRAY_SIZE(ck2_muxes), clk_data);
+	mtk_clk_unregister_factors(ck2_divs, ARRAY_SIZE(ck2_divs), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt8196_ck2[] = {
+	{ .compatible = "mediatek,mt8196-cksys_gp2", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8196_ck2_drv = {
+	.probe = clk_mt8196_ck2_probe,
+	.remove = clk_mt8196_ck2_remove,
+	.driver = {
+		.name = "clk-mt8196-ck2",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_clk_mt8196_ck2,
+	},
+};
+
+module_platform_driver(clk_mt8196_ck2_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


