Return-Path: <netdev+bounces-110296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7B92BC2B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106621C20D01
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E5191484;
	Tue,  9 Jul 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lK0LJS7C"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E819047D;
	Tue,  9 Jul 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533256; cv=none; b=RFgxwiKEoy9N8lsyTh0L2yjxtTYTige14groDPJD5dhctfOPCQx62HHZaR10yxMX6y+MGi1be8vnCeeQ8BW/T5axgIeZLkA4omrvViY8dsnvrR4mfpj9xYkdsWfN4RS1vrSH8EjHpIr0kPAs9ZXz7qcj48aBnFA1t4DnwJ/n4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533256; c=relaxed/simple;
	bh=Ex1DFxzqtCXqvJ+a4DTzxQmabU1eUIweEZT/7M8pQ/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQapG8AnyyNze2crurUStxvUxVdUwm0wLy4ril7oZO6rbAGKI+bfAHek5f54yK49Dj4ZOvq6uASjC2E61awWqrbiH5+u4kjZUxvN7kXL3dF/2AO4CdOJZfZ/TviBnXOfxIk1QXA5ZAtnyng/Gv9dcxMR7XTsyYJzdgLloUy6NGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lK0LJS7C; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EF041BF210;
	Tue,  9 Jul 2024 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720533252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UylGglBX1XOLCextmbCbiuNhWEiRQlnEHwkHESX5MAo=;
	b=lK0LJS7CPzwfV0FbvevTD90jN7njRzuuW/O5Y66FrbbXoTCKoV+6hqt3fv8d8DvKzjI8yJ
	auYVJ21PW55Jjqlilq3V4z3q3h9oea9zIRcjToJLthUlePeSZvCDaF792DYv9cUxmCLieP
	23ROSV/QnU07OcEAzHC3PMJxj3pQHYJUk1d7NTwxn/U4tUlw/5N55Fio22vLkRorCLMRrC
	H7yLwMVoybE4FsXjQlso6eILzFUEYU795H8ajjQKTRl0ZeYsErAYx20qEJ8w99Vau5e+9f
	QrIWTUTqJGbAGDd2aTXF7shOYO5CUPC5FKE7kq/AWBvti/rddbRNds4TDBMo4g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Jul 2024 15:53:43 +0200
Subject: [PATCH net-next v17 11/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-feature_ptp_netnext-v17-11-b5317f50df2a@bootlin.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
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
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
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
index f5fab1c14b47..f521b07da231 100644
--- a/drivers/ptp/ptp_clock_consumer.c
+++ b/drivers/ptp/ptp_clock_consumer.c
@@ -108,3 +108,9 @@ void remove_hwtstamp_provider(struct rcu_head *rcu_head)
 	kfree(hwtstamp);
 }
 EXPORT_SYMBOL(remove_hwtstamp_provider);
+
+int ptp_clock_index(struct ptp_clock *ptp)
+{
+	return ptp->index;
+}
+EXPORT_SYMBOL(ptp_clock_index);

-- 
2.34.1


