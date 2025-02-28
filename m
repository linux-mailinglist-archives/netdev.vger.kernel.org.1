Return-Path: <netdev+bounces-170813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12FA4A073
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9417F1899441
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBB1F09AC;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAnDYXUg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440A1F0991;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763973; cv=none; b=W6ssFgNMMCakI4aLmdcjC1TWH7alWf//4MKiaGnjfbr1GT5/nY+ROB5jjTf+KMCnKlILfcHbFF/qX+II6//7+KZuRAlxU9AWfC47QFjeWZtYjmcv89p8MQnuUK6r5zsPG/YXoAQAZmjJa9UUDJ6A8rpMmtvQOsv/ZXAyVchL2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763973; c=relaxed/simple;
	bh=cPTCJFNFhpivopOiLy1Jv1psoqvxMfFxzkCZOplVpG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVm/ltI1Jw9ucLy6Djfjw/mNdBtZhNrOW2vYlRdV6TMasRjGfZ6H26whDFFI6PUkOlSUDrRv4CLaLmKGVdclBpE5YGT1XNF0va0keqhpaChE8oEI9mjkBPGhN1V08tmlOMvf40cI2EUJE3q5aWSe9YAg6Yg4bhnQQMA/Woy6t9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAnDYXUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED09DC4CEE5;
	Fri, 28 Feb 2025 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763973;
	bh=cPTCJFNFhpivopOiLy1Jv1psoqvxMfFxzkCZOplVpG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PAnDYXUgCZ5QuzaeQDCLpumoywm88x5bUn0oDr1LDbQZL4kmqCNREDtK44lixn6J3
	 hIa8CX/XuGLYoOkHVU2r1rlfelWKoI6UJG+qtv/lMfYLZzUP+96l1Mz4+nKM1vmJtg
	 HexyI1GN8wR2TcFKhl9hY2l258mvaZAbNQYI+ZWvBiAAoAUFlNOfg3NT5P7YITA9/D
	 ImrPo1C6d4DeMMd7hhLZZm1Nl2ha89CNtJ/VzHVVvBacItNcGQb3E1Svc06pbBLtDx
	 31an8of+ADHeHjjQCKVeWTyRwvX6M/5TGbiAKhBdAm86qMBu60Tll+x7OVbTg6rl6a
	 JxOB/ieHW5/5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D2CC282D0;
	Fri, 28 Feb 2025 17:32:52 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 18:32:50 +0100
Subject: [PATCH v2 1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to
 YAML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-gianfar-yaml-v2-1-6beeefbd4818@posteo.net>
References: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
In-Reply-To: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740763971; l=6137;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=FCfdH7CYgs2HMWUtgO2Kr9tfttQkVuvNzc3Tc1aCf2A=;
 b=8irhqlR2weuPW/6zc6rywF4fLk+LFj0/mTGaobz+UPw2FG2CLoeL0AtZ1Eh7r51BK76I2qZW3
 0tCOXs+XfvaBN+uxU6d4JkxMCSseq3DITbgq5IzKo26Rvl1UkQKfDFB
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Move the information related to the Freescale Gianfar (TSEC) MDIO bus
and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
file in YAML format, fsl,gianfar-mdio.yaml.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- remove definitions of #address/size-cells (already in mdio.yaml)
- disambiguate compatible = "gianfar" schemas by using a "select:" schema
---
 .../devicetree/bindings/net/fsl,gianfar-mdio.yaml  | 113 +++++++++++++++++++++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  41 +-------
 2 files changed, 115 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..22369771c13614875845b6d6e6d6031b933cb152
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Gianfar (TSEC) MDIO Device
+
+description:
+  This binding describes the MDIO is a bus to which the PHY devices are
+  connected. For each device that exists on this bus, a child node should be
+  created.
+
+  As of this writing, every TSEC is associated with an internal Ten-Bit
+  Interface (TBI) PHY. This PHY is accessed through the local MDIO bus. These
+  buses are defined similarly to the mdio buses, except they are compatible
+  with "fsl,gianfar-tbi". The TBI PHYs underneath them are similar to normal
+  PHYs, but the reg property is considered instructive, rather than
+  descriptive. The reg property should be chosen so it doesn't interfere with
+  other PHYs on the bus.
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+# This is needed to distinguish gianfar.yaml and gianfar-mdio.yaml, because
+# both use compatible = "gianfar" (with different device_type values)
+select:
+  oneOf:
+    - properties:
+        compatible:
+          contains:
+            const: gianfar
+        device_type:
+          const: mdio
+      required:
+        - device_type
+
+    - properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,gianfar-tbi
+              - fsl,gianfar-mdio
+              - fsl,etsec2-tbi
+              - fsl,etsec2-mdio
+              - fsl,ucc-mdio
+              - ucc_geth_phy
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    enum:
+      - fsl,gianfar-tbi
+      - fsl,gianfar-mdio
+      - fsl,etsec2-tbi
+      - fsl,etsec2-mdio
+      - fsl,ucc-mdio
+      - gianfar
+      - ucc_geth_phy
+
+  reg:
+    minItems: 1
+    items:
+      - description:
+          Offset and length of the register set for the device
+
+      - description:
+          Optionally, the offset and length of the TBIPA register (TBI PHY
+          address register). If TBIPA register is not specified, the driver
+          will attempt to infer it from the register set specified (your
+          mileage may vary).
+
+  device_type:
+    const: mdio
+
+required:
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - $ref: mdio.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ucc_geth_phy
+    then:
+      required:
+        - device_type
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        mdio@24520 {
+            reg = <0x24520 0x20>;
+            compatible = "fsl,gianfar-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 9c9668c1b6a24edff7b7cf625b9f14c3cbc2e0c8..0e55e0af7d6f59cfb571dd3fcff704b7f4c140d2 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -1,47 +1,10 @@
 * MDIO IO device
 
-The MDIO is a bus to which the PHY devices are connected.  For each
-device that exists on this bus, a child node should be created.  See
-the definition of the PHY node in booting-without-of.txt for an example
-of how to define a PHY.
-
-Required properties:
-  - reg : Offset and length of the register set for the device, and optionally
-          the offset and length of the TBIPA register (TBI PHY address
-	  register).  If TBIPA register is not specified, the driver will
-	  attempt to infer it from the register set specified (your mileage may
-	  vary).
-  - compatible : Should define the compatible device type for the
-    mdio. Currently supported strings/devices are:
-	- "fsl,gianfar-tbi"
-	- "fsl,gianfar-mdio"
-	- "fsl,etsec2-tbi"
-	- "fsl,etsec2-mdio"
-	- "fsl,ucc-mdio"
-	- "fsl,fman-mdio"
-    When device_type is "mdio", the following strings are also considered:
-	- "gianfar"
-	- "ucc_geth_phy"
-
-Example:
-
-	mdio@24520 {
-		reg = <24520 20>;
-		compatible = "fsl,gianfar-mdio";
-
-		ethernet-phy@0 {
-			......
-		};
-	};
+Refer to Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
 
 * TBI Internal MDIO bus
 
-As of this writing, every tsec is associated with an internal TBI PHY.
-This PHY is accessed through the local MDIO bus.  These buses are defined
-similarly to the mdio buses, except they are compatible with "fsl,gianfar-tbi".
-The TBI PHYs underneath them are similar to normal PHYs, but the reg property
-is considered instructive, rather than descriptive.  The reg property should
-be chosen so it doesn't interfere with other PHYs on the bus.
+Refer to Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
 
 * Gianfar-compatible ethernet nodes
 

-- 
2.48.0.rc1.219.gb6b6757d772



