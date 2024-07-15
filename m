Return-Path: <netdev+bounces-111440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54E931016
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8B0282372
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315B185E6E;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljQrMVSu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC4185E60;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032804; cv=none; b=g0BcCqCHaG8P8535ABqeDo8ia5hgQJu8NJelthdVgTOYlYC9/RHfDw5f2rxg6QfUV3mqOzViHryTMsUTY2xw110YNxQoxpAaXTPiWA/N37/BmqAwc0lSurWmWD3qi+x0aN8ykVvZaNT1SbF26Bt3cJG8rMXHaAQlOOzLDbdToPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032804; c=relaxed/simple;
	bh=4P6bcFjMz2Z81KccelmzzJW3x4QXkAmbT0oSpWl6AJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Px5kbsKS4uZDC215x5NZGzu2bXS99qQ4IAO+Ifx+M0S/7Cbmci2vldiRMLbtP/iBwlZ1K8wLaxVXJqKZiZ93Qc7w83pCdF9g62J5o38QCJFCq/I6sHZMeQI5m9IXJlO7RTMnLBmt7jA6Pz7OMBO+fmHjtBBog6MikG5xKgGR52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljQrMVSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BECE2C4AF19;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032803;
	bh=4P6bcFjMz2Z81KccelmzzJW3x4QXkAmbT0oSpWl6AJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ljQrMVSuMnOlbkKTDtx+Val/d2JWs1bX3R1owqGK3poxk9OJAmCMsXbYzkbWOhnOb
	 zgToTNPxVy7YIbmJWiiJDDVKRJlEmkk4PiAoxRKDVmLfJs7a61TiCEpRVqz0n6CJ9H
	 oU3/fV5EZ6REiZXHCxks2cjN1n+4eh5ifwbCmMvo5ZNUtzNGq6ksSEfYndqetj97QK
	 /YmBU1pT5XavaGGCADf9Si7s7cgWLVyyDt1XH6Rrw9r1qYUfj698CBGgOWjJtaycx1
	 L0szgIE0Mv7L/73xCMfB2H+pNzgV+fZoX97bPzMX/cLvb+vOJyfa6sMkvlzGcMkVq8
	 ipiwrqQNNKuoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696CC3DA50;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:20 +0300
Subject: [PATCH v11 16/38] dt-bindings: net: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-16-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=2030;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2EI3oik4KHOxom6rjRW5fPr9iZissgfzSJoa2Vw9jd0=;
 b=i05NcwoUS8bi5oc+5uiGsb54nZME5zijYoJx3mLqg9hD+idgvWpMbJxFFsiM4bUcTSAzfn4OaXPJ
 rl/p5PWNALaW5ia3bC76xbkQKl9tpWlOYzSs9uCqFQQcfWXinRVr
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



