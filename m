Return-Path: <netdev+bounces-299419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1rMSBE3uL2oLJQUAu9opvQ
	(envelope-from <netdev+bounces-299419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC668624D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=XDxC0MAE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299419-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92EBE306963C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F123B0ADC;
	Mon, 15 Jun 2026 12:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D73E833F
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:17:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525870; cv=pass; b=F2xIrp4bDXf2d6jqWU91kMFUP4SJ7wMTk32PKsaDpgg0zaTzmVdnV1Ht3LqBJEtiOHLMe9aYNxmMytf8etseMH/6njQ90YTUmFokiTNsNKt6LkdJnLip1UGVbGV0fUnQPlPAVccJ0lB3nDvNnWHaGTdnC6ONqLcAqOg3ZBRWU34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525870; c=relaxed/simple;
	bh=RS/hELpS0zgkixiioE4QGruITlpKo68Msgr66zJw3M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhP+T0lWhm/UXu8oVnWA31vWdsxU6r3hahSMoPFWzv0RwKc0Sk+2oTXaHAJGvlsrLe05NhYMBcXPB4YP+3exiDspWUgQqsmRDzlTCUnsK3BGjJcBKfCEB4Lq5KOrb7i7Fdl+zssVIEc8dt5B74399++ra8GASWicFOt9OqCWbaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XDxC0MAE; arc=pass smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842358aaf36so1226460b3a.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781525868; cv=none;
        d=google.com; s=arc-20240605;
        b=PgISQ4M3vR8/IUwLbubhKjK6B0f9kmcWThgjZB05KuRugnLGVz8zdr5X5afmrHRycE
         WrJidnjnRqGLqzQy/x/KVFDCgv0Wf1U5fulXMYKf0lkmH+d4DzBAKqSPcfmObmxX0R+5
         bBuoROW3H5/a8NFPAfGPgeuJz1W6QR5NKS62sr1qkntFhQA3z6bgIz9xxnNqWt0diQUd
         KHKcPjdnhCpYRIXDFPP85SJVexZu8lLHZQHjtP3wQITEpY6ai2BKywiCtCGGmovMpwvj
         vsYZxVdAsLSy4XKLeAL6f76PYzDBqxPJSBB7iScIziQGpyMZnyFZB5m3vBGeJ+2Y8gIw
         ogYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQAlWFHdjrTwu3+1KPmTMcEZ6LKBetsSpL5MA83Zoi8=;
        fh=HH+R3vT7S2GYxuKHUFlD/9lHt0VJtU0mtuxocaftLnY=;
        b=YVU6lSiYzF0X8LkHqlEQGcvajexUNYj0/pmH4uKj+UY0g+rFLXtYhxaDSFQqIsTjd/
         CF0gIshnMx7Xds8ES25FDQTe92eRaBIbZs1j+fRp+xXjRnekr8DEz+mubGJJO8fMZEJJ
         2fHW6kc06azApKr4dQqZKV0zi41hTVpMUTmHmAHqzca6+diXDJ0/Cv58ZMTgrsKSqNOu
         aPCDnV9SXs9jLXT/0RNA7SY0vtw3HTfiY+fHXadDShzbpDoq7G2LCkzK9QMtWcV60/W5
         YE/lXp3DuP1B2kEhT2CMebpWtJCReGq/Rwqcs6T7/SkvqPCVx4W0ncNJRq3GHyZaQpfW
         cPkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781525868; x=1782130668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQAlWFHdjrTwu3+1KPmTMcEZ6LKBetsSpL5MA83Zoi8=;
        b=XDxC0MAElAZZoo0I+hmHNv+37BeDES/D3urzDK30y2FCXiwva+IPRpnk8LX+PoVI2W
         EYQpy/dP8VNmwMzQSbfUbv++OwJn0n9PeMI7C4AlUogQMLnsYspSEeHJzFn6jlWIWr45
         3u4qd9EOXa6diBrS8KGINd5hm3VvDwX3yTgjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525868; x=1782130668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQAlWFHdjrTwu3+1KPmTMcEZ6LKBetsSpL5MA83Zoi8=;
        b=Vh33otMTb3wgN4czzCaxb3WLa6PSUuncbJ0eUtr2iF+l6jLysLCRE9JOaliYTOQSzC
         7vBMI/bi25XW9O4yrjP2KdmEGbB+AqOI7sNc8kRld7YRe46KqB4kOI6JKbfSeXU7oz04
         xuJ+P1NmSwZVZhx6RulCIfveZEnQa1maapfmAX/bY6QIC3AhoJqlv5S1mlvkb+LQmtWC
         7gBug38qObWJZABxGHOIoI0bGFu97jmiBL2kKXMmRCjn7Dl2OYetPFb1ywIA2duoEnrH
         b9rNIur77SZ1KzOaFzb+Ym2ym3tRC3H3CczieqSwGpECqKFnFMxJDJPLx5tDoSozWMVH
         n1Pg==
X-Gm-Message-State: AOJu0YxNIJ29+gAuFwaqeX7452o2LdwHdj37QYzBtfVkZYT1tM0dvjE3
	YloOgnRWqYW9hrE7zWu/YVERetlJyQTGhEAGNpHWMigVcZgBvtxupN9ADsuGfDIbQLWOLJwjX+I
	wWjeGTKGYO0YWUi9QIzCLKitAVaGsir9p8dfWzlmlxgJwWomM3YcaQg==
X-Gm-Gg: Acq92OEgwddogv0+n2tnYNphrSMjTupLgd+VxIVz6gPeGFaYdNY9CB53QudUWopgAvk
	MNrr+z5e3vh485fp36kgGc7QIAJZS0sfOoOCv4KhYupgqAHYYdnFLg8c8D19CRdhacHC1R9vmpA
	obmUcnbwtsR8+/SBBhXIusWSddfKWnYVTcfYVfmE99dSAFt/WR/y3R3muqzU8oHb0eniy1F64Bz
	HMmAKI/cV5U5hox2Bt3AYBLLRnOA9lxNzG/K9+5hgMJcTOwQQMTHxb5Vgdj+f7eEFlBQflOqMqU
	DxEe3ySvlUqO38wANpM=
X-Received: by 2002:a05:6a00:1d9d:b0:842:66f3:c51c with SMTP id
 d2e1a72fcca58-844e1a9cae0mr11812696b3a.40.1781525868601; Mon, 15 Jun 2026
 05:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615103759.2404228-1-n05ec@lzu.edu.cn> <20260615103759.2404228-2-n05ec@lzu.edu.cn>
 <CAM0EoM=t6DYomidQW7RVSZsKvKW4tM3HHrg_fWK=tpqcQHD_Mw@mail.gmail.com>
In-Reply-To: <CAM0EoM=t6DYomidQW7RVSZsKvKW4tM3HHrg_fWK=tpqcQHD_Mw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Jun 2026 08:17:36 -0400
X-Gm-Features: AVVi8CehyE97ngFml3t5IsSdyym-bCgKMHrbhTCtwcpRgReMZMPwNGNAKnHw1TY
Message-ID: <CAM0EoMkxPH4C56_2j8t2Up1WBZXBgOMpU+SmDeC=xgd60Yh_Qw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: ets: avoid deficit wrap and
 empty-round livelock
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, petrm@mellanox.com, 
	davem@davemloft.net, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:petrm@mellanox.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299419-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,mellanox.com,davemloft.net,gmail.com,lzu.edu.cn,icloud.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,icloud.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56AC668624D

On Mon, Jun 15, 2026 at 8:09=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Jun 15, 2026 at 6:38=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> >
> > ETS keeps each DRR-style deficit in a u32 and replenishes it with
> > the configured quantum whenever the head packet is too large. Both
> > the quantum and qdisc_pkt_len() are user-controlled inputs: a large
> > quantum can wrap the deficit counter, while a tiny quantum combined
> > with an inflated qdisc_pkt_len() can force billions of iterations in
> > softirq context before any packet becomes eligible.
> >
> > Store deficits in u64 so replenishment remains monotonic, and after
> > one complete pass over the active list compute how many additional
> > full rounds cannot dequeue from any class. Add that budget in bulk
> > instead of advancing one quantum at a time. This preserves ETS ordering
> > while removing the non-productive loop.
> >
> > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:GPT-5.4
> > Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  net/sched/sch_ets.c | 63 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 44 insertions(+), 19 deletions(-)
> >
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index a4b07b661b77..ed3b191781ee 100644
> > --- a/net/sched/sch_ets.c
> > +++ b/net/sched/sch_ets.c
> > @@ -40,7 +40,7 @@ struct ets_class {
> >         struct list_head alist; /* In struct ets_sched.active. */
> >         struct Qdisc *qdisc;
> >         u32 quantum;
> > -       u32 deficit;
> > +       u64 deficit;
> >         struct gnet_stats_basic_sync bstats;
> >         struct gnet_stats_queue qstats;
> >  };
> > @@ -465,8 +465,10 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk=
_buff *skb)
> >  static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
> >  {
> >         struct ets_sched *q =3D qdisc_priv(sch);
> > -       struct ets_class *cl;
> > +       struct ets_class *cl, *first;
> >         struct sk_buff *skb;
> > +       u64 extra_rounds;
> > +       u64 rounds;
> >         unsigned int band;
> >         unsigned int len;
> >
> > @@ -481,26 +483,49 @@ static struct sk_buff *ets_qdisc_dequeue(struct Q=
disc *sch)
> >                 if (list_empty(&q->active))
> >                         goto out;
> >
> > -               cl =3D list_first_entry(&q->active, struct ets_class, a=
list);
> > -               skb =3D cl->qdisc->ops->peek(cl->qdisc);
> > -               if (!skb) {
> > -                       qdisc_warn_nonwc(__func__, cl->qdisc);
> > -                       goto out;
> > -               }
> > +               first =3D list_first_entry(&q->active, struct ets_class=
, alist);
> > +               extra_rounds =3D U64_MAX;
> >
> > -               len =3D qdisc_pkt_len(skb);
> > -               if (len <=3D cl->deficit) {
> > -                       cl->deficit -=3D len;
> > -                       skb =3D qdisc_dequeue_peeked(cl->qdisc);
> > -                       if (unlikely(!skb))
> > +               do {
> > +                       cl =3D list_first_entry(&q->active, struct ets_=
class, alist);
> > +                       skb =3D cl->qdisc->ops->peek(cl->qdisc);
> > +                       if (!skb) {
> > +                               qdisc_warn_nonwc(__func__, cl->qdisc);
> >                                 goto out;
> > -                       if (cl->qdisc->q.qlen =3D=3D 0)
> > -                               list_del_init(&cl->alist);
> > -                       return ets_qdisc_dequeue_skb(sch, skb);
> > -               }
> > +                       }
> > +
> > +                       len =3D qdisc_pkt_len(skb);
> > +                       if (len <=3D cl->deficit) {
> > +                               cl->deficit -=3D len;
> > +                               skb =3D qdisc_dequeue_peeked(cl->qdisc)=
;
> > +                               if (unlikely(!skb))
> > +                                       goto out;
> > +                               if (cl->qdisc->q.qlen =3D=3D 0)
> > +                                       list_del_init(&cl->alist);
> > +                               return ets_qdisc_dequeue_skb(sch, skb);
> > +                       }
> > +
> > +                       cl->deficit +=3D cl->quantum;
> > +                       list_move_tail(&cl->alist, &q->active);
> > +
> > +                       if (len <=3D cl->deficit) {
> > +                               extra_rounds =3D 0;
> > +                               continue;
> > +                       }
> > +
> > +                       rounds =3D div64_u64((u64)len - cl->deficit + c=
l->quantum - 1,
> > +                                          cl->quantum);
> > +                       if (rounds < extra_rounds)
> > +                               extra_rounds =3D rounds;
> > +               } while (list_first_entry(&q->active, struct ets_class,
> > +                                         alist) !=3D first);
> > +
> > +               if (!extra_rounds)
> > +                       continue;
> >
> > -               cl->deficit +=3D cl->quantum;
> > -               list_move_tail(&cl->alist, &q->active);
> > +               /* Skip full rounds where no active class can dequeue. =
*/
> > +               list_for_each_entry(cl, &q->active, alist)
> > +                       cl->deficit +=3D extra_rounds * cl->quantum;
> >         }
> >  out:
> >         return NULL;
>
> Hrm. This appears like overkill. Doing a div() in the fast path is questi=
onable.
> How about we bound the loop per dequeue to have an upper bound based on n=
bands?
>

Roughly (untested/uncompiled) like the following caffeine inspired approach=
:

------------
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index a4b07b661b77..127f948b3bd6 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -465,6 +465,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct
sk_buff *skb)
 static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 {
        struct ets_sched *q =3D qdisc_priv(sch);
+       unsigned int max_l =3D q->nbands * 2;
+       unsigned int cnt_l =3D 0;
        struct ets_class *cl;
        struct sk_buff *skb;
        unsigned int band;
@@ -501,6 +503,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *=
sch)

                cl->deficit +=3D cl->quantum;
                list_move_tail(&cl->alist, &q->active);
+               if (++cnt_l > max_l)
+                       goto out;
        }
 out:
        return NULL;
------------------

cheers,
jamal

