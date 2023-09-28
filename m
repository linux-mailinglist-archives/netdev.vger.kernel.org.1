Return-Path: <netdev+bounces-36901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C797B222D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 00B47281266
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B651227;
	Thu, 28 Sep 2023 16:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654264E298
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:23:26 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624AD6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 09:23:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so21939a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695918202; x=1696523002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoK7DrnkbZoEIlYmoBBEvLuBCh+s4Y05tdAexrGncuU=;
        b=oP8tWTNcPnRfRpkBzt1652ESSkvNJRz+wQdzgf34Dck6WUPoqMN+FAg3xAYmuHZgGv
         +8zy0V0TQiOp8kLzfk2+MGMIjnYUeDfm5ag9MSrG2in6ye+org/O/oUMolb9at2wZK/w
         /A2J4skXgpYpCiDdQbJEj5+bXpsQp3C69RdnE/2F5+o44iA+en1EYO26X5tdTYASCveD
         yJ3gs8P55VtHylKARuKbG/nWosuxnnx8BmNLjnwI4HLv2pwYjkDabWaERGiQCfpWbR/p
         ueZxvT4+N3ZXIeNVyWaUcOdyi+c95JgwPzmJfxhJd6JRXSyV1iYoRQrHXcap5rU+g4p2
         iyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918202; x=1696523002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoK7DrnkbZoEIlYmoBBEvLuBCh+s4Y05tdAexrGncuU=;
        b=YSs9TDr9I9R9izVdWKtBu8tqnX2p1f9Dxs1VKTvdCMdVLhxWkPCzNKYn6OCQOACO43
         aGk4C0B+48u1c0C4pq0MlbPCaZfZQHmNWKTPQ9XOLNJf1DDOkYbNEZkGjIGqEC30PHuj
         Nvh1+AsQfUzQLNwtZF2/TJp/+eVbDEo4uDG5hxSKpiuOs+x+xgO0jKhXk28mIAG36GH3
         sD9y8q+TDxzbWtZWCAsvCdAvkPJQKEn73K5XT/y7UyvgSzV4XZjUF3Z1bA5Ms2B3o+n1
         SYTs38VG2z89is1lrfIywUbLBaHAgyTlUQ6FCpwosX2KFwpv14JsdUllya5j7RHFaC0n
         9Zyg==
X-Gm-Message-State: AOJu0Yyn32FYP0erBEGa8pfrlkIXVw3u+YMoGjdt6Y1ps3U2QI9Xwpok
	GGPE72WcHcb7sGvU2qChPlIKEz8qBGrU8Q9LW7YONA==
X-Google-Smtp-Source: AGHT+IEumrZROsYRljFMvmWsDaEhoXqgx+m159N959ENHjD39+fOqU50QyiAKiyxyjglBFOuLthC1CdYkxePel+rzzs=
X-Received: by 2002:a50:aa93:0:b0:52e:f99a:b5f8 with SMTP id
 q19-20020a50aa93000000b0052ef99ab5f8mr418659edc.7.1695918202280; Thu, 28 Sep
 2023 09:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928100418.521594-1-yajun.deng@linux.dev> <CANn89iL9uy58ZrZRPEtrvQ7ckv5hVTq8shx3OesQA6SWoUOP=g@mail.gmail.com>
 <c43a3dde-fa4d-4a87-6f96-397813db5bd6@linux.dev> <CANn89i+iT11qzCidTrHHRMQiYR-nXtbPNAUJGaEg0NQMCq_8CA@mail.gmail.com>
 <5d8e302c-a28d-d4f4-eb91-4b54eb89490b@linux.dev>
In-Reply-To: <5d8e302c-a28d-d4f4-eb91-4b54eb89490b@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Sep 2023 18:23:11 +0200
Message-ID: <CANn89i+XQ_LKvr5LHd2QUgTMfZh9Nd1yQTYfRORHUt2_BCkxcg@mail.gmail.com>
Subject: Re: [PATCH v6] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 6:16=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/9/28 23:44, Eric Dumazet wrote:
> > On Thu, Sep 28, 2023 at 5:40=E2=80=AFPM Yajun Deng <yajun.deng@linux.de=
v> wrote:
> >>
> >> On 2023/9/28 22:18, Eric Dumazet wrote:
> >>> On Thu, Sep 28, 2023 at 12:04=E2=80=AFPM Yajun Deng <yajun.deng@linux=
.dev> wrote:
> >>>> Although there is a kfree_skb_reason() helper function that can be u=
sed to
> >>>> find the reason why this skb is dropped, but most callers didn't inc=
rease
> >>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped=
.
> >>>>
> >>>> For the users, people are more concerned about why the dropped in ip
> >>>> is increasing.
> >>>>
> >>>> Introduce netdev_core_stats_inc() for trace the caller of the droppe=
d
> >>>> skb. Also, add __code to netdev_core_stats_alloc(), as it's called
> >>>> unlinkly.
> >>>>
> >>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >>>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>> ---
> >>>> v6: merge netdev_core_stats and netdev_core_stats_inc together
> >>>> v5: Access the per cpu pointer before reach the relevant offset.
> >>>> v4: Introduce netdev_core_stats_inc() instead of export dev_core_sta=
ts_*_inc()
> >>>> v3: __cold should be added to the netdev_core_stats_alloc().
> >>>> v2: use __cold instead of inline in dev_core_stats().
> >>>> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.de=
ng@linux.dev/
> >>>> ---
> >>>>    include/linux/netdevice.h | 21 ++++-----------------
> >>>>    net/core/dev.c            | 17 +++++++++++++++--
> >>>>    2 files changed, 19 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>>> index 7e520c14eb8c..eb1fa04fbccc 100644
> >>>> --- a/include/linux/netdevice.h
> >>>> +++ b/include/linux/netdevice.h
> >>>> @@ -4002,32 +4002,19 @@ static __always_inline bool __is_skb_forward=
able(const struct net_device *dev,
> >>>>           return false;
> >>>>    }
> >>>>
> >>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(stru=
ct net_device *dev);
> >>>> -
> >>>> -static inline struct net_device_core_stats __percpu *dev_core_stats=
(struct net_device *dev)
> >>>> -{
> >>>> -       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> -       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> -
> >>>> -       if (likely(p))
> >>>> -               return p;
> >>>> -
> >>>> -       return netdev_core_stats_alloc(dev);
> >>>> -}
> >>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
> >>>>
> >>>>    #define DEV_CORE_STATS_INC(FIELD)                                =
              \
