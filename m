Return-Path: <netdev+bounces-302559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id up0aFXZJQmr+3wkAu9opvQ
	(envelope-from <netdev+bounces-302559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0B26D8EB7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=gyzOAUYj;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=G9LbQTuo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302559-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DED23001077
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FC3FAE15;
	Mon, 29 Jun 2026 10:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC88379C5A;
	Mon, 29 Jun 2026 10:29:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728962; cv=none; b=q/4TjvkzXgWON8SlrVz92fnpwzRKWOORT1K5voZm7pQxQwnaBfJ0h7fFqGcqCMUz/VL7IargbXY46ubqgMobYEoSwc0EdrFMmZCuSE+n6DiJR42cn805hSRATfGPNkEDc+Gl+R1YwOUe/FUhlkP3w4JYL7zYuXpccg5f3Mci0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728962; c=relaxed/simple;
	bh=tbtjkuimxedkcTP+D1p4As511RP7QabYqR6uLuD5NTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuGF8bEUpx/L8IChtrGmDBSRoIBh0ROc0v1ZtY7WWhiE0JLkBZaTeTSpyHI5do7RYsAsvyUR9/v6xDwiAMFNgWYcUQqiG76VfgoO6zPMlAQOXeCY9O4IvMDALH7ypjZdHxk5FdNfLrcLWrSuvBf7iCOR08K0ukC/K2PT5LB9X7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gyzOAUYj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9LbQTuo; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 29 Jun 2026 12:29:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782728959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xEfDSiGwjlvL77ASnBwcZCNfzRqenYZMglXUGdb8UM=;
	b=gyzOAUYj0Vk3iynVM+tyfuK0PeB/TcI1HoJDwy4BBznezJeM2u65f5asWNAo4O8jbsI+jW
	5e3XEMPLonyIicNcJhinLigZom+cMDADxxHr/b/gudYu0xR9VB5UmL6Ws2YnYWlIG5nl/w
	GHddtahL4nUZmMRpFP0ph6RMLoS3HyIboEkkBWBOMwxHEeDPqsU6bE4rBcA3ng3kjJnelL
	QgidNJoa6so10NpKfaTO1i4e35mFr7QG+NWG7g84SPss1E1iBKHLY7NydbcRS/9/zWp87h
	CKrkb6Nx9DCvU3VBHJ4E4rV2+QDNQ7lRotZW0yxpjwsB2g0gnM1wMcMoIhQfDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782728959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xEfDSiGwjlvL77ASnBwcZCNfzRqenYZMglXUGdb8UM=;
	b=G9LbQTuo+IZbziO0S+xHdre+EMftJ8iF2yJfNW9mjYJ4K8h1xwMmi3hHKLG27VmguucbSB
	Rf2ZdbumF8u5K+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, toke@toke.dk, jiri@resnulli.us,
	clrkwllms@kernel.org, rostedt@goodmis.org, kuniyu@google.com,
	sdf.kernel@gmail.com, skhawaja@google.com, liuhangbin@gmail.com,
	krikku@gmail.com, mkarsten@uwaterloo.ca, victor@mojatatu.com,
	ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	daniel@iogearbox.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
Message-ID: <20260629102917.Ag2Vd7LR@linutronix.de>
References: <20260626165156.169012-1-jhs@mojatatu.com>
 <20260626165156.169012-2-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260626165156.169012-2-jhs@mojatatu.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:jiri@resnulli.us,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:victor@mojatatu.com,m:ast@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:daniel@iogearbox.net,m:sashiko-bot@kernel.org,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,resnulli.us,goodmis.org,gmail.com,uwaterloo.ca,mojatatu.com,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C0B26D8EB7

On 2026-06-26 12:51:54 [-0400], Jamal Hadi Salim wrote:
> The bpf_net_context used by sch_handle_egress() is stack-allocated and to=
rn
> down in that function returned. By the time tcf_qevent_handle() runs
> current->bpf_net_context is NULL.
>=20
> When a filter attached to a qevent block (e.g. RED's early_drop or mark
> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf help=
er
> bpf_net_ctx_get_ri(). That helper unconditionally dereferences
> current->bpf_net_context resulting in a NULL pointer dereference.
>=20
> Note: The same holds for actions that invoke BPF redirect helpers
> (e.g. act_bpf running a program that calls bpf_redirect()) during qevent
> classification itself. And as a matter of fact the same assumption is
> made in the code outside of tc.
>=20
> Fix:
> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> __dev_queue_xmit(), so that it spans both the egress TC fast path and the
> qdisc enqueue. The setup is placed outside the egress_needed_key static
> branch because qevents are independent of clsact/NF egress hooks and
> that key may stay disabled when only a qevent-bearing qdisc is
> configured. Unfortunately this adds a small unconditional penalty to the
> code path _per packet_ only guarded by CONFIG_NET_XGRESS (two writes and
> one read for bpf_net_ctx_set, plus one write for bpf_net_ctx_clear).

I fail to understand this but you and sashiko have an understanding...
If there is TC_ACT_REDIRECT returned by tc_run(), then the skb is NULL
and as such uppon return from sch_handle_egress() the control flow goes
to the out label.
As a fix you move the bpf_net_ctx assigned to before CONFIG_NET_EGRESS
and clear it on exit. What do I miss here?

> This keeps all bpf_net_context management in net/core/dev.c i.e the
> existing boundary between tc core and BPF without requiring any net/sched/
> code to know about BPF plumbing.
>=20
> Reproducer (see the accompanying tdc test):
>=20
>   tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
>       avpkt 1000 burst 100 qevent early_drop block 10
>   tc qdisc add dev eth0 clsact
>   tc filter add block 10 pref 1 bpf obj redirect.o

stupid question: how do I get this redirect.o? Just a simply thing to
reproduce this=E2=80=A6

>   tc filter add dev eth0 egress protocol ip prio 1 matchall \
>       action gact pass
>=20
>   traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
>   on a redirect verdict, a NULL deref in skb_do_redirect().

Sebastian

