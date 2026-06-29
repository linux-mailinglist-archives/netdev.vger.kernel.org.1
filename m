Return-Path: <netdev+bounces-302563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PgxTBFRNQmqq4QkAu9opvQ
	(envelope-from <netdev+bounces-302563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:47:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE446D90A8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:47:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b="oyI/H26l";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302563-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4581530160C2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B50346AFD;
	Mon, 29 Jun 2026 10:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AE34750E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:47:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730047; cv=pass; b=Lm4QN0riAU1K0PDoSGkRKnfR2KK68Pf9BaZcljhOhYHz+Q2uEh4N+lk8BJmrts+n/Jw1glKk7aKiKxdvURllwcjwDfoFAP/jVOVLXXqhiKFKwaWPx+tsxa7B/CRGaUoDGLvNznFPWq5gS44jU9p3c0fJRilgwyevlF48V3xKw3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730047; c=relaxed/simple;
	bh=gWfU6/OyCo2rP1ZHR0B3aygjC+wA0mTDxemW9AISS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPPiHY8c5IMkOj25KT94323SjMIQhMUmf/YSXN9ZwNFO5vfPCegFS2JthYfhpgfdZtwvwzLQ28XYTO3GPQ0frnCk/v010q8N7xuUlXATjlPMetWrk/zcfM2Dvj0SX61ZQovJpWuwwca7YsSsMBcFPaxnTXpj1yZlvW9vqs4Yuuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=oyI/H26l; arc=pass smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8478cc93299so288066b3a.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782730045; cv=none;
        d=google.com; s=arc-20260327;
        b=qpWwiGoiHD8UcIBrPjD+2kkzaa2Ul+tiKkqb2omaZg1DlISPReirY+sQaPnIM/Hjmg
         waqAFBcBJ2+DuQh2juLVITF72hWg48O05D0477mPWzN8+rHMEj3hWbhisIh4XpkEEkyC
         pMU1Yxkg3N6BNUOwP2Or/A/y2or2MMDZrFsCBmv0BXFnrbKYHOMdPZ044rf/TfRR4BB/
         UF5ZHWXyASYchwOK2eK7e4GSVoJFvWRG8q/9kWjyfvEA8akAipC8p4GUNhpxDMEYCFoG
         oxPx8lmIE5tNP+eXCVkWAgKdbRKR3+/ZbNnsQR6CuHdjszY4OO5DffkKY/HcvwgUgY+y
         D6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2D/+tKmqEVHdrXuSNJqyqQwhydaMlOMVeSo45A3y9ak=;
        fh=cd02/ZbeI/l8yzLwiWB4VmtTSZH++Ap/Oa+LgBqOo6g=;
        b=oGUyorMlPZnbVO/5Nb4etolOaDDIiWr2+SksgVN6wMdkQLgBNgHnYBEPSZjLN7ezZl
         eVfPba8hESV9/kbdTLR3EiVurqrTa2J9eMWWsApOrcnCn23rW4CFGtvqtJdeTCMA1n4K
         UENDjogIOt/6X8uRjXLdkdJ2JEsM2ZPd6CcgWiDNSquVKIJRPzU5g+mHQddtQY9ZWs3X
         PdLSMtLDcqWni2Ey4k0v8+NSyu+JNCHP4GSL6Z9kI8CNAbBuApfxPN44AjkBUCGVW/EI
         NrWM4CoSTdCSaeboPf7oWTWJ+EDt+3eroXsF+M+4RPm/WCODgP7RFzmIpnAG68XgNhkR
         aBAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782730045; x=1783334845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D/+tKmqEVHdrXuSNJqyqQwhydaMlOMVeSo45A3y9ak=;
        b=oyI/H26lFj6+qhCKhcQPKAz2JKRRE2BIwmqYDhZR58GxiuPo3OYsSLPEInYwX1uAV8
         QhMD3sd1UjSVoyyB0xCYz2gVMqbym+a6TcaYQMeklDKuQA7z5a711ABRYqA7JJFuEEFE
         gBv/+uBfY67xhSWAv8AvDxuFlHahv1KV/z4+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730045; x=1783334845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D/+tKmqEVHdrXuSNJqyqQwhydaMlOMVeSo45A3y9ak=;
        b=bMjoDT2uFpFRh4D23vXvI8Md712vPmDvZalMEz3GFhKXlfXeh8XFYTW3afBy6LWRZ7
         nLKYjQoBtlBy/2z0C1SwtcVSALgqCeDCh2LDFzFbPgLa/Ps0QZlve08s7Ngfucnm6TMQ
         WXeJQh3bJPjT/atdq6CzKEp1N6B+VdMiLQi8vZEugYX+eSFGwKXe1cf66Ap5E7SFJqYz
         Oo2UlZCSmAXJB5lL9GMNacbtBe34QMHmWZb2/KtyFYz1WwjlkcjcNd4jtps1798g/zL3
         Q4AbL8f8ar8FV4xep5ANlBCJN2KQ8+0QATRBUPuISvICB1t9HHmtrsnqyFvQoxQqoYS/
         HjPQ==
X-Gm-Message-State: AOJu0YyhHQegOQND0CAgOvJWjAtRaMaD+XaFVRvCU30GdcNfaELzRU1h
	D0hG4QNtp2bcaBejpn0D16Kz3kBTPE6ILtdFlIUywKBVzSTslZBgS9YChNPYZwx9Jx1jtoTdVdi
	AW1JJi1vHG/jG35KDOujRLRsuHAefbY6Vqg3ttsaC
X-Gm-Gg: AfdE7cnCqD0T/XB7lHyfyr/HlUiVUw2qzCGRLCQERdTW2J425hXTpLMJOwt9eJP5ms/
	jjVGHWH0gQoaHwmpMye91WdtmiIQam6Of/PUq+gsEitnq76wfgCUg2iGkq1atIrZfZJVRuMbkIX
	99J1XJeODNmfZrtZvzk1Sglsnqj9J61hQy3au6trReVfV0GVftVcMMU6mYmApO5IWO+h4a3Cb9I
	sbG6Yjj3pkX6IrGwQJ2L0IdAg6IJnzlcfNUGXj5+YA8EPUpE6BQxRidt31V3UkVcHn8AWts3g==
X-Received: by 2002:a05:6a00:4b4f:b0:847:1d73:f753 with SMTP id
 d2e1a72fcca58-8471d740f0emr3744079b3a.45.1782730045309; Mon, 29 Jun 2026
 03:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-2-jhs@mojatatu.com>
 <20260629102917.Ag2Vd7LR@linutronix.de>
In-Reply-To: <20260629102917.Ag2Vd7LR@linutronix.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 06:47:14 -0400
X-Gm-Features: AVVi8CdCMJDxSkLILcgjDrSjOxQDi_5ubUK40tv1YNxcJz-LIUxKvJgWZ1t15wA
Message-ID: <CAM0EoMkh50LPeZ6sy8uA6APen1zTRBRYjcH_b521q=5YhitLKg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	toke@toke.dk, jiri@resnulli.us, clrkwllms@kernel.org, rostedt@goodmis.org, 
	kuniyu@google.com, sdf.kernel@gmail.com, skhawaja@google.com, 
	liuhangbin@gmail.com, krikku@gmail.com, mkarsten@uwaterloo.ca, 
	victor@mojatatu.com, ast@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, daniel@iogearbox.net, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:jiri@resnulli.us,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:victor@mojatatu.com,m:ast@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:daniel@iogearbox.net,m:sashiko-bot@kernel.org,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302563-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,resnulli.us,goodmis.org,gmail.com,uwaterloo.ca,mojatatu.com,iogearbox.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:email,mojatatu.com:dkim,mojatatu.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BE446D90A8

 -

On Mon, Jun 29, 2026 at 6:29=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-06-26 12:51:54 [-0400], Jamal Hadi Salim wrote:
> > The bpf_net_context used by sch_handle_egress() is stack-allocated and =
torn
> > down in that function returned. By the time tcf_qevent_handle() runs
> > current->bpf_net_context is NULL.
> >
> > When a filter attached to a qevent block (e.g. RED's early_drop or mark
> > qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> > tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf he=
lper
> > bpf_net_ctx_get_ri(). That helper unconditionally dereferences
> > current->bpf_net_context resulting in a NULL pointer dereference.
> >
> > Note: The same holds for actions that invoke BPF redirect helpers
> > (e.g. act_bpf running a program that calls bpf_redirect()) during qeven=
t
> > classification itself. And as a matter of fact the same assumption is
> > made in the code outside of tc.
> >
> > Fix:
> > Move the bpf_net_context lifecycle out of sch_handle_egress() into
> > __dev_queue_xmit(), so that it spans both the egress TC fast path and t=
he
> > qdisc enqueue. The setup is placed outside the egress_needed_key static
> > branch because qevents are independent of clsact/NF egress hooks and
> > that key may stay disabled when only a qevent-bearing qdisc is
> > configured. Unfortunately this adds a small unconditional penalty to th=
e
> > code path _per packet_ only guarded by CONFIG_NET_XGRESS (two writes an=
d
> > one read for bpf_net_ctx_set, plus one write for bpf_net_ctx_clear).
>
> I fail to understand this but you and sashiko have an understanding...
> If there is TC_ACT_REDIRECT returned by tc_run(), then the skb is NULL
> and as such uppon return from sch_handle_egress() the control flow goes
> to the out label.
> As a fix you move the bpf_net_ctx assigned to before CONFIG_NET_EGRESS
> and clear it on exit. What do I miss here?
>

There are 2 separate filters.
IIUC, you are thinking of the first one which is the clsact egress
classifier (which runs in sch_handle_egress())  - its redirect would
indeed return NULL and skip qdisc enqueue.
The second one is the qevent redirect whch happens in
tcf_qevent_handle() during qdisc enqueue (block 10 in the reproducer).


> > This keeps all bpf_net_context management in net/core/dev.c i.e the
> > existing boundary between tc core and BPF without requiring any net/sch=
ed/
> > code to know about BPF plumbing.
> >
> > Reproducer (see the accompanying tdc test):
> >
> >   tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB =
\
> >       avpkt 1000 burst 100 qevent early_drop block 10
> >   tc qdisc add dev eth0 clsact
> >   tc filter add block 10 pref 1 bpf obj redirect.o
>
> stupid question: how do I get this redirect.o? Just a simply thing to
> reproduce this=E2=80=A6
>

It's just pseudo code for a bpf prog that redirects (so you can create
probably a few liner bpf prog).
Take a look at patch 3 which uses a prebuilt action-ebpf binary with
the action-redirect section (added by patch 3 to action.c).
If it's still not clear, I can craft one and send it to you.

cheers,
jamal

> >   tc filter add dev eth0 egress protocol ip prio 1 matchall \
> >       action gact pass
> >
> >   traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() an=
d,
> >   on a redirect verdict, a NULL deref in skb_do_redirect().
>
> Sebastian

