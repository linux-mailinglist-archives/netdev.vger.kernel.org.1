Return-Path: <netdev+bounces-34908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1307A5D77
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893D6282062
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218753D3B3;
	Tue, 19 Sep 2023 09:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8E30F9B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:11:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64ABDA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695114660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcHdjnvsZl7BjaN6uuW5yFHe3gIRLmoYmXk7ZuAeIGM=;
	b=RnzKCM2YL3ZS4oZhBFoH3UVINE81ijyBwo/QS0swZX76CeqisvGw3otmHyd/tGvVIFkmo5
	d9Y7ubO24LI4QIPyBobDw+rAeV7yWT3yZDAbc8mBiiU/uz/dLS76HZOYfxBrX2gpo1Iz9I
	tslApAX15ffog/QlDVMkuwzsZOnDUMI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-7jQWe7HJMbWDbNPTrFwl_g-1; Tue, 19 Sep 2023 05:10:59 -0400
X-MC-Unique: 7jQWe7HJMbWDbNPTrFwl_g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bff38e49a5so3697811fa.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114658; x=1695719458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcHdjnvsZl7BjaN6uuW5yFHe3gIRLmoYmXk7ZuAeIGM=;
        b=D7AvuFldKvsWZ6A9uA8OE0GBCDrNj0+dtywHwFMO9H2VJsT9FfVy59OSzgx18mYewH
         xCWoGwWRf3tsjEFRjDSHiPIJoVLE/MX9RJpX5RTcHjpUUK9NzbmUTj9IUZKqc7dz1Dly
         MOyh0LZE0ZU1dwMnAps3AxXABuW07uL/8h+BLEJ/ZLFhuUbFTR043jNaAfTVVKfRnP3D
         6ebFwfuPMVq2/hch7kRo0cS4DFT660RQ74pbYjYwNU0NjO/4JTHB1nmx0H+Us1jeq2zS
         DtKGW8butfMMHVloxHQrCeN8JHeRJI1u7frx+ekwmXuB4l4l9IGuEYMQViUWcEK3DW9l
         qqIw==
X-Gm-Message-State: AOJu0Yx4cv+mlbEEtvXB/eq4ksbzmh0O+1gSHM3MJeMjnEw8B3J+Kpo3
	BvdKcdctaE27pJnvwxre+q6jXTT+o/BUAfdYj9s6Gus9pvFtK0NA84Hnd9nOrWYjTPRLrlZ8GFL
	dWYTkWh1yjrJprF6n
X-Received: by 2002:a2e:9cc1:0:b0:2b6:cd7f:5ea8 with SMTP id g1-20020a2e9cc1000000b002b6cd7f5ea8mr8870055ljj.1.1695114658062;
        Tue, 19 Sep 2023 02:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzNCtHxx1G8D5dQquuh1yRTdbin+4OnUI2A5JfldJjIBc1M1fbe4bXylu2CK7kCzoyts753Q==
X-Received: by 2002:a2e:9cc1:0:b0:2b6:cd7f:5ea8 with SMTP id g1-20020a2e9cc1000000b002b6cd7f5ea8mr8870037ljj.1.1695114657663;
        Tue, 19 Sep 2023 02:10:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906394500b0099bc038eb2bsm7488645eje.58.2023.09.19.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:10:57 -0700 (PDT)
Message-ID: <37c2c3163c053138da40be6713914c8bb103dada.camel@redhat.com>
Subject: Re: [PATCH net-next v4] net/core: Introduce netdev_core_stats_inc()
 for trace
From: Paolo Abeni <pabeni@redhat.com>
To: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Date: Tue, 19 Sep 2023 11:10:56 +0200
In-Reply-To: <20230918024055.221900-1-yajun.deng@linux.dev>
References: <20230918024055.221900-1-yajun.deng@linux.dev>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 10:40 +0800, Yajun Deng wrote:
> Although there is a kfree_skb_reason() helper function that can be used t=
o
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>=20
> For the users, people are more concerned about why the dropped in ip
> is increasing.
>=20
> Introduce netdev_core_stats_inc() for trace. Also, move dev_core_stats()
> and netdev_core_stats_alloc() to dev.c, as they are not called externally=
.
>=20
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_=
inc()
> v3: __cold should be added to the netdev_core_stats_alloc().
> v2: use __cold instead of inline in dev_core_stats().
> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@li=
nux.dev/
> ---
>  include/linux/netdevice.h | 21 ++++-----------------
>  net/core/dev.c            | 26 ++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0896aaa91dd7..cddd4873b5b0 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3980,32 +3980,19 @@ static __always_inline bool __is_skb_forwardable(=
const struct net_device *dev,
>  	return false;
>  }
> =20
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev);
> -
> -static inline struct net_device_core_stats __percpu *dev_core_stats(stru=
ct net_device *dev)
> -{
> -	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() *=
/
> -	struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_stats)=
;
> -
> -	if (likely(p))
> -		return p;
> -
> -	return netdev_core_stats_alloc(dev);
> -}
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
> =20
>  #define DEV_CORE_STATS_INC(FIELD)						\
>  static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)	=
	\
>  {										\
> -	struct net_device_core_stats __percpu *p;				\
> -										\
> -	p =3D dev_core_stats(dev);						\
> -	if (p)									\
> -		this_cpu_inc(p->FIELD);						\
> +	netdev_core_stats_inc(dev,						\
> +			offsetof(struct net_device_core_stats, FIELD));		\
>  }
>  DEV_CORE_STATS_INC(rx_dropped)
>  DEV_CORE_STATS_INC(tx_dropped)
>  DEV_CORE_STATS_INC(rx_nohandler)
>  DEV_CORE_STATS_INC(rx_otherhost_dropped)
> +#undef DEV_CORE_STATS_INC
> =20
>  static __always_inline int ____dev_forward_skb(struct net_device *dev,
>  					       struct sk_buff *skb,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..f4cccdf05450 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10475,7 +10475,8 @@ void netdev_stats_to_stats64(struct rtnl_link_sta=
ts64 *stats64,
>  }
>  EXPORT_SYMBOL(netdev_stats_to_stats64);
> =20
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev)
> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_a=
lloc(
> +		struct net_device *dev)
>  {
>  	struct net_device_core_stats __percpu *p;
> =20
> @@ -10488,7 +10489,28 @@ struct net_device_core_stats __percpu *netdev_co=
re_stats_alloc(struct net_device
>  	/* This READ_ONCE() pairs with the cmpxchg() above */
>  	return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *netdev_core_stats(
> +		struct net_device *dev)
> +{
> +	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() *=
/
> +	struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_stats)=
;
> +
> +	if (likely(p))
> +		return p;
> +
> +	return netdev_core_stats_alloc(dev);
> +}
> +
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> +{
> +	struct net_device_core_stats __percpu *p;
> +
> +	p =3D netdev_core_stats(dev);
> +	if (p)
> +		this_cpu_inc(*(unsigned long *)((void *)p + offset));

The above is causing a lot of compile warning, as it's discarding the
(required) __percpu annotation.

You need to first access the per cpu pointer and then reach for the
relevant offset.

Cheers,

Paolo


