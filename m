Return-Path: <netdev+bounces-287089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCXXAXYGA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:52:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D551EE45
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137FD3054CC9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770724C77D0;
	Tue, 12 May 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ua+MAGPr"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5504C77CE;
	Tue, 12 May 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582939; cv=none; b=GyzPwgj3UqxB13ca36w2SERNyiiFX2sEUJdsCiTa8gaSuJdvUlE9nEev+13UEEXbikEAeFbE3KTbeJMgdi/No4NvU2XX8BzbTZuNe29XsqP0Yx0Rz4ubpS7hbCMtoAkQxX8ynRSXCvyh+v5SvAE5S6dXNWeYgNF4rMUlAJCwi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582939; c=relaxed/simple;
	bh=5rvLrUfVlAc9YY6CTOwDMsWJsP8QYsUXdm5THTFk/bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8URz9xXZh1R2Tob9Wj8SqG8V9viHSQRIzBWoHl9WNy5/8Hdu8d4NcetERqD10/zBPYqWGl3o0kS4rQlMTZYMaOodVoqjCyiTU39fUZiQCGS17gTIttotzArMKzc75NUDKwzFvwAiJ6pdPTILYyQqPuYd6j9c1uOfOllUOimn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ua+MAGPr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=kt/HkCI3dMRdzBCOx4Mnncl2c/BCOwyYQvNx7VAiknA=; b=ua+MAGPrWDir47R6YXtcnaZqW8
	nGMeAySBt2Z3ji95obNDtlYuzyxo+U752NivvePNKTyHgBczutHbBCln3pfxIytSDck5PB1UkP3ZV
	/wG4PerSCHfaIqvoL32Kzm+GfbD+oHu1fUAAYw6J3+dSRYmy/gwJY1ytCXcbado15vhAArQHPm4LV
	oFI/mwthUMzACNDmyqpI3SlkE2PY0J3R2jq4oUHcp2i8WL7hUYvOWqVcnVqo7/ju4OPYlj+Oepi0T
	EaeVpCqWUOIAv+F+YwMtmcXEp42TMTbHDD/w0NO/SN/6c8o6gBSYd9AOVEP8Dfl4cSMfz5ocP1Zbd
	awbN5Jng==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkfV-002K6n-0O;
	Tue, 12 May 2026 10:48:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:41 -0700
Subject: [PATCH net-next v2 8/9] netpoll: rename and export
 netpoll_zap_completion_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-8-1191d14ad66d@debian.org>
References: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
In-Reply-To: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=leitao@debian.org;
 h=from:subject:message-id; bh=5rvLrUfVlAc9YY6CTOwDMsWJsP8QYsUXdm5THTFk/bc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrVTkxup0d0pkrEhAA5A+RzkCqUBfzXBvfb
 g10Bh/Lh0iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bbh3D/9BG+EbI4AT1fO+gQlw0iNgFZRxQPuZSUZscGWLeIt/S1iVgs8/CzWHEF3HpORKr33FWMO
 XW5rluyMOmNUHqW4MuFrc4jjnPk/zNXgQ5/OJ1oHhmwb+7PIcnep6Qnxo/dIrIIDvetfZV23giP
 oAsB38RqpX89sx7yg7xs5CEq9lVhkuJ4e3YKoWwqkV1sOr7ghaHYSR69HTk42GNJcfxe4B+9qZT
 cUKkBBzkr6/z80swpkC+Sy7Qj9fbFtFRCgk/b++CDHrzzG2zK1Dp5XUgofqHB+q5df+wkuSf1lj
 bU8KUORFxEzNWGZAjKGy6xjLuvvYKSXI6Rhuuz1MnJ8cJCnVTTYKi7B5V/c7uNrAbpyNH8DOsuv
 YtIlQIHvWa8117HAav7LjEy6CLad+KZPxnR3DexRxmR7VG+39h4zpBnEg2sLwnyY+bhvgDXOjfX
 Cdyb/6L4jrVqhQR697EiF09n5cPTtoA0oD35PUctsgdI9ZEksV/AEqD7U2oVyqIjcu7QeDj9/Ci
 ZN35blcudZ0+F+dryye7E/gH9s0u5BkzugPg8+Lz6zwDXInkHmxpuhIqvqAvUWvsOvnXysBgei2
 8kz+31459FrAzLBVr+zaq2nI99S6TAYLYTBR9s56p5o7dAI/aKUYGhVR5LJI2f1MHj88vBmr8Ty
 Ejj4QmyiE+lx23w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 976D551EE45
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287089-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

zap_completion_queue() drains the per-CPU softnet completion queue.
Rename it with the netpoll_ prefix shared by the rest of the
subsystem's public API, and promote it from file-static to
EXPORT_SYMBOL_NS_GPL in the NETDEV_INTERNAL namespace so the upcoming
netconsole-side find_skb() can call it once the function moves out.
A forward declaration is added to include/linux/netpoll.h, and the
old file-static forward declaration is dropped.

No functional change.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 1 +
 net/core/netpoll.c      | 9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1877d42ccbccf..f986f7486cb8c 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,6 +74,7 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
+void netpoll_zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c148b3b68cec9..e4cda0aa4d488 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -51,8 +51,6 @@
 	 sizeof(struct udphdr) +					\
 	 MAX_UDP_CHUNK)
 
-static void zap_completion_queue(void);
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
@@ -199,7 +197,7 @@ void netpoll_poll_dev(struct net_device *dev)
 
 	up(&ni->dev_lock);
 
-	zap_completion_queue();
+	netpoll_zap_completion_queue();
 }
 EXPORT_SYMBOL(netpoll_poll_dev);
 
@@ -238,7 +236,7 @@ static void refill_skbs(struct netpoll *np)
 	}
 }
 
-static void zap_completion_queue(void)
+void netpoll_zap_completion_queue(void)
 {
 	unsigned long flags;
 	struct softnet_data *sd = &get_cpu_var(softnet_data);
@@ -265,13 +263,14 @@ static void zap_completion_queue(void)
 
 	put_cpu_var(softnet_data);
 }
+EXPORT_SYMBOL_NS_GPL(netpoll_zap_completion_queue, "NETDEV_INTERNAL");
 
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
 	struct sk_buff *skb;
 
-	zap_completion_queue();
+	netpoll_zap_completion_queue();
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);

-- 
2.53.0-Meta


