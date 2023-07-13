Return-Path: <netdev+bounces-17477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EB751C08
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACED1C212E9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0608C14;
	Thu, 13 Jul 2023 08:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D98839
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:44:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B02101
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689237855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR7Iv9w+XHBj08BP3jRidlSyx8eIsHtx4pnPO3UYAbg=;
	b=Yg8BttrKUzA/J9xuERKf0nccuNW7I2cOWiqwtAFgRDTRGCHUggSOoo3xHwvf6jNBdLrGB6
	iAPjxuL1DMtf9XQeAAr3oZ9uk/bs9ZlfNbXI3xCyyb7qdBBlB+2tzE+bxHNKRw1dBB2VZP
	fkYAmBq2Vi581gq4VuqLR030ZZJFK6k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-cBNQTXrlM3Kt9USaGnhzTA-1; Thu, 13 Jul 2023 04:44:14 -0400
X-MC-Unique: cBNQTXrlM3Kt9USaGnhzTA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4034b144d3bso1509291cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237853; x=1689842653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rR7Iv9w+XHBj08BP3jRidlSyx8eIsHtx4pnPO3UYAbg=;
        b=Lm0A4J2NzPi+ZvCBPrGJ9eFtxSz3tZwPIq/wOTor44KHzv+4PhASsgKEhVMMH0z4xr
         ZKkHYElGaICKPnIiYzrlAhcSy8Ri4CsYk6qJe3yhddgYTy+s+qOjZuZo1EPVEQ9EGQTc
         q8JqRS15Arbkxnc8e9uUyasGS2tYSQJI8JKeQUaN2CdLHbhp1APmB1KspsX1QAZyqWHO
         po9mzExIAMX5S6ZFBmjBwSf8tn6w6TZ5ksuQTCJpOR2RO6Rwa0sb94oVvjf7PaNNoXwr
         VHR5njK3PoAOGtIac8roAh6QmpwdkjvPH0ibOXfpQZoFg8MjQsWg1GB5yUz53pXZ+PBh
         y5Cg==
X-Gm-Message-State: ABy/qLZQ9hVLiGkjTw3eWF4MtNaJQbJLrFE+CwW0FiA8czUn9f9fe84/
	k0tOmB/GiEK/+D5A65wLnZWd2qJ4QMFLOBz0tHk0/cbUTacoRmKVi0Y3EOqQ8RoC+/LwLTEivnF
	8kj5c3pi5dqlhqslY
X-Received: by 2002:a05:622a:1990:b0:400:aa1a:bb4c with SMTP id u16-20020a05622a199000b00400aa1abb4cmr1308875qtc.3.1689237853680;
        Thu, 13 Jul 2023 01:44:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8TJAsr29yMqQMjwRnQEyiUvd8lgShe4ZmGN8Uh7I/0BM+IlrGANT3Q/ihOr4BJrsWdN27SA==
X-Received: by 2002:a05:622a:1990:b0:400:aa1a:bb4c with SMTP id u16-20020a05622a199000b00400aa1abb4cmr1308862qtc.3.1689237853408;
        Thu, 13 Jul 2023 01:44:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id a21-20020aed2795000000b004039e9199cesm2910488qtd.60.2023.07.13.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:44:13 -0700 (PDT)
Message-ID: <bb9e2a2685447a704e0fd94c078519f3ce587805.camel@redhat.com>
Subject: Re: [PATCH net] net/ipv6: Remove expired routes with a separated
 list of routes.
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, dsahern@kernel.org, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  martin.lau@linux.dev, kernel-team@meta.com,
 yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Date: Thu, 13 Jul 2023 10:44:09 +0200
In-Reply-To: <20230710203609.520720-1-kuifeng@meta.com>
References: <20230710203609.520720-1-kuifeng@meta.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, 2023-07-10 at 13:36 -0700, Kui-Feng Lee wrote:
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tr=
ee
> can be expensive if the number of routes in a table is big, even if most =
of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The size of a Linux IPv6 routing table can become a big problem if not
> managed appropriately.  Now, Linux has a garbage collector to remove
> expired routes periodically.  However, this may lead to a situation in
> which the routing path is blocked for a long period due to an
> excessive number of routes.
>=20
> For example, years ago, there is a commit about "ICMPv6 Packet too big
> messages". The root cause is that malicious ICMPv6 packets were sent back

