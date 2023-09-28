Return-Path: <netdev+bounces-36725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF27B17CA
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 183C91C208D8
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED48341BC;
	Thu, 28 Sep 2023 09:44:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B92E65C
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 09:44:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111C95
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695894289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4qFAYktYwodKXXfHdIdje+EzgutGOGN/kJNF5mkJkk=;
	b=IoPosRM9bIM4De4cUJffAFvzYMpb4dgmHRaG0Z2SBu4l8URNfR98o5yklgpPzQRYdm1Mhc
	fFR4yj3sRnyDsOyNUmHFfwacW/eetxEEwMo7VAdPyCvQzmxotJ+EsfMLIjzNBTYLNIEqU7
	mvK2SHMFRWp6VePyp2xO5KYMZIhvnj4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-vHcQzgslMkiJCUs56hHKTg-1; Thu, 28 Sep 2023 05:44:46 -0400
X-MC-Unique: vHcQzgslMkiJCUs56hHKTg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b295d163fdso139276766b.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 02:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695894285; x=1696499085;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4qFAYktYwodKXXfHdIdje+EzgutGOGN/kJNF5mkJkk=;
        b=Xwe2UQoN52xCsYRLYrRsN4hUVy+NccPXBT2L3SS9yOiAokpDtt+JKW7CtxX3QD7jrh
         BiWXX9L2qw3zbYE+9j91qOLGp9os+rEIf7qln/vXXO9pQBMi2GPaiwiRz6X7UW1J/Umi
         qChfE89cZlDPUiDQzLNE1wWWlZ1ptNjHQk5V8Qzgz6qodSVGptbogvBnU1ZH1dZ/kNWS
         dpH3/edqIkJT2ISKLMMKyPwZ11QwMKh7e+hNVE0wrajfgj8eUhgmQdh8Ujeu4M3GAw6Z
         ZbnvBrEajLXKfFuNc/3fctkVnXkg7Hj1QC27qrUUMh5wCdwrFD7Ipn/DBYM+UuPrOI5A
         btlQ==
X-Gm-Message-State: AOJu0Yz83U0zBkf5gZ5KIJCcRoDfQ/2DlZTKzr+6X07r0LHh1l6lUoD0
	qjj5l8iWkdIilCg5Q/ZQuypHTWC07xi/FwEhRwfi8yRgqTkGEVSSZvY4MpPRrAyg+Muq4QPyhPC
	sPHGfBuCkj8zBPFyS
X-Received: by 2002:a17:906:2ce:b0:9ae:3f76:1091 with SMTP id 14-20020a17090602ce00b009ae3f761091mr695212ejk.0.1695894284898;
        Thu, 28 Sep 2023 02:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbApYTTQgN2yo6x+QgbNtQCe5xd+ezE79cLx/XOMa6MpMXXruWp6SxngWsn3vHSJmsAUUDCw==
X-Received: by 2002:a17:906:2ce:b0:9ae:3f76:1091 with SMTP id 14-20020a17090602ce00b009ae3f761091mr695198ejk.0.1695894284456;
        Thu, 28 Sep 2023 02:44:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906704b00b00999bb1e01dfsm10587736ejj.52.2023.09.28.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:44:44 -0700 (PDT)
Message-ID: <af4e7e18e5df1a5e4bd35d1e156e96aebc515611.camel@redhat.com>
Subject: Re: [PATCH net-next v5] net/core: Introduce netdev_core_stats_inc()
 for trace
From: Paolo Abeni <pabeni@redhat.com>
To: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Date: Thu, 28 Sep 2023 11:44:42 +0200
In-Reply-To: <c4d8c8bf-974c-b4fe-f363-f4cd98545556@linux.dev>
References: <20230919135517.286766-1-yajun.deng@linux.dev>
	 <619e3735d99c8642b7b84a151515c2fee99ff694.camel@redhat.com>
	 <c4d8c8bf-974c-b4fe-f363-f4cd98545556@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-28 at 17:21 +0800, Yajun Deng wrote:
