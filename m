Return-Path: <netdev+bounces-193217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C9AC2F2F
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857AE7B268D
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9E71F237A;
	Sat, 24 May 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W0PNd+hu"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8931EFF9B;
	Sat, 24 May 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084234; cv=none; b=UOX8ZM4kuuiYjUGOef5kcuW6Rf15rqOnDB+TcmlgdhqdID31RxcvYvjxEw8ibijrfRuEb+ytQJVZ781ZcNZPunTsd0QFWnUF5BEj3Kz/kCgtQcI3vWnnWn4KZi9mUs1J+REnL4nuZNUB9X4eh8jqWe3SLyMvRvhDjF619ySH9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084234; c=relaxed/simple;
	bh=rGg8+EozkQQCuLdHOWxVowBLcQKUluZ8A2bKQ4fS+gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+mA7OKyvKUu4ZumGt37RQO0reZ60CZVtTp7SgAlJCDS+jwueiLf8Q65XoufvDArDKQ8EJLbqqYotr8+X2OfAL9VP2f7xx1yT4hjcVo6WnEIWugnU4fk5Us9rkgup+AZydjP/FEmJAnYAAXa02elFzylgGhgxD4w3Kz+Qn0YJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W0PNd+hu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A77CA43981;
	Sat, 24 May 2025 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748084230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM4+yDcHuugruomL+JLR61kY18/HcLP5jRzK1F1euEI=;
	b=W0PNd+huFitMbrucrmmdbrS7hIfJgnnofpQztoKGkqLUfojTwvIqBiO/7xrGBRLs6NcRot
	FsNUc1YBx1rcmp7VFJ9jVEfgV+AJ8MoMdlyZbD3fz2qzzZ83fqFJRu2KHAcU8b2xvy+F+x
	0Uy851HvkmyevRyP5QlpFaeXR3S0Hm/GeRJxdJ1AJR/mAT+KcsgWGYZjx52pS3U1dI0xIB
	G0zL4hBO/ooi1UDkCb/S+d+FEjZ9FewHbNau+Dc6NaJcmdO6toAW/I9+5Rfm18WAAhnHn1
	glGZz/6lkNaE9/rMG3iEiQ5ti2Q3WrrZW0qgfLEiyNattFXgnTykCxe/X8JNow==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 24 May 2025 12:56:13 +0200
Subject: [PATCH net-next v12 11/13] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-feature_poe_port_prio-v12-11-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
In-Reply-To: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudehgeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikeenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdekpdhrtghpthhtohepkhihlhgvrdhsfigvnhhsohhnsegvshhtrdhtvggthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
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
2.43.0


