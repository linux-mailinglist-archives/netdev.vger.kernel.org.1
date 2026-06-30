Return-Path: <netdev+bounces-303139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4imFAKexQ2onfQoAu9opvQ
	(envelope-from <netdev+bounces-303139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2846E3FCF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:08:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O1O1g017;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73C663002F61
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA340757B;
	Tue, 30 Jun 2026 12:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A82F872
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:01:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820904; cv=pass; b=amoEVypfcBBw+A/mzCRePaOf5ZHxWKalqRnI+NIFXZOjw2FR1d4Akc+c053r68CG1U4KewLsbLYY9bi6QAR1RiEm4GkgBhlv4YPy9fJX6PEALKjIc1ElGfg6uPHiGZFwl25MVcb6MLbn0SwHugjtAxNRY1WLA0fZ1cwqENA1U9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820904; c=relaxed/simple;
	bh=5RD/fXtPthZHrtbsQjrXdejhjnF9h+fzl678Tn8gOeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh067DTM66NpOVDKi49CciYbXHaomkOslOwFRVONRpM20qnNX9Ut404pR5Lz8vt0XeIpU91aD7Ur1qCiPd0QvlvYf01FkbcnD7LAHV4YlUzTdN+RjUOOz3oYmJHqzi0X2T9bvZzWLkGo19dq12NWStaCRXZRxQRuvB+nWCwdTWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1O1g017; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aebfa21c62so451671e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782820901; cv=none;
        d=google.com; s=arc-20260327;
        b=A9VaMc27n1dM73YBSX4etZHH9A0nbZonKMl6wK15XCmz385d7/kXdIHsBajsFMlJGN
         r41KFfN49W2Ta959DB+1ZZVUM9D9n4rLO2X9POVs6ihLf8ATXdD0y6ChEANMjnZUcwTi
         e/+ZLnOVLH9nNkfK31eMs8N8Yj1vlhBhonxzgWwXnnH16gADWMuZ7DZbRxZoGBbMwvtA
         xIU4jdFsgEpqjRB3j3NRXZ8q4ToBk+q0TSOeL3Y1v8mWPnhJCERkkIZF+slbnrx72Jps
         dy8j3zITqfvEyK7GDupYzPOPfOtn6GiEuMlfoQp8AEzMJua/IlCjYCyij4A5JpOuvFh6
         4dDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQB81QRr+7xOnnJO8gqyQeTBsIiQc6GySxFYZL6NELM=;
        fh=bNw0CUKleOcHyovAdoJdcz4ad8X/OpeXycTqmcWprD8=;
        b=lly4AzLAxp+zJ3tBajrKIB4LN+E0o1pEMGBA4fAuAvZEe835ia9B2gDAJoV0Sv2pxj
         aT+1a/1HJs6AhVgycJ4dIkoaJVtaSjdzH9wxMyVF697gn/3tFZzLedc417iAOy7D7gHE
         6CMI7OHWsH68YP18xCC8erDw3StEuM3ChXLhYBQDaKwkfrK+qMYzje9dE5tyVH10ntNX
         H7eXAI0ROYrjnV8Xo8tSUP2sCceB3IjOIgDK4O3nLCFwA1qwk5m5XFkcy6Fc29TxyusL
         xeCDo8TFuxShAEqnInPBtr5XoA1hI/hB/3/rJCpwENmTxVoerknQZO0/l+H7vzNeObIK
         4TlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820901; x=1783425701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQB81QRr+7xOnnJO8gqyQeTBsIiQc6GySxFYZL6NELM=;
        b=O1O1g0175zJEFJsScv3qLz+xdn+dnhHOIYfd24DS4N9jT50XoQVkU6P7KRMugI2u2+
         xPcw1CF9ROQmjXe0CZS+52jZ3ORaMj3VXHGlwWGfREo0RJ44sFpRJpLETPN8X81drcuX
         pxBIGB3Xao8bouLdHlfBns6ZsbxLp42sFQmqUVI9evswGxg5OIvMtLS78CYHZQoIqOOo
         IWVBhJZDNeAw84P85LWG7KU21hvFiJIGDyYsmaeZ2VJIb4p0LX3C0huqqn2h4JsfxAaV
         6OeM3c46/O0oKxlaimzedStRCNWlxivMeyp1G2Iw12go3eBfp/nMhLfPAQd7bBK4sQLr
         TlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820901; x=1783425701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQB81QRr+7xOnnJO8gqyQeTBsIiQc6GySxFYZL6NELM=;
        b=bKIANExnV5eYKo/MXK5MKkb1GMsBqtTW7bKxBBC9JKrHm+xb9DOnxWH0iK63BQD43m
         zkjLmyEeRjvU0eQQOxvbAShUvWmyoAEwEuwRMcATWmbY2/nrCyr4MM91P/ZWpWwVz+It
         1nKnnrZf99uT6Wex/RQMOgazKZvoCS25HdwFxL7Lel+Rj8/6SOHhA/AJiildJONBa57z
         UOxqjwBeqVJkRKQy2emUlRyK2EsMaS0p2mHvDCVk/tqy8aD4z3zl5Le2Vdp6cPYvMuz5
         xXjUJr3Kwq4qDowUuFrh2eV3Cwhp70KyYEpSXuNFOMfF5hOSF6oZX0y7LyCVuVUEun6C
         wpQg==
X-Forwarded-Encrypted: i=1; AHgh+RoA+u821/CPNdMwjiVZiR1IrXk6oLykIFyWhFAy3w2Cr9l/DyLw+8Vc1J2GyL5YRC52Eh+/qSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU50KwbKbwujum+CEpifcB1L3B2o4BchVa4ZE8r+tyWlXxgmPK
	Zl7WOlmPrHkwQaifAcyvNpE/Ut/s5k8u3yq6Az0vhM/1OZUAab+C2TB9mExKY114uEj3XyT9U/Z
	ygtV2YYYTqyFSjtO+4gGlFDr1stAJppE=
X-Gm-Gg: AfdE7cnlGFqZluImoVTdyqhT4eK7m2YjVqSdSiWCVORkXvdiKqFLcgJDhie6CKw9I0/
	ucqftKp3BoXUGDK5DCB7yn/i6772EaiO5HhuPIjYNofZqMpiX7f8LkCVcoXRHawV0uu1UzAqEkl
	0Mv8dfLoEf2w90hSNVmR/O3lpybIbusDwe5imUMDBoNltkQNoH9p67kwy0ca2F4/ClJrK2thR76
	xduFkmRXJWsoLlLCOmkVudAP+T86hytocDmprgbwnWpfye4kTYB35A1cqfsCOoS6SZIeYNz36sn
	6j3J20v9FozCrtNq9FAanIEWm2pxWA==
X-Received: by 2002:ac2:598d:0:b0:5ae:9d87:b85c with SMTP id
 2adb3069b0e04-5aebdba4261mr552785e87.21.1782820900932; Tue, 30 Jun 2026
 05:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625102020.92814-1-vimal.agrawal@sophos.com>
 <20260625214659.1115819-1-kuniyu@google.com> <CALkUMdSzLQSpjpK+cnt=c+dPDZGnyB2zUD3z3KKXr=-DhM7t=Q@mail.gmail.com>
 <CAAVpQUA4dyukqihiQoGfbaPtBn1OAaRaWyQ197+hPs7gmqW7=Q@mail.gmail.com>
In-Reply-To: <CAAVpQUA4dyukqihiQoGfbaPtBn1OAaRaWyQ197+hPs7gmqW7=Q@mail.gmail.com>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Tue, 30 Jun 2026 17:31:27 +0530
X-Gm-Features: AVVi8CeOUIWUrQURbCNHU2vsvn0aQB9F_ErGpjMDPZV3LnhsVP5P4HZrYYnxfi8
Message-ID: <CALkUMdTCYQDe3aR8mvSDMjkmYhXZRJf1S6sMRRkaem+_=Yk9WA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	vimal.agrawal@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:kuba@kernel.org,m:edumazet@google.com,m:netdev@vger.kernel.org,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303139-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,sophos.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB2846E3FCF

Hi Kuniyuki,

You are correct that in this specific test case GC does not help since
all entries are active/reachable. However, this is not the only
scenario where entries can exceed gc_thresh3.

In a real workload, the table can exceed gc_thresh3 with a mix of
active and stale entries. In that case GC does help, but should not be
called on every allocation attempt =E2=80=94 once per 50ms is sufficient fo=
r
GC to make progress without causing lock contention.

The rate limiting also protects against the case where GC cannot
reclaim anything. Without it, every allocation attempt above
gc_thresh3 triggers a full table scan holding tbl->lock, even when GC
has no work to do.

Thanks,
Vimal

On Mon, Jun 29, 2026 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Mon, Jun 29, 2026 at 12:57=E2=80=AFAM Vimal Agrawal <avimalin@gmail.co=
m> wrote:
> >
> > Hi Kuniyuki,
> > Thank you for the feedback.
> > However, the rate limiting issue exists independently of the threshold
> > values. If entries genuinely exceed gc_thresh3 =E2=80=94 regardless of =
what it
> > is set to =E2=80=94 neigh_forced_gc() is called on every allocation att=
empt
> > with no rate limiting. In my workload, most entries are
> > active/reachable with refcnt > 1, so the GC walk traverses the entire
> > table without reclaiming anything.
>
> This suggests your gc_thresh2/3 do not fit your use case.
>
> If GC does not help, there is no point in running it or rate-limiting
> in the first place.
>
>
> > Increasing gc_thresh3 would make
> > this worse, not better, as GC now has a larger table to scan on each
> > call.
>
> If you just increase gc_thresh3 slightly, then yes, it won't help.
>
>
> >
> > Regarding neigh_hash_shift: in my workload, neigh_alloc() returns
> > ENOBUFS before reaching do_alloc() since GC cannot reclaim any
> > entries. kzalloc() is never called, so neigh_hash_grow() is not
> > involved in the latency I observed. The pre-lock time check in
> > neigh_forced_gc() is a low-cost safeguard that prevents repeated full
> > table scans regardless of gc_thresh3 value. It does not interfere with
> > correct GC behaviour =E2=80=94 if entries are still above the threshold=
, GC
> > runs normally.
> >
> >
> > Hi Jakub,
> > I tested with different threshold values, filling the table completely
> > with 32k reachable entries and attempting 1000 additional allocations.
> > Exported neigh_forced_gc so that it can be profiled
> >                          no change  10ms   50ms   100ms
> > max cpu usage %          44%        11.8%  2.56%  1.42%
> > calls > 100us (of 1000)  101        31     13     7
> >
> > At 10ms, max CPU usage is still 11.8% and 31 out of 1000 calls take
> > more than 100us. Given that 50ms reduces this to 2.56% and 13 calls
> > respectively, I would prefer 50ms as the threshold. However, I am open
> > to further discussion on the right value.
> >
> > Thanks,
> > Vimal
> >
> >
> > On Fri, Jun 26, 2026 at 3:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > From: Vimal Agrawal <avimalin@gmail.com>
> > > Date: Thu, 25 Jun 2026 10:20:20 +0000
> > > > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is c=
alled
> > > > on every allocation attempt with no rate limiting. In workloads wit=
h mostly
> > > > active/reachable entries, the GC walk traverses a large portion of =
the
> > > > neighbour table without reclaiming entries, holding tbl->lock for a=
n
> > > > extended period. This causes severe lock contention and allocation
> > > > latencies exceeding 16ms under sustained neighbour creation.
> > > >
> > > > Add a pre-lock check in neigh_forced_gc() to skip the GC run if one=
 was
> > > > performed within the last second, avoiding repeated full table scan=
s and
> > > > lock acquisitions on the hot allocation path.
> > > >
> > > > Profiling of neigh_create() shows ~3 orders of magnitude latency
> > > > improvement with this change.
> > > >
> > > > Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQ=
Wx7sSM=3DAEgsq0kywHxTw@mail.gmail.com/
> > >
> > > From the thread, these look misconfigured.
> > >
> > > ---8<---
> > > net.ipv6.neigh.default.gc_thresh2 =3D 32768
> > > net.ipv6.neigh.default.gc_thresh3 =3D 32768
> > > ---8<---
> > >
> > > If gc_thresh3 is larger enough, gc_thresh2 will give you 5s
> > > rate limiting.
> > >
> > > If the number of active neigh entries constantly exceeds
> > > gc_thresh3, it will be the correct gc_thresh2 for you.
> > >
> > > Also, I guess you want a new kernel param for the first
> > > neigh_hash_alloc(), which is currently fixed for 3, which
> > > is too small for some hosts.
> > >
> > > 50000 entries require neigh_hash_grow() 13 times.
> > >
> > > Can you test this on your real workload, starting from
> > > neigh_hash_shift=3D16 and appropriate gc_thresh2/3 ?
> > >
> > > ---8<---
> > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > index 1349c0eedb64..a75b3750eec9 100644
> > > --- a/net/core/neighbour.c
> > > +++ b/net/core/neighbour.c
> > > @@ -1817,6 +1817,22 @@ EXPORT_SYMBOL(neigh_parms_release);
> > >  static struct lock_class_key neigh_table_proxy_queue_class;
> > >
> > >  static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __rea=
d_mostly;
> > > +static __initdata unsigned long neigh_hash_shift =3D 3;
> > > +
> > > +static int __init neigh_set_hash_shift(char *str)
> > > +{
> > > +       ssize_t ret;
> > > +
> > > +       if (!str)
> > > +               return 0;
> > > +
> > > +       ret =3D kstrtoul(str, 0, &neigh_hash_shift);
> > > +       if (ret)
> > > +               return 0;
> > > +
> > > +       return 1;
> > > +}
> > > +__setup("neigh_hash_shift=3D", neigh_set_hash_shift);
> > >
> > >  void neigh_table_init(int index, struct neigh_table *tbl)
> > >  {
> > > @@ -1843,7 +1859,7 @@ void neigh_table_init(int index, struct neigh_t=
able *tbl)
> > >                 panic("cannot create neighbour proc dir entry");
> > >  #endif
> > >
> > > -       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
> > > +       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(neigh_hash_shift)=
);
> > >
> > >         phsize =3D (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry=
 *);
> > >         tbl->phash_buckets =3D kzalloc(phsize, GFP_KERNEL);
> > > ---8<---
> > >
> > >
> > >
> > > > Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> > > > ---
> > > >  net/core/neighbour.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > index 1349c0eedb64..078842db3c5f 100644
> > > > --- a/net/core/neighbour.c
> > > > +++ b/net/core/neighbour.c
> > > > @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *=
tbl)
> > > >       int shrunk =3D 0;
> > > >       int loop =3D 0;
> > > >
> > > > +     if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
> > > > +             return 0;
> > > > +
> > > >       NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> > > >
> > > >       spin_lock_bh(&tbl->lock);
> > > > --
> > > > 2.17.1
> > > > v

