Return-Path: <netdev+bounces-34121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A67A22FC
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454331C20ADD
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A22B11C99;
	Fri, 15 Sep 2023 15:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0230D05
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:54:53 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B64E78
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:54:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40476ce8b2fso14806875e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694793290; x=1695398090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I1h8YCnwFeB0GVKkTlrI3aGet6KqtF196LIsCT/osKw=;
        b=EtYcxFupdJu4wHRBc3ibI1KJDnfWAhu/SHv/wjU5P+g3s/rJdRXEsT9fCd8ZcH58ny
         Z+clJndkMhNlnyDJ9DNuaP01QeeJkybJMq1tfFsAP5XGYqQQvDYdrK/5k4NQv8hapV87
         mpLNA9UZlDQHsSXNQbXYdeyVGjHYik3hydNf7tlAbajBpfUlPFcpKhFvM7qkl85HzPo0
         t9ptzcXW31ZIKUGv6p2NpCeTvaNW+xWik00EyI0WI2C+lx2wjO2iF0S/TBTslEzRd99q
         e3HKvTH/XHdJE8PR9tAVDXVguHDMDxWA/3GZQTJclZZcgxQLsnrBneP5s3NU6jn6n5yK
         wqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694793290; x=1695398090;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1h8YCnwFeB0GVKkTlrI3aGet6KqtF196LIsCT/osKw=;
        b=wnZa2DbUjI9GnKXqT8e74l7RwNAkS5fNPV3cRHWuBbwAkI/PE9rMf4YpUvYvHB+W24
         LjH9sQb0KDoN9t1eXvk4/zlTOj5HVvOP7yZnJkzi2s8O9nWKhiuF+K+ttGZuEsJhs1mF
         iGeDXrFJ+A0BvnJT7d7TZy0xkC6qdHIbYEyLHuXRv3mhPunGbudl1XEGUSW1mn9tqdU3
         qwCjZQPyfJcNOIv2tVsWijU/9Jv56EXgpQ70hGQ+O8UKiJvgyP+AyMa6eTGz0ZHgd65y
         wxwa3dDIWPeYFPBcer5k7BkkuXAnj20T3y+ljSslT7Bnz+IY6t+ys1TMuJr9XMXmZr6/
         ShHQ==
X-Gm-Message-State: AOJu0Yw6hd5umotg1vtGDTUyq1q52E5v7SH7x9j41NQ3E5zUCqNtBof3
	1m8FsV18x8D43qGPMySXG3zMqA==
X-Google-Smtp-Source: AGHT+IF7cTgcFYVzsv/uP8lze2eyyWIWskIoHCfPFhgLWRwdKcmaq6R87vnwWL8X043gMZ7MnUe9gg==
X-Received: by 2002:a1c:4c07:0:b0:402:ee9e:ed98 with SMTP id z7-20020a1c4c07000000b00402ee9eed98mr1829410wmf.34.1694793289564;
        Fri, 15 Sep 2023 08:54:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:724a:5ebf:1377:3f14? ([2a01:e0a:b41:c160:724a:5ebf:1377:3f14])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bcb8a000000b003fed7fa6c00sm7931335wmi.7.2023.09.15.08.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:54:48 -0700 (PDT)
Message-ID: <49271935-e0bf-948c-829b-18ddd9203926@6wind.com>
Date: Fri, 15 Sep 2023 17:54:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Thomas Haller <thaller@redhat.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
 <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com> <ZQGG8xqt8m3IHS4z@Laptop-X1>
 <e2b57bea-fb14-cef4-315a-406f0d3a7e4f@6wind.com>
 <767a9486-6734-6113-9346-f4bef04370f0@kernel.org>
 <a4003473-6809-db97-3d06-cec8e08c6ed6@6wind.com>
 <b83e24a4-6de3-0df2-d902-f2cc3cdbaf41@6wind.com>
 <0e146bcf-d8b1-84a3-f8a4-976fc8414b25@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <0e146bcf-d8b1-84a3-f8a4-976fc8414b25@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 15/09/2023 à 05:07, David Ahern a écrit :
