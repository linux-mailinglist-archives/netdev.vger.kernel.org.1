Return-Path: <netdev+bounces-193219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C90AC2F32
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB41189CDE6
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0067A1F4CB1;
	Sat, 24 May 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NCl1SNMN"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754F1F4725;
	Sat, 24 May 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084239; cv=none; b=oSRkIdOEDpYYRIUBokJq1JSk20f+L8RGLwH2tZ9qoee5UGU7vOcyJjOaPOdl19aOUO/IUAgA1FLv73m7kO3N45vBL/lvb06QKS645ds71aJeHGSH8mngEB7Vxblc92aO/dzCJwT9hZIUYUOY8jz+UZoEH5u6ftMQzv17U5+nk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084239; c=relaxed/simple;
	bh=TYmhhQzdL/cD2JJdewLa/1qf8twd/OUcCt86/tJZJdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaoFw3icYwNggiae1YKplt3rP7VfD5Yg+JITxOwR4IiP8eTvmECB3hFSRAQmvFyzn7rB09nIGrtsZXg8A5xOAzexu/8BQXKCJsnXW7coQESEG5/2QcK2QA/RgPujsw7KmvQUwyq9l1fn35J0ozv2FdnhsUuKv08g0zg3IpM2SF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NCl1SNMN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9005D43980;
	Sat, 24 May 2025 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748084232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywh2RgVGTSPBCH7D9W/NIFmHWpb1iZOWNtwG6KvDLXs=;
	b=NCl1SNMNCVcreVHilGvova8IR5oPcMVeudW3uMy6aNucv32d0WJRMi1KXqs4J8FWia498A
	ri0O8uO8/ysjl7DevMlEwnIBlC4mEg6pTAcg8RxZ1lpjo9UrlAdtVo8FVJikGjl8Fgw353
	U4lmGgSsZ8eJ5hoO4sYrrtsxA5nLmShSNkdw46uGqZCCchc3+aZkOZXTT2QhAAM9gxoNIV
	M/kJQq+z72w9lmz0nlSzhmyx04b6BwsxMwWAhtqCNho4CrRHFllkir/dguAwvORX+Ar0h8
	TDYvQZ0yofhBV812dXSAW1ATy/JlSy86yxZqxtaTx27m5BtOSk7arXFA/kYZeA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 24 May 2025 12:56:15 +0200
Subject: [PATCH net-next v12 13/13] dt-bindings: net: pse-pd: ti,tps23881:
 Add interrupt description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-feature_poe_port_prio-v12-13-d65fd61df7a7@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudehgeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikeenucevlhhushhtvghrufhiiigvpeduudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemvgeigegsmegtkegrsgemvggvkeemjegvieekpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
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
index 116c00f6f19c..d0b2515cfba6 100644
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
 
@@ -64,9 +67,12 @@ unevaluatedProperties: false
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
@@ -74,6 +80,8 @@ examples:
       ethernet-pse@20 {
         compatible = "ti,tps23881";
         reg = <0x20>;
+        interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gpiog>;
 
         channels {
           #address-cells = <1>;

-- 
2.43.0


