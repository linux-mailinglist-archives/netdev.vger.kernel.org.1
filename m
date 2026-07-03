Return-Path: <netdev+bounces-304407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IxELColnR2olXwAAu9opvQ
	(envelope-from <netdev+bounces-304407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA286FFA60
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=va5471tG;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304407-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304407-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02E6303AA97
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE06335F8D2;
	Fri,  3 Jul 2026 07:31:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1536A027;
	Fri,  3 Jul 2026 07:31:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063889; cv=none; b=N0DB1CBa+W+uhBP637+Zz2/G02+ooefnB07g7Rl3ea9c0lQnWmu1ntjOzy2pJgzv/mK6KrdPm/VaDVYFEJrfEPOGNxmHP562A8q7W+ruJvegasfJoqqaB79im5fp4qO1xQaoNz6UwjMCTPz//qa2EARBRH0PaIPayAhAyj69wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063889; c=relaxed/simple;
	bh=AGk/PzkSnD7U+H6RCno8dl2uyBvdpE9Nto/TE46t6F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDMbxO1OyOphL4a1/ZvJLD1iBAxgaBb7jnUzJ+o3WpX88C6dOB5HzH4BZkmdDJHpx9BcH6v5Z8MJbTEgeTebtFxE9GM1XYxXKifO1Lh9fUjTyw4LdivC71SnuvKyVNhNpadUK13orxgYyubHX1m1fEasLJAqfTklcBa65ocAsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=va5471tG; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 6487760C04;
	Fri,  3 Jul 2026 03:31:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063885; bh=fu+2hAxKrnIRTtk5w3LDslFXFRwOWOppD49wLv70BB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=va5471tGL300KxFgvSSn7IhstU1VuhtioRX20KuQhYBPAWgXAqti3fWonGz86/nJy
	 MPfzmfWvhGaI7Fy3P5wcTsxU+HXJ2zd1v3j0iW+sHeZDP/LZZptqcNPMmYKDvLlhTW
	 G5ujZZCdlwULbSjJ9LcgG/VEqZTWaWN+Pl4tAVeafyXNI9zyJsL2GAUH8M4JrJDoFq
	 85bvmWWf/pi5jzZcO+3F7q/m1ZexYCfmkeRipWGPryewFqRI65wNzv22JWqlv9sCVa
	 Zx2GVHXMDOXAriqwBPFHE1RhyJ+lEug4FeUtayErhpgwKUdyqReTAWLBkZtzj/O7V0
	 kqNAKF1Dm6kKw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:29 +1000
Subject: [PATCH net-next 10/12] net: dsa: qca8k: drop redundant
 mgmt_eth_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-10-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
In-Reply-To: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=7254;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=kNzUBISFxdpN/lRjeZA5BSOluqM4Z8yN5XK5e2nxZJ4=;
 b=a59KG3ItV7yxFFI+bO5+K8XH4VFrgpg4N4KOdUPcoq4PmHJzxz2NltoTqNn+fXVyck5HdRDSD
 HXegFSpfLwKAgdrlTNrOiRhyLP9evFf+8/WUDs9SO4LGdw6kuOUq9Gx
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304407-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch,waldekranz.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:horms@kernel.org,m:f.fainelli@gmail.com,m:tobias@waldekranz.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ansuelsmth@gmail.com,m:viviendidelot@gmail.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:dkim,padl.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA286FFA60

From: Christian Marangi <ansuelsmth@gmail.com>

Now that we generalized inband logic and functions to dsa core, we can
drop the custom qca8k struct to handle inband mgmt and use directly the
dsa core dsa_inband struct in the priv struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 30 +++++++++++-------------------
 drivers/net/dsa/qca/qca8k.h      |  6 +-----
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 14371c3c9a459..3314dff580316 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -162,7 +162,6 @@ qca8k_set_page(struct qca8k_priv *priv, u16 page)
 
 static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 {
-	struct qca8k_mgmt_eth_data *mgmt_eth_data;
 	struct qca8k_priv *priv = ds->priv;
 	struct qca_mgmt_ethhdr *mgmt_ethhdr;
 	u32 command;
@@ -172,7 +171,6 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 	int i;
 
 	mgmt_ethhdr = (struct qca_mgmt_ethhdr *)skb_mac_header(skb);
-	mgmt_eth_data = &priv->mgmt_eth_data;
 
 	command = get_unaligned_le32(&mgmt_ethhdr->command);
 	cmd = FIELD_GET(QCA_HDR_MGMT_CMD, command);
@@ -189,7 +187,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 
 	/* Make sure the seq match the requested packet. If not, drop. */
 	if (get_unaligned_le32(&mgmt_ethhdr->seq) !=
-	    dsa_inband_seqno(&mgmt_eth_data->inband))
+	    dsa_inband_seqno(&priv->inband))
 		return;
 
 	if (cmd == MDIO_READ) {
@@ -215,7 +213,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 		}
 	}
 
