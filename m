Return-Path: <netdev+bounces-304052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LdnsBbwsRmpuLAsAu9opvQ
	(envelope-from <netdev+bounces-304052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:17:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948336F5254
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="XCc/ceRk";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304052-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304052-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 067B630465E0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2947ECDE;
	Thu,  2 Jul 2026 09:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD947DFAF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983275; cv=none; b=OV6cnciLRfAL9cNR+TRcTosWTDaKnW+LLknFSSaPRpRxLCF+qEOUTHueDB8SVP/WTihkCo+rl2HtHxqfdHaKZD/i0JFeI7labFcQ5X7F/kBoa1vngFnGTVt6Wl4V7ecqUrJQ3nWEEX1zM0lQWe5EJ37RfXSCl+9ylq4GivZwjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983275; c=relaxed/simple;
	bh=4UAp5ZrZWlF73uucLDzR3l0r11jDqRvLWAHa4K1+g+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVzMBA0Jn7A2MazV3R65ZTAXDhfxNqxwXZvYIOheFeBErQbXoa4Xk0yrlfcEmn7P8iMm/gxeINi6Q3QWVn9Btu4E9Q68ifkpx3mQ6dfqP+3QQqa8uaZp291/9oxEI9OG9gciAT4W22bSotiFZs5Fg7aSGn8SWhdrwUT8GYDvjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCc/ceRk; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9976F1A0DD7;
	Thu,  2 Jul 2026 09:07:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BEE05FF03;
	Thu,  2 Jul 2026 09:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2C00104C990D;
	Thu,  2 Jul 2026 11:07:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GQVrQgDR7eJBrRUODjf4Liq6ZKp5ye9nzyTUx+KIHkI=;
	b=XCc/ceRka18ozDjvOMsD8CVvQ//AJlNUvMp2X2cJ5EFWpFiNzSr8pQ6/JXZbpcHeUKWSi5
	+gVsDXXbvC/2kcQ3ORqj+gc83tKfK2By9TCF8XHp4DZWSEvyM7d2M7fa6r2sfV2usrjGss
	ctJCm5j97yUCiyGlRnpFQty7iBhwDSwVYEDp0/C6Uf+fyUmAlHkftOOqyXJKBvw7atvmmK
	QZdvl6jAAvAzV1Oc9RFVsnitaXQzJvRMbiJC6w/utHzSfRz8/obCk+YEYEVtewZO0gXJuj
	/cBnwDKUudoPtE/dJIUEWuEywqQAGumtuapZULj8d7eLlvIGYQKoGAbg6/mSXQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:31 +0200
Subject: [PATCH net-next 09/10] net: dsa: microchip: rename
 ksz9477_drive_strength_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-9-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304052-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 948336F5254

ksz9477_drive_strength_write() isn't used for the KSZ9477-family only.
It's also used for the KSZ87xx chip variants. This function name is
misleading.

Rename it ksz_drive_strength_write().

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4f6f5526c26b..15ed139564cb 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3838,8 +3838,8 @@ static void ksz_drive_strength_error(struct ksz_device *dev,
 }
 
 /**
- * ksz9477_drive_strength_write() - Set the drive strength for specific KSZ9477
- *				    chip variants.
+ * ksz_drive_strength_write() - Set the drive strength for specific KSZ9477
+ *				and the KSZ87xx chip variants.
  * @dev:       ksz device
  * @props:     Array of drive strength properties to be applied
  * @num_props: Number of properties in the array
@@ -3850,9 +3850,9 @@ static void ksz_drive_strength_error(struct ksz_device *dev,
  *
  * Return: 0 on successful configuration, a negative error code on failure.
  */
-static int ksz9477_drive_strength_write(struct ksz_device *dev,
-					struct ksz_driver_strength_prop *props,
-					int num_props)
+static int ksz_drive_strength_write(struct ksz_device *dev,
+				    struct ksz_driver_strength_prop *props,
+				    int num_props)
 {
 	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
 	int i, ret, reg;
@@ -3998,8 +3998,8 @@ int ksz_parse_drive_strength(struct ksz_device *dev)
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
 	case LAN9646_CHIP_ID:
-		return ksz9477_drive_strength_write(dev, of_props,
-						    ARRAY_SIZE(of_props));
+		return ksz_drive_strength_write(dev, of_props,
+						ARRAY_SIZE(of_props));
 	default:
 		for (i = 0; i < ARRAY_SIZE(of_props); i++) {
 			if (of_props[i].value == -1)

-- 
2.54.0