Please use the customary commit reference: <hash> ("<title>")

> for every small packet sent to them. These packets add routes with an
> expiration time that prompts the GC to periodically check all routes in t=
he
> tables, including permanent ones.
>=20
> Why Route Expires
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Users can add IPv6 routes with an expiration time manually. However,
> the Neighbor Discovery protocol may also generate routes that can
> expire.  For example, Router Advertisement (RA) messages may create a
> default route with an expiration time. [RFC 4861] For IPv4, it is not
> possible to set an expiration time for a route, and there is no RA, so
> there is no need to worry about such issues.
>=20
> Create Routes with Expires
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> You can create routes with expires with the  command.
>=20
> For example,
>=20
>     ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \
>         dev enp0s3 expires 30
>=20
> The route that has been generated will be deleted automatically in 30
> seconds.
>=20
> GC of FIB6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The function called fib6_run_gc() is responsible for performing
> garbage collection (GC) for the Linux IPv6 stack. It checks for the
> expiration of every route by traversing the trees of routing
> tables. The time taken to traverse a routing table increases with its
> size. Holding the routing table lock during traversal is particularly
> undesirable. Therefore, it is preferable to keep the lock for the
> shortest possible duration.
>=20
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The cause of the issue is keeping the routing table locked during the
> traversal of large trees. To solve this problem, we can create a separate
> list of routes that have expiration. This will prevent GC from checking
> permanent routes.
>=20
> Result
> =3D=3D=3D=3D=3D=3D
>=20
> We conducted a test to measure the execution times of fib6_gc_timer_cb()
> and observed that it enhances the GC of FIB6. During the test, we added
> permanent routes with the following numbers: 1000, 3000, 6000, and
> 9000. Additionally, we added a route with an expiration time.
>=20
> Here are the average execution times for the kernel without the patch.
>  - 120020 ns with 1000 permanent routes
>  - 308920 ns with 3000 ...
>  - 581470 ns with 6000 ...
>  - 855310 ns with 9000 ...
>=20
> The kernel with the patch consistently takes around 14000 ns to execute,
> regardless of the number of permanent routes that are installed.
>=20
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  include/net/ip6_fib.h |  31 ++++++++-----
>  net/ipv6/ip6_fib.c    | 104 ++++++++++++++++++++++++++++++++++++++++--
>  net/ipv6/route.c      |   6 +--
>  3 files changed, 123 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 05e6f756feaf..fb4d8bf4b938 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -177,6 +177,8 @@ struct fib6_info {
>  	};
>  	unsigned int			fib6_nsiblings;
> =20
> +	struct hlist_node		gc_link;
> +

It looks like placing the new field here will create 2 4bytes holes, I
think it should be better moving it after 'fib6_ref'

>  	refcount_t			fib6_ref;
>  	unsigned long			expires;
>  	struct dst_metrics		*fib6_metrics;
> @@ -247,18 +249,19 @@ static inline bool fib6_requires_src(const struct f=
ib6_info *rt)
>  	return rt->fib6_src.plen > 0;
>  }
> =20
> -static inline void fib6_clean_expires(struct fib6_info *f6i)
> -{
> -	f6i->fib6_flags &=3D ~RTF_EXPIRES;
> -	f6i->expires =3D 0;
> -}
> +void fib6_clean_expires(struct fib6_info *f6i);
> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can=
 be
> + * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into =
the
> + * list of GC candidates until it is inserted into a table.
> + */

This comment should be probably paired with  'fib6_set_expires'
instead.

> +void fib6_clean_expires_locked(struct fib6_info *f6i);
> =20
> -static inline void fib6_set_expires(struct fib6_info *f6i,
> -				    unsigned long expires)
> -{
> -	f6i->expires =3D expires;
> -	f6i->fib6_flags |=3D RTF_EXPIRES;
> -}
> +void fib6_set_expires(struct fib6_info *f6i, unsigned long expires);
> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can=
 be
