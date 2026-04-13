Return-Path: <netdev+bounces-278077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMoTF7Dr3Gk0YQkAu9opvQ
	(envelope-from <netdev+bounces-278077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:12:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBABC3EC6CA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF08300F19B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6C93CAE84;
	Mon, 13 Apr 2026 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7f6EuKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7E3BFE33
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085904; cv=pass; b=O/COmmRtzbH13VQb1KAAWzpSnAi9AIAozQ9imRt6t7HYyBdReunA38sWXVKqOzjJdOYhEYUD65Myw2oSzbSweziZQOTLv3szjsYRjni2OfFF8tSPTRwBWatua5AiwEKAMo3Qog7SEKHnW08Zd+MfqKTWnwJFUXF/cJzsBPp8Ido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085904; c=relaxed/simple;
	bh=Yk4VICVS11v4xblesi5IIuZrz55CAP8X/YlYIWxoJ7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jms4tCvWOWNCfpQfklcXbxKrxGuLzZjfZ27gG2jhWBejMRleUDB1mwS3S6/Xg54lCYZfbI9lNkAOxQdWCKUIc028H1+mZaJhKqQIm6JQpBbbrHEyIxVga/IPL8VAeGKNlOtwlpJ8Gi5bCHYn9ulElyULSh/2Zh+I6inq5W2sN/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7f6EuKG; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d58c513dbso33213711cf.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776085901; cv=none;
        d=google.com; s=arc-20240605;
        b=icNYNZg/fzkN4pCtCSwCH6ZDua3ARqCgw88YoYY7lgfy+YJ4lGRfTNOl5AjLlKDKWY
         u4r12OvHLtlJwZqA9/G2/RfQIsXliIJVXSmoa8dV2DTOXlnde3K3CdGaCGzd+45h54mq
         ELTnvXCChGq4tgxibDL3/F8LTJ7IkQJl5HyYr+bY5IvMBq/yLXXI73yuok9NLGMgA7/C
         imh+rw6DDt1rCIxw/oEY7WsUnQOivOWRkahpTTI5MYZkfDA1SHAPlAIelVV5fkUZ0lpM
         Z7pBGsl7MHS2Rm56aFxpnANQVGNRyXuCPrIG/Uug+/0PDa49crRA1JPuCjQxPOOzSy/B
         NU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r8PXW4BD7mnxNFgdhJZI/Zb4HGQTgLeiYsz4wn54oLo=;
        fh=ul9xAxlmDV1kAhUZ0/m6cftGkX1LnBlbHL5biv3SgxM=;
        b=iSGq0ybR9/Kj8IttEWzzoBbzs3DXP8g9jbqxm2sFD8yZRA/f4hF/vAhzOW15N/mLnd
         YJz8j+PYaXkRyI/+0YFrJIDHEaW5OdwzDsjOrFJ2j4KLM09PvDUKgenDHpunID8nECS3
         uHFot1YNqejSS09pWuv37O2T0nAjhG21J6c5P7neB8eyRw0+mc5KodGE0lkd59QZricf
         nG+RX60TERaEVpR/REeHYNv4JrA6UD06Pl7TdvUKMFcgPFPSKvZpGzogqsacdajV5G5j
         msGhBUASQb2ZkjwR3LihYG9Tqz1x4aT20bniYEDubJG7eeFQ3k2ydrPFIhPGdCjoz7pX
         wgbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776085901; x=1776690701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8PXW4BD7mnxNFgdhJZI/Zb4HGQTgLeiYsz4wn54oLo=;
        b=i7f6EuKGFN3ziadGJpXeHKM38m2Pp3dds1acbrfuDKPi2J6eO2DpogaYBzsA5Ccu9o
         Q2vuPVRk5+o2vmUHh3WmDAgAf43CnfI6UE3FXZfurkI/T9b7fVP1xXP2K16DK45a6x+q
         pVIrlpTcSWDlE5jf0MfsobclPT+J3GPYzlghCLTV3I7aoO4Ef7nZXgBgGwM8tAQ8sZMl
         F4A4MWrV+Nrmtx1g7IhiZsMTXm7duIuVilykQp41nL8qIpCEs+GhsVWit9Akb0FkiuPJ
         rNsCdXY1Pf7vuf/g9i3SgHH/UDvZTWBT1qGkPZgiiz1xv32KrrTLvpqRnddgICMNNy68
         w4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776085901; x=1776690701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8PXW4BD7mnxNFgdhJZI/Zb4HGQTgLeiYsz4wn54oLo=;
        b=K5t2xqmiGcrP9/IhXKayXKzBimXy7UNOKCzXkEs9mMdgSTfLXLJJEQfrKsOZK3MOyv
         NK2z8t36GbJ8HIBLxpXLhXaKu81gXRtsH6WgNzS7JLLiBRdFKscXDyhvrkz0hF+b3r+K
         hmsACbluHQruNTlnCmLZAXe+/IMcdzQBSA3zIl56aVta+Stu5pVsZVcPewnl9GvNLHK2
         eUyEBtgPVw98WGkaenvH3c5WNivDpwehXN6I5C8HeFZBsbGIpkKFgh4zwE42NhqUysLR
         RG60YXuMxDlSKBOACmlJeBUBCRM81wC5Q82mW8hRAae0nJ/7Kq9lnmxfTLwxEudTOKdi
         dhPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+h5zV8RtgeEdaq3bYDPyszW0wfnsLN/ovyyWm37nu7v1WZsuTBgGXO64oiF5QeN79UEUtrmM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvOOzzbXzBjFdy4ndIUBHD/74IO++CKlKbnj99TXo6z+O5wXn
	jFalGXu3lG1jyguwbPppLQDRh8IXcgJKlYVNwf+MWHK5xRi6qL/J+42oS2bh7MQI1DzImmuyOwV
	O+/sdbfJKykJd1gNSwQI5sHl3CZHDnJBGxUrSTxJ6
X-Gm-Gg: AeBDies/ih2tJMYls30jmQtcNyWs8aUkd9Z2KhvwZSeexlOncEFb7VH8W8Sj/B3qs1B
	p22bHTNtl6/vs5UMTr5sf8aHuoyuI++UC6rxV+oK0Rv60VSYPVXXu49BqkAQO8WtLuBT7tbo+Sw
	JrSk/12LDlGGc96UL4W5bFjJ7MGHwcL5TKSp/NH9rOCVhoLKrIjiUmVB1jgPhnYsy03EFZh4dYX
	GgG3vzrVEGe1HiPFbBGOLVkqG3JmbJZ761qbMwpClHULYDFvEwwrKQicBIMxDdBaBYOk6hfKof7
	fKBgDMyovOKjNGDQb/yXQJp66226AlsCKgtLAWIcGD00MErUT03p8OHOOyc5604P1wU2/GUEVQ=
	=
X-Received: by 2002:ac8:5751:0:b0:50b:3895:c22f with SMTP id
 d75a77b69052e-50dd5b05d87mr203411371cf.26.1776085900063; Mon, 13 Apr 2026
 06:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com> <20260410182257.774311-14-edumazet@google.com>
 <87se8zcbcy.fsf@toke.dk>
In-Reply-To: <87se8zcbcy.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Apr 2026 06:11:28 -0700
X-Gm-Features: AQROBzACmw4QTCwpVExTzubVZknT93G0xGHseqbji8ZfL0WVLivp33zmJXyvTWE
Message-ID: <CANn89iJbFUm5NF1Q6WnB17Ufdg8PyFX4msJLVVs4PKRz6XW6yw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 13/15] net/sched: sch_cake: annotate
 data-races in cake_dump_stats()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278077-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BBABC3EC6CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 5:07=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > cake_dump_stats() and cake_dump_class_stats() run without qdisc
