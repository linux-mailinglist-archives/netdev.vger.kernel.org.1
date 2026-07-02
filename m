Return-Path: <netdev+bounces-304051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3dPtE6ksRmphLAsAu9opvQ
	(envelope-from <netdev+bounces-304051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB446F5247
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:17:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=b2EBA8Ln;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304051-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8361F30F5BF7
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45447DFAE;
	Thu,  2 Jul 2026 09:07:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656338E5DE
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983273; cv=none; b=Auv9XjyJ55DogUfneIaQTTibCp4NncGV6dRRWG/Usw9h+FjIWE7JfIibl5GCTEA5I5P2NJFE2X8A9u/Uno9eV8Z8nNWvUOcDR4W3byL4QEok4qOdkD2Xw91I8rvySB2m6/2kZqJJGrJ/7vd8mZEIa7mW1L/0IdLXipmc7OJXzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983273; c=relaxed/simple;
	bh=gnXX8h6vugJCiVNJ+tl1tlbT3wC2EOZTwFzCWfTy+0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLUrJSn9FCDQlizVpmkWXfDwYbYcZak9m5zwPq+lXGD/afWfRcq4B06WQDYOPhT8kTseCoew5YeZdK6AqN0yCDz7byOawlopHv8h5eLhIc8h4tJgBbrWirKS51foIqPsqNy7kmOXp0oOcmD6/FDNPh5Wvy+zSZMZ3sN2PrV7KMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b2EBA8Ln; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C0BDB1A0DD4;
	Thu,  2 Jul 2026 09:07:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95BDC5FF03;
	Thu,  2 Jul 2026 09:07:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E20C104C99F5;
	Thu,  2 Jul 2026 11:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983269; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Eh9tdxtgC1Y80+J82MnO47fRUv8A6UQJ5guFshBUmc4=;
	b=b2EBA8LnagmX/yTi4w2zbVV3GAM6icWTWdBmBx99XEXpnNqpvn+st/tW8DQLxkmoY2kEd0
	mZUxIaOoiO4WMLBrsRc8JtNIYXaeVKs6g+qO6jLrwz/746hBs7fu6QdLh+jEo1FB1LLfQM
	E8x5zrtxMD/56af6SzHlRkAP652h3OcL3mjNVQvrAY0SrRaDJOxL3ogR2SirpM7R5eJhT/
	Efhk+Dl+Yh/7D4Fh/neAxqZOfm5tIE0yz1ZxzbnjNQD67pCAQWSGT52mD4t9ZLuq3bh8yq
	SL76o5MldKLrNx+KQIhDPK8oHwzIqbuO/uNtaI3wvSYNch3dnVJTj+qi1WVeOA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:30 +0200
Subject: [PATCH net-next 08/10] net: dsa: microchip: move
 ksz9477_set_default_prio_queue_mapping() to ksz9477.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-8-93441e695fa4@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-304051-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: ACB446F5247

ksz9477_set_default_prio_queue_mapping() dictates a KSZ9477-specific
behavior but is defined in the common section of the code.

Move its definition to the KSZ9477-specific area.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c    | 23 +++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  1 +
 drivers/net/dsa/microchip/ksz_common.c | 22 ----------------------
 drivers/net/dsa/microchip/ksz_common.h |  1 -
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index a831eb884ce4..691b9b18c707 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -15,6 +15,7 @@
 #include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <net/dsa.h>
+#include <net/ieee8021q.h>
 #include <net/switchdev.h>
 
 #include "ksz9477_reg.h"
@@ -1410,6 +1411,28 @@ static void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
 }
 
+int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev, int port)
+{
+	u32 queue_map = 0;
+	int ipm;
+
+	for (ipm = 0; ipm < dev->info->num_ipms; ipm++) {
+		int queue;
+
+		/* Traffic Type (TT) is corresponding to the Internal Priority
+		 * Map (IPM) in the switch. Traffic Class (TC) is
+		 * corresponding to the queue in the switch.
+		 */
+		queue = ieee8021q_tt_to_tc(ipm, dev->info->num_tx_queues);
+		if (queue < 0)
+			return queue;
+
+		queue_map |= queue << (ipm * KSZ9477_PORT_TC_MAP_S);
+	}
+
+	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
+}
+
 static int ksz9477_dsa_port_setup(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 962174a922a0..a84c000000e6 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -44,6 +44,7 @@ int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
 int ksz9477_enable_stp_addr(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
+int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev, int port);
 
 int ksz9477_port_acl_init(struct ksz_device *dev, int port);
 void ksz9477_port_acl_free(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2846041d97a5..4f6f5526c26b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2753,28 +2753,6 @@ void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
 	 */
 }
 
-int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev, int port)
-{
-	u32 queue_map = 0;
-	int ipm;
-
-	for (ipm = 0; ipm < dev->info->num_ipms; ipm++) {
-		int queue;
-
-		/* Traffic Type (TT) is corresponding to the Internal Priority
-		 * Map (IPM) in the switch. Traffic Class (TC) is
-		 * corresponding to the queue in the switch.
-		 */
-		queue = ieee8021q_tt_to_tc(ipm, dev->info->num_tx_queues);
-		if (queue < 0)
-			return queue;
-
-		queue_map |= queue << (ipm * KSZ9477_PORT_TC_MAP_S);
-	}
-
-	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
-}
-
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 7aa4a69d06ef..029080838237 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -512,7 +512,6 @@ int ksz_pirq_setup(struct ksz_device *dev, u8 p);
 int ksz_girq_setup(struct ksz_device *dev);
 void ksz_irq_free(struct ksz_irq *kirq);
 int ksz_parse_drive_strength(struct ksz_device *dev);
-int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev, int port);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)

-- 
2.54.0


