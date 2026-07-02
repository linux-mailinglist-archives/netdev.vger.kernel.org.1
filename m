Return-Path: <netdev+bounces-304167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uuFLMHRaRmroRQsAu9opvQ
	(envelope-from <netdev+bounces-304167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE86F7A59
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:32:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=BqpPb2OC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304167-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 898573004411
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C347DD47;
	Thu,  2 Jul 2026 12:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC647DD63;
	Thu,  2 Jul 2026 12:20:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994837; cv=none; b=QJXmX84TLFWCmNa6ym0RsXbCHR4jRshGbprsl/FJNzu9DGQBfQMmnVU8nYc1OIIC6/IFh7qdZX8mLCxoQZ/0x0yj0kMt6In2yL9ZM4JhBzXeGyfwbIgUaL1UNZVVd8pZz9pooQd9zXb0eLk1vH8WIT/U5MjgzMgSOwt+Njzl2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994837; c=relaxed/simple;
	bh=iTRaxikl2RbANeTRC5I32miHHan/0F8c8KI0ulCWjv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiKq8XT9zpVpV8ldLfRJFgW6dP4rywuo4F3fpz8q0+aQ41kJdWBjdssoQsM5c6A/HcvCwNCd7XXXerGNU+0ZjiDl2JnZkZn0NOElahsBMuVEz/nGMvYXzSvP5OLgf+qN+4SkBscm3kIfG5TWodQNyNj+wuSgEY9/lnyLi6aSi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BqpPb2OC; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=5rwf4I8Zdv0hrfv06i4HlqDFemomtqfmzX5kva2cj7Q=; b=BqpPb2OCb6icMJWDrqCpDvN44a
	Wc1WS3H5Ep2YoukW6Z9YP0u3lJjp+8tbXTkG7tmSqH27fRYyq8EPrXoR3kf3yYqOow+vz8vZzOzZG
	1eWcfqM+INIX6Jp9GnTVfhIYmT5fY/MS3vANbcKHWiJPC7HInK7c3J8PGA3I50HTYtB5/H/yNejd9
	iJ/eeUmyI4GtT9uMh3dguPaliRaGRhfgFmXxI0CCh8XIrhl6ghKAKnNZBs7R6ACBKUxgVcYivjZWf
	pP4ANVio7XfhqcomJ4Gwe2QLC59MO+fuPuUPJ4RBwZjeZYN2CKRbtE+jjJdsBTCnwQjUGjHZ8rPD4
	0VtxusZQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGP8-008cQG-0s;
	Thu, 02 Jul 2026 12:20:30 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:19:45 -0700
Subject: [PATCH net-next v2 1/8] netpoll: export refill_skbs(),
 refill_skbs_work_handler(), skb_pool_flush()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-netconsole_move_more-v2-1-1ebedd921dcb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; i=leitao@debian.org;
 h=from:subject:message-id; bh=iTRaxikl2RbANeTRC5I32miHHan/0F8c8KI0ulCWjv0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFvjCFhxmsmpiEJYyt0NaxziEsmnddp0yn8
 YYk0jW7ziaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 bcUcD/4jX8b33d8vH4k5+1WO9J7F4pzfuS2PX7aDHXFolWhNWelrp6qjzSPXZ1UdUqCzguaGisb
 zgTzFHYaCTfKgfk9ODQgb4S1J3gcbvO8qSHYAgChOZzDuyVWlNJ6xi+5r2uEVugzLrgnC3osgm5
 CsL6hRKOSFRhTpJEiE2fII/eGyLoSL0s8r7iLXuMUWIEglziCBl3KyIf38db9dwDlUXbn24Kud6
 ABCR81jG1GJFr3Pve/8IYKvOP2Qxm3SLDX5kuBY1G0MUG1aRXm0OPBpdXYXOBHJfujH6/jMNpjZ
 G3mc9ntkW/+pKeKGgd911/5WsHdeNPYKgjjfnMswI8zyODp5YjxYMhfqPP5w2RRyJ7l0Dv8HV9K
 UcxvLIhmDl6G+MuzRoBqOIYrxQBWgP46Ro0x2KL7u9gRczuVLMhmyvCh5LGFNKsQmYF4+6DLMUC
 5ChzdyMmCHcAdooE4/VdcPkD2oRas5JiN39Y6+FlN1VI4Xx/bDekfvDOJaBecENs1Ew+QfqBcdq
 Q4HlgmUubdT0i9Spglr4g3/FfVPamaXzNJmRZxakaNPsAB+QyJUrTNjczwRqBn/8CLtHi6ekvrm
 lvklQayrRdhSBy5ciiwdIjVbGqHB4KKlnofk+xr9jqPfg+wrjxZAbGXpGRfKaTQEl5z8iK9QJyS
 jsF8VjshGUSqmkg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7FE86F7A59

These three helpers manage the per-netpoll fallback skb pool. They
are file-static today because all of their callers live in
net/core/netpoll.c. Subsequent patches relocate the pool's owner
from struct netpoll to the only consumer that actually uses it
(netconsole), and that work needs netconsole to drive the helpers
directly while the function bodies still live here.

Drop static, add prototypes in <linux/netpoll.h>, and
EXPORT_SYMBOL_GPL() each. No behaviour change.

The exports are transitional. Each helper is moved into
drivers/net/netconsole.c later in this series, and at that point
its EXPORT_SYMBOL_GPL() and prototype are dropped. By the end of
the series no symbol introduced here remains exported.

The goal of this patch is to make the subsequente patches easy to
review.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 3 +++
 net/core/netpoll.c      | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 88f7daa8560e5..a7b96e1792207 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -90,6 +90,9 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
+void refill_skbs(struct netpoll *np);
+void refill_skbs_work_handler(struct work_struct *work);
+void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 85aa513508811..d990bfdfbad4d 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -213,7 +213,7 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-static void refill_skbs(struct netpoll *np)
+void refill_skbs(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
 	struct sk_buff *skb;
@@ -228,6 +228,7 @@ static void refill_skbs(struct netpoll *np)
 		skb_queue_tail(skb_pool, skb);
 	}
 }
+EXPORT_SYMBOL_GPL(refill_skbs);
 
 void netpoll_zap_completion_queue(void)
 {
@@ -351,7 +352,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-static void skb_pool_flush(struct netpoll *np)
+void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
 
@@ -359,14 +360,16 @@ static void skb_pool_flush(struct netpoll *np)
 	skb_pool = &np->skb_pool;
 	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
 }
+EXPORT_SYMBOL_GPL(skb_pool_flush);
 
-static void refill_skbs_work_handler(struct work_struct *work)
+void refill_skbs_work_handler(struct work_struct *work)
 {
 	struct netpoll *np =
 		container_of(work, struct netpoll, refill_wq);
 
 	refill_skbs(np);
 }
+EXPORT_SYMBOL_GPL(refill_skbs_work_handler);
 
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {

-- 
2.53.0-Meta