> > spinlock being held.
> >
> > Add READ_ONCE()/WRITE_ONCE() annotations.
> >
> > Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cak=
e) qdisc")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
> > ---
> >  net/sched/sch_cake.c | 404 ++++++++++++++++++++++++-------------------
> >  1 file changed, 225 insertions(+), 179 deletions(-)
>
> One of these diffstats is not like the others - thanks for tackling this =
:)
>
> A few nits below:
>
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index 32e672820c00a88c6d8fe77a6308405e016525ea..f523f0aa4d830e9d3ec4d43=
bb123e1dc4f8f289d 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -399,14 +399,14 @@ static void cake_configure_rates(struct Qdisc *sc=
h, u64 rate, bool rate_adjust);
> >   * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka =
Q0.32
> >   */
> >
> > -static void cobalt_newton_step(struct cobalt_vars *vars)
> > +static void cobalt_newton_step(struct cobalt_vars *vars, u32 count)
> >  {
> >       u32 invsqrt, invsqrt2;
> >       u64 val;
> >
> >       invsqrt =3D vars->rec_inv_sqrt;
> >       invsqrt2 =3D ((u64)invsqrt * invsqrt) >> 32;
> > -     val =3D (3LL << 32) - ((u64)vars->count * invsqrt2);
> > +     val =3D (3LL << 32) - ((u64)count * invsqrt2);
> >
> >       val >>=3D 2; /* avoid overflow in following multiply */
> >       val =3D (val * invsqrt) >> (32 - 2 + 1);
> > @@ -414,12 +414,12 @@ static void cobalt_newton_step(struct cobalt_vars=
 *vars)
> >       vars->rec_inv_sqrt =3D val;
> >  }
> >
> > -static void cobalt_invsqrt(struct cobalt_vars *vars)
> > +static void cobalt_invsqrt(struct cobalt_vars *vars, u32 count)
> >  {
> > -     if (vars->count < REC_INV_SQRT_CACHE)
> > -             vars->rec_inv_sqrt =3D inv_sqrt_cache[vars->count];
> > +     if (count < REC_INV_SQRT_CACHE)
> > +             vars->rec_inv_sqrt =3D inv_sqrt_cache[count];
> >       else
> > -             cobalt_newton_step(vars);
> > +             cobalt_newton_step(vars, count);
> >  }
> >
> >  static void cobalt_vars_init(struct cobalt_vars *vars)
> > @@ -449,16 +449,19 @@ static bool cobalt_queue_full(struct cobalt_vars =
*vars,
> >       bool up =3D false;
> >
> >       if (ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
> > -             up =3D !vars->p_drop;
> > -             vars->p_drop +=3D p->p_inc;
> > -             if (vars->p_drop < p->p_inc)
> > -                     vars->p_drop =3D ~0;
> > -             vars->blue_timer =3D now;
> > -     }
> > -     vars->dropping =3D true;
> > -     vars->drop_next =3D now;
> > +             u32 p_drop =3D vars->p_drop;
> > +
> > +             up =3D !p_drop;
> > +             p_drop +=3D p->p_inc;
> > +             if (p_drop < p->p_inc)
> > +                     p_drop =3D ~0;
> > +             WRITE_ONCE(vars->p_drop, p_drop);
> > +             WRITE_ONCE(vars->blue_timer, now);
> > +     }
> > +     WRITE_ONCE(vars->dropping, true);
> > +     WRITE_ONCE(vars->drop_next, now);
> >       if (!vars->count)
> > -             vars->count =3D 1;
> > +             WRITE_ONCE(vars->count, 1);
> >
> >       return up;
> >  }
> > @@ -474,21 +477,25 @@ static bool cobalt_queue_empty(struct cobalt_vars=
 *vars,
> >
> >       if (vars->p_drop &&
> >           ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
> > -             if (vars->p_drop < p->p_dec)
> > -                     vars->p_drop =3D 0;
> > +             u32 p_drop =3D vars->p_drop;
> > +
> > +             if (p_drop < p->p_dec)
> > +                     p_drop =3D 0;
> >               else
> > -                     vars->p_drop -=3D p->p_dec;
> > -             vars->blue_timer =3D now;
> > -             down =3D !vars->p_drop;
> > +                     p_drop -=3D p->p_dec;
> > +             WRITE_ONCE(vars->p_drop, p_drop);
> > +             WRITE_ONCE(vars->blue_timer, now);
> > +             down =3D !p_drop;
> >       }
> > -     vars->dropping =3D false;
> > +     WRITE_ONCE(vars->dropping, false);
> >
> >       if (vars->count && ktime_to_ns(ktime_sub(now, vars->drop_next)) >=
=3D 0) {
> > -             vars->count--;
> > -             cobalt_invsqrt(vars);
> > -             vars->drop_next =3D cobalt_control(vars->drop_next,
> > -                                              p->interval,
> > -                                              vars->rec_inv_sqrt);
> > +             WRITE_ONCE(vars->count, vars->count - 1);
> > +             cobalt_invsqrt(vars, vars->count);
> > +             WRITE_ONCE(vars->drop_next,
> > +                        cobalt_control(vars->drop_next,
> > +                                       p->interval,
> > +                                       vars->rec_inv_sqrt));
> >       }
> >
> >       return down;
> > @@ -507,6 +514,7 @@ static enum qdisc_drop_reason cobalt_should_drop(st=
ruct cobalt_vars *vars,
> >       bool next_due, over_target;
> >       ktime_t schedule;
> >       u64 sojourn;
> > +     u32 count;
> >
> >  /* The 'schedule' variable records, in its sign, whether 'now' is befo=
re or
> >   * after 'drop_next'.  This allows 'drop_next' to be updated before th=
e next
> > @@ -528,45 +536,50 @@ static enum qdisc_drop_reason cobalt_should_drop(=
struct cobalt_vars *vars,
> >       over_target =3D sojourn > p->target &&
> >                     sojourn > p->mtu_time * bulk_flows * 2 &&
> >                     sojourn > p->mtu_time * 4;
> > -     next_due =3D vars->count && ktime_to_ns(schedule) >=3D 0;
> > +     count =3D vars->count;
> > +     next_due =3D count && ktime_to_ns(schedule) >=3D 0;
> >
> >       vars->ecn_marked =3D false;
> >
> >       if (over_target) {
> >               if (!vars->dropping) {
> > -                     vars->dropping =3D true;
> > -                     vars->drop_next =3D cobalt_control(now,
> > -                                                      p->interval,
> > -                                                      vars->rec_inv_sq=
rt);
> > +                     WRITE_ONCE(vars->dropping, true);
> > +                     WRITE_ONCE(vars->drop_next,
> > +                                cobalt_control(now,
> > +                                               p->interval,
> > +                                               vars->rec_inv_sqrt));
> >               }
> > -             if (!vars->count)
> > -                     vars->count =3D 1;
> > +             if (!count)
> > +                     count =3D 1;
> >       } else if (vars->dropping) {
> > -             vars->dropping =3D false;
> > +             WRITE_ONCE(vars->dropping, false);
> >       }
> >
> >       if (next_due && vars->dropping) {
> >               /* Use ECN mark if possible, otherwise drop */
> > -             if (!(vars->ecn_marked =3D INET_ECN_set_ce(skb)))
> > +             vars->ecn_marked =3D INET_ECN_set_ce(skb);
> > +             if (!vars->ecn_marked)
> >                       reason =3D QDISC_DROP_CONGESTED;
> >
> > -             vars->count++;
> > -             if (!vars->count)
> > -                     vars->count--;
> > -             cobalt_invsqrt(vars);
> > -             vars->drop_next =3D cobalt_control(vars->drop_next,
> > -                                              p->interval,
> > -                                              vars->rec_inv_sqrt);
> > +             count++;
> > +             if (!count)
> > +                     count--;
> > +             cobalt_invsqrt(vars, count);
> > +             WRITE_ONCE(vars->drop_next,
> > +                        cobalt_control(vars->drop_next,
> > +                                       p->interval,
> > +                                       vars->rec_inv_sqrt));
> >               schedule =3D ktime_sub(now, vars->drop_next);
> >       } else {
> >               while (next_due) {
> > -                     vars->count--;
> > -                     cobalt_invsqrt(vars);
> > -                     vars->drop_next =3D cobalt_control(vars->drop_nex=
t,
> > -                                                      p->interval,
> > -                                                      vars->rec_inv_sq=
rt);
> > +                     count--;
> > +                     cobalt_invsqrt(vars, count);
> > +                     WRITE_ONCE(vars->drop_next,
> > +                                cobalt_control(vars->drop_next,
> > +                                               p->interval,
> > +                                               vars->rec_inv_sqrt));
> >                       schedule =3D ktime_sub(now, vars->drop_next);
> > -                     next_due =3D vars->count && ktime_to_ns(schedule)=
 >=3D 0;
> > +                     next_due =3D count && ktime_to_ns(schedule) >=3D =
0;
> >               }
> >       }
> >
> > @@ -575,11 +588,12 @@ static enum qdisc_drop_reason cobalt_should_drop(=
struct cobalt_vars *vars,
> >           get_random_u32() < vars->p_drop)
> >               reason =3D QDISC_DROP_FLOOD_PROTECTION;
> >
> > +     WRITE_ONCE(vars->count, count);
> >       /* Overload the drop_next field as an activity timeout */
> > -     if (!vars->count)
> > -             vars->drop_next =3D ktime_add_ns(now, p->interval);
> > +     if (count)
>
> This seems to reverse the conditional?

Ah right, thanks !

>
> > +             WRITE_ONCE(vars->drop_next, ktime_add_ns(now, p->interval=
));
> >       else if (ktime_to_ns(schedule) > 0 && reason =3D=3D QDISC_DROP_UN=
SPEC)
> > -             vars->drop_next =3D now;
> > +             WRITE_ONCE(vars->drop_next, now);
> >
> >       return reason;
> >  }
> > @@ -813,7 +827,7 @@ static u32 cake_hash(struct cake_tin_data *q, const=
 struct sk_buff *skb,
> >                    i++, k =3D (k + 1) % CAKE_SET_WAYS) {
> >                       if (q->tags[outer_hash + k] =3D=3D flow_hash) {
> >                               if (i)
> > -                                     q->way_hits++;
> > +                                     WRITE_ONCE(q->way_hits, q->way_hi=
ts + 1);
> >
> >                               if (!q->flows[outer_hash + k].set) {
> >                                       /* need to increment host refcnts=
 */
> > @@ -831,7 +845,7 @@ static u32 cake_hash(struct cake_tin_data *q, const=
 struct sk_buff *skb,
> >               for (i =3D 0; i < CAKE_SET_WAYS;
> >                        i++, k =3D (k + 1) % CAKE_SET_WAYS) {
> >                       if (!q->flows[outer_hash + k].set) {
> > -                             q->way_misses++;
> > +                             WRITE_ONCE(q->way_misses, q->way_misses +=
 1);
> >                               allocate_src =3D cake_dsrc(flow_mode);
> >                               allocate_dst =3D cake_ddst(flow_mode);
> >                               goto found;
> > @@ -841,7 +855,7 @@ static u32 cake_hash(struct cake_tin_data *q, const=
 struct sk_buff *skb,
> >               /* With no empty queues, default to the original
> >                * queue, accept the collision, update the host tags.
> >                */
> > -             q->way_collisions++;
> > +             WRITE_ONCE(q->way_collisions, q->way_collisions + 1);
> >               allocate_src =3D cake_dsrc(flow_mode);
> >               allocate_dst =3D cake_ddst(flow_mode);
> >
> > @@ -875,7 +889,8 @@ static u32 cake_hash(struct cake_tin_data *q, const=
 struct sk_buff *skb,
> >                       q->flows[reduced_hash].srchost =3D srchost_idx;
> >
> >                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BU=
LK)
> > -                             cake_inc_srchost_bulk_flow_count(q, &q->f=
lows[reduced_hash], flow_mode);
> > +                             cake_inc_srchost_bulk_flow_count(q, &q->f=
lows[reduced_hash],
> > +                                                              flow_mod=
e);
> >               }
> >
> >               if (allocate_dst) {
> > @@ -899,7 +914,8 @@ static u32 cake_hash(struct cake_tin_data *q, const=
 struct sk_buff *skb,
> >                       q->flows[reduced_hash].dsthost =3D dsthost_idx;
> >
> >                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BU=
LK)
> > -                             cake_inc_dsthost_bulk_flow_count(q, &q->f=
lows[reduced_hash], flow_mode);
> > +                             cake_inc_dsthost_bulk_flow_count(q, &q->f=
lows[reduced_hash],
> > +                                                              flow_mod=
e);
> >               }
> >       }
> >
> > @@ -1379,9 +1395,9 @@ static u32 cake_calc_overhead(struct cake_sched_d=
ata *qd, u32 len, u32 off)
> >               len -=3D off;
> >
> >       if (qd->max_netlen < len)
> > -             qd->max_netlen =3D len;
> > +             WRITE_ONCE(qd->max_netlen, len);
> >       if (qd->min_netlen > len)
> > -             qd->min_netlen =3D len;
> > +             WRITE_ONCE(qd->min_netlen, len);
> >
> >       len +=3D q->rate_overhead;
> >
> > @@ -1401,9 +1417,9 @@ static u32 cake_calc_overhead(struct cake_sched_d=
ata *qd, u32 len, u32 off)
> >       }
> >
> >       if (qd->max_adjlen < len)
> > -             qd->max_adjlen =3D len;
> > +             WRITE_ONCE(qd->max_adjlen, len);
> >       if (qd->min_adjlen > len)
> > -             qd->min_adjlen =3D len;
> > +             WRITE_ONCE(qd->min_adjlen, len);
> >
> >       return len;
> >  }
> > @@ -1416,7 +1432,7 @@ static u32 cake_overhead(struct cake_sched_data *=
q, const struct sk_buff *skb)
> >       u16 segs =3D qdisc_pkt_segs(skb);
> >       u32 len =3D qdisc_pkt_len(skb);
> >
> > -     q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
> > +     WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8))=
;
> >
> >       if (segs =3D=3D 1)
> >               return cake_calc_overhead(q, len, off);
> > @@ -1590,16 +1606,17 @@ static unsigned int cake_drop(struct Qdisc *sch=
, struct sk_buff **to_free)
> >       }
> >
> >       if (cobalt_queue_full(&flow->cvars, &b->cparams, now))
> > -             b->unresponsive_flow_count++;
> > +             WRITE_ONCE(b->unresponsive_flow_count,
> > +                        b->unresponsive_flow_count + 1);
> >
> >       len =3D qdisc_pkt_len(skb);
> >       q->buffer_used      -=3D skb->truesize;
> > -     b->backlogs[idx]    -=3D len;
> > -     b->tin_backlog      -=3D len;
> > +     WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] - len);
> > +     WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
> >       qstats_backlog_sub(sch, len);
> >
> > -     flow->dropped++;
> > -     b->tin_dropped++;
> > +     WRITE_ONCE(flow->dropped, flow->dropped + 1);
> > +     WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
> >
> >       if (q->config->rate_flags & CAKE_FLAG_INGRESS)
> >               cake_advance_shaper(q, b, skb, now, true);
> > @@ -1795,7 +1812,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >       }
> >
> >       if (unlikely(len > b->max_skblen))
> > -             b->max_skblen =3D len;
> > +             WRITE_ONCE(b->max_skblen, len);
> >
> >       if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_=
SPLIT_GSO) {
> >               struct sk_buff *segs, *nskb;
> > @@ -1819,13 +1836,13 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >                       numsegs++;
> >                       slen +=3D segs->len;
> >                       q->buffer_used +=3D segs->truesize;
> > -                     b->packets++;
>
> Right above this hunk we do sch->q.qlen++; - does that need changing as
> well?

This was changed to qdisc_qlen_inc() in a prior commit in this series.
( net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec() )


>
> >               }
> >
> >               /* stats */
> > -             b->bytes            +=3D slen;
> > -             b->backlogs[idx]    +=3D slen;
> > -             b->tin_backlog      +=3D slen;
> > +             WRITE_ONCE(b->bytes, b->bytes + slen);
> > +             WRITE_ONCE(b->packets, b->packets + numsegs);
> > +             WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
> >               qstats_backlog_add(sch, slen);
> >               q->avg_window_bytes +=3D slen;
> >
> > @@ -1843,10 +1860,10 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >                       ack =3D cake_ack_filter(q, flow);
> >
> >               if (ack) {
> > -                     b->ack_drops++;
> > +                     WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
> >                       qdisc_qstats_drop(sch);
> >                       ack_pkt_len =3D qdisc_pkt_len(ack);
> > -                     b->bytes +=3D ack_pkt_len;
> > +                     WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
> >                       q->buffer_used +=3D skb->truesize - ack->truesize=
;
> >                       if (q->config->rate_flags & CAKE_FLAG_INGRESS)
> >                               cake_advance_shaper(q, b, ack, now, true)=
;
> > @@ -1859,10 +1876,10 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >               }
> >
> >               /* stats */
> > -             b->packets++;
> > -             b->bytes            +=3D len - ack_pkt_len;
> > -             b->backlogs[idx]    +=3D len - ack_pkt_len;
> > -             b->tin_backlog      +=3D len - ack_pkt_len;
> > +             WRITE_ONCE(b->packets, b->packets + 1);
> > +             WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
> > +             WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + len - ack=
_pkt_len);
> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt=
_len);
> >               qstats_backlog_add(sch, len - ack_pkt_len);
> >               q->avg_window_bytes +=3D len - ack_pkt_len;
> >       }
> > @@ -1894,9 +1911,9 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >                       u64 b =3D q->avg_window_bytes * (u64)NSEC_PER_SEC=
;
> >
> >                       b =3D div64_u64(b, window_interval);
> > -                     q->avg_peak_bandwidth =3D
> > -                             cake_ewma(q->avg_peak_bandwidth, b,
> > -                                       b > q->avg_peak_bandwidth ? 2 :=
 8);
