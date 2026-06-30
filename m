Return-Path: <netdev+bounces-303300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UrIJCbHxQ2rVlwoAu9opvQ
	(envelope-from <netdev+bounces-303300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102216E68D9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:41:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=di8XLbuL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303300-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303300-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC7E3033AC2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B777F3B4E8A;
	Tue, 30 Jun 2026 16:36:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD525B0B7
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:36:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837408; cv=pass; b=YSttxYgCJ+L1vCLlwH9GTBBuRTV0nrxf1pB7naqJfLQ4GAwTgJB+Cly3WEMj1oUXAIWTiwpHN2yGodvSzmFDj90CzOlD7i4GKtHXJVQY8g5X6SLRUbpd90zpYEUTkTeIDSN+1Ms50eHX7bCEfsKf5ZZC/tYMmY3uW1PPpxQWT98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837408; c=relaxed/simple;
	bh=QbIZIvDJF4lDcecb+rf0A7vl2bO/Fr8rKZ6Ur+brHXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVQ+tVnwpnIzjTFhM0/l9n3NILyja97P1elAxk9FMW3mSwRZo7nNbo2nKpuzM3rVryUCdlPtgtIwoDQosmG2pr2i1g4hVYcQvVCHGIeUYaz1DUe/WE10fsE5SBu8cSdReNUm3N9IXQdHSf1h98w8fFWZk2CLGIMi2m1RNGNLluc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=di8XLbuL; arc=pass smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13b2d7dc8d1so1398225c88.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782837406; cv=none;
        d=google.com; s=arc-20260327;
        b=szgPfBqUFP9zbsxg/5MBhPXg6pCGnkzovtI53Dh3bgJy+r7i8V6UPQQEqwSLoCiV1D
         JcoLB6rTXvlqIbqZMZERgeDp/aGEkjJSjj5CmLIBAtS3AASWDFRDWfNnTLbTMnHvFpbq
         BvvBfTP1Bcq7IKagh2EcpJJ38IAdIhjSCK+3BtVv++gxUhC8TkXcxOYEicPHzQQe4dIh
         X9faEzE/Mr8YxwhobK4N6CDHZNSJAo0TdiWBelOqOZFbDHF0cxCmlcsupc51aZmTHbKW
         gNc8XPTeoiGUnYNJC0pcqQW+lUddI5oz2WSoeCyrxjJU4xaQwtv/3UfVVoLxYy2nnNZJ
         aJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yWcf0VOcI4ztos5q5Aza7NDXI+gce4H/HjJL7sl4WuI=;
        fh=gVy05R5ErcwyFbMwf1vXoVG8svH794lWHzs3hQzMN2c=;
        b=RqAEWbRea1mNj/NLvALZcrVd8z1T8LFxdNpodHub3iny0y/vL8N55qwASz0bP6RSTw
         JZntafSQkdku+yEgW68eCIj1sjuPboOqttR8qwSPny4KpWXYCBQ1HSjSV+uPT+oKD9Dp
         YYWJoHswg+5JiYrCfQo7l/BrvzZMrnjV8eHFKRoFG8W4FsBurD7JPUWM3FkKGCV+9W4r
         eEJRIAOWqR0F1Zb8fWmDvTLuQbnS1AEKX1B8jzf8UjSvEI339L9R5hXd6VCrj+SsMLZa
         B/pBjmqvUNemnuW23Izro0dEJXemzfo0AvCSgv1ZCR4pnbQPlcSXmhVQZXr9GbiT9owQ
         kh5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782837406; x=1783442206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWcf0VOcI4ztos5q5Aza7NDXI+gce4H/HjJL7sl4WuI=;
        b=di8XLbuLu2tHGjhedqn9WkVmaOqASWo+AO/ez1/HG26kFAZLBxtKdFz1uZwaR4GEl/
         UlG5V+g4C8qJpJ1wFC+NFLSDkfcRydBpsfigv1AucnTTAVKHB+Kp0Syz9XtwwN7LgXHZ
         uGb6nsn2gCQ859N5Myc2GRcWL/V5XqgUkzaMXXmmKERIIz7NUDj9Zpe+Mur+rGlSml82
         VqPSieRyav8BUNLpCJdOFbk92Jzqbc8I45p9oCqIvZB1mcyGVIQ5J38xk+jBqk0PwBhJ
         A5ewNrkHaciFGdqlku4j6w1zY7X6WJPxdVx7hLCNZDIHY+cq7Np66ULACvX91vTf7YSO
         UA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837406; x=1783442206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWcf0VOcI4ztos5q5Aza7NDXI+gce4H/HjJL7sl4WuI=;
        b=KV3Nv1F9x3V4X05LW9lTWLFwYs9tu6VYJhkYIrv/p701WypXe3JQLEsy+d48ziFRdu
         PjADKk13TzipBvQuEwj4R/Ybg86uxZkFFUusTIxi9hajmnK4wE7xxoIz1oZhiKwLCUMu
         V6IaAqh6O7BDPIbh+RJ9ob/TlyR+28N0GuR18iT56QXwZgM5Vi8b1GA2y+DfoAX147zo
         wgUCMAQG/yZZNcjGLc+TLrUbIjqaxQgvTpsdeCl6AIF8cBKaFVFysFnP5gwahMCSLLnW
         5/TLhgqm2G+kQL1mgnN4Wo+V1ifHP3qdA630kgWj9H5GeHe5Tb7aqZujsF6fRf37vz30
         FY2w==
X-Forwarded-Encrypted: i=1; AFNElJ+jAkQr0DZaVkEGV6c0alWvW5TOqIhyE3+RI4bRgN6/zJD5ZIrmmi9ye3Q6NJF2wj3pggGtzQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/Y3oDQa8UIbz7Lm4+E1lAdyze3ckTRQj4ka420hRNkD4f/Ws
	SEPsWt8xrahFAm7jC59GtSLkzUbnQMrhDwWYCP7pLXvwDFehPlxm74o+caVJDtB08fj3s5evsmw
	GXuF9rgLqkmErBC53mgtr3yXITK1Omdo2bmJy23DP
X-Gm-Gg: AfdE7cm/wyLc23hvEKrmtiESClNDjh6wxCgIyZAtHYAf0xkMzKTBcegm3+k5AeC2UvC
	J101fwtaWqipkSxlaAaWShZePyW7y0j2U2JcAeuG9AwOKum4r5TjAw7O0HbybIvEpX6rxL7yTzw
	gLtGrXYYfZh3M5sPq+AjIqT92UdydkBHsjvE6hsH19h6z8/vCQg4M7aG0RaQokMrRbpHqqj0Jjy
	HvuiQsKfVderBufou91zY49a8hj4zADILmMTk8XI6iySvelgNab5eGJJkJUXuz5ojQffylvrLDm
	F4BLsWF4JyqL3RFjUvjxZ40ad14KZi+y647qy2gSzKsSosAqGAB+f9dg5PkroHXvHFVCwAMIFCu
	dS+Gae9iW62fir13/aoXO54C99hgSftEV2qrdun+MndVZ/HA6
X-Received: by 2002:a05:7022:f9c:b0:137:fc2b:1efe with SMTP id
 a92af1059eb24-13b2a15d7d6mr2779292c88.11.1782837405003; Tue, 30 Jun 2026
 09:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625102020.92814-1-vimal.agrawal@sophos.com>
 <20260625214659.1115819-1-kuniyu@google.com> <CALkUMdSzLQSpjpK+cnt=c+dPDZGnyB2zUD3z3KKXr=-DhM7t=Q@mail.gmail.com>
 <CAAVpQUA4dyukqihiQoGfbaPtBn1OAaRaWyQ197+hPs7gmqW7=Q@mail.gmail.com> <CALkUMdTCYQDe3aR8mvSDMjkmYhXZRJf1S6sMRRkaem+_=Yk9WA@mail.gmail.com>
In-Reply-To: <CALkUMdTCYQDe3aR8mvSDMjkmYhXZRJf1S6sMRRkaem+_=Yk9WA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:36:32 -0700
X-Gm-Features: AVVi8CfNo9hI9d8wku84Qqa0GiyzQpF_OoEknU7jUfLD1E_FfR48uz-xBVtPNCY
Message-ID: <CAAVpQUAN87UybUdiCy_A+UThmAN9haB2ie2-usW4qZoY31XEGA@mail.gmail.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avimalin@gmail.com,m:kuba@kernel.org,m:edumazet@google.com,m:netdev@vger.kernel.org,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303300-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 102216E68D9

On Tue, Jun 30, 2026 at 5:01=E2=80=AFAM Vimal Agrawal <avimalin@gmail.com> =
wrote:
>
> Hi Kuniyuki,
>
> You are correct that in this specific test case GC does not help since
> all entries are active/reachable. However, this is not the only
> scenario where entries can exceed gc_thresh3.
>
> In a real workload, the table can exceed gc_thresh3 with a mix of
> active and stale entries. In that case GC does help, but should not be
> called on every allocation attempt =E2=80=94 once per 50ms is sufficient =
for
> GC to make progress without causing lock contention.

My mental model is that gc_thresh3 is the hard limit while gc_thresh2
is the soft limit, so if the total number of entries often exceeds gc_thres=
h3,
it's clearly wrong.

I think you need to set gc_thresh2 to a proper baseline (it sounds like
your current gc_thresh3 is the one) and gc_thresh3 to gc_thresh2+X
where X covers fluctuations.


>
> The rate limiting also protects against the case where GC cannot
> reclaim anything. Without it, every allocation attempt above
> gc_thresh3 triggers a full table scan holding tbl->lock, even when GC
> has no work to do.
>
> Thanks,
> Vimal
>
> On Mon, Jun 29, 2026 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > On Mon, Jun 29, 2026 at 12:57=E2=80=AFAM Vimal Agrawal <avimalin@gmail.=
com> wrote:
> > >
> > > Hi Kuniyuki,
> > > Thank you for the feedback.
> > > However, the rate limiting issue exists independently of the threshol=
d
> > > values. If entries genuinely exceed gc_thresh3 =E2=80=94 regardless o=
f what it
> > > is set to =E2=80=94 neigh_forced_gc() is called on every allocation a=
ttempt
> > > with no rate limiting. In my workload, most entries are
> > > active/reachable with refcnt > 1, so the GC walk traverses the entire
> > > table without reclaiming anything.
> >
> > This suggests your gc_thresh2/3 do not fit your use case.
> >
> > If GC does not help, there is no point in running it or rate-limiting
> > in the first place.
> >
> >
> > > Increasing gc_thresh3 would make
> > > this worse, not better, as GC now has a larger table to scan on each
> > > call.
> >
> > If you just increase gc_thresh3 slightly, then yes, it won't help.
> >
> >
> > >
> > > Regarding neigh_hash_shift: in my workload, neigh_alloc() returns
> > > ENOBUFS before reaching do_alloc() since GC cannot reclaim any
> > > entries. kzalloc() is never called, so neigh_hash_grow() is not
> > > involved in the latency I observed. The pre-lock time check in
> > > neigh_forced_gc() is a low-cost safeguard that prevents repeated full
> > > table scans regardless of gc_thresh3 value. It does not interfere wit=
h
> > > correct GC behaviour =E2=80=94 if entries are still above the thresho=
ld, GC
> > > runs normally.
> > >
> > >
> > > Hi Jakub,
> > > I tested with different threshold values, filling the table completel=
y
> > > with 32k reachable entries and attempting 1000 additional allocations=
.
> > > Exported neigh_forced_gc so that it can be profiled
> > >                          no change  10ms   50ms   100ms
> > > max cpu usage %          44%        11.8%  2.56%  1.42%
> > > calls > 100us (of 1000)  101        31     13     7
> > >
> > > At 10ms, max CPU usage is still 11.8% and 31 out of 1000 calls take
> > > more than 100us. Given that 50ms reduces this to 2.56% and 13 calls
> > > respectively, I would prefer 50ms as the threshold. However, I am ope=
n
> > > to further discussion on the right value.
> > >
> > > Thanks,
> > > Vimal
> > >
> > >
> > > On Fri, Jun 26, 2026 at 3:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > From: Vimal Agrawal <avimalin@gmail.com>
> > > > Date: Thu, 25 Jun 2026 10:20:20 +0000
> > > > > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is=
 called
> > > > > on every allocation attempt with no rate limiting. In workloads w=
ith mostly
> > > > > active/reachable entries, the GC walk traverses a large portion o=
f the
> > > > > neighbour table without reclaiming entries, holding tbl->lock for=
 an
> > > > > extended period. This causes severe lock contention and allocatio=
n
> > > > > latencies exceeding 16ms under sustained neighbour creation.
> > > > >
> > > > > Add a pre-lock check in neigh_forced_gc() to skip the GC run if o=
ne was
> > > > > performed within the last second, avoiding repeated full table sc=
ans and
> > > > > lock acquisitions on the hot allocation path.
> > > > >
> > > > > Profiling of neigh_create() shows ~3 orders of magnitude latency
> > > > > improvement with this change.
> > > > >
> > > > > Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1=
nQWx7sSM=3DAEgsq0kywHxTw@mail.gmail.com/
> > > >
> > > > From the thread, these look misconfigured.
> > > >
> > > > ---8<---
> > > > net.ipv6.neigh.default.gc_thresh2 =3D 32768
> > > > net.ipv6.neigh.default.gc_thresh3 =3D 32768
> > > > ---8<---
> > > >
> > > > If gc_thresh3 is larger enough, gc_thresh2 will give you 5s
> > > > rate limiting.
> > > >
> > > > If the number of active neigh entries constantly exceeds
> > > > gc_thresh3, it will be the correct gc_thresh2 for you.
> > > >
> > > > Also, I guess you want a new kernel param for the first
> > > > neigh_hash_alloc(), which is currently fixed for 3, which
> > > > is too small for some hosts.
> > > >
> > > > 50000 entries require neigh_hash_grow() 13 times.
> > > >
> > > > Can you test this on your real workload, starting from
> > > > neigh_hash_shift=3D16 and appropriate gc_thresh2/3 ?
> > > >
> > > > ---8<---
> > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > index 1349c0eedb64..a75b3750eec9 100644
> > > > --- a/net/core/neighbour.c
> > > > +++ b/net/core/neighbour.c
> > > > @@ -1817,6 +1817,22 @@ EXPORT_SYMBOL(neigh_parms_release);
> > > >  static struct lock_class_key neigh_table_proxy_queue_class;
> > > >
> > > >  static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __r=
ead_mostly;
> > > > +static __initdata unsigned long neigh_hash_shift =3D 3;
> > > > +
> > > > +static int __init neigh_set_hash_shift(char *str)
> > > > +{
> > > > +       ssize_t ret;
> > > > +
> > > > +       if (!str)
> > > > +               return 0;
> > > > +
> > > > +       ret =3D kstrtoul(str, 0, &neigh_hash_shift);
> > > > +       if (ret)
> > > > +               return 0;
> > > > +
> > > > +       return 1;
> > > > +}
> > > > +__setup("neigh_hash_shift=3D", neigh_set_hash_shift);
> > > >
> > > >  void neigh_table_init(int index, struct neigh_table *tbl)
> > > >  {
> > > > @@ -1843,7 +1859,7 @@ void neigh_table_init(int index, struct neigh=
_table *tbl)
> > > >                 panic("cannot create neighbour proc dir entry");
> > > >  #endif
> > > >
> > > > -       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
> > > > +       RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(neigh_hash_shif=
t));
> > > >
> > > >         phsize =3D (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_ent=
ry *);
> > > >         tbl->phash_buckets =3D kzalloc(phsize, GFP_KERNEL);
> > > > ---8<---
> > > >
> > > >
> > > >
> > > > > Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> > > > > ---
> > > > >  net/core/neighbour.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > > index 1349c0eedb64..078842db3c5f 100644
> > > > > --- a/net/core/neighbour.c
> > > > > +++ b/net/core/neighbour.c
> > > > > @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table=
 *tbl)
> > > > >       int shrunk =3D 0;
> > > > >       int loop =3D 0;
> > > > >
> > > > > +     if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
> > > > > +             return 0;
> > > > > +
> > > > >       NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> > > > >
> > > > >       spin_lock_bh(&tbl->lock);
> > > > > --
> > > > > 2.17.1
> > > > > v

