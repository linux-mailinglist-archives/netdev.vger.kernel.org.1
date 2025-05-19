Return-Path: <netdev+bounces-191639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A67FABC8B3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32E41B65E6A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF321ADA3;
	Mon, 19 May 2025 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b="Z36oibbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.universe-factory.net (osgiliath.universe-factory.net [141.95.161.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9721A94F;
	Mon, 19 May 2025 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.161.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688072; cv=none; b=BD2osM8jsPrmg9iBlSj6DyaLmPQ8Omdmy0Ol19/Y4GrTcuCr8w1CHszjR7SK9tV6pyXW7lPfnkrgTtwp1cuRDawQxlF9u89LzAkCdGt6jUw6B2uQqAgGqlyFNd4nvlGf66HDTffMSmV0sIjGQ79KLkE2G+OCJXABTU4bX0Qrhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688072; c=relaxed/simple;
	bh=o9yUfEBtm/4TRNaNJcKUoN/ncTqU60oDUTRvPK/bwMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkE4iwoTuQpuPlqmWgYI3zE/B6Tpu5UWvpqrX0vmM3Ts7XN6A5bV6MMDli9GYPM7WHAj7CmBgdJNjqa2SL+ur+2gZuPf1qWxZFOwPaQGJeLoOK6lnqFpGjlK9Ji/EeVdEmKRJVxaFPL4BkY0QsTxx2ZFc522Vj7u4l8q6Ef3hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b=Z36oibbO; arc=none smtp.client-ip=141.95.161.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1747687626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4tFLqo5k3xKoHIPW5pDy7bw73GjEG7aqdMDGqN1oPs=;
	b=Z36oibbOCISEclanDTqUhUZ8OJNayNS0OT3H8FGMI4K6d3BLP+DWeRHr1T2QFUS9nGXfRx
	58RB3eHl12InmKgD3nwF2OuivDCPtKNeJJgWHQJ1EBs0itwIxnDCE07nDq56ag+0pwZADS
	2f+RZf21onm1QBcomKGxAckds+1AZzGj+5bdFIZufGzqH6sKXDiC2RBBmKyM9KRPKe99zm
	P25UJZPUxRjYbxkuJYJtZRm6vqxoa1ThDUTvYrdCELe6SRtbqgD8CSG5uRd7bVSUGZpHjX
	QmpRHrLnsjOolvhYPm4CFPFNnIuAolcu96U9LtHjU/DeHouFuj7BIb0e+8XgzQ==
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
Subject: [PATCH batadv 5/5] batman-adv: move hardif generation counter into batadv_priv
Date: Mon, 19 May 2025 22:46:32 +0200
Message-ID: <fd475dcf9ceaa7d14e4f0b4dca668f93e704f370.1747687504.git.mschiffer@universe-factory.net>
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

The counter doesn't need to be global.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/hard-interface.c | 4 ++--
 net/batman-adv/main.c           | 1 -
 net/batman-adv/main.h           | 2 --
 net/batman-adv/netlink.c        | 2 +-
 net/batman-adv/types.h          | 3 +++
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5b46104dcf61..90968abefba0 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -748,7 +748,7 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -869,7 +869,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8e8ea93cf61d..f3d82d567968 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -61,7 +61,6 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index debc55922fe1..365d92d04c85 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -232,8 +232,6 @@ static inline int batadv_print_vid(unsigned short vid)
 		return -1;
 }
 
-extern unsigned int batadv_hardif_generation;
-
 extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *mesh_iface);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 41c1e7e0cf0d..23a626c63d40 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -978,7 +978,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	rtnl_lock();
-	cb->seq = batadv_hardif_generation << 1 | 1;
+	cb->seq = bat_priv->hardif_generation << 1 | 1;
 
 	netdev_for_each_lower_private(mesh_iface, hard_iface, iter) {
 		if (i++ < skip)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fc84c2a80020..f490fe436458 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1727,6 +1727,9 @@ struct batadv_priv {
 	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
+	/** @hardif_generation: generation counter added to netlink hardif dumps */
+	unsigned int hardif_generation;
+
 	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
 
-- 
2.49.0


