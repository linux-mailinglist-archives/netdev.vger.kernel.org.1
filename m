Return-Path: <netdev+bounces-303152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nqImKVG4Q2oDfwoAu9opvQ
	(envelope-from <netdev+bounces-303152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:36:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A106E43A3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:36:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=Zap0J3Sk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303152-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303152-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6167305B121
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9440C5D4;
	Tue, 30 Jun 2026 12:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2C3C0601;
	Tue, 30 Jun 2026 12:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822817; cv=none; b=fDeWSH1dQVLUlhF/Ztisu8axyL895crLlBegQEQ9hSvaRnfJ0RahrxlhOWVqaS7MnQfjmxzBbb2drGwa+dzfEZ9S8P2RSIRggKRiH+L+kfFiq+mp64sDB1CT6lqhm2Ln9StkgBQi4f/YHTP3yB5MI7MxrXlUfoAj/v52nVCFdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822817; c=relaxed/simple;
	bh=4xirhVk5rd8/OzP9pdd2shYjtS5a4xImDIcuYYJF2Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnduUfV9ASEA1PfGRsTzPC6X/JU2kYEldzULvGGKqqQrVRmS4vmgdWqLyRE8bT6ehDiNZcBdOLua6GdaSt9jUA5gBGa1Pcx9sxmz7gYisUlp5wOkY8eyYETOq+RMjlvg796j+5ZgdQxS3xiLJHXB05L72l2vK6c58FPTUtSCYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Zap0J3Sk; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2J9NdtPZSW7EAYePRVcww4LdPHj6ztJIcm0YUUfpipA=; b=Zap0J3Sk6BNCenXOIOmJ94o1Ts
	pESa6lvFsPdjC+Ji9+Jz2qBLzMbWORgfnwxzJY7qH88QvLiR+LfGKtW92YzttfjFmIvWiY3od+Rar
	NqRbNQsk88QobSOux+5V3Wwn+ihSDLTY9g0gXsZ3MMqd2cVYF7sRaY5KyDLRYair199lEPH4ZxR9j
	kLGrcurG//6GYdrLYqsYaxA57XMMA6U0O3gCJL8DP14pMVzmkKUKRIbYhVXzqMBcVFm/D4UA/ind/
	tbRb+fnVyiI622+2oOLiVFOJGcSfD72Ey0mlQXIg8JEVSQd+mpLkbVXh/7tKKX3QAJl5vbOTe5mIX
	MbBEXOFA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1weXee-000NcR-2z;
	Tue, 30 Jun 2026 14:33:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	jhs@mojatatu.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 1/3] bpf: Reject redirect helpers without a bpf_net_context
Date: Tue, 30 Jun 2026 14:33:29 +0200
Message-ID: <20260630123331.186840-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630123331.186840-1-daniel@iogearbox.net>
References: <20260630123331.186840-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28046/Mon Jun 29 08:27:20 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,mojatatu.com,linutronix.de,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303152-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32A106E43A3

The bpf_redirect*() helpers and skb_do_redirect() obtain the per-task
bpf_redirect_info via bpf_net_ctx_get_ri(), which dereferences the
current->bpf_net_context unconditionally. That context is established
on the paths that run tc BPF such as sch_handle_{ingress,egress}(),
*except* for the case where {cls,act}_bpf was attached to a proper
qdisc. A program running from there reaches the NULL deref in two ways:

* It calls bpf_redirect() directly, which dereferences the context at
  the top of the helper:

     tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
        avpkt 1000 burst 100 qevent early_drop block 10
     tc filter add block 10 pref 1 bpf obj redirect.o

* It simply returns TC_ACT_REDIRECT without helper call: tcf_qevent_handle()
  then dispatches to skb_do_redirect(), which dereferences the context

Rather than extending bpf_net_context management into the qdisc path,
make the redirect helpers refuse to operate when no context exists, and
have tcf_qevent_handle() drop a TC_ACT_REDIRECT verdict instead of
calling skb_do_redirect(). Previous behaviour was a crash, so nothing
regresses by not supporting it.

Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/filter.c   | 17 +++++++++++------
 net/sched/cls_api.c |  6 ++----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..11bb0d236822 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2552,11 +2552,13 @@ int skb_do_redirect(struct sk_buff *skb)
 
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
+	struct bpf_redirect_info *ri;
 
-	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
+	if (unlikely(!bpf_net_ctx_get() ||
+		     (flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL))))
 		return TC_ACT_SHOT;
 
+	ri = bpf_net_ctx_get_ri();
 	ri->flags = flags;
 	ri->tgt_index = ifindex;
 
@@ -2573,11 +2575,12 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
+	struct bpf_redirect_info *ri;
 
-	if (unlikely(flags))
+	if (unlikely(!bpf_net_ctx_get() || flags))
 		return TC_ACT_SHOT;
 
+	ri = bpf_net_ctx_get_ri();
 	ri->flags = BPF_F_PEER;
 	ri->tgt_index = ifindex;
 
@@ -2595,11 +2598,13 @@ static const struct bpf_func_proto bpf_redirect_peer_proto = {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, params,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
+	struct bpf_redirect_info *ri;
 
-	if (unlikely((plen && plen < sizeof(*params)) || flags))
+	if (unlikely((plen && plen < sizeof(*params)) ||
+		     !bpf_net_ctx_get() || flags))
 		return TC_ACT_SHOT;
 
+	ri = bpf_net_ctx_get_ri();
 	ri->flags = BPF_F_NEIGH | (plen ? BPF_F_NEXTHOP : 0);
 	ri->tgt_index = ifindex;
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..ac49ca6d9a0c 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4034,6 +4034,8 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 	fl = rcu_dereference_bh(qe->filter_chain);
 
 	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	case TC_ACT_REDIRECT:
+		fallthrough;
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
@@ -4045,10 +4047,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 		__qdisc_drop(skb, to_free);
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
-	case TC_ACT_REDIRECT:
-		skb_do_redirect(skb);
-		*ret = __NET_XMIT_STOLEN;
-		return NULL;
 	case TC_ACT_CONSUMED:
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
-- 
2.43.0