> On 9/14/23 9:43 AM, Nicolas Dichtel wrote:
>> Le 13/09/2023 à 16:53, Nicolas Dichtel a écrit :
>>> Le 13/09/2023 à 16:43, David Ahern a écrit :
>>>> On 9/13/23 8:11 AM, Nicolas Dichtel wrote:
>>>>> The compat_mode was introduced for daemons that doesn't support the nexthop
>>>>> framework. There must be a notification (RTM_DELROUTE) when a route is deleted
>>>>> due to a carrier down event. Right now, the backward compat is broken.
>>>>
>>>> The compat_mode is for daemons that do not understand the nexthop id
>>>> attribute, and need the legacy set of attributes for the route - i.e,
>>> Yes, it's my point.
>>> On my system, one daemon understands and configures nexthop id and another one
>>> doesn't understand nexthop id. This last daemon removes routes when an interface
>>> is put down but not when the carrier is lost.
>>> The kernel doc [1] says:
>>> 	Further, updates or deletes of a nexthop configuration generate route
>>> 	notifications for each fib entry using the nexthop.
>>> So, my understanding is that a RTM_DELROUTE msg should be sent when a nexthop is
>>> removed due to a carrier lost event.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/ip-sysctl.rst#n2116
>>
>> I dug a bit more about these (missing) notifications. I will try to describe
>> what should be done for cases where there is no notification:
>>
>> When an interface is set down:
>>  - the single (!multipath) routes associated with this interface should be
>>    removed;
>>  - for multipath routes:
>>    + if all nh use this interface: the routes are deleted;
>>    + if only some nh uses this interface :
>>      ~ if all other nh already point to a down interface: the routes are deleted;
>>      ~ if at least one nh points to an up interface:
>>        o the nh are *temporarily* disabled if it's a plain nexthop;
>>        o the nh is *definitely* removed if it's a nexthop object;
>> When the interface is set up later, disabled nh are restored (ie only plain
>> nexthop of multipath routes).
>>
>> When an interface loses its carrier:
>>  - for routes using plain nexthop: nothing happens;
>>  - for routes using nexthop objects:
>>    + for single routes: they are deleted;
>>    + for multipath routes, the nh is definitely removed if it's a nexthop
>>      object (ie the route is deleted if there is no other nexthop in the group);
>> When an interface recovers its carrier, there is nothing to do.
>>
>> When the last ipv4 address of an interface is removed:
>>  - for routes using nexthop objects: nothing happens;
>>  - for routes using plain nexthop: the same rules as 'interface down' applies.
>> When an ipv4 address is added again on the interface, disabled nh are restored
>> (ie only plain nexthop of multipath routes).
>>
>> I bet I miss some cases.
>>
>> Conclusions:
>>  - legacy applications (that are not aware of nexthop objects) cannot maintain a
>>    routing cache (even with compat_mode enabled);
>>  - fixing only the legacy applications (aka compat_mode) seems too
>>    complex;
>>  - even if an application is aware of nexthop objects, the rules to maintain a
>>    cache are far from obvious.
>>
>> I don't understand why there is so much reluctance to not send a notification
>> when a route is deleted. This would fix all cases.
>> I understand that the goal was to save netlink traffic, but in this case, the
>> daemons that are interested in maintaining a routing cache have to fully parse
>> their cache to mark/remove routes. For big routing tables, this will cost a lot
>> of cpu, so I wonder if it's really a gain for the system. On such systems, there
>> is probably more than one daemon in this case, so even more cpu to spend for
>> these operations.
>>
>> As Thomas said, this discussion has come up for more than a decade. And with the
>> nexthop objects support, it's even more complex. There is obviously something to do.
>>
>> At least, I would have expected an RTM_DELNEXTHOP msg for each deleted nexthop.
>> But this wouldn't solve the routing cache sync for legacy applications.
>>
> 
> The split nexthop API is about efficiency. Do not send route
Efficiency for the kernel, but complexity for userspace daemons. I'm not sure
the system wins something when several daemons implement the same complex logic.

> notifications when they are easily derived from other events -- e.g.,
> link down or carrier down. The first commit for the nexthop code:
> 
> commit ab84be7e54fc3d9b248285f1a14067558d858819
> Author: David Ahern <dsahern@gmail.com>
> Date:   Fri May 24 14:43:04 2019 -0700
> 
>     net: Initial nexthop code
> 
>     Barebones start point for nexthops. Implementation for RTM commands,
>     notifications, management of rbtree for holding nexthops by id, and
>     kernel side data structures for nexthops and nexthop config.
> 
>     Nexthops are maintained in an rbtree sorted by id. Similar to routes,
>     nexthops are configured per namespace using netns_nexthop struct added
>     to struct net.
> 
>     Nexthop notifications are sent when a nexthop is added or deleted,
>     but NOT if the delete is due to a device event or network namespace
>     teardown (which also involves device events). Applications are
>     expected to use the device down event to flush nexthops and any
>     routes used by the nexthops.
> 
> Intent is stated.
I understand, but are there numbers of the gain? In terms of cpu? memory? Some
systems could have a lot of routes (~900k for an ipv4 full route), but they
usually have a small number of nexthop. If you look at the big picture, is it
really worth saving some netlink messages and putting the load/complexity in the
userspace daemons?

It was the initial intent, no problem. But if people complain, maybe it could be
improved to fit everybody's use case.

> 
> The only compatibility with legacy API is around expanding the nhid to a
> full set of nexthop attributes to aid a transition to the new API.
As I said in another reply, the kernel doc [1] seems also to explain this:
	Further, updates or deletes of a nexthop configuration generate route
	notifications for each fib entry using the nexthop.

Without this, legacy daemons are broken. The compat_mode only hides some
behavior changes if these updates are not notified.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/ip-sysctl.rst#n2116


Regards,
Nicolas