> On 2023/9/28 16:23, Paolo Abeni wrote:
> > On Tue, 2023-09-19 at 21:55 +0800, Yajun Deng wrote:
> > > Although there is a kfree_skb_reason() helper function that can be us=
ed to
> > > find the reason why this skb is dropped, but most callers didn't incr=
ease
> > > one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> > >=20
> > > For the users, people are more concerned about why the dropped in ip
> > > is increasing.
> > >=20
> > > Introduce netdev_core_stats_inc() for trace. Also, move dev_core_stat=
s()
> > > and netdev_core_stats_alloc() to dev.c, as they are not called extern=
ally.
> > >=20
> > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > ---
> > > v5: Access the per cpu pointer before reach the relevant offset.
> > > v4: Introduce netdev_core_stats_inc() instead of export dev_core_stat=
s_*_inc()
> > > v3: __cold should be added to the netdev_core_stats_alloc().
> > > v2: use __cold instead of inline in dev_core_stats().
> > > v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.den=
g@linux.dev/
> > > ---
> > >   include/linux/netdevice.h | 21 ++++-----------------
> > >   net/core/dev.c            | 26 ++++++++++++++++++++++++--
> > >   2 files changed, 28 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index db3d8429d50d..4c258d44c7d2 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -4001,32 +4001,19 @@ static __always_inline bool __is_skb_forwarda=
ble(const struct net_device *dev,
> > >   	return false;
> > >   }
> > >  =20
> > > -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struc=
t net_device *dev);
> > > -
> > > -static inline struct net_device_core_stats __percpu *dev_core_stats(=
struct net_device *dev)
> > > -{
> > > -	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc=
() */
> > > -	struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_st=
ats);
> > > -
> > > -	if (likely(p))
> > > -		return p;
> > > -
> > > -	return netdev_core_stats_alloc(dev);
> > > -}
> > > +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
> > >  =20
> > >   #define DEV_CORE_STATS_INC(FIELD)						\
> > >   static inline void dev_core_stats_##FIELD##_inc(struct net_device *=
dev)		\
> > >   {										\
> > > -	struct net_device_core_stats __percpu *p;				\
> > > -										\
> > > -	p =3D dev_core_stats(dev);						\
> > > -	if (p)									\
> > > -		this_cpu_inc(p->FIELD);						\
> > > +	netdev_core_stats_inc(dev,						\
> > > +			offsetof(struct net_device_core_stats, FIELD));		\
> > >   }
> > >   DEV_CORE_STATS_INC(rx_dropped)
> > >   DEV_CORE_STATS_INC(tx_dropped)
> > >   DEV_CORE_STATS_INC(rx_nohandler)
> > >   DEV_CORE_STATS_INC(rx_otherhost_dropped)
> > > +#undef DEV_CORE_STATS_INC
> > >  =20
> > >   static __always_inline int ____dev_forward_skb(struct net_device *d=
ev,
> > >   					       struct sk_buff *skb,
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 606a366cc209..4bc0161bc0d6 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link=
_stats64 *stats64,
> > >   }
> > >   EXPORT_SYMBOL(netdev_stats_to_stats64);
> > >  =20
> > > -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struc=
t net_device *dev)
> > > +static __cold struct net_device_core_stats __percpu *netdev_core_sta=
ts_alloc(
> > > +		struct net_device *dev)
> > >   {
> > >   	struct net_device_core_stats __percpu *p;
> > >  =20
> > > @@ -10510,7 +10511,28 @@ struct net_device_core_stats __percpu *netde=
v_core_stats_alloc(struct net_device
> > >   	/* This READ_ONCE() pairs with the cmpxchg() above */
> > >   	return READ_ONCE(dev->core_stats);
> > >   }
> > > -EXPORT_SYMBOL(netdev_core_stats_alloc);
> > > +
> > > +static inline struct net_device_core_stats __percpu *netdev_core_sta=
ts(
> > > +		struct net_device *dev)
> > I'm sorry for the delayed feedback - conference and traveling in the
> > way.
> >=20
> > It looks like the 'inline' keyword above is a left-over of a previous
> > revision? The compiler should generate the same code even without it,
> > right? If so, it should be better drop it.
>=20
>=20
> If so, should I merge netdev_core_stats and netdev_core_stats_inc=20
> together, as it didn't called by others. Like:
>=20
> void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This READ_ONCE() pairs wit=
h the write in=20
> netdev_core_stats_alloc() */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct net_device_core_stats =
__percpu *p =3D=20
> READ_ONCE(dev->core_stats);
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(!p))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 p =3D netdev_core_stats_alloc(dev);
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++=
;
> }
> EXPORT_SYMBOL_GPL(netdev_core_stats_inc);

Makes sense to me. I initially thought the code would be more readable
with 2 separate functions, but the above LGTM.

Cheers,

Paolo


