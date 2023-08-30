Return-Path: <netdev+bounces-31429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99978D6FC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019EC2810FE
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967D6FD1;
	Wed, 30 Aug 2023 15:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B723DF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:29:44 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504781A3
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:29:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40078c4855fso53745325e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1693409382; x=1694014182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1N4xeRS7u5SwQUwXLzC4QTPCvrGeeBsZ3NmBvXt8mkg=;
        b=huJNaxFWoO5W96r5jt5bJVqZBfYNGWD/u/BLa8LFalSxi8I9ajICzhVUpE0z1QUfdE
         N8srnLX3e4ZPksB+dmD5cHdCuTMe40lRGX/xOdYf/0IEdAQ5wuwf4UaRKt5H2uSGamdR
         gWTZ7FmFFd/XkDg0Lj3wkPBDDaKctd5P6IREnJ5nAmuERG0/swAs7sDZvUf85XdJVTkB
         eGz7SSp3ZqO9XlChvBJR3CRVD3MHnX5t4Aob7nPJxn1laNKUxqTM1CDrc0TZbZUnbvvf
         E5b1rxfcBSA/milL9eTzLrLb7n3npGSQTPMtv/r/qOpNZLLEEFutSvAnttMjuMvEFa2X
         oqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409382; x=1694014182;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1N4xeRS7u5SwQUwXLzC4QTPCvrGeeBsZ3NmBvXt8mkg=;
        b=izlrPnm4XD8q7RSelFbKwncrR2qzObE6AAAajdhZEgO2ysWhbEby2xHrIdN9YJ7lYa
         OEZKhw8RcReDOLF9WFgFcBSuv9i+uCf9n2iauRll3BenAWYv2fpV2I7rYjWecZSifk3i
         prTpvMvTUXz49LtwNAhwTgy7HIIVeLF1uAsYKT6+v0ST/U4R5q59Ku1oKCYLXcJPiJcO
         jfFq8rnrcOByeqzkM51gxA9vC2l1A/QQzZ6xz7klILrjCSxtLWy4t4qRJUcfGlCUwaKn
         vzlAwxfMoR64W1uwbhUTNHs2PRe5qnEfzR8bkgu3xNXo8yAaaDX+nqnQzWe3ItYPRW12
         fjdQ==
X-Gm-Message-State: AOJu0YzCr+S2Qi5/R1vHkmS/mZGhwRdRx5fuWl84p/Hb1L1mlJeP+LkL
	xErqt5w2mQTfHB0cNcvgH1TYvsvwT7QH3TCYH2U=
X-Google-Smtp-Source: AGHT+IFvOpSRL+cKCsE/yoLq3Om9eGUwdXfTFQsZtAGrulQxu09ffBecu9w9nRC8Doc27ZFoIypmWw==
X-Received: by 2002:a05:600c:22c3:b0:401:b53e:6c3b with SMTP id 3-20020a05600c22c300b00401b53e6c3bmr2101738wmg.6.1693409381560;
        Wed, 30 Aug 2023 08:29:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:88aa:cf33:6b9f:40b5? ([2a01:e0a:b41:c160:88aa:cf33:6b9f:40b5])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b00401d8181f8bsm2586756wmf.25.2023.08.30.08.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:29:40 -0700 (PDT)
Message-ID: <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
Date: Wed, 30 Aug 2023 17:29:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230830061550.2319741-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 30/08/2023 à 08:15, Hangbin Liu a écrit :
> Different with IPv4, IPv6 will auto merge the same metric routes into
> multipath routes. But the different type and protocol routes are also
> merged, which will lost user's configure info. e.g.
> 
> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
> + ip -6 route show table 100
> local 2001:db8:103::/64 metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> 
> + ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
> + ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
> + ip -6 route show table 200
> 2001:db8:104::/64 proto kernel metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> 
> So let's skip counting the different type and protocol routes as siblings.
> After update, the different type/protocol routes will not be merged.
> 
> + ip -6 route show table 100
> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
> 
> + ip -6 route show table 200
> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium

This seems wrong. The goal of 'ip route append' is to add a next hop, not to
create a new route. Ok, it adds a new route if no route exists, but it seems
wrong to me to use it by default, instead of 'add', to make things work magically.

It seems more correct to return an error in these cases, but this will change
the uapi and it may break existing setups.

Before this patch, both next hops could be used by the kernel. After it, one
route will be ignored (the former or the last one?). This is confusing and also
seems wrong.

> 
> Reported-by: Thomas Haller <thaller@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2161994
Please, don't put private link. The bug entry is not public.

Can you explain what is the initial problem?


> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> All fib test passed:
> Tests passed: 203
> Tests failed:   0
> ---
>  net/ipv6/ip6_fib.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 28b01a068412..f60f5d14f034 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1133,6 +1133,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  							rt->fib6_pmtu);
>  				return -EEXIST;
>  			}
> +
> +			if (iter->fib6_type != rt->fib6_type ||
> +			    iter->fib6_protocol != rt->fib6_protocol)
> +				goto next_iter;
> +
>  			/* If we have the same destination and the same metric,
>  			 * but not the same gateway, then the route we try to
>  			 * add is sibling to this route, increment our counter

