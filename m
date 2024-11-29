Return-Path: <netdev+bounces-147107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD04E9D78D9
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449AB163616
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683E198E96;
	Sun, 24 Nov 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCz9u3tm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFE18FDCC;
	Sun, 24 Nov 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488195; cv=none; b=taPhMSVCS0cMoGTS+6dIwmgccBoM+Nr/IiFQeijMcRFHdohXSZEyLecf+SxyvYncLMUsqWs2ljdUbNtA4C4UogJVSdz1t00mJ3n+yG/zctq6b5Ml9XfMb0FNCP9JZ7tDlPj9/EKtxoBO4NYxLmglHDeuYTgBGHqVe20q71k15Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488195; c=relaxed/simple;
	bh=hRTYBgd5aMrqxBD9zYQNvdPGPWcLGVS6g40811SQlp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uaramxva8vpSmlO3QZsG3m1Mj7OhShmlVh08OBhqdlXYc8zkR3gauRlPzhdWiyUcNXDbwWkWaSvp/OmQSKwJNwIak/2HwhiIYY8b3L4isiYOHu0qZwlhRp8iLdufWbbWpxxNQ0afj409VoCliHSq6xU/66QHoPZc3AvHqRiHj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCz9u3tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFEC7C4CEFD;
	Sun, 24 Nov 2024 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732488194;
	bh=hRTYBgd5aMrqxBD9zYQNvdPGPWcLGVS6g40811SQlp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QCz9u3tmUFHogfZS3qKISq0+bRstWs/Kh200xJwjhOx8mAHbymH4NiQSrfe/aW5R2
	 xSPutVkaw4ndppgCNITJTYAybDU01ek/XP9NtvHIrrgNM/cKpx8hImJEVVHHiIctWo
	 vXlkK25DxOOxOR5bG8m8/bteshniMcDD+VlXapavqLyibyxs8RrqwHu0/rq+nr2oMM
	 8rqgh9n0ZJmNcWtc1MKJzt1tXO9o8094X/Q1m2etzl/uf0Cn6LlKtfFTAVc0nRWpae
	 eUKFeAwAiEKF5prGGKDZqX4J+1Lo4wjXukcseH1/Jax7xfKgk/HcQZHU5u4y1HgT2Z
	 yQ/ITPL7zRqbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7ED3B7C3;
	Sun, 24 Nov 2024 22:43:14 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sun, 24 Nov 2024 23:42:44 +0100
Subject: [PATCH RFC net-next v6 13/15] dt-bindings: net: Add DT bindings
 for DWMAC on NXP S32G/R SoCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-upstream_s32cc_gmac-v6-13-dc5718ccf001@oss.nxp.com>
References: <20241124-upstream_s32cc_gmac-v6-0-dc5718ccf001@oss.nxp.com>
In-Reply-To: <20241124-upstream_s32cc_gmac-v6-0-dc5718ccf001@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732488190; l=4096;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=HHjvFK+MHmQc/THlQijGySkp22UNi4Qf+z7YD0xfSdU=;
 b=igdlnRUDm+Btgrcm+w265yJV3OQyP+QhUBXZJ+GBEYJeN4ktXd4QheCyYW/yUAY526tf89npl
 IvHirPX8LfqA0UF48pc6Ig4sQ/Hpp448A0s0cWX7kF7EKJTjceH7qUr
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add basic description for DWMAC ethernet IP on NXP S32G2xx, S32G3xx
and S32R45 automotive series SoCs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 105 +++++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 2 files changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
new file mode 100644
index 000000000000..2b8b74c5feec
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021-2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,s32-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xx/S32G3xx/S32R45 GMAC ethernet controller
+
+maintainers:
+  - Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
+
+description:
+  This device is a Synopsys DWC IP, integrated on NXP S32G/R SoCs.
+  The SoC series S32G2xx and S32G3xx feature one DWMAC instance,
+  the SoC S32R45 has two instances. The devices can use RGMII/RMII/MII
+  interface over Pinctrl device or the output can be routed
+  to the embedded SerDes for SGMII connectivity.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-dwmac
+      - items:
+          - enum:
+              - nxp,s32g3-dwmac
+              - nxp,s32r45-dwmac
+          - const: nxp,s32g2-dwmac
+
+  reg:
+    items:
+      - description: Main GMAC registers
+      - description: GMAC PHY mode control register
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
+  clocks:
+    items:
+      - description: Main GMAC clock
+      - description: Transmit clock
+      - description: Receive clock
+      - description: PTP reference clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: tx
+      - const: rx
+      - const: ptp_ref
+
+required:
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ethernet@4033c000 {
+        compatible = "nxp,s32g2-dwmac";
+        reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
+              <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        snps,mtl-rx-config = <&mtl_rx_setup>;
+        snps,mtl-tx-config = <&mtl_tx_setup>;
+        clocks = <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;
+        clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
+        phy-mode = "rgmii-id";
+        phy-handle = <&phy0>;
+
+        mtl_rx_setup: rx-queues-config {
+          snps,rx-queues-to-use = <5>;
+        };
+
+        mtl_tx_setup: tx-queues-config {
+          snps,tx-queues-to-use = <5>;
+        };
+
+        mdio {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          compatible = "snps,dwmac-mdio";
+
+          phy0: ethernet-phy@0 {
+            reg = <0>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index eb1f3ae41ab9..91e75eb3f329 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -67,6 +67,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nxp,s32g2-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos

-- 
2.47.0



