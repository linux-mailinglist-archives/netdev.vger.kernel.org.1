Return-Path: <netdev+bounces-306534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yvYUAA7iUGqa7AIAu9opvQ
	(envelope-from <netdev+bounces-306534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:14:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E43B73A9A2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:14:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=bT3E19n3;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306534-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306534-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF05309CE41
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C3426D03;
	Fri, 10 Jul 2026 11:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A21403AF1;
	Fri, 10 Jul 2026 11:54:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684497; cv=none; b=dNY2bHWpzhix9n2VHNjXMdXHHly9B68CYwQT8sxln3ZC8UIErK9OwYqeUhJD3f4x/S40rhwjqTJvdcnkjhu5veSF/sjCGi2dIVZlLpBB/e9pquiUVvOaX1k2uvXvBzvRWDcSjOA78Pgp29eY8TsS8Ar14kGtwB34QM4Zzu+jJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684497; c=relaxed/simple;
	bh=aC7eACdusPQb+kSWaFenb73RQI+wZmB66qZeD+vVINE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZThwrr3oNQn7IRViK/56ezB05YkEXrizuzmOpqPJQbo/MbFhKs0BUKPRhUOGeO1CpSZ58ojoPUBbKQ7Ewiy9Fy/JZ5rr+1p78XmuxlWQlqh+Tcmt3w/+wMYJh+swXaiGfvaXVajiSBt2ijXrACNAMz1gpoyu9Nhq/lEs1DT66oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bT3E19n3; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=5gzFJ/ruyU6gEXu70bKJirk+aMtDB4IeCWRclLWtdtk=; b=bT3E19n37o2GKR9WFBny2i9nvc
	gnKsvmgIw2mXPR26D+A2++GPPd9JMro1Ovcff4mdp3sCCelfvr+owjIju/ypUYlvMAZgSFX4ZADTV
	8f07AFtzDZYFbDfsk6P6KgBwFPLyMzSHG9mV1Miz/zrQfTLTjr7gWNy5gtqgCA0N+4pFZbHXpfMaE
	gz1LlKZzqB0gpGEC4PtY144wLNjlgx0gq69vLd21ltGofjM/195yXd6l/2U2L16nrk2tQaz20aQsI
	7eR8vGM5xy5F5chgZWwf984dHt68ei15KwHlbI/0QBKMfU+IAdv59CDxYeKt/BgSQDm0Bj63s8PTN
	CpfuGNAQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oa-004SZ9-2a;
	Fri, 10 Jul 2026 11:54:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:59 -0700
Subject: [PATCH net-next v3 7/9] netconsole: move skb_pool / refill_wq from
 struct netpoll to netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-7-6f63f76b28bc@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6717; i=leitao@debian.org;
 h=from:subject:message-id; bh=aC7eACdusPQb+kSWaFenb73RQI+wZmB66qZeD+vVINE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jyQbjybjfnR5E4sjfiUAjsqr2kOBZxSrFS
 CaJuG6yIZaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bdTtD/4yPR3OnR1iQ+HYOyOKO7GD1lbfag7IbMiL+RBnGHBUnpoUZS6tp3kdsU+X/ByBNoDoe0p
 mcXhIYS93abPDjvEHLRSrntspGuQvLxBm4dJhRTl/L3z7t8KnaVcZYqCc7jZwJY4qcd8xqIA478
 dW4dMTBWcjq9VNdWDMiyU3/VoKedwpdZYRTDSU6zIgvM5VgXwjnTUc51Bp9C/Qnz7BqCslqwzfS
 6fosfayQf+sHmTzeccE4MthqXiY320qs6b6RQ0PI3uEGLNRGrQjtVsgiDF9EBCvnCkI02hqPPFO
 jysaePakNBLcE8fbg5SnPUizqdI/M0TtCLGNiubP1cVkUPwDHt7IwBh1RWKGEl66sP7QiITrvEp
 +qraMiaePo2xAyp9yqA53cprh46kR5a0DSbusIhAav3JpjBh0QwLxaUeqseCfwzjG+xKZboljUr
 V+RH6utsZgJSHaevDUF4y7Euc3l0uzFhxooeD1kAMnqNdygChTEeJt2OHtZf2J2w2/NP2oVb3pW
 1tF9FE4ZA12mr9exrEz74DlDkAHReu5snP7Xh1Sdn6ZfjOUWCpn4egWe0AJ7qE/0FLE+lBeCSiQ
 kSZ8A5sfJJRxF2ozxm/4/8Kz/pwdyKMtiyaEo0XTLRBINtxog+VWEaaB74D4s0pSFezbJYv9BAP
 hpHWgfgX/gFLnPQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306534-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E43B73A9A2

These two fields back the fallback skb pool that find_skb() uses.
Every helper that touches them lives in netconsole now (refill_skbs,
refill_skbs_work_handler, netconsole_skb_pool_init,
netconsole_skb_pool_flush, find_skb, netcons_skb_pop), so the data
can move alongside its only consumer.

Add skb_pool and refill_wq to struct netconsole_target, drop them
from struct netpoll.

This will save 48-bytes for every netpoll user instance (except
netconsole that will have it in netconsole target struct).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 53 +++++++++++++++++++++++++++---------------------
 include/linux/netpoll.h  |  2 --
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 742723c5a7d46..cf591ae667362 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -183,6 +183,11 @@ enum target_state {
  *		remote_mac	(read-write)
  * @buf:	The buffer used to send the full msg to the network stack
  * @resume_wq:	Workqueue to resume deactivated target
+ * @skb_pool:	Per-target fallback skb pool consulted by find_skb() when
+ *		its GFP_ATOMIC allocation fails. Lifetime brackets a
+ *		successful netpoll_setup() / netpoll_cleanup() pair on @np.
+ * @refill_wq:	Work item that asynchronously tops @skb_pool back up to
+ *		MAX_SKBS after find_skb() drains an entry.
  */
 struct netconsole_target {
 	struct list_head	list;
@@ -208,6 +213,8 @@ struct netconsole_target {
 	 */
 	char			buf[MAX_PRINT_CHUNK + 1];
 	struct work_struct	resume_wq;
+	struct sk_buff_head	skb_pool;
+	struct work_struct	refill_wq;
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -305,13 +312,11 @@ static void netcons_release_dev(struct netconsole_target *nt)
 		memset(&nt->np.dev_name, 0, IFNAMSIZ);
 }
 
-static void refill_skbs(struct netpoll *np)
+static void refill_skbs(struct netconsole_target *nt)
 {
-	struct sk_buff_head *skb_pool;
+	struct sk_buff_head *skb_pool = &nt->skb_pool;
 	struct sk_buff *skb;
 
-	skb_pool = &np->skb_pool;
-
 	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC | __GFP_NOWARN);
 		if (!skb)
@@ -323,10 +328,10 @@ static void refill_skbs(struct netpoll *np)
 
 static void refill_skbs_work_handler(struct work_struct *work)
 {
-	struct netpoll *np =
-		container_of(work, struct netpoll, refill_wq);
+	struct netconsole_target *nt =
+		container_of(work, struct netconsole_target, refill_wq);
 
-	refill_skbs(np);
+	refill_skbs(nt);
 }
 
 /* Seed the per-target skb pool that find_skb() falls back to. The queue
@@ -335,15 +340,13 @@ static void refill_skbs_work_handler(struct work_struct *work)
  */
 static void netconsole_skb_pool_init(struct netconsole_target *nt)
 {
-	refill_skbs(&nt->np);
+	refill_skbs(nt);
 }
 
 static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 {
-	struct netpoll *np = &nt->np;
-
-	cancel_work_sync(&np->refill_wq);
-	skb_queue_purge_reason(&np->skb_pool, SKB_CONSUMED);
+	cancel_work_sync(&nt->refill_wq);
+	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
 /* Attempts to resume logging to a deactivated target. */
@@ -462,8 +465,8 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
 	/* Set up the skb pool primitives once; enabling only refills it. */
-	skb_queue_head_init(&nt->np.skb_pool);
-	INIT_WORK(&nt->np.refill_wq, refill_skbs_work_handler);
+	skb_queue_head_init(&nt->skb_pool);
+	INIT_WORK(&nt->refill_wq, refill_skbs_work_handler);
 
 	return nt;
 }
@@ -1785,7 +1788,7 @@ static struct notifier_block netconsole_netdev_notifier = {
  * pool locks and is therefore not NMI-safe. Skip the refill when called
  * from NMI context; the next non-NMI caller will top the pool back up.
  */
-static struct sk_buff *netcons_skb_pop(struct netpoll *np, int len)
+static struct sk_buff *netcons_skb_pop(struct netconsole_target *nt, int len)
 {
 	struct sk_buff *skb;
 
@@ -1797,19 +1800,21 @@ static struct sk_buff *netcons_skb_pop(struct netpoll *np, int len)
 		if (!in_nmi())
 			net_warn_ratelimited("netconsole: dropping message, requested skb len %d exceeds pool buffer size %zu on %s\n",
 					     len, (size_t)MAX_SKB_SIZE,
-					     np->dev->name);
+					     nt->np.dev->name);
 		return NULL;
 	}
 
-	skb = skb_dequeue(&np->skb_pool);
+	skb = skb_dequeue(&nt->skb_pool);
 	if (!in_nmi())
-		schedule_work(&np->refill_wq);
+		schedule_work(&nt->refill_wq);
 
 	return skb;
 }
 
-static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+static struct sk_buff *find_skb(struct netconsole_target *nt, int len,
+				int reserve)
 {
+	struct netpoll *np = &nt->np;
 	int count = 0;
 	struct sk_buff *skb;
 
@@ -1818,7 +1823,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 
 	skb = alloc_skb(len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!skb)
-		skb = netcons_skb_pop(np, len);
+		skb = netcons_skb_pop(nt, len);
 
 	if (!skb) {
 		if (++count < 10) {
@@ -1940,8 +1945,10 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 	skb->protocol = htons(ETH_P_IPV6);
 }
 
-static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
+			    int len)
 {
+	struct netpoll *np = &nt->np;
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
 
@@ -1956,7 +1963,7 @@ static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
 
-	skb = find_skb(np, total_len + np->dev->needed_tailroom,
+	skb = find_skb(nt, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
 		return -ENOMEM;
@@ -1987,7 +1994,7 @@ static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
  */
 static void send_udp(struct netconsole_target *nt, const char *msg, int len)
 {
-	int result = netpoll_send_udp(&nt->np, msg, len);
+	int result = netpoll_send_udp(nt, msg, len);
 
 	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
 		if (result == NET_XMIT_DROP) {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1216b5c237ce4..f377fdf7839ca 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -37,8 +37,6 @@ struct netpoll {
 	bool ipv6;
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
-	struct sk_buff_head skb_pool;
-	struct work_struct refill_wq;
 };
 
 #define np_info(np, fmt, ...)				\

-- 
2.53.0-Meta


