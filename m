Return-Path: <netdev+bounces-292716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCC3NmZRGGqwiwgAu9opvQ
	(envelope-from <netdev+bounces-292716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBA5F3AD2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F670300C0C7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94423F23C4;
	Thu, 28 May 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="0i4Q4UUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EF2475CF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978580; cv=none; b=aRsmAt1a0ioGzGOvyHyjn/nV1UK8j7rzqT1dhntQXD3rWkIlX6jEr8phW4bIU6c3YRXH85TCbie2e9fM2MwinVqocwY8oFXNc17BFkrk2R4Zs8r+3YeYP89EeljNploQJsaN/oA7pcY6edZU5OQKmKgrswxT19Ni55Q9P6+ZeGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978580; c=relaxed/simple;
	bh=wyaIWVzJCiQuPmsdNotti3PxhFmou4IBHFryifUGr5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKcmSFrKUitTvyYognSCML1oq7jmWiwxOu0jh8KdwKy25ddLXTknEZDEz+vZtmzILFvlj+lo03Di0sotW0/NNVmz8lIb4HtzuS16650SFIbbqIldglX4mVLZZcokceF2dnc+fnQNMxGZdyQ/oWoh8C4NtvUgk5n7fH5RqqSB94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=0i4Q4UUs; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BLc6U940QbY5UXcEVE/tOt57O5CMJ0DW1/joXEARGo=;
	b=0i4Q4UUsgAuJXuuGWU9AEMB2Djeh34AsJQGktw5hUXLsv4RhQuBg2J1ICsr19sLG87chJ6
	/6LWyyklDJztTU0NeUJ3kXHsfCeIIcwPx5z/ibMalop/jxsh78oHmPc81j1gJieqGeDdzW
	BY9fJQ+1wDAsm3bKVbK/EPM7Df0fUAP5EY6v1CW9HRPY5wzoYXZf0WlsZUNLuyK8JnsArF
	QRKB/vBHG+XPNUfcQFz07T/hnzyju1QTFZz04J4bh6rmNXrTxmXDLc1dpVq7gPH8Mn4L7t
	lQlUSaOkKQAIxQsGjg9gJ1XPJuPM1jmxkzHd1oM1Ahzly4U6VMZdHwXSG6Vmyg==
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
Subject: [PATCH net-next 09/15] batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
Date: Thu, 28 May 2026 16:29:18 +0200
Message-ID: <20260528142924.329658-10-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292716-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C7EBA5F3AD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

The vlan configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c              | 2 +-
 net/batman-adv/mesh-interface.c    | 2 +-
 net/batman-adv/netlink.c           | 8 ++++----
 net/batman-adv/translation-table.c | 2 +-
 net/batman-adv/types.h             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a3993a8337648..786b80a18b5d9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -627,7 +627,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	 */
 	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
+		ap_isolation_enabled = READ_ONCE(vlan->ap_isolation);
 		batadv_meshif_vlan_put(vlan);
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index dadb0784fa3e6..6d7f2dc326fe9 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -567,7 +567,7 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	vlan->vid = vid;
 	kref_init(&vlan->refcount);
 
-	atomic_set(&vlan->ap_isolation, 0);
+	WRITE_ONCE(vlan->ap_isolation, 0);
 
 	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->meshif_vlan_list);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 15f7166afd5a6..7d2498c0ca16a 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -181,7 +181,7 @@ static int batadv_netlink_mesh_fill_ap_isolation(struct sk_buff *msg,
 	if (!vlan)
 		return 0;
 
-	ap_isolation = atomic_read(&vlan->ap_isolation);
+	ap_isolation = READ_ONCE(vlan->ap_isolation);
 	batadv_meshif_vlan_put(vlan);
 
 	return nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
@@ -204,7 +204,7 @@ static int batadv_netlink_set_mesh_ap_isolation(struct nlattr *attr,
 	if (!vlan)
 		return -ENOENT;
 
-	atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+	WRITE_ONCE(vlan->ap_isolation, !!nla_get_u8(attr));
 	batadv_meshif_vlan_put(vlan);
 
 	return 0;
@@ -1022,7 +1022,7 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
-		       !!atomic_read(&vlan->ap_isolation)))
+		       !!READ_ONCE(vlan->ap_isolation)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -1110,7 +1110,7 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED];
 
-		atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+		WRITE_ONCE(vlan->ap_isolation, !!nla_get_u8(attr));
 	}
 
 	batadv_netlink_notify_vlan(bat_priv, vlan);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 28869f65ada09..515f26ff8c269 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3730,7 +3730,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	if (!vlan)
 		return false;
 
-	if (!atomic_read(&vlan->ap_isolation))
+	if (!READ_ONCE(vlan->ap_isolation))
 		goto vlan_put;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index dd63cd28914d7..cf01a670d8250 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1459,7 +1459,7 @@ struct batadv_meshif_vlan {
 	unsigned short vid;
 
 	/** @ap_isolation: AP isolation state */
-	atomic_t ap_isolation;		/* boolean */
+	u8 ap_isolation;		/* boolean */
 
 	/** @tt: TT private attributes (VLAN specific) */
 	struct batadv_vlan_tt tt;
-- 
2.47.3


