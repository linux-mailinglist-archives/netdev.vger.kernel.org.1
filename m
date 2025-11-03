Return-Path: <netdev+bounces-234966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A6C2A5D2
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 08:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2C8C4E34E0
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7952C08A8;
	Mon,  3 Nov 2025 07:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B112BEFE8;
	Mon,  3 Nov 2025 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155584; cv=none; b=jBB4xf1FOhY8pZikdPstkoCgCu/TqG9AtxrObZHguCNQDL0M1oYOyOgk2DMLNonj1oYF3BvxqW2HdW9tmLT0uaWZE9EIUnLd9TXsQIZThEMeDh+GIzEgauas9Xxj5GXFNDyYgZmR0JVG5flssLINhCn+GUww1xWa3qPe4Kj5wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155584; c=relaxed/simple;
	bh=PYQ6XsN2gnhIp8Xo10NhHRhhYIWg1cOPkDhVccPlR7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CMrgnUEZM/hfsm93M1UZ5iGD6ouc3htem/3e6I5UhUnvMUtlr56F91MCrPIvhkzJJ7tM4FxJT5thkytkPCDmxwB3A8v3R96hJ56j/0bSlnFNh0nuL9CY8HbTki9hVDP+90vL43c/Szebv1hhIydML5BOVF35tvSBBo3FNfWNTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 3 Nov 2025 15:39:16 +0800
Subject: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=2708;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PYQ6XsN2gnhIp8Xo10NhHRhhYIWg1cOPkDhVccPlR7M=;
 b=8dQN9gN9ej9i43GElLGYbszMymHwxeJW2OmcXiRvmXcYj/4GFfTzTlHQ1YGAWaPxG5n5BDaN+
 FO4ETMfGFPwAKTnDiLBELXw5qtDywwUeN9fTojTTX8W6/F85DDzewjc
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
Add conditional schema constraints for Aspeed AST2600 MAC controllers:
- For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps properties
  with 45ps step.
- For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
  with 250ps step.
- Both require the "scu" property.
Other compatible values remain unrestricted.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..de646e7e3bca 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -19,6 +19,12 @@ properties:
               - aspeed,ast2500-mac
               - aspeed,ast2600-mac
           - const: faraday,ftgmac100
+      - items:
+          - enum:
+              - aspeed,ast2600-mac01
+              - aspeed,ast2600-mac23
+          - const: aspeed,ast2600-mac
+          - const: faraday,ftgmac100
 
   reg:
     maxItems: 1
@@ -69,6 +75,12 @@ properties:
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
+  scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
+      This reference is used by the MAC controller to configure the RGMII delays.
+
 required:
   - compatible
   - reg
@@ -88,6 +100,44 @@ allOf:
     else:
       properties:
         resets: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-mac01
+    then:
+      properties:
+        rx-internal-delay-ps:
+          minimum: 0
+          maximum: 1395
+          multipleOf: 45
+        tx-internal-delay-ps:
+          minimum: 0
+          maximum: 1395
+          multipleOf: 45
+      required:
+        - scu
+        - rx-internal-delay-ps
+        - tx-internal-delay-ps
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-mac23
+    then:
+      properties:
+        rx-internal-delay-ps:
+          minimum: 0
+          maximum: 7750
+          multipleOf: 250
+        tx-internal-delay-ps:
+          minimum: 0
+          maximum: 7750
+          multipleOf: 250
+      required:
+        - scu
+        - rx-internal-delay-ps
+        - tx-internal-delay-ps
 
 unevaluatedProperties: false
 

-- 
2.34.1


