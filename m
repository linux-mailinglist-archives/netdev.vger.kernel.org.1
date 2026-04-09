Return-Path: <netdev+bounces-277011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHojFy2t12kMRQgAu9opvQ
	(envelope-from <netdev+bounces-277011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FE3CB75F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9ECC305749E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BA3A542F;
	Thu,  9 Apr 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="we9CDdWx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72D281503;
	Thu,  9 Apr 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741853; cv=none; b=pohScFXddQPOBab6BaKYe/62JeYQf4zIZXKjPzTYcsGF1TPJ9BARSpnzUXQULgy8HUhUKYV5MZ4kobPAMZC6rHQ1rDzo4WOLZakVHBtQI4PfKDT1piCHrM2yREtlJbeXv/3PetMQ4wIYte+suJG23SSHTOYoTNh7eXXYrGPMq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741853; c=relaxed/simple;
	bh=HWsWBwylPxX/oag7MZ6Z4JTQYom7njEWZFh24TIwLb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EcQakh38i8+1xM+6ed0qe4OkvUMJDRT0bqDQzRrfnr0jM7C+HheE5bfg+VGPvxGryeNHtiZzyLjB5SYzQPn2iK/jdzGzUUE1ckV4V0LOR4U95WikTwZvEHOBtiN2hdHVBqnNlJTMOrwAzSloX3bdPdyj5DtBhp/W3Cz2DT8JQPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=we9CDdWx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775741851; x=1807277851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWsWBwylPxX/oag7MZ6Z4JTQYom7njEWZFh24TIwLb4=;
  b=we9CDdWxTHq+M1g+UyPYBGcUCcsgTnpwB5WEuUPyz8VnlrSX18rygLdk
   cIuQyDLmE9Rbl29dXcgXJjWJ7+wZbV60rWVOYHe1VwBeM4bEU13kvQyXc
   5pQoi1y7GiyTzQ4KMCXBRe6V0yBUHJlZtY/aJXky8pC5OzNb3vZqQtugQ
   y6bqaXxEchmu9s1LVeVyce66LiJy52hGRuCx7udVce2TnWTTE66AgW/lE
   U3GG/A2GTDCMOqf/2fPx3YYs2674BuCDZyzEjOtCmC+0ZH3QRdmIVion8
   PClYmq16uGXLWIwJtpsCH2+LZY4VguXfdSc0Bq/DiuPToqGfJRKmnMySx
   g==;
X-CSE-ConnectionGUID: f6s3wHcjTmaC0Q3Df/37WA==
X-CSE-MsgGUID: VNQs8TRcTdW9dJZa9wu/bA==
X-IronPort-AV: E=Sophos;i="6.23,169,1770620400"; 
   d="scan'208";a="55876032"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:37:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 9 Apr 2026 06:36:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 9 Apr 2026 06:36:58 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: phy: fix a return path in get_phy_c45_ids()
Date: Thu, 9 Apr 2026 06:36:54 -0700
Message-ID: <20260409133654.3203336-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277011-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C46FE3CB75F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The return value of phy_c45_probe_present() is stored in "ret", not
"phy_reg", fix this. "phy_reg" always has a positive value if we reach
this return path (since it would have returned earlier otherwise), which
means that the original goal of the patch of not considering -ENODEV
fatal wasn't achieved.

Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
Signed-off-by: Charles Perry <charles.perry@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    Changes in v2:
      - Collect Andrew's Reviewed-by
      - Send to net instead of net-next
      - fix one typo in the commit message

 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..810327fa886a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -973,8 +973,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 				/* returning -ENODEV doesn't stop bus
 				 * scanning
 				 */
-				return (phy_reg == -EIO ||
-					phy_reg == -ENODEV) ? -ENODEV : -EIO;
+				return (ret == -EIO ||
+					ret == -ENODEV) ? -ENODEV : -EIO;
 
 			if (!ret)
 				continue;
-- 
2.47.3


