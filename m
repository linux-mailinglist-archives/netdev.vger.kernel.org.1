Return-Path: <netdev+bounces-17173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA5750B6A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718371C20FFD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402102AB40;
	Wed, 12 Jul 2023 14:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428DA42
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:52:14 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738ED10B
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:52:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so113254431fa.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689173530; x=1691765530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEsEZqyAF5CV0dX25sFVpwrns2MDngxAFs4im1HqwqU=;
        b=0z7yFLyItiNDp711koXJJ4aTbp0rdLle37fAYe0YhbMjdP27PHf9jHKIU52BRdt4z2
         hjAZKjoiQEHb5q5kz+Ek1+hdx3sUZdmaBzLtd89DL13lBjOw9wQQV+yoKrvbfNXFmxfh
         Jk4kH6P2eN1yneoCJAHHFwoND1FkGzXiiEU1o1QnW6/LB/zzonyGfvK5OU+sVptxz0EW
         OCmTYqsqNvVF+VSL4YU8wooryaVmfUbHdxEdoexMojQ50mDYJVRIJ4W6CSi86DBrxHQE
         asx8W9vjMFRahGC7446wCZAdcdOkCOXORgLMHMiPJlyP03Sj8I+XdE+hALWVkO7AYGtc
         6WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173530; x=1691765530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEsEZqyAF5CV0dX25sFVpwrns2MDngxAFs4im1HqwqU=;
        b=i7b4s6seeCVdU2vn1yD/guTKpR1A46v+I9uo9nxgqXob6u/LpXB6a1P6/TjUk0nTyP
         pSu1VohzT7+hc9aJ6/7yRYQZeBd8kkGtRlskyxPy4x64p9LpBj1QuYGPY+QdDxTgAfmx
         Do/BTV4bNi7ffU6lyF2MCVYKBS+GKosMdZHDdDOJN8Uaug18nSWxOQav5VKAAamwKou9
         0xOTA5se1ExnhDyZT/JGcpPebiizxzDQ4yyOVhXx7I/PixFCXvapMj32kAhHUScWqfXX
         Tjy6ookeSboWLEdNBNzo6OATJTTh4uKbrUsxoWXy8gDeaUXfGggoK0w05yS7+X35HGg2
         mg5Q==
X-Gm-Message-State: ABy/qLYV7AZpTtDL5UDmaFFs5LSlu7S+twHMqDqw5OIt1bRxbxXfHrWP
	RxgDqqxSlBoM3FVaLp9/cY2cVA==
X-Google-Smtp-Source: APBJJlFiZlYYBC+lbUER5z8Ofdv4m8A4Fb++MFYv8XoP6QA5GOJPaRibDc6UsucUQ/NabgMZPa24pw==
X-Received: by 2002:a05:651c:102f:b0:2b5:85a9:7e9b with SMTP id w15-20020a05651c102f00b002b585a97e9bmr19105711ljm.33.1689173530431;
        Wed, 12 Jul 2023 07:52:10 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906b21200b00992e265a22dsm2637433ejz.136.2023.07.12.07.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:52:10 -0700 (PDT)
Message-ID: <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
Date: Wed, 12 Jul 2023 17:52:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 net] bridge: Return an error when enabling STP in
 netns.
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 Harry Coin <hcoin@quietfountain.com>
References: <20230711235415.92166-1-kuniyu@amazon.com>
 <ZK69NDM60+N0TTFh@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZK69NDM60+N0TTFh@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/07/2023 17:48, Ido Schimmel wrote:
> On Tue, Jul 11, 2023 at 04:54:15PM -0700, Kuniyuki Iwashima wrote:
>> When we create an L2 loop on a bridge in netns, we will see packets storm
>> even if STP is enabled.
>>
>>   # unshare -n
>>   # ip link add br0 type bridge
>>   # ip link add veth0 type veth peer name veth1
>>   # ip link set veth0 master br0 up
>>   # ip link set veth1 master br0 up
>>   # ip link set br0 type bridge stp_state 1
>>   # ip link set br0 up
>>   # sleep 30
>>   # ip -s link show br0
>>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>>       RX: bytes  packets  errors  dropped missed  mcast
>>       956553768  12861249 0       0       0       12861249  <-. Keep
>>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>>       1027834    11951    0       0       0       0         <-'   rapidly
>>
>> This is because llc_rcv() drops all packets in non-root netns and BPDU
>> is dropped.
>>
>> Let's show an error when enabling STP in netns.
>>
>>   # unshare -n
>>   # ip link add br0 type bridge
>>   # ip link set br0 type bridge stp_state 1
>>   Error: bridge: STP can't be enabled in non-root netns.
>>
>> Note this commit will be reverted later when we namespacify the whole LLC
>> infra.
>>
>> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
>> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> 
> I'm not sure that's accurate. I read his response in the link below and
> he says "I'd rather be warned than blocked" and "But better warned and
> awaiting a fix than blocked", which I agree with. The patch has the
> potential to cause a lot of regressions, but without actually fixing the
> problem.
> 
> How about simply removing the error [1]? Since iproute2 commit
> 844c37b42373 ("libnetlink: Handle extack messages for non-error case"),
> it can print extack warnings and not only errors. With the diff below:
> 
>  # unshare -n 
>  # ip link add name br0 type bridge
>  # ip link set dev br0 type bridge stp_state 1
>  Warning: bridge: STP can't be enabled in non-root netns.
>  # echo $?
>  0
> 
> [1]
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index a807996ac56b..b5143de37938 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,10 +201,8 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>         ASSERT_RTNL();
>  
> -       if (!net_eq(dev_net(br->dev), &init_net)) {
> +       if (!net_eq(dev_net(br->dev), &init_net))
>                 NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> -               return -EINVAL;
> -       }
>  
>         if (br_mrp_enabled(br)) {
>                 NL_SET_ERR_MSG_MOD(extack,
> 

I'd prefer this approach to changing user-visible behaviour and potential regressions.
Just change the warning message.

Thanks,
 Nik


