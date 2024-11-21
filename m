Return-Path: <netdev+bounces-146677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D5C9D4F26
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBB31F2029C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10B1E2834;
	Thu, 21 Nov 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pJ6nxZg0"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED51E2820;
	Thu, 21 Nov 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200280; cv=none; b=imd9HlbHncvJnIYuhiFsBrGNiAiywS5gBhAFSng7It4Uftvu7preAutu9PKANrSwi/i2EEStlfQP+fhNwvv+G/Ys5zXUtmL70GmiN5u5zn6d9XgD0ZPYF2fze2BR3IaFk0XCTDkM6FJWRIqGfJ1DpVyrQ6ZiDgHPe4in/Gzm/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200280; c=relaxed/simple;
	bh=8sobjCFBFsT9+xz8+Z2UWonKTJ0mO4ZVu0JHkUEE4Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azUh4qeYOzCul87eIpD+px+kdC+9x0pWvj3jqXrKLtMhBfZBccP8L06Np8e/8cSjoFg+X7hRF6SESGxlLtKgOn6FoeiutuUUZ/5pHUjPrziaZF+SzZnoB6hMlF7WJO8jKSTn5BRipUGySq5f7dIPWHSYW+Mnli5AcEfRnfwfCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pJ6nxZg0; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5588D40003;
	Thu, 21 Nov 2024 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EYD2bXtQk97J4lHluWo/28Vyaff+Wh4G3DPULHC/tI=;
	b=pJ6nxZg0cp7GyOYCB1QGV2TOze1sEmZCXPdYldOLTlNuUe51DrWxiSXRF240RkODN+plN8
	/I9CQBBo8NvPObSWtyYMmYz+4N5UKkXXfXDOhZtJ0cvYmGheTiwFI9L2SbgUhXyjZuEthA
	RVG2405bJSpia5iB9GC+1SSVrkrXmY6KIxgM/e+GSd6znRQ5Ehy6n5yITuYRmgVd8EiNKX
	TkJkRf1Q8h/dSpfrMKaXquDN5tSWQ+0mxSH7hHxmDrAr+uOhdFaTsBu5yHU5NOiEyqZOHV
	WrrVFdpLVmBD4anRH5nL+773UATJYyQ0Q+4pm5Y0drOXBDsGDXZrC6AQcm/MlA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:51 +0100
Subject: [PATCH RFC net-next v3 25/27] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-25-83299fa6967c@bootlin.com>
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

This patch adds the regulator supply parameter of the managers.
It updates also the example as the regulator supply of the PSE PIs
should be the managers itself and not an external regulator.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
index fd4244fceced..0dc0da32576b 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -68,6 +68,9 @@ properties:
           "#size-cells":
             const: 0
 
+          vmain-supply:
+            description: Regulator power supply for the PD69208X manager.
+
         patternProperties:
           '^port@[0-7]$':
             type: object
@@ -106,10 +109,11 @@ examples:
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
@@ -128,7 +132,7 @@ examples:
             };
           };
 
-          manager@1 {
+          manager1: manager@1 {
             reg = <1>;
             #address-cells = <1>;
             #size-cells = <0>;
@@ -161,7 +165,7 @@ examples:
             pairset-names = "alternative-a", "alternative-b";
             pairsets = <&phys0>, <&phys1>;
             polarity-supported = "MDI", "S";
-            vpwr-supply = <&vpwr1>;
+            vpwr-supply = <&manager0>;
           };
           pse_pi1: pse-pi@1 {
             reg = <1>;
@@ -169,7 +173,7 @@ examples:
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


