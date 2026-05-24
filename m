Return-Path: <netdev+bounces-291208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK0jBMgjE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294D5C30EA
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EE913012BE9
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282273A8749;
	Sun, 24 May 2026 16:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F23A900B
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639155; cv=none; b=l/D1FPjPahPaxcGRI3ek/nKW1lDNRi4Q0QYo7aNw4NYWO5yr+Y0K9dYN0O7Q/afI/WX/SmwF+BWxvpXRiJBbIkEH5ZY7jDEJNaL9uFgb9MwvMM9r/dQuMRQeSMIW8vZc3j5MD2trLZONi9z4OrQoh8m1ohwZJyUTTbCcdthViDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639155; c=relaxed/simple;
	bh=9Io60ANRnBsmyAgRWfG1mFkAHxHn3SG2P8y1eiYREg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKm/LkSUTiT5c8nmZKs/gAho2iH8HlFYeC7HD0VBSywzZoCD8cDdlxs5FEPAtplyh3xNWAmxxxSN61kTw8kGBkzVAD00Eon/23GSEqCed8glx7DJ4EnThPeoFcQdW0ZMOr7HD23SHxNooe/VCjhcvZtR4lJ4ik8FeGotIHqYu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47c35be031dso6156462b6e.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639150; x=1780243950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOCvAbA4VDDlZEPxROsjDedDXmikIirSU/l9zKPktHc=;
        b=MMXkzkUUEBdL1ZARIlfYDrBQ5X6XefQN7NYZYlflpm35mTtN4nEdScGc7CGDYyCGho
         EEvCJw+uY7An1fJ6r0Rznxq5Az/CCst7z3SdMQkyoXERxX9HDrRKNFFn1BjhajJpzEFV
         EzsTepfBkRiwAaRFm8XrKJpzMCHbmZWINl6XRSyx/Ue1n8av5NQXv6ceqQ16iVsardll
         CIueVJkdiFoOZWHGrA0s4UyqgUA1v7ZZGJGoBQbIA3AWLmDGIf+GeEoSC1Zi1XIkSKlI
         1gGQBtUuHyIs44uyNiDdr9tskKn7DU4DZ57nu2aPCVechib8BlEiQxSc9DGtkGHzgiMX
         cKFg==
X-Gm-Message-State: AOJu0Yz8DEecU1ZSlARLSr1crnbeTGCx8Qyzk4D0BOYZRIb5AVk5bG2t
	GSdeaF0KigofY9TgTB4LLe0O3WTonXfnd45mP43SwzG5HWwblVi+hUhQvHYzUQCH
X-Gm-Gg: Acq92OEvKa1ZuoqxRzX7wexCVs/E2hoqR1hu+iJXlKhMLGWDZHHMW/Ae9gcfrEqcUw+
	eYh7ViN0vufueTfDa9jc7B/g1zQbrfK3ELqlYBtCgtm91tztnBQnBx9NM8ZGEEJlYVU5t1xmR+n
	l5njuUharxZYaPh4FMfB178IFK0up+wys+3DIi+p1HTlcqlXuGu8XMi7cERMFpYvmkho2HQys8N
	Ri8JwEWIs8gP5/rzAZcKc30ObJeBzgJuhyVELg/0mLKAaIhbQye+kZ+DSch9joXqtR84NsH6ViK
	d4NZEHYK6uk38Qwl6rRZpTd9mjkrLa9/+1Rav7QgARS1qoM8a6VPKQNAo0n81pO5C0EISgkz9Pr
	pgmNhs+FhUeCG2xCO8gHSZ3Y5umqzrSHgaq7fGpKQcArH4lzUzKvvPBvk3TS3pZKfqUMeZBKCsF
	UMrofDJVNRnzPB/Q==
X-Received: by 2002:a05:6808:c1cb:b0:485:29ad:d19e with SMTP id 5614622812f47-4854a4101c8mr7027942b6e.47.1779639150174;
        Sun, 24 May 2026 09:12:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4855476ab77sm3537709b6e.17.2026.05.24.09.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:22 -0700
