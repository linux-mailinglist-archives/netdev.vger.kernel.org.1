Return-Path: <netdev+bounces-172760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28692A55E75
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84207AAE50
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E21A3164;
	Fri,  7 Mar 2025 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cR7K5NcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F18DDC5;
	Fri,  7 Mar 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318373; cv=none; b=SsbHeNuSYrk3pswiFUaU5ZJxwtTlsFMTueCdZpLXBZE/y4502wOCqsTewQSqnXaE6lCHY5VMFcqyfVEp3ut9vM3rK4WJodtA4gheCz5CWlZs91dPgIm4gR9/Anad5KOd+aC1k+FiA2yuHReVN8ic2ruIqeKxvEsHQjHB3thse6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318373; c=relaxed/simple;
	bh=V9r2IiarIQeRS7/oNmj1Hy/nQ+tBJ7d+ARVkG37nNjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw4sPWz47dAzcsc0r0gKwdHvNXCDzCx7udzWJ2MYnKSd3ukLqG0qK0NHqgyWCGfZKiOgKYqR5GczeuVyrsUmUEHPtI5EIXOPeW55WgalWICgjdrFez4wpXjpWlnhBrepmXbD8NtYyKsp6n91rcEVyyUkJ9ZOF7bCsDPexgbvNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cR7K5NcQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2c459dcfb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oou/ixzKHk+Y7iStR8p4OKOD3wOKzxnYzhWF2xVDvco=;
	b=cR7K5NcQufAP5On+s0xIHJ036mtPZFlS2KY2u+yUwOQ0gVV+Inm2JcpnYnYQi3G6Yxront666S8eEbIAnCxfxvN5FUhWV4Ys6OSfrbi6tBTX6FaFVLZGVB9/kui75pM0UzirtcdZ9rYH+uBOFXoZBXRqg4LXYrr8aj0L3B8pX3Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:73cae439-8278-423d-827e-6e642ffd62e9,IP:0,UR
	L:25,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:bbe207c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1|
	19,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,OSH
X-CID-BAS: 2,OSH,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d2c459dcfb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1906720722; Fri, 07 Mar 2025 11:32:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:39 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:38 +0800
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
Subject: [PATCH 06/26] dt-bindings: clock: mediatek: Add new MT8196 clock
Date: Fri, 7 Mar 2025 11:27:02 +0800
Message-ID: <20250307032942.10447-7-guangjie.song@mediatek.com>
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

