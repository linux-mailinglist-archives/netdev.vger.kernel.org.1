Return-Path: <netdev+bounces-291678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFo0EmqNFWrUWQcAu9opvQ
	(envelope-from <netdev+bounces-291678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1965D550C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91BC303EC27
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350C3F7ABE;
	Tue, 26 May 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="u2T0t4FC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AB3DBD6F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796889; cv=pass; b=SBmfN25MT0AEFhm4Wr9IDPeR+IvhvrNnP/1jIJaLj5Z4POkUF/IXGwrrXfV0MJz7N3SuNVmg7eX70hCeGG9VthhzOnM+eFnxu7S51MThkGGU6GKQUj39K41TknTS8HjRCL29GrOEOHnOYAXHqObjT/guEfQ81h3zenFc6VEAS+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796889; c=relaxed/simple;
	bh=WzZZoH3Rb04BG6bTIuBlu6LbSdN1ZVh7q3yVjJ4VHIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAoXXiIchgjE6lS+++lt79UA60ljBUPNb17geBunq5KLv9nKmnrC1MZZRfbxDmaLawerbrlcNvALsl5bLLfSLZ1Qt2EJeCL1ABYVD2vqNCOXBixN/ZqVF7+Jktkovnyi7v8ay5u5tC+kJYIR1gQ/mfDuC73FCb1ON5QhP1P7Hj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=u2T0t4FC; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-837b39eb078so7243080b3a.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 05:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779796883; cv=none;
        d=google.com; s=arc-20240605;
        b=jGSIf9yH1F/eINvkIaYToeSUxGg5wabBIEKyNEVE6B5kM6g9sRUb1ZqvY5N4nkbeLz
         zn+Xu2EoIGyp73kE35zJSsR+9I7eV1v+cSP8ODsLs/o4cjgYSwJvz5CI+x43qogHqVry
         f5n+SQXz9UKdtna2LHGRJkp6Fz0EaOhKfS66mY+w6r7eDhxPVAjANdEYaitDfF3+Gwox
         YinHqkVb0EC4ya4RbW/FEpQPwnJX61n6oa5Sz5GQPfk+4Wo63yy5SFGv75s75Mw6zy97
         2v66x0PsutBP9eRsu+QJ5J99wBjdQmcfetL45JBemsdz+Wv0Fj1XtvIIpklWavZ3q4qF
         KFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IBhDiGz4hykhxlnPgJ0+HZoywaxKHxSmGhWWIm262Xg=;
        fh=2hesRKs88IL3nRVXrANU/bIA69VUlxqt1iOXy2tPtyk=;
        b=VvfJgfwzJ30x6NsY/p05I/KJVQ6a8bvNixB+MBderkbmgVTkRoHrR6KkcLfDpjjUel
         1f2XJ0mnhWiH/lVpQrzzhlYBdAchQWLtXLXgO7MKwc80s6pBkXhwff8n3YYOEYWTwp8t
         fkYYTZ0FermEj8PJN7gw60TEcICf3VyEKrTuzbZ/ALw4cImVRFf3QHnajnlif1xKPQeG
         pPSR3t3RsXqvPxey6LNEsrjDp7KcaFQVSd7wnX7pQPv/mULNCn/2o+xz/zhYxQw9y6R1
         jSQi85fcZUH0GjfU/OpFYzxzrYRU9FC4av1CpKJD4ezyH1rnA4JjvmAz82zIjBN7kxPc
         49tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779796883; x=1780401683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBhDiGz4hykhxlnPgJ0+HZoywaxKHxSmGhWWIm262Xg=;
        b=u2T0t4FC3cm+NaEul2ylmKNoaeclq8hedwQiwOU63dEaDs2A6jDYGvTiSi7GQp312i
         9Z8dOHuQIiG4EsfrOQrpFpj1kJz52DwsVWUpkYuoKRK8Ps7KWL+GmOufWB/V4KPD+8dV
         DKT/DG/vVdm5MVL87yv1ItWbEGuHTa/w7KvPVZrf8eChqKrXw09nn/e9QDHikdxSzmnt
         56gmgX/0w8wD39BUIDcP2kS2ctmHPIHE8/grKHzI5uL9/5sLwSqLYbGZwmqZZ1gIWl0n
         n8RiduBHb7adgcVaQDoZyjn5cgjuLJCrsqNf+KqJ3+IR2wuUkfhdM7Zh5ePvcVlKDV3R
         MeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796883; x=1780401683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBhDiGz4hykhxlnPgJ0+HZoywaxKHxSmGhWWIm262Xg=;
        b=WhI2nOJ/UJvlcyehpphGNdzLinHR1KaZ2zAgWAkd1MBxtby2H9nffKdT6D95EaS+mG
         JaezI420wgcZ2ak1mXPLNq88+yuzGB6whZxXzUHeDVi0OIs5f/czGXamYSifp21aHxBX
         fYXtUL6vaY89xgBM1jF/+qw7FjLu7fMszxlCyhqeQSFV+AgWTkVlZJh/CYWCJxe6w7wW
         EriqZOmgSQHZW2/jzN2ldp19pE1i4UJo82rLTEtqbxVE+qle3K9lbFkLLrd3rJfD/OJI
         1Bh5cHQ4hYp/Zp5L57s9A3vV/PNGlrrYWi7n1cnwlDdDNVWGxoxB2awcp4I8LMVMsqPp
         ZxOw==
X-Forwarded-Encrypted: i=1; AFNElJ8L0E4/ClR0t+i/0/NUlEsYJrFBV+59/Cn337JbYmWY2hjcG4t2/7lwTP4Q0e+Y2rxPCOD5/WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSb4+SbHTrqt4P4f7gJOx6HBY1jkZi30vkb9LLH7xS2FWpBhi
	5JtyMNvdU55BTs12VZrEhKcqVbrXoqfxdM/J0oaPMSYYklD5EPSnEmftDRUxTFOBsdyf2U6G6f0
	5Ab9LqZQv05HwTAG4g9IHr9nOTc6Y2S3t6UmsmbAN
X-Gm-Gg: Acq92OEz0kkIXhu981Hd/hL0kkM2gkWvs7K/VJPTyUFTWjEzpndW/XN+iHnnR0e7q6y
	l5ar1eGB4n/JL6u8ZmlTuBeoNtftbsJ4Prt/NL5lRn1jvKd9qWUPP8dzsNGzoleIIbCEpoTQSO2
	maJ53xhOXdlqxTcgirLZUI/5J5s+cQTgJnlusbIw1fjWfhJZrQ3ATLz3LETj/OJxfDoCgkrY8Pe
	ZKMdJgA1Pp9o99WFKdlXCzgSS5D5aWd4Biue2Y/Bk7+/xq0CaZKudM9C0oLL8z2g/vb6nMqzlkw
	ikb+XZ9qRW5N+/4ZirZQEuiEA8rhtA==
X-Received: by 2002:a05:6a21:398a:b0:39b:c4cd:d854 with SMTP id
 adf61e73a8af0-3b328eb8acdmr17090692637.30.1779796881403; Tue, 26 May 2026
 05:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <20260526105306.48a2bee7@pumpkin>
In-Reply-To: <20260526105306.48a2bee7@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 May 2026 08:01:08 -0400
X-Gm-Features: AVHnY4KN76QLQ1NJR6wNz7N5Cncrqn2crT5KH1ULlGZRtvh-08wB6s4-KiRM3AE
Message-ID: <CAM0EoMmNnPj-UO_7PN2Z3vaWKSqo4M6PzcSnn80Kzm_H1JTptA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-291678-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9D1965D550C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:53=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 18 May 2026 20:39:50 -0700
> Rajat Gupta <rajat.gupta@oss.qualcomm.com> wrote:
>
> > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > once before the key loop using tcfp_off_max_hint, but the hint does
> > not account for the runtime header offset added by typed keys. This
> > can leave part of the write region un-COW'd.
> >
> > Fix by moving skb_ensure_writable() inside the per-key loop where
> > the actual write offset is known, and add overflow checking on the
> > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > at ingress), use skb_cow() to COW the headroom instead. Guard
> > offset_valid() against INT_MIN, where negation is undefined.
> >
> > Additionally, linearize skbs with shared frags upfront to prevent
> > silent data corruption when pedit operates on zero-copy pages
> > (e.g. from sendfile).
> >
> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is wr=
itable")
> > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Reported-by: Han Guidong <2045gemini@gmail.com>
> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > Tested-by: Han Guidong <2045gemini@gmail.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > ---
> >  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index bc20f08a2..79921b8d8 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> >  #include <linux/slab.h>
> > +#include <linux/overflow.h>
> >  #include <net/ipv6.h>
> >  #include <net/netlink.h>
> >  #include <net/pkt_sched.h>
> > @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int =
offset)
> >       if (offset > 0 && offset > skb->len)
> >               return false;
> >
> > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > -             return false;
> > +     if (offset < 0) {
> > +             if (offset =3D=3D INT_MIN || -offset > skb_headroom(skb))
> > +                     return false;
> > +     }
>
> Can't you negate skb_headroom() instead - that cannot be INT_MIN.
> So:
>         if (offset < 0 && offset < -skb_headroom(skb))
>

