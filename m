Return-Path: <netdev+bounces-291623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAZxO9BuFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3F5D3D12
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1B230530D0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494A23D9DA5;
	Tue, 26 May 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cFFmFgDO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742543D8917
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788869; cv=none; b=UmCGP2Klmikp/j0e8SlenU5/E8zB07ZJ4AqeNha1fLQ42vODPM+zUWeRl8CwGf88+Q9Z4BSWL3MxR6v7nHziq5LTort5NdjQXumi8WrgqUGdEEFGcK88gMLpEnAqw6xNac4CLeGYQX+JhxnEou6EDigH4am48CmQ9FqLe+OeK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788869; c=relaxed/simple;
	bh=/chFbqe/d9fGsKte/GmNLYtFYgRf7dD52fg9DqrYvzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gX/5AzDjNn7U9JrxLWr+StuRaxpl5PBHn8QbsFaO3+CEPEIftsm9xcZAz9oaVtRDgK3Lx3gVD9ySA5ydZmf7nn65dh9D1aDJDEy1JOdiTjW47na+cBWz0/6EsMQVwLLXFNxus085BpYpXPuR4oiydj2qHgxpnbKgSQJMpFTWLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cFFmFgDO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7F66FC79AB7;
	Tue, 26 May 2026 09:47:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35F3760732;
	Tue, 26 May 2026 09:47:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFF4210888589;
	Tue, 26 May 2026 11:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vzYaQ5yu63Jc3ORXyaAHobEcTOkRNZZ3zA5L1lbh9OM=;
	b=cFFmFgDOKknGbxOq4itLQRmbLoUz0AAquKTtfyjuOfHie/7hICNz4tt7TFJ9Ai3cRIXE2j
	e3Q+EagOrM5VG+s53BVvlN+Z1nAh33teIqd6C2Rxr3TpYv5TSEvds47x9rxr2wDkOh54A1
	Gg2e151AkqzlG/Ch6wj1hXa27Hao98jAqDdZQcPzu1Y7/yu7NgfmK3WF6EJNfVQAJOZaLv
	7XTN5eIUGg7jK81vov2aZw3wkZvl+teJFcwxpdyYdNxpIqIj2DxMtt5Udn1xPsD7IbvYBx
	YHGqErC/6T3yyScdl/d1TaHFE0ZQX0hv7f8Z++Wn8XvW2k4zCsceJiLri08flw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:29 +0200
Subject: [PATCH net-next 3/9] net: dsa: microchip: implement get_phy_flags
 only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-3-5b63e732149a@bootlin.com>
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
In-Reply-To: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 51A3F5D3D12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The common ksz_get_phy_flags() is used by all the switches to implement
the optional .get_phy_flags DSA operation. It always returns 0 except
for KSZ88X3 switches where an errata has to be handled.

Make ksz_get_phy_flags() ksz88xx-specific.
Remove the get_phy_flags implementation for the switches that don't need
it.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 22 +++++++++++++++++++---
 drivers/net/dsa/microchip/ksz9477.c      |  1 -
 drivers/net/dsa/microchip/ksz_common.c   | 18 ------------------
 drivers/net/dsa/microchip/ksz_common.h   |  2 --
 drivers/net/dsa/microchip/lan937x_main.c |  1 -
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 93e0b3f60448..98cf7239057d 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2272,6 +2272,24 @@ static int ksz8463_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val
 	return 0;
 }
 
+static u32 ksz88xx_get_phy_flags(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+
+	switch (dev->chip_id) {
+	case KSZ88X3_CHIP_ID:
+		/* Silicon Errata Sheet (DS80000830A):
+		 * Port 1 does not work with LinkMD Cable-Testing.
+		 * Port 1 does not respond to received PAUSE control frames.
+		 */
+		if (!port)
+			return MICREL_KSZ8_P1_ERRATA;
+		break;
+	}
+
+	return 0;
+}
+
 static int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
@@ -2419,7 +2437,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
-	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz8463_phy_read16,
@@ -2474,7 +2491,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_tag_protocol	= ksz87xx_get_tag_protocol,
 	.connect_tag_protocol   = ksz87xx_connect_tag_protocol,
-	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz8_phy_read16,
@@ -2532,7 +2548,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_tag_protocol	= ksz88xx_get_tag_protocol,
 	.connect_tag_protocol   = ksz88xx_connect_tag_protocol,
-	.get_phy_flags		= ksz_get_phy_flags,
+	.get_phy_flags		= ksz88xx_get_phy_flags,
 	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz8_phy_read16,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index c18bad08a508..a39541d29ad5 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1952,7 +1952,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_tag_protocol	= ksz9477_get_tag_protocol,
 	.connect_tag_protocol   = ksz9477_connect_tag_protocol,
-	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz9477_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz9477_phy_read16,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 81d3ec88e436..5fb151fbf4f3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2838,24 +2838,6 @@ void ksz_init_mib_timer(struct ksz_device *dev)
 	}
 }
 
-u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	switch (dev->chip_id) {
-	case KSZ88X3_CHIP_ID:
-		/* Silicon Errata Sheet (DS80000830A):
-		 * Port 1 does not work with LinkMD Cable-Testing.
-		 * Port 1 does not respond to received PAUSE control frames.
-		 */
-		if (!port)
-			return MICREL_KSZ8_P1_ERRATA;
-		break;
-	}
-
-	return 0;
-}
-
 void ksz_phylink_mac_link_down(struct phylink_config *config,
 			       unsigned int mode,
 			       phy_interface_t interface)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index da62c1658aa8..804912fdd2db 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -440,8 +440,6 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
 int ksz_handle_wake_reason(struct ksz_device *dev, int port);
 
-u32 ksz_get_phy_flags(struct dsa_switch *ds, int port);
-
 int ksz_sset_count(struct dsa_switch *ds, int port, int sset);
 void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
 			   uint64_t *buf);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 731737fd58d1..57e289637193 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -846,7 +846,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_tag_protocol	= lan937x_get_tag_protocol,
 	.connect_tag_protocol   = lan937x_connect_tag_protocol,
-	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= lan937x_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= lan937x_phy_read16,

-- 
2.54.0


