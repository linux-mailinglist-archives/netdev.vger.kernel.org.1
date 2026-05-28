Return-Path: <netdev+bounces-292711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBIyOi5TGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B8D5F3CCD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 796E8314E1BD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C13E3DAB;
	Thu, 28 May 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="KiWNRo5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6483C4B93
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978579; cv=none; b=DIWRr3mgo8pzFKCrOTE1BANO7k8hmpnNpOktsRQrvRMV+Sd9ppI4ftIjGS4PYUGnIZntyRyuaUdu60tXV8j1hogKot4QfZFa7dGI+m/8QCr8ig/zoniAMPXlJhrdZxizRphtK34UfntphUnOqWFd/gh+0I7Z26kUOv8veMn7Vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978579; c=relaxed/simple;
	bh=dSVdMXViGVWlIhnzhEzhIBV8Obuph/VDi6yc9+0iq0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5fDkVCzE/X/iyDGP0TJ5GBUFzpMYq80kfw1N35XNdLzhsRVexZ9CTldIAa6S9Co59Hhu+hTQ728zMqP3GrvogbMYFYb9eAl3uzQh/tzYIKgDQVUibm97/oj14uZJ2jDvr45UMtpZpXemtbXme/fjNOKj7CwCTsv8/QCrmRaN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=KiWNRo5C; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qjZCBChOX+vODQ5VLN2Zm9FUbTzB34wiiRnj4TQlN4=;
	b=KiWNRo5C4WOKowsCYFrtn3Okc00LAu/ihb5kmMmNcV02n8/jjCndR2vvKmrSZzoMKEMc2g
	gs50mvCmJxp44iHHVh7jQZyZxDhriCF1+p5yJy/5/WXjpeqxFoAzsUjmj5uHZ6KvtjA0hA
	RY9NNO2sEM04/RPSkWRoeeqjPjdjPZ3ukuO95GA53BGMao+HA2BqXHXC0JqpkAb/FtcMKQ
	m2TIzbyHdiFsGNh7JVga8ULJQ9DntGO3p0MwKCq8WDjtnbxsH7htqI6O1TK5pkVMRqaocu
	YVAQoVpsL/JPNNTnXVd/Mwc/5wGpGChgRmR1QImefcmduuTK5kafM95N24LjIA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 08/15] batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
Date: Thu, 28 May 2026 16:29:17 +0200
Message-ID: <20260528142924.329658-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292711-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 71B8D5F3CCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The hardif configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c     |  2 +-
 net/batman-adv/bat_v.c          |  5 ++---
 net/batman-adv/bat_v_elp.c      |  7 ++++---
 net/batman-adv/bat_v_ogm.c      |  6 +++---
 net/batman-adv/hard-interface.c |  2 +-
 net/batman-adv/netlink.c        | 12 ++++++------
 net/batman-adv/types.h          |  6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 5628017bee511..df8e64588e1e7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1218,7 +1218,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	inv_asym_penalty = BATADV_TQ_MAX_VALUE * neigh_rq_inv_cube;
 	inv_asym_penalty /= neigh_rq_max_cube;
 	tq_asym_penalty = BATADV_TQ_MAX_VALUE - inv_asym_penalty;
-	tq_iface_hop_penalty -= atomic_read(&if_incoming->hop_penalty);
+	tq_iface_hop_penalty -= READ_ONCE(if_incoming->hop_penalty);
 
 	/* penalize if the OGM is forwarded on the same interface. WiFi
 	 * interfaces and other half duplex devices suffer from throughput
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 492058a87682b..ac2932da5472d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -7,7 +7,6 @@
 #include "bat_v.h"
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
@@ -813,8 +812,8 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 	/* enable link throughput auto-detection by setting the throughput
 	 * override to zero
 	 */