You mean something like this? if (offset < 0 && offset <
-(int)skb_headroom(skb))
 That does feel cleaner, yes.

> >
> >       return true;
> >  }
> > @@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >       struct tcf_pedit_key_ex *tkey_ex;
> >       struct tcf_pedit_parms *parms;
> >       struct tc_pedit_key *tkey;
> > -     u32 max_offset;
> >       int i;
> >
> >       parms =3D rcu_dereference_bh(p->parms);
> >
> > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> > -                   skb_transport_offset(skb) :
> > -                   skb_network_offset(skb)) +
> > -                  parms->tcfp_off_max_hint;
> > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > -             goto done;
> > +     /*
> > +      * If the skb has shared frags the user is likely using zero-copy
> > +      * (e.g. sendfile).  Those page frags may point to page-cache pag=
es;
> > +      * writing into them would silently corrupt the page cache.
> > +      * Linearize so pedit operates on a private copy.
> > +      * TL;DR: if you want zero-copy, don't use pedit.
> > +      */
> > +     if (skb_has_shared_frag(skb)) {
> > +             if (__skb_linearize(skb))
> > +                     goto bad;
> > +     }
>
> Should there be a way of 'unsharing' frags by just copying the frags
> rather than doing a full linearize?
> That would be much less likely to fail for big skb.
>

It has been agreed that this chunk is unnecessary, so it will be
removed in the next update.

cheers,
jamal

