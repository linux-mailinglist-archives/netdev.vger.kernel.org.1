Return-Path: <netdev+bounces-304049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dEDLGTUtRmqNLAsAu9opvQ
	(envelope-from <netdev+bounces-304049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD66F5295
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=m0bqUaPo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304049-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15CA3317E36C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E647DD70;
	Thu,  2 Jul 2026 09:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361147D945;
	Thu,  2 Jul 2026 09:07:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983269; cv=none; b=sNYgL4PXyuRo0IJFEH39qzdRnqE90PuZ19q/QSMxvVdE+Xl59kpdz0JYHu/ZzVEU8IqmNVy+nue/A10Czqe7JpvrQGkDM6VRreJzsR0DQ5nO03+/E7kDd0NsCUHEWNF82lV9ywUiKI2vSVtv5orK6m5zulXdDAwCYZuRHiE/dCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983269; c=relaxed/simple;
	bh=BTaaYahjvLRWdK5nnnr7T2PUP6NLREyz4fnriNorK6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+MkFBdEifievuM6fVGhcES5LgRoiddJSUTT8cK0o6Pk+wIstlZgSpZxCsSxR2rR4gQ1CagJFsHa2cqdWo6CcSXQh7vQQGSpivxmJUuh36yXbAWPHh9i1l/sx+WLWwoRJzPQriHuawAArr0qy8L9MMhcV4Ta+KGKBSWC50qK9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m0bqUaPo; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54C91C4FED7;
	Thu,  2 Jul 2026 09:07:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C0ED5FF03;
	Thu,  2 Jul 2026 09:07:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C872104C9616;
	Thu,  2 Jul 2026 11:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KrKhTct7/7J4MdzORAtr/ar9PaS7gkwvZomz+z8SHww=;
	b=m0bqUaPo70StSXCK0J/ixHLUSoV1BT3n0vQxKSIKxQLlmUC3jvKrrjpix9hI7aI5Oq0sDu
	0GQLrTlWpYBevXEebtxAIhrIOhFBY7k5SE3lfNFRUm6aEYosiCvhW1WcHwFeUD0RAQW82b
	yBzvfWWqT0Y/pIVFbRRNeK9f/q81tow8DaQVSQZfHrvErhHlCvFSSNy8zVcwdHqiivtV8p
	PzsEehM09A4I/NwIgY937EC2lCeTTescu8050Pc73DucsnF1stSQFdLBw7wEbAH8KbitZb
	URYRvmPJe5A1CAOqsijDatVSD5AeH37uT1PT7nH+2fkDhdOvhzD1s8l0eLGmdg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:28 +0200
Subject: [PATCH net-next 06/10] net: dsa: microchip: move KSZ9477 errata
 handling to ksz9477.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-6-93441e695fa4@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-304049-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84BD66F5295

The KSZ9477 PHY errata is handled from the common ksz_r_mib_stat64().
This errata clearly belongs to the KSZ9477 family so it should be handled
from the ksz9477-specific portion of the driver.

Create a ksz9477-specific r_mib_stat64() implementation that handles
this errata.
Remove the errata handling from the common ksz_r_mib_stat64().

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c    | 24 +++++++++++++++---
 drivers/net/dsa/microchip/ksz9477.h    |  2 --
 drivers/net/dsa/microchip/ksz_common.c | 46 ----------------------------------
 drivers/net/dsa/microchip/ksz_common.h | 39 ++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index ad6748905e08..a831eb884ce4 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -483,8 +483,8 @@ static int ksz9477_half_duplex_monitor(struct ksz_device *dev, int port,
 	return ret;
 }
 
-int ksz9477_errata_monitor(struct ksz_device *dev, int port,
-			   u64 tx_late_col)
+static int ksz9477_errata_monitor(struct ksz_device *dev, int port,
+				  u64 tx_late_col)
 {
 	u8 status;
 	int ret;
@@ -502,6 +502,24 @@ int ksz9477_errata_monitor(struct ksz_device *dev, int port,
 	return ret;
 }
 
+static void ksz9477_r_mib_stats64(struct ksz_device *dev, int port)
+{
+	struct ksz_stats_raw *raw;
+	struct ksz_port_mib *mib;
+	int ret;
+
+	ksz_r_mib_stats64(dev, port);
+
+	if (dev->info->phy_errata_9477 && !ksz_is_sgmii_port(dev, port)) {
+		mib = &dev->ports[port].mib;
+		raw = (struct ksz_stats_raw *)mib->counters;
+
+		ret = ksz9477_errata_monitor(dev, port, raw->tx_late_col);
+		if (ret)
+			dev_err(dev->dev, "Failed to monitor transmission halt\n");
+	}
+};
+
 void ksz9477_port_init_cnt(struct ksz_device *dev, int port)
 {
 	struct ksz_port_mib *mib = &dev->ports[port].mib;
@@ -2109,7 +2127,7 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.cfg_port_member = ksz9477_cfg_port_member,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
 	.r_mib_pkt = ksz9477_r_mib_pkt,
-	.r_mib_stat64 = ksz_r_mib_stats64,
+	.r_mib_stat64 = ksz9477_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
 	.pme_write8 = ksz_write8,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 25b74d0af6c5..962174a922a0 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -32,8 +32,6 @@ int ksz9477_port_mirror_add(struct dsa_switch *ds, int port,
 			    bool ingress, struct netlink_ext_ack *extack);
 void ksz9477_port_mirror_del(struct dsa_switch *ds, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
-int ksz9477_errata_monitor(struct ksz_device *dev, int port,
-			   u64 tx_late_col);
 int ksz9477_fdb_dump(struct dsa_switch *ds, int port,
 		     dsa_fdb_dump_cb_t *cb, void *data);
 int ksz9477_fdb_add(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 92fcbd9605c7..b54aea92b67d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -37,45 +37,6 @@
 
 #define MIB_COUNTER_NUM 0x20
 
-struct ksz_stats_raw {
-	u64 rx_hi;
-	u64 rx_undersize;
-	u64 rx_fragments;
-	u64 rx_oversize;
-	u64 rx_jabbers;
-	u64 rx_symbol_err;
-	u64 rx_crc_err;
-	u64 rx_align_err;
-	u64 rx_mac_ctrl;
-	u64 rx_pause;
-	u64 rx_bcast;
-	u64 rx_mcast;
-	u64 rx_ucast;
-	u64 rx_64_or_less;
-	u64 rx_65_127;
-	u64 rx_128_255;
-	u64 rx_256_511;
-	u64 rx_512_1023;
-	u64 rx_1024_1522;
-	u64 rx_1523_2000;
-	u64 rx_2001;
-	u64 tx_hi;
-	u64 tx_late_col;
-	u64 tx_pause;
-	u64 tx_bcast;
-	u64 tx_mcast;
-	u64 tx_ucast;
-	u64 tx_deferred;
-	u64 tx_total_col;
-	u64 tx_exc_col;
-	u64 tx_single_col;
-	u64 tx_mult_col;
-	u64 rx_total;
-	u64 tx_total;
-	u64 rx_discards;
-	u64 tx_discards;
-};
-
 static const struct ksz_mib_names ksz88xx_mib_names[] = {
 	{ 0x00, "rx" },
 	{ 0x01, "rx_hi" },
@@ -1976,7 +1937,6 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 	struct rtnl_link_stats64 *stats;
 	struct ksz_stats_raw *raw;
 	struct ksz_port_mib *mib;
-	int ret;
 
 	mib = &dev->ports[port].mib;
 	stats = &mib->stats64;
@@ -2018,12 +1978,6 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 	pstats->rx_pause_frames = raw->rx_pause;
 
 	spin_unlock(&mib->stats64_lock);
-
-	if (dev->info->phy_errata_9477 && !ksz_is_sgmii_port(dev, port)) {
-		ret = ksz9477_errata_monitor(dev, port, raw->tx_late_col);
-		if (ret)
-			dev_err(dev->dev, "Failed to monitor transmission halt\n");
-	}
 }
 
 void ksz_get_stats64(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 2c7716d8cf28..245329b6e0e9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -40,6 +40,45 @@ struct vlan_table {
 	u32 table[3];
 };
 
+struct ksz_stats_raw {
+	u64 rx_hi;
+	u64 rx_undersize;
+	u64 rx_fragments;
+	u64 rx_oversize;
+	u64 rx_jabbers;
+	u64 rx_symbol_err;
+	u64 rx_crc_err;
+	u64 rx_align_err;
+	u64 rx_mac_ctrl;
+	u64 rx_pause;
+	u64 rx_bcast;
+	u64 rx_mcast;
+	u64 rx_ucast;
+	u64 rx_64_or_less;
+	u64 rx_65_127;
+	u64 rx_128_255;
+	u64 rx_256_511;
+	u64 rx_512_1023;
+	u64 rx_1024_1522;
+	u64 rx_1523_2000;
+	u64 rx_2001;
+	u64 tx_hi;
+	u64 tx_late_col;
+	u64 tx_pause;
+	u64 tx_bcast;
+	u64 tx_mcast;
+	u64 tx_ucast;
+	u64 tx_deferred;
+	u64 tx_total_col;
+	u64 tx_exc_col;
+	u64 tx_single_col;
+	u64 tx_mult_col;
+	u64 rx_total;
+	u64 tx_total;
+	u64 rx_discards;
+	u64 tx_discards;
+};
+
 struct ksz_port_mib {
 	struct mutex cnt_mutex;		/* structure access */
 	u8 cnt_ptr;

-- 
2.54.0


