Return-Path: <netdev+bounces-155086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C856A00F8A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAC1165C0A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4921FE477;
	Fri,  3 Jan 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="btfhaA3X"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846201FE454;
	Fri,  3 Jan 2025 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938867; cv=none; b=BESX2En+vuK5z01V1OwSqL6jefnqrwUW616pG5XV2mfUYqPTtr/DzxgIWmOuIq0lMenQAsk3jAaTNBzSs7Ay0p/7LjIfYpmkUgCx3xtYGDc7w56A6hRYKXG72ibb18le+yH2LZNVnK+Bu58Er4+q+G9TBfCTlG77m082ah/S7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938867; c=relaxed/simple;
	bh=eRTDKa7YJxbJg6W8hg75dz6zce+b/nvsVSqGfZ41wb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiisReAGoDpp1LZqvzYW8Ep8ygtQM120PL+IOS9kusoMgI1GGOJ/Jl12wVlS0KZ4JdzNY0UXyavaZY/fwQGKbdxHtn6L1MDysi4fWY3j5zXEFNW5Qvc8TRjXynlH8SkbEtmlOJVls2tDpPWiYsi/TPI2tNMWnFEntKsOC2OtgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=btfhaA3X; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D829FF803;
	Fri,  3 Jan 2025 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpuDqXWaCxqA2x1yVVS8hTH+qPZUUdlXXGqJTCtoiKs=;
	b=btfhaA3XRRURe8asNXt13pOh35U6gvFCUWhzUskGK5JcFpjk9vdZicBJI7AbD+iBbZOUg5
	nyzbGDukI37SxOm1W5r3lvwT/bV6vUkNk6AstLkWIXVp5W2wU2v40wgQAzKArWlVv8Dfwd
	7JHjz07H1jNN4O+N8y8u5Ck5uwEK0ViCbjj0VzSDY0vLWrBBdxN4lpChccgI3Ifsu+bAQS
	/KjGRWg0bR5aRqonzTete+euJ1dcu7sR9yYFCBkeVbKyuK4KDdgcVmxVObGuXoEARnkway
	tazXKoLGqkgXWO8+l5ACwEXN6w/Lm/fIQZq3RtvEpmH+97fTnQREQJDeMeeIhg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:07 +0100
Subject: [PATCH net-next v4 18/27] regulator: dt-bindings: Add
 regulator-power-budget property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce a new property to describe the power budget of the regulator.
This property will allow power management support for regulator consumers
like PSE controllers, enabling them to make decisions based on the
available power capacity.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Add type.
- Add unit in the name.

Changes in v2:
- new patch.
---
 Documentation/devicetree/bindings/regulator/regulator.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index 1ef380d1515e..c5a6b24ebe7b 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -34,6 +34,11 @@ properties:
   regulator-input-current-limit-microamp:
     description: maximum input current regulator allows
 
+  regulator-power-budget-miniwatt:
+    description: power budget of the regulator
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+
   regulator-always-on:
     description: boolean, regulator should never be disabled
     type: boolean

-- 
2.34.1


