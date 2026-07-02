Return-Path: <netdev+bounces-304173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+MlOLpYRmomRQsAu9opvQ
	(envelope-from <netdev+bounces-304173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED16F7892
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=fgprgsFy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304173-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3D0830CEE8D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15B480DD5;
	Thu,  2 Jul 2026 12:20:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9D47F2CB;
	Thu,  2 Jul 2026 12:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994855; cv=none; b=WQ5zj214qzfnOp6McE1GMJCJVPBancRwYjtbCrvdNRI/yIWPUZcG4BptyUE/Ps9kq2mLjylnP0khlqE4sdSbQTvq4/csidWFJEzpCZMN0sv06NvtDbd5syLcU8W2YektKSmL2XUAw4PL/7DgPrV8HrPieptqJTlncSWhiXq+91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994855; c=relaxed/simple;
	bh=Ozzed1OMm5oS5ExZ8PO6+TLVaxdHfJUySBs+T5JjN5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dy+9ZiWQ28vC4zQ/0mRljk2Z0t+7w4fDqN0n4o0KnSS9SpXyYDqx32k8F/jsyrkRvgObvkVRuz7LcDZYX67/9p9DPbneU99fcsZ5LDE/JoG/UEwyQLwWUkPor2fay2vyL86vHfQbFeVwHDFE4GHSgXC0NLSQ/a1Bac32ecbubnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fgprgsFy; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=spmpoXH+ljbovXISrtUAddA3ARSpBMXzO4bPvfjwMws=; b=fgprgsFyShUPVl3l+BvGB0kRU0
	FItaOP5CNQpaDbLTEEGFBeJn7tGpt6YLXxf3NQQ1mYzpHb2oSWyHFLFWwLA5xIjDXMHqgcqSWHPXT
	jBtD8a1ivuKr1q1/0nq+eAkqyu//exgsrweI/RWx+z9xN2bnmosyta2k4nRcMDoeTkFxLN4qVq3zV
	Zfw74B6WW/ansvcouyl/PqKMkvcRuEkOZptdnQQozAa8D4GvcSopbvP0tPZ71XJ6iScrmRkHDdB06
	/xl+2Friz+a4HCXDBrhk8ui87yT3DcXMsgmJGk+Ap24xiAClydM7upmhGQhuDoilKUOilL//aVwaO
	qiHSMauQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGPS-008cRC-0V;
	Thu, 02 Jul 2026 12:20:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:50 -0700
Subject: [PATCH net-next v2 6/8] netconsole: move skb_pool / refill_wq from
 struct netpoll to netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-6-1ebedd921dcb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6464; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ozzed1OMm5oS5ExZ8PO6+TLVaxdHfJUySBs+T5JjN5c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFlr28eHM09lL1NLgX8KNBg0VfV2GObagKM
 QOIV3VeCw6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 bWBuD/4lgsArGpyOE1chicbiy00I1MWumn13taxoTKiwF4+emJueZFfaKLtVv4OcAEvLCyYP7Wc
 OUfepgPRvv5YgyFuW5Dbyjk29EigfbJ5riBq9se6/Hluam0ZmcNUrwhiA0odas+7IG5lAKn2sFZ
 2EW/MO1q9wsb+frlo7Qgd/KdC1oM7YNsvg6echC4Z43rOOy7n3ozwpOTp/Q3CXtMMItDeqPdw5T
 ZG1aCEQ6z76D6OlGl2lTF66zJjMk7b8Uiyv1sx6EMjyxiPYC9Q8b1YooNLnZp6bfqX2eCamF+jF
 61V0y7tQb92Mfm6yn0X6gOr7+PBqbdB8KhgAkg53oMCvDw4AOtPTgIfnGVVb1Vc6i/xefL0wktJ
 V9DQPT5ZrRFIET+L8Lq1zZX9m5bMVWmBOFioZ6wI+05Wwg70k85NG7GuzFYQknJkiiYN/tHMlIU
 lAAWaz1VsnaJiB5rrPvvnVHmDPFH7pGOEyMOTlZ+aiGIDEpPsxh8mCuSldUlsFgnhkMEx385adq
 Ii5Rv18RSCU9A7Iy2k0aw5f9PFvIMdSm348BcF9c6ctcTe4fMT0cNA3GWlezxzkLDMcZzUd9JSU
 iCTA3q7UBxT5JOqkSbD3BQFGyjw6XltJcb2xV11e6BtgqFMzOR+eZPLJEwNytRo9UZop9J0XehG
 DXoyag3gI4G/KUA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304173-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54ED16F7892

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
index 3e1b8ece7032e..bfa5fdac9600b 100644
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
 
 /* Initialise the per-target skb pool that find_skb() falls back to and
@@ -335,17 +340,15 @@ static void refill_skbs_work_handler(struct work_struct *work)
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
@@ -1784,7 +1787,7 @@ static struct notifier_block netconsole_netdev_notifier = {
  * pool locks and is therefore not NMI-safe. Skip the refill when called
  * from NMI context; the next non-NMI caller will top the pool back up.
  */
-static struct sk_buff *netcons_skb_pop(struct netpoll *np, int len)
+static struct sk_buff *netcons_skb_pop(struct netconsole_target *nt, int len)
 {
 	struct sk_buff *skb;
 
@@ -1796,19 +1799,21 @@ static struct sk_buff *netcons_skb_pop(struct netpoll *np, int len)
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
 
@@ -1817,7 +1822,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 
 	skb = alloc_skb(len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!skb)
-		skb = netcons_skb_pop(np, len);
+		skb = netcons_skb_pop(nt, len);
 
 	if (!skb) {
 		if (++count < 10) {
@@ -1939,8 +1944,10 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 	skb->protocol = htons(ETH_P_IPV6);
 }
 
-static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
+			    int len)
 {
+	struct netpoll *np = &nt->np;
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
 
@@ -1955,7 +1962,7 @@ static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
 
-	skb = find_skb(np, total_len + np->dev->needed_tailroom,
+	skb = find_skb(nt, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
 		return -ENOMEM;
@@ -1986,7 +1993,7 @@ static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
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


