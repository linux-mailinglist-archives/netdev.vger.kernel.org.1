Return-Path: <netdev+bounces-304171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ALZfOKpYRmohRQsAu9opvQ
	(envelope-from <netdev+bounces-304171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBEA6F7884
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=IkTRDrIQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304171-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304171-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6864F30886B8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668647DFBD;
	Thu,  2 Jul 2026 12:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D3480978;
	Thu,  2 Jul 2026 12:20:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994847; cv=none; b=PoIOu3/EVkEJ9wZmO15mviXnirkJcmJdA7DmwL8gnHQ3PU2Tli0GbKTfKoXo6wBPqUZF56lJpNoiTwHNOLsAfpR/7SA//OSuVNUjPrQilX7m1wxHphIxBqf8ExINVtGPOZgvZxqTLG4TFpiEWuReGeRqwnUldB1rNi6OPkUIYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994847; c=relaxed/simple;
	bh=/xwUC3EdhFnukKRYH9jrqkNKUElM9MbOZrLoFAsdE/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMBdJYG+tbE1PFj1aaXzPqeiZOPEg9qsgkSf8vgpgPNHs7bEF7KcWgkfHbPQO1sxlNq/BqQjkTA5eO3P2i288eVIx/YYJk4V38LnY7m/p8T+bj70CedmjRfWxGe94s2sJbU0HNIKGHjCVKUjsMZgycCj8tuI5nc7qlMjTGapPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IkTRDrIQ; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YNpLN13LP9HQufU7hminbv7Sx8jX4+J/DmkudT8hh5s=; b=IkTRDrIQC17bKi3cnk89wIrl/b
	ILFNVcuXPY/KvZ3nrhtEB4xWxl1JySWvpAz+lAIe2eUB1AbqQzenxqXCFBY82j4gzGu4IGdBql23L
	UPLgcj53AwmGQeQOEtjkTxMlQZ0dy/DMxnqnMVm0F0TIFND8V7kC2ElD6jMaQmg+ac4oHywJ+FxAo
	XbuDkauf/gs+4ml6nxxi8xbOlb+34nN07rbN6qKz8RWdVIAEUjki+toQZb/INyH4i+600n0dY08Jj
	acd0iHJLGsW+2gpPCWHr4Czz9Ljq5A1IN1V8N5t5qqQnsGZWlTqJFjjg9ZKsQFgDlZUu4YvIHoCDM
	s8tYrmhQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGPK-008cQq-0a;
	Thu, 02 Jul 2026 12:20:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:48 -0700
Subject: [PATCH net-next v2 4/8] netconsole: move refill_skbs() and
 skb-pool sizing macros from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-4-1ebedd921dcb@debian.org>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
In-Reply-To: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4632; i=leitao@debian.org;
 h=from:subject:message-id; bh=/xwUC3EdhFnukKRYH9jrqkNKUElM9MbOZrLoFAsdE/w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFpQ5wHFoZ3JraFXBiq6+TiSKH7kUixydm0
 KdlkJOJCHKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 bXNcD/9whUIqhZqhT3CzP3uG112U2z0ay7Msg6U9xKSyx8HIyuTAfUIS9ceUG02s5uRnyvpVdWs
 I57B2k/6uNhdtO1gcnhvisaIQjmSr3HOH4OvJqZIx7Erjoc8e73KQEVSKhESGz4ZWfNqJ2L9bqP
 jcSq1uv43RRmzbzsBB/u24a0iks1TFsmunIkPUx9fx8tw/6JrUKw8ngeoeABCsVpVLeC1Hx65Fx
 qXkkPt6OKdcHXgTOJZLc8QpBPNi9EyEwnVWNSPi6KbfH2o5jKB0mLQaadmoQBbgbrWHJm+wfwm9
 qqGpgvYC+QbTtPSLMXWhe154Kum4YYK75VgVROr1cmnE8ktEdRdKuj60bmmGo/FNSKui+ZyvgQR
 OYUyshYaUAbEKnAf65F0BTyKuRH1sSSRDOin5bu/njSIkdmQ8IqaX2fJxbOP6Es554TiMM2f5Zv
 rrB7tdpQxnEcjvTdYrGVh/YebhKd0OpEAoNrsp6rBeT325rNcF+/9cIA3QD/4GLxv1cmGVU3uHa
 RYnBobDWpO2/SuV8n3KgoFmMqqEXPG9UeL74/KPDbKqprlrJ4lOoWA5hI6IPj3mVIFQ1kBj0cLT
 hJzm+y+FNC3+xBwYTJ8oGARDslQcsYF+8CYRgJoNbVqKSi98gpcgj+2NdzGzkoplxLEub7PWb1H
 4ohtK9k4A3oU1uw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304171-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BBEA6F7884

refill_skbs() is now only called from netconsole (directly via
netconsole_skb_pool_init() and indirectly via the just-moved
refill_skbs_work_handler()), and the MAX_UDP_CHUNK / MAX_SKBS /
MAX_SKB_SIZE macros are private to it. Move them all into
drivers/net/netconsole.c.

MAX_UDP_CHUNK and MAX_SKB_SIZE were promoted to <linux/netpoll.h>
by commit 6c537b845c99 ("netconsole: do not dequeue pooled skbs that
cannot satisfy len") so find_skb() could detect oversized requests
against the same value refill_skbs() used. With both functions now
local to netconsole, the shared definition no longer needs to live
in the header.

Pure code motion: bodies and pool sizing semantics are unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 29 +++++++++++++++++++++++++++++
 include/linux/netpoll.h  | 15 ---------------
 net/core/netpoll.c       | 23 -----------------------
 3 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 59b1f7d6f103a..6bb8184d023a3 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -61,6 +61,19 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 #define MAX_USERDATA_ITEMS		256
 #define MAX_PRINT_CHUNK			1000
 
+/*
+ * Sizing for the per-target fallback skb pool consulted by find_skb()
+ * when its GFP_ATOMIC allocation fails so messages still get out under
+ * memory pressure.
+ */
+#define MAX_UDP_CHUNK			1460
+#define MAX_SKBS			32
+#define MAX_SKB_SIZE							\
+	(sizeof(struct ethhdr) +					\
+	 sizeof(struct iphdr) +						\
+	 sizeof(struct udphdr) +					\
+	 MAX_UDP_CHUNK)
+
 static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]");
@@ -292,6 +305,22 @@ static void netcons_release_dev(struct netconsole_target *nt)
 		memset(&nt->np.dev_name, 0, IFNAMSIZ);
 }
 
