Return-Path: <netdev+bounces-259313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDgaMb2/lWlYUgIAu9opvQ
	(envelope-from <netdev+bounces-259313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:33:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083C156B76
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D9B9305C3C5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE16327206;
	Wed, 18 Feb 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="m9csE+N7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667F326D73
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421583; cv=pass; b=VLDcQb+spssWN1peDn442F3yYUpp0drx78zxVlcKhHfbrGYf9LKSTW36q1RWkhwmUozHH31e1p5i/iWHPGNQI3bUzoMzTnthUx1KPixpQ8kf/2vQC8y7ZQSQuyUMBJWJ0iY1oRTxhA04i/LDwnEW2ZWfB9dLuSwAtBO++qEp9O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421583; c=relaxed/simple;
	bh=Xh5p01gjlblJPCd5win9BhFW7XTWUDyKbz8czLev6Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ktn6GQO99LXXVATYicUx7sgP18BtCKa/P4U8FCil3ASNUubqWmrTf7X4w62GekxIH14MREHA8H3Nq05WhbF3CsaYgqi3PMY6x0LaApMQPSSayxzC7Wf/ehJ7T7f+IbVSxbRpKp6/6eQ/bWjTcfkAmcPXENpiL8HG18S/hL8kno8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=m9csE+N7; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so3598490a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 05:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771421581; cv=none;
        d=google.com; s=arc-20240605;
        b=O37L4FKmkeGamj0YPpLrqj5cKWltckXick+QNJ9h6cBANaETbMFtMTe8YKoQh6hrgw
         9WqQL5TN3CKRMwakBVetVuBBA5pe8bEzo2jdS5o+GIrgHgr1LJBIqmmM4uu09+crV9ig
         ftGo6PKDJVuJevWEVYQ507olOL+i3wyERhSRYA3Ofqqn6mrTKMQSuNqHDi+Pi72o5CWp
         BTvEJHvJoLYwshUe2ETSdQ59dp3fEqY/Xr+kyEIyC1v5v3COy9zLrp9L/nJ6BZC0F74w
         obF8DKaXjscSfjc4xITh9dww3/JLlMpJ5uA4QmhTk/Q/Nbh6I7xA8pCH2mL/9WfhZdkm
         Tt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvMSMw23moFVAI527p/9o996bSUPA/Lihxmu9SRpTuA=;
        fh=9LJK7r1xJHeCOS6cqj7GAOWvlwO5c8k1gylolR4HO0I=;
        b=jgP/dlU+PIuDXv5v++gU4bVwP9Ryoq2lOXLDwdUIR59DYA6kW0y4UTsPMxR1fwOqTj
         wvHHNHRi5WMS3KR3cMZPcDHk6R3HKEiwIZn/Mukj6iQZo9pziZe+YtUKKmGifvobj39h
         uT8Lh/OcpzjEWrbc4fE8cF+qOBFLbfbAO+Nq80TNL0zZq+AAY6e4AFQ4PrsqoFl3n8Xt
         TfIe3TeAbe4in5rNkz9BMqQwSWhlWMAA4aWo0Iks4Ka436voDhsZW6azrfT0ZPTNabMN
         doGIOqgvsy6GDF0/gfvrqnAMTudo088sOSCFA5n9s3fFOvaQYe572/r1YVD9AiUj7tOe
         IiTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771421581; x=1772026381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvMSMw23moFVAI527p/9o996bSUPA/Lihxmu9SRpTuA=;
        b=m9csE+N7Cuxo7fgBnB4vTog5kfJQDEkDKnOmLKPOkSHb2SFg8ANXl7W46PNCJfxpNL
         gnC9MS4U0UOPgY6Lwj+46n+aJukjJ3ZZEMWphGMOeVB4QXUbQpiOgrQ5LmuF66sLRFI/
         MkOX6gGXsup2Bn9NgAOgkYrex8ywopZi8JrcQQ2rRI91g/tlde8VVdoRalvzNtroQ8rz
         zch3PF6xZtNIOhfwlRHfUTfgBJJssrjDN1toh7WSj0O34biViWDmQjSy7OLOBtFvDuGP
         G5wsvpe+mljBefbZMv6cZycDmLqR5JEVWE2ZoqwUmy43JRZtJitHFZfY2+8Qlr0hSfgC
         Txgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771421581; x=1772026381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvMSMw23moFVAI527p/9o996bSUPA/Lihxmu9SRpTuA=;
        b=RrKhMIBetl9gHkHXIm00g2or4uyb+prnd7bXQ5Qx7K32GLGST7FC54XtZ6EWuSfs9p
         3KTIa/IMpMWPEmlbn0BFhFSJulLvxurBS4zTyoPSfBtXRyVqT6+TMxj+mNBwayoX6u1x
         H3hD/T1jzjM23qXa8QiCoCtEsWB9sgBSIbuGceEu6MxRMyn+zekFV40kTZB7wZIqlo/a
         rAdqHoAiuuWawvW8Xs6L2PNirQSbdcfkQG/pv7wzkDtXhPp9oHtYM5/X6ATe5RByK5BU
         qWe8Gd3Fhe/kaMpXgWmUlpAQV9QraCpO2BW5vUWhjOxb9EfkCpf3CITxVoCuuS5ll6ae
         oLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPLJfbPs129cbotnbHs27wEjDDpy1rDxsusJCdrZwmmDBj8Lt0m+kGMoYnD2p1+xDDRnr5pio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKeWimkpuhPnQxOJAJ9vUIeOrh5rKKVAoGLY1cyyhmZJDm+or
	ZhN9w/HhU7195ABOv4ftSU9ltkhE9daOoSAJVEnE1c2WbklHivawrzGEdOBmQTQLGMXLqHRlrXe
	qjE0phLvJ2K3k4yAEpcZ8uFDjcK3QNRkHGxrYHCRx
X-Gm-Gg: AZuq6aKIExWzDsOiaKJeH49SCv7uWi9SWi5PWynbUq6YydkeQUy+H2fiinG4QGmi8Q1
	IvIukdG49jMVQaRGa3Gl7r/TJFgM3vYYZoLo8pKvNH1m/DsZhYZx4IjyzAOMMjRCloLp0P+en3i
	GlnlDs/fWPoYD+Xdq8AyID76MOynAz5fOPmuYasruaZio++NuGF3nlR+Uz4E6yLvHSSZkYa9T6B
	39U1Fj9BBQavbdp4/QfDDtQdOUOuVDREwAZUL1/qAONUzq4dqIETQNfkUdN6aT+prh5ADnKuThu
	ESW8o9pnB/FwkvU=
X-Received: by 2002:a17:902:cf10:b0:2a7:b447:3389 with SMTP id
 d9443c01a7336-2ad17433847mr149623225ad.2.1771421581129; Wed, 18 Feb 2026
 05:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213113849.136695-2-p@1g4.org> <20260213155528.2515066-1-horms@kernel.org>
 <BRr95QFZN9_ai_HGUbpS_NTCZ_7nKmODaNT-iE1S9IdeiK8dDJjOCh7C9DDrZE29LUJ3YTRkAav0xpk3azg54ruQSwG74GWNTDB-HpOMasM=@1g4.org>
In-Reply-To: <BRr95QFZN9_ai_HGUbpS_NTCZ_7nKmODaNT-iE1S9IdeiK8dDJjOCh7C9DDrZE29LUJ3YTRkAav0xpk3azg54ruQSwG74GWNTDB-HpOMasM=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Feb 2026 08:32:50 -0500
X-Gm-Features: AaiRm504lTrqeXPJ6sffoXwIj4sofBkq_7-PtyPUoLbU4w_Lr7rV2qmv46TvQuY
Message-ID: <CAM0EoMnZNG5k8_XDYS190HdGn-_7wdo3mqBQ-8KE-CrVDGJUhw@mail.gmail.com>
Subject: Re: [net,v6,1/1] net/sched: act_gate: snapshot parameters with RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Simon Horman <horms@kernel.org>, jiri@resnulli.us, pabeni@redhat.com, 
	victor@mojatatu.com, davem@davemloft.net, netdev@vger.kernel.org, 
	stable@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-259313-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,resnulli.us,redhat.com,mojatatu.com,davemloft.net,vger.kernel.org,google.com,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1g4.org:email]
