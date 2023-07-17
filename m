Return-Path: <netdev+bounces-18441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB13756FAE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 00:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB1D281486
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 22:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A610977;
	Mon, 17 Jul 2023 22:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD42F52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 22:17:42 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1177A4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:17:39 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9ad292819so4065601a34.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689632259; x=1692224259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAOJgd9eIxgaAwMCYrRIDegh2z57AY+aTUb1Xkwx3Vw=;
        b=Hgbc3Ffl09KaxScTskL+e2OlU/odeq5Z606NjM8bPoBoTP92lAtZqISPEWdzK5WJ7M
         WqsOw4oYUV2ggHAstnbW7+K2WOxV2CB6GpY1iqj6POx6diy2zs/Q8QMn+7DMHe9HYcO3
         9wxc45FW9As2DXrYeTKQafhC+pfGBzrZu7JLa5KC11opt60AM6R6u17++Z/1ZY0kUFM8
         JphcoN2lXSLrMIkfMqqLs4PaKzX0EubenyI/CWPHGkToCAr7+5CsDs2nHTljQEji1u4l
         D4ydryG1CMVIML7OMX83yUAZAKFugPVyMJOOkQ4sEYJxjdSDWLGA7oz4DbyhMxWrCsFM
         SYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632259; x=1692224259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAOJgd9eIxgaAwMCYrRIDegh2z57AY+aTUb1Xkwx3Vw=;
        b=HiP63RYH6Qp93+InIMZGobrywAZ4tBSmfswOaVH5LtFIINk8wZwANbLfJ2fEjv8mB/
         MS88KWxGcAU5Niimmge92Uag3JcsKZ2Jh+bdQz8zw5U4j+CmDEJN5qXE/J3MVzAKBkwU
         WSqtptaEBJzoPtgOg+VM+18wpz/3CBP2/kHS++Mx8qy2WzSBwqU+fIYOj7/BA/gk6czo
         5O680yKjDwZAfhOLezp95xPtOnGwKQKzyVp8uikb20XwZCvHv8MTFBjTUslZbbs8+Wwp
         zqPSbSTL+4nREyUCT5fCHirNn8UiD8kAOes71LJFfU6Ka3F1ONBbZqprG4SB/r3Ndmly
         KZhw==
X-Gm-Message-State: ABy/qLb+2xWg5l00mgbltY2XdmUXj/rlk2S47bvVJ6/kbLH/xv6VJM4a
	X2BH9bqhIco/ykhtT4yMjZNXKwA9fws=
X-Google-Smtp-Source: APBJJlHGh1hDeCGoETET24+evW5mYZDUQrpPrmZs53UGyOPHM57TgTCvnwH3ITAqVvmVCgudpMNXyQ==
X-Received: by 2002:a05:6358:5922:b0:132:db25:bbfc with SMTP id g34-20020a056358592200b00132db25bbfcmr11947385rwf.2.1689632259044;
        Mon, 17 Jul 2023 15:17:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:af1:9a93:de8d:12f4? ([2600:1700:6cf8:1240:af1:9a93:de8d:12f4])
        by smtp.gmail.com with ESMTPSA id o66-20020a817345000000b00576c534115bsm123295ywc.34.2023.07.17.15.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 15:17:38 -0700 (PDT)
Message-ID: <837bbc34-ce0f-f2c9-4a20-21c0a0c01041@gmail.com>
Date: Mon, 17 Jul 2023 15:17:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net/ipv6: Remove expired routes with a separated list
 of routes.
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230710203609.520720-1-kuifeng@meta.com>
 <bb9e2a2685447a704e0fd94c078519f3ce587805.camel@redhat.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <bb9e2a2685447a704e0fd94c078519f3ce587805.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/13/23 01:44, Paolo Abeni wrote:
> Hi,
> 
> On Mon, 2023-07-10 at 13:36 -0700, Kui-Feng Lee wrote:
>> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
>> can be expensive if the number of routes in a table is big, even if most of
>> them are permanent. Checking routes in a separated list of routes having
>> expiration will avoid this potential issue.
>>
>> Background
>> ==========
>>
>> The size of a Linux IPv6 routing table can become a big problem if not
>> managed appropriately.  Now, Linux has a garbage collector to remove
>> expired routes periodically.  However, this may lead to a situation in
>> which the routing path is blocked for a long period due to an
>> excessive number of routes.
>>
>> For example, years ago, there is a commit about "ICMPv6 Packet too big
>> messages". The root cause is that malicious ICMPv6 packets were sent back
> 
> Please use the customary commit reference: <hash> ("<title>")

