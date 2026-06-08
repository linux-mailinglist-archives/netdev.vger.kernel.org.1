Return-Path: <netdev+bounces-296600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w7NJBXzQJmr5kwIAu9opvQ
	(envelope-from <netdev+bounces-296600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:23:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92465720F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:23:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=NuDODtLY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296600-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC5630B1317
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596973D668E;
	Mon,  8 Jun 2026 14:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965843D5259
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:10:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927838; cv=none; b=JBziOs3X0eLdhnKGVrvz7pY0wAELpMJYr+oAJH+RpEJ7agsxzOkZs3faud/3tKB8BEqCKdduw6BFJcRB3u9RNT6TqIjxq9HSKmXpD3UiJxb/OjKykWEvD7FnRNlnXps3GwlnkzrcCQL9W+70KVAfPA3QCOtyAWlYa7H3AmAsQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927838; c=relaxed/simple;
	bh=dLf2hPhdjeR81oWJOxklIWm/A8TarMQ98Xpq3Xa5cqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWb9ps9Jk/5NpNnuzMRywfyoeJ3dlt44aVdsRFbLQAQWaBR6w8icNcOoAULzqeYxKXGOOpqAjuej//0L8yiAAmB8T4OXtVEtoUM3wP6WjssCF2DsXbjNARhv/dvlloZWO2fzj7YqBzSIRCawNfKWC6bFmFyqUd7b0AyP6rThzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NuDODtLY; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 499574E414F7;
	Mon,  8 Jun 2026 14:10:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CB165FFB7;
	Mon,  8 Jun 2026 14:10:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC7A9106A2977;
	Mon,  8 Jun 2026 16:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IfKgmu5CABMy/972M65pvBeWLhBqurxd2aekhpz/kvQ=;
	b=NuDODtLYVLwB0yM9fCKDUYkIHyiLCpFzHDg/xQp0O180xgRubGfCZrhsNDFkRLtDeWbcz4
	jLQ1lqrfEf7LPOHkZuSwaOcE08JmvmsrCNKnS3FP9l2IC4vayGxCeEcnS4dlSVg57yjPqv
	LvzQydDNQxCMXB5jq1rDH1RtIz6fCYe9+7rTPXJHbHH6dtAYaNKr7REGaU/hqiUW417WA6
	5jWocbGrVd01oDVubZO1oP671NnOtLS+GQL/nUGijh8q8IyiemVYurfpbP/IftQpg/Fkfc
	D9Fr7rhWxyTksYRRdnlZCjUDqjWfreUlTwsJNomRQaKPZj8e4deFysvp6uLfLQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:13 +0200
Subject: [PATCH net-next v2 10/10] net: dsa: microchip: implement
 port_teardown only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-10-6e61b7be23c4@bootlin.com>
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296600-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B92465720F

The port_teardown() operation is optional. Yet, it is implemented by all
the KSZ switches through a common function that doesn't do anything for
the switches that aren't part of the ksz9477 family

Remove the implementation from the switches that don't need it.
Implement instead a ksz9477-specific port_teardown.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  3 ---
 drivers/net/dsa/microchip/ksz9477.c      | 10 +++++++++-
 drivers/net/dsa/microchip/ksz_common.c   | 19 -------------------
 drivers/net/dsa/microchip/ksz_common.h   |  1 -
 drivers/net/dsa/microchip/lan937x_main.c |  1 -
 5 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 76b0f2ac8594..9a895a811195 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2450,7 +2450,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
@@ -2498,7 +2497,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
@@ -2552,7 +2550,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 48813b0f4280..f3f0c98dfb5a 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1941,6 +1941,14 @@ static void ksz9477_duplex_flowctrl(struct ksz_device *dev, int port, int duplex
 	ksz_prmw8(dev, port, regs[P_XMII_CTRL_0], mask, val);
 }
 
+static void ksz9477_port_teardown(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dsa_is_user_port(ds, port))
+		ksz9477_port_acl_free(dev, port);
+}
+
 void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 				 struct phy_device *phydev,
 				 unsigned int mode,
@@ -2073,7 +2081,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_hsr_leave		= ksz9477_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
+	.port_teardown		= ksz9477_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz9477_flush_dyn_mac_table,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d08659ffa442..d1726778bb48 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2953,25 +2953,6 @@ void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	ksz_update_port_member(dev, port);
 }
 
-void ksz_port_teardown(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	switch (dev->chip_id) {
-	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-	case KSZ9896_CHIP_ID:
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		if (dsa_is_user_port(ds, port))
-			ksz9477_port_acl_free(dev, port);
-	}
-}
-
 int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 			      struct switchdev_brport_flags flags,
 			      struct netlink_ext_ack *extack)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 7b9a12648e85..d90179bd7762 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -387,7 +387,6 @@ int ksz_switch_suspend(struct device *dev);
 int ksz_switch_resume(struct device *dev);
 
 void ksz_teardown(struct dsa_switch *ds);
-void ksz_port_teardown(struct dsa_switch *ds, int port);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
 bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 48cd367455c3..8eb5337b0c10 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -967,7 +967,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_bridge_leave	= ksz_port_bridge_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz9477_flush_dyn_mac_table,

-- 
2.54.0


