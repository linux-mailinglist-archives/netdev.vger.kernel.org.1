Return-Path: <netdev+bounces-268238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGFSJlVDuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD129E90A
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4A67300DF5D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884E33859C;
	Mon, 16 Mar 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zcty9oVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1121576E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683537; cv=pass; b=FNof/vDPHyIjbbiRYiNfz21EBVNZIZQtmnUOIXfk4GxL1GanOJR5qO9jNZuUqlzyKBWP+dDCAh2eY4Amg4ysMraDGMeLdy2m4WotXkfk3k6hpQOr7WySuZCg14Re+VRzzkzqyNwQP30VmgoVuxt9ocUsNKpO5I50R/5dhDUPaYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683537; c=relaxed/simple;
	bh=MbC6uMUT+zuv5iFSt6iGnCeFySwpAstad5vSboyQO7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbM4DzZAY8eAPKnc73XGeK4hbHvHGFJ4f2dfSU2uzsu2nHMN4SjUMgWLdGsvutasC+GKs325KvXll7CgiJNgpGHrrMeiNdYEAjJe+orC6TtuPuHal0tdFadrbMjBwpKvHFbgkYSOZJD9JbC4XbCx3nKB7fKVHMHxRBOS6UAtis8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zcty9oVt; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a13374cf6so4339828b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683534; cv=none;
        d=google.com; s=arc-20240605;
        b=Lr5ha0pMLQ2tNvrlUpS/ltW/AulIs9014Sm+c6S8vbsPONtvznovyRxDFbAWiJ8icv
         tRuYJjVGhOlVly870oFdPMgZlAuf9ADvYYPBwjeLV39x971el42kasVPEqtNmoiMXypO
         xejO0y5cJaQzyBiJfu/6u8gG/gh6O46h5xFoYHCdKbOwvoYasCk6NoYIsF8DCwGTRVy9
         9oZzyuVQVxJ8RiG31hv06aMYATPmo3HlxEhHL6QauaNYzwj8kphC2lczM186y/ZT8UML
         6OA1LAL+kF7hF/NSzmx53vcjDiY7R2A8DN1LWEmRbVFr9llUSKfOTECpLIuu1xmD90eI
         3B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PeRxadn+pkJDqWBwQlbJ6Bu0N7NNd6VUX/BiAi/6qTw=;
        fh=C0Pd76hVwM/uGr4A/cn7OTzLHq3lq6ubXF8EN+USUbQ=;
        b=JwQCKsVB2e8oSeTLPMW8kla+zNz3ld+VHuCTuKflApY/uAGWO/0SAGR7qdvehjnmUM
         WHHHRyJ8QaiP1+L5lbCLFWw5uDsPjkhT2Y1e54d3UW7Q5CtTLipQux6Jr99GzHDt/nzO
         IW+iXB6BaravO3oWKhJgZ2lei/Kl+xrXCw9sUu377XM8oTQKMpwMdsUT9Wd240udXcc3
         EzCMouJCM6eOgyXra1iyMyI7/nXxYofBj8vCxI7zzGXC930SeCpSyBOEKPlm+sufT8yy
         9NBWghi6M6ykm8twz9BnlOqVUKILFgCs+ZOI9TO+XJrNSD+5O1aGY6fPHRpRlVOH2Hc/
         bzxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773683534; x=1774288334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeRxadn+pkJDqWBwQlbJ6Bu0N7NNd6VUX/BiAi/6qTw=;
        b=zcty9oVtUVo7ByzJ84YMMHwMaRt1ln15UCPA6Yd0MBmvCex18Z7C2wYZAFO3fNsCeO
         f+IKCy/p4DT1J+QViqpTvh/XbaTybbJn7Cg7cL3c2NnJGbTvM3sY7m5qQLHoPoUNz/B8
         vxZfGgfclN+JrA6Sar24PATYipaIJE4O0ii3STrqkBUN69KEH2BAgzVPiAn4nGLVOzsd
         ms5wgP5WIifDhBmp0VgK05t6njuG0BnNOOdJ8iDMKmB0BYDCVSZGrYcTGmFxs+MfH64w
         MKlv1hA1Ade8TnIwaMBd0i47qQIXWqDqpcCNchvwAz6EZ127+4lFuGxTQBbI+XO2fQ9M
         EIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683534; x=1774288334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PeRxadn+pkJDqWBwQlbJ6Bu0N7NNd6VUX/BiAi/6qTw=;
        b=c2FCHUNk++BVMvPfNMGzDuls4NgBUzzTTl3J0X6vMzr0OieTXJSpff+Ia5rPN6wc1k
         hJMHe+P65RPwOMnIjF7iimcb4n/R3yyTYkMg+OhKWS0TCe62x30IbjnrVeZkjkDloDjg
         8vYqKq1xslPhtZYQwrlzN6caa1YTDQWKb5BNRlKmPCG3L1xivh9Xbvsj4+VEOEKeUu/Q
         bzXPweYLjyNxs64j4CRj2+GedPlw6P8UmfTlyuiQ3Zoewa+qej4dTrz8MXDv+PmhoR2A
         kcI5A2EBgsiXzjUWvuic5U+mCPR5OcZdUt8NjQBzdHObzBfM6NrLUP+Q2cIsV1rKVWu5
         Agyw==
