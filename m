Return-Path: <netdev+bounces-306241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rodBEO2oT2rxlwIAu9opvQ
	(envelope-from <netdev+bounces-306241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:58:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C342A731DB0
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:58:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=QpeBKQ4s;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306241-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F15E830B4CFF
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B341F7EF;
	Thu,  9 Jul 2026 13:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD240803B;
	Thu,  9 Jul 2026 13:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604589; cv=none; b=fHN+iRSYIWxB36Mxxxw9w2Bz28BkqgSeiOX5KZG5T5/soLfhOzO01HbiONrRO0i8fnI6kE9FofggYsiWTW7Yd7JR+24jvc/gsf7sua/faGCdsII9L0zVKIMGsnfKiK6+z+fdgr7jrTnoIJXJp0HtbaY70EClkVUqRMH9yOn/dao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604589; c=relaxed/simple;
	bh=sVf4JWxTXvJ5fXNFoSwmODDw0D/u3efriRVaKk26m1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7ZkPP8rRVizbGzvfHaXDn+H4goSe7gCnARl79V0K+WDcNWOca5OFhmIJkCW2okbXBxEagVGkLyUbNNiRjFNO5UvUjiW57amhuoGVJ4hEDe2VuIcuma2438FnkD+41PcTEds+4wsNxS4hVXlk9fKJmRh4eDnbyzkSSqamWjHOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QpeBKQ4s; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783604585;
	bh=sVf4JWxTXvJ5fXNFoSwmODDw0D/u3efriRVaKk26m1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QpeBKQ4suon7kLyD4HRnpLiGPlz/2I+WkPWy8ReAGQOoewmP33gVHVsihOsnCFMAm
	 f/olUkKdCR+n4rEQ0CoPKyskPCRmFeBggm6n6EIQA75NrpW0oxpxoHPiqjhrEWqUIg
	 00fiRueXnPUNAfDN+FGi4RhpVbPgOwKaOBb45OPrTYq73ZxlVARQinyozIiBCFpFLf
	 jaxYEzRzNkslASIBtHyvO8RHyJRCujQ9W6DqMyZMRDgtA2MMo+bwPfzL7fkU4jpgn/
	 XLYVN1gcDnIoqtOKll0iwPVlGbwioYnCNJZgU3xwZVl3lnR4uETlZKEXytjJrYFLPU
	 j+wcyQOiMgnTQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 793DA17E0EE1;
	Thu, 09 Jul 2026 15:43:04 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 09 Jul 2026 15:42:48 +0200
Subject: [PATCH v2 08/18] dt-bindings: clock: mediatek: Add MT8189 clocks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8189-clocks-system-base-v2-8-2926da3db6cf@collabora.com>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783604575; l=19952;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=sVf4JWxTXvJ5fXNFoSwmODDw0D/u3efriRVaKk26m1M=;
 b=kU2S40btWyoYKaZgefRTGgDlhma64u/8DdGtlxP1j4+8VIIkuhxRJT/CYSqnxDDXGmHb1YoM9
 gJIoIw/2eRgDFrIU/u+gDax+JCD/77oRG1mSew0LfMFFJnw7hfb31eL
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306241-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C342A731DB0

Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
The MT8189 clock IP provide clock control for main system
(apmixedsys, topcksys and vlpcksys) and subsys (eg. peri, scp,
ufs...).

Also, add compatible for frequency hopping and spread spectrum clock
functionality and reset controller header file for MT8189 UFS reset
controller support.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml      |  15 +
 .../bindings/clock/mediatek,mt8186-fhctl.yaml      |   1 +
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   5 +
 include/dt-bindings/clock/mediatek,mt8189-clk.h    | 433 +++++++++++++++++++++
 include/dt-bindings/reset/mediatek,mt8189-resets.h |  17 +
 5 files changed, 471 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index ab9f8cb7dd6e..380dab8f4e98 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -58,6 +58,19 @@ properties:
           - mediatek,mt8188-vencsys
           - mediatek,mt8188-wpesys
           - mediatek,mt8188-wpesys-vpp0
+          - mediatek,mt8189-dbg-ao
+          - mediatek,mt8189-dem
+          - mediatek,mt8189-dvfsrc-top
+          - mediatek,mt8189-iic-wrap-e
+          - mediatek,mt8189-iic-wrap-en
+          - mediatek,mt8189-iic-wrap-s
+          - mediatek,mt8189-iic-wrap-ws
+          - mediatek,mt8189-scp-clk
+          - mediatek,mt8189-scp-i2c-clk
+          - mediatek,mt8189-ufscfg-ao
+          - mediatek,mt8189-ufscfg-pdn
+          - mediatek,mt8189-vlpcfg
+          - mediatek,mt8189-vlpcfg-ao
           - mediatek,mt8192-camsys
           - mediatek,mt8192-camsys_rawa
           - mediatek,mt8192-camsys_rawb
@@ -133,6 +146,8 @@ allOf:
             - mediatek,mt8188-imgsys1-dip-nr
             - mediatek,mt8188-imgsys1-dip-top
             - mediatek,mt8188-ipesys
+            - mediatek,mt8189-ufscfg-ao
+            - mediatek,mt8189-ufscfg-pdn
     then:
       required:
         - '#reset-cells'
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
index d00327d12e1e..824e3b2bd6c0 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
@@ -20,6 +20,7 @@ properties:
       - mediatek,mt6795-fhctl
       - mediatek,mt8173-fhctl
       - mediatek,mt8186-fhctl
+      - mediatek,mt8189-fhctl
       - mediatek,mt8192-fhctl
       - mediatek,mt8195-fhctl
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 4a9d3eea4316..2575f84ef917 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -35,6 +35,11 @@ properties:
           - mediatek,mt8188-infracfg-ao
           - mediatek,mt8188-pericfg-ao
           - mediatek,mt8188-topckgen
+          - mediatek,mt8189-apmixedsys
+          - mediatek,mt8189-infra-ao
+          - mediatek,mt8189-peri-ao
+          - mediatek,mt8189-topckgen
+          - mediatek,mt8189-vlpckgen
           - mediatek,mt8192-apmixedsys
           - mediatek,mt8192-infracfg
           - mediatek,mt8192-pericfg
diff --git a/include/dt-bindings/clock/mediatek,mt8189-clk.h b/include/dt-bindings/clock/mediatek,mt8189-clk.h
new file mode 100644
index 000000000000..ca433f969698
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt8189-clk.h
@@ -0,0 +1,433 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)  */
+/*
+ * Copyright (C) 2025-2026 MediaTek Inc.
+ *                    Qiqi Wang <qiqi.wang@mediatek.com>
+ *                    Irving-CH Lin <irving-ch.lin@mediatek.com>
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8189_H
+#define _DT_BINDINGS_CLK_MT8189_H
+
+/* TOPCKGEN */
+#define CLK_TOP_AXI_SEL					0
+#define CLK_TOP_AXI_PERI_SEL				1
+#define CLK_TOP_AXI_U_SEL				2
+#define CLK_TOP_BUS_AXIMEM_SEL				3
+#define CLK_TOP_DISP0_SEL				4
+#define CLK_TOP_MMINFRA_SEL				5
+#define CLK_TOP_UART_SEL				6
+#define CLK_TOP_SPI0_SEL				7
+#define CLK_TOP_SPI1_SEL				8
+#define CLK_TOP_SPI2_SEL				9
+#define CLK_TOP_SPI3_SEL				10
+#define CLK_TOP_SPI4_SEL				11
+#define CLK_TOP_SPI5_SEL				12
+#define CLK_TOP_MSDC_MACRO_0P_SEL			13
+#define CLK_TOP_MSDC50_0_HCLK_SEL			14
+#define CLK_TOP_MSDC50_0_SEL				15
+#define CLK_TOP_AES_MSDCFDE_SEL				16
+#define CLK_TOP_MSDC_MACRO_1P_SEL			17
+#define CLK_TOP_MSDC30_1_SEL				18
+#define CLK_TOP_MSDC30_1_HCLK_SEL			19
+#define CLK_TOP_MSDC_MACRO_2P_SEL			20
+#define CLK_TOP_MSDC30_2_SEL				21
+#define CLK_TOP_MSDC30_2_HCLK_SEL			22
+#define CLK_TOP_AUD_INTBUS_SEL				23
+#define CLK_TOP_ATB_SEL					24
+#define CLK_TOP_DISP_PWM_SEL				25
+#define CLK_TOP_USB_TOP_P0_SEL				26
+#define CLK_TOP_USB_XHCI_P0_SEL				27
+#define CLK_TOP_USB_TOP_P1_SEL				28
+#define CLK_TOP_USB_XHCI_P1_SEL				29
+#define CLK_TOP_USB_TOP_P2_SEL				30
+#define CLK_TOP_USB_XHCI_P2_SEL				31
+#define CLK_TOP_USB_TOP_P3_SEL				32
+#define CLK_TOP_USB_XHCI_P3_SEL				33
+#define CLK_TOP_USB_TOP_P4_SEL				34
+#define CLK_TOP_USB_XHCI_P4_SEL				35
+#define CLK_TOP_I2C_SEL					36
+#define CLK_TOP_SENINF_SEL				37
+#define CLK_TOP_SENINF1_SEL				38
+#define CLK_TOP_AUD_ENGEN1_SEL				39
+#define CLK_TOP_AUD_ENGEN2_SEL				40
+#define CLK_TOP_AES_UFSFDE_SEL				41
+#define CLK_TOP_U_SEL					42
+#define CLK_TOP_U_MBIST_SEL				43
+#define CLK_TOP_AUD_1_SEL				44
+#define CLK_TOP_AUD_2_SEL				45
+#define CLK_TOP_VENC_SEL				46
+#define CLK_TOP_VDEC_SEL				47
+#define CLK_TOP_PWM_SEL					48
+#define CLK_TOP_AUDIO_H_SEL				49
+#define CLK_TOP_MCUPM_SEL				50
+#define CLK_TOP_MEM_SUB_SEL				51
+#define CLK_TOP_MEM_SUB_PERI_SEL			52
+#define CLK_TOP_MEM_SUB_U_SEL				53
+#define CLK_TOP_EMI_N_SEL				54
+#define CLK_TOP_DSI_OCC_SEL				55
+#define CLK_TOP_AP2CONN_HOST_SEL			56
+#define CLK_TOP_IMG1_SEL				57
+#define CLK_TOP_IPE_SEL					58
+#define CLK_TOP_CAM_SEL					59
+#define CLK_TOP_CAMTM_SEL				60
+#define CLK_TOP_DSP_SEL					61
+#define CLK_TOP_SR_PKA_SEL				62
+#define CLK_TOP_DXCC_SEL				63
+#define CLK_TOP_MFG_REF_SEL				64
+#define CLK_TOP_MDP0_SEL				65
+#define CLK_TOP_DP_SEL					66
+#define CLK_TOP_EDP_SEL					67
+#define CLK_TOP_EDP_FAVT_SEL				68
+#define CLK_TOP_ETH_250M_SEL				69
+#define CLK_TOP_ETH_62P4M_PTP_SEL			70
+#define CLK_TOP_ETH_50M_RMII_SEL			71
+#define CLK_TOP_SFLASH_SEL				72
+#define CLK_TOP_GCPU_SEL				73
+#define CLK_TOP_MAC_TL_SEL				74
+#define CLK_TOP_VDSTX_DG_CTS_SEL			75
+#define CLK_TOP_PLL_DPIX_SEL				76
+#define CLK_TOP_ECC_SEL					77
+#define CLK_TOP_APLL_I2SIN0_MCK_SEL			78
+#define CLK_TOP_APLL_I2SIN1_MCK_SEL			79
+#define CLK_TOP_APLL_I2SIN2_MCK_SEL			80
+#define CLK_TOP_APLL_I2SIN3_MCK_SEL			81
+#define CLK_TOP_APLL_I2SIN4_MCK_SEL			82
+#define CLK_TOP_APLL_I2SIN6_MCK_SEL			83
+#define CLK_TOP_APLL_I2SOUT0_MCK_SEL			84
+#define CLK_TOP_APLL_I2SOUT1_MCK_SEL			85
+#define CLK_TOP_APLL_I2SOUT2_MCK_SEL			86
+#define CLK_TOP_APLL_I2SOUT3_MCK_SEL			87
+#define CLK_TOP_APLL_I2SOUT4_MCK_SEL			88
+#define CLK_TOP_APLL_I2SOUT6_MCK_SEL			89
+#define CLK_TOP_APLL_FMI2S_MCK_SEL			90
+#define CLK_TOP_APLL_TDMOUT_MCK_SEL			91
+#define CLK_TOP_MFG_SEL_MFGPLL				92
+#define CLK_TOP_APLL12_CK_DIV_I2SIN0			93
+#define CLK_TOP_APLL12_CK_DIV_I2SIN1			94
+#define CLK_TOP_APLL12_CK_DIV_I2SOUT0			95
+#define CLK_TOP_APLL12_CK_DIV_I2SOUT1			96
+#define CLK_TOP_APLL12_CK_DIV_FMI2S			97
+#define CLK_TOP_APLL12_CK_DIV_TDMOUT_M			98
+#define CLK_TOP_APLL12_CK_DIV_TDMOUT_B			99
+#define CLK_TOP_MAINPLL_D3				100
+#define CLK_TOP_MAINPLL_D4				101
+#define CLK_TOP_MAINPLL_D4_D2				102
+#define CLK_TOP_MAINPLL_D4_D4				103
+#define CLK_TOP_MAINPLL_D4_D8				104
+#define CLK_TOP_MAINPLL_D5				105
+#define CLK_TOP_MAINPLL_D5_D2				106
+#define CLK_TOP_MAINPLL_D5_D4				107
+#define CLK_TOP_MAINPLL_D5_D8				108
+#define CLK_TOP_MAINPLL_D6				109
+#define CLK_TOP_MAINPLL_D6_D2				110
+#define CLK_TOP_MAINPLL_D6_D4				111
+#define CLK_TOP_MAINPLL_D6_D8				112
+#define CLK_TOP_MAINPLL_D7				113
+#define CLK_TOP_MAINPLL_D7_D2				114
+#define CLK_TOP_MAINPLL_D7_D4				115
+#define CLK_TOP_MAINPLL_D7_D8				116
+#define CLK_TOP_MAINPLL_D9				117
+#define CLK_TOP_UNIVPLL_D2				118
+#define CLK_TOP_UNIVPLL_D3				119
+#define CLK_TOP_UNIVPLL_D4				120
+#define CLK_TOP_UNIVPLL_D4_D2				121
+#define CLK_TOP_UNIVPLL_D4_D4				122
+#define CLK_TOP_UNIVPLL_D4_D8				123
+#define CLK_TOP_UNIVPLL_D5				124
+#define CLK_TOP_UNIVPLL_D5_D2				125
+#define CLK_TOP_UNIVPLL_D5_D4				126
+#define CLK_TOP_UNIVPLL_D6				127
+#define CLK_TOP_UNIVPLL_D6_D2				128
+#define CLK_TOP_UNIVPLL_D6_D4				129
+#define CLK_TOP_UNIVPLL_D6_D8				130
+#define CLK_TOP_UNIVPLL_D6_D16				131
+#define CLK_TOP_UNIVPLL_D7				132
+#define CLK_TOP_UNIVPLL_D7_D2				133
+#define CLK_TOP_UNIVPLL_D7_D3				134
+#define CLK_TOP_LVDSTX_DG_CTS				135
+#define CLK_TOP_UNIVPLL_192M				136
+#define CLK_TOP_UNIVPLL_192M_D2				137
+#define CLK_TOP_UNIVPLL_192M_D4				138
+#define CLK_TOP_UNIVPLL_192M_D8				139
+#define CLK_TOP_UNIVPLL_192M_D10			140
+#define CLK_TOP_UNIVPLL_192M_D16			141
+#define CLK_TOP_UNIVPLL_192M_D32			142
+#define CLK_TOP_APLL1_D2				143
+#define CLK_TOP_APLL1_D4				144
+#define CLK_TOP_APLL1_D8				145
+#define CLK_TOP_APLL1_D3				146
+#define CLK_TOP_APLL2_D2				147
+#define CLK_TOP_APLL2_D4				148
+#define CLK_TOP_APLL2_D8				149
+#define CLK_TOP_APLL2_D3				150
+#define CLK_TOP_MMPLL_D4				151
+#define CLK_TOP_MMPLL_D4_D2				152
+#define CLK_TOP_MMPLL_D4_D4				153
+#define CLK_TOP_VPLL_DPIX				154
+#define CLK_TOP_MMPLL_D5				155
+#define CLK_TOP_MMPLL_D5_D2				156
+#define CLK_TOP_MMPLL_D5_D4				157
+#define CLK_TOP_MMPLL_D6				158
+#define CLK_TOP_MMPLL_D6_D2				159
+#define CLK_TOP_MMPLL_D7				160
+#define CLK_TOP_MMPLL_D9				161
+#define CLK_TOP_TVDPLL1_D2				162
+#define CLK_TOP_TVDPLL1_D4				163
+#define CLK_TOP_TVDPLL1_D8				164
+#define CLK_TOP_TVDPLL1_D16				165
+#define CLK_TOP_TVDPLL2_D2				166
+#define CLK_TOP_TVDPLL2_D4				167
+#define CLK_TOP_TVDPLL2_D8				168
+#define CLK_TOP_TVDPLL2_D16				169
+#define CLK_TOP_ETHPLL_D2				170
+#define CLK_TOP_ETHPLL_D8				171
+#define CLK_TOP_ETHPLL_D10				172
+#define CLK_TOP_MSDCPLL_D2				173
+#define CLK_TOP_UFSPLL_D2				174
+#define CLK_TOP_F26M_CK_D2				175
+#define CLK_TOP_OSC_D2					176
+#define CLK_TOP_OSC_D4					177
+#define CLK_TOP_OSC_D8					178
+#define CLK_TOP_OSC_D16					179
+#define CLK_TOP_OSC_D3					180
+#define CLK_TOP_OSC_D7					181
+#define CLK_TOP_OSC_D10					182
+#define CLK_TOP_OSC_D20					183
+#define CLK_TOP_FMCNT_P0_EN				184
+#define CLK_TOP_FMCNT_P1_EN				185
+#define CLK_TOP_FMCNT_P2_EN				186
+#define CLK_TOP_FMCNT_P3_EN				187
+#define CLK_TOP_FMCNT_P4_EN				188
+#define CLK_TOP_USB_F26M_CK_EN				189
+#define CLK_TOP_SSPXTP_F26M_CK_EN			190
+#define CLK_TOP_USB2_PHY_RF_P0_EN			191
+#define CLK_TOP_USB2_PHY_RF_P1_EN			192
+#define CLK_TOP_USB2_PHY_RF_P2_EN			193
+#define CLK_TOP_USB2_PHY_RF_P3_EN			194
+#define CLK_TOP_USB2_PHY_RF_P4_EN			195
+#define CLK_TOP_USB2_26M_CK_P0_EN			196
+#define CLK_TOP_USB2_26M_CK_P1_EN			197
+#define CLK_TOP_USB2_26M_CK_P2_EN			198
+#define CLK_TOP_USB2_26M_CK_P3_EN			199
+#define CLK_TOP_USB2_26M_CK_P4_EN			200
+#define CLK_TOP_F26M_CK_EN				201
+#define CLK_TOP_AP2CON_EN				202
+#define CLK_TOP_EINT_N_EN				203
+#define CLK_TOP_TOPCKGEN_FMIPI_CSI_UP26M_CK_EN		204
+#define CLK_TOP_EINT_E_EN				205
+#define CLK_TOP_EINT_W_EN				206
+#define CLK_TOP_EINT_S_EN				207
+
+/* INFRACFG_AO */
+#define CLK_IFRAO_CQ_DMA_FPC				0
+#define CLK_IFRAO_DEBUGSYS				1
+#define CLK_IFRAO_DBG_TRACE				2
+#define CLK_IFRAO_CQ_DMA				3
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_ARMPLL_LL				0
+#define CLK_APMIXED_ARMPLL_BL				1
+#define CLK_APMIXED_CCIPLL				2
+#define CLK_APMIXED_MAINPLL				3
+#define CLK_APMIXED_UNIVPLL				4
+#define CLK_APMIXED_MMPLL				5
+#define CLK_APMIXED_MFGPLL				6
+#define CLK_APMIXED_APLL1				7
+#define CLK_APMIXED_APLL2				8
+#define CLK_APMIXED_EMIPLL				9
+#define CLK_APMIXED_APUPLL2				10
+#define CLK_APMIXED_APUPLL				11
+#define CLK_APMIXED_TVDPLL1				12
+#define CLK_APMIXED_TVDPLL2				13
+#define CLK_APMIXED_ETHPLL				14
+#define CLK_APMIXED_MSDCPLL				15
+#define CLK_APMIXED_UFSPLL				16
+
+/* PERICFG_AO */
+#define CLK_PERAO_UART0					0
+#define CLK_PERAO_UART1					1
+#define CLK_PERAO_UART2					2
+#define CLK_PERAO_UART3					3
+#define CLK_PERAO_PWM_H					4
+#define CLK_PERAO_PWM_B					5
+#define CLK_PERAO_PWM_FB1				6
+#define CLK_PERAO_PWM_FB2				7
+#define CLK_PERAO_PWM_FB3				8
+#define CLK_PERAO_PWM_FB4				9
+#define CLK_PERAO_DISP_PWM0				10
+#define CLK_PERAO_DISP_PWM1				11
+#define CLK_PERAO_SPI0_B				12
+#define CLK_PERAO_SPI1_B				13
+#define CLK_PERAO_SPI2_B				14
+#define CLK_PERAO_SPI3_B				15
+#define CLK_PERAO_SPI4_B				16
+#define CLK_PERAO_SPI5_B				17
+#define CLK_PERAO_SPI0_H				18
+#define CLK_PERAO_SPI1_H				19
+#define CLK_PERAO_SPI2_H				20
+#define CLK_PERAO_SPI3_H				21
+#define CLK_PERAO_SPI4_H				22
+#define CLK_PERAO_SPI5_H				23
+#define CLK_PERAO_AXI					24
+#define CLK_PERAO_AHB_APB				25
+#define CLK_PERAO_TL					26
+#define CLK_PERAO_REF					27
+#define CLK_PERAO_I2C					28
+#define CLK_PERAO_DMA_B					29
+#define CLK_PERAO_SSUSB0_REF				30
+#define CLK_PERAO_SSUSB0_FRMCNT				31
+#define CLK_PERAO_SSUSB0_SYS				32
+#define CLK_PERAO_SSUSB0_XHCI				33
+#define CLK_PERAO_SSUSB0_F				34
+#define CLK_PERAO_SSUSB0_H				35
+#define CLK_PERAO_SSUSB1_REF				36
+#define CLK_PERAO_SSUSB1_FRMCNT				37
+#define CLK_PERAO_SSUSB1_SYS				38
+#define CLK_PERAO_SSUSB1_XHCI				39
+#define CLK_PERAO_SSUSB1_F				40
+#define CLK_PERAO_SSUSB1_H				41
+#define CLK_PERAO_SSUSB2_REF				42
+#define CLK_PERAO_SSUSB2_FRMCNT				43
+#define CLK_PERAO_SSUSB2_SYS				44
+#define CLK_PERAO_SSUSB2_XHCI				45
+#define CLK_PERAO_SSUSB2_F				46
+#define CLK_PERAO_SSUSB2_H				47
+#define CLK_PERAO_SSUSB3_REF				48
+#define CLK_PERAO_SSUSB3_FRMCNT				49
+#define CLK_PERAO_SSUSB3_SYS				50
+#define CLK_PERAO_SSUSB3_XHCI				51
+#define CLK_PERAO_SSUSB3_F				52
+#define CLK_PERAO_SSUSB3_H				53
+#define CLK_PERAO_SSUSB4_REF				54
+#define CLK_PERAO_SSUSB4_FRMCNT				55
+#define CLK_PERAO_SSUSB4_SYS				56
+#define CLK_PERAO_SSUSB4_XHCI				57
+#define CLK_PERAO_SSUSB4_F				58
+#define CLK_PERAO_SSUSB4_H				59
+#define CLK_PERAO_MSDC0					60
+#define CLK_PERAO_MSDC0_H				61
+#define CLK_PERAO_MSDC0_FAES				62
+#define CLK_PERAO_MSDC0_MST_F				63
+#define CLK_PERAO_MSDC0_SLV_H				64
+#define CLK_PERAO_MSDC1					65
+#define CLK_PERAO_MSDC1_H				66
+#define CLK_PERAO_MSDC1_MST_F				67
+#define CLK_PERAO_MSDC1_SLV_H				68
+#define CLK_PERAO_MSDC2					69
+#define CLK_PERAO_MSDC2_H				70
+#define CLK_PERAO_MSDC2_MST_F				71
+#define CLK_PERAO_MSDC2_SLV_H				72
+#define CLK_PERAO_SFLASH				73
+#define CLK_PERAO_SFLASH_F				74
+#define CLK_PERAO_SFLASH_H				75
+#define CLK_PERAO_SFLASH_P				76
+#define CLK_PERAO_AUDIO0				77
+#define CLK_PERAO_AUDIO1				78
+#define CLK_PERAO_AUDIO2				79
+#define CLK_PERAO_AUXADC_26M				80
+
+/* UFSCFG_AO_REG */
+#define CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM			0
+#define CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0		1
+#define CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1		2
+#define CLK_UFSCFG_AO_REG_UNIPRO_SYS			3
+#define CLK_UFSCFG_AO_REG_U_SAP_CFG			4
+#define CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS		5
+
+/* UFSCFG_PDN_REG */
+#define CLK_UFSCFG_REG_UFSHCI_UFS			0
+#define CLK_UFSCFG_REG_UFSHCI_AES			1
+#define CLK_UFSCFG_REG_UFSHCI_U_AHB			2
+#define CLK_UFSCFG_REG_UFSHCI_U_AXI			3
+
+/* IMP_IIC_WRAP_WS */
+#define CLK_IMPWS_I2C2					0
+
+/* IMP_IIC_WRAP_E */
+#define CLK_IMPE_I2C0					0
+#define CLK_IMPE_I2C1					1
+
+/* IMP_IIC_WRAP_S */
+#define CLK_IMPS_I2C3					0
+#define CLK_IMPS_I2C4					1
+#define CLK_IMPS_I2C5					2
+#define CLK_IMPS_I2C6					3
+
+/* IMP_IIC_WRAP_EN */
+#define CLK_IMPEN_I2C7					0
+#define CLK_IMPEN_I2C8					1
+
+/* VLPCFG_REG */
+#define CLK_VLPCFG_REG_SCP				0
+#define CLK_VLPCFG_REG_RG_R_APXGPT_26M			1
+#define CLK_VLPCFG_REG_DPMSRCK_TEST			2
+#define CLK_VLPCFG_REG_RG_DPMSRRTC_TEST			3
+#define CLK_VLPCFG_REG_DPMSRULP_TEST			4
+#define CLK_VLPCFG_REG_SPMI_P_MST			5
+#define CLK_VLPCFG_REG_SPMI_P_MST_32K			6
+#define CLK_VLPCFG_REG_PMIF_SPMI_P_SYS			7
+#define CLK_VLPCFG_REG_PMIF_SPMI_P_TMR			8
+#define CLK_VLPCFG_REG_PMIF_SPMI_M_SYS			9
+#define CLK_VLPCFG_REG_PMIF_SPMI_M_TMR			10
+#define CLK_VLPCFG_REG_DVFSRC				11
+#define CLK_VLPCFG_REG_PWM_VLP				12
+#define CLK_VLPCFG_REG_SRCK				13
+#define CLK_VLPCFG_REG_SSPM_F26M			14
+#define CLK_VLPCFG_REG_SSPM_F32K			15
+#define CLK_VLPCFG_REG_SSPM_ULPOSC			16
+#define CLK_VLPCFG_REG_VLP_32K_COM			17
+#define CLK_VLPCFG_REG_VLP_26M_COM			18
+
+/* VLP_CKSYS */
+#define CLK_VLP_CK_SCP_SEL				0
+#define CLK_VLP_CK_PWRAP_ULPOSC_SEL			1
+#define CLK_VLP_CK_SPMI_P_MST_SEL			2
+#define CLK_VLP_CK_DVFSRC_SEL				3
+#define CLK_VLP_CK_PWM_VLP_SEL				4
+#define CLK_VLP_CK_AXI_VLP_SEL				5
+#define CLK_VLP_CK_SYSTIMER_26M_SEL			6
+#define CLK_VLP_CK_SSPM_SEL				7
+#define CLK_VLP_CK_SSPM_F26M_SEL			8
+#define CLK_VLP_CK_SRCK_SEL				9
+#define CLK_VLP_CK_SCP_SPI_SEL				10
+#define CLK_VLP_CK_SCP_IIC_SEL				11
+#define CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL			12
+#define CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL			13
+#define CLK_VLP_CK_SSPM_ULPOSC_SEL			14
+#define CLK_VLP_CK_APXGPT_26M_SEL			15
+#define CLK_VLP_CK_VADSP_SEL				16
+#define CLK_VLP_CK_VADSP_VOWPLL_SEL			17
+#define CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL		18
+#define CLK_VLP_CK_CAMTG0_SEL				19
+#define CLK_VLP_CK_CAMTG1_SEL				20
+#define CLK_VLP_CK_CAMTG2_SEL				21
+#define CLK_VLP_CK_AUD_ADC_SEL				22
+#define CLK_VLP_CK_KP_IRQ_GEN_SEL			23
+#define CLK_VLP_CK_VADSYS_VLP_26M_EN			24
+#define CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN		25
+
+/* SCP_IIC */
+#define CLK_SCP_IIC_I2C0_W1S				0
+#define CLK_SCP_IIC_I2C1_W1S				1
+
+/* SCP */
+#define CLK_SCP_SET_SPI0				0
+#define CLK_SCP_SET_SPI1				1
+
+/* VLPCFG_AO_REG */
+#define CLK_VLPCFG_AO_APEINT_RX				0
+
+/* DVFSRC_TOP */
+#define CLK_DVFSRC_TOP_DVFSRC_EN			0
+
+/* DBGAO */
+#define CLK_DBGAO_ATB_EN				0
+
+/* DEM */
+#define CLK_DEM_ATB_EN					0
+#define CLK_DEM_BUSCLK_EN				1
+#define CLK_DEM_SYSCLK_EN				2
+
+#endif /* _DT_BINDINGS_CLK_MT8189_H */
diff --git a/include/dt-bindings/reset/mediatek,mt8189-resets.h b/include/dt-bindings/reset/mediatek,mt8189-resets.h
new file mode 100644
index 000000000000..0f31984374be
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8189-resets.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2026 Collabora Ltd.
+ * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8189
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8189
+
+/* UFS resets */
+#define MT8189_UFSAO_RST_UFS_MPHY		0
+
+#define MT8189_UFSPDN_RST_UFS_UNIPRO		0
+#define MT8189_UFSPDN_RST_UFS_CRYPTO		1
+#define MT8189_UFSPDN_RST_UFS_HCI		2
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8189 */

-- 
2.55.0


