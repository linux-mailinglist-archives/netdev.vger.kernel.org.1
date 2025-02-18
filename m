Return-Path: <netdev+bounces-167412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97582A3A29E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A880C3A4DAA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF75274278;
	Tue, 18 Feb 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FDNxyL2t"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95949272932;
	Tue, 18 Feb 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895580; cv=none; b=AvSGN9Q22SbOXjF6p0ZjS4imgyLiBhvObokDag6G/h5Ie153mJc2IFbroB8CwOZ1xzZSYzDnVdXVPdRw6i2+ti1hPaVTmwhiWSuufnm/icGk8NikRxjLF5hQ7QlZpKbHSaqb32gvEPMEoWlWJN0N3hiSoO+F2SjKJ8oeoViP4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895580; c=relaxed/simple;
	bh=t1nJNnpVAbVuCugSGl71cMjZ0PL0FJgx4xql2/Bv3u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEt6OLH+Je/ofBNme2QvNUa8mM5JyWRBqqlXMGW/Dw9JUa1VyDvBdOuFjbAMMIuFSmuKVWY9BlnlLxSVGx90tvf3xL4vwrL6HLYyeDfovH2b+ij978EUvERb+4Y5qi2wPx2OY7K1L0VcHERi1+h0ym+breuLTAi3KesJSETXu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FDNxyL2t; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D682B44324;
	Tue, 18 Feb 2025 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739895577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6TrfIOC7ZKBjqzWaZmxxl+SaNJZisJJ/+EVN8flZjw=;
	b=FDNxyL2tncfwJhXJP+NSn/VlHnm3wcJpFBwyKN5KZP47ctVhpi+c4gcepZo2/wfP/fgD7D
	dqgfEgHlgbC/kIY1ES/h+JHUkMBZHYU3OAOcyKrGro4G5ACurZNgjaOrFtmqRYoWoZLOEQ
	tTq4bkDq1BB+x3bHR5pK2e3+3fXdh+UJVb23BZX3Es78a1qeymo1ZBV1tjUK+7NyG6oR5Y
	XQB/eUgA7GoxP5Fcl5cP13iRe4fCRMDzbbf0TQseQlLXiojpxJwyoe1VSXcMueUH03knoT
	zQN6zwTZ22t2GSotjlM8Lz199KnReZWRqlw6IF68Y5EJj5+48oFnhbIkB5ecYQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 18 Feb 2025 17:19:14 +0100
Subject: [PATCH net-next v5 10/12] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-feature_poe_port_prio-v5-10-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
In-Reply-To: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggstddumeeftdehfeemrgdvieeimeelvgeivgemleeisgdumegvsgguleemfhdtrgegnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtudemfedtheefmegrvdeiieemlegviegvmeeliegsudemvggsugelmehftdgrgedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhuk
 hdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch adds the regulator supply parameter of the managers.
It updates also the example as the regulator supply of the PSE PIs
should be the managers itself and not an external regulator.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
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


