Return-Path: <netdev+bounces-191643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95294ABC8BB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928D51B65F7A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506921CC43;
	Mon, 19 May 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b="GCgB3LiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.universe-factory.net (osgiliath.universe-factory.net [141.95.161.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5521ABAE;
	Mon, 19 May 2025 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.161.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688074; cv=none; b=cEzyFJUQiu/wt73B2OvcJMQjGhUjDg0ZAEkvdfgei8JT3S1ie1BxxdIC8o49UCL5IesCKsi0+SleTKseHGm38QD1sG44tcz0XQ1UNjR/JXgciGJU2vInXcRPLnAYuI9zM/mAvNzTqWqu2SrPF+55/t6AuTcP2XlEUPeXcuQ5XaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688074; c=relaxed/simple;
	bh=h1MLSkSp7608TAxXWbWHe4vIGUXd+c5Wuhshbg6qKVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1kMkzPZRjjoK3x/xpMo4NmhHUqTOMBTz6LZ8dNR2MLqVB8GTmX5xZo4d2HGVVgpa0uKlnZQJKm0L//Bjp0H8oNlTbl3SFLzAaDSZsKzIn1Z02h/DX3H3eUY+UwGVJ5FUV9O7So2ot+yVt+R1leyFetO5X7PwODqdWvCO21Wcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b=GCgB3LiB; arc=none smtp.client-ip=141.95.161.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1747687626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IK43LTWvxmkvAV+Aq9GRCi4DNSqJMJlrPCqqPgdgcg=;
	b=GCgB3LiBpSDkg96TxhHvORazq0jyRYSp14hmTnh16NQZqOONT+l6rg9MB23RiVn/8k90l0
	5+XydgadYUcEIhL47W0q7cefqHWTJR3sXkj6Ar2SPuiC/NOcNiDNnCncgfpd/q8vI9J6Su
	AYkKoFkZLjkQYPWjkWVesI8klO+LJsAMNbnZZEgobS/pvXoSLOcio9iRpGNbPjIcw+mUUP
	IgVJ+ZG0iw5XR5XBUVJ0izjl4XCgiGMU8GSxqjjktGyspqzKNxg++loBgiooXCXUZkbuAR
	0v9hvG+rkyZmYDJNA/uLk6wbBUMQMm7pXKd9ZiqpjiKkQEuxPsn6YYVMkW7EJQ==
Authentication-Results: mail.universe-factory.net;
	auth=pass smtp.mailfrom=mschiffer@universe-factory.net
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Mon, 19 May 2025 22:46:31 +0200
Message-ID: <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
In-Reply-To: <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
References: <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

With interfaces being kept track of as iflink private data, there is no
need for the global list anymore. batadv_hardif_get_by_netdev() can now
use netdev_master_upper_dev_get()+netdev_lower_dev_get_private() to find
the hardif corresponding to a netdev.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/hard-interface.c | 26 ++++++++++----------------
 net/batman-adv/hard-interface.h |  2 +-
 net/batman-adv/main.c           |  5 -----
 net/batman-adv/main.h           |  1 -
 net/batman-adv/types.h          |  3 ---
 5 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 89e0e11250ca..5b46104dcf61 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -63,21 +63,19 @@ void batadv_hardif_release(struct kref *ref)
  * Return: batadv_hard_iface of net_dev (with increased refcnt), NULL on errors
  */
 struct batadv_hard_iface *
-batadv_hardif_get_by_netdev(const struct net_device *net_dev)
+batadv_hardif_get_by_netdev(struct net_device *net_dev)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct net_device *mesh_iface;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->net_dev == net_dev &&
-		    kref_get_unless_zero(&hard_iface->refcount))
-			goto out;
-	}
+	mesh_iface = netdev_master_upper_dev_get(net_dev);
+	if (!mesh_iface || !batadv_meshif_is_valid(mesh_iface))
+		return NULL;
 
-	hard_iface = NULL;
+	hard_iface = netdev_lower_dev_get_private(mesh_iface, net_dev);
+	if (!kref_get_unless_zero(&hard_iface->refcount))
+		return NULL;
 
-out:
-	rcu_read_unlock();
 	return hard_iface;
 }
 
@@ -721,7 +719,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = NULL;
 	hard_iface->if_status = BATADV_IF_INACTIVE;
 
-	INIT_LIST_HEAD(&hard_iface->list);
 	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 
 	mutex_init(&hard_iface->bat_iv.ogm_buff_mutex);
@@ -738,8 +735,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	batadv_v_hardif_init(hard_iface);
 
 	kref_get(&hard_iface->refcount);
-	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
-	batadv_hardif_generation++;
 
 	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
 	required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
@@ -753,6 +748,7 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	batadv_hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -850,9 +846,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
-	list_del_rcu(&hard_iface->list);
-	batadv_hardif_generation++;
-
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
@@ -876,6 +869,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
+	batadv_hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index ace7a0f6f3b6..6b210ebe45b3 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -66,7 +66,7 @@ struct net_device *batadv_get_real_netdev(struct net_device *net_device);
 bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
-batadv_hardif_get_by_netdev(const struct net_device *net_dev);
+batadv_hardif_get_by_netdev(struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index f1a7233de1da..8e8ea93cf61d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -61,10 +61,6 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-/* List manipulations on hardif_list have to be rtnl_lock()'ed,
- * list traversals just rcu-locked
- */
-struct list_head batadv_hardif_list;
 unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
@@ -97,7 +93,6 @@ static int __init batadv_init(void)
 	if (ret < 0)
 		return ret;
 
-	INIT_LIST_HEAD(&batadv_hardif_list);
 	batadv_algo_init();
 
 	batadv_recv_handler_init();
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 692109be2210..debc55922fe1 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -232,7 +232,6 @@ static inline int batadv_print_vid(unsigned short vid)
 		return -1;
 }
 
-extern struct list_head batadv_hardif_list;
 extern unsigned int batadv_hardif_generation;
 
 extern struct workqueue_struct *batadv_event_workqueue;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0ca0fc072fc9..fc84c2a80020 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -166,9 +166,6 @@ enum batadv_hard_iface_wifi_flags {
  * struct batadv_hard_iface - network device known to batman-adv
  */
 struct batadv_hard_iface {
-	/** @list: list node for batadv_hardif_list */
-	struct list_head list;
-
 	/** @if_status: status of the interface for batman-adv */
 	char if_status;
 
-- 
2.49.0


