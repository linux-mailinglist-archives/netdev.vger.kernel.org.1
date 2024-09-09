Return-Path: <netdev+bounces-126405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C397116E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411EB1C223A3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5FE1B1D6E;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzjCdRrb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4E1B1D4B;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869536; cv=none; b=G0jNbRQjBeDXz7Rd1JQ0A9IJzkjU/A8eynbMBD6z3ffQDxFYLrurZw7Cx2EbNGKmKeVYr2N7Z51NfyztiQU7Mp+/T0rgrZj3wXNq47cPo2eVftPxzSmVCO7Fl1WUhVGnnkeFeOiB0rfilA6cgHiUTBMUCe5BeqWwIpulCByhp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869536; c=relaxed/simple;
	bh=4P6bcFjMz2Z81KccelmzzJW3x4QXkAmbT0oSpWl6AJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCEbyMcKY+IXNRa/XMUCV/I0jUcCgYeR3zn+dR5u3RyauGgTO9OpnEFMRXbXfXQW7p2rm1OF5EE2rHCT2oHcaaMpnKjkseSGCt34o/rGNOEZENpvLVMlepWyPj1eQXVc/CAoie/YYW+GHq7JUB8Lfx60Bxcn67T9faNNK7ESFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzjCdRrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3067AC4CEF0;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869536;
	bh=4P6bcFjMz2Z81KccelmzzJW3x4QXkAmbT0oSpWl6AJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DzjCdRrbJAhEhf6CanHqMFkVI6MuyeZFR0uwJtMWpeldaCUM611T3feTUkbj89XYJ
	 sxO5hIR9rZmwUL4APinFLYMTUG5Kt2gHCESo1BoCDkXpDoLiFJAfhesU1R8ucPodpp
	 vTAXrFqMSS3ScQ+MX17YeGAJL9ZHwNDIk/P33DXba76Ec2xt/aFY/BQQ3Y3y+kxtqC
	 vLGftlO2P9gSM6+t1clGcdtT5yRhf/hmeDEaaVAv1Gn2GdzckhH1pF7hP9kswObQgW
	 JnOEyGLiCjTd+Tc0KuDTdyTecGJSZdQ3TYHG7h87Xz0zCpguA7qeYexolqHisYw7FD
	 VzSHibo89pD8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31DECE57E;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 09 Sep 2024 11:10:41 +0300
Subject: [PATCH v12 16/38] dt-bindings: net: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-ep93xx-v12-16-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725869532; l=2030;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2EI3oik4KHOxom6rjRW5fPr9iZissgfzSJoa2Vw9jd0=;
 b=tiPSNrXlIv+e7ErezGzwVOPkryJ6i2K9M8n7TGorqrvF2kAFvl8M8Xh5/2vvXvXLO0g6HbWOMXLD
 tVfu82JODyEiG/MTC2EhVnWamK+OhPqprt+LG630vOdz+jOPlHPs
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC Ethernet Controller.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/cirrus,ep9301-eth.yaml | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cirrus,ep9301-eth.yaml b/Documentation/devicetree/bindings/net/cirrus,ep9301-eth.yaml
new file mode 100644
index 000000000000..ad0915307095
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cirrus,ep9301-eth.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/cirrus,ep9301-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EP93xx SoC Ethernet Controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-eth
+      - items:
+          - enum:
+              - cirrus,ep9302-eth
+              - cirrus,ep9307-eth
+              - cirrus,ep9312-eth
+              - cirrus,ep9315-eth
+          - const: cirrus,ep9301-eth
+
+  reg:
+    items:
+      - description: The physical base address and size of IO range
+
+  interrupts:
+    items:
+      - description: Combined signal for various interrupt events
+
+  phy-handle: true
+
+  mdio:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+    description: optional node for embedded MDIO controller
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - phy-handle
+
+additionalProperties: false
+
+examples:
+  - |
+    ethernet@80010000 {
+        compatible = "cirrus,ep9301-eth";
+        reg = <0x80010000 0x10000>;
+        interrupt-parent = <&vic1>;
+        interrupts = <7>;
+        phy-handle = <&phy0>;
+    };

-- 
2.43.2



