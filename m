Return-Path: <netdev+bounces-303542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FQXyI03ORGq01AoAu9opvQ
	(envelope-from <netdev+bounces-303542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73646EB0AF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:22:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="YcRBKM/0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303542-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EC54300E69E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3AC3E2AD8;
	Wed,  1 Jul 2026 08:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964038E5D4
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894143; cv=none; b=UzGciC1YiFQ9EpfvjI0UoFpgUbvHFwoaziBwZUZrs8u/XNwXbYE8EPAUHwJ9wcEkGna/VbvetPY8lBtxlT85SBjsYcCeiPPZGcYBf6MDAo026vZylbYZgR2QWexizyO3MiTTE4c1K0/5rT6mHlU++AakeSHCuv4gJ3xgJGiY0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894143; c=relaxed/simple;
	bh=6lvvRXufqMNGxW2Af5aHc4wCI92pe6TY5REDBLPpJDI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CBmL8sax5qsF+HEXNqt2jTP980z1Jh1rtIiEbm8ianlRpdYwf4FXkEOftvupaywi1jRjhaLMofFqQKHooFaXZ78sHCW+a9OqCtD4BUnO4Ax/8/41dYntDNSblXPNgYPPrPm7n1S1LQPEoKIcuBVo4mUf77xBKoDMUmOe9WJTDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YcRBKM/0; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f39a46efd9so3185366d6.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782894138; x=1783498938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vCu62ov+KaZ6jEXVf6oYpT4hnxOy0eAKkYKmoOdOJA=;
        b=YcRBKM/0GxnUgrdF8wfcZXgLzOHvBwlNTT1VEdxC6QTIpoXrxWa6ly7sAiiTha4bC0
         x3Vnb1lsLD36zuev8vQQRj/1SwvgPhaOtOhr+nBpbqCy3rB8toiupZx1HkWwGZ+vhlze
         eRU+7UcOUGnsh38lzsZwjQqqvR2t40BeHFWkOAjIomd6+oa7a6sDHs6U6aeb7ZQqEuIM
         Oq4BfjKBeUwNz1lYvqMcc0ibRZqtzLzCLZ0pBp70dBOFxMxDOB27gXMcLZ5zCqq8AHW/
         HOSBxoz9VqnqeEfiyfqD1MC8Tg2BLrfSovaAACV0OaRHZy3MabpD8/aXpbX+8mrukV5N
         BpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894138; x=1783498938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vCu62ov+KaZ6jEXVf6oYpT4hnxOy0eAKkYKmoOdOJA=;
        b=r+w619G2KFxg0BuApNRct8NLvQKlsv1CqOtJydVT4S1pb9scocffoAbP7cgrn9VCnY
         rOw1t7YbyIGnNpxGCqN7/k8oY5OwDHUD+JNmd4hAJ9UZ/NeM5OnK6ZqrHnJVs9nMeOpN
         iGhTrYsnYWot6UHpcopFTIRGR/7g/araj3djJeUu3LCRm/4cq1nQkJ3W63ibMu+FPE0L
         VHX4BdsAaHPmiIMUun+UhqsWpJmll+lVy6LO9BbvD4S4nVi/YodfBKM0zCs6JIIOts9M
         w2y4B/4RKD8OlquYL2QZYJhxjZuvhtkr/hNCpgbjRFdaJvQwyGO3c92NvTUlFBXNlQZi
         v7mw==
X-Forwarded-Encrypted: i=1; AHgh+RqEm8FZLk9AEW2gKMuvIK468jAxO+GLJSxVluIXQMKRKJ3LmjbvCllGd8aWDSKO8vw9kmLtheE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy600vYBY6DhvznE0KEKZLF5VfgFH7rt2RK21ix/yJko4Lk3gs
	BtxqTUeksW5y8I0k/6ilSs8tWg9uWZi/hhIy/4khqdBLKY9+ulwqnaF/nprSgghL8fuctdT2T2n
	CP4TVTp4Kbqv5Dw==
X-Received: from qvry11.prod.google.com ([2002:ad4:530b:0:b0:8de:96d2:d2b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:459b:b0:8d0:3950:aa0f with SMTP id 6a1803df08f44-8f254024153mr69517696d6.22.1782894138009;
 Wed, 01 Jul 2026 01:22:18 -0700 (PDT)
Date: Wed,  1 Jul 2026 08:22:13 +0000
In-Reply-To: <20260701082214.2974946-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701082214.2974946-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701082214.2974946-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] macvlan: annotate data-races around vlan->mode
 and vlan->flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303542-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A73646EB0AF

Both fields can be changed in macvlan_changelink() while being read
locklessly.

Add READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836bb2395267914807542ae5094e1a3c..8b69cc9b70f98d7991110f5eda76d58d5d96fa81 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -277,7 +277,7 @@ static void macvlan_broadcast(struct sk_buff *skb,
 		return;
 
 	hash_for_each_rcu(port->vlan_hash, i, vlan, hlist) {
-		if (vlan->dev == src || !(vlan->mode & mode))
+		if (vlan->dev == src || !(READ_ONCE(vlan->mode) & mode))
 			continue;
 
 		hash = mc_hash(vlan, eth->h_dest);
@@ -306,7 +306,7 @@ static void macvlan_multicast_rx(const struct macvlan_port *port,
 				  MACVLAN_MODE_VEPA    |
 				  MACVLAN_MODE_PASSTHRU|
 				  MACVLAN_MODE_BRIDGE);
-	else if (src->mode == MACVLAN_MODE_VEPA)
+	else if (READ_ONCE(src->mode) == MACVLAN_MODE_VEPA)
 		/* flood to everyone except source */
 		macvlan_broadcast(skb, port, src->dev,
 				  MACVLAN_MODE_VEPA |
@@ -447,7 +447,7 @@ static bool macvlan_forward_source(struct sk_buff *skb,
 			if (!vlan)
 				continue;
 
-			if (vlan->flags & MACVLAN_FLAG_NODST)
+			if (READ_ONCE(vlan->flags) & MACVLAN_FLAG_NODST)
 				consume = true;
 			macvlan_forward_source_one(skb, vlan);
 		}
@@ -487,14 +487,18 @@ static rx_handler_result_t macvlan_handle_frame(struct sk_buff **pskb)
 			return RX_HANDLER_CONSUMED;
 		}
 		src = macvlan_hash_lookup(port, eth->h_source);
-		if (src && src->mode != MACVLAN_MODE_VEPA &&
-		    src->mode != MACVLAN_MODE_BRIDGE) {
-			/* forward to original port. */
-			vlan = src;
-			ret = macvlan_broadcast_one(skb, vlan, eth, 0) ?:
-			      __netif_rx(skb);
-			handle_res = RX_HANDLER_CONSUMED;
-			goto out;
+		if (src) {
+			enum macvlan_mode mode = READ_ONCE(src->mode);
+
+			if (mode != MACVLAN_MODE_VEPA &&
+			    mode != MACVLAN_MODE_BRIDGE) {
+				/* forward to original port. */
+				vlan = src;
+				ret = macvlan_broadcast_one(skb, vlan, eth, 0) ?:
+				      __netif_rx(skb);
+				handle_res = RX_HANDLER_CONSUMED;
+				goto out;
+			}
 		}
 
 		hash = mc_hash(NULL, eth->h_dest);
@@ -515,7 +519,7 @@ static rx_handler_result_t macvlan_handle_frame(struct sk_buff **pskb)
 					      struct macvlan_dev, list);
 	else
 		vlan = macvlan_hash_lookup(port, eth->h_dest);
-	if (!vlan || vlan->mode == MACVLAN_MODE_SOURCE)
+	if (!vlan || READ_ONCE(vlan->mode) == MACVLAN_MODE_SOURCE)
 		return RX_HANDLER_PASS;
 
 	dev = vlan->dev;
@@ -548,7 +552,7 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	const struct macvlan_port *port = vlan->port;
 	const struct macvlan_dev *dest;
 
-	if (vlan->mode == MACVLAN_MODE_BRIDGE) {
+	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_BRIDGE) {
 		const struct ethhdr *eth = skb_eth_hdr(skb);
 
 		/* send to other bridge ports directly */
@@ -559,7 +563,7 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 
 		dest = macvlan_hash_lookup(port, eth->h_dest);
-		if (dest && dest->mode == MACVLAN_MODE_BRIDGE) {
+		if (dest && READ_ONCE(dest->mode) == MACVLAN_MODE_BRIDGE) {
 			/* send to lowerdev first for its network taps */
 			dev_forward_skb(vlan->lowerdev, skb);
 
@@ -777,7 +781,7 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
 	if (ether_addr_equal(dev->dev_addr, addr->__data))
 		return 0;
 
-	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
+	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_PASSTHRU) {
 		macvlan_set_addr_change(vlan->port);
 		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
 	}
@@ -1645,7 +1649,7 @@ static int macvlan_changelink(struct net_device *dev,
 			if (err < 0)
 				return err;
 		}
-		vlan->flags = flags;
+		WRITE_ONCE(vlan->flags, flags);
 	}
 
 	if (data && data[IFLA_MACVLAN_BC_QUEUE_LEN]) {
@@ -1658,7 +1662,7 @@ static int macvlan_changelink(struct net_device *dev,
 			vlan, nla_get_s32(data[IFLA_MACVLAN_BC_CUTOFF]));
 
 	if (set_mode)
-		vlan->mode = mode;
+		WRITE_ONCE(vlan->mode, mode);
 	if (data && data[IFLA_MACVLAN_MACADDR_MODE]) {
 		if (vlan->mode != MACVLAN_MODE_SOURCE)
 			return -EINVAL;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


