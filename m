Return-Path: <netdev+bounces-183452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4DA90B68
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF7E17E71B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73771223704;
	Wed, 16 Apr 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b="ozEUG8Vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail.universe-factory.net (osgiliath.universe-factory.net [141.95.161.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B153221F07;
	Wed, 16 Apr 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.161.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828713; cv=none; b=Mbnsp91LUeZdH4eOHMxvb5W/HpO2X3MFbmChRafVR46X7GjK1jOYxegPCbvrFEZboDI+GhnY+Idcmj+7KejGhF+fOyahLrADrwE6ZO4b2CT0zcuj6E3swBXcl3FjOI18fhph7QcpsgmM/NfQ2DXXmFQivnBmtZ5Elv12EmA2I+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828713; c=relaxed/simple;
	bh=zglIdbC5Tg511EtnlgXHyL4QiGFnusIxv7OoZEMwEus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVCcXEuh0OKKoyRLKHSeBe2kQQdEXQyzq8zcQJMXDxOlt2dmnNgGQ4kzVuW5IqY+MXMVaeKfdp1lEiZK75tsLLmPpq3va+/KF5rhMGHiPO5hH1NY80nJFs+Gqi0NsuvzbRqIogpDhaffOLhULcr75aW4Y/alFWckDuhblSiOkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b=ozEUG8Vr; arc=none smtp.client-ip=141.95.161.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744828700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XJDMhfldMO0Uz3R/dGP3WNaSTXv6Xbup3WKyLVrNux4=;
	b=ozEUG8Vr2QfwYFS+57Y9O4FqUK/BOGKXxyq/rOt5lZ9faT2TiZ7a2d/6UGtkqXJUmgMaI1
	6eQ2VhSY4KeJ1DW/t3zwmXo2rG9ur51Xff01bYip8xRp4Kwu36BqOxZEO34mMR7L3+qG9D
	G2oNytgQb8LUo83t2NMQ7zxHSV6wyufZ6junDEn377pxXa4WgZddpTVQlD5u3rlDvBiu8i
	4vh+XXMlkeT0djG6Ms3UFFFNdFxD+QfHzT5cgCjtLuV4ka27tJ9QQcAps+Ux4ouuJs4Fz1
	wMSAJ43F+60H1VV2I4icLvMNHVaBcOh6NcUsY5pPcmDs3GdpZ9UBHVLz+GeqEQ==
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
Subject: [PATCH batadv stable v2] batman-adv: fix duplicate MAC address check
Date: Wed, 16 Apr 2025 20:37:56 +0200
Message-ID: <0a3f663c380e8371932cbf157cde18f8ff93c400.1744449181.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

batadv_check_known_mac_addr() is both too lenient and too strict:

- It is called from batadv_hardif_add_interface(), which means that it
  checked interfaces that are not used for batman-adv at all. Move it
  to batadv_hardif_enable_interface(). Also, restrict it to hardifs of
  the same mesh interface; different mesh interfaces should not interact
  at all. The batadv_check_known_mac_addr() argument is changed from
  `struct net_device` to `struct batadv_hard_iface` to achieve this.
- The check only cares about hardifs in BATADV_IF_ACTIVE and
  BATADV_IF_TO_BE_ACTIVATED states, but interfaces in BATADV_IF_INACTIVE
  state should be checked as well, or the following steps will not
  result in a warning then they should:

  - Add two interfaces in down state with different MAC addresses to
    a mesh as hardifs
  - Change the MAC addresses so they conflict
  - Set interfaces to up state

  Now there will be two active hardifs with the same MAC address, but no
  warning. Fix by only ignoring hardifs in BATADV_IF_NOT_IN_USE state.

The RCU lock can be dropped, as we're holding RTNL anyways when the
function is called.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
v2: do not change pr_warn to netdev_warn in the patch for stable

 net/batman-adv/hard-interface.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f9662653..d099434d3dfa 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -506,28 +506,32 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 	return false;
 }
 
-static void batadv_check_known_mac_addr(const struct net_device *net_dev)
+static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_iface)
 {
-	const struct batadv_hard_iface *hard_iface;
+	const struct net_device *mesh_iface = hard_iface->mesh_iface;
+	const struct batadv_hard_iface *tmp_hard_iface;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != BATADV_IF_ACTIVE &&
-		    hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED)
+	if (!mesh_iface)
+		return;
+
+	list_for_each_entry(tmp_hard_iface, &batadv_hardif_list, list) {
+		if (tmp_hard_iface == hard_iface)
+			continue;
+
+		if (tmp_hard_iface->mesh_iface != mesh_iface)
 			continue;
 
-		if (hard_iface->net_dev == net_dev)
+		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
-		if (!batadv_compare_eth(hard_iface->net_dev->dev_addr,
-					net_dev->dev_addr))
+		if (!batadv_compare_eth(tmp_hard_iface->net_dev->dev_addr,
+					hard_iface->net_dev->dev_addr))
 			continue;
 
 		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
-			net_dev->dev_addr, hard_iface->net_dev->name);
+			hard_iface->net_dev->dev_addr, tmp_hard_iface->net_dev->name);
 		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
-	rcu_read_unlock();
 }
 
 /**
@@ -764,6 +768,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
 
+	batadv_check_known_mac_addr(hard_iface);
+
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
 	else
@@ -902,7 +908,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	batadv_v_hardif_init(hard_iface);
 
-	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 	batadv_hardif_generation++;
@@ -989,7 +994,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			goto hardif_put;
 
-		batadv_check_known_mac_addr(hard_iface->net_dev);
+		batadv_check_known_mac_addr(hard_iface);
 
 		bat_priv = netdev_priv(hard_iface->mesh_iface);
 		bat_priv->algo_ops->iface.update_mac(hard_iface);
-- 
2.49.0