> >>>>    static inline void dev_core_stats_##FIELD##_inc(struct net_device=
 *dev)                \
> >>>>    {                                                                =
              \
> >>>> -       struct net_device_core_stats __percpu *p;                   =
            \
> >>>> -                                                                   =
            \
> >>>> -       p =3D dev_core_stats(dev);                                  =
              \
> >>>> -       if (p)                                                      =
            \
> >>>> -               this_cpu_inc(p->FIELD);                             =
            \
> >>> Note that we were using this_cpu_inc() which implied :
> >>> - IRQ safety, and
> >>> - a barrier paired with :
> >>>
> >>> net/core/dev.c:10548:                   storage->rx_dropped +=3D
> >>> READ_ONCE(core_stats->rx_dropped);
> >>> net/core/dev.c:10549:                   storage->tx_dropped +=3D
> >>> READ_ONCE(core_stats->tx_dropped);
> >>> net/core/dev.c:10550:                   storage->rx_nohandler +=3D
> >>> READ_ONCE(core_stats->rx_nohandler);
> >>> net/core/dev.c:10551:                   storage->rx_otherhost_dropped
> >>> +=3D READ_ONCE(core_stats->rx_otherhost_dropped);
> >>>
> >>>
> >>>> +       netdev_core_stats_inc(dev,                                  =
            \
> >>>> +                       offsetof(struct net_device_core_stats, FIELD=
));         \
> >>>>    }
> >>>>    DEV_CORE_STATS_INC(rx_dropped)
> >>>>    DEV_CORE_STATS_INC(tx_dropped)
> >>>>    DEV_CORE_STATS_INC(rx_nohandler)
> >>>>    DEV_CORE_STATS_INC(rx_otherhost_dropped)
> >>>> +#undef DEV_CORE_STATS_INC
> >>>>
> >>>>    static __always_inline int ____dev_forward_skb(struct net_device =
*dev,
> >>>>                                                  struct sk_buff *skb=
,
> >>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>> index 606a366cc209..88a32c392c1d 100644
> >>>> --- a/net/core/dev.c
> >>>> +++ b/net/core/dev.c
> >>>> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_lin=
k_stats64 *stats64,
> >>>>    }
> >>>>    EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>>>
> >>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(stru=
ct net_device *dev)
> >>>> +static __cold struct net_device_core_stats __percpu *netdev_core_st=
ats_alloc(
> >>>> +               struct net_device *dev)
> >>>>    {
> >>>>           struct net_device_core_stats __percpu *p;
> >>>>
> >>>> @@ -10510,7 +10511,19 @@ struct net_device_core_stats __percpu *netd=
ev_core_stats_alloc(struct net_device
> >>>>           /* This READ_ONCE() pairs with the cmpxchg() above */
> >>>>           return READ_ONCE(dev->core_stats);
> >>>>    }
> >>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >>>> +
> >>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >>>> +{
> >>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> +
> >>>> +       if (unlikely(!p))
> >>>> +               p =3D netdev_core_stats_alloc(dev);
> >>>> +
> >>>> +       if (p)
> >>>> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset=
))++;
> >>> While here you are using a ++ operation that :
> >>>
> >>> - is not irq safe
> >>> - might cause store-tearing.
> >>>
> >>> I would suggest a preliminary patch converting the "unsigned long" fi=
elds in
> >>> struct net_device_core_stats to local_t
> >> Do you mean it needs to revert the commit 6510ea973d8d ("net: Use
> >> this_cpu_inc() to increment
> >>
> >> net->core_stats") first? But it would allocate memory which breaks on
> >> PREEMPT_RT.
> > I think I provided an (untested) alternative.
> >
> > unsigned long __percpu *field =3D (__force unsigned long __percpu *)
> > ((__force u8 *)p + offset);
> > this_cpu_inc(field);
>
> unsigned long __percpu *field =3D (__force unsigned long __percpu *)
> ((__force u8 *)p + offset);
> this_cpu_inc(*(int *)field);
>
> This would compiler success. But I didn't test it.
> This cold look complex.

Why exactly ? Not very different from the cast you already had.

> Shoud I base v3? Export dev_core_stats_*_inc() intead of introduce netdev=
_core_stats_inc().
> That would be easy.

Well, you tell me, but this does not look incremental to me.

I do not think we need 4 different (and maybe more to come if struct
net_device_core_stats
grows in the future) functions for some hardly used path.