X-Rspamd-Queue-Id: 4083C156B76
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:37=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> 1. I don=E2=80=99t think this is reachable, during create, the IDR slot i=
s populated
>    with ERR_PTR(-EBUSY) by tcf_idr_check_alloc(). The real action pointer=
 is
>    only published later by tcf_idr_insert_many(), which runs after init()
>    returns and after tcf_gate_init() has already done:
>
>      rcu_replace_pointer(gact->param, p, ...)
>
>    Both the normal lookup path and the dump walker treat ERR_PTR entries =
as
>    =E2=80=9Cnot ready=E2=80=9D: tcf_idr_search() rejects them and the dum=
p walker skips.
>

Correct.


> 2. offload_act_setup() is currently called with act->tcfa_lock held in bo=
th
>    call chains (net/sched/act_api.c and net/sched/cls_api.c). Since
>    gact->tcf_lock aliases common.tcfa_lock, the
>    lockdep_is_held(&gact->tcf_lock) condition in tcf_gate_params_locked()
>    is satisfied.
>

The spinlock will catch it as stated.

The AI is clearly hallucinating..

cheers,
jamal

> Thanks,
> Paul
>
>
>
>
> On Friday, February 13th, 2026 at 9:55 AM, Simon Horman <horms@kernel.org=
> wrote:
>
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html
> > ---
> > net/sched: act_gate: snapshot parameters with RCU on replace
> >
> > The gate action can be replaced while the hrtimer callback or dump path=
 is
