Return-Path: <netdev+bounces-304047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7chJMT0uRmrpLAsAu9opvQ
	(envelope-from <netdev+bounces-304047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE76F5339
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:24:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=yreQmrnT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304047-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304047-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DEBC30E6750
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02B47D948;
	Thu,  2 Jul 2026 09:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8147CC79
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983266; cv=none; b=QN1tjROnAKmbyi4/P+q4o0BPN1I0rr3QS5tBX5Um9fZSTMC43XYmnRhcu2XaIRtugLfZM9bBblL14BTd4pm/PNd4zBBE4BZHtjsc2GPCKAaW5cKRvyPK55HsEGKC9q8/ZyystFRHNoJ2SliKe5A3mPjSoinXPYWc5EAucDoqOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983266; c=relaxed/simple;
	bh=dBBpP5Lz2+JojJwrPXBdGaqok5/Q3DWB1g9yh7ZGF78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unrlGcz37VNabllYzZczMCmvW6eerqdUz2LLrINUnQhUXvxZ3/n4YbUna1u+hrP3FdXLFUhtkRf3o0LpTnGZdLErdGEfQGDnzE1ZBM5h6W/6znBCSRAF9hHpI2UnzDLrp0Ugyzo+18tUSt/PY7O0TK07oWOB4Cx2VOtE4eXbqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yreQmrnT; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC1BCC4FED4;
	Thu,  2 Jul 2026 09:07:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91BA75FF03;
	Thu,  2 Jul 2026 09:07:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAD45104C9625;
	Thu,  2 Jul 2026 11:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983262; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XUa+jHULbae5bprqUew3ZFTGiptayYO4M1GUz3gSLkw=;
	b=yreQmrnTpTWDihKfi87RZDHQy1m1Pvw8SIN9P8EIkxwLsnfgYV5fJs9ogSwQO4hNwIE8q4
	6RYpyohxaywRGYiX4Cif5I4e7tYNgzcIDcZ0D3pAQdBzvO+Xc/DUo2cQug5f7SnQchYj4h
	hLw1fojT4O2rd3Onir5+2EaHRqMmg9L6MNcM1hrFCVXTbnTpaS/Zfia52TtTRpJaO0L2yD
	Qlyzo67fPmev5vZ1RZcejS0OGniZQcdNUQEIDHDoH6qpqJgyAwtjOq6/DvnwERBy/IwWuW
	uX+x/G60mRNuKqJwEe9G3y2DSEKkXgZXFiULJlrdxEZQy6Olu2Y3sQE7QfyB8Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:26 +0200
Subject: [PATCH net-next 04/10] net: dsa: microchip: move ksz88xx stats
 handling in ksz8.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-4-93441e695fa4@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-304047-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3ADE76F5339

ksz88xx_r_mib_stats64() is defined in ksz_common while it's clearly
ksz88xx-specific.

Move its definition in ksz8.c

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 86 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.c | 86 ----------------------------------
 drivers/net/dsa/microchip/ksz_common.h |  1 -
 3 files changed, 86 insertions(+), 87 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 2b4720c4c87e..ad7c7a6e1d31 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -36,6 +36,43 @@
 #include "ksz8_reg.h"
 #include "ksz8.h"
 
+struct ksz88xx_stats_raw {
+	u64 rx;
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
+	u64 tx;
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
+	u64 rx_discards;
+	u64 tx_discards;
+};
+
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
 	ksz_rmw8(dev, addr, bits, set ? bits : 0);
@@ -2052,6 +2089,55 @@ static int ksz8_enable_stp_addr(struct ksz_device *dev)
 	return ksz8_w_sta_mac_table(dev, 0, &alu);
 }
 