X-Forwarded-Encrypted: i=1; AJvYcCV4SvNjQ+RsSfr19kO4gtQAqwDaEtH5qp1LUCmez1WmZ0Y1bGAHd4rzTBp/s33FMW+0BtzlCX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmiuusmOepEgHULCQKf+/kJaspgZnXIn7pxdfdEo9IIzeLxn1X
	13Nfpl1PEXjodTaYBmYJ5XQ+Hz83zpm1ymp5qXUIrdKHMBlpCzjsFs42Rbx8vhtzrq7E4mDOeRf
	O3dzxEuIiwB6eE2U+zRY+aaKXvfmGktiu12QeudFvysKdbQyDsRDUrA==
X-Gm-Gg: ATEYQzzIMWDJMf1Jlh6GOWjeAFM80KeAkg5RlH1V5fLzlCnq0E0vXmgTdqSwFEgizYx
	WLo1KAiNNCPJTN5yl22Xg3cELx3By3t5xiX2h8JBpFg9tytzyi9/tV9dPF9fi4120nkLI8BclXO
	Z6dBZ/3OBu0UgnAH/OZSsqkEt+j4C4vWDHSXW1BQqJK5t9W53SYWCpd7qjYfCK/I+rgy8TQjPM0
	L0duZo0lO9l2A92WEcVulmu021abIBd7Eu+BsCvX6ZMuo8bFbSUKpA1ORzX99AN7M9ptSjiwOpm
	R5IETXLg3r2szJU=
X-Received: by 2002:a05:6a00:1586:b0:81a:857b:f944 with SMTP id
 d2e1a72fcca58-82a19866231mr10341038b3a.26.1773683533697; Mon, 16 Mar 2026
 10:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313211646.12549-1-stephen@networkplumber.org>
 <20260313211646.12549-4-stephen@networkplumber.org> <ydqKfVXU_4_kSsU89EbfSyd66aGeaCaVHFr6kXhrF-qG7G2WCAAOS51LTAM2y_thGnB0pp-pbGLDWqM4XooMX-jelz30W0KbpE3KzCKiWqo=@willsroot.io>
 <20260315090622.5fbdf074@phoenix.local> <CAM0EoMnh7gYjEGVB0eqGfannC=i=R5YQZbBfZK1K+CqKJyOMOQ@mail.gmail.com>
 <20260315101818.1382d6f6@phoenix.local>
