Return-Path: <netdev+bounces-303545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6xFQBkXQRGoi1QoAu9opvQ
	(envelope-from <netdev+bounces-303545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:31:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086896EB1BC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:31:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jLSjNZMH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303545-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303545-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56A2E3009F0C
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14D31A065;
	Wed,  1 Jul 2026 08:30:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96300374735
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:30:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894651; cv=pass; b=Fc1Ty4XYyPChuudE72V1gRVrZG2S27Vib/SCsXGEc86mDktyKGWxVc079p5FDUBUjCrIu/iJ+STwGUAQIQdUOuVnQbWwv1HoDrxvBGscp4MyZpIVB9Nip3c/mX5KLq7juYWc19iIz6dr1ZvMQ2kVIVQPsa31DYqzxZocFn8y0xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894651; c=relaxed/simple;
	bh=2vAqhxoq+YuVjx9sYbrcW69k7/AHJQq8OFYZR+kFnF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcGNRr+frq1iWR1M59vvl5+CZ2lICo/KZtrqdZ3DzU7lZBYWk2hyAjyjA9cuWnYNtuB+OtKi4j8y5AXK3uBrA3KO8Jo7yPv2vGESd1o8ucEXBDEDPVAUBeMKZ2XoT0Fcqn2dMl7doHyMsf3Ci06z1i9iGYLjadZMn5MbROPcasg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLSjNZMH; arc=pass smtp.client-ip=209.85.221.182
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bbfc48715fso838772e0c.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782894648; cv=none;
        d=google.com; s=arc-20260327;
        b=sU1yyHlpNvh8hHlurXpUPz8huCxgmFMW6ey9HoO+Vbi/ZcOxdhFPQ/XljQ7BdVYeor
         gZE3pag9CZi6qil6kB2KPaxNd19bEewbjLP2oRKc2Cfxu1QwamV3vJYMB3uNSmOD504g
         Sj518+uJkugYoMS+3gMm7SwHDM6Z87jTnWdgwo0dNQLxBKNzwVAm+G0liInFucmNV5nl
         NzUKmuYd1wsHwAiE/sp8VBpajJO7JGX0YEGgE0tIJbeBtQPlqp5FpJqyH8La747BGdPn
         jq17Xm0mVLlVAm3/2IxzJhreOyOpCSZpJv2TkXN2FpIY3QRhchiuSIWff2ayE5WccD0R
         ykDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dTlzVKeWlXiUw0nFQCxSSk3lxndMDArj7zo5FAbDa2g=;
        fh=9xpVUVkTGrn1FZ+DouQ+5I9UMo6S4+dd5VJ47yCLVUw=;
        b=SklLTsKvUnNFAjXbO/W03HFg7AiPNs3qlMkifpzCie+9Upkx/g53fKcDxd6P6wp6iv
         0aSlFpeHUIi1XQ6Yw2CcfQXbH+VFAOqLaky8tJDO/EXNmxd5la7PWUPXevvfZM7O90BD
         yMk7Ff8aSJOpXU8jHOWJcCh/fEWgHWjx9IWKKtH1L5s1YMb/aAEmYx3ZhTzLjN8lB31I
         9+tqDai0ZQUmDmHWgGgNT9bSvHDzZr691DoAOR8B0b/KWhkmxS8GcKcFEd34oKxCZgFr
         ua7PKAV1AVrHZqLcpHAU8DyiaQ4Qi9MmeqkmbJ5TQGMFjw3X2pfoIIMzn4B5jUzlXcMo
         DwsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782894648; x=1783499448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTlzVKeWlXiUw0nFQCxSSk3lxndMDArj7zo5FAbDa2g=;
        b=jLSjNZMHnXLmjvneqjeHLAq5jp2La5E+PqPu+AKGq4mc5Sli2JiFWk7RTvOt+xzkYZ
         9KECVbKL4MbdfJyEkI6RRosVc9bQQ109lX9ZWvsAdYdrE9MkyExSfFVo7VFB+W9AP6mx
         tzGxmrQt4z9T54PYM4tWJwTqZbxFQ2AGue1DNyGM5xdaLOFHPPXmuZkfON6vH0TG2KII
         /fsHhKm1DfhOx/iadr2n/vir2sZZbSkdQP7Lo3gFmDTBVZHdhx2Ldk5TWT86zCurGaN1
         maNJFs5WRHFRHJlnByuZll0BLgkhYRT64e+vvgbNfAyuderCIfgBPGJBwY7aMhj06OOT
         J7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894648; x=1783499448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTlzVKeWlXiUw0nFQCxSSk3lxndMDArj7zo5FAbDa2g=;
        b=EuijoSwmLbHECs+EOWLmhWWOD8VZlsxgT1sDKGLNkU9UPc1Wr8be1zjBXC5JnkzwC0
         sBt6KPtp0K/3IS9HnQti7xUf52VILDcZg5F0ymetLy3jnVpA/MUBq6wyKfLpAyA/GZyJ
         XHlhXwFGvS1IK3aQ5HHYhWIAMlgFmID/2IyQ9BsOy+Eh61uCZwBnoNPhtpDTeSd+7vX3
         Jx6u/oYJqnryF3LXrQFKNGlpz6PLy7/Wm7LlagbP1RoHJwRAbZ+MmYjpv0+3vQln0giM
         1ujW+Q9iKthXayOA4YxBT8cCF2DWELoOgZekjnH9cYY4NQsVjT9KL0RtKEsg61LHVDy0
         vG7w==
X-Forwarded-Encrypted: i=1; AHgh+RrR02ABdnHz8Fptio6JNptHNBYuXzc1xxM8WbNaMm/JxYiii/CKgsujKLDWn8TG7JNLSHT0q5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws883Rwv7HOqnAdizfZuSK/dZMtl5bqkeT3OwsecjnPqV3ke2I
	fUPDI0Gp7g3P5JfLXMQddUzHm+PZuPcSfQQSuTZ7LgUecJkIAcOFN63WwonJG7wqqwuaw9594Qc
	vWO1FHYMFVc9Txq+u7S3s5SMsyGI4RdA=
X-Gm-Gg: AfdE7cmhqpXsSwY49cL9TtKb/sx8Ie5rf7NaFhxPxYvHK6XG5gTReJA2cwvk/Tc5uvS
	AYr6HF2ZeaBA9SvkFd09bvhC1p2q8XGzUCZlNZUsuuoserz/qWBWRbyYuyT24TWa+Zci0V3ygKA
	MtNEHzqpQJrriv8noDB6bEXmwKeXxdzD+fIB4k4k1sisSFYjQL25dUvziO59BY6AMGkAk6mtDgy
	xSNRGhv8NdUtHvrNH99D0dY6v9hyepkRKbA4NeaunrXo1+lyJZUm9Lx0ANdJVAhybh0BJWaJSs7
	bLCdy+OZOhoVhSKsl52PUuUQxUIw
X-Received: by 2002:a05:6122:8710:b0:5bb:e5dd:d93d with SMTP id
 71dfb90a1353d-5bdc920db63mr1654446e0c.0.1782894648417; Wed, 01 Jul 2026
 01:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625102020.92814-1-vimal.agrawal@sophos.com>
 <20260625214659.1115819-1-kuniyu@google.com> <CALkUMdSzLQSpjpK+cnt=c+dPDZGnyB2zUD3z3KKXr=-DhM7t=Q@mail.gmail.com>
 <CAAVpQUA4dyukqihiQoGfbaPtBn1OAaRaWyQ197+hPs7gmqW7=Q@mail.gmail.com>
 <CALkUMdTCYQDe3aR8mvSDMjkmYhXZRJf1S6sMRRkaem+_=Yk9WA@mail.gmail.com> <CAAVpQUAN87UybUdiCy_A+UThmAN9haB2ie2-usW4qZoY31XEGA@mail.gmail.com>
In-Reply-To: <CAAVpQUAN87UybUdiCy_A+UThmAN9haB2ie2-usW4qZoY31XEGA@mail.gmail.com>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Wed, 1 Jul 2026 14:00:36 +0530
X-Gm-Features: AVVi8CfnQH_vHSaW_pbUJyGDCTOQJUmApWSLi-UoTDCC8rwUQsYc6SRCiBTaRE8
Message-ID: <CALkUMdQMeRd_pu5mK+JKrJYSvLAzuv0H+ag98oXDvTxx_Fg9AA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-303545-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 086896EB1BC

Hi Kuniyuki,

I understand the recommendation to set gc_thresh3 =3D gc_thresh2 +
headroom. However, in field deployments the neighbour table size can
be unpredictable =E2=80=94 traffic patterns, routing changes, and network
events can cause transient spikes that exceed even a well-configured
gc_thresh3.

We have reproduced this with 32k IXIA clients where we observed soft
lockups under sustained neighbour creation. This is what originally
motivated the investigation.

The current behaviour when gc_thresh3 is exceeded =E2=80=94 calling
neigh_forced_gc() on every allocation with no rate limiting =E2=80=94 is
unnecessarily severe. It causes lock contention proportional to the
table size on every allocation attempt, even briefly exceeding
gc_thresh3 results in significant latency impact.

The patch does not change GC semantics or thresholds. It simply
prevents repeated full table scans within a short window, which is
harmless when GC is effective and protective when it is not. This
seems like a reasonable defensive improvement regardless of how
thresholds are configured.


Thanks,
Vimal

On Tue, Jun 30, 2026 at 10:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Tue, Jun 30, 2026 at 5:01=E2=80=AFAM Vimal Agrawal <avimalin@gmail.com=
> wrote:
> >
> > Hi Kuniyuki,
> >
> > You are correct that in this specific test case GC does not help since
> > all entries are active/reachable. However, this is not the only
> > scenario where entries can exceed gc_thresh3.
> >
> > In a real workload, the table can exceed gc_thresh3 with a mix of
> > active and stale entries. In that case GC does help, but should not be
> > called on every allocation attempt =E2=80=94 once per 50ms is sufficien=
t for
> > GC to make progress without causing lock contention.
>
> My mental model is that gc_thresh3 is the hard limit while gc_thresh2
> is the soft limit, so if the total number of entries often exceeds gc_thr=
esh3,
> it's clearly wrong.
>
> I think you need to set gc_thresh2 to a proper baseline (it sounds like
> your current gc_thresh3 is the one) and gc_thresh3 to gc_thresh2+X
> where X covers fluctuations.
>
>
> >
> > The rate limiting also protects against the case where GC cannot
> > reclaim anything. Without it, every allocation attempt above
> > gc_thresh3 triggers a full table scan holding tbl->lock, even when GC
> > has no work to do.
> >
> > Thanks,
> > Vimal
> >
> > On Mon, Jun 29, 2026 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > >
> > > On Mon, Jun 29, 2026 at 12:57=E2=80=AFAM Vimal Agrawal <avimalin@gmai=
l.com> wrote:
> > > >
> > > > Hi Kuniyuki,
> > > > Thank you for the feedback.
> > > > However, the rate limiting issue exists independently of the thresh=
old
> > > > values. If entries genuinely exceed gc_thresh3 =E2=80=94 regardless=
 of what it
> > > > is set to =E2=80=94 neigh_forced_gc() is called on every allocation=
 attempt
> > > > with no rate limiting. In my workload, most entries are
> > > > active/reachable with refcnt > 1, so the GC walk traverses the enti=
re
> > > > table without reclaiming anything.
> > >
> > > This suggests your gc_thresh2/3 do not fit your use case.
> > >
> > > If GC does not help, there is no point in running it or rate-limiting
> > > in the first place.
> > >
> > >
> > > > Increasing gc_thresh3 would make
> > > > this worse, not better, as GC now has a larger table to scan on eac=
h
> > > > call.
> > >
> > > If you just increase gc_thresh3 slightly, then yes, it won't help.
> > >
> > >
> > > >
> > > > Regarding neigh_hash_shift: in my workload, neigh_alloc() returns
> > > > ENOBUFS before reaching do_alloc() since GC cannot reclaim any
> > > > entries. kzalloc() is never called, so neigh_hash_grow() is not
> > > > involved in the latency I observed. The pre-lock time check in
> > > > neigh_forced_gc() is a low-cost safeguard that prevents repeated fu=
ll
> > > > table scans regardless of gc_thresh3 value. It does not interfere w=
ith
> > > > correct GC behaviour =E2=80=94 if entries are still above the thres=
hold, GC
> > > > runs normally.
> > > >
> > > >
> > > > Hi Jakub,
> > > > I tested with different threshold values, filling the table complet=
ely
> > > > with 32k reachable entries and attempting 1000 additional allocatio=
ns.
> > > > Exported neigh_forced_gc so that it can be profiled
> > > >                          no change  10ms   50ms   100ms
> > > > max cpu usage %          44%        11.8%  2.56%  1.42%
> > > > calls > 100us (of 1000)  101        31     13     7
> > > >
> > > > At 10ms, max CPU usage is still 11.8% and 31 out of 1000 calls take
> > > > more than 100us. Given that 50ms reduces this to 2.56% and 13 calls
> > > > respectively, I would prefer 50ms as the threshold. However, I am o=
pen
> > > > to further discussion on the right value.
> > > >
> > > > Thanks,
> > > > Vimal
> > > >
> > > >
> > > > On Fri, Jun 26, 2026 at 3:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> > > > >
> > > > > From: Vimal Agrawal <avimalin@gmail.com>
> > > > > Date: Thu, 25 Jun 2026 10:20:20 +0000
> > > > > > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() =
is called
> > > > > > on every allocation attempt with no rate limiting. In workloads=
 with mostly
> > > > > > active/reachable entries, the GC walk traverses a large portion=
 of the
> > > > > > neighbour table without reclaiming entries, holding tbl->lock f=
or an
> > > > > > extended period. This causes severe lock contention and allocat=
ion
> > > > > > latencies exceeding 16ms under sustained neighbour creation.
> > > > > >
> > > > > > Add a pre-lock check in neigh_forced_gc() to skip the GC run if=
 one was
> > > > > > performed within the last second, avoiding repeated full table =
scans and
> > > > > > lock acquisitions on the hot allocation path.
> > > > > >
> > > > > > Profiling of neigh_create() shows ~3 orders of magnitude latenc=
y
> > > > > > improvement with this change.
> > > > > >
> > > > > > Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yio=
O1nQWx7sSM=3DAEgsq0kywHxTw@mail.gmail.com/
> > > > >
> > > > > From the thread, these look misconfigured.
> > > > >
> > > > > ---8<---
> > > > > net.ipv6.neigh.default.gc_thresh2 =3D 32768
> > > > > net.ipv6.neigh.default.gc_thresh3 =3D 32768
> > > > > ---8<---
> > > > >
> > > > > If gc_thresh3 is larger enough, gc_thresh2 will give you 5s
> > > > > rate limiting.
> > > > >
> > > > > If the number of active neigh entries constantly exceeds
> > > > > gc_thresh3, it will be the correct gc_thresh2 for you.
> > > > >
> > > > > Also, I guess you want a new kernel param for the first
> > > > > neigh_hash_alloc(), which is currently fixed for 3, which
> > > > > is too small for some hosts.
> > > > >
> > > > > 50000 entries require neigh_hash_grow() 13 times.
> > > > >
> > > > > Can you test this on your real workload, starting from
> > > > > neigh_hash_shift=3D16 and appropriate gc_thresh2/3 ?
> > > > >
> > > > > ---8<---
> > > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > > index 1349c0eedb64..a75b3750eec9 100644
> > > > > --- a/net/core/neighbour.c
> > > > > +++ b/net/core/neighbour.c
> > > > > @@ -1817,6 +1817,22 @@ EXPORT_SYMBOL(neigh_parms_release);
> > > > >  static struct lock_class_key neigh_table_proxy_queue_class;
> > > > >
> > > > >  static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] _=
_read_mostly;
> > > > > +static __initdata unsigned long neigh_hash_shift =3D 3;
> > > > > +
> > > > > +static int __init neigh_set_hash_shift(char *str)
> > > > > +{
> > > > > +       ssize_t ret;
> > > > > +
> > > > > +       if (!str)
> > > > > +               return 0;
> > > > > +
> > > > > +       ret =3D kstrtoul(str, 0, &neigh_hash_shift);
> > > > > +       if (ret)
> > > > > +               return 0;
> > > > > +
> > > > > +       return 1;
> > > > > +}
> > > > > +__setup("neigh_hash_shift=3D", neigh_set_hash_shift);
> > > > >
> > > > >  void neigh_table_init(int index, struct neigh_table *tbl)
> > > > >  {
> > > > > @@ -1843,7 +1859,7 @@ void neigh_table_init(int index, struct nei=
gh_table *tbl)
> > > > >                 panic("cannot create neighbour proc dir entry");
> > > > >  #endif
> > > > >
> > > > > -       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
> > > > > +       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(neigh_hash_sh=
ift));
> > > > >
> > > > >         phsize =3D (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_e=
ntry *);
> > > > >         tbl->phash_buckets =3D kzalloc(phsize, GFP_KERNEL);
> > > > > ---8<---
> > > > >
> > > > >
> > > > >
> > > > > > Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> > > > > > ---
> > > > > >  net/core/neighbour.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > > > index 1349c0eedb64..078842db3c5f 100644
> > > > > > --- a/net/core/neighbour.c
> > > > > > +++ b/net/core/neighbour.c
> > > > > > @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_tab=
le *tbl)
> > > > > >       int shrunk =3D 0;
> > > > > >       int loop =3D 0;
> > > > > >
> > > > > > +     if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ)=
)
> > > > > > +             return 0;
> > > > > > +
> > > > > >       NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> > > > > >
> > > > > >       spin_lock_bh(&tbl->lock);
> > > > > > --
> > > > > > 2.17.1
> > > > > > v