> > walking the schedule list.
> >
> > Convert the parameters to an RCU-protected snapshot and swap updates un=
der
> > tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE om=
its
> > the entry list, preserve the existing schedule so the effective state i=
s
> > unchanged.
> >
> > > diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gat=
e.h
> > > index c1a67149c6b6..5223c00279d5 100644
> > > --- a/include/net/tc_act/tc_gate.h
> > > +++ b/include/net/tc_act/tc_gate.h
> > > @@ -32,6 +32,7 @@ struct tcf_gate_params {
> > >     s32                     tcfg_clockid;
> > >     size_t                  num_entries;
> > >     struct list_head        entries;
> > > +   struct rcu_head         rcu;
> > >  };
> > >
> > >  #define GATE_ACT_GATE_OPEN BIT(0)
> > > @@ -39,7 +40,7 @@ struct tcf_gate_params {
> > >
> > >  struct tcf_gate {
> > >     struct tc_action        common;
> > > -   struct tcf_gate_params  param;
> > > +   struct tcf_gate_params __rcu *param;
> > >     u8                      current_gate_status;
> > >     ktime_t                 current_close_time;
> > >     u32                     current_entry_octets;
> > > @@ -51,47 +52,65 @@ struct tcf_gate {
> > >
> > >  #define to_gate(a) ((struct tcf_gate *)a)
> > >
> > > +static inline struct tcf_gate_params *tcf_gate_params_locked(const s=
truct tc_action *a)
> > > +{
> > > +   struct tcf_gate *gact =3D to_gate(a);
> > > +
> > > +   return rcu_dereference_protected(gact->param,
> > > +                                    lockdep_is_held(&gact->tcf_lock)=
);
> > > +}
> > > +
> > >  static inline s32 tcf_gate_prio(const struct tc_action *a)
> > >  {
> > > +   struct tcf_gate_params *p;
> > >     s32 tcfg_prio;
> > >
> > > -   tcfg_prio =3D to_gate(a)->param.tcfg_priority;
> > > +   p =3D tcf_gate_params_locked(a);
> > > +   tcfg_prio =3D p->tcfg_priority;
> > >
> > >     return tcfg_prio;
> > >  }
> >
> > [ ... ]
> >
> > > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > > index c1f75f272757..60c80e609ec3 100644
> > > --- a/net/sched/act_gate.c
> > > +++ b/net/sched/act_gate.c
> >
> > [ ... ]
> >
> > > @@ -509,10 +621,9 @@ static int tcf_gate_dump(struct sk_buff *skb, st=
ruct tc_action *a,
> > >     struct nlattr *entry_list;
> > >     struct tcf_t t;
> > >
> > > -   spin_lock_bh(&gact->tcf_lock);
> > > -   opt.action =3D gact->tcf_action;
> > > -
> > > -   p =3D &gact->param;
> > > +   rcu_read_lock();
> > > +   opt.action =3D READ_ONCE(gact->tcf_action);
> > > +   p =3D rcu_dereference(gact->param);
> > >
> > >     if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
> > >             goto nla_put_failure;
> > >
> > > @@ -552,12 +663,12 @@ static int tcf_gate_dump(struct sk_buff *skb, s=
truct tc_action *a,
> > >     tcf_tm_dump(&t, &gact->tcf_tm);
> > >     if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
> > >             goto nla_put_failure;
> > > -   spin_unlock_bh(&gact->tcf_lock);
> > > +   rcu_read_unlock();
> > >
> > >     return skb->len;
> > >
> > >  nla_put_failure:
> > > -   spin_unlock_bh(&gact->tcf_lock);
> > > +   rcu_read_unlock();
> > >     nlmsg_trim(skb, b);
> > >     return -1;
> > >  }
> >
> > Can tcf_gate_dump be called before gact->param is initialized?
> >
> > After the conversion to RCU pointers, if tcf_gate_dump is called during
> > action initialization (between tcf_idr_create_from_flags and
> > rcu_replace_pointer in tcf_gate_init), p will be NULL:
> >
> > net/sched/act_gate.c:tcf_gate_init() {
> >     tcf_idr_create_from_flags(...);
> >     ...
> >     // gact->param still NULL here
> >     ...
> >     rcu_replace_pointer(gact->param, p, ...);  // line 517
> > }
> >
> > net/sched/act_gate.c:tcf_gate_dump() {
> >     rcu_read_lock();
> >     p =3D rcu_dereference(gact->param);  // can be NULL
> >
> >     if (nla_put_u64_64bit(skb, TCA_GATE_BASE_TIME,
> >                           p->tcfg_basetime, TCA_GATE_PAD))  // NULL der=
ef
> > }
> >
> > Before the patch, param was an embedded struct that was zero-initialize=
d,
> > so dump would return valid (if meaningless) data. After the patch, this
> > becomes a NULL pointer dereference.
> >
> > While the tc action framework may prevent dumping partially initialized
> > actions through external synchronization, should this code include a NU=
LL
> > check to make the initialization window safer?
> >
> > The second issue is in the hardware offload path. Looking at
> > net/sched/act_gate.c:tcf_gate_offload_act_setup(), the function calls t=
he
> > accessor helpers without holding tcf_lock:
> >
> > net/sched/act_gate.c:tcf_gate_offload_act_setup() {
> >     // no lock held here
> >     entry->gate.prio =3D tcf_gate_prio(act);           // line 723
> >     entry->gate.basetime =3D tcf_gate_basetime(act);
> >     entry->gate.cycletime =3D tcf_gate_cycletime(act);
> >     ...
> > }
> >
> > include/net/tc_act/tc_gate.h:tcf_gate_prio() {
> >     p =3D tcf_gate_params_locked(a);  // uses rcu_dereference_protected
> >     ...
> > }
> >
> > include/net/tc_act/tc_gate.h:tcf_gate_params_locked() {
> >     return rcu_dereference_protected(gact->param,
> >                                      lockdep_is_held(&gact->tcf_lock));
> > }
> >
> > Does tcf_gate_offload_act_setup violate the locking requirements?
> >
> > The accessor functions all use tcf_gate_params_locked(), which requires
> > tcf_lock to be held (verified via lockdep_is_held). The offload setup
> > function doesn't acquire this lock before calling the accessors.
> >
> > With lockdep enabled, this will trigger warnings. Without lockdep, ther=
e's
> > a race where param can be replaced via rcu_replace_pointer while the
> > offload function is reading it, potentially causing reads of inconsiste=
nt
> > state.
> >
> > The dump path uses the correct pattern with rcu_read_lock() and
> > rcu_dereference(). Should the offload path either acquire tcf_lock or u=
se
> > a similar RCU-only approach?
> >

