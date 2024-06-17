Return-Path: <netdev+bounces-103969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E790A9E0
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE7728825E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC07194A53;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsCpNwGN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF31946C6;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617104; cv=none; b=hsmLN+W0SORWdIUb6hhEznyvvJdU3c3OqszVBuUDhfY2ALGy3OU4v5Bz1gT5FgApuWDqemRmYenSmEg/3lwoMWV7Um5tzGLLuVsn9Pw0gDl4Z0qa0Qb3WxeA96rEpSxLGURmJcBzqUokuiQJTc1NzuzZVpMO4cjDhvBa7OtuOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617104; c=relaxed/simple;
	bh=4P6bcFjMz2Z81KccelmzzJW3x4QXkAmbT0oSpWl6AJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXUJqeLkXwawcdskfgo1hPy91/1192iT6hhVXuLnE5wAk6DgI+j261i3cd2KuaPiwmR7r1BPJtEBqTIMTFCVszrJEJfNxgkLCBdMAZIEgWAbac7ptWA//j+c7bsN6ZvPVySTDDERxst7XpguyT4M2OlXA+8NkoP7hUtNIOMNwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsCpNwGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F603C4DE09;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617104;
	bh=4P6bcFjMz2Z81KccelmzzJW3x4QXkAmbT0oSpWl6AJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tsCpNwGN6afUGHpYZDk3RYYVyHcq0EZnZM7LLN8+jVJR0XagDhcfCS0syleURU9qz
	 zc01gjZLBDUY0bxaVo++BEWcen5Y4dXWPKEmD5PUbelS8eY/AzFOLh8CIPJPOqsoC1
	 LrDKAt7KdMSZwgH35Mt12azDzejGYOMnhX1YDrOW87etMQsYf8IOHBOF9SvO/VCIr/
	 BGyMQIBw5cpvdQdm++RyvLnKKHP0TdO2c6z3GYL7gosv7Eul+J2X+ji5cuSnRBKByz
	 cpG9YW+0FUG5/7tp7cGefXTResnwDo9RrlUgQ6kFah2ZK6DCueLWm0/sK4BqlzDG/Z
	 v77g94FPXkAaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EFBC2BA1A;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:36:50 +0300
Subject: [PATCH v10 16/38] dt-bindings: net: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-16-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=2030;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2EI3oik4KHOxom6rjRW5fPr9iZissgfzSJoa2Vw9jd0=;
 b=oXTNSEjBimv7+u5cuG18isF71bTlqEdBKHy3rS/RsHSfrv/o1QlYlnfhvcyA9rv7zNuP1gN97uYF
 NWaqlXsDC6mBELBBRX8lh1ZtslQ+f5YoJXgUmvqlhfAlQNgIBCUM
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



