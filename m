Return-Path: <netdev+bounces-33345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C779D787
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE546282131
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6169F8F54;
	Tue, 12 Sep 2023 17:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538055CAC
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:29:03 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014710F2
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:29:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41513d2cca7so26641cf.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694539741; x=1695144541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C68JmHetf6csZ7uaIOcZ347VMnT6195vMOibg6ebhPk=;
        b=icRgmMOZ1JamHxs7ch4TprRDtsyQ6w3whnhRDbhHRWL4kDhOtCeVotQJn1AnTIpU8g
         x/MePSsvDeWTTh7RdoI/X0LGiXEaAOlquEspn6oZnRswziZsminwZCqqKdtoNzyWpw+H
         XC1Yip8GgcQ7bBg4A1IWb8TvvkNpDOqsyDb+622qXzgCbUUOlryj6zouWh9FSzusaG0q
         P7fBOC2M0P/t+KlkJYfeHd7eJ5B7j3MSs2PvkjusxZDP+jw6w0cOgcm/AWhbGlki818G
         cWGJTb2fowKJTry25/xkvHWXU1mjPrcdTXyiv8ASHXR4zv1c3xNuxFdSvwpqzV97lMYx
         TPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539741; x=1695144541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C68JmHetf6csZ7uaIOcZ347VMnT6195vMOibg6ebhPk=;
        b=kKlNSTranXwijB8G6EJpJQ4nrkRNc7ZzMKq+R/Mpeyj0iF318fcej3BE5/T4Gdk+uU
         6au/ofS29zlOrbAs1cONJyYLFDIIt86ZUKiG1H9AuCcGXEPBhwy9dIe6Pc5tdpMFa+4L
         TIwtz0NxYM1jg3eTtpQt8f6ElrJjZXoN5GreMHZiyyXeC1RWHvUD2LT5e3i2l4/Nberu
         1WSvOLud600tIuVa15OmIbwMYz6zN+SdKhYVUDoiq5EoKT1HtDtEPH80gT7yX52W4MLY
         vuvxVD3szSOjbwAAO5Nmd2HyIgVS2y0if6elM4nA7x9vZiW1QQPQHOrjg/zDY8iCfCA6
         n8sA==
X-Gm-Message-State: AOJu0Yxto5ycgCnVILVkw/96ynZIuGc5khDI2KReGXSx57A7Fa941ulT
	nVCYduQ/9qfCZUvu6UZUQX/hYM4ZyX3JpcsUY+mCSgKaF5MGi0wzn7c=
X-Google-Smtp-Source: AGHT+IFQsLvdANwfSgZAFEuZYncS5OyKbw/svHb1e7cq5kBKaXzbwRraAgtp/jHHozBU2dyWJsJiSiICFMZrXJHEVLo=
X-Received: by 2002:a05:622a:1914:b0:410:4845:8d37 with SMTP id
 w20-20020a05622a191400b0041048458d37mr253844qtc.29.1694539741427; Tue, 12 Sep
 2023 10:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com> <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
In-Reply-To: <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 19:28:50 +0200
Message-ID: <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 7:16=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 12 Sep 2023 18:04:44 +0200
>
> > On Tue, Sep 12, 2023 at 5:58=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Tue, 12 Sep 2023 06:23:24 +0200
> >>
> >>> On Mon, Sep 11, 2023 at 10:20=E2=80=AFAM Yajun Deng <yajun.deng@linux=
.dev> wrote:
> >>>>
> >>>> Although there is a kfree_skb_reason() helper function that can be u=
sed
> >>>> to find the reason for dropped packets, but most callers didn't incr=
ease
> >>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped=
.
> >>
> >> [...]
> >>
> >>>>  EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>>>
> >>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(stru=
ct net_device *dev)
> >>>> +static struct net_device_core_stats __percpu *netdev_core_stats_all=
oc(struct net_device *dev)
> >>>>  {
> >>>>         struct net_device_core_stats __percpu *p;
> >>>>
> >>>> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netd=
ev_core_stats_alloc(struct net_device
> >>>>         /* This READ_ONCE() pairs with the cmpxchg() above */
> >>>>         return READ_ONCE(dev->core_stats);
> >>>>  }
> >>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >>>> +
> >>>> +static inline struct net_device_core_stats __percpu *dev_core_stats=
(struct net_device *dev)
> >>>
> >>> Please remove this inline attritbute. Consider using __cold instead.
> >>
> >> __cold? O_o I thought the author's inlining it as it's a couple
> >> locs/intstructions, while the compilers would most likely keep it
> >> non-inlined as it's referenced 4 times. __cold will for sure keep it
> >> standalone and place it in .text.cold, i.e. far away from the call sit=
es.
> >> I realize dev_core_stats_*() aren't called frequently, but why making
> >> only one small helper cold rather than all of them then?
> >>
> >
> > This helper is used at least one time per netdevice lifetime.
> > This is definitely cold.
>
> But then each dev_stats_*_inc() (not cold) has to call it from a
> completely different piece of .text far from their. I either don't
> understand the idea or dunno. Why not make them cold as well then?
>

The __cold attribute is only applied to the helper _allocating_ the
memory, once.

Not on the functions actually incrementing the stats.

There are situations where they can be called thousands/millions of
times per second (incast flood).
If this situation happens, the _allocation_ still happens once.



> > Forcing an inline makes no sense, this would duplicate the code four ti=
mes,
> > for absolutely no gain.
>
> I'd love to see bloat-o-meter numbers, I suspect we're talking about
> 20-30 bytes.
>
> >
> >>>
> >>>> +{
> >>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> +
> >>>> +       if (likely(p))
> >>>> +               return p;
> >>>> +
> >>>> +       return netdev_core_stats_alloc(dev);
> >>>> +}
> >>
> >> [...]
> >>
> >> Thanks,
> >> Olek
>
> Thanks,
> Olek