Subject: [PATCH 6/9] netconsole: move skb_pool / refill_wq from struct
 netpoll to netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-6-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=5953; i=leitao@debian.org;
 h=from:subject:message-id; bh=9Io60ANRnBsmyAgRWfG1mFkAHxHn3SG2P8y1eiYREg0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlUbp4nQefRCtC5/vbsMc4cAMNs/0r5BwbX
 /S8XQZfT06JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 benfEACE+hT0Yf5LSCZ0h7++UVe8bzUB85RUWo4VvcPTtMprC/g0BIRnG7RDeSX4+pszi/lqSlt
 bB+5jquAksoVTFnCEOoQbJjYrFYaJcPxI8bN2G1lXWK3tUryhMSdLdTEfn3VhiymLj6beXZsFIR
 eS5TeR0jW64qj/lx9wrtsAuznGjbFUvlJCyyy89lHYx/frW2LORvkSP2yq+wkqc0pIc7sgfRXm2
 CFDsNIJ/MQ/th5hwoNzFrzM5Lcmn1VFAlLVwyCti2PRDiqurGooGpQC/Fz5t5P+xeTcQIfDAsJV
 Ez5hC72zEon9+eNRit+c8PWCROVIYRwiR+HHLHg38QTlwYGn4Qz398PPzSKqQ79FZRADBI3seW1
 F3sy63JV2u1zVEdPPtQuP5ZLajmv9jZXIwic3S3VBVtx4OaeeIZvc8JAoSQFU//fJjRFyBjJB3z
 gHqkixZWn9y3UPk5Y+knN5eSmWuMElOKmswD+ww9xAuNs2vwqagdqnQ902/zk8kT593Q0ITsBwO
 +VCCUQaSDrAgkLuzPhPeg3xYwCq5n2bDRREvLc80cneh5CSHF117sym4N/yf49W5frzYkt8Xnhq
 IyCIcvX6+MCFzmRZdRxSkVaoN2vpBzsP6wMNDzAUPmE/rUwdvloEUzpZ6Z7hFRbUnUWD2lhvg+G
 zef7+cvpofPhxLQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291208-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.769];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8294D5C30EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These two fields back the fallback skb pool that find_skb() uses.
Every helper that touches them lives in netconsole now (refill_skbs,
refill_skbs_work_handler, netconsole_skb_pool_init,
netconsole_skb_pool_flush, find_skb), so the data can move alongside
its only consumer.

Add skb_pool and refill_wq to struct netconsole_target, drop them
from struct netpoll, and update the helpers and find_skb() to take
a struct netconsole_target * and reach the pool through nt-> rather
than np->. Thread nt through netpoll_send_udp() so its only caller
in send_udp() can pass nt directly.

struct netpoll shrinks by sizeof(sk_buff_head) + sizeof(work_struct)
for every consumer, including bonding, bridge, team, vlan, macvlan
and dsa, which carried the fields as dead weight.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 47 +++++++++++++++++++++++++++--------------------
 include/linux/netpoll.h  |  2 --
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a8ced60bef7a..b8b1608d09e9 100644
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
@@ -206,6 +211,8 @@ struct netconsole_target {
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
 	struct work_struct	resume_wq;
+	struct sk_buff_head	skb_pool;
+	struct work_struct	refill_wq;
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -296,13 +303,11 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
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
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
@@ -314,10 +319,10 @@ static void refill_skbs(struct netpoll *np)
 
 static void refill_skbs_work_handler(struct work_struct *work)
 {
-	struct netpoll *np =
-		container_of(work, struct netpoll, refill_wq);
+	struct netconsole_target *nt =
+		container_of(work, struct netconsole_target, refill_wq);
 
-	refill_skbs(np);
+	refill_skbs(nt);
 }
 
 /* Initialise the per-target skb pool that find_skb() falls back to and
@@ -326,17 +331,15 @@ static void refill_skbs_work_handler(struct work_struct *work)
  */
 static void netconsole_skb_pool_init(struct netconsole_target *nt)
 {
-	skb_queue_head_init(&nt->np.skb_pool);
-	INIT_WORK(&nt->np.refill_wq, refill_skbs_work_handler);
-	refill_skbs(&nt->np);
+	skb_queue_head_init(&nt->skb_pool);
+	INIT_WORK(&nt->refill_wq, refill_skbs_work_handler);
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
@@ -1731,8 +1734,10 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
-static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+static struct sk_buff *find_skb(struct netconsole_target *nt, int len,
+				int reserve)
 {
+	struct netpoll *np = &nt->np;
 	int count = 0;
 	struct sk_buff *skb;
 
@@ -1741,8 +1746,8 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
+		skb = skb_dequeue(&nt->skb_pool);
+		schedule_work(&nt->refill_wq);
 	}
 
 	if (!skb) {
@@ -1865,8 +1870,10 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 	skb->protocol = htons(ETH_P_IPV6);
 }
 
-static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
+			    int len)
 {
+	struct netpoll *np = &nt->np;
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
 
@@ -1881,7 +1888,7 @@ static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
 
-	skb = find_skb(np, total_len + np->dev->needed_tailroom,
+	skb = find_skb(nt, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
 		return -ENOMEM;
@@ -1912,7 +1919,7 @@ static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
  */
 static void send_udp(struct netconsole_target *nt, const char *msg, int len)
 {
-	int result = netpoll_send_udp(&nt->np, msg, len);
+	int result = netpoll_send_udp(nt, msg, len);
 
 	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
 		if (result == NET_XMIT_DROP) {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index e4b8f1f91e54..8344454df05d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -35,8 +35,6 @@ struct netpoll {
 	bool ipv6;
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
-	struct sk_buff_head skb_pool;
-	struct work_struct refill_wq;
 };
 
 #define np_info(np, fmt, ...)				\

-- 
2.54.0


