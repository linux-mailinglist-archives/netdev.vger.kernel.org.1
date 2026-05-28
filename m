Return-Path: <netdev+bounces-292720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJgtBI9RGGqwiwgAu9opvQ
	(envelope-from <netdev+bounces-292720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FFE5F3B1F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C09F304116D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACC3F6C5E;
	Thu, 28 May 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="QEwPcJMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19C3E8335
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978582; cv=none; b=TE+ws0rsBh5IQymhJGXhCzeO2wX6uSHuOjJeg9XC3hyUfJ6/lR8ZdIkBfKXb+hOM0eJ0F4Ak0VzxaMJ7Bnm574CQlBCuxHFaPns1DQ06cdu5CNJAv8wBOGVFLXe0nz5zQ+fs/ggVuh44xZFmXQPUGRvYRGcn5ce2tCCTusEWH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978582; c=relaxed/simple;
	bh=A9N4L0q2fHgE2hf2c8fEwfFdYYuI1UHFdV6EqNn5zho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/umB5Pa8ahreRN6lJuKI/30WWrhnv9pjK9qJtlkjtsIjzI52HP9yiXET+HmVbuXWjyLcAGgjQYFcRgLg6BEqC35uPTLeGDwyoSwONea4NNUb5WqGH8i7SUs4nwWQ4kstgcq/Lxd1gkZ7PhLSjIB9OX94sJLJuF9HwsAskH68n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=QEwPcJMG; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6u6T781s7XK1jBUvRM4QJsBwZyvoXt3jBDZflyahKU=;
	b=QEwPcJMGaKR20EKZ2eHhTIJvml6JJxITWhGMubEmct0Qmu0npIgCM0aw8+Qtyzj6aNnpI8
	bbf1vq8/uyLOgRNgEk9mvpyYDVv9dQ0E9EFP5mZ1lVJaBEC1ABIe/0pN9/y/NtRmssiZ1L
	wgsmnRf/ITbEWAAAcKErf3HMDBfyouyrY85vM3b80u0ty9ADhHkYgESWu9w/M2G3d5hPF6
	1I+WPEv8vs0g3cQOtVJcN7S6eqv9MJA2BGhewaRRkhveQe/nC9YObMHkj45II6d0VaRufN
	LkLutVRtJhyp5ISK4gIRPgfrww6j4S4lsSHz4XPdyUZ9AV7ctmnzJDVOMlneFw==
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
Subject: [PATCH net-next 14/15] batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
Date: Thu, 28 May 2026 16:29:23 +0200
Message-ID: <20260528142924.329658-15-sw@simonwunderlich.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292720-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8FFE5F3B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Both OGMv1 (on the primary interface) and OGM2 unconditionally reallocated
their packet buffer on every transmission cycle, regardless of whether the
required size had changed. This meant a kfree/kmalloc pair even when the
TVLV payload size was identical to the previous send.

Introduce struct batadv_ogm_buf to encapsulate the OGM packet buffer
together with its current length, allocated capacity, and fixed header
length. This consolidates the separate buf/len arguments that were
previously threaded through each call site.

In batadv_tvlv_realloc_packet_buff(), the capacity is rounded up to the
next power of two so that small growth or shrinkage in TVLV data does not
trigger a reallocation. When kmalloc fails but the existing buffer is large
enough to hold the new data, the oversized buffer is reused rather than
returning an error.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 35 ++++++++++++-----------
 net/batman-adv/bat_v_ogm.c  | 30 ++++++++++----------
 net/batman-adv/tvlv.c       | 56 ++++++++++++++++++++++---------------
 net/batman-adv/tvlv.h       |  3 +-
 net/batman-adv/types.h      | 31 +++++++++++++-------
 5 files changed, 88 insertions(+), 67 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index c436b77674a56..6f5a468c4084c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -195,14 +195,17 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
 	atomic_set(&hard_iface->bat_iv.ogm_seqno, random_seqno);
 
-	hard_iface->bat_iv.ogm_buff_len = BATADV_OGM_HLEN;
-	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff_len, GFP_ATOMIC);
+	hard_iface->bat_iv.ogm_buff.len = BATADV_OGM_HLEN;
+	hard_iface->bat_iv.ogm_buff.capacity = BATADV_OGM_HLEN;
+	hard_iface->bat_iv.ogm_buff.header_length = BATADV_OGM_HLEN;
+
+	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff.capacity, GFP_ATOMIC);
 	if (!ogm_buff) {
 		mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 		return -ENOMEM;
 	}
 
