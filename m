Return-Path: <netdev+bounces-265930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFXtJrfZr2kkdAIAu9opvQ
	(envelope-from <netdev+bounces-265930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E683E2477F5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E027530BBE95
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC742EEAD;
	Tue, 10 Mar 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="AoSSp5UU"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F7254AFF;
	Tue, 10 Mar 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132139; cv=pass; b=VSdYVGizB4+72899MppZlQKLFIoMoaWgY3SSzhMdZPiRVuLq7MeRaGd6lFJY/4EfjvTKbtV+LRqShMu9dH6IlcZiWDO5PbXwV+aV6P+rxwAh1akBGgIzIvnUnwer1F3H707af4SjC7u9P3U9Luq/2oI2h1J6Qby2/ENs6cFAbKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132139; c=relaxed/simple;
	bh=jzY0MrwTsMV3x5En1zOm/w8FpmhJKLYY3avhAHLTIMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3g1m58ZMgMDcQbW7PjfkDzr4Xxgi0KRu2NPHi3UzYHxw6G2XFsbqO0fSuc/yYIJmFTX1l6Re8ZOgE/s0SzixM0ezbOPQ5tRmmi9grDv06BUfKI4PYU9/omYfoIOzjqKm72ojllwSYFSg4rDpY+uGi3G9AWnrDrxqS0wDNdmAFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=AoSSp5UU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1773132114; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fjyTlIMtB/Pugk5GPLgHLsfNdcY2wWSz2W3SFScKmDdPe2UUI5bT1lY9WB+5Smr59bf/1HqGeoNDyhhQaaIs7RZPVROnFrPB1S6Sr4si593OMPMUHu/cF3wolT+mu+Ro4aOpPgaqIsPorfdWM8uSvj1pLTmAm/Kx15QPjAxnlNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773132114; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/GKE/5Vy5rvMzqCLP4HD5HJ2pRY4KuZqKqAV6U6txtE=; 
	b=fquY+FCGcW0SrM15X9w0ay2rVO+4NElZd0njsMfyhfsipqRWVs4xyIqJG2/WDqLz/XLqfs4YtNCHMey5cxoDsWLGlQx68lOdgrHWZNr8cJS3eE7djkjz0iMz7I94ZRlMYImGnu5SfRQvyN+etRuMqVOuCNOomTNNDR8RbB7+4qg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773132114;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=/GKE/5Vy5rvMzqCLP4HD5HJ2pRY4KuZqKqAV6U6txtE=;
	b=AoSSp5UUsByE6ebLTNMPdpZcPre9j3qIet8FbtkSpbqpujriuVHixfhdC5z7h9uI
	W+Ue7ijLNfOBM8InCbmZ08sUDBJ0PMi/mZWc9nPrdtZv5i5Ih5AHiyy+VZg6ObbfKep
	OvrLphc5rFd03/OGicnjUDInpxOS+iz32+ZB41JE=
Received: by mx.zohomail.com with SMTPS id 1773132111547988.6413668944255;
	Tue, 10 Mar 2026 01:41:51 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 10 Mar 2026 16:33:54 +0800
Subject: [PATCH RFC 1/8] dt-bindings: clk: sun60i-a733-ccu: Add allwinner
 A733 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-a733-clk-v1-1-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
In-Reply-To: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773132092; l=18765;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=jzY0MrwTsMV3x5En1zOm/w8FpmhJKLYY3avhAHLTIMw=;
 b=p/YGyZ9D1nHvkqOFETjFGn7RWqho1Mr6+o4+NdUcxdHrlOMzf9xx0Od9hdPwFEvGeN+lH++lT
 PZ++IQClVhlATNlln+OooHfahDqTX92j5D8RBv8sNJL8IvTbK5beKED
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Queue-Id: E683E2477F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	TAGGED_FROM(0.00)[bounces-265930-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[pigmoral.tech];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.30.140.80:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,pigmoral.tech:dkim,pigmoral.tech:email,pigmoral.tech:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The CCU and R-CCU (PRCM) modules provide clocks and reset functions for
the Allwinner A733 SoC. The clock architecture of the A733 is evolved
from the A523, though the root clocking strategy transitions from a
static oscillator frequency in the Devicetree to the "hosc" clock, which
is determined by choosing from three possible frequencies (19.2MHz,
24MHz, or 26MHz) by the RTC hardware, and finally feeds the CCU and
R-CCU.

Additionally, the MCU_CCU module found in previous designs is removed
from the A733, and the clock tree is expanded with more clock outputs
to support new functional modules.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  | 107 ++++++++
 include/dt-bindings/clock/sun60i-a733-ccu.h        | 289 +++++++++++++++++++++
 include/dt-bindings/clock/sun60i-a733-r-ccu.h      |  39 +++
 include/dt-bindings/reset/sun60i-a733-ccu.h        | 131 ++++++++++
 include/dt-bindings/reset/sun60i-a733-r-ccu.h      |  23 ++
 5 files changed, 589 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun60i-a733-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun60i-a733-ccu.yaml
new file mode 100644
index 000000000000..aff3ff731285
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun60i-a733-ccu.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/allwinner,sun60i-a733-ccu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A733 Clock Control Unit
+
+maintainers:
+  - Junhui Liu <junhui.liu@pigmoral.tech>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - allwinner,sun60i-a733-ccu
+      - allwinner,sun60i-a733-r-ccu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+    maxItems: 7
+
+  clock-names:
+    minItems: 4
+    maxItems: 7
+
+required:
+  - "#clock-cells"
+  - "#reset-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun60i-a733-ccu
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: High Frequency Oscillator (19.2MHz, 24MHz, or 26MHz)
+            - description: Low Frequency Oscillator (usually at 32kHz)
+            - description: Internal Oscillator
+            - description: Low Frequency Oscillator fanout
+
+        clock-names:
+          items:
+            - const: hosc
+            - const: losc
+            - const: iosc
+            - const: losc-fanout
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun60i-a733-r-ccu
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: High Frequency Oscillator (19.2MHz, 24MHz, or 26MHz)
+            - description: Low Frequency Oscillator (usually at 32kHz)
+            - description: Internal Oscillator
+            - description: System 24MHz Clock
+            - description: Peripherals PLL 0 (200 MHz output)
+            - description: Peripherals PLL 0 (300 MHz output)
+            - description: Peripherals PLL 1 (300 MHz output)
+
+        clock-names:
+          items:
+            - const: hosc
+            - const: losc
+            - const: iosc
+            - const: sys-24m
+            - const: pll-periph0-200m
+            - const: pll-periph0-300m
+            - const: pll-periph1-300m
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@2002000 {
+      compatible = "allwinner,sun60i-a733-ccu";
+      reg = <0x02002000 0x2000>;
+      clocks = <&rtc 2>, <&rtc 1>, <&rtc 0>, <&rtc 4>;
+      clock-names = "hosc", "losc", "iosc", "losc-fanout";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/sun60i-a733-ccu.h b/include/dt-bindings/clock/sun60i-a733-ccu.h
new file mode 100644
index 000000000000..1a98bea8ca9a
--- /dev/null
+++ b/include/dt-bindings/clock/sun60i-a733-ccu.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_
+#define _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_
+
+#define CLK_PLL_REF		0
+#define CLK_SYS_24M		1
+#define CLK_PLL_DDR		2
+#define CLK_PLL_PERIPH0_4X	3
+#define CLK_PLL_PERIPH0_2X	4
+#define CLK_PLL_PERIPH0_800M	5
+#define CLK_PLL_PERIPH0_480M	6
+#define CLK_PLL_PERIPH0_600M	7
+#define CLK_PLL_PERIPH0_400M	8
+#define CLK_PLL_PERIPH0_300M	9
+#define CLK_PLL_PERIPH0_200M	10
+#define CLK_PLL_PERIPH0_160M	11
+#define CLK_PLL_PERIPH0_150M	12
+#define CLK_PLL_PERIPH1_4X	13
+#define CLK_PLL_PERIPH1_2X	14
+#define CLK_PLL_PERIPH1_800M	15
+#define CLK_PLL_PERIPH1_480M	16
+#define CLK_PLL_PERIPH1_600M	17
+#define CLK_PLL_PERIPH1_400M	18
+#define CLK_PLL_PERIPH1_300M	19
+#define CLK_PLL_PERIPH1_200M	20
+#define CLK_PLL_PERIPH1_160M	21
+#define CLK_PLL_PERIPH1_150M	22
+#define CLK_PLL_GPU		23
+#define CLK_PLL_VIDEO0_8X	24
+#define CLK_PLL_VIDEO0_4X	25
+#define CLK_PLL_VIDEO0_3X	26
+#define CLK_PLL_VIDEO1_8X	27
+#define CLK_PLL_VIDEO1_4X	28
+#define CLK_PLL_VIDEO1_3X	29
+#define CLK_PLL_VIDEO2_8X	30
+#define CLK_PLL_VIDEO2_4X	31
+#define CLK_PLL_VIDEO2_3X	32
+#define CLK_PLL_VE0		33
+#define CLK_PLL_VE1		34
+#define CLK_PLL_AUDIO0_4X	35
+#define CLK_PLL_AUDIO1		36
+#define CLK_PLL_AUDIO1_DIV2	37
+#define CLK_PLL_AUDIO1_DIV5	38
+#define CLK_PLL_NPU		39
+#define CLK_PLL_DE		40
+#define CLK_PLL_DE_4X		41
+#define CLK_PLL_DE_3X		42
+#define CLK_AHB			43
+#define CLK_APB0		44
+#define CLK_APB1		45
+#define CLK_APB_UART		46
+#define CLK_TRACE		47
+#define CLK_GIC			48
+#define CLK_CPU_PERI		49
+#define CLK_BUS_ITS_PCIE	50
+#define CLK_NSI			51
+#define CLK_BUS_NSI		52
+#define CLK_MBUS		53
+#define CLK_MBUS_IOMMU0_SYS	54
+#define CLK_APB_IOMMU0_SYS	55
+#define CLK_AHB_IOMMU0_SYS	56
+#define CLK_BUS_MSI_LITE0	57
+#define CLK_BUS_MSI_LITE1	58
+#define CLK_BUS_MSI_LITE2	59
+#define CLK_MBUS_IOMMU1_SYS	60
+#define CLK_APB_IOMMU1_SYS	61
+#define CLK_AHB_IOMMU1_SYS	62
+#define CLK_AHB_VE_DEC		63
+#define CLK_AHB_VE_ENC		64
+#define CLK_AHB_VID_IN		65
+#define CLK_AHB_VID_COUT0	66
+#define CLK_AHB_VID_COUT1	67
+#define CLK_AHB_DE		68
+#define CLK_AHB_NPU		69
+#define CLK_AHB_GPU0		70
+#define CLK_AHB_SERDES		71
+#define CLK_AHB_USB_SYS		72
+#define CLK_AHB_MSI_LITE0	73
+#define CLK_AHB_STORE		74
+#define CLK_AHB_CPUS		75
+#define CLK_MBUS_IOMMU0		76
+#define CLK_MBUS_IOMMU1		77
+#define CLK_MBUS_DESYS		78
+#define CLK_MBUS_VE_ENC_GATE	79
+#define CLK_MBUS_VE_DEC_GATE	80
+#define CLK_MBUS_GPU0		81
+#define CLK_MBUS_NPU		82
+#define CLK_MBUS_VID_IN		83
+#define CLK_MBUS_SERDES		84
+#define CLK_MBUS_MSI_LITE0	85
+#define CLK_MBUS_STORE		86
+#define CLK_MBUS_MSI_LITE2	87
+#define CLK_MBUS_DMA0		88
+#define CLK_MBUS_VE_ENC		89
+#define CLK_MBUS_CE		90
+#define CLK_MBUS_DMA1		91
+#define CLK_MBUS_NAND		92
+#define CLK_MBUS_CSI		93
+#define CLK_MBUS_ISP		94
+#define CLK_MBUS_GMAC0		95
+#define CLK_MBUS_GMAC1		96
+#define CLK_MBUS_VE_DEC		97
+#define CLK_BUS_DMA0		98
+#define CLK_BUS_DMA1		99
+#define CLK_BUS_SPINLOCK	100
+#define CLK_BUS_MSGBOX		101
+#define CLK_BUS_PWM0		102
+#define CLK_BUS_PWM1		103
+#define CLK_BUS_DBG		104
+#define CLK_BUS_SYSDAP		105
+#define CLK_TIMER0		106
+#define CLK_TIMER1		107
+#define CLK_TIMER2		108
+#define CLK_TIMER3		109
+#define CLK_TIMER4		110
+#define CLK_TIMER5		111
+#define CLK_TIMER6		112
+#define CLK_TIMER7		113
+#define CLK_TIMER8		114
+#define CLK_TIMER9		115
+#define CLK_BUS_TIMER		116
+#define CLK_AVS			117
+#define CLK_DE			118
+#define CLK_BUS_DE		119
+#define CLK_DI			120
+#define CLK_BUS_DI		121
+#define CLK_G2D			122
+#define CLK_BUS_G2D		123
+#define CLK_EINK		124
+#define CLK_EINK_PANEL		125
+#define CLK_BUS_EINK		126
+#define CLK_VE_ENC		127
+#define CLK_VE_DEC		128
+#define CLK_BUS_VE_ENC		129
+#define CLK_BUS_VE_DEC		130
+#define CLK_CE			131
+#define CLK_BUS_CE		132
+#define CLK_BUS_CE_SYS		133
+#define CLK_NPU			134
+#define CLK_BUS_NPU		135
+#define CLK_GPU			136
+#define CLK_BUS_GPU		137
+#define CLK_DRAM		138
+#define CLK_BUS_DRAM		139
+#define CLK_NAND0		140
+#define CLK_NAND1		141
+#define CLK_BUS_NAND		142
+#define CLK_MMC0		143
+#define CLK_MMC1		144
+#define CLK_MMC2		145
+#define CLK_MMC3		146
+#define CLK_BUS_MMC0		147
+#define CLK_BUS_MMC1		148
+#define CLK_BUS_MMC2		149
+#define CLK_BUS_MMC3		150
+#define CLK_UFS_AXI		151
+#define CLK_UFS_CFG		152
+#define CLK_BUS_UFS		153
+#define CLK_BUS_UART0		154
+#define CLK_BUS_UART1		155
+#define CLK_BUS_UART2		156
+#define CLK_BUS_UART3		157
+#define CLK_BUS_UART4		158
+#define CLK_BUS_UART5		159
+#define CLK_BUS_UART6		160
+#define CLK_BUS_I2C0		161
+#define CLK_BUS_I2C1		162
+#define CLK_BUS_I2C2		163
+#define CLK_BUS_I2C3		164
+#define CLK_BUS_I2C4		165
+#define CLK_BUS_I2C5		166
+#define CLK_BUS_I2C6		167
+#define CLK_BUS_I2C7		168
+#define CLK_BUS_I2C8		169
+#define CLK_BUS_I2C9		170
+#define CLK_BUS_I2C10		171
+#define CLK_BUS_I2C11		172
+#define CLK_BUS_I2C12		173
+#define CLK_SPI0		174
+#define CLK_SPI1		175
+#define CLK_SPI2		176
+#define CLK_SPI3		177
+#define CLK_SPI4		178
+#define CLK_BUS_SPI0		179
+#define CLK_BUS_SPI1		180
+#define CLK_BUS_SPI2		181
+#define CLK_BUS_SPI3		182
+#define CLK_BUS_SPI4		183
+#define CLK_SPIF		184
+#define CLK_BUS_SPIF		185
+#define CLK_GPADC		186
+#define CLK_BUS_GPADC		187
+#define CLK_BUS_THS		188
+#define CLK_IRRX		189
+#define CLK_BUS_IRRX		190
+#define CLK_IRTX		191
+#define CLK_BUS_IRTX		192
+#define CLK_BUS_LRADC		193
+#define CLK_SGPIO		194
+#define CLK_BUS_SGPIO		195
+#define CLK_LPC			196
+#define CLK_BUS_LPC		197
+#define CLK_I2SPCM0		198
+#define CLK_I2SPCM1		199
+#define CLK_I2SPCM2		200
+#define CLK_I2SPCM3		201
+#define CLK_I2SPCM4		202
+#define CLK_BUS_I2SPCM0		203
+#define CLK_BUS_I2SPCM1		204
+#define CLK_BUS_I2SPCM2		205
+#define CLK_BUS_I2SPCM3		206
+#define CLK_BUS_I2SPCM4		207
+#define CLK_I2SPCM2_ASRC	208
+#define CLK_OWA_TX		209
+#define CLK_OWA_RX		210
+#define CLK_BUS_OWA		211
+#define CLK_DMIC		212
+#define CLK_BUS_DMIC		213
+#define CLK_USB_OHCI0		214
+#define CLK_BUS_OTG		215
+#define CLK_BUS_EHCI0		216
+#define CLK_BUS_OHCI0		217
+#define CLK_USB_OHCI1		218
+#define CLK_BUS_EHCI1		219
+#define CLK_BUS_OHCI1		220
+#define CLK_USB_REF		221
+#define CLK_USB2_U2_REF		222
+#define CLK_USB2_SUSPEND	223
+#define CLK_USB2_MF		224
+#define CLK_USB2_U3_UTMI	225
+#define CLK_USB2_U2_PIPE	226
+#define CLK_PCIE_AUX		227
+#define CLK_PCIE_AXI_SLV	228
+#define CLK_SERDES_PHY		229
+#define CLK_GMAC_PTP		230
+#define CLK_GMAC0_PHY		231
+#define CLK_GMAC1_PHY		232
+#define CLK_BUS_GMAC0		233
+#define CLK_BUS_GMAC1		234
+#define CLK_TCON_LCD0		235
+#define CLK_TCON_LCD1		236
+#define CLK_TCON_LCD2		237
+#define CLK_BUS_TCON_LCD0	238
+#define CLK_BUS_TCON_LCD1	239
+#define CLK_BUS_TCON_LCD2	240
+#define CLK_DSI0		241
+#define CLK_DSI1		242
+#define CLK_BUS_DSI0		243
+#define CLK_BUS_DSI1		244
+#define CLK_COMBPHY0		245
+#define CLK_COMBPHY1		246
+#define CLK_BUS_TCON_TV0	247
+#define CLK_BUS_TCON_TV1	248
+#define CLK_EDP_TV		249
+#define CLK_BUS_EDP_TV		250
+#define CLK_HDMI_CEC_32K	251
+#define CLK_HDMI_CEC		252
+#define CLK_HDMI_TV		253
+#define CLK_BUS_HDMI_TV		254
+#define CLK_HDMI_SFR		255
+#define CLK_HDMI_ESM		256
+#define CLK_BUS_DPSS_TOP0	257
+#define CLK_BUS_DPSS_TOP1	258
+#define CLK_LEDC		259
+#define CLK_BUS_LEDC		260
+#define CLK_BUS_DSC		261
+#define CLK_CSI_MASTER0		262
+#define CLK_CSI_MASTER1		263
+#define CLK_CSI_MASTER2		264
+#define CLK_CSI			265
+#define CLK_BUS_CSI		266
+#define CLK_ISP			267
+#define CLK_APB2JTAG		268
+#define CLK_FANOUT_24M		269
+#define CLK_FANOUT_12M		270
+#define CLK_FANOUT_16M		271
+#define CLK_FANOUT_25M		272
+#define CLK_FANOUT_27M		273
+#define CLK_FANOUT_PCLK		274
+#define CLK_FANOUT0		275
+#define CLK_FANOUT1		276
+#define CLK_FANOUT2		277
+#define CLK_FANOUT3		278
+
+#endif /* _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_ */
diff --git a/include/dt-bindings/clock/sun60i-a733-r-ccu.h b/include/dt-bindings/clock/sun60i-a733-r-ccu.h
new file mode 100644
index 000000000000..1c717cc588b8
--- /dev/null
+++ b/include/dt-bindings/clock/sun60i-a733-r-ccu.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN60I_A733_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN60I_A733_R_CCU_H_
+
+#define CLK_R_AHB		0
+#define CLK_R_APB0		1
+#define CLK_R_APB1		2
+#define CLK_R_TIMER0		3
+#define CLK_R_TIMER1		4
+#define CLK_R_TIMER2		5
+#define CLK_R_TIMER3		6
+#define CLK_BUS_R_TIMER		7
+#define CLK_BUS_R_TWD		8
+#define CLK_R_PWMCTRL		9
+#define CLK_BUS_R_PWMCTRL	10
+#define CLK_R_SPI		11
+#define CLK_BUS_R_SPI		12
+#define CLK_BUS_R_MSGBOX	13
+#define CLK_BUS_R_UART0		14
+#define CLK_BUS_R_UART1		15
+#define CLK_BUS_R_I2C0		16
+#define CLK_BUS_R_I2C1		17
+#define CLK_BUS_R_I2C2		18
+#define CLK_BUS_R_PPU		19
+#define CLK_BUS_R_TZMA		20
+#define CLK_BUS_R_CPU_BIST	21
+#define CLK_R_IR_RX		22
+#define CLK_BUS_R_IR_RX		23
+#define CLK_BUS_R_RTC		24
+#define CLK_R_RISCV		25
+#define CLK_BUS_R_RISCV		26
+#define CLK_BUS_R_RISCV_CFG	27
+#define CLK_BUS_R_CPUCFG	28
+
+#endif /* _DT_BINDINGS_CLK_SUN60I_A733_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun60i-a733-ccu.h b/include/dt-bindings/reset/sun60i-a733-ccu.h
new file mode 100644
index 000000000000..11ce78cf04dd
--- /dev/null
+++ b/include/dt-bindings/reset/sun60i-a733-ccu.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN60I_A733_CCU_H_
+#define _DT_BINDINGS_RST_SUN60I_A733_CCU_H_
+
+#define RST_BUS_ITS_PCIE	0
+#define RST_BUS_NSI		1
+#define RST_BUS_NSI_CFG		2
+#define RST_BUS_IOMMU0_SYS	3
+#define RST_BUS_MSI_LITE0_AHB	4
+#define RST_BUS_MSI_LITE0_MBUS	5
+#define RST_BUS_MSI_LITE1_AHB	6
+#define RST_BUS_MSI_LITE1_MBUS	7
+#define RST_BUS_MSI_LITE2_AHB	8
+#define RST_BUS_MSI_LITE2_MBUS	9
+#define RST_BUS_IOMMU1_SYS	10
+#define RST_BUS_DMA0		11
+#define RST_BUS_DMA1		12
+#define RST_BUS_SPINLOCK	13
+#define RST_BUS_MSGBOX		14
+#define RST_BUS_PWM0		15
+#define RST_BUS_PWM1		16
+#define RST_BUS_DBG		17
+#define RST_BUS_SYSDAP		18
+#define RST_BUS_TIMER0		19
+#define RST_BUS_DE		20
+#define RST_BUS_DI		21
+#define RST_BUS_G2D		22
+#define RST_BUS_EINK		23
+#define RST_BUS_DE_SYS		24
+#define RST_BUS_VE_ENC		25
+#define RST_BUS_VE_DEC		26
+#define RST_BUS_CE		27
+#define RST_BUS_CE_SYS		28
+#define RST_BUS_NPU_CORE	29
+#define RST_BUS_NPU_AXI		30
+#define RST_BUS_NPU_AHB		31
+#define RST_BUS_NPU_SRAM	32
+#define RST_BUS_GPU		33
+#define RST_BUS_DRAM		34
+#define RST_BUS_NAND		35
+#define RST_BUS_MMC0		36
+#define RST_BUS_MMC1		37
+#define RST_BUS_MMC2		38
+#define RST_BUS_MMC3		39
+#define RST_BUS_UFS_AHB		40
+#define RST_BUS_UFS_AXI		41
+#define RST_BUS_UFS_PHY		42
+#define RST_BUS_UFS_CORE	43
+#define RST_BUS_UART0		44
+#define RST_BUS_UART1		45
+#define RST_BUS_UART2		46
+#define RST_BUS_UART3		47
+#define RST_BUS_UART4		48
+#define RST_BUS_UART5		49
+#define RST_BUS_UART6		50
+#define RST_BUS_I2C0		51
+#define RST_BUS_I2C1		52
+#define RST_BUS_I2C2		53
+#define RST_BUS_I2C3		54
+#define RST_BUS_I2C4		55
+#define RST_BUS_I2C5		56
+#define RST_BUS_I2C6		57
+#define RST_BUS_I2C7		58
+#define RST_BUS_I2C8		59
+#define RST_BUS_I2C9		60
+#define RST_BUS_I2C10		61
+#define RST_BUS_I2C11		62
+#define RST_BUS_I2C12		63
+#define RST_BUS_SPI0		64
+#define RST_BUS_SPI1		65
+#define RST_BUS_SPI2		66
+#define RST_BUS_SPIF		67
+#define RST_BUS_SPI3		68
+#define RST_BUS_SPI4		69
+#define RST_BUS_GPADC		70
+#define RST_BUS_THS		71
+#define RST_BUS_IRRX		72
+#define RST_BUS_IRTX		73
+#define RST_BUS_LRADC		74
+#define RST_BUS_SGPIO		75
+#define RST_BUS_LPC		76
+#define RST_BUS_I2SPCM0		77
+#define RST_BUS_I2SPCM1		78
+#define RST_BUS_I2SPCM2		79
+#define RST_BUS_I2SPCM3		80
+#define RST_BUS_I2SPCM4		81
+#define RST_BUS_OWA		82
+#define RST_BUS_DMIC		83
+#define RST_USB_PHY0		84
+#define RST_BUS_OHCI0		85
+#define RST_BUS_EHCI0		86
+#define RST_BUS_OTG		87
+#define RST_USB_PHY1		88
+#define RST_BUS_OHCI1		89
+#define RST_BUS_EHCI1		90
+#define RST_BUS_USB2		91
+#define RST_BUS_PCIE		92
+#define RST_BUS_PCIE_PWRUP	93
+#define RST_BUS_SERDES		94
+#define RST_BUS_GMAC0		95
+#define RST_BUS_GMAC0_AXI	96
+#define RST_BUS_GMAC1		97
+#define RST_BUS_GMAC1_AXI	98
+#define RST_BUS_TCON_LCD0	99
+#define RST_BUS_TCON_LCD1	100
+#define RST_BUS_TCON_LCD2	101
+#define RST_BUS_LVDS0		102
+#define RST_BUS_LVDS1		103
+#define RST_BUS_DSI0		104
+#define RST_BUS_DSI1		105
+#define RST_BUS_TCON_TV0	106
+#define RST_BUS_TCON_TV1	107
+#define RST_BUS_EDP		108
+#define RST_BUS_HDMI_MAIN	109
+#define RST_BUS_HDMI_SUB	110
+#define RST_BUS_HDMI_HDCP	111
+#define RST_BUS_DPSS_TOP0	112
+#define RST_BUS_DPSS_TOP1	113
+#define RST_BUS_VIDEO_OUT0	114
+#define RST_BUS_VIDEO_OUT1	115
+#define RST_BUS_LEDC		116
+#define RST_BUS_DSC		117
+#define RST_BUS_CSI		118
+#define RST_BUS_VIDEO_IN	119
+#define RST_BUS_APB2JTAG	120
+
+#endif /* _DT_BINDINGS_RST_SUN60I_A733_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun60i-a733-r-ccu.h b/include/dt-bindings/reset/sun60i-a733-r-ccu.h
new file mode 100644
index 000000000000..629e546d1998
--- /dev/null
+++ b/include/dt-bindings/reset/sun60i-a733-r-ccu.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN60I_A733_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN60I_A733_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_PWM		1
+#define RST_BUS_R_SPI		2
+#define RST_BUS_R_MSGBOX	3
+#define RST_BUS_R_UART0		4
+#define RST_BUS_R_UART1		5
+#define RST_BUS_R_I2C0		6
+#define RST_BUS_R_I2C1		7
+#define RST_BUS_R_I2C2		8
+#define RST_BUS_R_IR_RX		9
+#define RST_BUS_R_RTC		10
+#define RST_BUS_R_RISCV_CFG	11
+#define RST_BUS_R_CPUCFG	12
+
+#endif /* _DT_BINDINGS_RST_SUN60I_A733_R_CCU_H_ */

-- 
2.52.0


