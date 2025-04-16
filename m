Return-Path: <netdev+bounces-183317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56092A9050F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8C43B6924
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4112505BA;
	Wed, 16 Apr 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ozN+m1fS"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555C24E4AC;
	Wed, 16 Apr 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811108; cv=none; b=D7XXjtQBXi8MO4jJhZVeeRomh9ij2XtVqKdyvej70XdjY7kqO6TUIOogVbkVdiIchw8A7HnR0IVgM1czH9QFapfNT1vsqh74rsDTwqEITPEI9NVEhv9RMECz1FsI59O2PhX4lrQ+qrK2HzhqMIRPtJkXqIEuwvVIRS0S+mRa42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811108; c=relaxed/simple;
	bh=Jn41cw8nKB5Et/jTyOLpaMmZXmY/SDIsbul00xmf0hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swpTkHRw2FBYZKAOP6UqMCro/T9qGXHHcbYhJx6kz/rrdDpWkU78y7C0H8zv7K+l4XnyD41DtGE171RWkAOLVqHSPQWHH1vZvp6k+fRHzkVYXUBFceuXQIXwBLTT1RSb8LZ/nHYElJyaWuB65FiH0nQdig00t3ZonD0OXtl+QxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozN+m1fS; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17B5A43903;
	Wed, 16 Apr 2025 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744811103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMaIRlhquyjfKzC9Nfmvr79PGKRBrxgo0Q9ST42MxmE=;
	b=ozN+m1fStrpV7jAHguRXNn63xpGgHFmS33RhMQv0xe3w4wQMG3H7qLdJ5NDE3scH3oC2Gn
	fCmaMTW245D4uT98dsaTrzkSD1lj7i8kdF9YAv6q0D7yjD6laafABIeKulkoBnaMnXenMA
	/DENJooEykOI82dvOrMyd3nKEddtC75ql42Fa9tdr9h9mPIuY0j/1+Ly2kybBqeCWx3WHS
	CHeSrNVaTth8KaELLmBX+DJfQ94Zdkv9pHLu6GNejMiiY862I8Mn2iZXZvfNRVd3MBWRXi
	X4NJt7sWsBauiMArKznaz0v/yCY9nts2+c3iBlMll625v8lsj3U9uMgawZ6hwQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Apr 2025 15:44:28 +0200
Subject: [PATCH net-next v8 13/13] dt-bindings: net: pse-pd: ti,tps23881:
 Add interrupt description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-feature_poe_port_prio-v8-13-446c39dc3738@bootlin.com>
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


