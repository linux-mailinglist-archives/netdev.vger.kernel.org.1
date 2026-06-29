Return-Path: <netdev+bounces-302501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o3p4NWYlQmrW0wkAu9opvQ
	(envelope-from <netdev+bounces-302501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C66D73B6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZFXnwcXN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302501-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302501-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA9CA300C301
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4933F5BD;
	Mon, 29 Jun 2026 07:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA33DA5B0
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:57:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719838; cv=pass; b=BOk1UI6RrbhGd/l2dgk50gROGRHcyLolDlzBL0c/9fyPlCsip+merK9ra3AzzZ83882MpO9JNi9eqzR7zcTaw/kFtRn+CQXDB9PTmLaKJs/nm7WRNguZ2VckU75mjlWD4eViCvbadGJ48KC9fKBNgP6OD0FNvyEaK59gz67XhrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719838; c=relaxed/simple;
	bh=uDvNHdO6ipZOa22B+VF77WNBMVNQLhth4jVSeJu2tHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsL+0qFhu0yNF6x/JZFB2m47AUAi48xXge/xA4lZDOE7nFP7vY5fFm6LsOVTGwFx8suw9b0pJmRIxsb6NQLKCLoPAZ9CUoZaImKYdHqn/cRBF4woKGV+o73A8/Bsve1cnkgevruiBBvV0t7ONFZhnk2jd42GZY3lU2DN+GsvJYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFXnwcXN; arc=pass smtp.client-ip=209.85.221.169
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bc4a1130adso743907e0c.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 00:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782719835; cv=none;
        d=google.com; s=arc-20260327;
        b=kp1SEUH2lJqUiGMzNXMxOKYp9M1ERx0H2XJhRyphkYegVjQ5EEkTnYhKmUQkv9SYRH
         T9CMDlvJzJ8J4Ktklg5F56qmM6Z/8Di6sHMYUz9CMDta+2AQbhruvWLuTOjPHu2CVVkd
         ZWMC6zXrBqBGvx60kVoEUELfWhRD/OUdgNHaWOjuwD5vTA+te6X4gVkUqpfAHzqSTRtc
         QA+qhAM+CDfsxFZivXJDmfpZxbbSs20q8Pb+lQp+pEJmk5E9h3elhE10iLS2ozaS2uOH
         3MgYP+s5th8lgzNglBRSxOHheDmNplV4xmSeFL3L9ey0jHyR49ohdzNXdRgldwhw2s42
         7Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b9rE9Esj3MEH0RWN+pNoBZkM3ovEHrZLtejAAEjKoHQ=;
        fh=p2F1ZlQCMYi7eabj+4BZtmCsKqXjoScj7fz9KwLhwdc=;
        b=SOC+m8LP25CBOocDSdU9bDyk+eS6bcsLMbTwAw4FhoC3bI3d4SDNHqburmJAxjZIyo
         4x+tcMBvOaCXhqlINDX2ozanX4bYhr4ZzPRyaAGQJIOfKC1MnGQWENdtq1CfLcCGTjiH
         Nh2904cxKSHWbW6THYYOVWCGxO8vX1cNegpq7YNOVHZlfQ7TA5ehOFidpyBGAZ20AKXU
         I0eqyXzqmexxvryjZ8epSfEsHSmBYg7kWGS/IIcFr5yVwByWJxfPr95TApJvgagr3DR1
         cznpgIwJF8EFfYmrp3q8M/EgJ2l+EvFkUT493lJt6zTleHIhIXVjfe7V5gsiFCfEXT1S
         NI3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782719835; x=1783324635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9rE9Esj3MEH0RWN+pNoBZkM3ovEHrZLtejAAEjKoHQ=;
        b=ZFXnwcXNlgntEfJIwCtF8CBj326t70ybDy/CAjoSkn72eNjQQDpJ8wsooQ+R4G8ift
         6WYvBSgglTiBUSZw1nKBqHgeFBvnrfEayXc+rs9TO8tl3uZcVgs+gyOUuJbTiM3ZDX74
         MVc1zCxLXXESl7mZw/wi0PXt5WCx9TzPrFYI2QGVzfsg9MQ7m6p690z04f6l1a+z8M8N
         tZWEMM6k8pzCkrU8ywngT10vUnFZgZv3rk3ebD9lkJqtHMd5lSNAElkz3QC93KG1nSWg
         FHpfE/f3g2DGoISTzHKczsb9hhCJlwwAYh2fbUzfCVsuE+ZRYsDpAGbn82hFCwQw5OBo
         Z8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782719835; x=1783324635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b9rE9Esj3MEH0RWN+pNoBZkM3ovEHrZLtejAAEjKoHQ=;
        b=jZPox+9S9SRRbGgWvXxWpcnWON5/J+JxF82Wq/Y170Ljv6gHOCl3AvsvUv5x894m4s
         v+dl7nxIl7E/DZnZiv3+XGVBS0Muvw7iDXISu0IDRvNZfadF/SyoH0z9LSi0Tb0dwEjy
         9UWBOhplcqzHqTDWqOyy4Tj3BBgD9aD+PbZahUeTiCWze+vazOJR0mth5y9B20rknWip
         B5YjcTYuBeTe0EMYY4o65zr6Ue2msrbN78Vs6UGfpQnm4sj0lwAPGqGn/p+s4LKAZ9Ev
         QQqInhjT/Kk4U1IfjaEqhMfjXWvA+nkR0NuXQnpdr+wClzak2BELD1Nhj+T/mNZIXthh
         38jg==
X-Forwarded-Encrypted: i=1; AHgh+RqLDGJqkabbxAbPY4uVtx/YFj/UPltQECqjO4kFxYI/3So1zJLR5EYrFI1zhDrk70Odvk36vVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVhPG4a4twIHctN5ykS6iYHJ5tY2SVRdm2H3i9TrA2c90bC6W
	1mFXdv6bqvfbASLjbAO/QqzkaKxnhjyl41/lG88+zZyS3swYTMQbNtaXCLxiUZNVge5zAmVvMyI
	x/enGzvEmPzFc9ozDmMpaJX7Z5lqQBXk=
X-Gm-Gg: AfdE7clTkJ6frSyssN6W+F6yg+fYUbmSWv3vaJKnfI6TZxjET+jZvKeUB4SG8u97Mfs
	IZkL3RjD/KlufZ3cyA2c2lomIeTT9LOxwMRWjRB/CeIqjwatD0Y97AInn6E0TU3LSmpnxHUVrR0
	LWdZYCfQsqU+8yXR1an0ZHwf8k8fYXYKI0dazkc6pO5R4OOv4PCzuMlVXtR8Sug7bJot98Ecneb
	LTKHj78x9zIrMebrvu3UuUnWu3s0KikTNKf7CJpNuT2mp+RGZJOmfbFOGcTzSIw0t2+E8o/NXB8
	EucJCtAUBtiJN3iv/bmjCxwdoynvhy3FQNI2k+0M
X-Received: by 2002:a05:6122:a2a:b0:5bd:ac34:9823 with SMTP id
 71dfb90a1353d-5bdac34a434mr751457e0c.1.1782719834833; Mon, 29 Jun 2026
 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625102020.92814-1-vimal.agrawal@sophos.com> <20260625214659.1115819-1-kuniyu@google.com>
In-Reply-To: <20260625214659.1115819-1-kuniyu@google.com>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Mon, 29 Jun 2026 13:27:03 +0530
X-Gm-Features: AVVi8Cd2-E129MORS7WWH8yzeK7dveRGPac6nbpTPHmJgI4cyvrsAA2FmVK7kB4
Message-ID: <CALkUMdSzLQSpjpK+cnt=c+dPDZGnyB2zUD3z3KKXr=-DhM7t=Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
To: Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org
Cc: edumazet@google.com, netdev@vger.kernel.org, vimal.agrawal@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:kuba@kernel.org,m:edumazet@google.com,m:netdev@vger.kernel.org,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302501-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sophos.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 851C66D73B6

Hi Kuniyuki,
Thank you for the feedback.
However, the rate limiting issue exists independently of the threshold
values. If entries genuinely exceed gc_thresh3 =E2=80=94 regardless of what=
 it
is set to =E2=80=94 neigh_forced_gc() is called on every allocation attempt
with no rate limiting. In my workload, most entries are
active/reachable with refcnt > 1, so the GC walk traverses the entire
table without reclaiming anything. Increasing gc_thresh3 would make
this worse, not better, as GC now has a larger table to scan on each
call.

Regarding neigh_hash_shift: in my workload, neigh_alloc() returns
ENOBUFS before reaching do_alloc() since GC cannot reclaim any
entries. kzalloc() is never called, so neigh_hash_grow() is not
involved in the latency I observed. The pre-lock time check in
neigh_forced_gc() is a low-cost safeguard that prevents repeated full
table scans regardless of gc_thresh3 value. It does not interfere with
correct GC behaviour =E2=80=94 if entries are still above the threshold, GC
runs normally.


Hi Jakub,
I tested with different threshold values, filling the table completely
with 32k reachable entries and attempting 1000 additional allocations.
Exported neigh_forced_gc so that it can be profiled
                         no change  10ms   50ms   100ms
max cpu usage %          44%        11.8%  2.56%  1.42%
calls > 100us (of 1000)  101        31     13     7

At 10ms, max CPU usage is still 11.8% and 31 out of 1000 calls take
more than 100us. Given that 50ms reduces this to 2.56% and 13 calls
respectively, I would prefer 50ms as the threshold. However, I am open
to further discussion on the right value.

Thanks,
Vimal


On Fri, Jun 26, 2026 at 3:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Vimal Agrawal <avimalin@gmail.com>
> Date: Thu, 25 Jun 2026 10:20:20 +0000
> > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is calle=
d
> > on every allocation attempt with no rate limiting. In workloads with mo=
stly
> > active/reachable entries, the GC walk traverses a large portion of the
> > neighbour table without reclaiming entries, holding tbl->lock for an
> > extended period. This causes severe lock contention and allocation
> > latencies exceeding 16ms under sustained neighbour creation.
> >
> > Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
> > performed within the last second, avoiding repeated full table scans an=
d
> > lock acquisitions on the hot allocation path.
> >
> > Profiling of neigh_create() shows ~3 orders of magnitude latency
> > improvement with this change.
> >
> > Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7s=
SM=3DAEgsq0kywHxTw@mail.gmail.com/
>
> From the thread, these look misconfigured.
>
> ---8<---
> net.ipv6.neigh.default.gc_thresh2 =3D 32768
> net.ipv6.neigh.default.gc_thresh3 =3D 32768
> ---8<---
>
> If gc_thresh3 is larger enough, gc_thresh2 will give you 5s
> rate limiting.
>
> If the number of active neigh entries constantly exceeds
> gc_thresh3, it will be the correct gc_thresh2 for you.
>
> Also, I guess you want a new kernel param for the first
> neigh_hash_alloc(), which is currently fixed for 3, which
> is too small for some hosts.
>
> 50000 entries require neigh_hash_grow() 13 times.
>
> Can you test this on your real workload, starting from
> neigh_hash_shift=3D16 and appropriate gc_thresh2/3 ?
>
> ---8<---
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb64..a75b3750eec9 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1817,6 +1817,22 @@ EXPORT_SYMBOL(neigh_parms_release);
>  static struct lock_class_key neigh_table_proxy_queue_class;
>
>  static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mo=
stly;
> +static __initdata unsigned long neigh_hash_shift =3D 3;
> +
> +static int __init neigh_set_hash_shift(char *str)
> +{
> +       ssize_t ret;
> +
> +       if (!str)
> +               return 0;
> +
> +       ret =3D kstrtoul(str, 0, &neigh_hash_shift);
> +       if (ret)
> +               return 0;
> +
> +       return 1;
> +}
> +__setup("neigh_hash_shift=3D", neigh_set_hash_shift);
>
>  void neigh_table_init(int index, struct neigh_table *tbl)
>  {
> @@ -1843,7 +1859,7 @@ void neigh_table_init(int index, struct neigh_table=
 *tbl)
>                 panic("cannot create neighbour proc dir entry");
>  #endif
>
> -       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
> +       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(neigh_hash_shift));
>
>         phsize =3D (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry *);
>         tbl->phash_buckets =3D kzalloc(phsize, GFP_KERNEL);
> ---8<---
>
>
>
> > Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> > ---
> >  net/core/neighbour.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 1349c0eedb64..078842db3c5f 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *tbl)
> >       int shrunk =3D 0;
> >       int loop =3D 0;
> >
> > +     if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
> > +             return 0;
> > +
> >       NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> >
> >       spin_lock_bh(&tbl->lock);
> > --
> > 2.17.1
> > v