> > +                     WRITE_ONCE(q->avg_peak_bandwidth,
> > +                                cake_ewma(q->avg_peak_bandwidth, b,
> > +                                          b > q->avg_peak_bandwidth ? =
2 : 8));
> >                       q->avg_window_bytes =3D 0;
> >                       q->avg_window_begin =3D now;
> >
> > @@ -1917,27 +1934,30 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >               if (!flow->set) {
> >                       list_add_tail(&flow->flowchain, &b->new_flows);
> >               } else {
> > -                     b->decaying_flow_count--;
> > +                     WRITE_ONCE(b->decaying_flow_count,
> > +                                b->decaying_flow_count - 1);
> >                       list_move_tail(&flow->flowchain, &b->new_flows);
> >               }
> >               flow->set =3D CAKE_SET_SPARSE;
> > -             b->sparse_flow_count++;
> > +             WRITE_ONCE(b->sparse_flow_count,
> > +                        b->sparse_flow_count + 1);
> >
> > -             flow->deficit =3D cake_get_flow_quantum(b, flow, q->confi=
g->flow_mode);
> > +             WRITE_ONCE(flow->deficit,
> > +                        cake_get_flow_quantum(b, flow, q->config->flow=
_mode));
> >       } else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
> >               /* this flow was empty, accounted as a sparse flow, but a=
ctually
> >                * in the bulk rotation.
> >                */
> >               flow->set =3D CAKE_SET_BULK;
> > -             b->sparse_flow_count--;
> > -             b->bulk_flow_count++;
> > +             WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1=
);
> > +             WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
> >
> >               cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow=
_mode);
> >               cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow=
_mode);
> >       }
> >
> >       if (q->buffer_used > q->buffer_max_used)
> > -             q->buffer_max_used =3D q->buffer_used;
> > +             WRITE_ONCE(q->buffer_max_used, q->buffer_used);
> >
> >       if (q->buffer_used <=3D q->buffer_limit)
> >               return NET_XMIT_SUCCESS;
> > @@ -1976,8 +1996,8 @@ static struct sk_buff *cake_dequeue_one(struct Qd=
isc *sch)
> >       if (flow->head) {
> >               skb =3D dequeue_head(flow);
> >               len =3D qdisc_pkt_len(skb);
> > -             b->backlogs[q->cur_flow] -=3D len;
> > -             b->tin_backlog           -=3D len;
> > +             WRITE_ONCE(b->backlogs[q->cur_flow], b->backlogs[q->cur_f=
low] - len);
> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
> >               qstats_backlog_sub(sch, len);
> >               q->buffer_used           -=3D skb->truesize;
> >               qdisc_qlen_dec(sch);
> > @@ -2042,7 +2062,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
> >
> >               cake_configure_rates(sch, new_rate, true);
> >               q->last_checked_active =3D now;
> > -             q->active_queues =3D num_active_qs;
> > +             WRITE_ONCE(q->active_queues, num_active_qs);
> >       }
> >
> >  begin:
> > @@ -2149,8 +2169,10 @@ static struct sk_buff *cake_dequeue(struct Qdisc=
 *sch)