Sure!

> 
>> for every small packet sent to them. These packets add routes with an
>> expiration time that prompts the GC to periodically check all routes in the
>> tables, including permanent ones.
>>
>> Why Route Expires
>> =================
>>
>> Users can add IPv6 routes with an expiration time manually. However,
>> the Neighbor Discovery protocol may also generate routes that can
>> expire.  For example, Router Advertisement (RA) messages may create a
>> default route with an expiration time. [RFC 4861] For IPv4, it is not
>> possible to set an expiration time for a route, and there is no RA, so
>> there is no need to worry about such issues.
>>
>> Create Routes with Expires
>> ==========================
>>
>> You can create routes with expires with the  command.
>>
>> For example,
>>
>>      ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \
>>          dev enp0s3 expires 30
>>
>> The route that has been generated will be deleted automatically in 30
>> seconds.
>>
>> GC of FIB6
>> ==========
>>
>> The function called fib6_run_gc() is responsible for performing
>> garbage collection (GC) for the Linux IPv6 stack. It checks for the
>> expiration of every route by traversing the trees of routing
>> tables. The time taken to traverse a routing table increases with its
>> size. Holding the routing table lock during traversal is particularly
>> undesirable. Therefore, it is preferable to keep the lock for the
>> shortest possible duration.
>>
>> Solution
>> ========
>>
>> The cause of the issue is keeping the routing table locked during the
>> traversal of large trees. To solve this problem, we can create a separate
>> list of routes that have expiration. This will prevent GC from checking
>> permanent routes.
>>
>> Result
>> ======
>>
>> We conducted a test to measure the execution times of fib6_gc_timer_cb()
>> and observed that it enhances the GC of FIB6. During the test, we added
>> permanent routes with the following numbers: 1000, 3000, 6000, and
>> 9000. Additionally, we added a route with an expiration time.
>>
>> Here are the average execution times for the kernel without the patch.
>>   - 120020 ns with 1000 permanent routes
>>   - 308920 ns with 3000 ...
>>   - 581470 ns with 6000 ...
>>   - 855310 ns with 9000 ...
>>
>> The kernel with the patch consistently takes around 14000 ns to execute,
>> regardless of the number of permanent routes that are installed.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/net/ip6_fib.h |  31 ++++++++-----
>>   net/ipv6/ip6_fib.c    | 104 ++++++++++++++++++++++++++++++++++++++++--
>>   net/ipv6/route.c      |   6 +--
>>   3 files changed, 123 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
>> index 05e6f756feaf..fb4d8bf4b938 100644
>> --- a/include/net/ip6_fib.h
>> +++ b/include/net/ip6_fib.h
>> @@ -177,6 +177,8 @@ struct fib6_info {
>>   	};
>>   	unsigned int			fib6_nsiblings;
>>   
>> +	struct hlist_node		gc_link;
>> +
> 
> It looks like placing the new field here will create 2 4bytes holes, I
> think it should be better moving it after 'fib6_ref'

You are right! I didn't aware that. Thank you for reminding!

> 
>>   	refcount_t			fib6_ref;
>>   	unsigned long			expires;
>>   	struct dst_metrics		*fib6_metrics;
>> @@ -247,18 +249,19 @@ static inline bool fib6_requires_src(const struct fib6_info *rt)
>>   	return rt->fib6_src.plen > 0;
>>   }
>>   
>> -static inline void fib6_clean_expires(struct fib6_info *f6i)
>> -{
>> -	f6i->fib6_flags &= ~RTF_EXPIRES;
>> -	f6i->expires = 0;
>> -}
>> +void fib6_clean_expires(struct fib6_info *f6i);
>> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
>> + * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
>> + * list of GC candidates until it is inserted into a table.
>> + */
> 
> This comment should be probably paired with  'fib6_set_expires'
> instead.

Right!