In-Reply-To: <20260315101818.1382d6f6@phoenix.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Mar 2026 13:52:02 -0400
X-Gm-Features: AaiRm500JNK14WdNlxc8bXVSS5-o8taaYTerRhP1E2tF4zJGgNXKVNNXuRg804k
Message-ID: <CAM0EoMmn+KjML3F75Fqamc+APgvqhZxjn+YJ1biQHWrUZCgHLg@mail.gmail.com>
Subject: Re: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for duplication
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Savino Dicanosa <savy@syst3mfailure.io>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268238-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:url,mail.gmail.com:mid,willsroot.io:email,imgur.com:url]
X-Rspamd-Queue-Id: 5FAD129E90A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 1:18=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 15 Mar 2026 12:19:02 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > On Sun, Mar 15, 2026 at 12:06=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Sat, 14 Mar 2026 19:29:10 +0000
> > > William Liu <will@willsroot.io> wrote:
> > >
> > > > Looping in Jamal and Victor.
> > > >
> > > > On Friday, March 13th, 2026 at 9:17 PM, Stephen Hemminger <stephen@=
networkplumber.org> wrote:
> > > >
> > > > > Add a per-CPU recursion depth counter to netem_enqueue(). When ne=
tem
> > > > > duplicates a packet, the clone is re-enqueued at the root qdisc. =
If
> > > > > the tree contains other netem instances, this can recurse without
> > > > > bound, causing soft lockups and OOM.
> > > > >
> > > > > This approach was previously considered but rejected on the groun=
ds
> > > > > that netem_dequeue calling enqueue on a child netem could bypass =
the
> > > > > depth check. That concern does not apply: the child netem's
> > > > > netem_enqueue() increments the same per-CPU counter, so the total
> > > > > nesting depth across all netem instances in the call chain is tra=
cked
> > > > > correctly.
> > > >
> > > > I'm assuming you are referring to [1] (and other relevant followup =
messages), but has this setup been tested against the original repro? I thi=
nk there was a similar draft fix originally but it failed during testing be=
cause DOS still happened [2].
> > > >
> > > > If I remember correctly,  the issue is less so the recursive depth =
but more so being able to differentiate between packets that are previously=
 involved in duplication or not.
