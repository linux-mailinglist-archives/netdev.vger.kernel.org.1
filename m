Return-Path: <netdev+bounces-304172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pl1VEsNYRmopRQsAu9opvQ
	(envelope-from <netdev+bounces-304172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988A6F7895
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=te67xh8f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304172-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304172-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86315308E682
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB9480DFA;
	Thu,  2 Jul 2026 12:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF867480DD5;
	Thu,  2 Jul 2026 12:20:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994851; cv=none; b=PYrRi88wtkua2opH5XSbadG8LRrMLeor2vWtli2PM07vF7Ds5UeUkX+T3JlnB6A6oWWQxWhngI8Bhh33xVRDgvi0GqVN63JJ8N9uJUa0ctJKU0wwN9Fqt5PFLepht6Lw5XphP6haitw5Ox1iHL5StQkX52Qn2UQKcrNqVhjboR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994851; c=relaxed/simple;
	bh=2yu2W4DY9FiEga1wFCciIxRVEKNiQDjmtwCM4rXMGfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxLGwgPx0U2PXhGiwpoghMbWWshuRoQ38TyXUQpcGGJ6WamXpullqvxonJ5j/umoAh8jWyYXnMm6F4yqOnsAS6qva9rzIto7QnHN+qVfcTTrnfxpUyyjKYZGiceDY5+MJIiXa7nBEoooRQiO6WStQHR9IY3L17WcuFuAXB7f29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=te67xh8f; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=8z9linYe8JJM49tkVWMnTWpVNUypxR9HIyvmYXniojI=; b=te67xh8fO3rr7geOSzYHkFSjAL
	e51Xc7kYyhv1yu5m+5kC1U83177TdYv5w44IHNaXpGxpAh2yKLuxHjT+eUxlO37PyamBV7XJ4p8TK
	23oXbbGVfuRrOd1+RAMTMbJ+9oOw7op+7AEomk7BaG+FhqK1YiRs3iTBz5pQqlo2IfQgj8dr/lsEP
	Y7ltwdSAGkfqyoOYVZ0inEWvirtGAmvhEn7lIncAgzyLX/JjsIYbCr7l9G8aKKzVyzASWpAslVU6o
	xClTWIDWlCchSfPaf9DsnA4uOwHl4S0fJRriF1vfVpNESFzQMiMfMEf8mkNF65NCJehj+3fPzRFAD
	LE5wEZew==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGPO-008cR1-0q;
	Thu, 02 Jul 2026 12:20:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:49 -0700
Subject: [PATCH net-next v2 5/8] netconsole: move skb_pool_flush() from
 netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-5-1ebedd921dcb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=leitao@debian.org;
 h=from:subject:message-id; bh=2yu2W4DY9FiEga1wFCciIxRVEKNiQDjmtwCM4rXMGfM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFNm3U2TU8PNQgsmRLUi0/57lAoqNToZNy6
 GO7nAknAc+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 baFSD/wObja9SzbBUw5ibrcPs4Q5KlputSRgVoJNgY7879DWnpfcpwHEb1UuaqK6r7J9zUabGYx
 e4kG+rIR2mRmF5FwzX4wlYUGQltk78mCYbzUiYLB3rjW73OT8Q9iqf22ik9wXh0HofZlX9Cz30Z
 mS1mPqQY133APrrfnuxQs8fUfB73SjnHklsJfUrLw+eqBSLg83pO3aINrC8DAj/Ijf5mQhfY9qb
 3DLtXJB/3OzcsU5htVY2ZNhmGhRfCdD4kasmmzNXZUhhTx6NqRzuDNELfm9bGJIhjSo3DivzojY
 hUz54ztCyGQXq16Q37MPAPDvstkai9qeMsiiObJDnjXNGvhFeI+uNs6CxSNce6YjW+xUp/tOxfi
 2d9EDktNXVFSBlxDSvvctEkb7rciKg9/5SOXSWEjrFgEcKVwZGyHYAyS3CTPdsyJk7s81QLpc3Y
 swT9SBY30wnHu2y3ZSn+AD/KBrsYAEA6Mt7K5+zbI19C4PHrQMnmgdSTynX27E4j7lNOLYXa+E0
 BswEBGwn7OpNl1H3l9qde5z0gqu6+jUDt7dBTnDp/QrcmisqbREYrl6pR9ny551vDJToC5MD7pc
 2Bb2j5SJ7KTqmrWSEiLA/ZTtkK2VPotSzIp1VQv/Otg6sDmm7kfpt9EhzD4erq3vfkS0MqBJiIv
 hIvh3KGYvb6kJqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304172-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2988A6F7895

skb_pool_flush() has no callers left in net/core/netpoll.c after
netconsole took over the pool lifecycle. Inline its body into
netconsole_skb_pool_flush() (the only caller) and drop the function
and its export from netpoll. The prototype goes from
<linux/netpoll.h>.

Pure code motion: cancel_work_sync() + skb_queue_purge_reason()
semantics are unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c |  5 ++++-
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 10 ----------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 6bb8184d023a3..3e1b8ece7032e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -342,7 +342,10 @@ static void netconsole_skb_pool_init(struct netconsole_target *nt)
 
 static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 {
-	skb_pool_flush(&nt->np);
+	struct netpoll *np = &nt->np;
+
+	cancel_work_sync(&np->refill_wq);
+	skb_queue_purge_reason(&np->skb_pool, SKB_CONSUMED);
 }
 
 /* Attempts to resume logging to a deactivated target. */
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 7e2fbce863e9b..1216b5c237ce4 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -76,7 +76,6 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
-void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 921699e69ac97..10b6063251a5b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -329,16 +329,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void skb_pool_flush(struct netpoll *np)
-{
-	struct sk_buff_head *skb_pool;
-
-	cancel_work_sync(&np->refill_wq);
-	skb_pool = &np->skb_pool;
-	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
-}
-EXPORT_SYMBOL_GPL(skb_pool_flush);
-
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;

-- 
2.53.0-Meta