-	hard_iface->bat_iv.ogm_buff = ogm_buff;
+	hard_iface->bat_iv.ogm_buff.buf = ogm_buff;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)ogm_buff;
 	batadv_ogm_packet->packet_type = BATADV_IV_OGM;
@@ -221,8 +224,9 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	kfree(hard_iface->bat_iv.ogm_buff);
-	hard_iface->bat_iv.ogm_buff = NULL;
+	kfree(hard_iface->bat_iv.ogm_buff.buf);
+	memset(&hard_iface->bat_iv.ogm_buff, 0,
+	       sizeof(hard_iface->bat_iv.ogm_buff));
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 
@@ -236,7 +240,7 @@ static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
 
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	ogm_buff = hard_iface->bat_iv.ogm_buff;
+	ogm_buff = hard_iface->bat_iv.ogm_buff.buf;
 	if (!ogm_buff)
 		goto unlock;
 
@@ -258,7 +262,7 @@ batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	ogm_buff = hard_iface->bat_iv.ogm_buff;
+	ogm_buff = hard_iface->bat_iv.ogm_buff.buf;
 	if (!ogm_buff)
 		goto unlock;
 
@@ -796,10 +800,9 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-	unsigned char **ogm_buff = &hard_iface->bat_iv.ogm_buff;
+	struct batadv_ogm_buf *ogm_buff = &hard_iface->bat_iv.ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *primary_if, *tmp_hard_iface;
-	int *ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
 	struct list_head *iter;
 	u32 seqno;
 	u16 tvlv_len = 0;
@@ -811,7 +814,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
 	/* interface already disabled by batadv_iv_ogm_iface_disable */
-	if (!*ogm_buff)
+	if (!ogm_buff->buf)
 		return;
 
 	/* the interface gets activated here to avoid race conditions between
@@ -830,9 +833,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * appended as it may alter the tt tvlv container
 		 */
 		batadv_tt_local_commit_changes(bat_priv);
-		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-						       ogm_buff_len,
-						       BATADV_OGM_HLEN);
+		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff);
 		if (ret < 0) {
 			reschedule = true;
 			goto out;
@@ -841,7 +842,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		tvlv_len = ret;
 	}
 
-	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
+	batadv_ogm_packet = ogm_buff->buf;
 	batadv_ogm_packet->tvlv_len = htons(tvlv_len);
 
 	/* change sequence number to network order */
@@ -857,7 +858,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		/* OGMs from secondary interfaces are only scheduled on their
 		 * respective interfaces.
 		 */
-		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff->len,
 						    hard_iface, hard_iface, 1, send_time);
 		if (!scheduled)
 			reschedule = true;
@@ -873,8 +874,8 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
 			continue;
 
-		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
-						    *ogm_buff_len, hard_iface,
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf,
+						    ogm_buff->len, hard_iface,
 						    tmp_hard_iface, 1, send_time);
 		batadv_hardif_put(tmp_hard_iface);
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index b337bd8e58e7d..2c4dca639709c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -270,10 +270,9 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
+	struct batadv_ogm_buf *ogm_buff;
 	struct sk_buff *skb, *skb_tmp;
-	unsigned char **ogm_buff;
 	struct list_head *iter;
-	int *ogm_buff_len;
 	u16 tvlv_len;
 	int ret;
 
@@ -283,26 +282,23 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 		goto out;
 
 	ogm_buff = &bat_priv->bat_v.ogm_buff;
-	ogm_buff_len = &bat_priv->bat_v.ogm_buff_len;
 
 	/* tt changes have to be committed before the tvlv data is
 	 * appended as it may alter the tt tvlv container
 	 */
 	batadv_tt_local_commit_changes(bat_priv);
-	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-					       ogm_buff_len,
-					       BATADV_OGM2_HLEN);
+	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff);
 	if (ret < 0)
 		goto reschedule;
 
 	tvlv_len = ret;
 
-	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + *ogm_buff_len);
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff->len);
 	if (!skb)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	skb_put_data(skb, *ogm_buff, *ogm_buff_len);
