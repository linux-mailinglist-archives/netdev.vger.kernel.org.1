Return-Path: <netdev+bounces-303037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sqUKDT2AQ2qbZQoAu9opvQ
	(envelope-from <netdev+bounces-303037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:37:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC86E1B8B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Wbfs4TxI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303037-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303037-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECA71300AB34
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C341E5724;
	Tue, 30 Jun 2026 08:37:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9B19067C;
	Tue, 30 Jun 2026 08:37:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808634; cv=none; b=eWS60Epfl+WxZdvy7S8fzm/2hkiSbe3UOvSPfLSYMrJZMVpTDnPDZbBbe80Snt7qRKG4Imbtw6Kb9AxXkikxNmiD43khFaMe5qZXi2w+MdEOlaRDGGZ5C93vgk0o50LzRQvAede1WWkfOC2s45DjoGSBAefhEmDgGAOWXNki/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808634; c=relaxed/simple;
	bh=aooLG63bV4zknygq7xk22oDT4j7FegkFgEwk2Un2eec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nx+4oZTmhbUZO2dyoZgU174G+Q+nJvw0kph2DQRZkRJC0PpJefQ85KG9cQLIqXUpnK+sW4pn37a0pDtUoVBUQ0KiaMxsnsixa1JAgZ/8cKoMWR9po8b69PvS+LunSC5ScIzZRY6HeMmCR7aKfNqclfcdt1kbXYAcBOUaIbiIcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wbfs4TxI; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6403E4E40B94;
	Tue, 30 Jun 2026 08:37:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F9A160233;
	Tue, 30 Jun 2026 08:37:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77EC2106F1C74;
	Tue, 30 Jun 2026 10:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782808628; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fd/QA6acfgIrDHgg6VpbFw+QypozMGr8wd9fRrr3/8Q=;
	b=Wbfs4TxI74pThMevE/iwEHtgj27864fo5QxSfoWLoOsGVI9u8NDKPR6j4KnxsiEZsW1KBJ
	mlVGDH993x+KgcgiAi3XEnUEgnEUcrY0X4KyJSRWx/WAOg117a0d0qZzF5Dk1yPvNA5tNp
	RIZqAMPsLpLiWq4ZgfgoefLZZDN1pH+yKPkGC5eluWuWwVlP7jEFmQewnaO2A+sx62Rrid
	kVzXMpfnBNaEbYFrPY4X51Mq7nEN3u8XJJm/kZ+F5e/dAY2YqxHJ7/8zpqUg+G6hi4ippT
	vdkSbEe8DGir749qvy0+x/rztAfCPMPVL/PwTyXHBzybeJj/C0uMJcmIMTvG3A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next] net: phylink: Drop references to the .validate() method in comments
Date: Tue, 30 Jun 2026 10:37:00 +0200
Message-ID: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303037-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EBC86E1B8B

The phylink_mac_ops '.validate()' has been removed in:

commit da5f6b80ad64 ("net: phylink: remove .validate() method")

There are still a few comments around in phylink that references that,
related to the ports fields as well as the Pause configuration. Let's
drop these references and update the comments related to Pause handling.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..59dfe35afa54 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -153,8 +153,7 @@ static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
  * @mask: ethtool link mode mask
  *
- * Sets all the port type modes in the ethtool mask.  MAC drivers should
- * use this in their 'validate' callback.
+ * Sets all the port type modes in the ethtool mask.
  */
 void phylink_set_port_modes(unsigned long *mask)
 {
@@ -2095,9 +2094,9 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	/*
 	 * This is the new way of dealing with flow control for PHYs,
 	 * as described by Timur Tabi in commit 529ed1275263 ("net: phy:
-	 * phy drivers should not set SUPPORTED_[Asym_]Pause") except
-	 * using our validate call to the MAC, we rely upon the MAC
-	 * clearing the bits from both supported and advertising fields.
+	 * phy drivers should not set SUPPORTED_[Asym_]Pause"). MAC drivers
+	 * set their support using the MAC_SYM_PAUSE and MAC_ASYM_PAUSE
+	 * capabilities and must NOT change the phy's pause settings directly.
 	 */
 	phy_support_asym_pause(phy);
 
@@ -3931,9 +3930,9 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	/*
 	 * This is the new way of dealing with flow control for PHYs,
 	 * as described by Timur Tabi in commit 529ed1275263 ("net: phy:
-	 * phy drivers should not set SUPPORTED_[Asym_]Pause") except
-	 * using our validate call to the MAC, we rely upon the MAC
-	 * clearing the bits from both supported and advertising fields.
+	 * phy drivers should not set SUPPORTED_[Asym_]Pause"). MAC drivers
+	 * set their support using the MAC_SYM_PAUSE and MAC_ASYM_PAUSE
+	 * capabilities and must NOT change the phy's pause settings directly.
 	 */
 	phy_support_asym_pause(phy);
 
-- 
2.54.0


