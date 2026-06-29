Return-Path: <netdev+bounces-302673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wLruDDR+QmoW8gkAu9opvQ
	(envelope-from <netdev+bounces-302673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F236DBE2E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=XksBjP4o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302673-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302673-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA883182535
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842037475B;
	Mon, 29 Jun 2026 14:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE136D51D
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:08:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742129; cv=pass; b=QH93neA51hPmfd0tq8Vit7JDLpdPMqWkatz9+4xf6H2pVFa7TuErFVseKSpioqbeEEiU7G/MhUYqCebscKG7P4cWZJO/K+3ye5YiHR3sy/mx8T6lP4DKcIh69U4uzlfuFYIzUB288FcihzXh0WTokFwlW+vdSMkJdVKw5Feb/Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742129; c=relaxed/simple;
	bh=q8QVdB9NJN+/zi8Xa6uyCMmfy4NxiwhJalxYShKUiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TES8h9w1orsP46pR06n3Weo9bV7bBp600IqjiWsayWc4U5f5l8Lw+hCzloRpOZpx4LBeoO2oFmxb/Mns+LnxCkDE6XjdBzzM6E2ATEXPw4B9qffXUDs+lHXENoC4GOPFUvTG7In1p15398NBWYsQLk2lfIsqJIH1Nc2zwGnBzZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XksBjP4o; arc=pass smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664a10cd4a4so3033017d50.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742127; cv=none;
        d=google.com; s=arc-20260327;
        b=MOIvyY8nzOmvKyFWFachLEBvkFFQvrKdF2p1MpKujh46v5V9LvjkvyNd65OMvXnT5a
         GWSyUcI4p45681Ks7cmm9P3bAgBe8CHNJtI+Kt7PlKKGYMGYC9SHuuvCwtMkHjxrvO9s
         LLgdmB7YJG8FO3pUECpNBTOq+aqUJ8HhdWMBYg6bAprfG//eznbt3YnG39sGT07PvtAY
         JbG5vAC8vxj4GAGBOkJiEZEUK4xiveHuqgQwpiGE6H8a7fUUuBGlMMTkGedV/EMIpKMu
         cF4xznw5g43iACXwCARY/oCzGJc2KD+1F+4xHfealGF53vfxWNX2o15FqxI9Zavxohj/
         7Smw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        fh=RJ15Qvpyi4AZV26VInCJqnWnvqAc6YFfexCACVte/3k=;
        b=jnguqikugIKX6xmMgLybGETpnHAOKQJtgV+ia57vfjQuHMo5EBrB6AIILapHdPIUct
         5W2m0W7GbwZKRXYUx46mwdMIhgcP5j7BK+rkkQoGAeJ33mVN89+/JoykbIcW7TKGwUFB
         7P7ACf/Wk+OH0V7JhDNNiQcYG7rKk24K6IGjk2Npu8zEPzFQW9mHPQSI4J4TA2hqLlvq
         pAx4u0TO4EW7DZwfj4fca+4wYCINqsyIdTsom7lCB5z+LyI+oB1B2biFM4zHcWXPltdA
         UTnpC5bgh7xGLWHa8NAHppsghrNpF8zQHumTnRVodklZThp96vPzDhlS9EKUCJPjEvdA
         sSjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782742127; x=1783346927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=XksBjP4onHdQGNQhjSwLsyFa5U7EewqqYv64OBG477NoI+++Tzw60DB7vQAZvZbWUY
         +wnPRwDg7tNhwk/aXmOESi2i4WG0ddy05TpTtLnU2ORZWEBiTZyYntVGdsQ+zCmpBv9K
         Im1tPOFZtf9o+0WBcY7VNiERNX0K7lpExRr7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742127; x=1783346927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=codD4Y9vfKR0SbkgeM1T2454JxJvoIfN+6m/xaL6uCAFJCfWx9cpf1TJkYofCFRFZi
         w1i4tNoYHKJV6KGSZDAy7L3dpzLD4uQN2uJt0Np+Ionp8ILEWJhP9QuqUqpt2Pj/2aWf
         JwdOg2eExAjm0fe1SCI9z6WaqEUrJ35RXLVtOOj7yxQAeELTeDTOOVy8T+NqydUJBHv4
         KtjZohHDUriSCMYH+NzW88LqLdtP9nkQfnTjuo7F7wBbPF1GESqrSFt7yuiJnP/D4lmK
         UgydhUfchDP8Z5m0tqooFJYNZF/75jXkJPcrXTt5OFVXuGVBuaXLDVyh4uB3elI1GFU8
         dERg==
X-Gm-Message-State: AOJu0Yzoaoz4gF+fSka1EZkjM8ETKPRlDqyWGMJ5OH+yYoVvI5DKlmRx
	ZUBaNonLAAvW6/+CH637x+XamfYs6PFqWwIrFD71iExz+HrWzCAHWRySZgE5odk+LgIeV0adudx
	hE4BAKWV+dAb4p3Cp1AmRFAFrDx1RQKOp2bVt16gW
X-Gm-Gg: AfdE7cnAMe/hL4UVwbWruLY9Z03fx2KSjZjwsX4hueTho/HMTWJ6CuknaDku1x5Agca
	vzTxuajKdP0hO3j7/JH47MNtn9tZnNzGKkYQmi8fUNfg0cy32A2WL1rjZWL/mMM/c4H4ljm5/JO
	I+s/BKaNzW+Imwy+qviIYnd+6qrlyOtWtaPZ4YgDCM4yhfW85ICzpVR8ZYRidt/7RR8i5XtHzzQ
	JkuChXEPPgBQjqsWFY0mJFkulj9mz9STKk0ZZ9+31l9N5i9gOIJoGZulM2BkhOXeGj1iQ==
X-Received: by 2002:a05:690e:11c9:b0:664:cd1c:3c1c with SMTP id
 956f58d0204a3-664cd1c64c7mr3930877d50.0.1782742126728; Mon, 29 Jun 2026
 07:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629102157.737306-1-jhs@mojatatu.com> <20260629102157.737306-2-jhs@mojatatu.com>
 <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net> <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
 <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
In-Reply-To: <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 10:08:33 -0400
X-Gm-Features: AVVi8Cdkj6dZhabBc0jnLqVMZa0vjqL1ozX4LLqAaVAUSsSvVM-qHxGJioR3gI0
Message-ID: <CAM0EoMknehYGAse7AfAN12oEYvQ894YbJrdhv1unOYgpTtvzFA@mail.gmail.com>
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>, 
	Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:rostedt@goodmis.org,m:petrm@nvidia.com,m:ast@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:linux-rt-devel@lists.linux.dev,m:bpf@vger.kernel.org,m:security@kernel.org,m:stable@vger.kernel.org,m:victor@mojatatu.com,m:bigeasy@linutronix.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302673-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,goodmis.org,nvidia.com,gmail.com,lists.linux.dev,mojatatu.com,linutronix.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87F236DBE2E

On Mon, Jun 29, 2026 at 9:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/29/26 3:36 PM, Jamal Hadi Salim wrote:
> > On Mon, Jun 29, 2026 at 9:01=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
> >>> The bpf_net_context used by sch_handle_egress() is stack-allocated an=
d torn
> >>> down in that function returned. By the time tcf_qevent_handle() runs
> >>> current->bpf_net_context is NULL.
> >>>
> >>> When a filter attached to a qevent block (e.g. RED's early_drop or ma=
rk
> >>> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> >>> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf =
helper
> >>> bpf_net_ctx_get_ri().  That helper unconditionally dereferences
> >>> current->bpf_net_context resulting in a NULL pointer dereference.
> >>>
> >>> Note: The same holds for actions that invoke BPF redirect helpers
> >>> (e.g. act_bpf running a program that calls bpf_redirect()) during qev=
ent
> >>> classification itself.
> >>>
> >>> Fix:
> >>> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> >>> __dev_queue_xmit(), so that it spans both the egress TC fast path and=
 the
> >>> qdisc enqueue.
> >>> Note: The call is placed outside the egress_needed_key static branch
> >>> to cover the case where clsact static key is disabled. Unfortunately =
this
> >>> adds a small unconditional penalty to the code path _per packet_ only
> >>> guarded by CONFIG_NET_XGRESS (two writes and one read).
> >>>
> >>> As pointed by sashiko [1]:
> >>> The same context must also be set up in net_tx_action()'s qdisc drain
> >>> path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED chil=
d)
> >>> can trigger qevent classification asynchronously from softirq context=
.
> >>>
> >>> This keeps all bpf_net_context management in net/core/dev.c i.e the
> >>> existing boundary between tc core and BPF without requiring any net/s=
ched/
> >>> code to know about BPF plumbing.
> >>>
> >>> Reproducer:
> >>>
> >>>     tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 2=
0KB \
> >>>         avpkt 1000 burst 100 qevent early_drop block 10
> >>>     tc filter add block 10 pref 1 bpf obj redirect.o
> >>>
> >>>     traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle(=
) and,
> >>>     on a redirect verdict, a NULL deref in skb_do_redirect().
> >>>
> >>> Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks=
")
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
> >> bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
> >> end up having to touch the core TX code?
> >>
> >> Untested diff :
> >
> > This is bpf plumbing which doesnt belong in tc really. You already
> > moved most ebpf/clsact stuff into dev.c - let's just keep it there.
> >
> > As a side note: calling a hierachy of N qdiscs we would incur N
> > set/clear cycles for N levels =E2=80=94 and worse, qdiscs like HTB and =
HFSC
> > iterate filters while loop calling tcf_classify_qdisc() per iteration,
> > so each filter chain traversal does set/clear per proto.
> I'm just saying that this is a lot simpler and taken out of the core fast
> path. Also, I think you forgot to Cc Sebastian on the whole v2 given the
> bpf_net_ctx_{set,clear} dance. Imho, having them via tcf_classify_qdisc o=
r
> something similar would be the much better choice compared to sprinkling
> ifdefs since you want to block the TC_ACT_REDIRECT from classifiers attac=
hed
> to qdiscs.

And you are clearly not listening to what i said.
Something similar would be fine - but stop using tc as your dumping ground.

cheers,
jamal

