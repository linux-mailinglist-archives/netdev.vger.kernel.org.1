Return-Path: <netdev+bounces-293060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LVtDhddGWoLvwgAu9opvQ
	(envelope-from <netdev+bounces-293060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880DD5FFFA4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656B7310F024
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E723BFAD0;
	Fri, 29 May 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zDpXDoCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD33BF69C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046822; cv=none; b=lDiW/K8qxTJeSk+tTeHzfHecMd3U9/swNYhzw31ljMZAxy2IpsoPVIAnspo+JaxXk3wgjPT6qxGN3L5EVwVztozDOpi0AkD1MKG3uMEAN/97xuHVr3qYkqUsHB1ppSj46gPr0ccIiqjKq1m/J4b2fm8N7jd4YgHQKmYk1icrTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046822; c=relaxed/simple;
	bh=T6A5ZpOpTm/4dF52Xuk74SuW6krpdilyDUhtEpGPEew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0A9wm926P9CLME2vknzAKT3Und7+TbqWPKxE1CuEqQF2kK7fG5C1VnLqbn/WZo8bzxRXjUcv4YviBbqVfE07psxEWv545vaz7yyFuvOVNLH+yLANBPZgEltPoHPrNqW2CJkWADaDLpxU3b0tQk6NvSpGDZwIe467McMqIxR2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zDpXDoCQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 39B0520754;
	Fri, 29 May 2026 11:26:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bCU3K2JApnqa; Fri, 29 May 2026 11:26:58 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F2FD12019D;
	Fri, 29 May 2026 11:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F2FD12019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780046818;
	bh=1P6PdNJCqe/xzZVKy2Mdn5fV8zN7597TavqYs00A8fU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=zDpXDoCQcag7trM6kgXvJFwpmgxSxIomNBCee4SC0JoSgaXhSkEOcgd3QQy5Av4WO
	 mYPtmzCfvfurVoS884ZLVlgLM99/hpGdf9tG7mbAXUeVQK8iK47ri7afeXHxlph2zD
	 uEoh6dstJfMDcUz1QM/QKYO8CWOzWS5p3yOTI2qz2WHZipWMfFWH7UVhwHmbN/2vSY
	 toevEId+MF33v7iYOGlGOoz6uueFFfezpXHAoThSER4vVfQnxit/FgZxVF/MDBqi8D
	 Y3G6E0CSO2VdCJjTmj/gAY6VShA0qG+2U6tK9YkWGJX0EO7ASTZYwA3/bk9PQbU7ZS
	 gaqOJbEsswsfw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:26:57 +0200
Received: (nullmailer pid 3879690 invoked by uid 1000);
	Fri, 29 May 2026 09:26:51 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/10] xfrm: route MIGRATE notifications to caller's netns
Date: Fri, 29 May 2026 11:26:03 +0200
Message-ID: <20260529092648.3878973-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529092648.3878973-1-steffen.klassert@secunet.com>
References: <20260529092648.3878973-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293060-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email,secunet.com:mid,secunet.com:dkim,ntu.edu.sg:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 880DD5FFFA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maoyi Xie <maoyixie.tju@gmail.com>

xfrm_send_migrate() in net/xfrm/xfrm_user.c and pfkey_send_migrate()
in net/key/af_key.c both hardcode &init_net for the multicast that
announces a successful XFRM_MSG_MIGRATE / SADB_X_MIGRATE.

XFRM_MSG_MIGRATE arrives on a per-netns NETLINK_XFRM socket, and the
rest of the xfrm/af_key netlink path was made netns-aware in 2008.
The other 14 multicast paths in xfrm_user.c route their event using
xs_net(x), xp_net(xp) or sock_net(skb->sk); only the migrate path
was missed.

Two consequences of the init_net hardcoding:

  1. The notification (selector, old/new endpoint addresses, and the
     km_address) is delivered to listeners on init_net's
     XFRMNLGRP_MIGRATE / pfkey BROADCAST_ALL groups rather than on
     the issuing netns. An IKE daemon running in init_net therefore
     receives migration notifications originating from any other
     netns on the host.

  2. An IKE daemon running inside a non-init netns and subscribed
     to its own XFRMNLGRP_MIGRATE / pfkey groups never receives the
     notification of its own migration. IKEv2 MOBIKE / address-update
     handling inside a netns is silently broken.

Thread struct net through km_migrate() and the xfrm_mgr.migrate
function pointer, drop the &init_net override in xfrm_send_migrate()
and pfkey_send_migrate(), and pass the caller's net (already in
scope in xfrm_migrate() via sock_net(skb->sk)) all the way down.
struct xfrm_mgr is in-tree only and not exported as a stable API,
so the function-pointer signature change is internal.

pfkey_broadcast() is already netns-aware via net_generic(net,
pfkey_net_id) since the pernet conversion. The five other
pfkey_broadcast() callers in af_key.c already pass xs_net(x),
sock_net(sk) or a per-netns net, so this only removes the
&init_net outlier.

Fixes: 5c79de6e79cd ("[XFRM]: User interface for handling XFRM_MSG_MIGRATE")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 3 ++-
 net/key/af_key.c       | 6 +++---
 net/xfrm/xfrm_policy.c | 2 +-
 net/xfrm/xfrm_state.c  | 4 ++--
 net/xfrm/xfrm_user.c   | 5 ++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..874409127e29 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -715,6 +715,7 @@ struct xfrm_mgr {
 					   const struct xfrm_migrate *m,
 					   int num_bundles,
 					   const struct xfrm_kmaddress *k,
+					   struct net *net,
 					   const struct xfrm_encap_tmpl *encap);
 	bool			(*is_alive)(const struct km_event *c);
 };
@@ -1891,7 +1892,7 @@ int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_bundles,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
diff --git a/net/key/af_key.c b/net/key/af_key.c
index a166a88d8788..9cffeef18cd9 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3564,7 +3564,7 @@ static int set_ipsecrequest(struct sk_buff *skb,
 #ifdef CONFIG_NET_KEY_MIGRATE
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	int i;
@@ -3669,7 +3669,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* broadcast migrate message to sockets */
-	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, &init_net);
+	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, net);
 
 	return 0;
 
@@ -3680,7 +3680,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c944327ce66c..59968dcbafe1 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4703,7 +4703,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* Stage 5 - announce */
-	km_migrate(sel, dir, type, m, num_migrate, k, encap);
+	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
 
 	xfrm_pol_put(pol);
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 686014d39429..395d82411a87 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2837,7 +2837,7 @@ EXPORT_SYMBOL(km_policy_expired);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_migrate,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap)
 {
 	int err = -EINVAL;
@@ -2848,7 +2848,7 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	list_for_each_entry_rcu(km, &xfrm_km_list, list) {
 		if (km->migrate) {
 			ret = km->migrate(sel, dir, type, m, num_migrate, k,
-					  encap);
+					  net, encap);
 			if (!ret)
 				err = ret;
 		}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 38a90e5ee3d9..71a4b7278eba 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3271,10 +3271,9 @@ static int build_migrate(struct sk_buff *skb, const struct xfrm_migrate *m,
 
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
-	struct net *net = &init_net;
 	struct sk_buff *skb;
 	int err;
 
@@ -3292,7 +3291,7 @@ static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
-- 
2.43.0