+static void refill_skbs(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+	struct sk_buff *skb;
+
+	skb_pool = &np->skb_pool;
+
+	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC | __GFP_NOWARN);
+		if (!skb)
+			break;
+
+		skb_queue_tail(skb_pool, skb);
+	}
+}
+
 static void refill_skbs_work_handler(struct work_struct *work)
 {
 	struct netpoll *np =
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 51e5863d8e678..7e2fbce863e9b 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -21,20 +21,6 @@ union inet_addr {
 	struct in6_addr	in6;
 };
 
-/*
- * Maximum payload netpoll's preallocated skb pool can carry. Keep this in
- * sync with the buffer size used by refill_skbs() in net/core/netpoll.c;
- * callers (e.g. netconsole) use it to detect requests the pool can never
- * satisfy and avoid dequeuing a pooled skb that would later trip
- * skb_over_panic() in skb_put().
- */
-#define MAX_UDP_CHUNK	1460
-#define MAX_SKB_SIZE						\
-	(sizeof(struct ethhdr) +				\
-	 sizeof(struct iphdr) +					\
-	 sizeof(struct udphdr) +				\
-	 MAX_UDP_CHUNK)
-
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
@@ -90,7 +76,6 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
-void refill_skbs(struct netpoll *np);
 void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 7088cf0df43ce..921699e69ac97 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -36,12 +36,6 @@
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
 
-/*
- * We maintain a small pool of fully-sized skbs, to make sure the
- * message gets out even in extreme OOM situations.
- */
-
-#define MAX_SKBS 32
 #define USEC_PER_POLL	50
 
 static unsigned int carrier_timeout = 4;
@@ -213,23 +207,6 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-void refill_skbs(struct netpoll *np)
-{
-	struct sk_buff_head *skb_pool;
-	struct sk_buff *skb;
-
-	skb_pool = &np->skb_pool;
-
-	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
-		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC | __GFP_NOWARN);
-		if (!skb)
-			break;
-
-		skb_queue_tail(skb_pool, skb);
-	}
-}
-EXPORT_SYMBOL_GPL(refill_skbs);
-
 void netpoll_zap_completion_queue(void)
 {
 	unsigned long flags;

-- 
2.53.0-Meta


