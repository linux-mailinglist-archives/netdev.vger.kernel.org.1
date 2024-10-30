Return-Path: <netdev+bounces-140392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB559B64EC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B656AB20FEF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6551F6681;
	Wed, 30 Oct 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HTgYZpgS"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56C1F4730;
	Wed, 30 Oct 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296519; cv=none; b=KFnSbxVU6je+lwyeulefzVZ3pyGeFp9jKVRDb4IaBvDOhOVbMuRzSC6SgsP7FYj1XA4n/DRIrtP7u0ZaY3oc+il1THVXMxOjkIq/EJkpov8eOBgSSWMnQHfX+Q0L1wJ1YM4oDh1mnc47IPF2SlsjjBd1hXBItoZEeqC8fuO/INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296519; c=relaxed/simple;
	bh=VvGomd4CsgGBhIU7pyBpX/Z+sXtXTWPEK3ZJsnpKH28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asYHnQMMc2fZZHuGD6dN+mJr3hsoJMCjGJQLrxWYSta5NsnuWqiW2cSTFIk35THIaOT7wm6k0ti6GDgM3/rREvfk7qpONFgDo9haCzVRCb1g1sadVcLJQG8EYH4Lwh5EAVFgJH7sPFo72YJlvMI2vJblTszjHsZlhQtrH0NduCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HTgYZpgS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34C801C000D;
	Wed, 30 Oct 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730296514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaSNYgBmbkGG1UyZcwoYGA9rHYudjY/FeaExeuN9m4g=;
	b=HTgYZpgS+JyYv7UAuRYMCJXsQIqwpncjfCa4XnGZx3xnPRuMNTvDyzZk+lZUEGfWcvaeoD
	MUPEC4+ZBRJj5UV71RdPAX9PMCrb+B06MtcXYZPHwtz/onhuBfeS9S/GGNFYN4m3GCWSzg
	XHStR7ONyP2dArcPtgqfzcgQYKqACigzg8b8+anPsds4EmkrbkCfvJZmrX8SrDjitKa3Hc
	NR3rDNJ9LvVoJ5d+pwKCv5+6rnMfIXXfH1oXhQHNT+LiMtj2zLRLKS+zXzRSJLN+MB2ypW
	T1/OkAb2vWlibshhC3pQVkJtnVCjU8qyIyit2gvcm83cW4kaqZqHSjKZFeFbdw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 14:54:49 +0100
Subject: [PATCH net-next v19 07/10] net: ptp: Move ptp_clock_index() to
 builtin symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_ptp_netnext-v19-7-94f8aadc9d5c@bootlin.com>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
In-Reply-To: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
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
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Move ptp_clock_index() to builtin symbols to prepare for supporting get
and set hardware timestamps from ethtool, which is builtin.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


