Return-Path: <netdev+bounces-33914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF617A09AF
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F7FB2080B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDBC2110C;
	Thu, 14 Sep 2023 15:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB6CA78
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:43:23 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0D99
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:43:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so1065650f8f.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694706201; x=1695311001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0dQJlmPkRoYe95XpgxvtyrGY+Vo+IGCkpC1ldQpOps=;
        b=T7skHdfl8ieSaKNQmVy4A/ECrRjMgXpJqupWd1aKwwbrjZ7vJShuUMuiCnI+T8Bxc4
         jDVoqQuR3xA9t7/JYFyUWvtyTH3UZN/8CR6s70iHoZSPWXqdJCa+Vg1NLMokvQ97NZUR
         zaTccZ5GJDwe/WNfYnEal8RRTQa6VT95jlJWNrq/21hsFHFSCtnnA/fqO0OzRpDWlqHv
         t7A+TpHJuhZ7XFlu9Mj8kQLY8gD6bJnYZQGblbj5/grBsMOsxkv+K9nOmCmySZse1lSa
         oRAF6PJNmvIpUEil69nrKiHk8qi6iVY881p9qQHwscqwkz3SHKB6lsqAAhqIxgo8TKUe
         Iazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694706201; x=1695311001;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0dQJlmPkRoYe95XpgxvtyrGY+Vo+IGCkpC1ldQpOps=;
        b=ckKHXCwBlrffJhE9JX0EzoaujYt6W4wKwJqLZTv6Kbau4gsvXTshl6o3XQztPhiIjS
         sVlkAeLev0tTxDJVqWDifJQf0mIqybLycsIAZeJmdsu2jUBWxFuH581xeUomNdUp6oNG
         rSeYuwsrkM698oXEeVORqORHqxDC8Dw2av4Y+ulVx/foucPR7i8cEWmNPwKSomDA20aT
         86jF97v6n/ELd5AATemo+DyxQBsU5fVxLBT72OVMavOQt4FUX9L0OgcLP8AyCiFOPtuU
         oV46kdEaNzK5FT+D2Xsolf/lw9LGLTa57u90nZhejbNQwd2YPH3dQIFYttKBbs+hxksp
         U1Fw==
X-Gm-Message-State: AOJu0Yw20uV/YU9RGNlv33e1qI95pfy6JI1spGdV3qFRqJdjEHKnmYJ2
	oMFCZbZ/pxFqoNrKFx4rvNXarQ==
X-Google-Smtp-Source: AGHT+IFh+MGRF71hcHzxaHPc1Bz0AfhURon+iQ2w7rwccT97qBsoKUF/fE1Z+7ponJlbLbr6+xv/0A==
X-Received: by 2002:a05:6000:1112:b0:31f:9501:fc0c with SMTP id z18-20020a056000111200b0031f9501fc0cmr4791908wrw.45.1694706200596;
        Thu, 14 Sep 2023 08:43:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:c3c5:63df:302e:e540? ([2a01:e0a:b41:c160:c3c5:63df:302e:e540])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000100b00b0031c52e81490sm2094046wrx.72.2023.09.14.08.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 08:43:19 -0700 (PDT)
Message-ID: <b83e24a4-6de3-0df2-d902-f2cc3cdbaf41@6wind.com>
Date: Thu, 14 Sep 2023 17:43:19 +0200
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
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
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
Organization: 6WIND
In-Reply-To: <a4003473-6809-db97-3d06-cec8e08c6ed6@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 13/09/2023 à 16:53, Nicolas Dichtel a écrit :
> Le 13/09/2023 à 16:43, David Ahern a écrit :
>> On 9/13/23 8:11 AM, Nicolas Dichtel wrote:
>>> The compat_mode was introduced for daemons that doesn't support the nexthop
>>> framework. There must be a notification (RTM_DELROUTE) when a route is deleted
>>> due to a carrier down event. Right now, the backward compat is broken.
>>
>> The compat_mode is for daemons that do not understand the nexthop id
>> attribute, and need the legacy set of attributes for the route - i.e,
> Yes, it's my point.
> On my system, one daemon understands and configures nexthop id and another one
> doesn't understand nexthop id. This last daemon removes routes when an interface
> is put down but not when the carrier is lost.
> The kernel doc [1] says:
> 	Further, updates or deletes of a nexthop configuration generate route
> 	notifications for each fib entry using the nexthop.
> So, my understanding is that a RTM_DELROUTE msg should be sent when a nexthop is
> removed due to a carrier lost event.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/ip-sysctl.rst#n2116

I dug a bit more about these (missing) notifications. I will try to describe
what should be done for cases where there is no notification:

When an interface is set down:
 - the single (!multipath) routes associated with this interface should be
   removed;
 - for multipath routes:
   + if all nh use this interface: the routes are deleted;
   + if only some nh uses this interface :
     ~ if all other nh already point to a down interface: the routes are deleted;
     ~ if at least one nh points to an up interface:
       o the nh are *temporarily* disabled if it's a plain nexthop;
       o the nh is *definitely* removed if it's a nexthop object;
When the interface is set up later, disabled nh are restored (ie only plain
nexthop of multipath routes).

When an interface loses its carrier:
 - for routes using plain nexthop: nothing happens;
 - for routes using nexthop objects:
   + for single routes: they are deleted;
   + for multipath routes, the nh is definitely removed if it's a nexthop
     object (ie the route is deleted if there is no other nexthop in the group);
When an interface recovers its carrier, there is nothing to do.

When the last ipv4 address of an interface is removed:
 - for routes using nexthop objects: nothing happens;
 - for routes using plain nexthop: the same rules as 'interface down' applies.
When an ipv4 address is added again on the interface, disabled nh are restored
(ie only plain nexthop of multipath routes).

I bet I miss some cases.

Conclusions:
 - legacy applications (that are not aware of nexthop objects) cannot maintain a
   routing cache (even with compat_mode enabled);
 - fixing only the legacy applications (aka compat_mode) seems too
   complex;
 - even if an application is aware of nexthop objects, the rules to maintain a
   cache are far from obvious.

I don't understand why there is so much reluctance to not send a notification
when a route is deleted. This would fix all cases.
I understand that the goal was to save netlink traffic, but in this case, the
daemons that are interested in maintaining a routing cache have to fully parse
their cache to mark/remove routes. For big routing tables, this will cost a lot
of cpu, so I wonder if it's really a gain for the system. On such systems, there
is probably more than one daemon in this case, so even more cpu to spend for
these operations.

As Thomas said, this discussion has come up for more than a decade. And with the
nexthop objects support, it's even more complex. There is obviously something to do.

At least, I would have expected an RTM_DELNEXTHOP msg for each deleted nexthop.
But this wouldn't solve the routing cache sync for legacy applications.


Regards,
Nicolas

