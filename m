Return-Path: <netdev+bounces-296593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BgwBHwbQJmrYkwIAu9opvQ
	(envelope-from <netdev+bounces-296593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E496F657196
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:21:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=sI7z3PhR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296593-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296593-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EABBE3142739
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7353CDBBF;
	Mon,  8 Jun 2026 14:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A33CAE74;
	Mon,  8 Jun 2026 14:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927826; cv=none; b=e0YwrZua20hlIENtl0ZaFguGtyse5Y99e8MYUsUT0vtqWnZRs81q8qxPtWliX78f4pfeSdckVh20aeNnTfN3Abh/7e0DuQLAmYsxCFEG9PInZUewiw0E7rMGJhgb4w8vTm+PdYklUCfCaiA79o90qJxFXHuncdln1U312jXIptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927826; c=relaxed/simple;
	bh=/chFbqe/d9fGsKte/GmNLYtFYgRf7dD52fg9DqrYvzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhngjHEeEFW9fZ/AbVBpXhNQIg8Y4rLnmwOYK1dY1cMbUoiOwsWT4kpBxmXU4hDlZMrbcs3Hw8P/tHUI7FPHq2p3u6Bxo9tq4bS0SMkD10BdU7RpGFfqZ1Se/w6bXPhOYLK9s2Oor/xupMmfKKYekgyXGfm2P5zNLAp9BiZYVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sI7z3PhR; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1D1681A37CC;
	Mon,  8 Jun 2026 14:10:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3F7E5FFB7;
	Mon,  8 Jun 2026 14:10:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 949B2106A295D;
	Mon,  8 Jun 2026 16:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vzYaQ5yu63Jc3ORXyaAHobEcTOkRNZZ3zA5L1lbh9OM=;
	b=sI7z3PhR14h+kTMtKT8Qfw6sJZS+Sm86xRV/wMDI22IO9ouvld12QHFCZbVW4HCxUDB+5Y
	agPeYqxPgKVH7Uyk4s1a1anIOqu12DAo8OPxW0whxsvJIm98/CiMmCnu7a9q8BF8+xwz6X
	65TjTHF+OuqG53Xplj5niIbw5gpYB1Z8EK+nz2C3zkeYjTNDYA5QsMe1Q+xULEQP2UVp9f
	KyNyGDkBxqyA75jCOsjdI/W7gBoWq27XRq0ayHIPAN6CYcbryUZf37VLZQGA/7wLDFEl+F
	haQYQV9D4YNLHHidL2byGOlS+ZhwIf2zSVfK83A7XxTHADmohBjXHrNJkx1Ymw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:06 +0200
Subject: [PATCH net-next v2 03/10] net: dsa: microchip: implement
 get_phy_flags only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-3-6e61b7be23c4@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-296593-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E496F657196

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


