Return-Path: <netdev+bounces-284442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG5oJW7++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:27:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3715D4CF62E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B19C3026E91
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A02481FBB;
	Tue,  5 May 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aibqIcsT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D747F2F3;
	Tue,  5 May 2026 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991135; cv=none; b=ICx/SwTopDSiHGvVKji0OEhRn2xpg4cnhacOSRqfi9Ns0IenTOxGLbpfn45iiguOj0zIcW+Oh3jBD2JxnyhuLhVzoGZITRcNN4qSyiu5+5oYJ6RmlDN2fqFTalk+eNYlPacyqSJVtPUrKNp5IOO8FhFv3InFeC+wwKZ8a9sE4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991135; c=relaxed/simple;
	bh=8jz8tYeSWIROM17x0GWQBuJQ/3o2BnZyxeI2jrIszWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twVA7N+YPeuJLucJH4e7RjCbP1n8cTYyAfOR3h4qh4JAFcX69TvWdMOfbzPoPrKW+LoP0kLNEXvCk0pc9h3r8FsVLsGzW37owWW6Qwzyw4hsfEc2Zmt+QuEp0dnYzjn0ndz9+xqTZyIPjFQI9QovKh3loCYGX85CM529+/FzIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aibqIcsT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E4BC0C5D739;
	Tue,  5 May 2026 14:26:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15C336053C;
	Tue,  5 May 2026 14:25:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 206EC11AD024D;
	Tue,  5 May 2026 16:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dN8OTOz2CBIZVO4HdWgUL6ssubbJ9fWY50uiLEocxyg=;
	b=aibqIcsT/aGX+fjvkJiBpvHLnwK+ZK7GXTphdki98leqS3/mfuUl8kzp7TTPq1vtRO3zPV
	EjrtKFs15zrE/syRWVb5VCBOQiMra0VHA+YJaFdVTnCVRDkf1JFpuNsuV8eKqFFo2zS1O+
	XrntDo4p8HsoFr3F5Ydhcadc+pA435N/hagf7UAgEo52sKjz6QcDW/ouEVsfErAs2HoU8M
	aYeg9gCAqK0IIE/NojeHOPb9jx5B0ExaAt+WWDFpdhcCb1bj21/vd8GnIFR3p1gK4hvHZ2
	IepxpGLOx/oLde+dchAYdhCBQKMxm+8HPXm9EzDqrtpYNts/kOxLqb+fAS2wcQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:08 +0200
Subject: [PATCH net-next 8/9] net: dsa: microchip: split
 ksz_get_tag_protocol()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-8-05d70fa42461@bootlin.com>
References: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
In-Reply-To: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 3715D4CF62E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

From: Vladimir Oltean <vladimir.oltean@nxp.com>

All the switch families use a common function to implement
.get_tag_protocol(). This function then returns the relevant protocol
depending on the chip ID.

Make the protocol to dsa_switch_ops association a little bit more
obvious by having separate implementations.

Change made by manually checking which chip id has which dsa_switch_ops
assigned to it, then filtering the common ksz_get_tag_protocol() for
just those chip IDs pertaining to it.

As an important benefit, we no longer have that weird-looking
DSA_TAG_PROTO_NONE fallback which was never actually returned.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 32 +++++++++++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz9477.c      | 16 +++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c   | 31 -------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  3 ---
 drivers/net/dsa/microchip/lan937x_main.c |  9 ++++++++-
 5 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index f7801269b11a4..fa2e1256323c2 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2100,6 +2100,32 @@ static void ksz8_switch_exit(struct ksz_device *dev)
 	ksz8_reset_switch(dev);
 }
 
+static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
+						      int port,
+						      enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_KSZ9893;
+}
+
+static enum dsa_tag_protocol ksz87xx_get_tag_protocol(struct dsa_switch *ds,
+						      int port,
+						      enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_KSZ8795;
+}
+
+static enum dsa_tag_protocol ksz88xx_get_tag_protocol(struct dsa_switch *ds,
+						      int port,
+						      enum dsa_tag_protocol mp)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (ksz_is_8895_family(dev)) /* KSZ8864, KSZ8895 */
+		return DSA_TAG_PROTO_KSZ8795;
+
+	return DSA_TAG_PROTO_KSZ9893;
+}
+
 static void ksz88x3_phylink_mac_config(struct phylink_config *config,
 				       unsigned int mode,
 				       const struct phylink_link_state *state)