> >                */
> >               if (flow->set =3D=3D CAKE_SET_SPARSE) {
> >                       if (flow->head) {
> > -                             b->sparse_flow_count--;
> > -                             b->bulk_flow_count++;
> > +                             WRITE_ONCE(b->sparse_flow_count,
> > +                                        b->sparse_flow_count - 1);
> > +                             WRITE_ONCE(b->bulk_flow_count,
> > +                                        b->bulk_flow_count + 1);
> >
> >                               cake_inc_srchost_bulk_flow_count(b, flow,=
 q->config->flow_mode);
> >                               cake_inc_dsthost_bulk_flow_count(b, flow,=
 q->config->flow_mode);
> > @@ -2165,7 +2187,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
> >                       }
> >               }
> >
> > -             flow->deficit +=3D cake_get_flow_quantum(b, flow, q->conf=
ig->flow_mode);
> > +             WRITE_ONCE(flow->deficit,
> > +                        flow->deficit + cake_get_flow_quantum(b, flow,=
 q->config->flow_mode));
> >               list_move_tail(&flow->flowchain, &b->old_flows);
> >
> >               goto retry;
> > @@ -2177,7 +2200,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
> >               if (!skb) {
> >                       /* this queue was actually empty */
> >                       if (cobalt_queue_empty(&flow->cvars, &b->cparams,=
 now))
> > -                             b->unresponsive_flow_count--;
> > +                             WRITE_ONCE(b->unresponsive_flow_count,
> > +                                        b->unresponsive_flow_count - 1=
);
> >
> >                       if (flow->cvars.p_drop || flow->cvars.count ||
> >                           ktime_before(now, flow->cvars.drop_next)) {
> > @@ -2187,16 +2211,22 @@ static struct sk_buff *cake_dequeue(struct Qdis=
c *sch)
> >                               list_move_tail(&flow->flowchain,
> >                                              &b->decaying_flows);
> >                               if (flow->set =3D=3D CAKE_SET_BULK) {
> > -                                     b->bulk_flow_count--;
> > +                                     WRITE_ONCE(b->bulk_flow_count,
> > +                                                b->bulk_flow_count - 1=
);
> >
> > -                                     cake_dec_srchost_bulk_flow_count(=
b, flow, q->config->flow_mode);
> > -                                     cake_dec_dsthost_bulk_flow_count(=
b, flow, q->config->flow_mode);
> > +                                     cake_dec_srchost_bulk_flow_count(=
b, flow,
> > +                                                                      =
q->config->flow_mode);
> > +                                     cake_dec_dsthost_bulk_flow_count(=
b, flow,
> > +                                                                      =
q->config->flow_mode);
>
> These seem like unnecessary whitespace changes?

Line length was 105 ... a bit over the recommended limit.