> > > >
> > > > >
> > > > > A depth limit of 4 is generous for any legitimate configuration.
> > > > >
> > > > > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplicatio=
n")
> > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: William Liu <will@willsroot.io>
> > > > > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> > > > >
> > > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > > ---
> > > > >  net/sched/sch_netem.c | 22 ++++++++++++++++++++++
> > > > >  1 file changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > index 0ccf74a9cb82..085fa3ad6f83 100644
> > > > > --- a/net/sched/sch_netem.c
> > > > > +++ b/net/sched/sch_netem.c
> > > > > @@ -21,6 +21,7 @@
> > > > >  #include <linux/rtnetlink.h>
> > > > >  #include <linux/reciprocal_div.h>
> > > > >  #include <linux/rbtree.h>
> > > > > +#include <linux/percpu.h>
> > > > >
> > > > >  #include <net/gso.h>
> > > > >  #include <net/netlink.h>
> > > > > @@ -29,6 +30,15 @@
> > > > >
> > > > >  #define VERSION "1.3"
> > > > >
> > > > > +/*
> > > > > + * Limit for recursion from duplication.
> > > > > + * Duplicated packets are re-enqueued at the root qdisc, which m=
ay
> > > > > + * reach this or another netem instance, causing nested calls to
> > > > > + * netem_enqueue(). This per-CPU counter limits the total depth.
> > > > > + */
> > > > > +static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
> > > > > +#define NETEM_RECURSION_LIMIT      4
> > > > > +
> > > > >  /* Network Emulation Queuing algorithm.
> > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > @@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb=
, struct Qdisc *sch,
> > > > >     /* Do not fool qdisc_drop_all() */
> > > > >     skb->prev =3D NULL;
> > > > >
> > > > > +   /* Guard against recursion from duplication re-injection. */
> > > > > +   if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
> > > > > +                NETEM_RECURSION_LIMIT)) {
> > > > > +           this_cpu_dec(netem_enqueue_depth);
> > > > > +           qdisc_drop(skb, sch, to_free);
> > > > > +           return NET_XMIT_DROP;
> > > > > +   }
> > > > > +
> > > > >     /* Random duplication */
> > > > >     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor=
, &q->prng))
> > > > >             ++count;
> > > > > @@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
> > > > >     if (count =3D=3D 0) {
> > > > >             qdisc_qstats_drop(sch);
> > > > >             __qdisc_drop(skb, to_free);
> > > > > +           this_cpu_dec(netem_enqueue_depth);
> > > > >             return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > > > >     }
> > > > >
> > > > > @@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
> > > > >             qdisc_drop_all(skb, sch, to_free);
> > > > >             if (skb2)
> > > > >                     __qdisc_drop(skb2, to_free);
> > > > > +           this_cpu_dec(netem_enqueue_depth);
> > > > >             return NET_XMIT_DROP;
> > > > >     }
> > > > >
> > > > > @@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb=
, struct Qdisc *sch,
> > > > >             /* Parent qdiscs accounted for 1 skb of size @prev_le=
n */
> > > > >             qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - pre=
v_len));
> > > > >     } else if (!skb) {
> > > > > +           this_cpu_dec(netem_enqueue_depth);
> > > > >             return NET_XMIT_DROP;
> > > > >     }
> > > > > +   this_cpu_dec(netem_enqueue_depth);
> > > > >     return NET_XMIT_SUCCESS;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.51.0
> > > > >
> > > > >
> > > >
> > > > What about the last suggestion for a robust fix from [3]?
> > > >
> > > > Best,
> > > > Will
> > > >
> > > > [1] https://lore.kernel.org/netdev/DISZZlS5CdbUKITzkIyT3jki3inTWSMe=
cT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=
=3D@willsroot.io/
> > > > [2] https://lore.kernel.org/netdev/q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuV=
grZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=
=3D@willsroot.io/
> > > > [3] https://lore.kernel.org/netdev/20260111163947.811248-6-jhs@moja=
tatu.com/
> > >
> > > Thanks, this is a tight corner here, and not all solutions work out.
> > >
> > > You're right that the per-CPU guard alone doesn't cover the
> > > dequeue-to-child-enqueue path you described. That's exactly why
> > > the series has two patches working together:
> > >
> > > Patch 02 adds the per-CPU recursion guard, which handles the
> > > direct enqueue recursion (rootq->enqueue duplicated packet hits
> > > another netem_enqueue in the same call chain).
> > >
> > > Patch 04 restructures netem_dequeue to eliminate the pump. The
> > > old code had "goto tfifo_dequeue" which looped back after each
> > > child enqueue, so packets the child duplicated back to root would
> > > immediately get picked up by the same dequeue iteration. The new
> > > code transfers all currently-ready packets from the tfifo to the
> > > child in one batch, then does a single dequeue from the child and
> > > returns. Packets that the child duplicates back to root land in
> > > the tfifo but won't be processed until the next dequeue call from
> > > the parent =E2=80=94 breaking the loop you diagrammed.
> > >
> > > The original repro is:
> > >
> > >   tc qdisc add dev lo root handle 1: netem delay 1ms duplicate 100%
> > >   tc qdisc add dev lo parent 1:1 handle 2: netem delay 1ms duplicate =
100%
> > >   ping -f localhost
> > >
> > > This is covered by tdc test f2a3 (nested netem config acceptance)
> > > and test 7a07 (nested netem with duplication, traffic via scapy).
> > > More tests are added in the new version.
> > >
> > > Jamal's proposed change with skb ttl would also work but
> > > it was rejected because it required adding ttl field to skb
> > > and skb size is a performance critical. As Cong pointed out
> > > adding a couple of bits for ttl makes it increase.
> > > So considered the idea and decided against it.
> >
> > It was not "rejected" - other than Cong making those claims (which i
> > responded to).
> > Last posting i had some feedback from Willem but i dropped the ball.
> > And that variant i posted had issues which were not caught by the AI
> > review - required human knowledge (it didnt consider the GRO code
> > path).
> > If you want to go this path - i am fine with it, I will just focus on
> > the mirred loop.
> > Also tell your AI to Cc the stakeholders next time it posts via
> > get_maintainers (and not cc stable) - then i will be fine reviewing.
> > Commit log (or cover letter) would help if you cite the "documented
> > examples" you said were broken.
> >
> > cheers,
> > jamal
>
> The AI never does any posting, I do. It is used for review only.
>

Ok - just cc the relevant people please..

