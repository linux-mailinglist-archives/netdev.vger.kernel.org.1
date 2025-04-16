Return-Path: <netdev+bounces-183314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A45A90501
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060B61906635
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9124E4AA;
	Wed, 16 Apr 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YL+zJm/M"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA624BCF9;
	Wed, 16 Apr 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811105; cv=none; b=kbTbXsqAsGk4X1+cNzkKyppUiWOVk0IKw1A+AzunPmVB9q1kgyMZggRbkzXs7iNnSdyIaVzp7KR8UNpk9FJxDnI+sFacuLVbTACaXE6l4TPnUHHSyXUWiAZrqC6dCklNqFDbEJihlSWJKi/SY7p5P9rBQOQIsSp0lxgFnJyE5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811105; c=relaxed/simple;
	bh=fdLBJz3XfsfY4TPnyBshtFiMS/5KSmrv/6AScwZObXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2llcSbszX+YIwdZe+0x44+gfouP/GlfCTQjp9a5jmjrP4yIiVHD2iTTtAUoD3WcStwiavRsL2diENW7DaqfB/1GjPKVmwieqGZins+ovgeaCdslnsJEvNokK2HntFBoAFyDcbAgxG0xFX/ULJQzF3EQ5p7PiVftvMeWHUINnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YL+zJm/M; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 429824390E;
	Wed, 16 Apr 2025 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744811100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFEefeZamBor0b/TGmFIcJZdU44c/sbmnuWd9h4THL8=;
	b=YL+zJm/MuRHM+M2fs+H7Jn4ChUiKid4TYabFxIUOLHTdNKy8pnDqjKnWbcbEJ0o+E+2mC2
	C1tHgFszsABeQlM5KhSxwy68lQAEz/mWliQUyaUv0u1hncIE7YpKinZHRAuJE/MwSqkgl2
	tvZNjNYXsM2sLtMMRwXJl6lMjRu9lIsGFODz7i7qMxUre/JvCfhae4xl2WymjD8FMA+1nr
	/Y6qi3AlHi7cfx8QuJ5j/IrJerzwA4QE8fWRuYDJ2sjEaAJCSaGj9eb0D3ZRREwAA653IB
	nkK5/QoNuQrG84881E276LBuj4K6XVOve1ukG4L4sp85zm4zfAByET0FTrlrdA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Apr 2025 15:44:26 +0200
Subject: [PATCH net-next v8 11/13] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-feature_poe_port_prio-v8-11-446c39dc3738@bootlin.com>
References: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
In-Reply-To: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehhohhrmhhssehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Adds the regulator supply parameter of the managers.
Update also the example as the regulator supply of the PSE PIs
should be the managers itself and not an external regulator.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v5:
- Add description of others power supplies.

Changes in v3:
- New patch
---
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
index fd4244fceced..ca61cc37a790 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -22,6 +22,12 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Regulator that provides 3.3V VDD power supply.
+
+  vdda-supply:
+    description: Regulator that provides 3.3V VDDA power supply.
+
   managers:
     type: object
     additionalProperties: false
@@ -68,6 +74,15 @@ properties:
           "#size-cells":
             const: 0
 
+          vmain-supply:
+            description: Regulator that provides 44-57V VMAIN power supply.
+
+          vaux5-supply:
+            description: Regulator that provides 5V VAUX5 power supply.
+
+          vaux3p3-supply:
+            description: Regulator that provides 3.3V VAUX3P3 power supply.
+
         patternProperties:
           '^port@[0-7]$':
             type: object
@@ -106,10 +121,11 @@ examples:
           #address-cells = <1>;
           #size-cells = <0>;
 
-          manager@0 {
+          manager0: manager@0 {
             reg = <0>;
             #address-cells = <1>;
             #size-cells = <0>;
+            vmain-supply = <&pse1_supply>;
 
             phys0: port@0 {
               reg = <0>;
@@ -161,7 +177,7 @@ examples:
             pairset-names = "alternative-a", "alternative-b";
             pairsets = <&phys0>, <&phys1>;
             polarity-supported = "MDI", "S";
-            vpwr-supply = <&vpwr1>;
+            vpwr-supply = <&manager0>;
           };
           pse_pi1: pse-pi@1 {
             reg = <1>;
@@ -169,7 +185,7 @@ examples:
             pairset-names = "alternative-a";
             pairsets = <&phys2>;
             polarity-supported = "MDI";
-            vpwr-supply = <&vpwr2>;
+            vpwr-supply = <&manager0>;
           };
         };
       };

-- 
2.34.1