@@ -2229,7 +2255,7 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 };
 
 const struct dsa_switch_ops ksz8463_switch_ops = {
-	.get_tag_protocol	= ksz_get_tag_protocol,
+	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
@@ -2290,7 +2316,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 };
 
 const struct dsa_switch_ops ksz87xx_switch_ops = {
-	.get_tag_protocol	= ksz_get_tag_protocol,
+	.get_tag_protocol	= ksz87xx_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
@@ -2351,7 +2377,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 };
 
 const struct dsa_switch_ops ksz88xx_switch_ops = {
-	.get_tag_protocol	= ksz_get_tag_protocol,
+	.get_tag_protocol	= ksz88xx_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 9fb0169b5e29e..9bac95bb079ff 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1610,6 +1610,20 @@ static void ksz9477_switch_exit(struct ksz_device *dev)
 	ksz9477_reset_switch(dev);
 }
 
+static enum dsa_tag_protocol ksz9477_get_tag_protocol(struct dsa_switch *ds,
+						      int port,
+						      enum dsa_tag_protocol mp)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->chip_id == KSZ8563_CHIP_ID ||
+	    dev->chip_id == KSZ9893_CHIP_ID ||
+	    dev->chip_id == KSZ9563_CHIP_ID)
+		return DSA_TAG_PROTO_KSZ9893;
+
+	return DSA_TAG_PROTO_KSZ9477;
+}
+
 static void ksz9477_set_gbit(struct ksz_device *dev, int port, bool gbit)
 {
 	const u8 *bitval = dev->info->xmii_ctrl1;
@@ -1775,7 +1789,7 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 };
 
 const struct dsa_switch_ops ksz9477_switch_ops = {
-	.get_tag_protocol	= ksz_get_tag_protocol,
+	.get_tag_protocol	= ksz9477_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 37e575bf4e14d..1be055d3f1994 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3304,37 +3304,6 @@ int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
-					   int port,
-					   enum dsa_tag_protocol mp)
-{
-	struct ksz_device *dev = ds->priv;
-	enum dsa_tag_protocol proto = DSA_TAG_PROTO_NONE;
-
-	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
-		proto = DSA_TAG_PROTO_KSZ8795;
-
-	if (dev->chip_id == KSZ88X3_CHIP_ID ||
-	    dev->chip_id == KSZ8463_CHIP_ID ||
-	    dev->chip_id == KSZ8563_CHIP_ID ||
-	    dev->chip_id == KSZ9893_CHIP_ID ||
-	    dev->chip_id == KSZ9563_CHIP_ID)
-		proto = DSA_TAG_PROTO_KSZ9893;
-
-	if (dev->chip_id == KSZ8567_CHIP_ID ||
-	    dev->chip_id == KSZ9477_CHIP_ID ||
-	    dev->chip_id == KSZ9896_CHIP_ID ||
-	    dev->chip_id == KSZ9897_CHIP_ID ||
-	    dev->chip_id == KSZ9567_CHIP_ID ||
-	    dev->chip_id == LAN9646_CHIP_ID)
-		proto = DSA_TAG_PROTO_KSZ9477;
-
-	if (is_lan937x(dev))
-		proto = DSA_TAG_PROTO_LAN937X;
-
-	return proto;
-}
-
 int ksz_connect_tag_protocol(struct dsa_switch *ds,
 			     enum dsa_tag_protocol proto)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 37923a1c43d80..39486b5571bd6 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -473,9 +473,6 @@ void ksz_teardown(struct dsa_switch *ds);
 int ksz_port_setup(struct dsa_switch *ds, int port);
 void ksz_port_teardown(struct dsa_switch *ds, int port);
 
-enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
-					   int port,
-					   enum dsa_tag_protocol mp);
 int ksz_connect_tag_protocol(struct dsa_switch *ds,
 			     enum dsa_tag_protocol proto);
 void ksz_init_mib_timer(struct ksz_device *dev);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index ff931b1143a52..c39be6eb50121 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -667,6 +667,13 @@ static void lan937x_switch_exit(struct ksz_device *dev)
 	lan937x_reset_switch(dev);
 }
 
+static enum dsa_tag_protocol lan937x_get_tag_protocol(struct dsa_switch *ds,
+						      int port,
+						      enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_LAN937X;
+}
+
 const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
@@ -714,7 +721,7 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 };
 
 const struct dsa_switch_ops lan937x_switch_ops = {
-	.get_tag_protocol	= ksz_get_tag_protocol,
+	.get_tag_protocol	= lan937x_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,

-- 
2.53.0


