Return-Path: <netdev+bounces-272083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwfHdU9xWn88gQAu9opvQ
	(envelope-from <netdev+bounces-272083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:08:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7B3368B7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 460B430B3CC9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6F2F12B3;
	Thu, 26 Mar 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlsL8dNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E8309EE7
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533711; cv=pass; b=qeG5Zr/aSLQPysZZSVgigJIL1TE+mzfzM2Femfsr7q7UnnH1bhaNiHHXQUXdG4QbpHVdj5T5mLECoChcmeatLmPw77j6ihQbjLimD8LRbVWfM/ZDtdTCByXPxkqvbN42Oe5T8hy2JyIDU1QEYOFgM6ZPJrvDXxWrISiQ09amFrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533711; c=relaxed/simple;
	bh=1mCWJ6GmgyrWdrBzqF7RYvjEZZMj6tQLN0C0SoLxPdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM8Jc5Sb4e33q0VNy0KUrEZer8sEWXbQtDth+hkCAWmoZfSf8cqiE57KwLLkyYuYkLj0eHEO3dktPj7Go5PfivXhLu1mPF3rCeWOpy4ZgaMshqIpjqv/H9LJIY74xlt/NU91aCB+JUlHwNJFV+G8aZpWVForeuvsuEwQmeutzlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlsL8dNK; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-464bc03efd8so537142b6e.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774533709; cv=none;
        d=google.com; s=arc-20240605;
        b=GBqX2VpkROf/eun07nGg0QxuoVAyou12rpB3pGmcybqRrzTz3Ug9gQm45s4wDIL9p0
         nRZkSlFcLu4RYW/LVlq22JPLvCO67bQ8mq6WS/Mdc0egZFXoCLGAulqfBHBkF9N4rNkg
         hIq/Kn4rIAyA859d9E5Yq7foKqYDrgaIRfmE05qGDGaExxQ599eXv1zGPyJxqetRJnB8
         xXTWQXVxSIDosrQgjF58/T6ST1CV44gNgavL9lb5pzOby56uJeB4qXqc0Wm3boRju5Ft
         u6ENzSyfVNVOd/m1daQ/NVvX8PB52fM3pg544XkQyB3zhi8oPAPxoXb1z3iTiaK6/M1F
         +dlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wQeZU/Ln24Gl12sg/XRCOP5LERM0uhGV9FWQ6YSt9CM=;
        fh=buZMbO1W+8GJEqkRpKgb6QHaFwShUc+UltRPfok3Y1w=;
        b=B/O7xDuJsHKbiqfxLTj4gN2sCyjIs05QBfMe19GQi4hXI0rYm/cbRHFayrXqBcrnX6
         jrnlsThMNDtxrBXxFBON3Yi/kb3uu69xPcRPwtA5XLStRL1L5xmzHSfM217tbgbQusVs
         lj52uuxDWAxM/CLVs3jAJwQrxZ8R37BXGWfpynJBx+3mpoOZKpZjREkiHnhExfNx6cNJ
         gYvsMVPhokoTFQuViWlGuGdvgU53/oWBVfWZHAqnr8n8SaAjkfHDiXLI1wpMjUmJiN4i
         gXW0Eo/cc5+6DN0vgOoO3XuwmJIPR9rAWoMNVD4N8rltVscutHBhm7xOpJEjrYE7u3Ds
         rDKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774533709; x=1775138509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQeZU/Ln24Gl12sg/XRCOP5LERM0uhGV9FWQ6YSt9CM=;
        b=PlsL8dNKfzh9WivLqLooLvLPNl6M8YVOJDjRoNTmVyMf71fQgd4wshXS0hVIEuQVZH
         qwdmdtftfGVg7uPhkdYnWwlNSH76AsBofXEWxBi5ORxgh79Us0mkm0Kavj7Bu1zF24hf
         hwOoMzYs3OMLEtGFpc3vgmzmCiJYUiSMghxHNXFlAIwzzjlAUulf63M8j7YfQXxdb1xy
         X1cfNJqw3Wp/ZE3oLPGmzM/kKynTwfvNOIn7ATfJFLQyTzOcMfSQVmilhwBGX2sejwc2
         hc3okh5V4VsxvRWyVEojwQrWXBDh0b9bNZuIn4U52fm7p1CVL9mxB4IceNaDDNz8R1DX
         SXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774533709; x=1775138509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wQeZU/Ln24Gl12sg/XRCOP5LERM0uhGV9FWQ6YSt9CM=;
        b=U9PCwgSIKj8pGPD4KqX3T2p1YfKQKnxutdq/ZZPoM/hXbMH0ayoZvufMrjUdFXfw4u
         VipRdrdOm7v43dSZBo5emyyEG8SEChnt4OEm5frvL187EzJg+vyHZ4XoWUlc8FBf3rtY
         x3+iYNYBppNzocZ5wphoL+CqYi3yMzh3PtPiXzy2dUol1ZWY4qV2FpF711RSv02ghSmb
         E1+UypEeOTFS3QZNv7xA0KAMC/VgBAHFzpozcnn5UXKeH9QT0w2LbYr0ceik5AtPbWlM
         X2Zhaz1GwOWKQFgRU5sZcBd4MXpvsCBN5Pn9pidIx/cdxLGcpN5hG5s1Hn+XHuqbEPW1
         XcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc//MdpU+jgqi7ctdoEpFuDj66qZZn1mg5ZDGNCJ7BU+zggH11u5Rw0ZHKR2H07jByOdsw9GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbQNKJ09Zpvx8s0pNzYaVBex4olTKQ6gRgQIsDDOzqkt9Ryqk
	matl30pDX3v4vNd3pIwRJA31B1aWh6RdwDJvO+cr33EKlOx+w1KspKyutqFUhJov1OdPtbxXv7a
	iJrnabkEm0w2HQQUdxCo+ZNlXmWkKClXyzIlLsbt4
X-Gm-Gg: ATEYQzw5l3vWnSx+rbfQjGzucR9YO0yrMYqffCMVVY10jZwQl2MofSMSXA9vU5AnT3v
	ECFDbHUk1+GwWPX2Yv7fMVXBv0VbzMBQmds6b7A4bbbjkr2pzRnhsPxdAjEmAVQltov9yg5+xqb
	Rmz22FG3n4ZXDHv2goaQX5r2AAgmk+CAt0ZFCCctR8diLunOi4Ybn+RjcESqXzTrTJxOkxyOBfC
	+QqBL3E89Ct/qzxp8AK9VelYByHbFU8YcIeePewJG1+x90/o/Mh0O++wZdxnbx5zIkdZeg5++5n
	InIH5mzTvpi0JqFH
X-Received: by 2002:a05:6808:6715:b0:463:4f2e:c50f with SMTP id
 5614622812f47-46a5c60a264mr3482954b6e.24.1774533708193; Thu, 26 Mar 2026
 07:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <CANn89i+SX1Kp7D2JzzEtg-zRkJzi4bdjzc2snvM7npJQzNp0+Q@mail.gmail.com>
 <acUw8zYwbbpgo8KJ@fedora> <39c100fe-1f6f-46d2-8dd5-cf82320508ff@linux.dev>
In-Reply-To: <39c100fe-1f6f-46d2-8dd5-cf82320508ff@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 07:01:36 -0700
X-Gm-Features: AQROBzB-h1a84INWJg1WUHbUag-_QTLSszzHuJ_Wpn9wYIQWW2ViNROKJgE6sQo
Message-ID: <CANn89i+wuKmY7NNoe+RNPN0XZNHvzTDOyKDSwA3QJZE3BMgVfQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using cmpxchg
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272083-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 0FF7B3368B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 6:44=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 3/26/26 9:13 PM, Hangbin Liu wrote:
> > On Thu, Mar 26, 2026 at 05:05:57AM -0700, Eric Dumazet wrote:
> >>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> >>> index dd26657b6a4a..64de761f40d5 100644
> >>> --- a/net/ipv6/ip6_fib.c
> >>> +++ b/net/ipv6/ip6_fib.c
> >>> @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int=
 metric, u32 val)
