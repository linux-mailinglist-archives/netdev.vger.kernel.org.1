Return-Path: <netdev+bounces-306530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1BSCLnXfUGqf6gIAu9opvQ
	(envelope-from <netdev+bounces-306530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:03:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0DC73A7E7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:03:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=ZWK5rQem;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306530-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306530-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B999306105B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E863B83F0;
	Fri, 10 Jul 2026 11:54:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F163B637A;
	Fri, 10 Jul 2026 11:54:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684473; cv=none; b=svJnSAvVgg670c9QjjhfsUOZ0jiuSYLZPNp4YBQ73CYuIVZHMxmSpy0BAO0rwgT2J8bdpOVXV/Rgsvue6OR2zEbDGT3Uco7kSurPKHssjSSC3axhvY94yRcdaeOWFwZLrpxf1jRSUx/k3ZkT9P63w40GRuy3OWz8sBFbeJomhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684473; c=relaxed/simple;
	bh=29kW4YIq6TQb7vg5agUdfyguq5Y2tRhUDP/DCvJRiEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXGLBkeku3Ioahx3qENVa1CjedMJXjf/5V9+eKFkmm9l1xt9CEmkLxrxY2IkM+SNRnpp0b2RgyMOYhWbhuWhj5byFMVYKjY9XFeX418TIJDk3vAkeHuMRgXVMn/AGLrzk0g9BcLiYZDLi6Xh21d0hw6IByLPz9w1mxIhtJRre7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZWK5rQem; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Bb4k9fj+CQPxPNk3uVIQ70vd+fl8m/Jh3dhoWRdsJzk=; b=ZWK5rQem4PXZXxWXhwG0SNgW7q
	tdm3Xgs116/+NdfvmwErWPOoRoYl7/PRIjm/bNn5G+sspbM3kfIetqnO9j+8fOexg/AfU7TpMT2Dv
	bJS5Hd/dwEeVoUqg7OSlJzteRxuDm1Y9+3CEUVls1aHZMRlAQw/5NDzcEukL/TmKPZsF/0kW3h8TU
	WMjZ7wV1LUv/OkKPolrEDoMO7nxv32IYozLGulO0bnu046nGxgOXRY10bCuPzluFRvFIqWaBBNFjb
	JjF809H/dd00Bx9Susz5RndpHMiwgGQJ1Qs/p3KFezUTtj6GQF4IfibhxERy0cLc8MJ+RxrqGCk11
	uy9qTDVw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oG-004SXb-0I;
	Fri, 10 Jul 2026 11:54:24 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:54 -0700
Subject: [PATCH net-next v3 2/9] netpoll: export refill_skbs(),
 refill_skbs_work_handler(), skb_pool_flush()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-2-6f63f76b28bc@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; i=leitao@debian.org;
 h=from:subject:message-id; bh=29kW4YIq6TQb7vg5agUdfyguq5Y2tRhUDP/DCvJRiEs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jUG+nwe4abIHIX4dub8UQRP2RO4sFEeY2U
 3h/HIgNUUSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bbfoEACiicRTVIbosJvg08G9Va9Wt7KYiltJMzxoeOHOOpQ5GsrwafvgC+TLsnw0aWTcw2zU87Q
 iMXZOqwNCSLJzHc0HHd6/Dip82F0AEQRSLUzXgZJ36n/NB4t4DEDcJRFsZ9fQVI7suuc1iddm4y
 QKSXusDW3MXI6zQojWWztdT96QEbzy9ZumD4p3VboeUKIVtSQW7IW1n7ocd2lQcimBEgnB5TNB4
 A2nz3vfqobosSBeLjrLR19cIAmEvkiKTnJoRJ0FEGYIbWmgB6B3adxcpc2CanEAgS9YIzoxJNfM
 HwHsukF6D+u88xeaiCGqADGCpcvXngtCFZ09NgL3JuPVIdQf+3OZP9x5I41JD/LuSzCsSXayiwq
 JAchQqRpkSGpwxxjBb7HpY7yhAubEqYNsWo/mA681JUEhIpl9rtie+Qn3+hVp2wfTJ9VFpIAn7V
 Gjq0rDXAYohbUihwxT209BK8XIXQ+x0EMxsnP/YPS3bC2VKJgzMzxhG1Wuaq2WnpHFj+iYVIA8A
 5xy17H8qyogJc64IeMUq9ajtugqICBGHrlQju6rcfgBZQ0uQvw3vIRt9nTb8qW0MAyCVAYov4g9
 sXXI1feLzZULpNnXK4+i7pfJ26ZkB8UxoSCD5kdrySURmRhy2VItv4eD/x7xFityUZuPHIG7zXz
 GfmCPy6uLwaxiVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306530-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B0DC73A7E7

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
index aed415d3cd74f..e062d88d10a37 100644
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


