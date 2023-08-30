Return-Path: <netdev+bounces-31355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BAB78D497
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA692812B3
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DBE1FB2;
	Wed, 30 Aug 2023 09:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AE1C03
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:38:03 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E6BE
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:38:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf4752c3cso33018565ad.2
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693388281; x=1693993081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4+SLtNpLYDV+P8YGvT9chqjBTHV7jwmYv+FwFjghA0=;
        b=IH1A8JAVoAQMC4BhxnL575UZkcz6TNC3dipgd0xJ6qM+39oTdSGqjrnMFlyFhHqz8J
         CGtzRf+iWBOtfG83tz5PPtRtOPtqOkPb038KjtEDcnaaYu+krmGrizWhJU8zrIszQdaW
         MYfhFt7kVmjsilVhbu1qhubFqUCHjslmYJ9bHHZpP8kMct4GmOIXwrWfyrXBRQBGhW8f
         7LQuj44YdXkACy5ve+K+ViuAfs4rA1tMcQwNMzlvUZuLqeyY0Vv+Dlh3i1O7iWChZzp0
         N9D8QtKIr5MHS+UBo9f5nL7bhFOTZUhdmdJqvSQ6NBCEcXr9d/f5YYKxQUoAHJWUz0zh
         nO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693388281; x=1693993081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4+SLtNpLYDV+P8YGvT9chqjBTHV7jwmYv+FwFjghA0=;
        b=XXozuKcFxb6g9O3PC9Du5bASBEWXR3qmRyb/KbRBeQo77JobyEWvvmD3KZtc6JPwza
         ja/06eh3rHa5J1mqWQqXcva9eldtP/ci9G4yDCJwpftb5/30kQUqcb8ZFEcau26MHigp
         8r9JcCPCNjjv1M504daKMFsw9jK/ry0+L7Ufu8qM5ULNIPpqJ+mEYD67mRmSazF6Gevc
         PEJ9scicu8w0FBcOqeHyXyil8G6CqDaj1tbgdPwXi3J2J//WyHTDvlwe5JeQI8Oyct2g
         TDhwOqDAlVaGGcU878hyrl2kLW1911M8ca0Hhc9xKObZClLsjl8s+ZToHBb85NTSxWCE
         lXKQ==
X-Gm-Message-State: AOJu0Yz6yvtGUkLXzaZjVfT4CacKyy8ZX/r9XEdQ//rifDwgF7sz081j
	Y63ZgRmQ3TEhazNmKca8Lrv+yWrkuR0=
X-Google-Smtp-Source: AGHT+IFY2yog9wkLdqpl2bt9J7KdWHsHCi0aY2L+1xJalX0BTsV6kOF2bKp1deWrxGWPEf/h8yBI2g==
X-Received: by 2002:a17:902:dac5:b0:1c2:1b71:f2ed with SMTP id q5-20020a170902dac500b001c21b71f2edmr120301plx.5.1693388280990;
        Wed, 30 Aug 2023 02:38:00 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7820:a6d0:fe00:94b0:34da:834c])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001bdf046ed71sm10757812plb.120.2023.08.30.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:38:00 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:37:55 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Message-ID: <ZO8N8yyYubzB2bJF@Laptop-X1>
References: <20230830061622.2320096-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830061622.2320096-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry, Looks it failed when I cancel the git send-email. There is
a typo in the subject. Should be "different" instead of "differe"...

I will fix this if there is an update needed.

Hangbin
On Wed, Aug 30, 2023 at 02:16:22PM +0800, Hangbin Liu wrote:
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
> 
> Reported-by: Thomas Haller <thaller@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2161994
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
> -- 
> 2.41.0
> 

