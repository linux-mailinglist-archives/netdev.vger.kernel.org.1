Return-Path: <netdev+bounces-35549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9A7A9CAB
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9810A282711
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F551259;
	Thu, 21 Sep 2023 18:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDA658BA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:34:25 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D2DAFED
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:32:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31ff985e292so1188255f8f.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695321150; x=1695925950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oet/D+JdIKmqqEXMeGgkoE2/3Tw5UCJOvyH76c8x0dQ=;
        b=WpTZMupDzvXcty3k8+aYHd9Xx31zrMX2CynyyafiiTl2JMB8tsYfvExdaTcpHX3i9V
         UhysCotqCDAjbzkW54ivD/bAGFUyjaAjl5X62IZeW1UUXb33bIUIk0AMRVwcprP21Z9x
         qTheA++YSlm8rTB+2csWu657vJTPVQHAv/jDEneCj4K/myDz55zxi09LOnRWguzizOpP
         PPr4h4kTm8gA4zBVdsUKt/1JTI5U28s2XlOZ/G+R6iCnzyz2eTodTqIAdL8kG4t5f0u5
         e0Aj+h79ZSrW4nW50sDedBOddPWPD9Jq8wLnb0xaWI1PEIEQnDvghLEvBUIlXF4BEQNb
         dXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321150; x=1695925950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oet/D+JdIKmqqEXMeGgkoE2/3Tw5UCJOvyH76c8x0dQ=;
        b=naxrIaygt/6NkQZqYwSYOYETu4Q9VPs9t3clc6iMapSTUlCpCipkqE5Kk0oU6i8k/d
         W4ayNpSHK4esQWN6Spb+35zsroB8yKFP4KtFm51NVb8qw3QU0XWxensCZVXn1lDu3jqQ
         L3qaFOKLNa9JW/Zq8oSpVmtHu8Angg6rG1gCwGUdALjq0v9yTGXpw+jPEe9/JX0IC1iF
         xXtj1Nsl12UV0tVcvIcZ6JO/S6tvHV6yk7+bP6OsGT29cDqkHayhYQM1OxC9qwKZE0g5
         kdI6Hu6YOy2PWl0f4x60ObdREBLB1evsIbFXoGfUkVNxRvlik5rD+gHq66jVxe9ooLck
         Nttg==
X-Gm-Message-State: AOJu0YwkePqfGfG9PKhZ2aylSW4mJHi6/4QWE74s8gcht/62BZewP3OW
	L1cAel8f5smUEOwDRZvr6MD4pj4EVxRH80rJHdLGJr+k
X-Google-Smtp-Source: AGHT+IGSqpABR6NJIutspbmDVZEhOKpxYfh5Gelph+0yVDatq2aZ3E+NWHnq2oOH1AMJw/MFATUt/Q==
X-Received: by 2002:ac2:5b1c:0:b0:503:314f:affe with SMTP id v28-20020ac25b1c000000b00503314faffemr4577024lfn.17.1695291285601;
        Thu, 21 Sep 2023 03:14:45 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b00532c32e2b2dsm622021edb.18.2023.09.21.03.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:14:45 -0700 (PDT)
Message-ID: <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
Date: Thu, 21 Sep 2023 13:14:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 2/6] net: bridge: Set strict_start_type for
 br_policy
Content-Language: en-US
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
 <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
 <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 10:23, Johannes Nixdorf wrote:
> On Wed, Sep 20, 2023 at 01:46:02PM +0300, Nikolay Aleksandrov wrote:
>> On 9/19/23 11:12, Johannes Nixdorf wrote:
>>> Set any new attributes added to br_policy to be parsed strictly, to
>>> prevent userspace from passing garbage.
>>>
>>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>>> ---
>>>    net/bridge/br_netlink.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>>> index 10f0d33d8ccf..505683ef9a26 100644
>>> --- a/net/bridge/br_netlink.c
>>> +++ b/net/bridge/br_netlink.c
>>> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>>>    }
>>>    static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
>>> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
>>> +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
>>>    	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>>>    	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>>>    	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
>>>
>>
>> instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the patch
>> and just use the new attribute name?
>> These are uapi, they won't change.
> 
> I wanted to avoid having a state between the two commits where the new
> attributes are already added, but not yet strictly verified. Otherwise
> they would present a slightly different UAPI at that one commit boundary
> than after this commit.
> 

That's not really a problem, the attribute is the same.

> This is also not the only place in the kernel where strict_start_type
> is specified that way. See e.g. commit c00041cf1cb8 ("net: bridge: Set
> strict_start_type at two policies"), even though that seems mostly be
> done to turn on strict_start_type preemtively, not in the same series
> that adds the new attribute.

Please, just use the new attribute to be more explicit where the strict 
parsing starts.

Thanks,
  Nik



