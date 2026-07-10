Return-Path: <netdev+bounces-306535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRqIKfzdUGpI6gIAu9opvQ
	(envelope-from <netdev+bounces-306535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:56:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026373A776
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=dTUYRift;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306535-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306535-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDD123006B70
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960D426ECA;
	Fri, 10 Jul 2026 11:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4484252B0;
	Fri, 10 Jul 2026 11:54:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684497; cv=none; b=LllKx/JQ48iPaHxaHL53TqbQZkjj0t9VniJhrLWdxuVvfVVK5gYZyQ++bYdVzAptRIKL8SLnSLZf0kBaS5gQU2C0OCn9JBRd9Amvxap78FCf1PB6HSslRo0y3ddIJmkqZtlFRgq9WbZvzcucUD5Vg+ZR8M6SDKkBThzCAwH+VLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684497; c=relaxed/simple;
	bh=3/ZRmDbzw13j5ystvXus39hCB1ikQLsxEO6uQOEYAfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqrQosTc72KGErCf2UglsgrMgc0MVtSg7vHl/L072nb6YQs4UlyepUWUSlgVcGENOra9xU7vYeRHWYMjMgWYU9dT9gpQ/03ir4mZqMs9BYVE1Dqd209y1ZDhivZSxuy+ryaccboAcfH963VmWyvtraHXvyvVGz7ErQHUeiqucWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dTUYRift; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=f6d4lSsdayZmxtgrfMIbeKSILUtKhmCttuplr9w7AZ4=; b=dTUYRiftwIWJQAswy75wyXxp/W
	N9qYTTHRiZ/oUBk3mzuwFJ+fax5cGRSQF1WC+QLrWTL3raNfotgikreEWkF8F79UJTmux9xOfg4+S
	wYAgHm+sVps2ywdXeSQ2uYzZGSMfOyeye5ycG6p7Xaui6baqK7ZPRvTU7ZRAzFE74/ne6wZgZ9xCq
	bCOFNR5fvnQpetQpJK0twwL3kIbwSRD8Rl4jGr0NWR0hUtrIR+rS4d00/86dAF3nbXliyC/l/sL6M
	fl+IIV6s3jJmOjkWbufZ7Ljdf5JN5LscBJts67WYJjdFqNmYvRMJhkJxvUQmdOk7XEBG+p9n2/3LJ
	j8s2oRLg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oW-004SYm-19;
	Fri, 10 Jul 2026 11:54:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:58 -0700
Subject: [PATCH net-next v3 6/9] netconsole: move skb_pool_flush() from
 netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-6-6f63f76b28bc@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=leitao@debian.org;
 h=from:subject:message-id; bh=3/ZRmDbzw13j5ystvXus39hCB1ikQLsxEO6uQOEYAfM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jVcNO5qHdxGeniPu0fTCBkb2QWYEA7/FAp
 7hcRW/qooyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bfDTD/0VYqqR6Weu34ajv/048DM4L6yjMQr+GY+b70Vnmc/QYVWdSnAg7hEy2jitpAkHTYs8dSy
 Y9Enlneo3w9tOO+QeX8SrDuS6XGUVETmBnw/HDBH4j3/RMy3MPrqmHbqd9zsMaxnw7vaFavoJgi
 agmdUO6MQaJPyKeL3b63ORHzpp2TToqnWIhQ7me9Lmly7/t/ELislBUIDnDXYzznX1ReWrEphNo
 BLVVJyjnBrxzT4/p/iNsXj38u0ZfSyJuInwbW95ueYK09ZX1xydVLDjEvSYuWNm+fZGT4XduxlZ
 zHSH2RKtIArB6gWfOKloo/43SS5Zd9Ozx93MTLlk83f5DgNgyloUyBHtzIB7q96stUI9sEAAjk1
 kSAya0X5wyfNhUAys632FJEeQh2Mt1jK4e47b4asxOuXFtinuxaGXhNKT/wSTyI/oZE9EIoEKNI
 2o5zet6pOMF44BvUsTqlFoNcHkq4IlGXOiJNGtLTaRHUftHpn/BVH2EyWTjyFzcO2/B+F3E/X15
 YNcc7jEssDWNBtVWuBfSfvHuFR4Gs3R/rH0+hEX0TxFA9S5xx1yifC9la8JzP6I34n0SV2C16jU
 dVusNuMd3nVCRvV5r37gjaS9hxv+XCu1aXq4PcUQV7p30g/tA/bl5XptRrOeLCAig7/xhIYLCVo
 TN6vDfjFC+FXDug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306535-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6026373A776

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
index efeada762536f..742723c5a7d46 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -340,7 +340,10 @@ static void netconsole_skb_pool_init(struct netconsole_target *nt)
 
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
index 9ca695f64210c..f8da1048ea3ab 100644
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