-	dsa_inband_complete(&mgmt_eth_data->inband, &data, sizeof(data), err);
+	dsa_inband_complete(&priv->inband, data, sizeof(data), err);
 }
 
 static struct sk_buff *qca8k_alloc_mdio_header(enum mdio_cmd cmd, u32 reg, u32 *val,
@@ -314,7 +312,6 @@ static void qca8k_mdio_header_fill_seq_num(struct sk_buff *skb, u32 seq_num)
 
 static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
-	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
 	u32 data[4];
 	int ret;
@@ -326,7 +323,7 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = READ_ONCE(priv->mgmt_conduit);
 
-	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+	ret = dsa_inband_request(&priv->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 data, sizeof(data),
 				 QCA8K_ETHERNET_TIMEOUT);
@@ -343,7 +340,6 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
-	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
 
 	skb = qca8k_alloc_mdio_header(MDIO_WRITE, reg, val,
@@ -353,7 +349,7 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = READ_ONCE(priv->mgmt_conduit);
 
-	return dsa_inband_request(&mgmt_eth_data->inband, skb,
+	return dsa_inband_request(&priv->inband, skb,
 				  qca8k_mdio_header_fill_seq_num,
 				  NULL, 0,
 				  QCA8K_ETHERNET_TIMEOUT);
@@ -534,7 +530,7 @@ static const struct regmap_config qca8k_regmap_config = {
 };
 
 static int
-qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
+qca8k_phy_eth_busy_wait(struct dsa_inband *inband,
 			struct sk_buff *read_skb, u32 *val)
 {
 	struct sk_buff *skb = skb_copy(read_skb, GFP_KERNEL);
@@ -544,8 +540,7 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 	if (!skb)
 		return -ENOMEM;
 
-	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
-				 qca8k_mdio_header_fill_seq_num,
+	ret = dsa_inband_request(inband, skb, qca8k_mdio_header_fill_seq_num,
 				 data, sizeof(data),
 				 QCA8K_ETHERNET_TIMEOUT);
 
@@ -562,7 +557,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		      int regnum, u16 data)
 {
 	struct sk_buff *write_skb, *clear_skb, *read_skb;
-	struct qca8k_mgmt_eth_data *mgmt_eth_data;
 	u32 write_val, clear_val = 0, val;
 	struct net_device *mgmt_conduit;
 	u32 resp_data[4];
@@ -571,8 +565,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
 
-	mgmt_eth_data = &priv->mgmt_eth_data;
-
 	write_val = QCA8K_MDIO_MASTER_BUSY | QCA8K_MDIO_MASTER_EN |
 		    QCA8K_MDIO_MASTER_PHY_ADDR(phy) |
 		    QCA8K_MDIO_MASTER_REG_ADDR(regnum);
@@ -624,7 +616,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	clear_skb->dev = mgmt_conduit;
 	write_skb->dev = mgmt_conduit;
 
-	ret = dsa_inband_request(&mgmt_eth_data->inband, write_skb,
+	ret = dsa_inband_request(&priv->inband, write_skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 NULL, 0,
 				 QCA8K_ETHERNET_TIMEOUT);
@@ -637,7 +629,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	ret = read_poll_timeout(qca8k_phy_eth_busy_wait, ret1,
 				!(val & QCA8K_MDIO_MASTER_BUSY), 0,
 				QCA8K_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC, false,
-				mgmt_eth_data, read_skb, &val);
+				&priv->inband, read_skb, &val);
 
 	if (ret < 0 && ret1 < 0) {
 		ret = ret1;
@@ -645,7 +637,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	}
 
 	if (read) {
-		ret = dsa_inband_request(&mgmt_eth_data->inband, read_skb,
+		ret = dsa_inband_request(&priv->inband, read_skb,
 					 qca8k_mdio_header_fill_seq_num,
 					 resp_data, sizeof(resp_data),
 					 QCA8K_ETHERNET_TIMEOUT);
@@ -660,7 +652,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 exit:
 
 	/* This is expected to fail sometimes, so don't check return value. */
-	dsa_inband_request(&mgmt_eth_data->inband, clear_skb,
+	dsa_inband_request(&priv->inband, clear_skb,
 			   qca8k_mdio_header_fill_seq_num,
 			   NULL, 0,
 			   QCA8K_ETHERNET_TIMEOUT);
@@ -1991,7 +1983,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	if (!priv->ds)
 		return -ENOMEM;
 
-	dsa_inband_init(&priv->mgmt_eth_data.inband, U32_MAX);
+	dsa_inband_init(&priv->inband, U32_MAX);
 
 	mutex_init(&priv->mib_eth_data.mutex);
 	init_completion(&priv->mib_eth_data.rw_done);
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index ccf92c85ccb14..48bd5531d13e2 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -391,10 +391,6 @@ enum {
 	QCA8K_CPU_PORT6,
 };
 
-struct qca8k_mgmt_eth_data {
-	struct dsa_inband inband;
-};
-
 struct qca8k_mib_eth_data {
 	struct completion rw_done;
 	struct mutex mutex; /* Process one command at time */
@@ -458,7 +454,7 @@ struct qca8k_priv {
 	struct device *dev;
 	struct gpio_desc *reset_gpio;
 	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
-	struct qca8k_mgmt_eth_data mgmt_eth_data;
+	struct dsa_inband inband;
 	struct qca8k_mib_eth_data mib_eth_data;
 	struct qca8k_mdio_cache mdio_cache;
 	struct qca8k_pcs pcs_port_0;

-- 
2.43.0


