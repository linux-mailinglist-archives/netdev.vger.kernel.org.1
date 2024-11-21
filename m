Return-Path: <netdev+bounces-146669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0F9D4F0C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6B9B216D6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F951E04A4;
	Thu, 21 Nov 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kiHmy+S0"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC21E00B5;
	Thu, 21 Nov 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200253; cv=none; b=oiHWU5eNl4wLIyOYqNu/YcFUjZTQKfXojYHoppFKo2+B62KWeSM2p+hae//4Vg2+IEqGuglH+LOdIuWR3rhP0l5uulMjAKD4tesDqp1DS9JiplH60PVinB+Sa2ZyifqWeeKKiDmiMuQC0z6lT2JRY76vKmkkBlvQT3CbRWU6cFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200253; c=relaxed/simple;
	bh=PmcM6Eq4mUZeQnTjPYQUDIKawcn+VUJWOtS6yiaro5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRs0zHUCqxWcWyku2CpZQzCTanMHBt8zQSOKx5CyvD0MW1t1LNdlphja06LuTkhc1NBxMbhLzrsZqiSzjmMOanveouD9L8gMPsOk0KdoKmtgHfLXD3uCqzz9sAKQotCXecP18yel4s4rU7ZtSA4MQNhuKvHHFQK4OdCAYExJIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kiHmy+S0; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E960C40003;
	Thu, 21 Nov 2024 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eH94oL4C+uAtHpUg+7hvQnupTMOvyV/l+52BXsH7jwA=;
	b=kiHmy+S0eG7bPmaCZkcWGHxdMkmfD7q8lFrQp+Ma78J4hUymBplOcFA/xT7MOEE8gWj4ab
	Gf1YiPXTju442tbUAss8RHd3wSIiq8EUJMF/JfaPM1Mlk0mr0USlrUq8CdrcAP4tH5e9O4
	VeDvkRNua2Qj/AHNuJ3cIYkdkijHJ/x5tsSHZpmWtaQfjLwo1VACahKPe00WfP1UX4V1sr
	YqH64qz95EZ6C91ziRqxpaa/9wDAJXJeXAC/wX6RCtLcHWRzln7v3j+9kv+F+/HywX7ILp
	kWeRavdtc6eFuDmc61LaBTiIxmUH1mkbPO2r5iPDXRew5UMMyF8gtdLuYueUlQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:43 +0100
Subject: [PATCH RFC net-next v3 17/27] regulator: dt-bindings: Add
 regulator-power-budget property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-17-83299fa6967c@bootlin.com>
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

Introduce a new property to describe the power budget of the regulator.
This property will allow power management support for regulator consumers
like PSE controllers, enabling them to make decisions based on the
available power capacity.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- new patch.
---
 Documentation/devicetree/bindings/regulator/regulator.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index 1ef380d1515e..52a410b51769 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -34,6 +34,9 @@ properties:
   regulator-input-current-limit-microamp:
     description: maximum input current regulator allows
 
+  regulator-power-budget:
+    description: power budget of the regulator in mW
+
   regulator-always-on:
     description: boolean, regulator should never be disabled
     type: boolean

-- 
2.34.1


