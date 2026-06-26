Return-Path: <netdev+bounces-302248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yjeYN0S4PmrfKgkAu9opvQ
	(envelope-from <netdev+bounces-302248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:35:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AF6CF6EB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Fc5MAecE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302248-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91C5530377B0
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A13F4DE7;
	Fri, 26 Jun 2026 17:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A7400E15
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:34:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495285; cv=pass; b=WuWUXvhstwdWB786H2sslTyDG7ZlFQr0EVT9ItT9HPlGersRQ5yXq1c9q4fLiJvJSw/1VI4QZLqVPNY6+wD4Ea9JRyUNUcAzgs0imyulM7sE3PdrrP4ynvT728wFbgryYCGhO3QACEKngg/FM3T+WZjQjZ20YswtppiSTYClNDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495285; c=relaxed/simple;
	bh=5TeWJSnPmHzpYVx92wMR7gKWS5TqsGzEO/DmG2zW5Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSbOOFuzLwAhQszAUdVM49PylbLgJtbaj+hW5W65iQwwpmdNNjZd5NCNseJKhGdIOrhDZjKR45YwUMPpQhgbvLFyBhmt/XFetDAGwx2oklCWLHMzl0fXsYnqmylsxbQNrbwpL//HjClkgOw+/Mo9Ar2RE5yW67qqOkumsfliD7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc5MAecE; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51a879e0e9fso6308851cf.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782495282; cv=none;
        d=google.com; s=arc-20260327;
        b=S0OLNS6J6KkXSpoc0cfPuUUm59qSSGwTO9eEHViOkErgvn7n3tMbf9am7EquM957zj
         npR/0bICFM4LCeWTktU0Srp/i7AlcDAYZbldSkC+b7wDPhTCa31rZtk/QiWy3M08uwxn
         5ZT/6gfbpVRZizem0aTN/mx3ocuJcEPWDXOMpofkmdLfP/15JV+YWhP8oj/o9ABfGWxa
         qTowtLqx0+rflv+G7YipJXabL6vDjpWp6h99H1bmCqkl6oftMqHSPm/Oo6DQBb+tMeVJ
         czYQPsrKcGyxqOc7SwGd2xBNLo/VGo7sqPyQArRB3tBV8BzQARLLJ9UtOHSpvY2uLDsA
         S6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rd6Am0B2+KnLyc+e/rrnGLj6Np9i0cOw418dR9UFS9U=;
        fh=k1xFoBbDMAYUuOkUTLsm4QkqevavcCjAKzkHshYlWu0=;
        b=j2GHcX4MfIq/uJIrILBZTlfMQm4xMxqRQuo8QyYkv4f3ZDpNqfGIO0Gt/8jBwSJKVS
         N6hp9ag3fHidusRyWxdWigtXi3yDafRvAgbhPxj3xPSXQkd2KJxBpuD137BfQ8/d+kKm
         mjlKpcDfEUdA5i7QHzfdLxhQV+ZSEhr6lRF6lraY6Cz0kZbzNqcInckbd2MuCJ1FOA6B
         zIgz5oMctDIL3SFdbEp7yT1VX0tYGADnBV5DjffhH2TKj1Kkfncq71+wmKjoB+pIaDaH
         Moz3ouQwTcEtJov4t7XRsPeK8gLu1SXVsMh20LXU3KKohd1l0TfQE5v5F80iDl7Q4xso
         +TLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782495282; x=1783100082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd6Am0B2+KnLyc+e/rrnGLj6Np9i0cOw418dR9UFS9U=;
        b=Fc5MAecEYw4xWKBgBwqyJkha1t7GImDtgFRqbWF8rmtM9aVSyLOS5sbgdlKN+8MP8Q
         79V6fIO5RHeNDXic3jfnIiEO27UcKBvU/YMUcGosIZc2hXf2eaPxEOspkpq8ncJ47Rue
         uQYcqgqia35L6ju0juGKtoq0LQ10ROvjAVtDnaQHaLuSsBKCsTCzxZt9C4aOoRxLpyQE
         BeL1akYFtp8QBv6Slnird9aIPbXWKDmw273tWKTtCwGhZlupiFvieLXc+UFqRYRYSLse
         tfghIj8Wdht7tssEv1JMf6ez65e0thTReiANtVpIOpZGFUQYtswwte/JS4ldtmeHkzxT
         1vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495282; x=1783100082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rd6Am0B2+KnLyc+e/rrnGLj6Np9i0cOw418dR9UFS9U=;
        b=NzitQY01Alu1nJUp6MWcx6T5UlvirhE5OMnbO3/ktHAYxBvZ3YVMFU+9+vlt67MiEv
         cZrnDG28ZdjyAVkT8mPId/Je6dWdtw9jtXNvJNWt+YC+EfNlAfu92WJmE2aKzfnaUxb2
         rGMN8lO53qs4LJbgjABc5TY3ab/QHJls7LO1w5VJNiyDEOiw9FesoFgp/csQgdMYeNnF
         G8/jaxA5gsbKPgbZIMkLii8lwFd3SeSMhI5+UtnRiXFZexR01J24nkGqNeqbLpfLE1J8
         2WI6LvxJhdipMVjbsteZ3U3K5gIaKmwvQGhP1EO4/YBpO8Tqmr7FAfsxtGyTyYvSp458
         6dCA==
X-Forwarded-Encrypted: i=1; AFNElJ+6QHZ4q2FRrosfhT7k1zDhGHlI0tctO9AtUpPgdcTRTG0n+54Sxd0zdeb+0suGDr0CkOQdI0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPXXkuYsaW2gy39FiEAQhFCRHVI29vUpqbtR5qP4dG4iPkq9w
	3SMiLlwAZswzSMkEI+t08keFdxtsgpZK4QWOzKA4abckS1FwjweA/Hw1632kL0oDwG1YqNNRMwD
	bn0WwZ9Jw/TW5t3hmwc8QcxVIbwn7LAw=
X-Gm-Gg: AfdE7ckYCULU+Mo1iDxCFmsdcldhcxbFIzGvPdKMZQ/h3PU4HHhD7dyKuJOTP2G8DLO
	eJQKma59S0abJDRyoC8BCApvmcIvmVs7ypn2oRWuqZw+VYacNne8ts2ZqxGmfAWyOlBnQkHqt/5
	0+iX7wSS50xdohwwxv+TRuswZNRhpH0jpAMUF2xYHmD4s/X1xeOENSrp7VckqbrEUM0kC/lcYFs
	knkT7Gra+OkcrYeFAxaqiNIAngpSkDoyTYup9wEitHvWeJSrdkqO5KQ82YIznOyCUM1bhzn17r2
	RpGHvmm5fos8OJfolaZ21ACqvbo1kA==
X-Received: by 2002:a05:622a:245:b0:517:7971:a234 with SMTP id
 d75a77b69052e-51a7275afa8mr106013941cf.4.1782495281720; Fri, 26 Jun 2026
 10:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
 <CAM0EoM=FvNKemH4Z5dL_pFQZcGWxLb4c_AMahOePLY7s6Pkhcg@mail.gmail.com>
In-Reply-To: <CAM0EoM=FvNKemH4Z5dL_pFQZcGWxLb4c_AMahOePLY7s6Pkhcg@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 26 Jun 2026 10:34:30 -0700
X-Gm-Features: AVVi8CcNbX4Tkxgw9jbwApj3qKdFa9jw5c9UlwkTwTz3Sp-Igwr4PS-StJd8v6g
Message-ID: <CAPuPA7LRaaLc5ffNvnrexi-6KWrMTCnQE4parUd7kNRwagZvfA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: sched: ets: avoid deficit wrap and bound
 empty dequeue rounds
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, petrm@mellanox.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:petrm@mellanox.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302248-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,resnulli.us,davemloft.net,mellanox.com,gmail.com,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,icloud.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 524AF6CF6EB

On Fri, Jun 26, 2026 at 2:54=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Jun 26, 2026 at 4:32=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
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
> > Store the deficit in u64 so replenishment cannot wrap the counter.
> > This keeps the existing dequeue logic unchanged while fixing the
> > overflow condition.
> >
> > Bound one dequeue attempt to at most nbands * 2 ETS rotations, as
> > suggested in review. This avoids the livelock without adding heavier
> > logic to the fast path.
> >
> > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Assisted-by: Codex:GPT-5.4
> > Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Note, you did not Cc many maintainers. Next time, or if you have to
> resend this patch make sure you Cc the stakeholders (see
> scripts/get_maintainers.pl)

Thank you very much for your advice. We were previously concerned
about bothering too many maintainers, so we used the pattern-depth=3D1
option when running scripts/get_maintainers.pl. We=E2=80=99ll relax this
parameter a bit in future submissions.

>
> cheers,
> jamal
>
> > ---
> > changes in v2:
> >   - Instead of doing a div() in the fast path, simply bound the loop pe=
r
> >     dequeue
> >   - v1 Link: https://lore.kernel.org/all/20260615103759.2404228-2-n05ec=
@lzu.edu.cn/
> >
> >
> >  net/sched/sch_ets.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index cb8cf437ce87..12a156ccb0a6 100644
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
> > @@ -463,6 +463,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_=
buff *skb)
> >  static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
> >  {
> >         struct ets_sched *q =3D qdisc_priv(sch);
> > +       unsigned int max_loops =3D READ_ONCE(q->nbands) * 2;
> > +       unsigned int loops =3D 0;
> >         struct ets_class *cl;
> >         struct sk_buff *skb;
> >         unsigned int band;
> > @@ -499,6 +501,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdi=
sc *sch)
> >
> >                 cl->deficit +=3D READ_ONCE(cl->quantum);
> >                 list_move_tail(&cl->alist, &q->active);
> > +               if (++loops > max_loops)
> > +                       goto out;
> >         }
> >  out:
> >         return NULL;
> > --
> > 2.47.3
> >