> >>>          if (!f6i)
> >>>                  return;
> >>>
> >>> -       if (f6i->fib6_metrics =3D=3D &dst_default_metrics) {
> >>> +       if (READ_ONCE(f6i->fib6_metrics) =3D=3D &dst_default_metrics)=
 {
> >>> +               struct dst_metrics *dflt =3D (struct dst_metrics *)&d=
st_default_metrics;
> >>>                  struct dst_metrics *p =3D kzalloc_obj(*p, GFP_ATOMIC=
);
> >>>
> >>>                  if (!p)
> >>>                          return;
> >>>
> >>>                  refcount_set(&p->refcnt, 1);
> >>> -               f6i->fib6_metrics =3D p;
> >>> +               if (cmpxchg(&f6i->fib6_metrics, dflt, p) !=3D dflt)
> >>> +                       kfree(p);
> >>>          }
> >>>
> >> The following line should happen before the cmpxchg(),
> >>   ->metrics[X] accesses also need READ_ONCE()/WRITE_ONCE() annotations=
.
> > Hi Eric,
> >
> > Jiayuan also suggested to using READ_ONCE()/WRITE_ONCE() for metrics[X]
> > accesses. But I don't get why this line should happen before the cmpxch=
g(),
> > Would you please help explain?
>
>
> I think what Eric means is something like this:
>
>
> ...
>          struct dst_metrics *p =3D kzalloc_obj(*p, GFP_ATOMIC);
>
>          if (!p)
>              return;
>
>          p->metrics[metric - 1] =3D val;
>          refcount_set(&p->refcnt, 1);
>          if (cmpxchg(&f6i->fib6_metrics, dflt, p) !=3D dflt)
>              kfree(p);
>          else
>              return;
>      }
> }
>
> m =3D READ_ONCE(f6i->fib6_metrics);
> WRITE_ONCE(m->metrics[metric - 1], val);
>
>
> Since p is private data before being published via cmpxchg(), we can
> safely initialize its metrics beforehand. This way we don't need to
> worry about concurrent access to f6i->fib6_metrics->metrics[] during
> initialization. Right?

Yes.  Think about RCU (Read Copy Update) rules.

We allocate an object, and populate it, then make sure changes are
committed, before publishing the new pointer.

Othewise an other cpu could read a 0 metric, while we wanted something else=
.

