Return-Path: <netdev+bounces-302761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IFF2FvSzQmrU/wkAu9opvQ
	(envelope-from <netdev+bounces-302761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9326DDEB6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BwWI1nyC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302761-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302761-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D0B73002908
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06145282F3B;
	Mon, 29 Jun 2026 18:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897E2D0C7E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:05:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756327; cv=pass; b=uNN0oiR8+seG9mrkQOGsa+1lkm8Y9dGUekl0cPMA3H7irgUCxSPYj58qEsun8JhEXI6wJ1CFx6MUwZ1bRkmyxDCRy8DnQnoOyH7IF1MlKttIrDOgKOPrgV5z6FW+XYLzvLoan4bLGboKoCr7+bfp033N6gcukhPMoeUKpW+uTB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756327; c=relaxed/simple;
	bh=Uhckl5gasRPy/Q9fjOQVz92tB7mZ/a0FmJRdZQt/bK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5eJN7urBUM+4E5ixQtx/VJ6svnp+L0Q9uHy9GV4jHb9XXrJtKdJQG6FaqpSeQy+QCg7+1o1Ge7UagdWGESoVaqglDeJM9CBEjpwbI5nZodXVA18qNOFrp0z8HzLs8Xmghg3cwSrZRICbleHrkG7lJNYHGvt1E3JomKx451u8/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwWI1nyC; arc=pass smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13809223fd4so4405512c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756325; cv=none;
        d=google.com; s=arc-20260327;
        b=a8DvpMqgCxXIn6BDppIY6nr+YBfYZMfwkKc9obJTfzvXvCkIP/wDvLA9Y4RrK3aL32
         TYvDwauR5Zxk1EV3uDqQKMgu4LRcR395LtXZv5c1aKPVf6/vbNKUEfVAOAB7LbANOcu8
         SGrgJ+9RQG9OOvN522EL+N2Nio7SnewAao1r1SsPrw78QSF1DinU+WNAnq4SB/yzkglB
         QafFYZzvEGhNoDhqug438GYDsGZg6xsDzpgbFcYf6np+sVwSpAmtnQcR9llvm84xqd6K
         TYCCjec1/KtykNUG6SUBYprN6RpaGmZ2N5SQh8hW8PbfIqKpXY8q/z/gsvsp6Bfblf6x
         uAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDw1E2/pIt6d7lE9aQGWAuiRLCVjcZhQOY5MZpoHVnM=;
        fh=LGPirqrxwya2Xl+I+WxNpg6Ny03f/JMrcrRM1/WJeZk=;
        b=IxuBmMw/Kn1fpQTPm7AXK2t1asZBcw3AAoYsZNWRLpSMGnqMa/VhRWmM06BAvN5ksd
         oMVnubmOMEY70BOXcOc27Z4GB5mvfXq+Hqz41Mldaxfr6sFBTgLHQKXZ2pTOIwAd3RQY
         XZmrxCTKhQ5nXVQwdSlp0u1LFhFHjyty5KvzAPv9QzbJghtvLq5pn3+rfwm/mqPXur9a
         2NMYRSJmEhDro0mlUG7xhKWpRS0R2Aq8CyZ5zK9ataOkfR6ZbInOPBOFwg/cyrUyFsfy
         aHA1RRwegAdBkNlyuOFXCxmraM4oGq7JiD6KbKfmvxyRBxtGDcIwk7Ke+rVSoupjQBfG
         6GcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756325; x=1783361125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDw1E2/pIt6d7lE9aQGWAuiRLCVjcZhQOY5MZpoHVnM=;
        b=BwWI1nyCWmtHjhGNWZNB8kvBDzGHvjeQ2KKeO/PD0DPd98CD57aqVETnHt51JripG4
         S25mDGOwz0n2a+iY6NHCh8yTAzemHz2dQ5uyHYYU83BHYqBQC3UR6tE2OWXn+pe5qqgu
         nCrt8Q/LZZqH+M57ZW+wzsC3OA8i9+TIGC9fnBOTKyjmBe8vrbhY6KEYt3QlweA1szDz
         h6E7wsgFR+3enkVh0k7puES2GsiMIUICT6bPMbNLNKzXfTPOUXxNtw5MRtySd1InqZiw
         wq72i+kp1PD/1ssPGWfnKNr6hGv++4DUZuf12rcPtPl0Vzn/6+Bm1ekm73pealqCHRnA
         nE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756325; x=1783361125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDw1E2/pIt6d7lE9aQGWAuiRLCVjcZhQOY5MZpoHVnM=;
        b=rhA0wQaFideXM6pNjzTPzMSSt+R0u55wFHUrwS2qzP4VoNnXyVNqlXmoZ+kZybFXUZ
         gSjE6Mq7tUBM1iJwIEfeI/ItVSGDkbxjkrubORl+3ILsjoFE1UJpC71oMHFWEQ0Q4bIR
         mx7fYWaJF0/mTD415w/U7hCj4qMcYYxbnzmfvfA3dtYd5b+1ojfPNQxomS/JpQ4cxj2O
         fzHjOH4mvgz2i4++9l+sMBoQ760Div8V9PGOJ+Vk5ezcqCPGBMkFrffK1SAnRE9L05qG
         h8eEfaFQJQHnNLicA6vTd7jtfOzGwr288KlNNqPWqlBMzfCcJJEFfi2EpcvwH5ZCQEnc
         8ggA==
X-Forwarded-Encrypted: i=1; AFNElJ85H2sgCx0raxZGFS1Ib9mIzk6x6NLLwpfyZiK1AEbwecuzAHf7rTjaIflUl3Jgt8EgClS672c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPUiLM0dP054pph6emguvDpKZub/nwpWZz3Ru0Qc/qcZuKwGY
	/2vzKiwHpBEcaL4DftDCTJyo5kd+10I/PVi5kLUeSmfaEIBC6Y8RFbUtA3MhdcbRpK/c4wMwxVH
	wKnRZ1wU3U4J7ubq0rJJ1KBr7ZKQ3kk1m9lEBAr/i
X-Gm-Gg: AfdE7cn9b8aQmSpcKwUDsaXeO59aIC2WDsc9Vhu/NWP8P6RVvGE0XrfDGg0EN/sAUvt
	ONlqOKh3MW2xgv6Ha0VR1YwKLzAZDRfVPaeYfuyjxSodOkt+2Ugs/7T+sqW/q+/3LlTxPVs/gP8
	zAv6IbsZpxAVKe3J8uVO9GrQ3yVpf1k9TYMqOOrJcXIe0l4I0qlAi25Jg6wRyBBQ7hITKHX/OSZ
	vfmQ4Ts7RdOUbdZraSNoHP3TyUqBamYfiF1SSRunvnpPB0opa04LfNvsKGSCAE8ys7XVzJqTK4u
	xX32YxAhFm5slcwulHkgxdbOU4ESni07wc8mGa7PASQQIXfautw4kVgQysl+VTqbZtvzzyvr+RK
	nwojC1hQZllPIUUPxfhYnGarrY2zvIlROE62RiYVSMw==
X-Received: by 2002:a05:7022:2212:b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-13b2a0a8ac0mr334633c88.0.1782756324471; Mon, 29 Jun 2026
 11:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625102020.92814-1-vimal.agrawal@sophos.com>
 <20260625214659.1115819-1-kuniyu@google.com> <CALkUMdSzLQSpjpK+cnt=c+dPDZGnyB2zUD3z3KKXr=-DhM7t=Q@mail.gmail.com>
In-Reply-To: <CALkUMdSzLQSpjpK+cnt=c+dPDZGnyB2zUD3z3KKXr=-DhM7t=Q@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 29 Jun 2026 11:05:13 -0700
X-Gm-Features: AVVi8Cec4fh6C2dBxYFOx_MjNcL0Q14J81BUEtzA5DPiOrLQzPF73f4WfQeydUM
Message-ID: <CAAVpQUA4dyukqihiQoGfbaPtBn1OAaRaWyQ197+hPs7gmqW7=Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
To: Vimal Agrawal <avimalin@gmail.com>
Cc: kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	vimal.agrawal@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:avimalin@gmail.com,m:kuba@kernel.org,m:edumazet@google.com,m:netdev@vger.kernel.org,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302761-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,sophos.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B9326DDEB6

On Mon, Jun 29, 2026 at 12:57=E2=80=AFAM Vimal Agrawal <avimalin@gmail.com>=
 wrote:
>
> Hi Kuniyuki,
> Thank you for the feedback.
> However, the rate limiting issue exists independently of the threshold
> values. If entries genuinely exceed gc_thresh3 =E2=80=94 regardless of wh=
at it
> is set to =E2=80=94 neigh_forced_gc() is called on every allocation attem=
pt
> with no rate limiting. In my workload, most entries are
> active/reachable with refcnt > 1, so the GC walk traverses the entire
> table without reclaiming anything.

This suggests your gc_thresh2/3 do not fit your use case.

If GC does not help, there is no point in running it or rate-limiting
in the first place.


> Increasing gc_thresh3 would make
> this worse, not better, as GC now has a larger table to scan on each
> call.

If you just increase gc_thresh3 slightly, then yes, it won't help.


>
> Regarding neigh_hash_shift: in my workload, neigh_alloc() returns
> ENOBUFS before reaching do_alloc() since GC cannot reclaim any
> entries. kzalloc() is never called, so neigh_hash_grow() is not
> involved in the latency I observed. The pre-lock time check in
> neigh_forced_gc() is a low-cost safeguard that prevents repeated full
> table scans regardless of gc_thresh3 value. It does not interfere with
> correct GC behaviour =E2=80=94 if entries are still above the threshold, =
GC
> runs normally.
>
>
> Hi Jakub,
> I tested with different threshold values, filling the table completely
> with 32k reachable entries and attempting 1000 additional allocations.
> Exported neigh_forced_gc so that it can be profiled
>                          no change  10ms   50ms   100ms
> max cpu usage %          44%        11.8%  2.56%  1.42%
> calls > 100us (of 1000)  101        31     13     7
>
> At 10ms, max CPU usage is still 11.8% and 31 out of 1000 calls take
> more than 100us. Given that 50ms reduces this to 2.56% and 13 calls
> respectively, I would prefer 50ms as the threshold. However, I am open
> to further discussion on the right value.
>
> Thanks,
> Vimal
>
>
> On Fri, Jun 26, 2026 at 3:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > From: Vimal Agrawal <avimalin@gmail.com>
> > Date: Thu, 25 Jun 2026 10:20:20 +0000
> > > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is cal=
led
> > > on every allocation attempt with no rate limiting. In workloads with =
mostly
> > > active/reachable entries, the GC walk traverses a large portion of th=
e
> > > neighbour table without reclaiming entries, holding tbl->lock for an
> > > extended period. This causes severe lock contention and allocation
> > > latencies exceeding 16ms under sustained neighbour creation.
> > >
> > > Add a pre-lock check in neigh_forced_gc() to skip the GC run if one w=
as
> > > performed within the last second, avoiding repeated full table scans =
and
> > > lock acquisitions on the hot allocation path.
> > >
> > > Profiling of neigh_create() shows ~3 orders of magnitude latency
> > > improvement with this change.
> > >
> > > Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx=
7sSM=3DAEgsq0kywHxTw@mail.gmail.com/
> >
> > From the thread, these look misconfigured.
> >
> > ---8<---
> > net.ipv6.neigh.default.gc_thresh2 =3D 32768
> > net.ipv6.neigh.default.gc_thresh3 =3D 32768
> > ---8<---
> >
> > If gc_thresh3 is larger enough, gc_thresh2 will give you 5s
> > rate limiting.
> >
> > If the number of active neigh entries constantly exceeds
> > gc_thresh3, it will be the correct gc_thresh2 for you.
> >
> > Also, I guess you want a new kernel param for the first
> > neigh_hash_alloc(), which is currently fixed for 3, which
> > is too small for some hosts.
> >
> > 50000 entries require neigh_hash_grow() 13 times.
> >
> > Can you test this on your real workload, starting from
> > neigh_hash_shift=3D16 and appropriate gc_thresh2/3 ?
> >
> > ---8<---
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 1349c0eedb64..a75b3750eec9 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1817,6 +1817,22 @@ EXPORT_SYMBOL(neigh_parms_release);
> >  static struct lock_class_key neigh_table_proxy_queue_class;
> >
> >  static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_=
mostly;
> > +static __initdata unsigned long neigh_hash_shift =3D 3;
> > +
> > +static int __init neigh_set_hash_shift(char *str)
> > +{
> > +       ssize_t ret;
> > +
> > +       if (!str)
> > +               return 0;
> > +
> > +       ret =3D kstrtoul(str, 0, &neigh_hash_shift);
> > +       if (ret)
> > +               return 0;
> > +
> > +       return 1;
> > +}
> > +__setup("neigh_hash_shift=3D", neigh_set_hash_shift);
> >
> >  void neigh_table_init(int index, struct neigh_table *tbl)
> >  {
> > @@ -1843,7 +1859,7 @@ void neigh_table_init(int index, struct neigh_tab=
le *tbl)
> >                 panic("cannot create neighbour proc dir entry");
> >  #endif
> >
> > -       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
> > +       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(neigh_hash_shift));
> >
> >         phsize =3D (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry *=
);
> >         tbl->phash_buckets =3D kzalloc(phsize, GFP_KERNEL);
> > ---8<---
> >
> >
> >
> > > Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> > > ---
> > >  net/core/neighbour.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > index 1349c0eedb64..078842db3c5f 100644
> > > --- a/net/core/neighbour.c
> > > +++ b/net/core/neighbour.c
> > > @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *tb=
l)
> > >       int shrunk =3D 0;
> > >       int loop =3D 0;
> > >
> > > +     if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
> > > +             return 0;
> > > +
> > >       NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> > >
> > >       spin_lock_bh(&tbl->lock);
> > > --
> > > 2.17.1
> > > v

