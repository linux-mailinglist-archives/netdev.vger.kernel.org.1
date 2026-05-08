Return-Path: <netdev+bounces-285917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJH8KFAG/mnumAAAu9opvQ
	(envelope-from <netdev+bounces-285917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:50:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC84F9009
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724A93034299
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73D30DEB2;
	Fri,  8 May 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="P0bDI6iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963F2FFDE1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255430; cv=none; b=McO92Qjhf+uAfHaUuWLAFwokNPpDnb4Vmm+hlHfKf8CmUwIDQRZz9F6whwjpW0LJGLFIaRL+XP0yVPcDseHE0gLEbnabCTHNjevXMP8ZOsf5cvTJzfiFDQ8omuthEw5oUlgaEBiZWv/klTeaSPMImk+BngtKDeKb9ZjFFEk0V5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255430; c=relaxed/simple;
	bh=GLhewK46ZCKD90IM94D/GsMNNNNNrbGFDzu0H2sHFFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui68svaXUR7jzjgPcWSXgVlms2CgjJcmRnX9pB4qlkiyaZqEGjV7Pi566GikVJYX/3hYdh3CnBflFm/kjnJpLzcj60mqWSu01zMpVewt8IiissxCiyIb6NqReKJxu1a2TvZFL5U6wBzskzHVkk5j/iB20RvGP9Nxmx2WQUVZjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=P0bDI6iy; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qumZwv+YdCQ9mlrjGAn5d4tKgy6sV2HcVnuFVQyPm6E=;
	b=P0bDI6iyKu0SPPZ5tA9zTfRnHCxULiJYzzAaY2QcvkVeXUe7lqW+kbZ2Xdkx8Ld5sMx/CU
	RYie5Eau2dZSSzQxFCgI5HhqpWgbqm39YI9lVw7A5mXGEdL2H17GvQ3YpmMTjD8fGoyFcW
	X9XC+fz9VQBT6tFAhEg8zRSvBJ2yP1XVjBjQ+TsNbvqD+W6Szb/4g6zbrfbk/MCbyv865M
	lSco0Gei+imD4FViEDRDYVQDViyigFbTN/eibb22ur5/tqm4boXHPsG8Zf9UhES5A9iUNP
	71hq+nC7xF1R0Lz3PYjQD+cFnvLaaP+CNx6+cTEznF/m0lba7X1FFNEDVS7UIw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 4/8] batman-adv: stop caching unowned originator pointers in BAT IV
Date: Fri,  8 May 2026 17:43:10 +0200
Message-ID: <20260508154314.12817-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01FC84F9009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.open-mesh.org,gmail.com,lzu.edu.cn,narfation.org,simonwunderlich.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285917-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,lzu.edu.cn:email,narfation.org:email]
X-Rspamd-Action: no action

From: Jiexun Wang <wangjiexun2025@gmail.com>

BAT IV keeps the last-hop neighbor address in each neigh_node, but some
paths also cache an originator pointer derived from a temporary lookup.
That pointer is not owned by the neigh_node and may no longer refer to a
live originator entry after purge handling runs.

Stop storing the auxiliary originator pointer in the BAT IV neighbor
state. When BAT IV needs the neighbor originator data, resolve it from
the stored neighbor address and drop the reference again after use.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
[sven: avoid bonding logic for outgoing OGM]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 83 ++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 618d1889c04e7..74ef7dc2b2f98 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -173,19 +173,12 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr,
-			struct batadv_orig_node *orig_node,
-			struct batadv_orig_node *orig_neigh)
+			struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = batadv_neigh_node_get_or_create(orig_node,
 						     hard_iface, neigh_addr);
-	if (!neigh_node)
-		goto out;
-
-	neigh_node->orig_node = orig_neigh;
-
-out:
 	return neigh_node;
 }
 
@@ -906,6 +899,31 @@ static u8 batadv_iv_orig_ifinfo_sum(struct batadv_orig_node *orig_node,
 	return sum;
 }
 
+/**
+ * batadv_iv_ogm_neigh_ifinfo_sum() - Get bcast_own sum for a last-hop neighbor
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @neigh_node: last-hop neighbor of an originator
+ *
+ * Return: Number of replied (rebroadcasted) OGMs for the originator currently
+ * announced by the neighbor. Returns 0 if the neighbor's originator entry is
+ * not available anymore.
+ */
+static u8 batadv_iv_ogm_neigh_ifinfo_sum(struct batadv_priv *bat_priv,
+					 const struct batadv_neigh_node *neigh_node)
+{
+	struct batadv_orig_node *orig_neigh;
+	u8 sum;
+
+	orig_neigh = batadv_orig_hash_find(bat_priv, neigh_node->addr);
+	if (!orig_neigh)
+		return 0;
+
+	sum = batadv_iv_orig_ifinfo_sum(orig_neigh, neigh_node->if_incoming);
+	batadv_orig_node_put(orig_neigh);
+
+	return sum;
+}
+
 /**
  * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
@@ -975,17 +993,9 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	}
 
 	if (!neigh_node) {
-		struct batadv_orig_node *orig_tmp;
-
-		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
-		if (!orig_tmp)
-			goto unlock;
-
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
-						     orig_node, orig_tmp);
-
-		batadv_orig_node_put(orig_tmp);
+						     orig_node);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1037,10 +1047,9 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	 */
 	if (router_ifinfo &&
 	    neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg) {
-		sum_orig = batadv_iv_orig_ifinfo_sum(router->orig_node,
-						     router->if_incoming);
-		sum_neigh = batadv_iv_orig_ifinfo_sum(neigh_node->orig_node,
-						      neigh_node->if_incoming);
+		sum_orig = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv, router);
+		sum_neigh = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv,
+							   neigh_node);
 		if (sum_orig >= sum_neigh)
 			goto out;
 	}
@@ -1106,7 +1115,6 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	if (!neigh_node)
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     orig_neigh_node->orig,
-						     orig_neigh_node,
 						     orig_neigh_node);
 
 	if (!neigh_node)
@@ -1302,6 +1310,32 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	return ret;
 }
 
+/**
+ * batadv_orig_to_direct_router() - get direct next hop neighbor to an orig address
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @orig_addr: the originator MAC address to search the best next hop router for
+ * @if_outgoing: the interface where the OGM should be sent to
+ *
+ * Return: A neighbor node which is the best router towards the given originator
+ * address. Bonding candidates are ignored.
+ */
+static struct batadv_neigh_node *
+batadv_orig_to_direct_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+			     struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+	if (!orig_node)
+		return NULL;
+
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	batadv_orig_node_put(orig_node);
+
+	return neigh_node;
+}
+
 /**
  * batadv_iv_ogm_process_per_outif() - process a batman iv OGM for an outgoing
  *  interface
@@ -1372,8 +1406,9 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router) {
-		router_router = batadv_orig_router_get(router->orig_node,
-						       if_outgoing);
+		router_router = batadv_orig_to_direct_router(bat_priv,
+							     router->addr,
+							     if_outgoing);
 		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
 	}
 
-- 
2.47.3


