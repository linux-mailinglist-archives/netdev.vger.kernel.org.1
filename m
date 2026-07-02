Return-Path: <netdev+bounces-303982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RlpXIMT6RWprHQsAu9opvQ
	(envelope-from <netdev+bounces-303982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 07:44:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1226F39BF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 07:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="crEVb/vt";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303982-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303982-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EB6430419EE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AA36896D;
	Thu,  2 Jul 2026 05:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13A3655DF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 05:41:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970867; cv=pass; b=RwRvSXnYvuzV4K/GhrpVXTiNErFBvDQU8/GCB+D4d+b2VrHgEIByJXJWY8j2t1gFgUeVti9L7TWXsG/XPI1bDtViSXiSGzwn544DYQj9NP9a/iTjH7yAINsb16YGOnKoLWcvKW9FIet+hOsrbiVPDs2JjSWA/jLNxzO7vRlQ8sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970867; c=relaxed/simple;
	bh=IQ/c8WVDoxQrhZvKSrnPQbv4b/9COlcR710Od8nu4tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSsGJZcmibbWnU6ToZMi2mMkJXPYijQaEWHsklkghqAFe/jOehyTAh7ps48xiFc+RX+W9CRzs0vvSKxo8qXu3waffZOp+fQ/4IndzQq2kUu7B3FezQ67dku5PfJg3qM2Bdfp+esjREreyezOT4npjYg7lsu9Re/KTEEykHg9klk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crEVb/vt; arc=pass smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so220935a12.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 22:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782970865; cv=none;
        d=google.com; s=arc-20260327;
        b=CnJcsmBpIDShey11imsr6ujmFQmoY+KG9n0zJQX5M56WxUKvWPNjgjqZpY/GpQ39w6
         AU66a5c+lBT9fJ7x6SXiMd+yn6M34lmwhla/COZBkHUZ7KTG1AIXdkvFGJLCu2waBJJ7
         W9yB0a41w9KM7gNkYSSMIVkPV5s+BIQXAoUgkAPXg9LTHIS/p6pIIOhLnkRvqbxUAKmt
         VkE6GhTgKSTMG+1dNPvczS062UPksf/26JPQdlNTdLhyU+MxM1NPwVsl5QKpj6g7+0Sk
         6HEzXH5NexN4b+C9zPlfEvykSYZlLGLiAhKcg2Gm5zagFzMyfiBpp+j4z/F7Ad8WIvLu
         w1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5UfvAgJ8YjTczByfeidWqKA0EosDZTFgQFu0/uNWSo=;
        fh=8NLVcBecdVeQMdSEHlK/aR9wVUqFqAKnV0QAUoA9sFY=;
        b=mk8TbJgVRg7UuB0aZyJn7Xw30EZd2lI2z5aEN/lLqg6ucHVFG+tA5nSW1/zc3mbabe
         UQk/hGByM5vg5PhEG4vyQKL+AsHg/Wk1HCK+JxYZmFktdrraGnHhn6PNjNeeyyOmtKN6
         lqs/YiGFHbqTyyNZ1gRQW32U1umTU2v60dbNZBN+W61t1/9r2oPcoHk9WDsmV5NZQTBJ
         glQV9HC3WPaBXVxIONfEF19/8UAGKy8rOlY65AldeKh+Iimz7M+Y0uLkPEf11kjnC/vb
         QnTNwTXSrOA4da5MSAFYZiNEqS5Ul3nRw40RpKO0EtEBAQMx0uwydlbRLedXPwQIKyPc
         CI5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970865; x=1783575665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5UfvAgJ8YjTczByfeidWqKA0EosDZTFgQFu0/uNWSo=;
        b=crEVb/vtynFU8RPb+rOusw/MWx0mpjIpmrwNl6FcQmDy0joDeoMrreKMWuMRAmuk4p
         or9sDldhXr4WH+OsaBiY0k199yF5/pJBN7MAFYjpfslEVL6yz9FLKzNHkRBJ20RH/5d1
         BS2nV39na+j2zvsn7yCFRGC6xBSTceSlFiaWSYB0Y7gEZaKaANMaVWFfch8PCxuCuZGD
         LFo+cxAGhs+eDmtBmHpDOWOhjUKf547PtQbPzdWdZYM3B8GUsCIsibkPEGjqgjKFIqbP
         +V8dkijGVG9KUtHUi7hfuoFF5dPf3BMcSX8fs8s4bOGMu8wC+kSULaxqXIS5xYipi6ZE
         qI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970865; x=1783575665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5UfvAgJ8YjTczByfeidWqKA0EosDZTFgQFu0/uNWSo=;
        b=FfyMuxRSAlDKgL9Li5Jly7R0365ITPq/kf7ZB1LSLenKIfImlNzQ9BL4X+kQ8MkvrJ
         90EiHU3DShVyBj7preUnjZhjW3EAZQgLa7str17D0fBZI4/cBopj38vdUR8h2A3RZerp
         jDzssW5lttZXU63ODo6E+2Yfz71XHjvv1mPQkEPzWc5ZzOdaVC5U39+G6PQE/Rz3k92F
         y0NyIXL47lboNW4BpojKPfKYHsKfcL8Uly2rwlBuL0okuT4LAIsKHt0yLZPmvbHEFw6m
         OqPVQTDKh6y9Ja9t8Fgir5GpJvSugYFKgrtPgG+54+OwVdDUROVbb8ZSMKxDHHxIYCiQ
         KyzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RXzq0U9Ptkk659MS/FWQ5jJxn30oZUJwo/ze9AZmn0yVWYyoptoBaJQ85BllOh7ytYGznCrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPt+hXF/xrEcDHrLF56BHeqE/fkCdgOEiJr8kO5Pb/N+cNRuYy
	FWCUIPP1i8kFDr80LyxnwRYLTpym+K6zH31cqKndUYfItAbZrau22ycrzDwGNX1SBc6ow4bfNjZ
	zF/GtGviSIsO3pmZvuLJYS3ZlriJETCY=
X-Gm-Gg: AfdE7cntFx+Kpt8sbkHMv3AgmfeN+nnvWrh/zi7CXz6vi8s+vYUn/UV+CPv0bO0anYM
	JDlyMjZENNrEgWJ04GTM/NJ06ROAXlOquX/qR5fj/+IaDnrN9ArvCXlYzx1UcaffaqPprIpmG/Y
	9mAbX0PKndx1VdCh4CReMyMcw11vjmi6ecmraAi65lti9N9QqRMoQBZK3D9aMqxgQk5AD8LSRWr
	oDe5PraiZTFejrH82x0kJN78PZBLO3I9pipi/XOBiQkKoaat0TuBKWNOZZIsr5XWrCZCQ4kFIRY
	tp0s5xi7jA4ohA/4V9tvo8Pp6vxxlt6BFD3u8GrDnp49v0pGp/op1GBbzfcmM9PIkYQcPs22poc
	gGFLjRhPP638qFA==
X-Received: by 2002:a05:6a20:9f93:b0:3b3:fdb0:2295 with SMTP id
 adf61e73a8af0-3bff3ffaea9mr4293388637.6.1782970860276; Wed, 01 Jul 2026
 22:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bzb+OOrdGyxbzjh=7MUEbA5FC05E6_iwCjDXcnSO-HZ=ig@mail.gmail.com>
 <tencent_30FB52DFC6440984EEF0EEC70C90A7DAC606@qq.com>
In-Reply-To: <tencent_30FB52DFC6440984EEF0EEC70C90A7DAC606@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 22:40:48 -0700
X-Gm-Features: AVVi8Cd_Aydgpi6ybanaT5W1RYtoYBPVPSh1YD5O91Uma0-voa1CtKjxUtg_WYg
Message-ID: <CAADnVQKvNewGNAoiF8thaqaWuZCFxzeXU3QHg8jP8Dmqag6_JQ@mail.gmail.com>
Subject: Re: [PATCH v5] bpf: Fix smp_processor_id() call trace for preemptible kernels
To: Edward Adam Davis <eadavis@qq.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, sashiko <sashiko-bot@kernel.org>, 
	sashiko-reviews@lists.linux.dev, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:eadavis@qq.com,m:andrii.nakryiko@gmail.com,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jiayuan.chen@linux.dev,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:sashiko-reviews@lists.linux.dev,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,m:andriinakryiko@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303982-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,iogearbox.net,etsalapatis.com,linux.dev,lists.linux.dev,googlegroups.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA1226F39BF

On Wed, Jul 1, 2026 at 9:35=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> On Wed, 1 Jul 2026 12:57:52 -0700, Andrii Nakryiko wrote:
> > > bpf_mem_cache_free_rcu() maybe called in preemptible context, this
> > > will trigger the below warning message:
> > >
> > > BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.1=
7/5820
> > > caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> > > Call Trace:
> > >  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
> > >  bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> > >  rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
> > >  __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c=
:3349
> > >  bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
> > >  __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
> > >
> > > this_cpu_ptr() requires the caller to prevent task migration.
> > > These helpers currently do not enforce that requirement and may
> > > be invoked from preemptible contexts, leading to accesses to another
> > > CPU's per-CPU cache after migration. Use get_cpu_ptr()/put_cpu_ptr()
> > > to pin the task while accessing the per-CPU allocator state.
> > >
> > > Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kf=
ree_rcu().")
> > > Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory =
allocator.")
> > > Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1=
f
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> >
> > from what I can see, bpf_mem_free() is called through bpf kfuncs only,
> > and all BPF programs run with migration disabled. So this seems like a
> > false positive. For per-cpu checking, it should probably check that
> > either preemption is disabled or migration is disabled. tl;dr, there
> > doesn't seem to be any
> Today, I researched the call sites of bpf_mem_free() in detail; it is
> called directly by bpf kfuns only.
>
> Different BPF program types execute in distinct kernel contexts: for
> instance, XDP and TC typically run in non-sleepable networking contexts,
> whereas `raw_tp`, `tracing`, `LSM`, `syscall` and especially sleepable
> BPF programs may run in contexts where preemption and migration are
> enabled. Consequently, any shared BPF code (such as a helper or kfunc)
> that accesses per-CPU data must not rely on the caller having disabled
> migration; instead, it must internally ensure that CPU migration does
> not occur during the access.
>
> Taking into account the CI reviewer's feedback [1] and my further
> investigation into BPF programs as described above, the adjustments
> related to bpf_mem_free() should be retained.
>
> [1]
> https://lore.kernel.org/all/20260630094823.897BD1F00A3D@smtp.kernel.org
> >
> > pw-bot: cr
> >
> > > v1 -> v2: using guard against preemption
> > > v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation=
()
> > > v3 -> v4: disable preempt to make this_cpu_ptr() work
> > > v4 -> v5: in mem free disable preemption
> > >
> >
> > maybe throttle your patch resubmission spree a bit?..
> My earlier actions were driven by a desire to keep pace with the CI
> reviewer's response speed.
> Moving forward, I will slow down the cadence of new patch submissions,
> as you suggested.

Don't bother. You don't sound like a human.
Bots are not welcomed here.