+	skb_put_data(skb, ogm_buff->buf, ogm_buff->len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
@@ -448,10 +444,10 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 	struct batadv_ogm2_packet *ogm_packet;
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
-	if (!bat_priv->bat_v.ogm_buff)
+	if (!bat_priv->bat_v.ogm_buff.buf)
 		goto unlock;
 
-	ogm_packet = (struct batadv_ogm2_packet *)bat_priv->bat_v.ogm_buff;
+	ogm_packet = bat_priv->bat_v.ogm_buff.buf;
 	ether_addr_copy(ogm_packet->orig, primary_iface->net_dev->dev_addr);
 
 unlock:
@@ -1052,12 +1048,15 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 	unsigned char *ogm_buff;
 	u32 random_seqno;
 
-	bat_priv->bat_v.ogm_buff_len = BATADV_OGM2_HLEN;
-	ogm_buff = kzalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
+	bat_priv->bat_v.ogm_buff.len = BATADV_OGM2_HLEN;
+	bat_priv->bat_v.ogm_buff.capacity = BATADV_OGM2_HLEN;
+	bat_priv->bat_v.ogm_buff.header_length = BATADV_OGM2_HLEN;
+
+	ogm_buff = kzalloc(bat_priv->bat_v.ogm_buff.capacity, GFP_ATOMIC);
 	if (!ogm_buff)
 		return -ENOMEM;
 
-	bat_priv->bat_v.ogm_buff = ogm_buff;
+	bat_priv->bat_v.ogm_buff.buf = ogm_buff;
 	ogm_packet = (struct batadv_ogm2_packet *)ogm_buff;
 	ogm_packet->packet_type = BATADV_OGM2;
 	ogm_packet->version = BATADV_COMPAT_VERSION;
@@ -1085,9 +1084,8 @@ void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
 
-	kfree(bat_priv->bat_v.ogm_buff);
-	bat_priv->bat_v.ogm_buff = NULL;
-	bat_priv->bat_v.ogm_buff_len = 0;
+	kfree(bat_priv->bat_v.ogm_buff.buf);
+	memset(&bat_priv->bat_v.ogm_buff, 0, sizeof(bat_priv->bat_v.ogm_buff));
 
 	mutex_unlock(&bat_priv->bat_v.ogm_buff_mutex);
 }
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8e8b54e2172ef..cd75daea478c5 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -17,6 +17,7 @@
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/log2.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_sched.h>
 #include <linux/rculist.h>
@@ -267,32 +268,48 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_realloc_packet_buff() - reallocate packet buffer to accommodate
  *  requested packet size
- * @packet_buff: packet buffer
- * @packet_buff_len: packet buffer size
- * @min_packet_len: requested packet minimum size
+ * @ogm_buff: ogm packet buffer
  * @additional_packet_len: requested additional packet size on top of minimum
  *  size
  *
  * Return: true of the packet buffer could be changed to the requested size,
  * false otherwise.
  */
-static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
-					    int *packet_buff_len,
-					    int min_packet_len,
-					    int additional_packet_len)
+static bool batadv_tvlv_realloc_packet_buff(struct batadv_ogm_buf *ogm_buff,
+					    size_t additional_packet_len)
 {
 	unsigned char *new_buff;
+	size_t newcapacity;
+	size_t newlen;
 
-	new_buff = kmalloc(min_packet_len + additional_packet_len, GFP_ATOMIC);
+	newlen = ogm_buff->header_length + additional_packet_len;
+	newcapacity = roundup_pow_of_two(newlen);
+
+	/* nothing to reallocate */
+	if (newcapacity == ogm_buff->capacity) {
+		ogm_buff->len = newlen;
+		return true;
+	}
+
+	new_buff = kmalloc(newcapacity, GFP_ATOMIC);
 
 	/* keep old buffer if kmalloc should fail */
-	if (!new_buff)
+	if (!new_buff) {
+		/* continue to use oversize buffer if new data fits */
+		if (newlen <= ogm_buff->capacity) {
+			ogm_buff->len = newlen;
+			return true;
+		}
+
 		return false;
+	}
+
+	memcpy(new_buff, ogm_buff->buf, ogm_buff->header_length);
+	kfree(ogm_buff->buf);
 
-	memcpy(new_buff, *packet_buff, min_packet_len);
-	kfree(*packet_buff);
-	*packet_buff = new_buff;
-	*packet_buff_len = min_packet_len + additional_packet_len;
+	ogm_buff->buf = new_buff;
+	ogm_buff->len = newlen;
+	ogm_buff->capacity = newcapacity;
 
 	return true;
 }