Add the new binding documentation for system clock and functional clock
on Mediatek MT8196.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 .../bindings/clock/mediatek,mt8196-clock.yaml |   66 +
 .../clock/mediatek,mt8196-sys-clock.yaml      |   63 +
 include/dt-bindings/clock/mt8196-clk.h        | 1503 +++++++++++++++++
 3 files changed, 1632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 include/dt-bindings/clock/mt8196-clk.h

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
new file mode 100644
index 000000000000..014c6c4840f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8196-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Functional Clock Controller for MT8196
+
+maintainers:
+  - Guangjie Song <guangjie.song@mediatek.com>
+
+description:
+  The clock architecture in MediaTek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The devices provide clock gate control in different IP blocks.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8196-audiosys
+      - mediatek,mt8196-dispsys0
+      - mediatek,mt8196-dispsys1
+      - mediatek,mt8196-disp_vdisp_ao_config
+      - mediatek,mt8196-imp_iic_wrap_c
+      - mediatek,mt8196-imp_iic_wrap_e
+      - mediatek,mt8196-imp_iic_wrap_n
+      - mediatek,mt8196-imp_iic_wrap_w
+      - mediatek,mt8196-mdpsys
+      - mediatek,mt8196-mdpsys1
+      - mediatek,mt8196-ovlsys0
+      - mediatek,mt8196-ovlsys1
+      - mediatek,mt8196-pericfg_ao
+      - mediatek,mt8196-pextp0cfg_ao
+      - mediatek,mt8196-pextp1cfg_ao
+      - mediatek,mt8196-ufscfg_ao
+      - mediatek,mt8196-vdecsys
+      - mediatek,mt8196-vdecsys_soc
+      - mediatek,mt8196-vencsys
+      - mediatek,mt8196-vencsys_c1
+      - mediatek,mt8196-vencsys_c2
+
+  reg:
+    description: Address range of the subsys.
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@16300000 {
+        compatible = "mediatek,mt8196-imp_iic_wrap_c";
+        reg = <0x16300000 0x1000>;
+        #clock-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
new file mode 100644
index 000000000000..0909b9f1ee52
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8196-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Clock Controller for MT8196
+
+maintainers:
+  - Guangjie Song <guangjie.song@mediatek.com>
+
+description:
+  The clock architecture in MediaTek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The apmixedsys, vlp_cksys, armpll, ccipll, mfgpll and ptppll provides most of PLLs
+  which generated from SoC 26m.
+  The cksys, cksys_gp2 and vlp_cksys provides dividers and muxes which provide the
+  clock source to other IP blocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8196-armpll_ll_pll_ctrl
+          - mediatek,mt8196-armpll_bl_pll_ctrl
+          - mediatek,mt8196-armpll_b_pll_ctrl
+          - mediatek,mt8196-apmixedsys
+          - mediatek,mt8196-apmixedsys_gp2
+          - mediatek,mt8196-ccipll_pll_ctrl
+          - mediatek,mt8196-cksys
+          - mediatek,mt8196-cksys_gp2
+          - mediatek,mt8196-mfgpll_pll_ctrl
+          - mediatek,mt8196-mfgpll_sc0_pll_ctrl
+          - mediatek,mt8196-mfgpll_sc1_pll_ctrl
+          - mediatek,mt8196-ptppll_pll_ctrl
+          - mediatek,mt8196-vlp_cksys
+      - const: syscon
+
+  reg:
+    description: Address range of the subsys.
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10000800 {
+        compatible = "mediatek,mt8196-apmixedsys", "syscon";
+        reg = <0 0x10000800 0 0x1000>;
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/mt8196-clk.h b/include/dt-bindings/clock/mt8196-clk.h
new file mode 100644
index 000000000000..9bd33c46f7de
--- /dev/null
+++ b/include/dt-bindings/clock/mt8196-clk.h
@@ -0,0 +1,1503 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Guangjie Song <guangjie.song@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8196_H
+#define _DT_BINDINGS_CLK_MT8196_H
+
+/* CKSYS */
+#define CLK_CK_AXI_SEL					0
+#define CLK_CK_MEM_SUB_SEL				1
+#define CLK_CK_IO_NOC_SEL				2
+#define CLK_CK_P_AXI_SEL				3
+#define CLK_CK_PEXTP0_AXI_SEL				4
+#define CLK_CK_PEXTP1_USB_AXI_SEL			5
+#define CLK_CK_P_FMEM_SUB_SEL				6
+#define CLK_CK_PEXPT0_MEM_SUB_SEL			7
+#define CLK_CK_PEXTP1_USB_MEM_SUB_SEL			8
+#define CLK_CK_P_NOC_SEL				9
+#define CLK_CK_EMI_N_SEL				10
+#define CLK_CK_EMI_S_SEL				11
+#define CLK_CK_AP2CONN_HOST_SEL				12
+#define CLK_CK_ATB_SEL					13
+#define CLK_CK_CIRQ_SEL					14
+#define CLK_CK_PBUS_156M_SEL				15
+#define CLK_CK_EFUSE_SEL				16
+#define CLK_CK_MCL3GIC_SEL				17
+#define CLK_CK_MCINFRA_SEL				18
+#define CLK_CK_DSP_SEL					19
+#define CLK_CK_MFG_REF_SEL				20
+#define CLK_CK_MFG_EB_SEL				21
+#define CLK_CK_UART_SEL					22
+#define CLK_CK_SPI0_BCLK_SEL				23
+#define CLK_CK_SPI1_BCLK_SEL				24
+#define CLK_CK_SPI2_BCLK_SEL				25
+#define CLK_CK_SPI3_BCLK_SEL				26
+#define CLK_CK_SPI4_BCLK_SEL				27
+#define CLK_CK_SPI5_BCLK_SEL				28
+#define CLK_CK_SPI6_BCLK_SEL				29
+#define CLK_CK_SPI7_BCLK_SEL				30
+#define CLK_CK_MSDC30_1_SEL				31
+#define CLK_CK_MSDC30_2_SEL				32
+#define CLK_CK_DISP_PWM_SEL				33
+#define CLK_CK_USB_TOP_1P_SEL				34
+#define CLK_CK_USB_XHCI_1P_SEL				35
+#define CLK_CK_USB_FMCNT_P1_SEL				36
+#define CLK_CK_I2C_P_SEL				37
+#define CLK_CK_I2C_EAST_SEL				38
+#define CLK_CK_I2C_WEST_SEL				39
+#define CLK_CK_I2C_NORTH_SEL				40
+#define CLK_CK_AES_UFSFDE_SEL				41
+#define CLK_CK_SEL					42
+#define CLK_CK_AUD_1_SEL				43
+#define CLK_CK_AUD_2_SEL				44
+#define CLK_CK_ADSP_SEL					45
+#define CLK_CK_ADSP_UARTHUB_BCLK_SEL			46
+#define CLK_CK_DPMAIF_MAIN_SEL				47
+#define CLK_CK_PWM_SEL					48
+#define CLK_CK_MCUPM_SEL				49
+#define CLK_CK_IPSEAST_SEL				50
+#define CLK_CK_TL_SEL					51
+#define CLK_CK_TL_P1_SEL				52
+#define CLK_CK_TL_P2_SEL				53
+#define CLK_CK_EMI_INTERFACE_546_SEL			54
+#define CLK_CK_SDF_SEL					55
+#define CLK_CK_UARTHUB_BCLK_SEL				56
+#define CLK_CK_DPSW_CMP_26M_SEL				57
+#define CLK_CK_SMAPCK_SEL				58
+#define CLK_CK_SSR_PKA_SEL				59
+#define CLK_CK_SSR_DMA_SEL				60
+#define CLK_CK_SSR_KDF_SEL				61
+#define CLK_CK_SSR_RNG_SEL				62
+#define CLK_CK_SPU0_SEL					63
+#define CLK_CK_SPU1_SEL					64
+#define CLK_CK_DXCC_SEL					65
+#define CLK_CK_APLL_I2SIN0_MCK_SEL			66
+#define CLK_CK_APLL_I2SIN1_MCK_SEL			67
+#define CLK_CK_APLL_I2SIN2_MCK_SEL			68
+#define CLK_CK_APLL_I2SIN3_MCK_SEL			69
+#define CLK_CK_APLL_I2SIN4_MCK_SEL			70
+#define CLK_CK_APLL_I2SIN6_MCK_SEL			71
+#define CLK_CK_APLL_I2SOUT0_MCK_SEL			72
+#define CLK_CK_APLL_I2SOUT1_MCK_SEL			73
+#define CLK_CK_APLL_I2SOUT2_MCK_SEL			74
+#define CLK_CK_APLL_I2SOUT3_MCK_SEL			75
+#define CLK_CK_APLL_I2SOUT4_MCK_SEL			76
+#define CLK_CK_APLL_I2SOUT6_MCK_SEL			77
+#define CLK_CK_APLL_FMI2S_MCK_SEL			78
+#define CLK_CK_APLL_TDMOUT_MCK_SEL			79
+#define CLK_CK_APLL12_CK_DIV_I2SIN0			80
+#define CLK_CK_APLL12_CK_DIV_I2SIN1			81
+#define CLK_CK_APLL12_CK_DIV_I2SIN2			82
+#define CLK_CK_APLL12_CK_DIV_I2SIN3			83
+#define CLK_CK_APLL12_CK_DIV_I2SIN4			84
+#define CLK_CK_APLL12_CK_DIV_I2SIN6			85
+#define CLK_CK_APLL12_CK_DIV_I2SOUT0			86
+#define CLK_CK_APLL12_CK_DIV_I2SOUT1			87
+#define CLK_CK_APLL12_CK_DIV_I2SOUT2			88
+#define CLK_CK_APLL12_CK_DIV_I2SOUT3			89
+#define CLK_CK_APLL12_CK_DIV_I2SOUT4			90
+#define CLK_CK_APLL12_CK_DIV_I2SOUT6			91
+#define CLK_CK_APLL12_CK_DIV_FMI2S			92
+#define CLK_CK_APLL12_CK_DIV_TDMOUT_M			93
+#define CLK_CK_APLL12_CK_DIV_TDMOUT_B			94
+#define CLK_CK_MAINPLL_D3				95
+#define CLK_CK_MAINPLL_D4				96
+#define CLK_CK_MAINPLL_D4_D2				97
+#define CLK_CK_MAINPLL_D4_D4				98
+#define CLK_CK_MAINPLL_D4_D8				99
+#define CLK_CK_MAINPLL_D5				100
+#define CLK_CK_MAINPLL_D5_D2				101
+#define CLK_CK_MAINPLL_D5_D4				102
+#define CLK_CK_MAINPLL_D5_D8				103
+#define CLK_CK_MAINPLL_D6				104
+#define CLK_CK_MAINPLL_D6_D2				105
+#define CLK_CK_MAINPLL_D7				106
+#define CLK_CK_MAINPLL_D7_D2				107
+#define CLK_CK_MAINPLL_D7_D4				108
+#define CLK_CK_MAINPLL_D7_D8				109
+#define CLK_CK_MAINPLL_D9				110
+#define CLK_CK_UNIVPLL_D4				111
+#define CLK_CK_UNIVPLL_D4_D2				112
+#define CLK_CK_UNIVPLL_D4_D4				113
+#define CLK_CK_UNIVPLL_D4_D8				114
+#define CLK_CK_UNIVPLL_D5				115
+#define CLK_CK_UNIVPLL_D5_D2				116
+#define CLK_CK_UNIVPLL_D5_D4				117
+#define CLK_CK_UNIVPLL_D6				118
+#define CLK_CK_UNIVPLL_D6_D2				119
+#define CLK_CK_UNIVPLL_D6_D4				120
+#define CLK_CK_UNIVPLL_D6_D8				121
+#define CLK_CK_UNIVPLL_D6_D16				122
+#define CLK_CK_UNIVPLL_192M				123
+#define CLK_CK_UNIVPLL_192M_D4				124
+#define CLK_CK_UNIVPLL_192M_D8				125
+#define CLK_CK_UNIVPLL_192M_D16				126
+#define CLK_CK_UNIVPLL_192M_D32				127
+#define CLK_CK_UNIVPLL_192M_D10				128
+#define CLK_CK_APLL1					129
+#define CLK_CK_APLL1_D4					130
+#define CLK_CK_APLL1_D8					131
+#define CLK_CK_APLL2					132
+#define CLK_CK_APLL2_D4					133
+#define CLK_CK_APLL2_D8					134
+#define CLK_CK_ADSPPLL					135
+#define CLK_CK_EMIPLL1					136
+#define CLK_CK_TVDPLL1_D2				137
+#define CLK_CK_MSDCPLL_D2				138
+#define CLK_CK_CLKRTC					139
+#define CLK_CK_TCK_26M_MX9				140
+#define CLK_CK_F26M					141
+#define CLK_CK_F26M_CK_D2				142
+#define CLK_CK_OSC					143
+#define CLK_CK_OSC_D2					144
+#define CLK_CK_OSC_D3					145
+#define CLK_CK_OSC_D4					146
+#define CLK_CK_OSC_D5					147
+#define CLK_CK_OSC_D7					148
+#define CLK_CK_OSC_D8					149
+#define CLK_CK_OSC_D10					150
+#define CLK_CK_OSC_D14					151
+#define CLK_CK_OSC_D20					152
+#define CLK_CK_OSC_D32					153
+#define CLK_CK_OSC_D40					154
+#define CLK_CK_OSC3					155
+#define CLK_CK_P_AXI					156
+#define CLK_CK_PEXTP0_AXI				157
+#define CLK_CK_PEXTP1_USB_AXI				158
+#define CLK_CK_PEXPT0_MEM_SUB				159
+#define CLK_CK_PEXTP1_USB_MEM_SUB			160
+#define CLK_CK_UART					161
+#define CLK_CK_SPI0_BCLK				162
+#define CLK_CK_SPI1_BCLK				163
+#define CLK_CK_SPI2_BCLK				164
+#define CLK_CK_SPI3_BCLK				165
+#define CLK_CK_SPI4_BCLK				166
+#define CLK_CK_SPI5_BCLK				167
+#define CLK_CK_SPI6_BCLK				168
+#define CLK_CK_SPI7_BCLK				169
+#define CLK_CK_MSDC30_1					170
+#define CLK_CK_MSDC30_2					171
+#define CLK_CK_I2C_PERI					172
+#define CLK_CK_I2C_EAST					173
+#define CLK_CK_I2C_WEST					174
+#define CLK_CK_I2C_NORTH				175
+#define CLK_CK_AES_UFSFDE				176
+#define CLK_CK_UFS					177
+#define CLK_CK_AUD_1					178
+#define CLK_CK_AUD_2					179
+#define CLK_CK_DPMAIF_MAIN				180
+#define CLK_CK_PWM					181
+#define CLK_CK_TL					182
+#define CLK_CK_TL_P1					183
+#define CLK_CK_TL_P2					184
+#define CLK_CK_SSR_RNG					185
+#define CLK_CK_SPU0					186
+#define CLK_CK_DXCC					187
+#define CLK_CK_SFLASH_SEL				188
+#define CLK_CK_SFLASH					189
+#define CLK_CK_NR_CLK					190
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_MAINPLL				0
+#define CLK_APMIXED_UNIVPLL				1
+#define CLK_APMIXED_MSDCPLL				2
+#define CLK_APMIXED_ADSPPLL				3
+#define CLK_APMIXED_EMIPLL				4
+#define CLK_APMIXED_EMIPLL2				5
+#define CLK_APMIXED_NR_CLK				6
+
+/* CKSYS_GP2 */
+#define CLK_CK2_SENINF0_SEL				0
+#define CLK_CK2_SENINF1_SEL				1
+#define CLK_CK2_SENINF2_SEL				2
+#define CLK_CK2_SENINF3_SEL				3
+#define CLK_CK2_SENINF4_SEL				4
+#define CLK_CK2_SENINF5_SEL				5
+#define CLK_CK2_IMG1_SEL				6
+#define CLK_CK2_IPE_SEL					7
+#define CLK_CK2_CAM_SEL					8
+#define CLK_CK2_CAMTM_SEL				9
+#define CLK_CK2_DPE_SEL					10
+#define CLK_CK2_VDEC_SEL				11
+#define CLK_CK2_CCUSYS_SEL				12
+#define CLK_CK2_CCUTM_SEL				13
+#define CLK_CK2_VENC_SEL				14
+#define CLK_CK2_DP1_SEL					15
+#define CLK_CK2_DP0_SEL					16
+#define CLK_CK2_DISP_SEL				17
+#define CLK_CK2_MDP_SEL					18
+#define CLK_CK2_MMINFRA_SEL				19
+#define CLK_CK2_MMINFRA_SNOC_SEL			20
+#define CLK_CK2_MMUP_SEL				21
+#define CLK_CK2_MMINFRA_AO_SEL				22
+#define CLK_CK2_MAINPLL2_D2				23
+#define CLK_CK2_MAINPLL2_D3				24
+#define CLK_CK2_MAINPLL2_D4				25
+#define CLK_CK2_MAINPLL2_D4_D2				26
+#define CLK_CK2_MAINPLL2_D4_D4				27
+#define CLK_CK2_MAINPLL2_D5				28
+#define CLK_CK2_MAINPLL2_D5_D2				29
+#define CLK_CK2_MAINPLL2_D6				30
+#define CLK_CK2_MAINPLL2_D6_D2				31
+#define CLK_CK2_MAINPLL2_D7				32
+#define CLK_CK2_MAINPLL2_D7_D2				33
+#define CLK_CK2_MAINPLL2_D9				34
+#define CLK_CK2_UNIVPLL2_D3				35
+#define CLK_CK2_UNIVPLL2_D4				36
+#define CLK_CK2_UNIVPLL2_D4_D2				37
+#define CLK_CK2_UNIVPLL2_D5				38
+#define CLK_CK2_UNIVPLL2_D5_D2				39
+#define CLK_CK2_UNIVPLL2_D6				40
+#define CLK_CK2_UNIVPLL2_D6_D2				41
+#define CLK_CK2_UNIVPLL2_D6_D4				42
+#define CLK_CK2_UNIVPLL2_D7				43
+#define CLK_CK2_IMGPLL_D2				44
+#define CLK_CK2_IMGPLL_D4				45
+#define CLK_CK2_IMGPLL_D5				46
+#define CLK_CK2_IMGPLL_D5_D2				47
+#define CLK_CK2_MMPLL2_D3				48
+#define CLK_CK2_MMPLL2_D4				49
+#define CLK_CK2_MMPLL2_D4_D2				50
+#define CLK_CK2_MMPLL2_D5				51
+#define CLK_CK2_MMPLL2_D5_D2				52
+#define CLK_CK2_MMPLL2_D6				53
+#define CLK_CK2_MMPLL2_D6_D2				54
+#define CLK_CK2_MMPLL2_D7				55
+#define CLK_CK2_MMPLL2_D9				56
+#define CLK_CK2_TVDPLL1_D4				57
+#define CLK_CK2_TVDPLL1_D8				58
+#define CLK_CK2_TVDPLL1_D16				59
+#define CLK_CK2_TVDPLL2_D2				60
+#define CLK_CK2_TVDPLL2_D4				61
+#define CLK_CK2_TVDPLL2_D8				62
+#define CLK_CK2_TVDPLL2_D16				63
+#define CLK_CK2_CCUSYS					64
+#define CLK_CK2_VENC					65
+#define CLK_CK2_MMINFRA					66
+#define CLK_CK2_IMG1					67
+#define CLK_CK2_IPE					68
+#define CLK_CK2_CAM					69
+#define CLK_CK2_CAMTM					70
+#define CLK_CK2_DPE					71
+#define CLK_CK2_VDEC					72
+#define CLK_CK2_DP1					73
+#define CLK_CK2_DP0					74
+#define CLK_CK2_MDP					75
+#define CLK_CK2_DISP					76
+#define CLK_CK2_AVS_IMG					77
+#define CLK_CK2_AVS_VDEC				78
+#define CLK_CK2_DVO_SEL					79
+#define CLK_CK2_DVO_FAVT_SEL				80
+#define CLK_CK2_TVDPLL3_D2				81
+#define CLK_CK2_TVDPLL3_D4				82
+#define CLK_CK2_TVDPLL3_D8				83
+#define CLK_CK2_TVDPLL3_D16				84
+#define CLK_CK2_NR_CLK					85
+
+/* APMIXEDSYS_GP2 */
+#define CLK_APMIXED2_MAINPLL2				0
+#define CLK_APMIXED2_UNIVPLL2				1
+#define CLK_APMIXED2_MMPLL2				2
+#define CLK_APMIXED2_IMGPLL				3
+#define CLK_APMIXED2_TVDPLL1				4
+#define CLK_APMIXED2_TVDPLL2				5
+#define CLK_APMIXED2_TVDPLL3				6
+#define CLK_APMIXED2_NR_CLK				7
+
+/* IMP_IIC_WRAP_E */
+#define CLK_IMPE_I2C5					0
+#define CLK_IMPE_I2C5_I2C				1
+#define CLK_IMPE_NR_CLK					2
+
+/* IMP_IIC_WRAP_W */
+#define CLK_IMPW_I2C0					0
+#define CLK_IMPW_I2C0_I2C				1
+#define CLK_IMPW_I2C3					2
+#define CLK_IMPW_I2C3_I2C				3
+#define CLK_IMPW_I2C6					4
+#define CLK_IMPW_I2C6_I2C				5
+#define CLK_IMPW_I2C10					6
+#define CLK_IMPW_I2C10_I2C				7
+#define CLK_IMPW_NR_CLK					8
+
+/* IMP_IIC_WRAP_N */
+#define CLK_IMPN_I2C1					0
+#define CLK_IMPN_I2C1_I2C				1
+#define CLK_IMPN_I2C2					2
+#define CLK_IMPN_I2C2_I2C				3
+#define CLK_IMPN_I2C4					4
+#define CLK_IMPN_I2C4_I2C				5
+#define CLK_IMPN_I2C7					6
+#define CLK_IMPN_I2C7_I2C				7
+#define CLK_IMPN_I2C8					8
+#define CLK_IMPN_I2C8_I2C				9
+#define CLK_IMPN_I2C9					10
+#define CLK_IMPN_I2C9_I2C				11
+#define CLK_IMPN_NR_CLK					12
+
+/* IMP_IIC_WRAP_C */
+#define CLK_IMPC_I2C11					0
+#define CLK_IMPC_I2C11_I2C				1
+#define CLK_IMPC_I2C12					2
+#define CLK_IMPC_I2C12_I2C				3
+#define CLK_IMPC_I2C13					4
+#define CLK_IMPC_I2C13_I2C				5
+#define CLK_IMPC_I2C14					6
+#define CLK_IMPC_I2C14_I2C				7
+#define CLK_IMPC_NR_CLK					8
+
+/* PERICFG_AO */
+#define CLK_PERAO_UART0_BCLK				0
+#define CLK_PERAO_UART0_BCLK_UART			1
+#define CLK_PERAO_UART1_BCLK				2
+#define CLK_PERAO_UART1_BCLK_UART			3
+#define CLK_PERAO_UART2_BCLK				4
+#define CLK_PERAO_UART2_BCLK_UART			5
+#define CLK_PERAO_UART3_BCLK				6
+#define CLK_PERAO_UART3_BCLK_UART			7
+#define CLK_PERAO_UART4_BCLK				8
+#define CLK_PERAO_UART4_BCLK_UART			9
+#define CLK_PERAO_UART5_BCLK				10
+#define CLK_PERAO_UART5_BCLK_UART			11
+#define CLK_PERAO_PWM_X16W_HCLK				12
+#define CLK_PERAO_PWM_X16W_HCLK_PWM			13
+#define CLK_PERAO_PWM_X16W_BCLK				14
+#define CLK_PERAO_PWM_X16W_BCLK_PWM			15
+#define CLK_PERAO_PWM_PWM_BCLK0				16
+#define CLK_PERAO_PWM_PWM_BCLK0_PWM			17
+#define CLK_PERAO_PWM_PWM_BCLK1				18
+#define CLK_PERAO_PWM_PWM_BCLK1_PWM			19
+#define CLK_PERAO_PWM_PWM_BCLK2				20
+#define CLK_PERAO_PWM_PWM_BCLK2_PWM			21
+#define CLK_PERAO_PWM_PWM_BCLK3				22
+#define CLK_PERAO_PWM_PWM_BCLK3_PWM			23
+#define CLK_PERAO_SPI0_BCLK				24
+#define CLK_PERAO_SPI0_BCLK_SPI				25
+#define CLK_PERAO_SPI1_BCLK				26
+#define CLK_PERAO_SPI1_BCLK_SPI				27
+#define CLK_PERAO_SPI2_BCLK				28
+#define CLK_PERAO_SPI2_BCLK_SPI				29
+#define CLK_PERAO_SPI3_BCLK				30
+#define CLK_PERAO_SPI3_BCLK_SPI				31
+#define CLK_PERAO_SPI4_BCLK				32
+#define CLK_PERAO_SPI4_BCLK_SPI				33
+#define CLK_PERAO_SPI5_BCLK				34
+#define CLK_PERAO_SPI5_BCLK_SPI				35
+#define CLK_PERAO_SPI6_BCLK				36
+#define CLK_PERAO_SPI6_BCLK_SPI				37
+#define CLK_PERAO_SPI7_BCLK				38
+#define CLK_PERAO_SPI7_BCLK_SPI				39
+#define CLK_PERAO_AP_DMA_X32W_BCLK			40
+#define CLK_PERAO_AP_DMA_X32W_BCLK_UART			41
+#define CLK_PERAO_AP_DMA_X32W_BCLK_I2C			42
+#define CLK_PERAO_MSDC1_MSDC_SRC			43
+#define CLK_PERAO_MSDC1_MSDC_SRC_MSDC1			44
+#define CLK_PERAO_MSDC1_HCLK				45
+#define CLK_PERAO_MSDC1_HCLK_MSDC1			46
+#define CLK_PERAO_MSDC1_AXI				47
+#define CLK_PERAO_MSDC1_AXI_MSDC1			48
+#define CLK_PERAO_MSDC1_HCLK_WRAP			49
+#define CLK_PERAO_MSDC1_HCLK_WRAP_MSDC1			50
+#define CLK_PERAO_MSDC2_MSDC_SRC			51
+#define CLK_PERAO_MSDC2_MSDC_SRC_MSDC2			52
+#define CLK_PERAO_MSDC2_HCLK				53
+#define CLK_PERAO_MSDC2_HCLK_MSDC2			54
+#define CLK_PERAO_MSDC2_AXI				55
+#define CLK_PERAO_MSDC2_AXI_MSDC2			56
+#define CLK_PERAO_MSDC2_HCLK_WRAP			57
+#define CLK_PERAO_MSDC2_HCLK_WRAP_MSDC2			58
+#define CLK_PERAO_FLASHIF_FLASH				59
+#define CLK_PERAO_FLASHIF_FLASH_FLASHIF			60
+#define CLK_PERAO_FLASHIF_27M				61
+#define CLK_PERAO_FLASHIF_27M_FLASHIF			62
+#define CLK_PERAO_FLASHIF_DRAM				63
+#define CLK_PERAO_FLASHIF_DRAM_FLASHIF			64
+#define CLK_PERAO_FLASHIF_AXI				65
+#define CLK_PERAO_FLASHIF_AXI_FLASHIF			66
+#define CLK_PERAO_FLASHIF_BCLK				67
+#define CLK_PERAO_FLASHIF_BCLK_FLASHIF			68
+#define CLK_PERAO_NR_CLK				69
+
+/* UFSCFG_AO */
+#define CLK_UFSAO_UNIPRO_TX_SYM				0
+#define CLK_UFSAO_UNIPRO_TX_SYM_UFS			1
+#define CLK_UFSAO_UNIPRO_RX_SYM0			2
+#define CLK_UFSAO_UNIPRO_RX_SYM0_UFS			3
+#define CLK_UFSAO_UNIPRO_RX_SYM1			4
+#define CLK_UFSAO_UNIPRO_RX_SYM1_UFS			5
+#define CLK_UFSAO_UNIPRO_SYS				6
+#define CLK_UFSAO_UNIPRO_SYS_UFS			7
+#define CLK_UFSAO_UNIPRO_SAP				8
+#define CLK_UFSAO_UNIPRO_SAP_UFS			9
+#define CLK_UFSAO_PHY_SAP				10
+#define CLK_UFSAO_PHY_SAP_UFS				11
+#define CLK_UFSAO_UFSHCI_UFS				12
+#define CLK_UFSAO_UFSHCI_UFS_UFS			13
+#define CLK_UFSAO_UFSHCI_AES				14
+#define CLK_UFSAO_UFSHCI_AES_UFS			15
+#define CLK_UFSAO_NR_CLK				16
+
+/* PEXTP0CFG_AO */
+#define CLK_PEXT_PEXTP_MAC_P0_TL			0
+#define CLK_PEXT_PEXTP_MAC_P0_TL_PCIE			1
+#define CLK_PEXT_PEXTP_MAC_P0_REF			2
+#define CLK_PEXT_PEXTP_MAC_P0_REF_PCIE			3
+#define CLK_PEXT_PEXTP_PHY_P0_MCU_BUS			4
+#define CLK_PEXT_PEXTP_PHY_P0_MCU_BUS_PCIE		5
+#define CLK_PEXT_PEXTP_PHY_P0_PEXTP_REF			6
+#define CLK_PEXT_PEXTP_PHY_P0_PEXTP_REF_PCIE		7
+#define CLK_PEXT_PEXTP_MAC_P0_AXI_250			8
+#define CLK_PEXT_PEXTP_MAC_P0_AXI_250_PCIE		9
+#define CLK_PEXT_PEXTP_MAC_P0_AHB_APB			10
+#define CLK_PEXT_PEXTP_MAC_P0_AHB_APB_PCIE		11
+#define CLK_PEXT_PEXTP_MAC_P0_PL_P			12
+#define CLK_PEXT_PEXTP_MAC_P0_PL_P_PCIE			13
+#define CLK_PEXT_PEXTP_VLP_AO_P0_LP			14
+#define CLK_PEXT_PEXTP_VLP_AO_P0_LP_PCIE		15
+#define CLK_PEXT_NR_CLK					16
+
+/* PEXTP1CFG_AO */
+#define CLK_PEXT1_PEXTP_MAC_P1_TL			0
+#define CLK_PEXT1_PEXTP_MAC_P1_TL_PCIE			1
+#define CLK_PEXT1_PEXTP_MAC_P1_REF			2
+#define CLK_PEXT1_PEXTP_MAC_P1_REF_PCIE			3
+#define CLK_PEXT1_PEXTP_MAC_P2_TL			4
+#define CLK_PEXT1_PEXTP_MAC_P2_TL_PCIE			5
+#define CLK_PEXT1_PEXTP_MAC_P2_REF			6
+#define CLK_PEXT1_PEXTP_MAC_P2_REF_PCIE			7
+#define CLK_PEXT1_PEXTP_PHY_P1_MCU_BUS			8
+#define CLK_PEXT1_PEXTP_PHY_P1_MCU_BUS_PCIE		9
+#define CLK_PEXT1_PEXTP_PHY_P1_PEXTP_REF		10
+#define CLK_PEXT1_PEXTP_PHY_P1_PEXTP_REF_PCIE		11
+#define CLK_PEXT1_PEXTP_PHY_P2_MCU_BUS			12
+#define CLK_PEXT1_PEXTP_PHY_P2_MCU_BUS_PCIE		13
+#define CLK_PEXT1_PEXTP_PHY_P2_PEXTP_REF		14
+#define CLK_PEXT1_PEXTP_PHY_P2_PEXTP_REF_PCIE		15
+#define CLK_PEXT1_PEXTP_MAC_P1_AXI_250			16
+#define CLK_PEXT1_PEXTP_MAC_P1_AXI_250_PCIE		17
+#define CLK_PEXT1_PEXTP_MAC_P1_AHB_APB			18
+#define CLK_PEXT1_PEXTP_MAC_P1_AHB_APB_PCIE		19
+#define CLK_PEXT1_PEXTP_MAC_P1_PL_P			20
+#define CLK_PEXT1_PEXTP_MAC_P1_PL_P_PCIE		21
+#define CLK_PEXT1_PEXTP_MAC_P2_AXI_250			22
+#define CLK_PEXT1_PEXTP_MAC_P2_AXI_250_PCIE		23
+#define CLK_PEXT1_PEXTP_MAC_P2_AHB_APB			24
+#define CLK_PEXT1_PEXTP_MAC_P2_AHB_APB_PCIE		25
+#define CLK_PEXT1_PEXTP_MAC_P2_PL_P			26
+#define CLK_PEXT1_PEXTP_MAC_P2_PL_P_PCIE		27
+#define CLK_PEXT1_PEXTP_VLP_AO_P1_LP			28
+#define CLK_PEXT1_PEXTP_VLP_AO_P1_LP_PCIE		29
+#define CLK_PEXT1_PEXTP_VLP_AO_P2_LP			30
+#define CLK_PEXT1_PEXTP_VLP_AO_P2_LP_PCIE		31
+#define CLK_PEXT1_NR_CLK				32
+
+/* VLP_CKSYS */
+#define CLK_VLP_CK_VLP_APLL1				0
+#define CLK_VLP_CK_VLP_APLL2				1
+#define CLK_VLP_CK_SCP_SEL				2
+#define CLK_VLP_CK_SCP_SPI_SEL				3
+#define CLK_VLP_CK_SCP_IIC_SEL				4
+#define CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL			5
+#define CLK_VLP_CK_PWRAP_ULPOSC_SEL			6
+#define CLK_VLP_CK_SPMI_M_TIA_32K_SEL			7
+#define CLK_VLP_CK_APXGPT_26M_BCLK_SEL			8
+#define CLK_VLP_CK_DPSW_SEL				9
+#define CLK_VLP_CK_DPSW_CENTRAL_SEL			10
+#define CLK_VLP_CK_SPMI_M_MST_SEL			11
+#define CLK_VLP_CK_DVFSRC_SEL				12
+#define CLK_VLP_CK_PWM_VLP_SEL				13
+#define CLK_VLP_CK_AXI_VLP_SEL				14
+#define CLK_VLP_CK_SYSTIMER_26M_SEL			15
+#define CLK_VLP_CK_SSPM_SEL				16
+#define CLK_VLP_CK_SRCK_SEL				17
+#define CLK_VLP_CK_CAMTG0_SEL				18
+#define CLK_VLP_CK_CAMTG1_SEL				19
+#define CLK_VLP_CK_CAMTG2_SEL				20
+#define CLK_VLP_CK_CAMTG3_SEL				21
+#define CLK_VLP_CK_CAMTG4_SEL				22
+#define CLK_VLP_CK_CAMTG5_SEL				23
+#define CLK_VLP_CK_CAMTG6_SEL				24
+#define CLK_VLP_CK_CAMTG7_SEL				25
+#define CLK_VLP_CK_SSPM_26M_SEL				26
+#define CLK_VLP_CK_ULPOSC_SSPM_SEL			27
+#define CLK_VLP_CK_VLP_PBUS_26M_SEL			28
+#define CLK_VLP_CK_DEBUG_ERR_FLAG_SEL			29
+#define CLK_VLP_CK_DPMSRDMA_SEL				30
+#define CLK_VLP_CK_VLP_PBUS_156M_SEL			31
+#define CLK_VLP_CK_SPM_SEL				32
+#define CLK_VLP_CK_MMINFRA_VLP_SEL			33
+#define CLK_VLP_CK_USB_TOP_SEL				34
+#define CLK_VLP_CK_USB_XHCI_SEL				35
+#define CLK_VLP_CK_NOC_VLP_SEL				36
+#define CLK_VLP_CK_AUDIO_H_SEL				37
+#define CLK_VLP_CK_AUD_ENGEN1_SEL			38
+#define CLK_VLP_CK_AUD_ENGEN2_SEL			39
+#define CLK_VLP_CK_AUD_INTBUS_SEL			40
+#define CLK_VLP_CK_SPVLP_26M_SEL			41
+#define CLK_VLP_CK_SPU0_VLP_SEL				42
+#define CLK_VLP_CK_SPU1_VLP_SEL				43
+#define CLK_VLP_CK_OSC3					44
+#define CLK_VLP_CK_CLKSQ				45
+#define CLK_VLP_CK_AUDIO_H				46
+#define CLK_VLP_CK_AUD_ENGEN1				47
+#define CLK_VLP_CK_AUD_ENGEN2				48
+#define CLK_VLP_CK_INFRA_26M				49
+#define CLK_VLP_CK_AUD_CLKSQ				50
+#define CLK_VLP_CK_NR_CLK				51
+
+/* AFE */
+#define CLK_AFE_PCM1					0
+#define CLK_AFE_PCM1_AFE				1
+#define CLK_AFE_PCM0					2
+#define CLK_AFE_PCM0_AFE				3
+#define CLK_AFE_CM2					4
+#define CLK_AFE_CM2_AFE					5
+#define CLK_AFE_CM1					6
+#define CLK_AFE_CM1_AFE					7
+#define CLK_AFE_CM0					8
+#define CLK_AFE_CM0_AFE					9
+#define CLK_AFE_STF					10
+#define CLK_AFE_STF_AFE					11
+#define CLK_AFE_HW_GAIN23				12
+#define CLK_AFE_HW_GAIN23_AFE				13
+#define CLK_AFE_HW_GAIN01				14
+#define CLK_AFE_HW_GAIN01_AFE				15
+#define CLK_AFE_FM_I2S					16
+#define CLK_AFE_FM_I2S_AFE				17
+#define CLK_AFE_MTKAIFV4				18
+#define CLK_AFE_MTKAIFV4_AFE				19
+#define CLK_AFE_UL2_ADC_HIRES_TML			20
+#define CLK_AFE_UL2_ADC_HIRES_TML_AFE			21
+#define CLK_AFE_UL2_ADC_HIRES				22
+#define CLK_AFE_UL2_ADC_HIRES_AFE			23
+#define CLK_AFE_UL2_TML					24
+#define CLK_AFE_UL2_TML_AFE				25
+#define CLK_AFE_UL2_ADC					26
+#define CLK_AFE_UL2_ADC_AFE				27
+#define CLK_AFE_UL1_ADC_HIRES_TML			28
+#define CLK_AFE_UL1_ADC_HIRES_TML_AFE			29
+#define CLK_AFE_UL1_ADC_HIRES				30
+#define CLK_AFE_UL1_ADC_HIRES_AFE			31
+#define CLK_AFE_UL1_TML					32
+#define CLK_AFE_UL1_TML_AFE				33
+#define CLK_AFE_UL1_ADC					34
+#define CLK_AFE_UL1_ADC_AFE				35
+#define CLK_AFE_UL0_ADC_HIRES_TML			36
+#define CLK_AFE_UL0_ADC_HIRES_TML_AFE			37
+#define CLK_AFE_UL0_ADC_HIRES				38
+#define CLK_AFE_UL0_ADC_HIRES_AFE			39
+#define CLK_AFE_UL0_TML					40
+#define CLK_AFE_UL0_TML_AFE				41
+#define CLK_AFE_UL0_ADC					42
+#define CLK_AFE_UL0_ADC_AFE				43
+#define CLK_AFE_ETDM_IN6				44
+#define CLK_AFE_ETDM_IN6_AFE				45
+#define CLK_AFE_ETDM_IN5				46
+#define CLK_AFE_ETDM_IN5_AFE				47
+#define CLK_AFE_ETDM_IN4				48
+#define CLK_AFE_ETDM_IN4_AFE				49
+#define CLK_AFE_ETDM_IN3				50
+#define CLK_AFE_ETDM_IN3_AFE				51
+#define CLK_AFE_ETDM_IN2				52
+#define CLK_AFE_ETDM_IN2_AFE				53
+#define CLK_AFE_ETDM_IN1				54
+#define CLK_AFE_ETDM_IN1_AFE				55
+#define CLK_AFE_ETDM_IN0				56
+#define CLK_AFE_ETDM_IN0_AFE				57
+#define CLK_AFE_ETDM_OUT6				58
+#define CLK_AFE_ETDM_OUT6_AFE				59
+#define CLK_AFE_ETDM_OUT5				60
+#define CLK_AFE_ETDM_OUT5_AFE				61
+#define CLK_AFE_ETDM_OUT4				62
+#define CLK_AFE_ETDM_OUT4_AFE				63
+#define CLK_AFE_ETDM_OUT3				64
+#define CLK_AFE_ETDM_OUT3_AFE				65
+#define CLK_AFE_ETDM_OUT2				66
+#define CLK_AFE_ETDM_OUT2_AFE				67
+#define CLK_AFE_ETDM_OUT1				68
+#define CLK_AFE_ETDM_OUT1_AFE				69
+#define CLK_AFE_ETDM_OUT0				70
+#define CLK_AFE_ETDM_OUT0_AFE				71
+#define CLK_AFE_TDM_OUT					72
+#define CLK_AFE_TDM_OUT_AFE				73
+#define CLK_AFE_GENERAL15_ASRC				74
+#define CLK_AFE_GENERAL15_ASRC_AFE			75
+#define CLK_AFE_GENERAL14_ASRC				76
+#define CLK_AFE_GENERAL14_ASRC_AFE			77
+#define CLK_AFE_GENERAL13_ASRC				78
+#define CLK_AFE_GENERAL13_ASRC_AFE			79
+#define CLK_AFE_GENERAL12_ASRC				80
+#define CLK_AFE_GENERAL12_ASRC_AFE			81
+#define CLK_AFE_GENERAL11_ASRC				82
+#define CLK_AFE_GENERAL11_ASRC_AFE			83
+#define CLK_AFE_GENERAL10_ASRC				84
+#define CLK_AFE_GENERAL10_ASRC_AFE			85
+#define CLK_AFE_GENERAL9_ASRC				86
+#define CLK_AFE_GENERAL9_ASRC_AFE			87
+#define CLK_AFE_GENERAL8_ASRC				88
+#define CLK_AFE_GENERAL8_ASRC_AFE			89
+#define CLK_AFE_GENERAL7_ASRC				90
+#define CLK_AFE_GENERAL7_ASRC_AFE			91
+#define CLK_AFE_GENERAL6_ASRC				92
+#define CLK_AFE_GENERAL6_ASRC_AFE			93
+#define CLK_AFE_GENERAL5_ASRC				94
+#define CLK_AFE_GENERAL5_ASRC_AFE			95
+#define CLK_AFE_GENERAL4_ASRC				96
+#define CLK_AFE_GENERAL4_ASRC_AFE			97
+#define CLK_AFE_GENERAL3_ASRC				98
+#define CLK_AFE_GENERAL3_ASRC_AFE			99
+#define CLK_AFE_GENERAL2_ASRC				100
+#define CLK_AFE_GENERAL2_ASRC_AFE			101
+#define CLK_AFE_GENERAL1_ASRC				102
+#define CLK_AFE_GENERAL1_ASRC_AFE			103
+#define CLK_AFE_GENERAL0_ASRC				104
+#define CLK_AFE_GENERAL0_ASRC_AFE			105
+#define CLK_AFE_CONNSYS_I2S_ASRC			106
+#define CLK_AFE_CONNSYS_I2S_ASRC_AFE			107
+#define CLK_AFE_AUDIO_HOPPING				108
+#define CLK_AFE_AUDIO_HOPPING_AFE			109
+#define CLK_AFE_AUDIO_F26M				110
+#define CLK_AFE_AUDIO_F26M_AFE				111
+#define CLK_AFE_APLL1					112
+#define CLK_AFE_APLL1_AFE				113
+#define CLK_AFE_APLL2					114
+#define CLK_AFE_APLL2_AFE				115
+#define CLK_AFE_H208M					116
+#define CLK_AFE_H208M_AFE				117
+#define CLK_AFE_APLL_TUNER2				118
+#define CLK_AFE_APLL_TUNER2_AFE				119
+#define CLK_AFE_APLL_TUNER1				120
+#define CLK_AFE_APLL_TUNER1_AFE				121
+#define CLK_AFE_NR_CLK					122
+
+/* DISPSYS_CONFIG */
+#define CLK_MM_CONFIG					0
+#define CLK_MM_CONFIG_DISP				1
+#define CLK_MM_DISP_MUTEX0				2
+#define CLK_MM_DISP_MUTEX0_DISP				3
+#define CLK_MM_DISP_AAL0				4
+#define CLK_MM_DISP_AAL0_PQ				5
+#define CLK_MM_DISP_AAL1				6
+#define CLK_MM_DISP_AAL1_PQ				7
+#define CLK_MM_DISP_C3D0				8
+#define CLK_MM_DISP_C3D0_PQ				9
+#define CLK_MM_DISP_C3D1				10
+#define CLK_MM_DISP_C3D1_PQ				11
+#define CLK_MM_DISP_C3D2				12
+#define CLK_MM_DISP_C3D2_PQ				13
+#define CLK_MM_DISP_C3D3				14
+#define CLK_MM_DISP_C3D3_PQ				15
+#define CLK_MM_DISP_CCORR0				16
+#define CLK_MM_DISP_CCORR0_PQ				17
+#define CLK_MM_DISP_CCORR1				18
+#define CLK_MM_DISP_CCORR1_PQ				19
+#define CLK_MM_DISP_CCORR2				20
+#define CLK_MM_DISP_CCORR2_PQ				21
+#define CLK_MM_DISP_CCORR3				22
+#define CLK_MM_DISP_CCORR3_PQ				23
+#define CLK_MM_DISP_CHIST0				24
+#define CLK_MM_DISP_CHIST0_PQ				25
+#define CLK_MM_DISP_CHIST1				26
+#define CLK_MM_DISP_CHIST1_PQ				27
+#define CLK_MM_DISP_COLOR0				28
+#define CLK_MM_DISP_COLOR0_PQ				29
+#define CLK_MM_DISP_COLOR1				30
+#define CLK_MM_DISP_COLOR1_PQ				31
+#define CLK_MM_DISP_DITHER0				32
+#define CLK_MM_DISP_DITHER0_PQ				33
+#define CLK_MM_DISP_DITHER1				34
+#define CLK_MM_DISP_DITHER1_PQ				35
+#define CLK_MM_DISP_DLI_ASYNC0				36
+#define CLK_MM_DISP_DLI_ASYNC0_DISP			37
+#define CLK_MM_DISP_DLI_ASYNC1				38
+#define CLK_MM_DISP_DLI_ASYNC1_DISP			39
+#define CLK_MM_DISP_DLI_ASYNC2				40
+#define CLK_MM_DISP_DLI_ASYNC2_DISP			41
+#define CLK_MM_DISP_DLI_ASYNC3				42
+#define CLK_MM_DISP_DLI_ASYNC3_DISP			43
+#define CLK_MM_DISP_DLI_ASYNC4				44
+#define CLK_MM_DISP_DLI_ASYNC4_DISP			45
+#define CLK_MM_DISP_DLI_ASYNC5				46
+#define CLK_MM_DISP_DLI_ASYNC5_DISP			47
+#define CLK_MM_DISP_DLI_ASYNC6				48
+#define CLK_MM_DISP_DLI_ASYNC6_DISP			49
+#define CLK_MM_DISP_DLI_ASYNC7				50
+#define CLK_MM_DISP_DLI_ASYNC7_DISP			51
+#define CLK_MM_DISP_DLI_ASYNC8				52
+#define CLK_MM_DISP_DLI_ASYNC8_DISP			53
+#define CLK_MM_DISP_DLI_ASYNC9				54
+#define CLK_MM_DISP_DLI_ASYNC9_DISP			55
+#define CLK_MM_DISP_DLI_ASYNC10				56
+#define CLK_MM_DISP_DLI_ASYNC10_DISP			57
+#define CLK_MM_DISP_DLI_ASYNC11				58
+#define CLK_MM_DISP_DLI_ASYNC11_DISP			59
+#define CLK_MM_DISP_DLI_ASYNC12				60
+#define CLK_MM_DISP_DLI_ASYNC12_DISP			61
+#define CLK_MM_DISP_DLI_ASYNC13				62
+#define CLK_MM_DISP_DLI_ASYNC13_DISP			63
+#define CLK_MM_DISP_DLI_ASYNC14				64
+#define CLK_MM_DISP_DLI_ASYNC14_DISP			65
+#define CLK_MM_DISP_DLI_ASYNC15				66
+#define CLK_MM_DISP_DLI_ASYNC15_DISP			67
+#define CLK_MM_DISP_DLO_ASYNC0				68
+#define CLK_MM_DISP_DLO_ASYNC0_DISP			69
+#define CLK_MM_DISP_DLO_ASYNC1				70
+#define CLK_MM_DISP_DLO_ASYNC1_DISP			71
+#define CLK_MM_DISP_DLO_ASYNC2				72
+#define CLK_MM_DISP_DLO_ASYNC2_DISP			73
+#define CLK_MM_DISP_DLO_ASYNC3				74
+#define CLK_MM_DISP_DLO_ASYNC3_DISP			75
+#define CLK_MM_DISP_DLO_ASYNC4				76
+#define CLK_MM_DISP_DLO_ASYNC4_DISP			77
+#define CLK_MM_DISP_DLO_ASYNC5				78
+#define CLK_MM_DISP_DLO_ASYNC5_DISP			79
+#define CLK_MM_DISP_DLO_ASYNC6				80
+#define CLK_MM_DISP_DLO_ASYNC6_DISP			81
+#define CLK_MM_DISP_DLO_ASYNC7				82
+#define CLK_MM_DISP_DLO_ASYNC7_DISP			83
+#define CLK_MM_DISP_DLO_ASYNC8				84
+#define CLK_MM_DISP_DLO_ASYNC8_DISP			85
+#define CLK_MM_DISP_GAMMA0				86
+#define CLK_MM_DISP_GAMMA0_PQ				87
+#define CLK_MM_DISP_GAMMA1				88
+#define CLK_MM_DISP_GAMMA1_PQ				89
+#define CLK_MM_MDP_AAL0					90
+#define CLK_MM_MDP_AAL0_PQ				91
+#define CLK_MM_MDP_AAL1					92
+#define CLK_MM_MDP_AAL1_PQ				93
+#define CLK_MM_MDP_RDMA0				94
+#define CLK_MM_MDP_RDMA0_DISP				95
+#define CLK_MM_DISP_POSTMASK0				96
+#define CLK_MM_DISP_POSTMASK0_DISP			97
+#define CLK_MM_DISP_POSTMASK1				98
+#define CLK_MM_DISP_POSTMASK1_DISP			99
+#define CLK_MM_MDP_RSZ0					100
+#define CLK_MM_MDP_RSZ0_DISP				101
+#define CLK_MM_MDP_RSZ1					102
+#define CLK_MM_MDP_RSZ1_DISP				103
+#define CLK_MM_DISP_SPR0				104
+#define CLK_MM_DISP_SPR0_DISP				105
+#define CLK_MM_DISP_TDSHP0				106
+#define CLK_MM_DISP_TDSHP0_PQ				107
+#define CLK_MM_DISP_TDSHP1				108
+#define CLK_MM_DISP_TDSHP1_PQ				109
+#define CLK_MM_DISP_WDMA0				110
+#define CLK_MM_DISP_WDMA0_DISP				111
+#define CLK_MM_DISP_Y2R0				112
+#define CLK_MM_DISP_Y2R0_DISP				113
+#define CLK_MM_SMI_SUB_COMM0				114
+#define CLK_MM_SMI_SUB_COMM0_SMI			115
+#define CLK_MM_DISP_FAKE_ENG0				116
+#define CLK_MM_DISP_FAKE_ENG0_DISP			117
+#define CLK_MM_NR_CLK					118
+
+/* DISPSYS1_CONFIG */
+#define CLK_MM1_DISPSYS1_CONFIG				0
+#define CLK_MM1_DISPSYS1_CONFIG_DISP			1
+#define CLK_MM1_DISPSYS1_S_CONFIG			2
+#define CLK_MM1_DISPSYS1_S_CONFIG_DISP			3
+#define CLK_MM1_DISP_MUTEX0				4
+#define CLK_MM1_DISP_MUTEX0_DISP			5
+#define CLK_MM1_DISP_DLI_ASYNC20			6
+#define CLK_MM1_DISP_DLI_ASYNC20_DISP			7
+#define CLK_MM1_DISP_DLI_ASYNC21			8
+#define CLK_MM1_DISP_DLI_ASYNC21_DISP			9
+#define CLK_MM1_DISP_DLI_ASYNC22			10
+#define CLK_MM1_DISP_DLI_ASYNC22_DISP			11
+#define CLK_MM1_DISP_DLI_ASYNC23			12
+#define CLK_MM1_DISP_DLI_ASYNC23_DISP			13
+#define CLK_MM1_DISP_DLI_ASYNC24			14
+#define CLK_MM1_DISP_DLI_ASYNC24_DISP			15
+#define CLK_MM1_DISP_DLI_ASYNC25			16
+#define CLK_MM1_DISP_DLI_ASYNC25_DISP			17
+#define CLK_MM1_DISP_DLI_ASYNC26			18
+#define CLK_MM1_DISP_DLI_ASYNC26_DISP			19
+#define CLK_MM1_DISP_DLI_ASYNC27			20
+#define CLK_MM1_DISP_DLI_ASYNC27_DISP			21
+#define CLK_MM1_DISP_DLI_ASYNC28			22
+#define CLK_MM1_DISP_DLI_ASYNC28_DISP			23
+#define CLK_MM1_DISP_RELAY0				24
+#define CLK_MM1_DISP_RELAY0_DISP			25
+#define CLK_MM1_DISP_RELAY1				26
+#define CLK_MM1_DISP_RELAY1_DISP			27
+#define CLK_MM1_DISP_RELAY2				28
+#define CLK_MM1_DISP_RELAY2_DISP			29
+#define CLK_MM1_DISP_RELAY3				30
+#define CLK_MM1_DISP_RELAY3_DISP			31
+#define CLK_MM1_DISP_DP_INTF0				32
+#define CLK_MM1_DISP_DP_INTF0_DISP			33
+#define CLK_MM1_DISP_DP_INTF1				34
+#define CLK_MM1_DISP_DP_INTF1_DISP			35
+#define CLK_MM1_DISP_DSC_WRAP0				36
+#define CLK_MM1_DISP_DSC_WRAP0_DISP			37
+#define CLK_MM1_DISP_DSC_WRAP1				38
+#define CLK_MM1_DISP_DSC_WRAP1_DISP			39
+#define CLK_MM1_DISP_DSC_WRAP2				40
+#define CLK_MM1_DISP_DSC_WRAP2_DISP			41
+#define CLK_MM1_DISP_DSC_WRAP3				42
+#define CLK_MM1_DISP_DSC_WRAP3_DISP			43
+#define CLK_MM1_DISP_DSI0				44
+#define CLK_MM1_DISP_DSI0_DISP				45
+#define CLK_MM1_DISP_DSI1				46
+#define CLK_MM1_DISP_DSI1_DISP				47
+#define CLK_MM1_DISP_DSI2				48
+#define CLK_MM1_DISP_DSI2_DISP				49
+#define CLK_MM1_DISP_DVO0				50
+#define CLK_MM1_DISP_DVO0_DISP				51
+#define CLK_MM1_DISP_GDMA0				52
+#define CLK_MM1_DISP_GDMA0_DISP				53
+#define CLK_MM1_DISP_MERGE0				54
+#define CLK_MM1_DISP_MERGE0_DISP			55
+#define CLK_MM1_DISP_MERGE1				56
+#define CLK_MM1_DISP_MERGE1_DISP			57
+#define CLK_MM1_DISP_MERGE2				58
+#define CLK_MM1_DISP_MERGE2_DISP			59
+#define CLK_MM1_DISP_ODDMR0				60
+#define CLK_MM1_DISP_ODDMR0_PQ				61
+#define CLK_MM1_DISP_POSTALIGN0				62
+#define CLK_MM1_DISP_POSTALIGN0_PQ			63
+#define CLK_MM1_DISP_DITHER2				64
+#define CLK_MM1_DISP_DITHER2_PQ				65
+#define CLK_MM1_DISP_R2Y0				66
+#define CLK_MM1_DISP_R2Y0_DISP				67
+#define CLK_MM1_DISP_SPLITTER0				68
+#define CLK_MM1_DISP_SPLITTER0_DISP			69
+#define CLK_MM1_DISP_SPLITTER1				70
+#define CLK_MM1_DISP_SPLITTER1_DISP			71
+#define CLK_MM1_DISP_SPLITTER2				72
+#define CLK_MM1_DISP_SPLITTER2_DISP			73
+#define CLK_MM1_DISP_SPLITTER3				74
+#define CLK_MM1_DISP_SPLITTER3_DISP			75
+#define CLK_MM1_DISP_VDCM0				76
+#define CLK_MM1_DISP_VDCM0_DISP				77
+#define CLK_MM1_DISP_WDMA1				78
+#define CLK_MM1_DISP_WDMA1_DISP				79
+#define CLK_MM1_DISP_WDMA2				80
+#define CLK_MM1_DISP_WDMA2_DISP				81
+#define CLK_MM1_DISP_WDMA3				82
+#define CLK_MM1_DISP_WDMA3_DISP				83
+#define CLK_MM1_DISP_WDMA4				84
+#define CLK_MM1_DISP_WDMA4_DISP				85
+#define CLK_MM1_MDP_RDMA1				86
+#define CLK_MM1_MDP_RDMA1_DISP				87
+#define CLK_MM1_SMI_LARB0				88
+#define CLK_MM1_SMI_LARB0_SMI				89
+#define CLK_MM1_MOD1					90
+#define CLK_MM1_MOD1_DISP				91
+#define CLK_MM1_MOD2					92
+#define CLK_MM1_MOD2_DISP				93
+#define CLK_MM1_MOD3					94
+#define CLK_MM1_MOD3_DISP				95
+#define CLK_MM1_MOD4					96
+#define CLK_MM1_MOD4_DISP				97
+#define CLK_MM1_MOD5					98
+#define CLK_MM1_MOD5_DISP				99
+#define CLK_MM1_MOD6					100
+#define CLK_MM1_MOD6_DISP				101
+#define CLK_MM1_CK_CG0					102
+#define CLK_MM1_CK_CG0_DISP				103
+#define CLK_MM1_CK_CG1					104
+#define CLK_MM1_CK_CG1_DISP				105
+#define CLK_MM1_CK_CG2					106
+#define CLK_MM1_CK_CG2_DISP				107
+#define CLK_MM1_CK_CG3					108
+#define CLK_MM1_CK_CG3_DISP				109
+#define CLK_MM1_CK_CG4					110
+#define CLK_MM1_CK_CG4_DISP				111
+#define CLK_MM1_CK_CG5					112
+#define CLK_MM1_CK_CG5_DISP				113
+#define CLK_MM1_CK_CG6					114
+#define CLK_MM1_CK_CG6_DISP				115
+#define CLK_MM1_CK_CG7					116
+#define CLK_MM1_CK_CG7_DISP				117
+#define CLK_MM1_F26M					118
+#define CLK_MM1_F26M_DISP				119
+#define CLK_MM1_NR_CLK					120
+
+/* OVLSYS_CONFIG */
+#define CLK_OVLSYS_CONFIG				0
+#define CLK_OVLSYS_CONFIG_DISP				1
+#define CLK_OVL_FAKE_ENG0				2
+#define CLK_OVL_FAKE_ENG0_DISP				3
+#define CLK_OVL_FAKE_ENG1				4
+#define CLK_OVL_FAKE_ENG1_DISP				5
+#define CLK_OVL_MUTEX0					6
+#define CLK_OVL_MUTEX0_DISP				7
+#define CLK_OVL_EXDMA0					8
+#define CLK_OVL_EXDMA0_DISP				9
+#define CLK_OVL_EXDMA1					10
+#define CLK_OVL_EXDMA1_DISP				11
+#define CLK_OVL_EXDMA2					12
+#define CLK_OVL_EXDMA2_DISP				13
+#define CLK_OVL_EXDMA3					14
+#define CLK_OVL_EXDMA3_DISP				15
+#define CLK_OVL_EXDMA4					16
+#define CLK_OVL_EXDMA4_DISP				17
+#define CLK_OVL_EXDMA5					18
+#define CLK_OVL_EXDMA5_DISP				19
+#define CLK_OVL_EXDMA6					20
+#define CLK_OVL_EXDMA6_DISP				21
+#define CLK_OVL_EXDMA7					22
+#define CLK_OVL_EXDMA7_DISP				23
+#define CLK_OVL_EXDMA8					24
+#define CLK_OVL_EXDMA8_DISP				25
+#define CLK_OVL_EXDMA9					26
+#define CLK_OVL_EXDMA9_DISP				27
+#define CLK_OVL_BLENDER0				28
+#define CLK_OVL_BLENDER0_DISP				29
+#define CLK_OVL_BLENDER1				30
+#define CLK_OVL_BLENDER1_DISP				31
+#define CLK_OVL_BLENDER2				32
+#define CLK_OVL_BLENDER2_DISP				33
+#define CLK_OVL_BLENDER3				34
+#define CLK_OVL_BLENDER3_DISP				35
+#define CLK_OVL_BLENDER4				36
+#define CLK_OVL_BLENDER4_DISP				37
+#define CLK_OVL_BLENDER5				38
+#define CLK_OVL_BLENDER5_DISP				39
+#define CLK_OVL_BLENDER6				40
+#define CLK_OVL_BLENDER6_DISP				41
+#define CLK_OVL_BLENDER7				42
+#define CLK_OVL_BLENDER7_DISP				43
+#define CLK_OVL_BLENDER8				44
+#define CLK_OVL_BLENDER8_DISP				45
+#define CLK_OVL_BLENDER9				46
+#define CLK_OVL_BLENDER9_DISP				47
+#define CLK_OVL_OUTPROC0				48
+#define CLK_OVL_OUTPROC0_DISP				49
+#define CLK_OVL_OUTPROC1				50
+#define CLK_OVL_OUTPROC1_DISP				51
+#define CLK_OVL_OUTPROC2				52
+#define CLK_OVL_OUTPROC2_DISP				53
+#define CLK_OVL_OUTPROC3				54
+#define CLK_OVL_OUTPROC3_DISP				55
+#define CLK_OVL_OUTPROC4				56
+#define CLK_OVL_OUTPROC4_DISP				57
+#define CLK_OVL_OUTPROC5				58
+#define CLK_OVL_OUTPROC5_DISP				59
+#define CLK_OVL_MDP_RSZ0				60
+#define CLK_OVL_MDP_RSZ0_DISP				61
+#define CLK_OVL_MDP_RSZ1				62
+#define CLK_OVL_MDP_RSZ1_DISP				63
+#define CLK_OVL_DISP_WDMA0				64
+#define CLK_OVL_DISP_WDMA0_DISP				65
+#define CLK_OVL_DISP_WDMA1				66
+#define CLK_OVL_DISP_WDMA1_DISP				67
+#define CLK_OVL_UFBC_WDMA0				68
+#define CLK_OVL_UFBC_WDMA0_DISP				69
+#define CLK_OVL_MDP_RDMA0				70
+#define CLK_OVL_MDP_RDMA0_DISP				71
+#define CLK_OVL_MDP_RDMA1				72
+#define CLK_OVL_MDP_RDMA1_DISP				73
+#define CLK_OVL_BWM0					74
+#define CLK_OVL_BWM0_DISP				75
+#define CLK_OVL_DLI0					76
+#define CLK_OVL_DLI0_DISP				77
+#define CLK_OVL_DLI1					78
+#define CLK_OVL_DLI1_DISP				79
+#define CLK_OVL_DLI2					80
+#define CLK_OVL_DLI2_DISP				81
+#define CLK_OVL_DLI3					82
+#define CLK_OVL_DLI3_DISP				83
+#define CLK_OVL_DLI4					84
+#define CLK_OVL_DLI4_DISP				85
+#define CLK_OVL_DLI5					86
+#define CLK_OVL_DLI5_DISP				87
+#define CLK_OVL_DLI6					88
+#define CLK_OVL_DLI6_DISP				89
+#define CLK_OVL_DLI7					90
+#define CLK_OVL_DLI7_DISP				91
+#define CLK_OVL_DLI8					92
+#define CLK_OVL_DLI8_DISP				93
+#define CLK_OVL_DLO0					94
+#define CLK_OVL_DLO0_DISP				95
+#define CLK_OVL_DLO1					96
+#define CLK_OVL_DLO1_DISP				97
+#define CLK_OVL_DLO2					98
+#define CLK_OVL_DLO2_DISP				99
+#define CLK_OVL_DLO3					100
+#define CLK_OVL_DLO3_DISP				101
+#define CLK_OVL_DLO4					102
+#define CLK_OVL_DLO4_DISP				103
+#define CLK_OVL_DLO5					104
+#define CLK_OVL_DLO5_DISP				105
+#define CLK_OVL_DLO6					106
+#define CLK_OVL_DLO6_DISP				107
+#define CLK_OVL_DLO7					108
+#define CLK_OVL_DLO7_DISP				109
+#define CLK_OVL_DLO8					110
+#define CLK_OVL_DLO8_DISP				111
+#define CLK_OVL_DLO9					112
+#define CLK_OVL_DLO9_DISP				113
+#define CLK_OVL_DLO10					114
+#define CLK_OVL_DLO10_DISP				115
+#define CLK_OVL_DLO11					116
+#define CLK_OVL_DLO11_DISP				117
+#define CLK_OVL_DLO12					118
+#define CLK_OVL_DLO12_DISP				119
+#define CLK_OVLSYS_RELAY0				120
+#define CLK_OVLSYS_RELAY0_DISP				121
+#define CLK_OVL_INLINEROT0				122
+#define CLK_OVL_INLINEROT0_DISP				123
+#define CLK_OVL_SMI					124
+#define CLK_OVL_SMI_SMI					125
+#define CLK_OVL_NR_CLK					126
+
+/* OVLSYS1_CONFIG */
+#define CLK_OVL1_OVLSYS_CONFIG				0
+#define CLK_OVL1_OVLSYS_CONFIG_DISP			1
+#define CLK_OVL1_OVL_FAKE_ENG0				2
+#define CLK_OVL1_OVL_FAKE_ENG0_DISP			3
+#define CLK_OVL1_OVL_FAKE_ENG1				4
+#define CLK_OVL1_OVL_FAKE_ENG1_DISP			5
+#define CLK_OVL1_OVL_MUTEX0				6
+#define CLK_OVL1_OVL_MUTEX0_DISP			7
+#define CLK_OVL1_OVL_EXDMA0				8
+#define CLK_OVL1_OVL_EXDMA0_DISP			9
+#define CLK_OVL1_OVL_EXDMA1				10
+#define CLK_OVL1_OVL_EXDMA1_DISP			11
+#define CLK_OVL1_OVL_EXDMA2				12
+#define CLK_OVL1_OVL_EXDMA2_DISP			13
+#define CLK_OVL1_OVL_EXDMA3				14
+#define CLK_OVL1_OVL_EXDMA3_DISP			15
+#define CLK_OVL1_OVL_EXDMA4				16
+#define CLK_OVL1_OVL_EXDMA4_DISP			17
+#define CLK_OVL1_OVL_EXDMA5				18
+#define CLK_OVL1_OVL_EXDMA5_DISP			19
+#define CLK_OVL1_OVL_EXDMA6				20
+#define CLK_OVL1_OVL_EXDMA6_DISP			21
+#define CLK_OVL1_OVL_EXDMA7				22
+#define CLK_OVL1_OVL_EXDMA7_DISP			23
+#define CLK_OVL1_OVL_EXDMA8				24
+#define CLK_OVL1_OVL_EXDMA8_DISP			25
+#define CLK_OVL1_OVL_EXDMA9				26
+#define CLK_OVL1_OVL_EXDMA9_DISP			27
+#define CLK_OVL1_OVL_BLENDER0				28
+#define CLK_OVL1_OVL_BLENDER0_DISP			29
+#define CLK_OVL1_OVL_BLENDER1				30
+#define CLK_OVL1_OVL_BLENDER1_DISP			31
+#define CLK_OVL1_OVL_BLENDER2				32
+#define CLK_OVL1_OVL_BLENDER2_DISP			33
+#define CLK_OVL1_OVL_BLENDER3				34
+#define CLK_OVL1_OVL_BLENDER3_DISP			35
+#define CLK_OVL1_OVL_BLENDER4				36
+#define CLK_OVL1_OVL_BLENDER4_DISP			37
+#define CLK_OVL1_OVL_BLENDER5				38
+#define CLK_OVL1_OVL_BLENDER5_DISP			39
+#define CLK_OVL1_OVL_BLENDER6				40
+#define CLK_OVL1_OVL_BLENDER6_DISP			41
+#define CLK_OVL1_OVL_BLENDER7				42
+#define CLK_OVL1_OVL_BLENDER7_DISP			43
+#define CLK_OVL1_OVL_BLENDER8				44
+#define CLK_OVL1_OVL_BLENDER8_DISP			45
+#define CLK_OVL1_OVL_BLENDER9				46
+#define CLK_OVL1_OVL_BLENDER9_DISP			47
+#define CLK_OVL1_OVL_OUTPROC0				48
+#define CLK_OVL1_OVL_OUTPROC0_DISP			49
+#define CLK_OVL1_OVL_OUTPROC1				50
+#define CLK_OVL1_OVL_OUTPROC1_DISP			51
+#define CLK_OVL1_OVL_OUTPROC2				52
+#define CLK_OVL1_OVL_OUTPROC2_DISP			53
+#define CLK_OVL1_OVL_OUTPROC3				54
+#define CLK_OVL1_OVL_OUTPROC3_DISP			55
+#define CLK_OVL1_OVL_OUTPROC4				56
+#define CLK_OVL1_OVL_OUTPROC4_DISP			57
+#define CLK_OVL1_OVL_OUTPROC5				58
+#define CLK_OVL1_OVL_OUTPROC5_DISP			59
+#define CLK_OVL1_OVL_MDP_RSZ0				60
+#define CLK_OVL1_OVL_MDP_RSZ0_DISP			61
+#define CLK_OVL1_OVL_MDP_RSZ1				62
+#define CLK_OVL1_OVL_MDP_RSZ1_DISP			63
+#define CLK_OVL1_OVL_DISP_WDMA0				64
+#define CLK_OVL1_OVL_DISP_WDMA0_DISP			65
+#define CLK_OVL1_OVL_DISP_WDMA1				66
+#define CLK_OVL1_OVL_DISP_WDMA1_DISP			67
+#define CLK_OVL1_OVL_UFBC_WDMA0				68
+#define CLK_OVL1_OVL_UFBC_WDMA0_DISP			69
+#define CLK_OVL1_OVL_MDP_RDMA0				70
+#define CLK_OVL1_OVL_MDP_RDMA0_DISP			71
+#define CLK_OVL1_OVL_MDP_RDMA1				72
+#define CLK_OVL1_OVL_MDP_RDMA1_DISP			73
+#define CLK_OVL1_OVL_BWM0				74
+#define CLK_OVL1_OVL_BWM0_DISP				75
+#define CLK_OVL1_DLI0					76
+#define CLK_OVL1_DLI0_DISP				77
+#define CLK_OVL1_DLI1					78
+#define CLK_OVL1_DLI1_DISP				79
+#define CLK_OVL1_DLI2					80
+#define CLK_OVL1_DLI2_DISP				81
+#define CLK_OVL1_DLI3					82
+#define CLK_OVL1_DLI3_DISP				83
+#define CLK_OVL1_DLI4					84
+#define CLK_OVL1_DLI4_DISP				85
+#define CLK_OVL1_DLI5					86
+#define CLK_OVL1_DLI5_DISP				87
+#define CLK_OVL1_DLI6					88
+#define CLK_OVL1_DLI6_DISP				89
+#define CLK_OVL1_DLI7					90
+#define CLK_OVL1_DLI7_DISP				91
+#define CLK_OVL1_DLI8					92
+#define CLK_OVL1_DLI8_DISP				93
+#define CLK_OVL1_DLO0					94
+#define CLK_OVL1_DLO0_DISP				95
+#define CLK_OVL1_DLO1					96
+#define CLK_OVL1_DLO1_DISP				97
+#define CLK_OVL1_DLO2					98
+#define CLK_OVL1_DLO2_DISP				99
+#define CLK_OVL1_DLO3					100
+#define CLK_OVL1_DLO3_DISP				101
+#define CLK_OVL1_DLO4					102
+#define CLK_OVL1_DLO4_DISP				103
+#define CLK_OVL1_DLO5					104
+#define CLK_OVL1_DLO5_DISP				105
+#define CLK_OVL1_DLO6					106
+#define CLK_OVL1_DLO6_DISP				107
+#define CLK_OVL1_DLO7					108
+#define CLK_OVL1_DLO7_DISP				109
+#define CLK_OVL1_DLO8					110
+#define CLK_OVL1_DLO8_DISP				111
+#define CLK_OVL1_DLO9					112
+#define CLK_OVL1_DLO9_DISP				113
+#define CLK_OVL1_DLO10					114
+#define CLK_OVL1_DLO10_DISP				115
+#define CLK_OVL1_DLO11					116
+#define CLK_OVL1_DLO11_DISP				117
+#define CLK_OVL1_DLO12					118
+#define CLK_OVL1_DLO12_DISP				119
+#define CLK_OVL1_OVLSYS_RELAY0				120
+#define CLK_OVL1_OVLSYS_RELAY0_DISP			121
+#define CLK_OVL1_OVL_INLINEROT0				122
+#define CLK_OVL1_OVL_INLINEROT0_DISP			123
+#define CLK_OVL1_SMI					124
+#define CLK_OVL1_SMI_SMI				125
+#define CLK_OVL1_NR_CLK					126
+
+/* VDEC_SOC_GCON_BASE */
+#define CLK_VDE1_LARB1_CKEN				0
+#define CLK_VDE1_LARB1_CKEN_VDEC			1
+#define CLK_VDE1_LARB1_CKEN_SMI				2
+#define CLK_VDE1_LAT_CKEN				3
+#define CLK_VDE1_LAT_CKEN_VDEC				4
+#define CLK_VDE1_LAT_ACTIVE				5
+#define CLK_VDE1_LAT_ACTIVE_VDEC			6
+#define CLK_VDE1_LAT_CKEN_ENG				7
+#define CLK_VDE1_LAT_CKEN_ENG_VDEC			8
+#define CLK_VDE1_VDEC_CKEN				9
+#define CLK_VDE1_VDEC_CKEN_VDEC				10
+#define CLK_VDE1_VDEC_ACTIVE				11
+#define CLK_VDE1_VDEC_ACTIVE_VDEC			12
+#define CLK_VDE1_VDEC_CKEN_ENG				13
+#define CLK_VDE1_VDEC_CKEN_ENG_VDEC			14
+#define CLK_VDE1_VDEC_SOC_APTV_EN			15
+#define CLK_VDE1_VDEC_SOC_APTV_EN_VDEC			16
+#define CLK_VDE1_VDEC_SOC_APTV_TOP_EN			17
+#define CLK_VDE1_VDEC_SOC_APTV_TOP_EN_VDEC		18
+#define CLK_VDE1_VDEC_SOC_IPS_EN			19
+#define CLK_VDE1_VDEC_SOC_IPS_EN_VDEC			20
+#define CLK_VDE1_NR_CLK					21
+
+/* VDEC_GCON_BASE */
+#define CLK_VDE2_LARB1_CKEN				0
+#define CLK_VDE2_LARB1_CKEN_VDEC			1
+#define CLK_VDE2_LARB1_CKEN_SMI				2
+#define CLK_VDE2_LAT_CKEN				3
+#define CLK_VDE2_LAT_CKEN_VDEC				4
+#define CLK_VDE2_LAT_ACTIVE				5
+#define CLK_VDE2_LAT_ACTIVE_VDEC			6
+#define CLK_VDE2_LAT_CKEN_ENG				7
+#define CLK_VDE2_LAT_CKEN_ENG_VDEC			8
+#define CLK_VDE2_VDEC_CKEN				9
+#define CLK_VDE2_VDEC_CKEN_VDEC				10
+#define CLK_VDE2_VDEC_ACTIVE				11
+#define CLK_VDE2_VDEC_ACTIVE_VDEC			12
+#define CLK_VDE2_VDEC_CKEN_ENG				13
+#define CLK_VDE2_VDEC_CKEN_ENG_VDEC			14
+#define CLK_VDE2_NR_CLK					15
+
+/* VENC_GCON */
+#define CLK_VEN1_CKE0_LARB				0
+#define CLK_VEN1_CKE0_LARB_VENC				1
+#define CLK_VEN1_CKE0_LARB_JPGENC			2
+#define CLK_VEN1_CKE0_LARB_JPGDEC			3
+#define CLK_VEN1_CKE0_LARB_SMI				4
+#define CLK_VEN1_CKE1_VENC				5
+#define CLK_VEN1_CKE1_VENC_VENC				6
+#define CLK_VEN1_CKE1_VENC_SMI				7
+#define CLK_VEN1_CKE2_JPGENC				8
+#define CLK_VEN1_CKE2_JPGENC_JPGENC			9
+#define CLK_VEN1_CKE3_JPGDEC				10
+#define CLK_VEN1_CKE3_JPGDEC_JPGDEC			11
+#define CLK_VEN1_CKE4_JPGDEC_C1				12
+#define CLK_VEN1_CKE4_JPGDEC_C1_JPGDEC			13
+#define CLK_VEN1_CKE5_GALS				14
+#define CLK_VEN1_CKE5_GALS_VENC				15
+#define CLK_VEN1_CKE5_GALS_JPGENC			16
+#define CLK_VEN1_CKE5_GALS_JPGDEC			17
+#define CLK_VEN1_CKE29_VENC_ADAB_CTRL			18
+#define CLK_VEN1_CKE29_VENC_ADAB_CTRL_VENC		19
+#define CLK_VEN1_CKE29_VENC_XPC_CTRL			20
+#define CLK_VEN1_CKE29_VENC_XPC_CTRL_VENC		21
+#define CLK_VEN1_CKE29_VENC_XPC_CTRL_JPGENC		22
+#define CLK_VEN1_CKE29_VENC_XPC_CTRL_JPGDEC		23
+#define CLK_VEN1_CKE6_GALS_SRAM				24
+#define CLK_VEN1_CKE6_GALS_SRAM_VENC			25
+#define CLK_VEN1_RES_FLAT				26
+#define CLK_VEN1_RES_FLAT_VENC				27
+#define CLK_VEN1_RES_FLAT_JPGENC			28
+#define CLK_VEN1_RES_FLAT_JPGDEC			29
+#define CLK_VEN1_NR_CLK					30
+
+/* VENC_GCON_CORE1 */
+#define CLK_VEN2_CKE0_LARB				0
+#define CLK_VEN2_CKE0_LARB_VENC				1
+#define CLK_VEN2_CKE0_LARB_JPGENC			2
+#define CLK_VEN2_CKE0_LARB_JPGDEC			3
+#define CLK_VEN2_CKE0_LARB_SMI				4
+#define CLK_VEN2_CKE1_VENC				5
+#define CLK_VEN2_CKE1_VENC_VENC				6
+#define CLK_VEN2_CKE1_VENC_SMI				7
+#define CLK_VEN2_CKE2_JPGENC				8
+#define CLK_VEN2_CKE2_JPGENC_JPGENC			9
+#define CLK_VEN2_CKE3_JPGDEC				10
+#define CLK_VEN2_CKE3_JPGDEC_JPGDEC			11
+#define CLK_VEN2_CKE5_GALS				12
+#define CLK_VEN2_CKE5_GALS_VENC				13
+#define CLK_VEN2_CKE5_GALS_JPGENC			14
+#define CLK_VEN2_CKE5_GALS_JPGDEC			15
+#define CLK_VEN2_CKE29_VENC_XPC_CTRL			16
+#define CLK_VEN2_CKE29_VENC_XPC_CTRL_VENC		17
+#define CLK_VEN2_CKE29_VENC_XPC_CTRL_JPGENC		18
+#define CLK_VEN2_CKE29_VENC_XPC_CTRL_JPGDEC		19
+#define CLK_VEN2_CKE6_GALS_SRAM				20
+#define CLK_VEN2_CKE6_GALS_SRAM_VENC			21
+#define CLK_VEN2_RES_FLAT				22
+#define CLK_VEN2_RES_FLAT_VENC				23
+#define CLK_VEN2_RES_FLAT_JPGENC			24
+#define CLK_VEN2_RES_FLAT_JPGDEC			25
+#define CLK_VEN2_NR_CLK					26
+
+/* VENC_GCON_CORE2 */
+#define CLK_VEN_C2_CKE0_LARB				0
+#define CLK_VEN_C2_CKE0_LARB_VENC			1
+#define CLK_VEN_C2_CKE0_LARB_SMI			2
+#define CLK_VEN_C2_CKE1_VENC				3
+#define CLK_VEN_C2_CKE1_VENC_VENC			4
+#define CLK_VEN_C2_CKE1_VENC_SMI			5
+#define CLK_VEN_C2_CKE5_GALS				6
+#define CLK_VEN_C2_CKE5_GALS_VENC			7
+#define CLK_VEN_C2_CKE29_VENC_XPC_CTRL			8
+#define CLK_VEN_C2_CKE29_VENC_XPC_CTRL_VENC		9
+#define CLK_VEN_C2_CKE6_GALS_SRAM			10
+#define CLK_VEN_C2_CKE6_GALS_SRAM_VENC			11
+#define CLK_VEN_C2_RES_FLAT				12
+#define CLK_VEN_C2_RES_FLAT_VENC			13
+#define CLK_VEN_C2_NR_CLK				14
+
+/* MDPSYS_CONFIG */
+#define CLK_MDP_MDP_MUTEX0				0
+#define CLK_MDP_MDP_MUTEX0_MML				1
+#define CLK_MDP_SMI0					2
+#define CLK_MDP_SMI0_MML				3
+#define CLK_MDP_SMI0_SMI				4
+#define CLK_MDP_APB_BUS					5
+#define CLK_MDP_APB_BUS_MML				6
+#define CLK_MDP_MDP_RDMA0				7
+#define CLK_MDP_MDP_RDMA0_MML				8
+#define CLK_MDP_MDP_RDMA1				9
+#define CLK_MDP_MDP_RDMA1_MML				10
+#define CLK_MDP_MDP_RDMA2				11
+#define CLK_MDP_MDP_RDMA2_MML				12
+#define CLK_MDP_MDP_BIRSZ0				13
+#define CLK_MDP_MDP_BIRSZ0_MML				14
+#define CLK_MDP_MDP_HDR0				15
+#define CLK_MDP_MDP_HDR0_MML				16
+#define CLK_MDP_MDP_AAL0				17
+#define CLK_MDP_MDP_AAL0_MML				18
+#define CLK_MDP_MDP_RSZ0				19
+#define CLK_MDP_MDP_RSZ0_MML				20
+#define CLK_MDP_MDP_RSZ2				21
+#define CLK_MDP_MDP_RSZ2_MML				22
+#define CLK_MDP_MDP_TDSHP0				23
+#define CLK_MDP_MDP_TDSHP0_MML				24
+#define CLK_MDP_MDP_COLOR0				25
+#define CLK_MDP_MDP_COLOR0_MML				26
+#define CLK_MDP_MDP_WROT0				27
+#define CLK_MDP_MDP_WROT0_MML				28
+#define CLK_MDP_MDP_WROT1				29
+#define CLK_MDP_MDP_WROT1_MML				30
+#define CLK_MDP_MDP_WROT2				31
+#define CLK_MDP_MDP_WROT2_MML				32
+#define CLK_MDP_MDP_FAKE_ENG0				33
+#define CLK_MDP_MDP_FAKE_ENG0_MML			34
+#define CLK_MDP_APB_DB					35
+#define CLK_MDP_APB_DB_MML				36
+#define CLK_MDP_MDP_DLI_ASYNC0				37
+#define CLK_MDP_MDP_DLI_ASYNC0_MML			38
+#define CLK_MDP_MDP_DLI_ASYNC1				39
+#define CLK_MDP_MDP_DLI_ASYNC1_MML			40
+#define CLK_MDP_MDP_DLO_ASYNC0				41
+#define CLK_MDP_MDP_DLO_ASYNC0_MML			42
+#define CLK_MDP_MDP_DLO_ASYNC1				43
+#define CLK_MDP_MDP_DLO_ASYNC1_MML			44
+#define CLK_MDP_MDP_DLI_ASYNC2				45
+#define CLK_MDP_MDP_DLI_ASYNC2_MML			46
+#define CLK_MDP_MDP_DLO_ASYNC2				47
+#define CLK_MDP_MDP_DLO_ASYNC2_MML			48
+#define CLK_MDP_MDP_DLO_ASYNC3				49
+#define CLK_MDP_MDP_DLO_ASYNC3_MML			50
+#define CLK_MDP_IMG_DL_ASYNC0				51
+#define CLK_MDP_IMG_DL_ASYNC0_MML			52
+#define CLK_MDP_MDP_RROT0				53
+#define CLK_MDP_MDP_RROT0_MML				54
+#define CLK_MDP_MDP_MERGE0				55
+#define CLK_MDP_MDP_MERGE0_MML				56
+#define CLK_MDP_MDP_C3D0				57
+#define CLK_MDP_MDP_C3D0_MML				58
+#define CLK_MDP_MDP_FG0					59
+#define CLK_MDP_MDP_FG0_MML				60
+#define CLK_MDP_MDP_CLA2				61
+#define CLK_MDP_MDP_CLA2_MML				62
+#define CLK_MDP_MDP_DLO_ASYNC4				63
+#define CLK_MDP_MDP_DLO_ASYNC4_MML			64
+#define CLK_MDP_VPP_RSZ0				65
+#define CLK_MDP_VPP_RSZ0_MML				66
+#define CLK_MDP_VPP_RSZ1				67
+#define CLK_MDP_VPP_RSZ1_MML				68
+#define CLK_MDP_MDP_DLO_ASYNC5				69
+#define CLK_MDP_MDP_DLO_ASYNC5_MML			70
+#define CLK_MDP_IMG0					71
+#define CLK_MDP_IMG0_MML				72
+#define CLK_MDP_F26M					73
+#define CLK_MDP_F26M_MML				74
+#define CLK_MDP_IMG_DL_RELAY0				75
+#define CLK_MDP_IMG_DL_RELAY0_MML			76
+#define CLK_MDP_IMG_DL_RELAY1				77
+#define CLK_MDP_IMG_DL_RELAY1_MML			78
+#define CLK_MDP_NR_CLK					79
+
+/* MDPSYS1_CONFIG */
+#define CLK_MDP1_MDP_MUTEX0				0
+#define CLK_MDP1_MDP_MUTEX0_MML				1
+#define CLK_MDP1_SMI0					2
+#define CLK_MDP1_SMI0_SMI				3
+#define CLK_MDP1_APB_BUS				4
+#define CLK_MDP1_APB_BUS_MML				5
+#define CLK_MDP1_MDP_RDMA0				6
+#define CLK_MDP1_MDP_RDMA0_MML				7
+#define CLK_MDP1_MDP_RDMA1				8
+#define CLK_MDP1_MDP_RDMA1_MML				9
+#define CLK_MDP1_MDP_RDMA2				10
+#define CLK_MDP1_MDP_RDMA2_MML				11
+#define CLK_MDP1_MDP_BIRSZ0				12
+#define CLK_MDP1_MDP_BIRSZ0_MML				13
+#define CLK_MDP1_MDP_HDR0				14
+#define CLK_MDP1_MDP_HDR0_MML				15
+#define CLK_MDP1_MDP_AAL0				16
+#define CLK_MDP1_MDP_AAL0_MML				17
+#define CLK_MDP1_MDP_RSZ0				18
+#define CLK_MDP1_MDP_RSZ0_MML				19
+#define CLK_MDP1_MDP_RSZ2				20
+#define CLK_MDP1_MDP_RSZ2_MML				21
+#define CLK_MDP1_MDP_TDSHP0				22
+#define CLK_MDP1_MDP_TDSHP0_MML				23
+#define CLK_MDP1_MDP_COLOR0				24
+#define CLK_MDP1_MDP_COLOR0_MML				25
+#define CLK_MDP1_MDP_WROT0				26
+#define CLK_MDP1_MDP_WROT0_MML				27
+#define CLK_MDP1_MDP_WROT1				28
+#define CLK_MDP1_MDP_WROT1_MML				29
+#define CLK_MDP1_MDP_WROT2				30
+#define CLK_MDP1_MDP_WROT2_MML				31
+#define CLK_MDP1_MDP_FAKE_ENG0				32
+#define CLK_MDP1_MDP_FAKE_ENG0_MML			33
+#define CLK_MDP1_APB_DB					34
+#define CLK_MDP1_APB_DB_MML				35
+#define CLK_MDP1_MDP_DLI_ASYNC0				36
+#define CLK_MDP1_MDP_DLI_ASYNC0_MML			37
+#define CLK_MDP1_MDP_DLI_ASYNC1				38
+#define CLK_MDP1_MDP_DLI_ASYNC1_MML			39
+#define CLK_MDP1_MDP_DLO_ASYNC0				40
+#define CLK_MDP1_MDP_DLO_ASYNC0_MML			41
+#define CLK_MDP1_MDP_DLO_ASYNC1				42
+#define CLK_MDP1_MDP_DLO_ASYNC1_MML			43
+#define CLK_MDP1_MDP_DLI_ASYNC2				44
+#define CLK_MDP1_MDP_DLI_ASYNC2_MML			45
+#define CLK_MDP1_MDP_DLO_ASYNC2				46
+#define CLK_MDP1_MDP_DLO_ASYNC2_MML			47
+#define CLK_MDP1_MDP_DLO_ASYNC3				48
+#define CLK_MDP1_MDP_DLO_ASYNC3_MML			49
+#define CLK_MDP1_IMG_DL_ASYNC0				50
+#define CLK_MDP1_IMG_DL_ASYNC0_MML			51
+#define CLK_MDP1_MDP_RROT0				52
+#define CLK_MDP1_MDP_RROT0_MML				53
+#define CLK_MDP1_MDP_MERGE0				54
+#define CLK_MDP1_MDP_MERGE0_MML				55
+#define CLK_MDP1_MDP_C3D0				56
+#define CLK_MDP1_MDP_C3D0_MML				57
+#define CLK_MDP1_MDP_FG0				58
+#define CLK_MDP1_MDP_FG0_MML				59
+#define CLK_MDP1_MDP_CLA2				60
+#define CLK_MDP1_MDP_CLA2_MML				61
+#define CLK_MDP1_MDP_DLO_ASYNC4				62
+#define CLK_MDP1_MDP_DLO_ASYNC4_MML			63
+#define CLK_MDP1_VPP_RSZ0				64
+#define CLK_MDP1_VPP_RSZ0_MML				65
+#define CLK_MDP1_VPP_RSZ1				66
+#define CLK_MDP1_VPP_RSZ1_MML				67
+#define CLK_MDP1_MDP_DLO_ASYNC5				68
+#define CLK_MDP1_MDP_DLO_ASYNC5_MML			69
+#define CLK_MDP1_IMG0					70
+#define CLK_MDP1_IMG0_MML				71
+#define CLK_MDP1_F26M					72
+#define CLK_MDP1_F26M_MML				73
+#define CLK_MDP1_IMG_DL_RELAY0				74
+#define CLK_MDP1_IMG_DL_RELAY0_MML			75
+#define CLK_MDP1_IMG_DL_RELAY1				76
+#define CLK_MDP1_IMG_DL_RELAY1_MML			77
+#define CLK_MDP1_NR_CLK					78
+
+/* DISP_VDISP_AO_CONFIG */
+#define CLK_MM_V_DISP_VDISP_AO_CONFIG			0
+#define CLK_MM_V_DISP_VDISP_AO_CONFIG_DISP		1
+#define CLK_MM_V_DISP_DPC				2
+#define CLK_MM_V_DISP_DPC_DISP				3
+#define CLK_MM_V_SMI_SUB_SOMM0				4
+#define CLK_MM_V_SMI_SUB_SOMM0_SMI			5
+#define CLK_MM_V_NR_CLK					6
+
+/* MFGPLL_PLL_CTRL */
+#define CLK_MFG_AO_MFGPLL				0
+#define CLK_MFG_AO_NR_CLK				1
+
+/* MFGPLL_SC0_PLL_CTRL */
+#define CLK_MFGSC0_AO_MFGPLL_SC0			0
+#define CLK_MFGSC0_AO_NR_CLK				1
+
+/* MFGPLL_SC1_PLL_CTRL */
+#define CLK_MFGSC1_AO_MFGPLL_SC1			0
+#define CLK_MFGSC1_AO_NR_CLK				1
+
+/* CCIPLL_PLL_CTRL */
+#define CLK_CCIPLL					0
+#define CLK_CCI_NR_CLK					1
+
+/* ARMPLL_LL_PLL_CTRL */
+#define CLK_CPLL_ARMPLL_LL				0
+#define CLK_CPU_LL_NR_CLK				1
+
+/* ARMPLL_BL_PLL_CTRL */
+#define CLK_CPBL_ARMPLL_BL				0
+#define CLK_CPU_BL_NR_CLK				1
+
+/* ARMPLL_B_PLL_CTRL */
+#define CLK_CPB_ARMPLL_B				0
+#define CLK_CPU_B_NR_CLK				1
+
+/* PTPPLL_PLL_CTRL */
+#define CLK_PTPPLL					0
+#define CLK_PTP_NR_CLK					1
+
+#endif /* _DT_BINDINGS_CLK_MT8196_H */
-- 
2.45.2