> + * NULL.
> + */
> +void fib6_set_expires_locked(struct fib6_info *f6i,
> +			     unsigned long expires);
> =20
>  static inline bool fib6_check_expired(const struct fib6_info *f6i)
>  {
> @@ -267,6 +270,11 @@ static inline bool fib6_check_expired(const struct f=
ib6_info *f6i)
>  	return false;
>  }
> =20
> +static inline bool fib6_has_expires(const struct fib6_info *f6i)
> +{
> +	return f6i->fib6_flags & RTF_EXPIRES;
> +}
> +
>  /* Function to safely get fn->fn_sernum for passed in rt
>   * and store result in passed in cookie.
>   * Return true if we can get cookie safely
> @@ -388,6 +396,7 @@ struct fib6_table {
>  	struct inet_peer_base	tb6_peers;
>  	unsigned int		flags;
>  	unsigned int		fib_seq;
> +	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
>  #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
>  };
> =20
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index bac768d36cc1..32292a758722 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -160,6 +160,8 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags, bo=
ol with_fib6_nh)
>  	INIT_LIST_HEAD(&f6i->fib6_siblings);
>  	refcount_set(&f6i->fib6_ref, 1);
> =20
> +	INIT_HLIST_NODE(&f6i->gc_link);
> +
>  	return f6i;
>  }
> =20
> @@ -246,6 +248,7 @@ static struct fib6_table *fib6_alloc_table(struct net=
 *net, u32 id)
>  				   net->ipv6.fib6_null_entry);
>  		table->tb6_root.fn_flags =3D RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
>  		inet_peer_base_init(&table->tb6_peers);
> +		INIT_HLIST_HEAD(&table->tb6_gc_hlist);
>  	}
> =20
>  	return table;
> @@ -1057,6 +1060,11 @@ static void fib6_purge_rt(struct fib6_info *rt, st=
ruct fib6_node *fn,
>  				    lockdep_is_held(&table->tb6_lock));
>  		}
>  	}
> +
> +	if (fib6_has_expires(rt)) {
> +		hlist_del_init(&rt->gc_link);
> +		rt->fib6_flags &=3D ~RTF_EXPIRES;
> +	}
>  }
> =20
>  /*
> @@ -1118,9 +1126,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, s=
truct fib6_info *rt,
>  				if (!(iter->fib6_flags & RTF_EXPIRES))
>  					return -EEXIST;
>  				if (!(rt->fib6_flags & RTF_EXPIRES))
> -					fib6_clean_expires(iter);
> +					fib6_clean_expires_locked(iter);
>  				else
> -					fib6_set_expires(iter, rt->expires);
> +					fib6_set_expires_locked(iter, rt->expires);

The above looks buggy. At this point 'iter' should be already inserted
into the 'tb6_gc_hlist' list and fib6_set_expires_locked() will
inconditionally re-add it.

> =20
>  				if (rt->fib6_pmtu)
>  					fib6_metric_set(iter, RTAX_MTU,
> @@ -1480,6 +1488,9 @@ int fib6_add(struct fib6_node *root, struct fib6_in=
fo *rt,
>  			list_add(&rt->nh_list, &rt->nh->f6i_list);
>  		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
>  		fib6_start_gc(info->nl_net, rt);
> +
> +		if (fib6_has_expires(rt))
> +			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
>  	}
> =20
>  out:
> @@ -2267,6 +2278,91 @@ void fib6_clean_all(struct net *net, int (*func)(s=
truct fib6_info *, void *),
>  	__fib6_clean_all(net, func, FIB6_NO_SERNUM_CHANGE, arg, false);
>  }
> =20
> +void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
> +{
> +	struct fib6_table *tb6;
> +
> +	tb6 =3D f6i->fib6_table;
> +	spin_lock_bh(&tb6->tb6_lock);
> +	f6i->expires =3D expires;
> +	if (!fib6_has_expires(f6i))
> +		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
> +	f6i->fib6_flags |=3D RTF_EXPIRES;

This duplicates most of the code from 'fib6_set_expires_locked'.
Instead you could call the latter here, too. Then fib6_set_expires()
could be small enough to be defined as a static inline function in the
header file.

> +	spin_unlock_bh(&tb6->tb6_lock);
> +}
> +
> +void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expire=
s)
> +{
> +	struct fib6_table *tb6;
> +
> +	tb6 =3D f6i->fib6_table;
> +	f6i->expires =3D expires;
> +	if (tb6 && !fib6_has_expires(f6i))
> +		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
> +	f6i->fib6_flags |=3D RTF_EXPIRES;
> +}
> +
> +void fib6_clean_expires(struct fib6_info *f6i)
> +{
> +	struct fib6_table *tb6;
> +
> +	tb6 =3D f6i->fib6_table;
> +	spin_lock_bh(&tb6->tb6_lock);
> +	if (fib6_has_expires(f6i))
> +		hlist_del_init(&f6i->gc_link);
> +	f6i->fib6_flags &=3D ~RTF_EXPIRES;
> +	f6i->expires =3D 0;

Same here.

> +	spin_unlock_bh(&tb6->tb6_lock);
> +}
> +
> +void fib6_clean_expires_locked(struct fib6_info *f6i)
> +{
> +	struct fib6_table *tb6;
> +
> +	tb6 =3D f6i->fib6_table;
> +	if (tb6 && fib6_has_expires(f6i))
> +		hlist_del_init(&f6i->gc_link);
> +	f6i->fib6_flags &=3D ~RTF_EXPIRES;
> +	f6i->expires =3D 0;
> +}
> +
> +static void fib6_gc_table(struct net *net,
> +			  struct fib6_table *tb6,
> +			  int (*func)(struct fib6_info *, void *arg),
> +			  void *arg)
> +{
> +	struct fib6_info *rt;
> +	struct hlist_node *n;
> +	struct nl_info info =3D {
> +		.nl_net =3D net,
> +		.skip_notify =3D false,
> +	};
> +
> +	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
> +		if (func(rt, arg) =3D=3D -1)

As 'func' is always fib6_age, you don't need to use an indirect call
here.

> +			fib6_del(rt, &info);
> +}
> +
> +static void fib6_gc_all(struct net *net,
> +			int (*func)(struct fib6_info *, void *),
> +			void *arg)


> +{
> +	struct fib6_table *table;
> +	struct hlist_head *head;
> +	unsigned int h;
> +
> +	rcu_read_lock();
> +	for (h =3D 0; h < FIB6_TABLE_HASHSZ; h++) {
> +		head =3D &net->ipv6.fib_table_hash[h];
> +		hlist_for_each_entry_rcu(table, head, tb6_hlist) {
> +			spin_lock_bh(&table->tb6_lock);
> +			fib6_gc_table(net, table, func, arg);
> +			spin_unlock_bh(&table->tb6_lock);
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
>  void fib6_clean_all_skip_notify(struct net *net,
>  				int (*func)(struct fib6_info *, void *),
>  				void *arg)
> @@ -2295,7 +2391,7 @@ static int fib6_age(struct fib6_info *rt, void *arg=
)
>  	 *	Routes are expired even if they are in use.
>  	 */
> =20
> -	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
> +	if (fib6_has_expires(rt) && rt->expires) {
>  		if (time_after(now, rt->expires)) {
>  			RT6_TRACE("expiring %p\n", rt);
>  			return -1;
> @@ -2327,7 +2423,7 @@ void fib6_run_gc(unsigned long expires, struct net =
*net, bool force)
>  			  net->ipv6.sysctl.ip6_rt_gc_interval;
>  	gc_args.more =3D 0;
> =20
> -	fib6_clean_all(net, fib6_age, &gc_args);
> +	fib6_gc_all(net, fib6_age, &gc_args);
>  	now =3D jiffies;
>  	net->ipv6.ip6_rt_last_gc =3D now;
> =20
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 64e873f5895f..a69083563689 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3760,10 +3760,10 @@ static struct fib6_info *ip6_route_info_create(st=
ruct fib6_config *cfg,
>  		rt->dst_nocount =3D true;
> =20
>  	if (cfg->fc_flags & RTF_EXPIRES)
> -		fib6_set_expires(rt, jiffies +
> -				clock_t_to_jiffies(cfg->fc_expires));
> +		fib6_set_expires_locked(rt, jiffies +
> +					clock_t_to_jiffies(cfg->fc_expires));
>  	else
> -		fib6_clean_expires(rt);
> +		fib6_clean_expires_locked(rt);
> =20
>  	if (cfg->fc_protocol =3D=3D RTPROT_UNSPEC)
>  		cfg->fc_protocol =3D RTPROT_BOOT;

I think this feature deserves a new paired self test: please add it
with the next revision, and please explicitly insert the target tree
into the patch prefix (in this case 'net-next')

Thanks,

Paolo


