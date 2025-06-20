Return-Path: <netdev+bounces-199706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15687AE1886
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8B04A1623
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C9289E1E;
	Fri, 20 Jun 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="faqqaLln"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF5280A5A;
	Fri, 20 Jun 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413803; cv=none; b=JpM0aSKOq4Jhx/J47xOeui5IKAASmwYR3Dq5cBpv507zE38YiiyhMtsmZRd6tSPmmRwrrs4IVa2MV56ERnj/sw01iCjEPR4SVwwEFTeburIxF9g5/1QRY6QASH8L/ww4cIeL8PrKqdx79zyl3Fwois1SQanYcB0ywMwz2j2hmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413803; c=relaxed/simple;
	bh=uKKp2EBsRiuwSy+I9KhR58Sjyf6N6HlLxdT1yn08xWw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jrnBXC50I5ff+9U06az79ilctUkDdhp/w9o6MG48cQxxGJI0kxOj8+zzSZMOdnRA4GP6XC2XJhaz6M4YMN4XLB8SqDvRsi4XarpYHYKAtAnsE8fFCs7JdDz2VWMbaD+QEiy0oinEogTl16qC3rkaP+qb0vAIzO1miwkwqH+fXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=faqqaLln; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E138C43183;
	Fri, 20 Jun 2025 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750413792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l9om1U2XVpUqMgPGNhzFWlJzgB+9ciqKyIqRaV1cuRI=;
	b=faqqaLlnI+kxIlIV8vXffBT8LU9sx4/1FcQDR9tqxQQedukkoFjAc6VUcyAz+FdU7wCjZT
	AjOAh79B6dKYHC2bLBRt0+W/eg4jMu9rRfZOySGjx/yLV3SLNyW0ce7LBAoyCoyjCkJDuh
	TvPKxn3/bias88iN9dhDyp/aCcRCRha4lI32PdR/+fgPIb3HOAnG7YpMTif5QjEU6ZnJ7U
	p5xJGkL7nXJ6OdHwgvNegqizJc1CaQvoA3GvqDM+0DpOWfOgq09YhoPN4znQ/M/NaTKHB8
	xbmbz7hmDNWu9cwRjTuopJze93g84JIIY+60vp/u6dcPeRHsinUyyWqfV8le8g==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next 0/2] PSE: Improve documentation clarity
Date: Fri, 20 Jun 2025 12:02:38 +0200
Message-Id: <20250620-poe_doc_improve-v1-0-96357bb95d52@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL4xVWgC/x3MQQqAIBBG4avErBN0oKiuEhGhfzWLVDQiiO6et
 PwW7z2UkQSZhuqhhEuyBF9g6orsvvgNSlwxseZGt6ZXMWB2wc5yxBQuKMddz8ZZ1hpUqpiwyv0
 fR/I4lcd90vS+HyYPbTRrAAAA
X-Change-ID: 20250619-poe_doc_improve-d28921dc200e
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Piotr Kubik <piotr.kubik@adtran.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-dd21f
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugefgudfftefhtdeghedtieeiueevleeludeiieetjeekteehleehfeetuefggeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsr
 dhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-GND-Sasl: kory.maincent@bootlin.com

Thanks to new PSE driver being proposed on the mailinglist figured out
there was some unclear documentation, which lead the developer on the
wrong path. Clarify these documentation.

The changes focus on clarifying the setup_pi_matrix callback behavior
and improving device tree binding descriptions, particularly around
channel-to-PI mapping relationships that are critical for proper PSE
controller integration.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      dt-bindings: pse: tps23881: Clarify channels property description
      net: pse-pd: tps23881: Clarify setup_pi_matrix callback documentation

 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 10 ++++++----
 include/linux/pse-pd/pse.h                                    |  8 +++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)
---
base-commit: 0341e1290e40a14ba8c955b9681c739dc2f14e99
change-id: 20250619-poe_doc_improve-d28921dc200e

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


