Return-Path: <netdev+bounces-199704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF74AE1883
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0874189DB7B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670628467B;
	Fri, 20 Jun 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NMyYRy+N"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8027D773;
	Fri, 20 Jun 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413802; cv=none; b=oP+8aLp81EE+2mL3qnMZGBthRi+HuO/BQpQDRaBfi1WWwSB7tcLjQfS9Nr+w3mrxABINvOTAn6D778dp0HH6dEeNawnaYhlmo7AOcTJBllspGxEdz2d7sFNzDluH0cQWccdC2Nz8L7fSZeSzmc6fW72j1N60u2K0zeh2fqrIRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413802; c=relaxed/simple;
	bh=iKc91cdYdfE1q/34hs9vETkYhsg7TdYC4qPkcuYH0do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UT3/LXWw5/+nTuCCeqcj8MTAk1z2EhfiztWPJjxj4l6kj6UWmBamEcXF4TM9mPu2JlrsYfPw6uJxHwoPJ/fcoVCnns3QD/rOKAuVFl42ZMah3X2IAHHcdQXci4HQxLXFjUZEis+tqInHocK9z6qcTH2saL7bl2gFle90uaeZqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NMyYRy+N; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECEAC43191;
	Fri, 20 Jun 2025 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750413793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4izFgzZ5VPbCB317VwjTDgDBibegjlGP0F7T7bAVpM=;
	b=NMyYRy+NchvpVq26Lyf/CmXOc7kl5vdr928epMCxdtfsz6Dml2NY+roReLQzEONGFwnpl/
	yFRAAF1bIp753ZSFDhglsCU09vecz02+z80fmVzkLWUo5uwfApJbg/svsECspPwRETuusx
	DSHmJeHC85baGQJS8tjKFuKEd352Urur1ugt6UvIWb6C2tEAhXH4xh0sVi97UGvToU4XDT
	2MTTboj6pLz2qaM+tRx8m7XenALxY7OaRaEVeW3rIToGjPUr67vmOBKYUmbqpigepcHpNK
	IKTnHu11krZA8kuKAYDeaTvvb3BOnY4FKdX4aiOY6FqD3Wvg9LRAUWwfYqrGkQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 20 Jun 2025 12:02:39 +0200
Subject: [PATCH net-next 1/2] dt-bindings: pse: tps23881: Clarify channels
 property description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-poe_doc_improve-v1-1-96357bb95d52@bootlin.com>
References: <20250620-poe_doc_improve-v1-0-96357bb95d52@bootlin.com>
In-Reply-To: <20250620-poe_doc_improve-v1-0-96357bb95d52@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnr
 dgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-GND-Sasl: kory.maincent@bootlin.com

Improve the channels property description to better explain the
relationship between physical delivery channels and PSE PI pairsets.
The previous description was unclear about how channels are referenced
and used in the port matrix mapping.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index 3a5f960d8489..bb1ee3398655 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -30,10 +30,12 @@ properties:
     maxItems: 1
 
   channels:
-    description: each set of 8 ports can be assigned to one physical
-      channels or two for PoE4. This parameter describes the configuration
-      of the ports conversion matrix that establishes relationship between
-      the logical ports and the physical channels.
+    description: |
+      Defines the 8 physical delivery channels on the controller that can
+      be referenced by PSE PIs through their "pairsets" property. The actual
+      port matrix mapping is created when PSE PIs reference these channels in
+      their pairsets. For 4-pair operation, two channels from the same group
+      (0-3 or 4-7) must be referenced by a single PSE PI.
     type: object
     additionalProperties: false
 

-- 
2.43.0


