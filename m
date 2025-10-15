Return-Path: <netdev+bounces-229486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFCBBDCDBA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CE63AD434
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F831353C;
	Wed, 15 Oct 2025 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0dNwlcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324ED2153E7;
	Wed, 15 Oct 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512533; cv=none; b=l3sb+EYef3i2OE1PiQGKSJzfMcd2hlK8H0vCIR6Ch8Iz6R8q5GMWzHEjta/A8yVZbUp8uwTwDbFjKELwzATkuxkPsBy++9Xqv0fF+ASlr4m6WEkqadTyxfw+KaIGl+txlyamLte6lZnRC2Ga7JNoCgzCasws5DHbMIw8cGZ5dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512533; c=relaxed/simple;
	bh=m9aUxWoOvf6KxhNOwsEC/YLVISuan8Zpc3IMwKpcPLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sI1xbSkdUwLxqQnJvkAHpK4km+ZXeMZkXLKsNNTE3sfN0yKgwVNlLGt5lgJXnTLK5wpwoesqAdzKi5+BM8PKPVK/l8kpTOYgclUVbWmu8rnaJIlWDhy5e3KXWuXBEvAjVtIzETYT78hhrq/cx05H6JVSN5ziXvoREtDUcan4/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0dNwlcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4D8C4CEF8;
	Wed, 15 Oct 2025 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512532;
	bh=m9aUxWoOvf6KxhNOwsEC/YLVISuan8Zpc3IMwKpcPLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q0dNwlcbwLeRfQbHmwNUQuOVIEz0SSc3fW19SV0NNPH2zBaRq3+zOXcQK7UfMvyCK
	 cKObj1tMVXU1k9bk7EpcS1C30UFPDW8lsKuMt9B7rQiCnwA+eizME5MCpMRnEh1Fda
	 rxXuk+Hqi2pYnb2l5UUI8g/hG8rZiMRUvkr/XHLzsNMSyoK4G2E0ktd/D5PqgcgaRD
	 E6Ye0jn79yMVYMkZIyjiTiMWQMNPCBvdBFNNvJzcFjT9gxgl9kNxqA9NkaOtmLfPzD
	 i77Jsz7KYi8ASHaCp4GtPDgtMZ2k+s/fpNzkB6o+ZVTaeP8/LSqVEqVAX8F0bs/TbQ
	 yf5jQNQx5Rhcg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:01 +0200
Subject: [PATCH net-next 01/12] dt-bindings: net: airoha: Add AN7583
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-1-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
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


