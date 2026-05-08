Return-Path: <netdev+bounces-285840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uQwPGrPm/WlNkgAAu9opvQ
	(envelope-from <netdev+bounces-285840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:35:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60524F7223
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6A930B4344
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBCD3EDAAF;
	Fri,  8 May 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="u6/bCcTL"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911F3EF0C8;
	Fri,  8 May 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247020; cv=none; b=iFOJW+64LTMvie4FuIyoqZxtkhe1XaF0NY8+++jZ3j7fbOkPV6w31RcXOMwF7wRexQf67jkIt0sI0CJHpegFh6d3nlvpVcwx37vgCTPekthVQ6Giaozwsu+qNVd6HjE9+rY1cjjHw2Zd0aTQ+/P8I8YBZs39GNUXrBM25LKyNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247020; c=relaxed/simple;
	bh=GCut3ieEWzJwDvrV9EKvxW+yE6TgayFDTE7Hcw9Em7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMVIaTl8qHHYecFvbBZKLc0OJXRKOkBJWax2rER7GcTwG+cZ++XG3lA9AgTPQSVqJBneUjWa2YgT0CKI/pGS+zwnA6gAZow0f6VoK4+QOTYKHQCQMm0Gh0v81c5ycJcwmHlSjzkTJGuGtWV+xWckYG+hjWvrYwavSfqMghFQQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=u6/bCcTL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=sIUzyPzrM5JMnMUNbhqwM36aBxK6ebWQrwSmdyV+TzI=; b=u6/bCcTLKRMMJAMweqg8CnN6lL
	EMORAEv1MxE4b7cH+3A8pyX8qW9/Ij33GRarRrnqkyO2wvmnQNokBhGkeA9E/hGrPLsKipJCRIE29
	/93MiohewMK/5ocTsmkb+W6Vj5WkBBPnoWDwYbM1CX5jJ+nz3KXjkAYgIc4gpuaaiNQrk1LIU9AKR
	5UXS3WHJ2+DWi7RPsBv9mBEqiJI7eAt+rGIHJa/QA1gaCZOG5+V9QHvlfhLxIy0/QaoI09v8ULvIj
	ckIGSbpLyofQXJOLilHMnSI+NoIu94S/H1wQnpgQ6+DWOgLLAwOPeXWjRPSGOZv2GwjnYn7gGyBaC
	3fLIs7sA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLHN-005B0V-2D;
	Fri, 08 May 2026 13:30:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:22 -0700
Subject: [PATCH net-next 8/8] netconsole: move find_skb() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-8-0f660e62841f@debian.org>
References: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
In-Reply-To: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4422; i=leitao@debian.org;
 h=from:subject:message-id; bh=GCut3ieEWzJwDvrV9EKvxW+yE6TgayFDTE7Hcw9Em7s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4CF6GDfOj3Hwg9IqzIQPZdehz5g17nY+mi
 lHiG2qhNWWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bfoUEACwvDEX7QebhylYdbMGVx88BOvOHHgx6Gg64V8x8JDwzG2YcajvtN8Cx3DXz2hkN9Uch1Q
 LflOZTt0wUFUQhN52eFbYy22T0Wzyrx+qa2Cw7EC7roiUP9pUz5W51dgZwigM3zgMzmveJsTYhW
 OqrUX6p+FK8imKHXZb/p8vg+I7TTwvmTfm1aY0fZacpmtXLJgg6X4RMJjWpUJGb6LICTPMIKmlZ
 QRGceYiOaBVZEX8+8CyriTnEdyhrinwSulttkwsMuEiEwN6K4CGQXVyXUnRn0geJ5RZb2IWmxBc
 7znuF+FaJHJshfGbKOs96/V0iqQAnfF1U8IOQmj51EIasMbWvm6jG0ANuDO379tH2kVhkIOdV46
 79+6o4knnmOTq2epZQHj3aghV9C1hi6m7JHqUVgS+92aQE9OYJrQDAX2ebIjM3DKspQNBtX5Hd1
 69TgkjqGk9GeWONg6c1FsfAGaRHsvPrA1txnmeTI88+iaAFh1KpDMmqNO4cqXs4XpExoVwpNoTp
 MHEDoVaQP1p48Xcjqg8ZnmCmKUqxHQ7DzrbPtIAwRARoFP7CXsHtfxBmsmYDw9cvjUWte9HZU2/
 3PSkuSTsB8ltDYK1DPoHrwxzkBi+aNqEDp9omF7YWNo5Q8W2xS84O7+fOG7KGT8H2xkP/L6ayu5
 fylYkCc6f68ZyBg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: C60524F7223
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285840-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

find_skb() is the netconsole-specific entry into the netpoll skb
pool: every other netpoll consumer (bonding, team, vlan, bridge,
macvlan, dsa) builds its own sk_buff and never touches the pool.
With netpoll_send_udp() (its only caller) now living in netconsole,
find_skb() can join it.

Move find_skb() into drivers/net/netconsole.c as a file-static
helper, drop EXPORT_SYMBOL_GPL(find_skb) and remove its prototype
from include/linux/netpoll.h.

find_skb() calls zap_completion_queue() to drain TX completions
before allocating. zap_completion_queue() also has a second caller
inside netpoll itself (netpoll_poll_dev() runs it after each poll
to free completed skbs), so it stays in net/core/netpoll.c.
Promote it from file-static to EXPORT_SYMBOL_GPL with a forward
declaration in include/linux/netpoll.h, and drop its old
file-static forward declaration.

The skb pool's lifecycle (np->skb_pool, np->refill_wq, refill_skbs(),
refill_skbs_work_handler(), skb_pool_flush()) stays in netpoll: it
is initialised in __netpoll_setup() and torn down in
__netpoll_cleanup(), both of which remain netpoll's responsibility.
The refill work queued via schedule_work(&np->refill_wq) from the
moved find_skb() runs refill_skbs_work_handler() in netpoll without
any further plumbing.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 27 +++++++++++++++++++++++++++
 include/linux/netpoll.h  |  2 +-
 net/core/netpoll.c       | 33 ++-------------------------------
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 48d2670bbdef5..817561d8b06bb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1653,6 +1653,33 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+{
+	int count = 0;
+	struct sk_buff *skb;
+
+	zap_completion_queue();
+repeat:
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb) {
+		skb = skb_dequeue(&np->skb_pool);
+		schedule_work(&np->refill_wq);
+	}
+
+	if (!skb) {
+		if (++count < 10) {
+			netpoll_poll_dev(np->dev);
+			goto repeat;
+		}
+		return NULL;
+	}
+
+	refcount_set(&skb->users, 1);
+	skb_reserve(skb, reserve);
+	return skb;
+}
+
 static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 				 int len)
 {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1877d42ccbccf..c9a03d88263ef 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -73,7 +73,7 @@ void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
+void zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c148b3b68cec9..956528904050e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -51,8 +51,6 @@
 	 sizeof(struct udphdr) +					\
 	 MAX_UDP_CHUNK)
 
-static void zap_completion_queue(void);
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
@@ -238,7 +236,7 @@ static void refill_skbs(struct netpoll *np)
 	}
 }
 
-static void zap_completion_queue(void)
+void zap_completion_queue(void)
 {
 	unsigned long flags;
 	struct softnet_data *sd = &get_cpu_var(softnet_data);
@@ -265,34 +263,7 @@ static void zap_completion_queue(void)
 
 	put_cpu_var(softnet_data);
 }
-
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
-{
-	int count = 0;
-	struct sk_buff *skb;
-
-	zap_completion_queue();
-repeat:
-
-	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
-	}
-
-	if (!skb) {
-		if (++count < 10) {
-			netpoll_poll_dev(np->dev);
-			goto repeat;
-		}
-		return NULL;
-	}
-
-	refcount_set(&skb->users, 1);
-	skb_reserve(skb, reserve);
-	return skb;
-}
-EXPORT_SYMBOL_GPL(find_skb);
+EXPORT_SYMBOL_GPL(zap_completion_queue);
 
 static int netpoll_owner_active(struct net_device *dev)
 {

-- 
2.53.0-Meta


