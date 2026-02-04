Return-Path: <netdev+bounces-256796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NGTEBKbg2nppwMAu9opvQ
	(envelope-from <netdev+bounces-256796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:16:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED272EBFBC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A283010DB2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9292DECDE;
	Wed,  4 Feb 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOYWQFnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62C217F33
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770232583; cv=pass; b=QbQXvX6vsQWzp9rPErjMlG7RRgezei9v0jfbX5oiXY3RdT/IhhMf4Ivyl2kBr0eP1KyaZ3II5d9wv9MLEXQtBMcj6g24/ujH3+vDcZlC5JROmDuLg9TJGqTDKQJC+dnPiH8rX+j2uW2LAXS5OlL1C+yGp3NfBu60fHCPm0rXmIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770232583; c=relaxed/simple;
	bh=PER2BQrsL1CJQhKWon9Mz9meNiPet/3DEkc6fa8mvI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALSoKgFq0qZLEoMdBspRt3/OtbA93BacITL+a9loxvWWvJEieYYzxJVsv8QB8Jg6/aj8LuE8+1e7HyWzgGM64IacbUL0ER5y4ZZouosqAYQmfqZkvGK9ZiSunkRL1a4p9LtT1C9aqz9cWOv9twPoXWDlbHjhmqJgGH0GUPkUJb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOYWQFnd; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b73112ab62so67287eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 11:16:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232582; cv=none;
        d=google.com; s=arc-20240605;
        b=TQxJg11ajGBCqZhTi5vJusid6BBiD9gzvpBpvoLWSHnewvnyFSZkU0BPHpvrra/i6S
         Bou9VQnv6o2OxYE1STA3pKKNicx7rI7i53ml9Dg2p+t3SWWdo+SguFVuQj9naEoH3G6z
         x7QJ/ABrR4QpIk/bF6n2IjVW1iY6FjNcUsKmVYSt+/73A+FjQSlrEEY1Pu+zWoWVMd5b
         HwBM19aMZv5Re/Xzl3jOoevTMKSKWJfqrh+kcOtAlLLIvTlHeLvZ+YnF+t0NiIGLAMEc
         X3VGR/rBLoKr+/VWqsYo9QpMuhRipugte1Ng7yr7JdAYzDuiBXndjaW95VnpVkL0tAZI
         GyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3uHPEEWLcSxU31xZCU6niHg5YWDthT8oTTsiIIWluck=;
        fh=SSWvNEmsQvmZRdYGnsHlILC0eALQjhdJt4EHuGbvXlI=;
        b=HcXxoUfY2E6NfLhFlIMQASTSY0bVq5uTKyM2cJLjbdYsOTWvSNItDaF7kgP+HGg6PW
         XEPsysgWB2KAWn5YIXvOGn/OhdBi1V2PETtEqC4329SWAEsApQwreRB9WGw5rAMDrHKT
         Fl+Dh+VyAWp4T+QAd7zBoKtrCo+Bil/kmgajaiRMP82DOOxsOlIqJEZ98tPolxMl65OQ
         sH/tzi0isRn72aAdxPvAFoxFYeV1OwkgmPRpf8FXqk9o9isGGvn5k6mrMp1IUp2WxA9j
         1XBGVdJCWfNPpAWiSPSnQOnCwPc2LTioZ+UqysTzH7XU+m6o8vhTqR5XNRnIA6s1fdZ/
         5HjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770232582; x=1770837382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uHPEEWLcSxU31xZCU6niHg5YWDthT8oTTsiIIWluck=;
        b=lOYWQFndCQ/CnmrxHZybSqR1JZxpgUlCwKdSzfqTL9v3PN2DBu8h/ZtFI9kle8waoi
         CD9ts7V9/6II5LjcouyoAiFgjm9idk1hyxcBJ19hdmdS4etLs9cM3Wk3Lw4v6lpaXEzK
         WMFz6LChoLmTVv5JTBmdy8LqEYLhjuqrJNODuH36BQcimdXe3flrt0VSK1UJvlACVfFF
         J8zGLZYXoyQ1sQlPe8UJ6ga8x2aWn4au6h0br53kGLRp3/96D2CPuBskbJdZLpnc6Xg6
         ouoOg70PKzSIHXnp37KEdtkWUjWrCOMwYXoFstNe0PhXhWZyvNZ0Y777gLjR2kXrtVgU
         wixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770232582; x=1770837382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uHPEEWLcSxU31xZCU6niHg5YWDthT8oTTsiIIWluck=;
        b=odNoJVvypLgknXSWKrld4tDiwGjRljPvgXU1oVH+abiA1FeMevamNuWTfnD7JkAMft
         keP7F87OmVwDMnQKnjHtpxX3CDwLn31LFg573wkz2L/LdfgiP7OpccWIBNYtQj92wg2g
         A89MbVqdLIlU0x3JO8/HFWWQDI447OhDmELH2PxA0YWZeIGLKk1fjjKB1LF5QJ6Q/dtP
         Nc9d5pX1vIVy5kvrOA0FX/NcCok7bwyw9IDTNtBpRtsjVEp2UzlMctwPCpq+Q4D9cCMA
         dZcYGlP+jY/Q1eYNruhU9TcIIdPZdpAIaiDgOM10SbX7grkyssrhzVdkwZVr6wnNIG5q
         yQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUE+FuVRQcoHBGO7kZJIhaC70WzNfcVRY4J5bf+QJWWF6J/3P8866L3fmzymfSqhFLSz+UPpns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ulLAny46LcL4f0JaYRCSMBWxv9EOKXT12/gEGXhu2cQpXQIu
	8K3ZKsXyFCq53N2GDH11getvzgW3i5JQCm2Fouu/fGzgD9oLkKmW/L1n0BgX2HSk4mipwbjJDVt
	TwyXA36g1bDIkrjv/46TWr+kwXrFvAczjbfF7Wbwt
X-Gm-Gg: AZuq6aIzfWi9MYFOU/6FqgR06eA0tfroGOdQrluFPWZ6MuQNAfa0Z7E+ClH8PO1sGYs
	hlPZRxXtORi44ad1xB7B6JqQdomgqRzWP5w+/Xy+e7TUQKO0id/NrH+fF20REVQz1K3LVoqvkys
	nl6IRQrL/qa37/n38J6neIiUSmZ4nmfnYIAC+/NvSbZsW7YE/srbv/doVK7QFGn2BzliRhPkjy6
	EU6vTK0afEQ65hir2x3uNcqR8WiigWlE83cwEhhySvG1CgPsRsErKFa4R1/WcHPMI8w4OWv45JG
	BMLmn7V2z8NrUtU4weqt46qQ0nqCkhqEXoFgdLKs2gKzVuhS5e3aqjEVi8KxBlvF/PA=
X-Received: by 2002:a05:7300:534f:b0:2b7:f12:9503 with SMTP id
 5a478bee46e88-2b83299d898mr1345406eec.30.1770232581601; Wed, 04 Feb 2026
 11:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co> <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev> <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
In-Reply-To: <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Feb 2026 11:16:10 -0800
X-Gm-Features: AZwV_Qgur5lVdyr6ufrZv78YuIEfQq3BMw2wq875R33oIJICWlo4lt09ETOastQ
Message-ID: <CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBGqKcUT0iMA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256796-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED272EBFBC
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:41=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 2/4/26 08:58, Kuniyuki Iwashima wrote:
> > On Tue, Feb 3, 2026 at 11:15=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
> >>> From: Michal Luczaj <mhal@rbox.co>
> >>> Date: Tue, 3 Feb 2026 10:57:46 +0100
> >>>> On 2/3/26 04:53, Martin KaFai Lau wrote:
> >>>>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
> >>>>>> In related news, looks like bpf_iter_unix_seq_show() is missing
> >>>>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock()=
. E.g.
> >>>>>> bpf iterator can grab unix_sock::peer as it is being released.
> >>>>>
> >>>>> If the concern is the bpf iterator prog may use a released unix_pee=
r(sk)
> >>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trus=
ted
> >>>>> pointer to the bpf prog, so nothing bad will happen other than
> >>>>> potentially reading incorrect values.
> >>>>
> >>>> But if the prog passes a released peer pointer to a bpf helper:
> >>>>
> >>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> >>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
> >>
> >> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a traci=
ng
> >> bpf prog.
> >>
> >>>
> >>> Can you cook a patch for this ? probably like below
> >>
> >> This can help the bpf_iter but not the other tracing prog such as fent=
ry.
> >
> > Oh well ... then bpf_skc_to_unix_sock() can be used even
> > with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??
> >
> > How about adding notrace to all af_unix bpf iterator functions ?
> >
> > The procfs iterator holds a spinlock of the hashtable from
> > ->start/next() to ->stop() to prevent the race with unix_release_sock()=
.
> >
> > I think other (non-iterator) functions cannot do such racy
> > access with tracing prog.
>
> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
> right, we can crash at many fentries.

Ah I was only considering SOCK_STREAM :p

Only solution that came to mind is breaking change enforcing
a release function to bpf_skc_to_unix_sock() so that it can
hold the peer's refcnt and save the pointer somewhere else
until the release function, but I think this is unacceptable.

Also, I guess this type of issue could be triggered with any
objects that are not refcounted by bpf tracing prog ?

For example, inet_sock(sk)->inet_opt could be freed by
setsockopt(IP_OPTIONS) even after fentry prog verifies
that it's not NULL.

I'm not sure if bpf_core_cast() etc allows such access, but
if it's allowed, I think there is no general solution.

Fortunately that's not null-deref nor oob-write, and it just reads
stale info as Martin mentioned... so probably this is WAI for
tracing prog ?


>
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe1/0x180
>  bpf_skc_to_unix_sock+0xa4/0xb0
>  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>  bpf_trampoline_6442564662+0x47/0xab
>  unix_shutdown+0x9/0x880
>  __sys_shutdown+0xe1/0x160
>  __x64_sys_shutdown+0x52/0x90
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> >
> >>
> >>>
> >>> ---8<---
> >>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >>> index 02ebad6afac7..9c7e9fbde362 100644
> >>> --- a/net/unix/af_unix.c
> >>> +++ b/net/unix/af_unix.c
> >>> @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_fi=
le *seq, void *v)
> >>>               return 0;
> >>>
> >>>       slow =3D lock_sock_fast(sk);
> >>> +     unix_state_lock(sk);
> >>>
> >>> -     if (unlikely(sk_unhashed(sk))) {
> >>> +     if (unlikely(sock_flag(other, SOCK_DEAD))) {
> >>>               ret =3D SEQ_SKIP;
> >>>               goto unlock;
> >>>       }
> >>> @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_fi=
le *seq, void *v)
> >>>       prog =3D bpf_iter_get_info(&meta, false);
> >>>       ret =3D unix_prog_seq_show(prog, &meta, v, uid);
> >>>   unlock:
> >>> +     unix_staet_unlock(sk);
> >>>       unlock_sock_fast(sk, slow);
> >>>       return ret;
> >>>   }
> >>> ---8<---
> >>>
> >>> Thanks!
> >>
>

