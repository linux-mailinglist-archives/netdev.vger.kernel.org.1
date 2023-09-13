Return-Path: <netdev+bounces-33577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E879EAA6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249F828197A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA721F172;
	Wed, 13 Sep 2023 14:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2721F171
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:12:02 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8B7D96
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401b5516104so72742445e9.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694614319; x=1695219119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=naGHmVDETIxSXm7k6tA6RCbCjEsrDrhKR8C3URMzsMM=;
        b=BXkfOhIRB2KpP6jYIO48cZHvK+WbTNJbmtKJ4NniDjaKNaQkosUpHp5Lp7Kr68D1OC
         VTH0QtKSYHRDkcHDLWIzZb2B0qrdzrumMLCaU02AewI5FQQJFJUBuCLOnktw4y9Q/1I3
         FHYAE8QX2y8pwsPgKCe2P7ohg7iR/tcViceSOhKogcrRzIzXPq4sy4iNEUSLPZsad5iS
         lOW+U7tyKQuxX4w4yd7WOydCsDZ4HWnRXa6VICAOv0yL6LgU6Gp5WSGmj8B4i28HOKxc
         GWeqkzCfJ0ZI0JS1cb+FQt50dQQT2ArMENzw7fdnDlLLqnhOJBurf1Ui5i80OI6+ZFA7
         AnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614319; x=1695219119;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naGHmVDETIxSXm7k6tA6RCbCjEsrDrhKR8C3URMzsMM=;
        b=Ben+RSsdMapJodj7+iJYskqOQubipcWEpfdKosJ89X+KIHGzTJd4JWolSNNzpzGSeh
         VJoY8goHiemujycJdWxxGGGXnc4VfeGhFoXmN6FN0cb344Jinc2cpgbSuiTeUDQv2NIO
         CdWy8STC5tSZY476Ku5xhzzbzoFZZzD4DXBM+MxZ1QZ+gcxSypisaaAf67lwoaLATg/x
         ZBYHbGgJZhirEGqLguHWTMmaXH+m/1FoLspoTLOKaUjsZDz+P20hgbiYF1pSyzJOWO3W
         Als/SJ6M/y2pq0I1XWHZBqkts2JtaDJ84v+B3eYYoPXL9SkuE+ukB6R0Dk20psBCB130
         XAFA==
X-Gm-Message-State: AOJu0YxULhm6GMrZgR+YpAEXbo6GG4eFiUXBwVt3hKtjbsQgCv+DAeSZ
	4VyFdEf3UKs8+KkLuprtpPH9sg==
X-Google-Smtp-Source: AGHT+IHPFDmzh9dM51hIxUTHuFdylVzR/A3AxyKlkXd1HdxIKtjTU6DsWQsn6HVtXBUlrhaTEyAEcg==
X-Received: by 2002:a05:600c:2814:b0:402:8896:cf09 with SMTP id m20-20020a05600c281400b004028896cf09mr2294433wmb.9.1694614318974;
        Wed, 13 Sep 2023 07:11:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:fde6:545:ec1d:c8f4? ([2a01:e0a:b41:c160:fde6:545:ec1d:c8f4])
        by smtp.gmail.com with ESMTPSA id x11-20020a05600c21cb00b003feff926fc5sm2175810wmj.17.2023.09.13.07.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:11:58 -0700 (PDT)
Message-ID: <e2b57bea-fb14-cef4-315a-406f0d3a7e4f@6wind.com>
Date: Wed, 13 Sep 2023 16:11:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Reply-To: nicolas.dichtel@6wind.com
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Thomas Haller <thaller@redhat.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
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
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZQGG8xqt8m3IHS4z@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 13/09/2023 à 11:54, Hangbin Liu a écrit :
> On Wed, Sep 13, 2023 at 09:58:08AM +0200, Nicolas Dichtel wrote:
>> Le 11/09/2023 à 11:50, Thomas Haller a écrit :
>> [snip]
>>> - the fact that it isn't fixed in more than a decade, shows IMO that
>>> getting caching right for routes is very hard. Patches that improve the
>>> behavior should not be rejected with "look at libnl3 or FRR".
>> +1
>>
>> I just hit another corner case:
>>
>> ip link set ntfp2 up
>> ip address add 10.125.0.1/24 dev ntfp2
>> ip nexthop add id 1234 via 10.125.0.2 dev ntfp2
>> ip route add 10.200.0.0/24 nhid 1234
>>
>> Check the config:
>> $ ip route
>> <snip>
>> 10.200.0.0/24 nhid 1234 via 10.125.0.2 dev ntfp2
>> $ ip nexthop
>> id 1234 via 10.125.0.2 dev ntfp2 scope link
>>
>>
>> Set the carrier off on ntfp2:
>> ip monitor label link route nexthop&
>> ip link set ntfp2 carrier off
>>
>> $ ip link set ntfp2 carrier off
>> $ [LINK]4: ntfp2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
>> DOWN group default
>>     link/ether de:ed:02:67:61:1f brd ff:ff:ff:ff:ff:ff
>>
>> => No nexthop event nor route event (net.ipv4.nexthop_compat_mode = 1)
>>
>> 'ip nexthop' and 'ip route' show that the nexthop and the route have been deleted.
>>
>> If the nexthop infra is not used (ip route add 10.200.0.0/24 via 10.125.0.2 dev
>> ntfp2), the route entry is not deleted.
>>
>> I wondering if it is expected to not have a nexthop event when one is removed
>> due to a carrier lost.
>> At least, a route event should be generated when the compat_mode is enabled.
> 
> This thread goes to a long discussion.
> 
> Ido has bringing up this issue[1]. In my patchv2[2] we skipped to send the
> notification as it is deliberate.
The compat_mode was introduced for daemons that doesn't support the nexthop
framework. There must be a notification (RTM_DELROUTE) when a route is deleted
due to a carrier down event. Right now, the backward compat is broken.

> 
> BTW, I'm still looking into the questions you asked in my IPv6 patch[3]. Sorry
> for the late response. I was busy with some other stuff recently.
> 
> [1] https://lore.kernel.org/netdev/ZLlE5of1Sw1pMPlM@shredder/
> [2] https://lore.kernel.org/netdev/20230809140234.3879929-3-liuhangbin@gmail.com/
> [3] https://lore.kernel.org/netdev/bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com/
Thank you for the pointers.


Regards,
Nicolas

