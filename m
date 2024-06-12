Return-Path: <netdev+bounces-102917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2564905662
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B36B1F25676
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CEF183073;
	Wed, 12 Jun 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BdKnpx8m"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7E181D07;
	Wed, 12 Jun 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204712; cv=none; b=YZvZSvSqAQ6znNqraLxufXHCv2/L9jvLttQj2SXGNnMcugi+nmXzMYb93963o24WgsXyIOk4KM1+trGHGtDvJdSAYoTGlofz/o4psN8hvfoch0jR+5w9ab6pPuWgt0+LlaV1cm/3h9+2Kc3hsV3JvCIIPIABeTAUTjD/ZFWm4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204712; c=relaxed/simple;
	bh=aeorz7ikHOyI3uGMrYyKmFVs7/hL9oxlIYMCbENPZPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQaU5AO/XAiCsd7CXrWe7iAeW38R7gojltYiVMozR+xjKWd9nAav9keOB5ogK3UZyftwfVrXsfRNpBDQE5zoQMyLRVQjJtab12Uhn+0qqr+xBNY9+oR0Io4bsPFwf77SreyIvoeNknLn/Sr1NSFk8EkSYXgcwa+nO8Su5KYj5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BdKnpx8m; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 463304000E;
	Wed, 12 Jun 2024 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718204709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=colQEtyFPW1f1bHjDkZLgN48b4d5EBtC727z2oaXiVM=;
	b=BdKnpx8m3SLwWkg2PKV0TnOcxHBuZV9SUVs1GMEVC3wjFOBRx5rWn+yBa/z1IrvoLAoD83
	yD1C6Tm2PK1926p/0fcPmwqUR9PXDAc4AmaHQ/9h756QTZhZH5sFSOz4QKMWSw5yNVJTPi
	2A4vV0iIrwM11pv83SWvaJIbRaV8SKK8MmDGaZhbHP33C43wsLmak6RqY1oWKZi3LXEJkm
	+RePuwEahMRei6SEsS7v/2N270ruVUD6WnXybZwVZIAoxDZ3fIL8+X1+7N8qMAq1y1TaDG
	an/KCYdeO20bxXglQgSVj3oCu6iaCUoMsyWduLWOj/58VkkjYQC0edPVZzJ52A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 12 Jun 2024 17:04:12 +0200
Subject: [PATCH net-next v15 12/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-feature_ptp_netnext-v15-12-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
In-Reply-To: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Move ptp_clock_index() to builtin symbols to prepare for supporting get
and set hardware timestamps from ethtool, which is builtin.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v13:
- New patch
---
 drivers/ptp/ptp_clock.c          | 6 ------
 drivers/ptp/ptp_clock_consumer.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 593b5c906314..fc4b266abe1d 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -460,12 +460,6 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 }
 EXPORT_SYMBOL(ptp_clock_event);
 
-int ptp_clock_index(struct ptp_clock *ptp)
-{
-	return ptp->index;
-}
-EXPORT_SYMBOL(ptp_clock_index);
-
 int ptp_find_pin(struct ptp_clock *ptp,
 		 enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/drivers/ptp/ptp_clock_consumer.c b/drivers/ptp/ptp_clock_consumer.c
index 58b0c8948fc8..69d2921e45a1 100644
--- a/drivers/ptp/ptp_clock_consumer.c
+++ b/drivers/ptp/ptp_clock_consumer.c
@@ -98,3 +98,9 @@ void ptp_clock_put(struct device *dev, struct ptp_clock *ptp)
 	put_device(&ptp->dev);
 	module_put(ptp->info->owner);
 }
+
+int ptp_clock_index(struct ptp_clock *ptp)
+{
+	return ptp->index;
+}
+EXPORT_SYMBOL(ptp_clock_index);

-- 
2.34.1