@@ -301,10 +318,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  * batadv_tvlv_container_ogm_append() - append tvlv container content to given
  *  OGM packet buffer
  * @bat_priv: the bat priv with all the mesh interface information
- * @packet_buff: ogm packet buffer
- * @packet_buff_len: ogm packet buffer size including ogm header and tvlv
- *  content
- * @packet_min_len: ogm header size to be preserved for the OGM itself
+ * @ogm_buff: ogm packet buffer
  *
  * The ogm packet might be enlarged or shrunk depending on the current size
  * and the size of the to-be-appended tvlv containers.
@@ -313,8 +327,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  *  if operation failed
  */
 int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
-				     unsigned char **packet_buff,
-				     int *packet_buff_len, int packet_min_len)
+				     struct batadv_ogm_buf *ogm_buff)
 {
 	struct batadv_tvlv_container *tvlv;
 	struct batadv_tvlv_hdr *tvlv_hdr;
@@ -330,8 +343,7 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 		goto end;
 	}
 
-	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
-					      packet_min_len, tvlv_value_len);
+	ret = batadv_tvlv_realloc_packet_buff(ogm_buff, tvlv_value_len);
 	if (!ret) {
 		tvlv_len_ret = -ENOMEM;
 		goto end;
@@ -342,7 +354,7 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 	if (!tvlv_value_len)
 		goto end;
 
-	tvlv_value = (*packet_buff) + packet_min_len;
+	tvlv_value = (u8 *)ogm_buff->buf + ogm_buff->header_length;
 
 	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
 		tvlv_hdr = tvlv_value;
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index f96f6b3f44a00..fc97838504431 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -17,8 +17,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
 				    void *tvlv_value, u16 tvlv_value_len);
 int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
-				     unsigned char **packet_buff,
-				     int *packet_buff_len, int packet_min_len);
+				     struct batadv_ogm_buf *ogm_buff);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
 			     struct batadv_ogm_packet *batadv_ogm_packet,
 			     struct batadv_orig_node *orig_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5d4ad35c19636..c3b6af399110b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -71,15 +71,29 @@ enum batadv_dhcp_recipient {
  */
 #define BATADV_TT_SYNC_MASK	0x00F0
 
+/**
+ * struct batadv_ogm_buf - Buffer to construct an OGM with TVLV
+ */
+struct batadv_ogm_buf {
+	/** @buf: buffer holding the OGM packet */
+	void *buf;
+
+	/** @len: length of the OGM packet buffer data */
+	size_t len;
+
+	/** @capacity: size of allocated buf */
+	size_t capacity;
+
+	/** @header_length: fixed size header length (must be <= len) */
+	size_t header_length;
+};
+
 /**
  * struct batadv_hard_iface_bat_iv - per hard-interface B.A.T.M.A.N. IV data
  */
 struct batadv_hard_iface_bat_iv {
 	/** @ogm_buff: buffer holding the OGM packet */
-	unsigned char *ogm_buff;
-
-	/** @ogm_buff_len: length of the OGM packet buffer */
-	int ogm_buff_len;
+	struct batadv_ogm_buf ogm_buff;
 
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
@@ -87,7 +101,7 @@ struct batadv_hard_iface_bat_iv {
 	/** @reschedule_work: recover OGM schedule after schedule error */
 	struct delayed_work reschedule_work;
 
-	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
+	/** @ogm_buff_mutex: lock protecting ogm_buff */
 	struct mutex ogm_buff_mutex;
 };
 
@@ -1481,15 +1495,12 @@ struct batadv_meshif_vlan {
  */
 struct batadv_priv_bat_v {
 	/** @ogm_buff: buffer holding the OGM packet */
-	unsigned char *ogm_buff;
-
-	/** @ogm_buff_len: length of the OGM packet buffer */
-	int ogm_buff_len;
+	struct batadv_ogm_buf ogm_buff;
 
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 
-	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
+	/** @ogm_buff_mutex: lock protecting ogm_buff */
 	struct mutex ogm_buff_mutex;
 
 	/** @ogm_wq: workqueue used to schedule OGM transmissions */
-- 
2.47.3


