Return-Path: <netdev+bounces-100531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC38FB024
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0F91C224F2
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDA1474D9;
	Tue,  4 Jun 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="asPa28aL"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9843146D79;
	Tue,  4 Jun 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497624; cv=none; b=jkiQNGTqMb8vvOOZuTG+y8o/1tp4K7YaMt7qekZL3SIMEvSYJZ6eL4XO0xnMmM54Abalb9pvnlcFlafOJAoQacvpiIq+In/HlAHpJura6WRMMhPrmGGDKIStQ2x2Mds82jZN4vhqD5xVAlfHafyjWx18XZhx8eEzHRni0ukGuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497624; c=relaxed/simple;
	bh=aeorz7ikHOyI3uGMrYyKmFVs7/hL9oxlIYMCbENPZPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnxDZ9zDjpk/bXCSnWcBKmvqoM/u892I5hXV4iPHI9Cld+BPnn181nE8xOXW8K6yNfywoXADcBq50bL5uFW5bRzdc6ysthPBnJrCI1l3nQZIURVdP0U07kA/AbamW3XCcvkBI91Nn8CoTI+nW+Utg22DWIY+4lyifyo5LfpflJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=asPa28aL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49BC21BF204;
	Tue,  4 Jun 2024 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=colQEtyFPW1f1bHjDkZLgN48b4d5EBtC727z2oaXiVM=;
	b=asPa28aLd8jgwUiNompuDnW0rrjuewJmwg/9avIJn5sQJRCRgGkb1l6gH3xHPNgZ0l3iSC
	OjGB1efKxd9xHdqutmoKdEYcPiM5NWjVOOVdul6M0kCXL2Q5Ru011glbNgf6/rl4nNR70c
	9sCOo0Hyvf/mr40TlNLETRItWnDaB/OOhyPbTWjIsLt2AkRm3aLYWSp9JrbV2N6XDpFUUG
	JQCXGDD0ORiFdL1ox8QjLtwltivvNm7ueqHaYUX7MLVW7bUgD13IRxfVr5MUfbnY20zDUs
	SJZ0Skdq/9elB0a+fkPSGVVmANkS73GUONEtGfpOtTBHn3z+3gUWEQ7rnpCL+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Jun 2024 12:39:47 +0200
Subject: [PATCH net-next v14 12/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-feature_ptp_netnext-v14-12-77b6f6efea40@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
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


