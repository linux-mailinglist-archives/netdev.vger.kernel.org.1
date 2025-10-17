Return-Path: <netdev+bounces-230386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9492BE778F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74979580A7F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B53112BD;
	Fri, 17 Oct 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMWddH23"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC73112BA;
	Fri, 17 Oct 2025 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691994; cv=none; b=kk0etNsRQz595Gj2MHhiESGmova4RywfMFXSMv6vHN1U5GfEAW9m2j72OSv81AZyxrLPEfd6uhsC3Lgi9kxFjxbsDV6W43iflydKvUn/2S/qhDHgMs5hW7o0uxVrop+JOOD4jF9IO0U0rJkzHnycFDMPNeeRLrNaGgZuUrv7hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691994; c=relaxed/simple;
	bh=2hoee5aUofQ7RDJJ+SoAmMAvRdZk3eVJOdj3z3fu1/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHjsZdey1XQCxKzJQLxbI8A5K9jymsUlRHho/tmX6XH9GdAboECzjVW56tfBHukSxa7RtWxDi5e1yASZ3eBO5rbmlStqx0/ITc4Ha2fpUMsHyz90rKSLUHEDKXgCbdkVm7cKj/fL28Q0hDth8Q5YgMHkgg0qUvUVAWcwDvCgGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMWddH23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE77C4CEFE;
	Fri, 17 Oct 2025 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691993;
	bh=2hoee5aUofQ7RDJJ+SoAmMAvRdZk3eVJOdj3z3fu1/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OMWddH23pCXxhbNHfOj+eV/wTAMH99uI99paDSSb3TCii7/NLqlu5kx82WqMpH7AO
	 KcK82avV1g6WC3M1+EOVDCBOiFIcAAOml6sPnYMHNijs9rsRg5XGiY4+1/cRDul9UW
	 Dtv4iZTUewXV/kS1NbsME0nPDZIPro6yK/zhnYDzxChqF5wSRpuhHtL5WLMxrJ9weL
	 AO3ci9RF+LAp9qq37W6G9sZlw0YyQ+Q0hrCn05rBXlyWmoiQK5XDUPzkJiK0wsCbZq
	 vsBVPTBUlUlaDd4J6ISNlKKbuzSeEqqCE0ZX6J9fTYrvVmzETSvF6E1+QruymFFr4L
	 GepxnjS5qNkug==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:10 +0200
Subject: [PATCH net-next v3 01/13] dt-bindings: net: airoha: Add AN7583
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-1-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
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
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 35 +++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index 6d22131ac2f9e28390b9e785ce33e8d983eafd0f..fbe2ddcdd909cb3d853a4ab9e9fec4af1d096c52 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - airoha,en7581-eth
+      - airoha,an7583-eth
 
   reg:
     items:
@@ -44,6 +45,7 @@ properties:
       - description: PDMA irq
 
   resets:
+    minItems: 7
     maxItems: 8
 
   reset-names:
@@ -54,8 +56,9 @@ properties:
       - const: xsi-mac
       - const: hsi0-mac
       - const: hsi1-mac
-      - const: hsi-mac
+      - enum: [ hsi-mac, xfp-mac ]
       - const: xfp-mac
+    minItems: 7
 
   memory-region:
     items:
@@ -81,6 +84,36 @@ properties:
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
+
+        reset-names:
+          minItems: 8
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
+          maxItems: 7
+
+        reset-names:
+          maxItems: 7
+
 patternProperties:
   "^ethernet@[1-4]$":
     type: object

-- 
2.51.0


