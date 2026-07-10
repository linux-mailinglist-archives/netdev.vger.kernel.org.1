Return-Path: <netdev+bounces-306533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QbUJOebdUGpB6gIAu9opvQ
	(envelope-from <netdev+bounces-306533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64573A769
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:56:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=fM4U84j9;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306533-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306533-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D0DF3008D08
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB03425CF2;
	Fri, 10 Jul 2026 11:54:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08607404BCF;
	Fri, 10 Jul 2026 11:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684488; cv=none; b=czfxBJhzB3gTMo8o94/WHVw0325pfgVduQgffU+TDuxmXi7i1QV1yPpKCONLj6FjlI5MYEoWFb0c1Jxb6ILlNNOWcLt+DtZ3MhmJdpnaJTZVb/a1cLpYM9Y7BHORdp5J8dBFg4Vcj5dfhqqE0DEVq5Fn3mtWVKqHkZ0WjF3NGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684488; c=relaxed/simple;
	bh=ZEgIcPdaWEgHrbKJSPKouaH5QfTQzMUuCJVnz1gCezM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIwWrRVV+TN1cf7IglC0WEhVChnNm10v2+uqIuaHjQ1OVq7ybL2htQdBUAfXG4K2Y8PrN6Aeu+xbGK0BL8lMUcnfF0yU1lEss/Qhwafx0m23/8slEU4yMepXOz0+ZLwx0IsU4DLSbabTd5TqY30k/NXxcP1tlZLTXpCHEMe3tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fM4U84j9; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=smbJfo7MCQ/ziPYnih21ss1uOV4RRcSAkaEBgiLxeBg=; b=fM4U84j9Pjbe1ciGdU3Iq5NZqp
	CchVTagtqJaa5UxrEW0jJVRpINCdxy6OOqTZxI86r0reug2CcHVBmjrOj0DQXQlaUXpAjb5Zv1Vld
	4FNNV9ceASrpkVLTI6tCXJfSp+B1TOBTFDynNsJPeaQ93rfld+YCmz/Sap2X6eqH7kFCyQIimjPoq
	7Bmxw9VsewldfFD/sqVM6Sqw77UTVTnuspCeKRV7m+OYw2+S8QmU/STPE0E9fezTw9/eYiUion3jb
	mRQb654jFmr7hdmsWj8A1hXwYXL6yy6z9vuYZ96GbfPvwEXgXaaAGpSYYtiAVKYHoHqmANjYr9rze
	Qc5xN/SQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oS-004SYb-1K;
	Fri, 10 Jul 2026 11:54:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:57 -0700
Subject: [PATCH net-next v3 5/9] netconsole: move refill_skbs() and
 skb-pool sizing macros from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-5-6f63f76b28bc@debian.org>
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4632; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZEgIcPdaWEgHrbKJSPKouaH5QfTQzMUuCJVnz1gCezM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jKNRNrE0bgKQT/s+J7F9NNDsM+/WFMxdzz
 v019OC/QI+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bdhrEACrWKVRpkN8gZJAoezNjyx8RmqYSYzsIgxbDPSrXyyute8EsblEtvFR9u9OtBlYkoExh2N
 ktXVg/KL5fHc1x9JUxEFmZKCj8E5RZtYJouJqat0OjT3dLqKne4nqjedZFXeM8wO+mpZNov9izv
 swts2pm6ukjCip6R6CyAbJgcJTIREqI8EnLpYMZnXJNxCXezTbLlxP5e6c3jUiBf6XYWlepZfD7
 aSnyWKlVKF4prOCOy3e0rs6SkvVB6ijeOH4YME17KbIXkR4h/rIjUH24z0gqlSVXyt0kj90pHv/
 6gIQuP0TRpW3E6WU9SUMx8Xa66mMPlmL9fmo7TVMOpupGUz4kVlpZ7CVM6kQTSjUVlEnsrzWXhZ
 CyXqlE+CDT5JCXdTZSeZTzNjtcC2/tUiZQf8jClSKHEpaIU8O8yhTbepaqjWATr0z/1E53d9hQC
 s2+dNnYFn6EBhZ1fNspYbMl7Mq5GQFC3TXgWhF9fZuvx39Yg3N3zP0OYp8xVWdgu/kr+7iwAbLu
 j91wf38F8ivolJqJ8ivzuSfW8EVb4nc35I5+qHvvBluAURZRaO8wDUWq9vK+HO/mvcM3yfo8cu7
 nq3JqYp4O26S7k2bj6GnaqSooNl5NyQQXzkWc83c4nBVrUOjqr0QnYJheNILzb5nNFLfc1qXiPo
 Nmy5puOOLla5wrg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306533-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA64573A769

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
index 96d9a47312cd7..efeada762536f 100644
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
index 93a16faf808c8..9ca695f64210c 100644
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


