Return-Path: <netdev+bounces-180313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D04A80E76
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C63B19E1F29
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2A233D9D;
	Tue,  8 Apr 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j8NIHh68"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD422E400;
	Tue,  8 Apr 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122773; cv=none; b=iWjYK2H75AAP0ybprxKJ2n93DZWKAZpGsd5vkKL162+xxacwZ4mvSCUe2ylR+0ncel8EUV7Wgxe3ov4JzUiTex/hnbpN2Q5V9lxyItL03VaLNJXtu16f2oCUXCIKdfX3aUP4Mr7bdL70Kjx7E730SOvFTMcwRIJd7ax4g0EY958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122773; c=relaxed/simple;
	bh=Jn41cw8nKB5Et/jTyOLpaMmZXmY/SDIsbul00xmf0hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYFFf7X1eX4JYfd17aAQy6B11OA2zVD1WWbxx8tT4pUKntM8D0kplGxBclSKlmXE3WJ6Fkaobj3E0EhbFeXa4al1VhEILLgftbPDBykqK22XwO/qw9FOTG/nKf/Qn2JdFDzglH2p7AgoSF8ei065bBc96MUathGs8pbSfDA9wOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j8NIHh68; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39A50441CD;
	Tue,  8 Apr 2025 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744122769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMaIRlhquyjfKzC9Nfmvr79PGKRBrxgo0Q9ST42MxmE=;
	b=j8NIHh68TfXxzOYdLXy3qI8E2oE0xPdq/2J98xAIeUAUW4MTnhoGoIoPfQtu/U5EWdcTAN
	erJ6FRH3rGjhZl+O+TL5qj0o7W1Z3ALe1TUAZJFRsWS7WMH39ZM0Ml0u5bQDCZObqk2QxA
	z9Ien9mKE9LvIvie66QHk7ra9Dkzc+xw6xkGSoEddJY/F/Sducb4LWWjybV1BsjOaND8aQ
	MQe4cJr978eJDKbP99o5rQrwf3r0Ten/6YmUZdVHV0GHo4f1EK9gcVGCkT0tumiIaZc885
	PYPQ2Aho3E0GmYJqKd0IuLi0HDv+2it1K0wuvScwxTqsP7tRx08DCaQzg8k3+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 08 Apr 2025 16:32:22 +0200
Subject: [PATCH net-next v7 13/13] dt-bindings: net: pse-pd: ti,tps23881:
 Add interrupt description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-feature_poe_port_prio-v7-13-9f5fc9e329cd@bootlin.com>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
In-Reply-To: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhig
 idruggvpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add an interrupt property to the device tree bindings for the TI TPS23881
PSE controller. The interrupt is primarily used to detect classification
and disconnection events, which are essential for managing the PSE
controller in compliance with the PoE standard.

Interrupt support is essential for the proper functioning of the TPS23881
controller. Without it, after a power-on (PWON), the controller will
no longer perform detection and classification. This could lead to
potential hazards, such as connecting a non-PoE device after a PoE device,
which might result in magic smoke.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Change in v5:
- Use standard interrupt flag in the example.

Change in v3:
- New patch
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index d08abcb01211..3a5f960d8489 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -20,6 +20,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   '#pse-cells':
     const: 1
 
@@ -62,9 +65,12 @@ unevaluatedProperties: false
 required:
   - compatible
   - reg
+  - interrupts
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -72,6 +78,8 @@ examples:
       ethernet-pse@20 {
         compatible = "ti,tps23881";
         reg = <0x20>;
+        interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gpiog>;
 
         channels {
           #address-cells = <1>;

-- 
2.34.1