-	atomic_set(&hard_iface->bat_v.throughput_override, 0);
-	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+	WRITE_ONCE(hard_iface->bat_v.throughput_override, 0);
+	WRITE_ONCE(hard_iface->bat_v.elp_interval, 500);
 
 	hard_iface->bat_v.aggr_len = 0;
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e207093de79fe..0190fafcbed2d 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -62,7 +63,7 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 {
 	unsigned int msecs;
 
-	msecs = atomic_read(&hard_iface->bat_v.elp_interval) - BATADV_JITTER;
+	msecs = READ_ONCE(hard_iface->bat_v.elp_interval) - BATADV_JITTER;
 	msecs += get_random_u32_below(2 * BATADV_JITTER);
 
 	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_v.elp_wq,
@@ -98,7 +99,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
-	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
+	throughput =  READ_ONCE(hard_iface->bat_v.throughput_override);
 	if (throughput != 0) {
 		*pthroughput = throughput;
 		return true;
@@ -324,7 +325,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	elp_packet = (struct batadv_elp_packet *)skb->data;
 	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
-	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
+	elp_interval = READ_ONCE(hard_iface->bat_v.elp_interval);
 	elp_packet->elp_interval = htonl(elp_interval);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 28f28b61ad6bc..f4cd8cad97e0c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -486,9 +486,9 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *if_outgoing,
 				    u32 throughput)
 {
-	int if_hop_penalty = atomic_read(&if_incoming->hop_penalty);
-	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
-	int hop_penalty_max = BATADV_TQ_MAX_VALUE;
+	u32 if_hop_penalty = READ_ONCE(if_incoming->hop_penalty);
+	u32 hop_penalty = READ_ONCE(bat_priv->hop_penalty);
+	u32 hop_penalty_max = BATADV_TQ_MAX_VALUE;
 
 	/* Apply per hardif hop penalty */
 	throughput = throughput * (hop_penalty_max - if_hop_penalty) /
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f8a2ac1c235e5..85a1f1154bb42 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -910,7 +910,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (batadv_is_wifi_hardif(hard_iface))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
-	atomic_set(&hard_iface->hop_penalty, 0);
+	WRITE_ONCE(hard_iface->hop_penalty, 0);
 
 	batadv_v_hardif_init(hard_iface);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 92adaa40c8b60..15f7166afd5a6 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -811,16 +811,16 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
 	}
 
 	if (nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY,
-		       atomic_read(&hard_iface->hop_penalty)))
+		       READ_ONCE(hard_iface->hop_penalty)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	if (nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL,
-			atomic_read(&hard_iface->bat_v.elp_interval)))
+			READ_ONCE(hard_iface->bat_v.elp_interval)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_THROUGHPUT_OVERRIDE,
-			atomic_read(&hard_iface->bat_v.throughput_override)))
+			READ_ONCE(hard_iface->bat_v.throughput_override)))
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 
@@ -913,7 +913,7 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
 		attr = info->attrs[BATADV_ATTR_HOP_PENALTY];
 
-		atomic_set(&hard_iface->hop_penalty, nla_get_u8(attr));
+		WRITE_ONCE(hard_iface->hop_penalty, nla_get_u8(attr));
 	}
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
@@ -921,13 +921,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
 
-		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
+		WRITE_ONCE(hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
 
 	if (info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {
 		attr = info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE];
 
-		atomic_set(&hard_iface->bat_v.throughput_override,
+		WRITE_ONCE(hard_iface->bat_v.throughput_override,
 			   nla_get_u32(attr));
 	}
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c4845b5e43be0..dd63cd28914d7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -114,7 +114,7 @@ enum batadv_v_hard_iface_flags {
  */
 struct batadv_hard_iface_bat_v {
 	/** @elp_interval: time interval between two ELP transmissions */
-	atomic_t elp_interval;
+	u32 elp_interval;
 
 	/** @elp_seqno: current ELP sequence number */
 	atomic_t elp_seqno;
@@ -138,7 +138,7 @@ struct batadv_hard_iface_bat_v {
 	 * @throughput_override: throughput override to disable link
 	 *  auto-detection
 	 */
-	atomic_t throughput_override;
+	u32 throughput_override;
 
 	/** @flags: interface specific flags */
 	u8 flags;
@@ -236,7 +236,7 @@ struct batadv_hard_iface {
 	 * @hop_penalty: penalty which will be applied to the tq-field
 	 * of an OGM received via this interface
 	 */
-	atomic_t hop_penalty;
+	u8 hop_penalty;
 
 	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;
-- 
2.47.3


