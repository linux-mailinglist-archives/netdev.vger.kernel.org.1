Return-Path: <netdev+bounces-146679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75F9D4F2C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3252281FC4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA51E32CA;
	Thu, 21 Nov 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hp64aSHI"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FC1E32B8;
	Thu, 21 Nov 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200286; cv=none; b=oIZjAIvBwmRBGtxN4vhy2QnUXMBZ16Fd6Gti8WmYeO3V6CxE2wprKDDyW+/B04vk3grsdO58ODu1dI8wb3PkgDEmjALWEYkpFJE7+btskf/1OZBaPEp+ItjDeFjf9xtlygCo5Y4dtrbMOwm9/42CZ+9igxCDFWpboJG1gf381hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200286; c=relaxed/simple;
	bh=FSkXv1pEsc86xlSs+uKmP+IRGAKuUeBV0ielPAvM/68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsL9aXMYEpJ/NKcSiSBvMq/vC7tRPSYnBVSa9NjGryX9zBFQXmNpbRlV9qK/Mg/nrZUmeu+qzJidUqUIuLhoJwDffX7hwrGVEM1o0XZ/sOmgL/NcBmlqjeLbEsPz+UT4qevNPTbqKB7kBe+bZK5hpFZAW8nQFX5YGS0odHx2jzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hp64aSHI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CF7140009;
	Thu, 21 Nov 2024 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CvRQYaUK8EzFLZ0ybAaQ1/a+EAtN4SsfxIocmO3j0U=;
	b=Hp64aSHI2mGUiaYZk5ZdDk7RKmT7XJMh98IgzYaYJTEc0U7Gx/XtK3Rz1GlH/F0zEW1UTL
	G+sA3+znMcF8I8lgdBUtzqiLAB/ElvSstmVGobgWH4oWBI+kfSswAnpc+dRRB0C+7I89++
	cEM1yZYaMAV9Mw4XT0hgCvEBMzwsnpVN6Qjsrfxr1P2XhCGCGO8M9jTqAlQTgCycSkpMUv
	1n3u/R+M8DTFh9WPsRAXxF2CyWBR3CN+4qYguPEthDDK7kg9W7r8MeklIzK0p85FnUPoYB
	sFD9F0FnWTxpOW7938ZakXllbmLbVU5ky57x39YRTSbqctw+x2mc5CiWWnMB+w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:53 +0100
Subject: [PATCH RFC net-next v3 27/27] dt-bindings: net: pse-pd:
 ti,tps23881: Add interrupt description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-27-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add an interrupt property to the device tree bindings for the TI TPS23881
PSE controller. The interrupt is primarily used to detect classification
and disconnection events, which are essential for managing the PSE
controller in compliance with the PoE standard.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- New patch
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index d08abcb01211..19d25ded4e58 100644
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
 
@@ -62,6 +65,7 @@ unevaluatedProperties: false
 required:
   - compatible
   - reg
+  - interrupts
 
 examples:
   - |
@@ -72,6 +76,8 @@ examples:
       ethernet-pse@20 {
         compatible = "ti,tps23881";
         reg = <0x20>;
+        interrupts = <8 0>;
+        interrupt-parent = <&gpiog>;
 
         channels {
           #address-cells = <1>;

-- 
2.34.1


