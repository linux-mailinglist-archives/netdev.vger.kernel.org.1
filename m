Return-Path: <netdev+bounces-36895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9E77B2197
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 3D3FAB20B07
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A04F140;
	Thu, 28 Sep 2023 15:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CD4F13F
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:44:48 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15758E5
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:44:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so16227a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695915883; x=1696520683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT/1Amukgs3JeGbxJIEjYG1p+SrMmDMHsig3NMgTn+k=;
        b=glPqnoh5+rErVQl0pVimRemNNOYpJVuT2FfVcp891EyPQg/NFTPOU+s/9rvZfXBada
         LK6+tbikVqimsvHFcDj5PuTGwyd42DMlP4gE/GpZKzKM+tHgQuNTju3pe4eCSyGvQudS
         jfa8w1YzIZIBL5Y3iDQlh5TQXeo+eHs7dk3Q5PUzCN6GFrU74Rxnldjl/XLchA0L3tes
         5WarNii/7fgxM+bplbfb/KYkp6h2WllXALjQCSttbTM2ssp8ixO6HPBNPyhX5SGqcwz+
         fcH1uBp3JGmz+ByfKbiFWGF4IPlZpaMGcG3JwVhdiUWuJfS8MKmu6wIMwqD2hq1xzu6Z
         zNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915883; x=1696520683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT/1Amukgs3JeGbxJIEjYG1p+SrMmDMHsig3NMgTn+k=;
        b=Z1/UqZFe52dvQAxpmqSxbpC5sHYujU8YNfN41MmCzbndgcQoagkkZNbbeaUTe9B8N5
         Tr7MOdT8mZAgGWPMSs5O0lmjQn5yyizTPt8DxjNIIN12ErgryRVe4xjlix+JXL9uJa6I
         kOMAwKab1JQal3IzGAUxd7VVJ97a7y0/uHqXhAbR2oDTim+amAv3VWIPLWgNGkNTIUq+
         Ldu+52alb7cEzapc+9bFbHD1DLhH1T0iSPeuGlSl4aV7MlqJ4ZCSaSke9G7TeYQCOElI
         1H6gFRk84jUPoVRocHuML03i+N9mgHEh5JY7StEmhxmKh8EgPbK8JDXzzL5a2u3yg+UF
         euzg==
X-Gm-Message-State: AOJu0Yzur1TDz6qmyA2vg6ukshyELfGcU3qsFJ+HbW1puViKPrrUgzdw
	OSMIDnoZqW7nMOUQsBFhdQmWXaOPcjOkwvLGEPMIC4nfXjSytmL2oO2mFA==
X-Google-Smtp-Source: AGHT+IEQ/+PQtN2SXQjBnQyt6NhuCGlbT5bM97sqPHsLFWkbuhpIh9m5iaLQBsAxLtNMsXL0fuJmh4gUlXJQQpBy6WM=
X-Received: by 2002:a50:d0d9:0:b0:530:4f4b:d9ee with SMTP id
 g25-20020a50d0d9000000b005304f4bd9eemr437436edf.5.1695915883155; Thu, 28 Sep
 2023 08:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928100418.521594-1-yajun.deng@linux.dev> <CANn89iL9uy58ZrZRPEtrvQ7ckv5hVTq8shx3OesQA6SWoUOP=g@mail.gmail.com>
 <c43a3dde-fa4d-4a87-6f96-397813db5bd6@linux.dev>
In-Reply-To: <c43a3dde-fa4d-4a87-6f96-397813db5bd6@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Sep 2023 17:44:29 +0200
Message-ID: <CANn89i+iT11qzCidTrHHRMQiYR-nXtbPNAUJGaEg0NQMCq_8CA@mail.gmail.com>
Subject: Re: [PATCH v6] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 5:40=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/9/28 22:18, Eric Dumazet wrote:
> > On Thu, Sep 28, 2023 at 12:04=E2=80=AFPM Yajun Deng <yajun.deng@linux.d=
ev> wrote:
> >> Although there is a kfree_skb_reason() helper function that can be use=
d to
> >> find the reason why this skb is dropped, but most callers didn't incre=
ase
> >> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> >>
> >> For the users, people are more concerned about why the dropped in ip
> >> is increasing.
> >>
> >> Introduce netdev_core_stats_inc() for trace the caller of the dropped
> >> skb. Also, add __code to netdev_core_stats_alloc(), as it's called
> >> unlinkly.
> >>
> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >> v6: merge netdev_core_stats and netdev_core_stats_inc together
> >> v5: Access the per cpu pointer before reach the relevant offset.
> >> v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats=
_*_inc()
> >> v3: __cold should be added to the netdev_core_stats_alloc().
> >> v2: use __cold instead of inline in dev_core_stats().
> >> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng=
@linux.dev/
> >> ---
> >>   include/linux/netdevice.h | 21 ++++-----------------
> >>   net/core/dev.c            | 17 +++++++++++++++--
> >>   2 files changed, 19 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >> index 7e520c14eb8c..eb1fa04fbccc 100644
> >> --- a/include/linux/netdevice.h
> >> +++ b/include/linux/netdevice.h
> >> @@ -4002,32 +4002,19 @@ static __always_inline bool __is_skb_forwardab=
le(const struct net_device *dev,
> >>          return false;
> >>   }
> >>
> >> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct=
 net_device *dev);
