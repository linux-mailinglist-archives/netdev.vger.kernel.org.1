Return-Path: <netdev+bounces-177337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC72A6FA8A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85303170E20
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA61257AF9;
	Tue, 25 Mar 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="a75CWyZL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223F256C8B;
	Tue, 25 Mar 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903903; cv=none; b=fyxx+41nSfVxdkuXPLJ4WNC1IaMwcPY9Rr5m2dxRkRf9e/VeMKAJPuGZGk5RwSg67dWnydoj41h+RtMxw1GYZlbs7HQSycThTOB2Wrsbl/zHf46Fw7a/i4oJzfAaq8sBSfNwyAFvLTPZs7wrVT+R1f+d/oDN6453G8oHmg269Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903903; c=relaxed/simple;
	bh=LbKDGPUsRzB21/dtuDv+AQH08uLt87W+n3tEi8+rwD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHB9vOqCs1HibOfoTSp5PaW/lQTzNYmIm/dSqQ6V12ykPmWFP9fSk7ZmPqvYwVOlpwIzZbs1iw3wr6R7+o67qPRtNMKdzNMZmfM8DiMCzPouxPWtOPCOP3KBBrFljpPtTuQ29iuiNBgU0sNaH+GS2btJ/yxUsEa+CaMaRqGfWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=a75CWyZL; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76329102EBA4A;
	Tue, 25 Mar 2025 12:58:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742903898; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wkjvXpluXHZIyk2FPJLHBibzQd9cgpPYKEkveOICekU=;
	b=a75CWyZLI/mtX4BBgVvlvy0gl8YN7T8r6CFmKMRLIe1xop8h8A3BOkSRHm62mPSuH4m5Ab
	DqHOIUQ+/VTodkeEYQoIQeyUMjX65j4r2aN27Y1kbW20eNWIp5oSQxsZRNmjQJ+U6MGkZ3
	PJxIrKdRCJKU7KCShMtzgjaMKsZcaxoGoGXQ/dJBzTobByZgYyueHwI5+JEPfSWRAkuHBU
	9p6rg5kodjQw90TrkFa2QQ8r4JVbQMrW6BBdqg79j+u8gAu6mU9jA92RTlk+D8rE4PGsQk
	l1MvmgGQkHNkiC8k8uo4emYcgQMnIxeIuyDXmp1RtpsYUDVo0+7c6DgNfbDSDA==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description (fec,mtip-switch.yaml)
Date: Tue, 25 Mar 2025 12:57:33 +0100
Message-Id: <20250325115736.1732721-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325115736.1732721-1-lukma@denx.de>
References: <20250325115736.1732721-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch provides description of the MTIP L2 switch available in some
NXP's SOCs - imx287, vf610.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../bindings/net/fec,mtip-switch.yaml         | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fec,mtip-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
new file mode 100644
index 000000000000..cd85385e0f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,mtip-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MTIP Level 2 (L2) switch
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+	  - imx287-mtip-switch
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  clocks:
+    maxItems: 4
+    description:
+      The "ipg", for MAC ipg_clk_s, ipg_clk_mac_s that are for register accessing.
+      The "ahb", for MAC ipg_clk, ipg_clk_mac that are bus clock.
+      The "ptp"(option), for IEEE1588 timer clock that requires the clock.
+      The "enet_out"(option), output clock for external device, like supply clock
+      for PHY. The clock is required if PHY clock source from SOC.
+
+  clock-names:
+    minItems: 4
+    maxItems: 4
+    items:
+      enum:
+	- ipg
+	- ahb
+	- ptp
+	- enet_out
+
+  phy-supply:
+    description:
+      Regulator that powers the Ethernet PHY.
+
+  phy-reset-gpios:
+    deprecated: true
+    description:
+      Should specify the gpio for phy reset.
+
+  phy-reset-duration:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Reset duration in milliseconds.  Should present only if property
+      "phy-reset-gpios" is available.  Missing the property will have the
+      duration be 1 millisecond.  Numbers greater than 1000 are invalid
+      and 1 millisecond will be used instead.
+
+  phy-reset-post-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Post reset delay in milliseconds. If present then a delay of phy-reset-post-delay
+      milliseconds will be observed after the phy-reset-gpios has been toggled.
+      Can be omitted thus no delay is observed. Delay is in range of 1ms to 1000ms.
+      Other delays are invalid.
+
+  mdio:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Specifies the mdio bus in the FEC, used as a container for phy nodes.
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      "^port@[0-9a-f]+$":
+	$ref: /schemas/net/ethernet-switch-controller.yaml#
+	unevaluatedProperties: false
+
+	properties:
+	  reg:
+	    description: Switch port number
+
+	required:
+	  - reg
+	  - phy-mode
+	  - phy-handle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mdio
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    switch@800f0000 {
+	compatible = "fsl,imx287-mtip-switch";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	phy-reset-duration = <25>;
+	phy-reset-post-delay = <10>;
+	interrupts = <100>, <101>, <102>;
+	clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+	clock-names = "ipg", "ahb", "enet_out", "ptp";
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mtip_port1: port@1 {
+			reg = <1>;
+			label = "lan0";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy0>;
+		};
+
+		mtip_port2: port@2 {
+			reg = <2>;
+			label = "lan1";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy1>;
+		};
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			smsc,disable-energy-detect;
+			/* Both PHYs (i.e. 0,1) have the same, single GPIO, */
+			/* line to handle both, their interrupts (AND'ed) */
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			smsc,disable-energy-detect;
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+    };
-- 
2.39.5


