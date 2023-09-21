Return-Path: <netdev+bounces-35442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159137A986C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21811C21103
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CB15495;
	Thu, 21 Sep 2023 17:22:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7122BE71
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:22:15 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C2B42C2A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:13:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1620427e87.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695316408; x=1695921208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pywDHr26aMIdNlh92ssNp5yeq0EGO9N0Av0l9CJtRTM=;
        b=ngil3R18lO/KauFPdcDDE1ueUz32BhZlMqsdaNgQzl82MoNDHhfvkdzGBcXCZgAZXP
         MvvbW3llT5YfEvHq0fFRsNeNndVYxci8dRCCdo+Ocx8Rnjn/AkKa6XNyG/zj7VDzHzMe
         uSuzLSokhuiWVmNEC5+e1ujDIKm0CmxOI0IXX75u+v85QRuhx3YMbCIs1Mm6+Czpbbs3
         ZwzsTazYXO8xvAqiCRS/Avt+tiaN4YE9WsjHxBCWLNwM5OQk9caiut/JLHMj4Io2vtCU
         IMl2Bvk7IjNLPsiEMbybaOoaU0YuiAW6giBXUoVp3i3OPvuhYjp9V7jnoNBIdsrro9Z6
         bzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316408; x=1695921208;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pywDHr26aMIdNlh92ssNp5yeq0EGO9N0Av0l9CJtRTM=;
        b=Z45pPvy4Fbmz5IUJm13vmr/KcWrO1rbU7xTr6HLiH/U2WKrI4/wxz33NDGG2RJmW8A
         HPAAuxtwI7qUkk/CeU1WowW+vs+jbEPZtaT91yd/qSNe8VrGGBYxpcJzj0frHS9GnRYi
         765nPYWoY5+dJHMHO77UsQr/y/us20HxIvUjREXCFFsF3urGiK7la5TtPBWHwNS1+Bp7
         j+39nyoaJ+nfeE2Yfc4BHJRL1AxT+gN1t4Azzn2GIWJIwL9JJLlT7acqmdH0wP/8rmCW
         FjjIaCk6969xZ551HQlJRD2BrqzELgPqVzqBV+rewDfvBpVMhelGIQ8rGdfrH7QB+e/w
         0rCQ==
X-Gm-Message-State: AOJu0YzcvCxqYegE/OC3r5YhkbP/sO8RLdHlybWNR7o8CBQFaUmetfAY
	tDiAmDvPKAumdvyXK4e6Ge/jrl4SSFGTU1JJJM8PdJfC
X-Google-Smtp-Source: AGHT+IFUh8Z6+6dwNLbxx67rrWJIEXMVs5stNBlOW661Y3biNTu5BIifVeQlIvAWerbPmTitQNmJ2g==
X-Received: by 2002:a17:906:2088:b0:9ae:3d8e:b635 with SMTP id 8-20020a170906208800b009ae3d8eb635mr4348407ejq.24.1695300707453;
        Thu, 21 Sep 2023 05:51:47 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b009ae54eba5casm998745ejd.102.2023.09.21.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:51:47 -0700 (PDT)
Message-ID: <6d06e629-3d6b-98dc-fecc-c5336c434d81@blackwall.org>
Date: Thu, 21 Sep 2023 15:51:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 4/6] net: bridge: Add netlink knobs for number
 / max learned FDB entries
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
 <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
In-Reply-To: <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/23 15:41, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
>> The previous patch added accounting and a limit for the number of
>> dynamically learned FDB entries per bridge. However it did not provide
>> means to actually configure those bounds or read back the count. This
>> patch does that.
>>
>> Two new netlink attributes are added for the accounting and limit of
>> dynamically learned FDB entries:
>>   - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>>     a single bridge.
>>   - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>>     the bridge.
>>
>> The new attributes are used like this:
>>
>>   # ip link add name br up type bridge fdb_max_learned 256
>>   # ip link add name v1 up master br type veth peer v2
>>   # ip link set up dev v2
>>   # mausezahn -a rand -c 1024 v2
>>   0.01 seconds (90877 packets per second
>>   # bridge fdb | grep -v permanent | wc -l
>>   256
>>   # ip -d link show dev br
>>   13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>>       [...] fdb_n_learned 256 fdb_max_learned 256
>>
>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>> ---
>>   include/uapi/linux/if_link.h |  2 ++
>>   net/bridge/br_netlink.c      | 15 ++++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
[snip]
>> @@ -1670,7 +1680,10 @@ static int br_fill_info(struct sk_buff *skb, 
>> const struct net_device *brdev)
>>           nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
>>                  br->topology_change_detected) ||
>>           nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
>> -        nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
>> +        nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
>> +        nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
>> +            atomic_read(&br->fdb_n_learned)) ||
>> +        nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
>>           return -EMSGSIZE;
>>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>>
> 
> Actually you're using atomic for counting, but using a u32 for the 
> limit, you should cap it because the count can overflow. Or you should
> use atomic64 for the counting.
> 

Scratch all that, I'm speaking nonsense. Need to refresh my mind. :)
EVerything's alright. Sorry for the noise.