+static void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
+{
+	struct ethtool_pause_stats *pstats;
+	struct rtnl_link_stats64 *stats;
+	struct ksz88xx_stats_raw *raw;
+	struct ksz_port_mib *mib;
+
+	mib = &dev->ports[port].mib;
+	stats = &mib->stats64;
+	pstats = &mib->pause_stats;
+	raw = (struct ksz88xx_stats_raw *)mib->counters;
+
+	spin_lock(&mib->stats64_lock);
+
+	stats->rx_packets = raw->rx_bcast + raw->rx_mcast + raw->rx_ucast +
+		raw->rx_pause;
+	stats->tx_packets = raw->tx_bcast + raw->tx_mcast + raw->tx_ucast +
+		raw->tx_pause;
+
+	/* HW counters are counting bytes + FCS which is not acceptable
+	 * for rtnl_link_stats64 interface
+	 */
+	stats->rx_bytes = raw->rx + raw->rx_hi - stats->rx_packets * ETH_FCS_LEN;
+	stats->tx_bytes = raw->tx + raw->tx_hi - stats->tx_packets * ETH_FCS_LEN;
+
+	stats->rx_length_errors = raw->rx_undersize + raw->rx_fragments +
+		raw->rx_oversize;
+
+	stats->rx_crc_errors = raw->rx_crc_err;
+	stats->rx_frame_errors = raw->rx_align_err;
+	stats->rx_dropped = raw->rx_discards;
+	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
+		stats->rx_frame_errors  + stats->rx_dropped;
+
+	stats->tx_window_errors = raw->tx_late_col;
+	stats->tx_fifo_errors = raw->tx_discards;
+	stats->tx_aborted_errors = raw->tx_exc_col;
+	stats->tx_errors = stats->tx_window_errors + stats->tx_fifo_errors +
+		stats->tx_aborted_errors;
+
+	stats->multicast = raw->rx_mcast;
+	stats->collisions = raw->tx_total_col;
+
+	pstats->tx_pause_frames = raw->tx_pause;
+	pstats->rx_pause_frames = raw->rx_pause;
+
+	spin_unlock(&mib->stats64_lock);
+}
+
 static int ksz8_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index be7738ae1f2a..56dd4c27b182 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -76,43 +76,6 @@ struct ksz_stats_raw {
 	u64 tx_discards;
 };
 
-struct ksz88xx_stats_raw {
-	u64 rx;
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
-	u64 tx;
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
-	u64 rx_discards;
-	u64 tx_discards;
-};
-
 static const struct ksz_mib_names ksz88xx_mib_names[] = {
 	{ 0x00, "rx" },
 	{ 0x01, "rx_hi" },
@@ -2063,55 +2026,6 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 	}
 }
 
-void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
-{
-	struct ethtool_pause_stats *pstats;
-	struct rtnl_link_stats64 *stats;
-	struct ksz88xx_stats_raw *raw;
-	struct ksz_port_mib *mib;
-
-	mib = &dev->ports[port].mib;
-	stats = &mib->stats64;
-	pstats = &mib->pause_stats;
-	raw = (struct ksz88xx_stats_raw *)mib->counters;
-
-	spin_lock(&mib->stats64_lock);
-
-	stats->rx_packets = raw->rx_bcast + raw->rx_mcast + raw->rx_ucast +
-		raw->rx_pause;
-	stats->tx_packets = raw->tx_bcast + raw->tx_mcast + raw->tx_ucast +
-		raw->tx_pause;
-
-	/* HW counters are counting bytes + FCS which is not acceptable
-	 * for rtnl_link_stats64 interface
-	 */
-	stats->rx_bytes = raw->rx + raw->rx_hi - stats->rx_packets * ETH_FCS_LEN;
-	stats->tx_bytes = raw->tx + raw->tx_hi - stats->tx_packets * ETH_FCS_LEN;
-
-	stats->rx_length_errors = raw->rx_undersize + raw->rx_fragments +
-		raw->rx_oversize;
-
-	stats->rx_crc_errors = raw->rx_crc_err;
-	stats->rx_frame_errors = raw->rx_align_err;
-	stats->rx_dropped = raw->rx_discards;
-	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
-		stats->rx_frame_errors  + stats->rx_dropped;
-
-	stats->tx_window_errors = raw->tx_late_col;
-	stats->tx_fifo_errors = raw->tx_discards;
-	stats->tx_aborted_errors = raw->tx_exc_col;
-	stats->tx_errors = stats->tx_window_errors + stats->tx_fifo_errors +
-		stats->tx_aborted_errors;
-
-	stats->multicast = raw->rx_mcast;
-	stats->collisions = raw->tx_total_col;
-
-	pstats->tx_pause_frames = raw->tx_pause;
-	pstats->rx_pause_frames = raw->rx_pause;
-
-	spin_unlock(&mib->stats64_lock);
-}
-
 void ksz_get_stats64(struct dsa_switch *ds, int port,
 		     struct rtnl_link_stats64 *s)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f367d6f96fa2..347787ef1f00 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -394,7 +394,6 @@ void ksz_teardown(struct dsa_switch *ds);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
 void ksz_r_mib_stats64(struct ksz_device *dev, int port);
-void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port);
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
 bool ksz_get_gbit(struct ksz_device *dev, int port);
 phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit);

-- 
2.54.0


