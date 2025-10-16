Return-Path: <netdev+bounces-229974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDA2BE2C69
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146EB19C7DCB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F94299948;
	Thu, 16 Oct 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikJcBWLv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6855328607;
	Thu, 16 Oct 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610520; cv=none; b=HGi2w7tEvkhMOFtSh5uy0um7vV89P2QJx8+ZggG1ewG8eCC9kLJ8cdag0cYBMdK6MkP8zcCGlyKZEOQH7HohlM2vQTTlgrohH6Y87r6yMJXeAh/gc1hSQ2SIumrjh4QIHLRw7C+hnUDEGg0SMCBAlYd6nICk1wW6ARXfOq0R/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610520; c=relaxed/simple;
	bh=m9aUxWoOvf6KxhNOwsEC/YLVISuan8Zpc3IMwKpcPLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SokZRquLKJhmTBzQbGbbN1odDk/1iQZz0/ygVlK2eqqA9jSLX70cY5PusBzahjL1upQiH/uZu3yvIcqtBJgkMFiygSCNdccI45Ii91oSFEE8uGX6w9iRyY+cOHtUWjKo9Wdcycm15JJJSxUSa5IO2Yizn+OQDleptuaAIZQy7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikJcBWLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DFDC113D0;
	Thu, 16 Oct 2025 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610520;
	bh=m9aUxWoOvf6KxhNOwsEC/YLVISuan8Zpc3IMwKpcPLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ikJcBWLvDvcIZzbgK5g2pRk8QrztkorF6iYeFB4oLNBIEDRBFANuBsZMdhd8nr90K
	 Vot59Wg1qkjzOvbRy0XrpLMR9Kxm8QzITFyvqj5wH/ZAORSC9zot3qTNShiAxAOnGH
	 PIG3l4EA8cAZbxs9sdCl9M1CAEa9XdU47pWABugviZqTXZKyozOfZaL9brqb+dsfqh
	 GLeUz93U8aYH48qfGcloL8TDaOlseTujhI0yKvj4SngCj4uXnrN52HYC3tdqded07c
	 DjPGd98KJc22uBtlO/4Dk3DIy7ux82iErEK+IucQzg0VWCA+yV5bGrsaWkDocnvaGa
	 7TDD3RDAJN6mQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:15 +0200
Subject: [PATCH net-next v2 01/13] dt-bindings: net: airoha: Add AN7583
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-an7583-eth-support-v2-1-ea6e7e9acbdb@kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
In-Reply-To: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce AN7583 ethernet controller support to Airoha EN7581
device-tree bindings. The main difference between EN7581 and AN7583 is
the number of reset lines required by the controller (AN7583 does not
require hsi-mac).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 60 ++++++++++++++++++----
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index 6d22131ac2f9e28390b9e785ce33e8d983eafd0f..7b258949a76d5c603a8e66e181895c4a4ae95db8 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - airoha,en7581-eth
+      - airoha,an7583-eth
 
   reg:
     items:
@@ -44,18 +45,12 @@ properties:
       - description: PDMA irq
 
   resets:
+    minItems: 7
     maxItems: 8
 
   reset-names:
-    items:
-      - const: fe
-      - const: pdma
-      - const: qdma
-      - const: xsi-mac
-      - const: hsi0-mac
-      - const: hsi1-mac
-      - const: hsi-mac
-      - const: xfp-mac
+    minItems: 7
+    maxItems: 8
 
   memory-region:
     items:
@@ -81,6 +76,53 @@ properties:
       interface to implement hardware flow offloading programming Packet
       Processor Engine (PPE) flow table.
 
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - airoha,en7581-eth
+    then:
+      properties:
+        resets:
+          minItems: 8
+          maxItems: 8
+
+        reset-names:
+          items:
+            - const: fe
+            - const: pdma
+            - const: qdma
+            - const: xsi-mac
+            - const: hsi0-mac
+            - const: hsi1-mac
+            - const: hsi-mac
+            - const: xfp-mac
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - airoha,an7583-eth
+    then:
+      properties:
+        resets:
+          minItems: 7
+          maxItems: 7
+
+        reset-names:
+          items:
+            - const: fe
+            - const: pdma
+            - const: qdma
+            - const: xsi-mac
+            - const: hsi0-mac
+            - const: hsi1-mac
+            - const: xfp-mac
+
 patternProperties:
   "^ethernet@[1-4]$":
     type: object

-- 
2.51.0