> 
>> +void fib6_clean_expires_locked(struct fib6_info *f6i);
>>   
>> -static inline void fib6_set_expires(struct fib6_info *f6i,
>> -				    unsigned long expires)
>> -{
>> -	f6i->expires = expires;
>> -	f6i->fib6_flags |= RTF_EXPIRES;
>> -}
>> +void fib6_set_expires(struct fib6_info *f6i, unsigned long expires);
>> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
>> + * NULL.
>> + */
>> +void fib6_set_expires_locked(struct fib6_info *f6i,
>> +			     unsigned long expires);
>>   
>>   static inline bool fib6_check_expired(const struct fib6_info *f6i)
>>   {
>> @@ -267,6 +270,11 @@ static inline bool fib6_check_expired(const struct fib6_info *f6i)
>>   	return false;
>>   }
>>   
>> +static inline bool fib6_has_expires(const struct fib6_info *f6i)
>> +{
>> +	return f6i->fib6_flags & RTF_EXPIRES;
>> +}
>> +
>>   /* Function to safely get fn->fn_sernum for passed in rt
>>    * and store result in passed in cookie.
>>    * Return true if we can get cookie safely
>> @@ -388,6 +396,7 @@ struct fib6_table {
>>   	struct inet_peer_base	tb6_peers;
>>   	unsigned int		flags;
>>   	unsigned int		fib_seq;
>> +	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
>>   #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
>>   };
>>   
>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>> index bac768d36cc1..32292a758722 100644
>> --- a/net/ipv6/ip6_fib.c
>> +++ b/net/ipv6/ip6_fib.c
>> @@ -160,6 +160,8 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags, bool with_fib6_nh)
>>   	INIT_LIST_HEAD(&f6i->fib6_siblings);
>>   	refcount_set(&f6i->fib6_ref, 1);
>>   
>> +	INIT_HLIST_NODE(&f6i->gc_link);
>> +
>>   	return f6i;
>>   }
>>   
>> @@ -246,6 +248,7 @@ static struct fib6_table *fib6_alloc_table(struct net *net, u32 id)
>>   				   net->ipv6.fib6_null_entry);
>>   		table->tb6_root.fn_flags = RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
>>   		inet_peer_base_init(&table->tb6_peers);
>> +		INIT_HLIST_HEAD(&table->tb6_gc_hlist);
>>   	}
>>   
>>   	return table;
>> @@ -1057,6 +1060,11 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
>>   				    lockdep_is_held(&table->tb6_lock));
>>   		}
>>   	}
>> +
>> +	if (fib6_has_expires(rt)) {
>> +		hlist_del_init(&rt->gc_link);
>> +		rt->fib6_flags &= ~RTF_EXPIRES;
>> +	}
>>   }
>>   
>>   /*
>> @@ -1118,9 +1126,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>>   				if (!(iter->fib6_flags & RTF_EXPIRES))
>>   					return -EEXIST;
>>   				if (!(rt->fib6_flags & RTF_EXPIRES))
>> -					fib6_clean_expires(iter);
>> +					fib6_clean_expires_locked(iter);
>>   				else
>> -					fib6_set_expires(iter, rt->expires);
>> +					fib6_set_expires_locked(iter, rt->expires);
> 
> The above looks buggy. At this point 'iter' should be already inserted
> into the 'tb6_gc_hlist' list and fib6_set_expires_locked() will
> inconditionally re-add it.

fib6_set_expires_locked() checks fib6_flags before adding to the list.
So, it should not happen.

> 
>>   
>>   				if (rt->fib6_pmtu)
>>   					fib6_metric_set(iter, RTAX_MTU,
>> @@ -1480,6 +1488,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
>>   			list_add(&rt->nh_list, &rt->nh->f6i_list);
>>   		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
>>   		fib6_start_gc(info->nl_net, rt);
>> +
>> +		if (fib6_has_expires(rt))
>> +			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
>>   	}
>>   
>>   out:
>> @@ -2267,6 +2278,91 @@ void fib6_clean_all(struct net *net, int (*func)(struct fib6_info *, void *),
>>   	__fib6_clean_all(net, func, FIB6_NO_SERNUM_CHANGE, arg, false);
>>   }
>>   
>> +void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
>> +{
>> +	struct fib6_table *tb6;
>> +
>> +	tb6 = f6i->fib6_table;
>> +	spin_lock_bh(&tb6->tb6_lock);
>> +	f6i->expires = expires;
>> +	if (!fib6_has_expires(f6i))
>> +		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
>> +	f6i->fib6_flags |= RTF_EXPIRES;
> 
> This duplicates most of the code from 'fib6_set_expires_locked'.
> Instead you could call the latter here, too. Then fib6_set_expires()
> could be small enough to be defined as a static inline function in the
> header file.

Agree!

> 
>> +	spin_unlock_bh(&tb6->tb6_lock);
>> +}
>> +
>> +void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expires)
>> +{
>> +	struct fib6_table *tb6;
>> +
>> +	tb6 = f6i->fib6_table;
>> +	f6i->expires = expires;
>> +	if (tb6 && !fib6_has_expires(f6i))
>> +		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
>> +	f6i->fib6_flags |= RTF_EXPIRES;
>> +}
>> +
>> +void fib6_clean_expires(struct fib6_info *f6i)
>> +{
>> +	struct fib6_table *tb6;
>> +
>> +	tb6 = f6i->fib6_table;
>> +	spin_lock_bh(&tb6->tb6_lock);
>> +	if (fib6_has_expires(f6i))
>> +		hlist_del_init(&f6i->gc_link);
>> +	f6i->fib6_flags &= ~RTF_EXPIRES;
>> +	f6i->expires = 0;
> 
> Same here.Got it!

> 
>> +	spin_unlock_bh(&tb6->tb6_lock);
>> +}
>> +
>> +void fib6_clean_expires_locked(struct fib6_info *f6i)
>> +{
>> +	struct fib6_table *tb6;
>> +
>> +	tb6 = f6i->fib6_table;
>> +	if (tb6 && fib6_has_expires(f6i))
>> +		hlist_del_init(&f6i->gc_link);
>> +	f6i->fib6_flags &= ~RTF_EXPIRES;
>> +	f6i->expires = 0;
>> +}
>> +
>> +static void fib6_gc_table(struct net *net,
>> +			  struct fib6_table *tb6,
>> +			  int (*func)(struct fib6_info *, void *arg),
>> +			  void *arg)
>> +{
>> +	struct fib6_info *rt;
>> +	struct hlist_node *n;
>> +	struct nl_info info = {
>> +		.nl_net = net,
>> +		.skip_notify = false,
>> +	};
>> +
>> +	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
>> +		if (func(rt, arg) == -1)
> 
> As 'func' is always fib6_age, you don't need to use an indirect call
> here.

Agree!

> 
>> +			fib6_del(rt, &info);
>> +}
>> +
>> +static void fib6_gc_all(struct net *net,
>> +			int (*func)(struct fib6_info *, void *),
>> +			void *arg)
> 
> 
>> +{
>> +	struct fib6_table *table;
>> +	struct hlist_head *head;
>> +	unsigned int h;
>> +
>> +	rcu_read_lock();
>> +	for (h = 0; h < FIB6_TABLE_HASHSZ; h++) {
>> +		head = &net->ipv6.fib_table_hash[h];
>> +		hlist_for_each_entry_rcu(table, head, tb6_hlist) {
>> +			spin_lock_bh(&table->tb6_lock);
>> +			fib6_gc_table(net, table, func, arg);
>> +			spin_unlock_bh(&table->tb6_lock);
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +}
>> +
>>   void fib6_clean_all_skip_notify(struct net *net,
>>   				int (*func)(struct fib6_info *, void *),
>>   				void *arg)
>> @@ -2295,7 +2391,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
>>   	 *	Routes are expired even if they are in use.
>>   	 */
>>   
>> -	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
>> +	if (fib6_has_expires(rt) && rt->expires) {
>>   		if (time_after(now, rt->expires)) {
>>   			RT6_TRACE("expiring %p\n", rt);
>>   			return -1;
>> @@ -2327,7 +2423,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
>>   			  net->ipv6.sysctl.ip6_rt_gc_interval;
>>   	gc_args.more = 0;
>>   
>> -	fib6_clean_all(net, fib6_age, &gc_args);
>> +	fib6_gc_all(net, fib6_age, &gc_args);
>>   	now = jiffies;
>>   	net->ipv6.ip6_rt_last_gc = now;
>>   
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index 64e873f5895f..a69083563689 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -3760,10 +3760,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>>   		rt->dst_nocount = true;
>>   
>>   	if (cfg->fc_flags & RTF_EXPIRES)
>> -		fib6_set_expires(rt, jiffies +
>> -				clock_t_to_jiffies(cfg->fc_expires));
>> +		fib6_set_expires_locked(rt, jiffies +
>> +					clock_t_to_jiffies(cfg->fc_expires));
>>   	else
>> -		fib6_clean_expires(rt);
>> +		fib6_clean_expires_locked(rt);
>>   
>>   	if (cfg->fc_protocol == RTPROT_UNSPEC)
>>   		cfg->fc_protocol = RTPROT_BOOT;
> 
> I think this feature deserves a new paired self test: please add it
> with the next revision, and please explicitly insert the target tree
> into the patch prefix (in this case 'net-next')

Got it!

Thank you for the review!

> 
> Thanks,
> 
> Paolo
> 
> 