> You are correct that the original skb ttl size objection was a
> "red herring"; the size only changed in a minimal config corner
> case and alignment padding absorbs it anyway.
>

Right. Here's a before and after of pahole on the skb struct.

-------
--- skb-all-config-pahole-before-ttl 2026-03-16 03:40:08.900884717 -0400
+++ skb-all-config-pahole-after-ttl 2026-03-16 04:03:55.970069673 -0400
@@ -79,8 +79,8 @@
  __u8       slow_gro:1;           /*   132: 3  1 */
  __u8       csum_not_inet:1;      /*   132: 4  1 */
  __u8       unreadable:1;         /*   132: 5  1 */
+ __u8       ttl:2;                /*   132: 6  1 */

- /* XXX 2 bits hole, try to pack */
  /* XXX 1 byte hole, try to pack */

  __u16      tc_index;             /*   134     2 */
--------

> Looking deeper at the ttl approach, I noticed that sharing the
> skb ttl across multiple subsystems could lead to new problems.
> For example: netem with duplication + mirred redirect is a
> legitimate combination. Netem increments ttl on the duplicate,
> mirred increments it again on redirect =E2=80=94 with only 2 bits (0-3),
> a valid packet gets dropped after just two hops. Each subsystem
> needs its own budget, which is what separate per-CPU counters
> give you.

Yes, this is true. The way I weigh it out is:
Does that config even make sense? It may be a niche case, but should
we introduce extra complexity just to serve this niche case (which
will still work albeit with some constraints)?
I will make some time and post the patches later today - if you think
strongly about going with the approach you took, i will drop the netem
patch.

> The per-CPU counter approach is simple and proven. Earlier versions
> of mirred used the same pattern (tcf_mirred_nest_level). Why did
> it get changed?
>

It's still per-CPU=E2=80=94things just things got shifted around (and are m=
ore
clever IMO). See:
commit fe946a751d9b52b7c45ca34899723b314b79b249
Author: Eric Dumazet <edumazet@google.com>
The per-CPU is useful if your loop stays in the same CPU and executes
back-to-back; Eric's thing will catch all that. It fails in two
scenarios:
1) if we queue the packet somewhere and then restart processing later.
The per-cpu state cant be maintained in such a case (example, it gets
wiped out the moment we go egress->ingress and queue the packet in the
backlog and later packets are being pulled from backlog)
2) If we have X/RPS where it came in one CPU but may end up on a different =
CPU.

Also note as Willem mentioned we used to have 3 bits for this loop
counter (and i seem to be the guy who took them out).

> Regarding the broken documented examples: the netem wiki shows
> HTB with netem leaves on different classes, and HFSC with netem
> children. check_netem_in_tree() rejects both if any branch has
> duplication enabled. I'll add specific citations in the next
> version.

I dont see it on the netem wiki. Is it this?
https://wiki.linuxfoundation.org/networking/netem)
In any case, I was not aware of this setup. A citation would help, and
would have helped more if you spoke up at the time.

>
> Lastly, my understanding of Linus's rules on regressions is
> that a regression must not be introduced even if it fixes a bug.
> The "No regressions" rule is highest priority here.
>

I dont believe this view should be taken as dogma . Let me try to make
my case with a gun analogy.
The large large majority of the qdiscs setups that come up in the bug
reports are based on illegal configurations. IOW, some hierarchies are
just nonsense - but are used to stage a setup which triggers a bug.
When the tc and qdisc infra in particular, were being implemented, the
philosophy was old skule "I am giving you the gun for hunting but if
you want to shoot your big toe, i am not going to stop you". The
general idea is that the gun owner is not into shooting their big toe;
if they do, we'd tell them that was not the gun's intent;-> The
problem now is there's profit in shooting the big toe (bounty hunting
for example) - so "we" the gun manufacturers are held responsible
whenever a toe gets shot. I am not sure if that got my point across
;->
The problem is we keep adding hacks to address specific issues for
nonsense setups. You can make it work but it would be equivalent to
this urban legend: https://i.imgur.com/vEwVkrl.jpeg

To make it short, that was the spirit I used to make the call to
accept that patch.

cheers,
jamal

