Return-Path: <netdev+bounces-199707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE0AE1887
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FBD172AF9
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36428A1DA;
	Fri, 20 Jun 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="drsTSoje"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B59283FF0;
	Fri, 20 Jun 2025 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413803; cv=none; b=Od2VYvjQX/W2cyVmn5CHGwXHl4kWFpLtE7YGHlnIN8gTjI+TFjCKPSEFwNjBdl5JhpBWJHW2MD5fru1+98KgpVWVGdJ3/1P/nBRuQI0V70c/8Uvm2km9oRw6Q0Y39eh2QFTcBWSTtz+EIofAS/sIQx9IxEhRfN2/QsoVGL8TTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413803; c=relaxed/simple;
	bh=xPR/InKNKfudhPDMsRzEG2eMx0eJCVxmRV7MrFp61XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cj8p8tBzIb1M4R4EcEWwif6GiKS0Ftg37D6bvUmAyYRb19MUKGF1J07iu0riwvG2NG0JbF438cuF/lV5iZPkkA5GcK+ZMpMJlt5I908zQn9AbZLhmjQ0IrWKx87xE6Lxjvvs79+pVia+iL7+N2D/kNdWwCCLv/dZ2yyFBKtdIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=drsTSoje; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F7DB43194;
	Fri, 20 Jun 2025 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750413794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuMofWOPrsRbIItSZ8PDXSA7GLYNIKCwv7N2XYcmiBI=;
	b=drsTSoje48BRR/mJ2Zz9hh17Ob8Yp3T9MKDv5S4FVh90S1kvFlLwDps6RvF6YG4fVhzF78
	jzLK4WpzTNA58Jwo4chy+m7sNuWkoSII7eDXwlX/zGHjVrRAgDTHYzm1TwEIWTHjpn+evS
	Xxq97UIHKLw+VDDdy6j+qKfUkRhm8rzhvghsJ+oWwQ5AtlQ9wWGWk8C3/a4Zcb4M6CyWja
	ZDcJxHAJGvi2YyNJN+Mv4g5dDKWwBXpooeaP2pzwPbmUnYn+LFrai18rw2NGL2lt7/eJO7
	/9QbClO3T7Y1O7+SP2H3c2PvUE4I5SeQyvmRhcljgGuqTHjE3uh/bllMfMhz8g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 20 Jun 2025 12:02:40 +0200
Subject: [PATCH net-next 2/2] net: pse-pd: tps23881: Clarify
 setup_pi_matrix callback documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-poe_doc_improve-v1-2-96357bb95d52@bootlin.com>
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

Improve the setup_pi_matrix callback documentation to clarify its purpose
and usage. The enhanced description explains that PSE PI devicetree nodes
are pre-parsed before this callback is invoked, and drivers should utilize
pcdev->pi[x]->pairset[y].np to map PSE controller hardware ports to their
corresponding Power Interfaces.

This clarification helps driver implementers understand the callback's
role in establishing the hardware-to-PI relationship mapping.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/pse-pd/pse.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index e5f305cef82e..4e5696cfade7 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -159,7 +159,13 @@ struct ethtool_pse_control_status {
 /**
  * struct pse_controller_ops - PSE controller driver callbacks
  *
- * @setup_pi_matrix: setup PI matrix of the PSE controller
+ * @setup_pi_matrix: Setup PI matrix of the PSE controller.
+ *		     The PSE PIs devicetree nodes have already been parsed by
+ *		     of_load_pse_pis() and the pcdev->pi[x]->pairset[y].np
+ *		     populated. This callback should establish the
+ *		     relationship between the PSE controller hardware ports
+ *		     and the PSE Power Interfaces, either through software
+ *		     mapping or hardware configuration.
  * @pi_get_admin_state: Get the operational state of the PSE PI. This ops
  *			is mandatory.
  * @pi_get_pw_status: Get the power detection status of the PSE PI. This

-- 
2.43.0