> >> -
> >> -static inline struct net_device_core_stats __percpu *dev_core_stats(s=
truct net_device *dev)
> >> -{
> >> -       /* This READ_ONCE() pairs with the write in netdev_core_stats_=
alloc() */
> >> -       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->co=
re_stats);
> >> -
> >> -       if (likely(p))
> >> -               return p;
> >> -
> >> -       return netdev_core_stats_alloc(dev);
> >> -}
> >> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
> >>
> >>   #define DEV_CORE_STATS_INC(FIELD)                                   =
           \
> >>   static inline void dev_core_stats_##FIELD##_inc(struct net_device *d=
ev)                \
> >>   {                                                                   =
           \
> >> -       struct net_device_core_stats __percpu *p;                     =
          \
> >> -                                                                     =
          \
> >> -       p =3D dev_core_stats(dev);                                    =
            \
> >> -       if (p)                                                        =
          \
> >> -               this_cpu_inc(p->FIELD);                               =
          \
> > Note that we were using this_cpu_inc() which implied :
> > - IRQ safety, and
> > - a barrier paired with :
> >
> > net/core/dev.c:10548:                   storage->rx_dropped +=3D
> > READ_ONCE(core_stats->rx_dropped);
> > net/core/dev.c:10549:                   storage->tx_dropped +=3D
> > READ_ONCE(core_stats->tx_dropped);
> > net/core/dev.c:10550:                   storage->rx_nohandler +=3D
> > READ_ONCE(core_stats->rx_nohandler);
> > net/core/dev.c:10551:                   storage->rx_otherhost_dropped
> > +=3D READ_ONCE(core_stats->rx_otherhost_dropped);
> >
> >
> >> +       netdev_core_stats_inc(dev,                                    =
          \
> >> +                       offsetof(struct net_device_core_stats, FIELD))=
;         \
> >>   }
> >>   DEV_CORE_STATS_INC(rx_dropped)
> >>   DEV_CORE_STATS_INC(tx_dropped)
> >>   DEV_CORE_STATS_INC(rx_nohandler)
> >>   DEV_CORE_STATS_INC(rx_otherhost_dropped)
> >> +#undef DEV_CORE_STATS_INC
> >>
> >>   static __always_inline int ____dev_forward_skb(struct net_device *de=
v,
> >>                                                 struct sk_buff *skb,
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index 606a366cc209..88a32c392c1d 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link_=
stats64 *stats64,
> >>   }
> >>   EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>
> >> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct=
 net_device *dev)
> >> +static __cold struct net_device_core_stats __percpu *netdev_core_stat=
s_alloc(
> >> +               struct net_device *dev)
> >>   {
> >>          struct net_device_core_stats __percpu *p;
> >>
> >> @@ -10510,7 +10511,19 @@ struct net_device_core_stats __percpu *netdev=
_core_stats_alloc(struct net_device
> >>          /* This READ_ONCE() pairs with the cmpxchg() above */
> >>          return READ_ONCE(dev->core_stats);
> >>   }
> >> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >> +
> >> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >> +{
> >> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_=
alloc() */
> >> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->co=
re_stats);
> >> +
> >> +       if (unlikely(!p))
> >> +               p =3D netdev_core_stats_alloc(dev);
> >> +
> >> +       if (p)
> >> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))=
++;
> > While here you are using a ++ operation that :
> >
> > - is not irq safe
> > - might cause store-tearing.
> >
> > I would suggest a preliminary patch converting the "unsigned long" fiel=
ds in
> > struct net_device_core_stats to local_t
>
> Do you mean it needs to revert the commit 6510ea973d8d ("net: Use
> this_cpu_inc() to increment
>
> net->core_stats") first? But it would allocate memory which breaks on
> PREEMPT_RT.

I think I provided an (untested) alternative.

unsigned long __percpu *field =3D (__force unsigned long __percpu *)
((__force u8 *)p + offset);
this_cpu_inc(field);


>
> >
> > You might be able tweak this to
> >
> > unsigned long __percpu *field =3D (unsigned long __percpu) ((u8 *)p + o=
ffset);
> > this_cpu_inc(field);

