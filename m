Return-Path: <netdev+bounces-33352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0179D84E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FB1C20F79
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B19454;
	Tue, 12 Sep 2023 18:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED5524E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:04:07 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15096E59
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:04:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414c54b2551so33841cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694541846; x=1695146646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltbshIgUZ3GxU8tCibnnL+HEfHX0Nv7hadU45yI7Sy8=;
        b=KfN+opurEyItLHYtyyguBdu9hsqBm6LR5DZtVjpUAAEH44D/L4PQ2bTtfupbK5Wx8u
         wvXlnRV8/rpzMoKHt1RtmhajlYMZYDxVXsWu3a6t2Ffrnwn+mip8GFMWZlKKDgK8ht1x
         3r8vAQjbOnAxsJGa4iaHMfBkyUlQ5gye7n9EmPnTny9CjMPzp8hlI8X9yjIiIbz7QTZV
         dr8TU9csq9qk5TPtxI3yCwmQ0IBseOLxWCfQG3N9k1pFpX3ytE4JBSeRcshxiWLcilXW
         W59UXNyFTzhdGe69egs1Rl+cJ5Sl9J+vc3H/MfOWkOzkNIeZvoyjsJmIRs5A/S6n2o4Q
         89Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541846; x=1695146646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltbshIgUZ3GxU8tCibnnL+HEfHX0Nv7hadU45yI7Sy8=;
        b=vukebHd9rdCqudeT9gc6rDMbs+IgzNIrKY7Yj+0wwuq8H5l/wcFuo/STafEZGqj+BT
         emS1sjl+xF8RHLLLRJ/pQpr6q9JTkuZu/eKGvxEAwuqKFk3hztE26cTgr+BklKEtRwfR
         yELFDuLcAuk2VNzb21u1VY55pv0tJz1lwdV8oD7z1g7klibq18xYaPvoIYOCuRzeAEKY
         gItGQtrjkMPGZKQzcc5jLpEh4XRf4CQ6EIe/a8xZQgPPEhsmq7uNPsoK7zDlKfTrSd+A
         FvIyHlYBv/iZ/oGzs09gL7Wo8hq6SnxbVhb/aVidXUuMeMt6JhICdvE8CD+qW4g6swBv
         bNJQ==
X-Gm-Message-State: AOJu0YxKRnK/u/NY1Ja35iMjZYSrOnye4hmspR9tAhncJRx95LkhlrVe
	vTVMqOCzEtGO6PdkAy7NdQ4lZiBH53e3pPl6zBpGQg==
X-Google-Smtp-Source: AGHT+IGb+fQ/gZdCvO8VmcaaiEQ+JHL6qoD565g5pv5+ffjREd3+K57QjxJi607801DZ0kDkh4Hk01y//NOsAZO/L3Y=
X-Received: by 2002:ac8:4e43:0:b0:412:16f:c44f with SMTP id
 e3-20020ac84e43000000b00412016fc44fmr17569qtw.6.1694541845921; Tue, 12 Sep
 2023 11:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com> <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com> <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
 <8bc6c1cd-50bb-44ef-5979-3bb50a70afcb@intel.com>
In-Reply-To: <8bc6c1cd-50bb-44ef-5979-3bb50a70afcb@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 20:03:54 +0200
Message-ID: <CANn89iL6HVvRegORfP49prJV4EJU2-AbD4YXB-eo_vwU1JG1ew@mail.gmail.com>
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 7:44=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 12 Sep 2023 19:28:50 +0200
>
> > On Tue, Sep 12, 2023 at 7:16=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Tue, 12 Sep 2023 18:04:44 +0200
> >>
> >>> On Tue, Sep 12, 2023 at 5:58=E2=80=AFPM Alexander Lobakin
> >>> <aleksander.lobakin@intel.com> wrote:
> >>>>
> >>>> From: Eric Dumazet <edumazet@google.com>
> >>>> Date: Tue, 12 Sep 2023 06:23:24 +0200
> >>>>
> >>>>> On Mon, Sep 11, 2023 at 10:20=E2=80=AFAM Yajun Deng <yajun.deng@lin=
ux.dev> wrote:
> >>>>>>
> >>>>>> Although there is a kfree_skb_reason() helper function that can be=
 used
> >>>>>> to find the reason for dropped packets, but most callers didn't in=
crease
> >>>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropp=
ed.
> >>>>
> >>>> [...]
> >>>>
> >>>>>>  EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>>>>>
> >>>>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(st=
ruct net_device *dev)
> >>>>>> +static struct net_device_core_stats __percpu *netdev_core_stats_a=
lloc(struct net_device *dev)
> >>>>>>  {
> >>>>>>         struct net_device_core_stats __percpu *p;
> >>>>>>
> >>>>>> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *ne=
tdev_core_stats_alloc(struct net_device
> >>>>>>         /* This READ_ONCE() pairs with the cmpxchg() above */
> >>>>>>         return READ_ONCE(dev->core_stats);
> >>>>>>  }
> >>>>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >>>>>> +
> >>>>>> +static inline struct net_device_core_stats __percpu *dev_core_sta=
ts(struct net_device *dev)
> >>>>>
> >>>>> Please remove this inline attritbute. Consider using __cold instead=
.
> >>>>
> >>>> __cold? O_o I thought the author's inlining it as it's a couple
> >>>> locs/intstructions, while the compilers would most likely keep it
> >>>> non-inlined as it's referenced 4 times. __cold will for sure keep it
> >>>> standalone and place it in .text.cold, i.e. far away from the call s=
ites.
> >>>> I realize dev_core_stats_*() aren't called frequently, but why makin=
g
> >>>> only one small helper cold rather than all of them then?
> >>>>
> >>>
> >>> This helper is used at least one time per netdevice lifetime.
> >>> This is definitely cold.
> >>
> >> But then each dev_stats_*_inc() (not cold) has to call it from a
> >> completely different piece of .text far from their. I either don't
> >> understand the idea or dunno. Why not make them cold as well then?
> >>
> >
> > The __cold attribute is only applied to the helper _allocating_ the
> > memory, once.
>
> Then it should be applied to netdev_core_stats_alloc(), not
> dev_core_stats(). The latter only dereferences the already existing
> pointer or calls the former, which actually does the allocation.
> That's why I don't get why make one if/else non-inline or even cold.

Sure, this was what was suggested (perhaps not _very_ precisely, but
the general idea was pretty clear).
v2 seems ok, right ?

It seems we are all on the same page.

+static __cold struct net_device_core_stats __percpu
*dev_core_stats(struct net_device *dev)
+{
+       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc=
() */
+       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_st=
ats);
+
+       if (likely(p))
+               return p;
+
+       return netdev_core_stats_alloc(dev);
+}
+
+#define DEV_CORE_STATS_INC(FIELD)                              \
+void dev_core_stats_##FIELD##_inc(struct net_device *dev)      \
+{                                                              \
+       struct net_device_core_stats __percpu *p;               \
+                                                               \
+       p =3D dev_core_stats(dev);                                \
+       if (p)                                                  \
+               this_cpu_inc(p->FIELD);                         \
+}                                                              \
+EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)

