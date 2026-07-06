Return-Path: <netdev+bounces-305198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LtNC10LTGpKfQEAu9opvQ
	(envelope-from <netdev+bounces-305198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:09:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 735457154EF
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:09:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=f2Mk1mam;
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305198-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305198-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728A03122A58
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E73C553C;
	Mon,  6 Jul 2026 18:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26643C3786;
	Mon,  6 Jul 2026 18:56:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364174; cv=none; b=Qjen5aJ6rckpWLILOE8tyqQfLqn4win/C4/9GJG7EpI1lFjcqyXhFcKikITKbOkp4TdwpQxQ5xKWOqKJmDpzDrUkF8VxqRnDVGSY4UPQqPtGmtbFkEA6G/FKFOeTqB889qbswwRauh1awGQaDau1+3LH7YJiYgvfl1HiH6npRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364174; c=relaxed/simple;
	bh=Iy737gpYpjcfmz+BK4MyiNnCqXlwli7b+Otb+58lB5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcO8UbH0gTLBZA9Aq8kORakUhBEu9oyPuOlfgm+Sn674gKNPvURghglySLXFSHG0uuJpXKQAqXGI8qwd+pCI093krQ9QKLFzCXaZ7Fqr6hDA/8Dt3tVaBMLRQj911lgajBbzDgjq6CW8au7opBFiGrig19QVvmsz/mIYvSHm+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=f2Mk1mam; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ia9jFHaB3zN0CVAd301cZySjDLnmx7govEGgeqC9izo=; b=f2Mk1mamH+2o7qcyGMpVvRmee3
	EDb+UBCtdh9FGv8GYAK0LAvp1Dlk/v/DEjdpUCg2xfqhyQ5y6B4eUqFYdQCxF/Y6Z0dkWLFGEe3Us
	dbcVwPBjS8lexkAYBPoTt3j9XLcxLysl6W7z2bL7nT/97GPVTTi2N/oKBe5AkFWcfSv3PbN2XSfli
	CFCl5Lp/fK518+eh7QGot4i5lFebIkxnqfZKrpnnpL6R4wxg+iUGIg7ObRHvyDcfbMEpb/wcB+Xal
	hRkOvYeNOP4G/cgas9ZuofPQcbDoKjaPA4zZQJgL/nxhGJKfx1BLy78H08z0o8H7blqsSFxlZuasi
	X+f8T+tw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgoUF-000Psi-04;
	Mon, 06 Jul 2026 20:56:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	jhs@mojatatu.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2 1/3] bpf: Reject redirect helpers without a bpf_net_context
Date: Mon,  6 Jul 2026 20:56:07 +0200
Message-ID: <20260706185609.330006-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706185609.330006-1-daniel@iogearbox.net>
References: <20260706185609.330006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,mojatatu.com,linutronix.de,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305198-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,iogearbox.net:from_mime,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 735457154EF

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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
index ffeea6db8337..523cf2a8bd1d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4046,6 +4046,8 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 	fl = rcu_dereference_bh(qe->filter_chain);
 
 	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	case TC_ACT_REDIRECT:
+		fallthrough;
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
@@ -4057,10 +4059,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
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


