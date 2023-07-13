Return-Path: <netdev+bounces-17514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71AD751DA7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A68281CBF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6942B100DC;
	Thu, 13 Jul 2023 09:46:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B19100D6
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:46:14 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E42113
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:46:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f96d680399so870952e87.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689241570; x=1691833570;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xN6Kb5J+9QWBrMEWZT5CJCFZg1nR/z1fy+PIOKZtWdg=;
        b=a6sdMqFl1Vm+4kzc9aTSRXzjBVZQx7aAyXLkZpyNTtmfnIqe1uELYtL9rDd9swHhrj
         EFrqpQdKBmN3Yn2p4UnfcjMj4aThh0xqaPyB4jBV42T90NHaqHMBGIe49ugDGT7lV+EO
         DPJ1bZyaM3CU3kiEh8Ox8P0LQoumz9Tv75ko3fXTHR3YH6SkVp0bOBzN11f4D20PZO/h
         q674WDG7yJDmdnWihGZDtxqDwQupnkTyDkTFP8Sd5ytDJyEuPuYu+60XnRwrtsvvWwi/
         6pHZV4F0KW/ijcJuwYiEiFWZbc/YRHPwgNosfhLVfAr5PcoAPC1ecHuFN1KpzS+L5Dno
         MLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241570; x=1691833570;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xN6Kb5J+9QWBrMEWZT5CJCFZg1nR/z1fy+PIOKZtWdg=;
        b=ewxFBU+d4ZibIGAOUofjacy8kmGdVduydzA7I9ANZ3P0U2tG1qRNfbiNpK/gjp7R5x
         e3nfIKOAb/KMEpWWmM6qvGc+Izb3eUA9Dy/+KUDPG8zbVwuibaz02A8rW5//Rzn/LnGD
         leaNajzvQRiMfICeczHSrySS6fkYvlFUj4FFnIBLZ34D5A2MUDm6RvT02tKgTWKn/qie
         d+eToJj63VHa1WiRPIb4+zBKnVpND03o7rbvdnkDkdOpcvBeguhNmr+tblxu/OF6SyB3
         7hBPdreXvViNMNP4Ywk7It1N8qWzBdnaHN6yZqL6vRhKInGJvHJWVujk530+IIicsvpr
         7Qag==
X-Gm-Message-State: ABy/qLYHfMWZmJ1FJDn67LNQm5GSLFdyZJsyjr41ePOhMVGdVyO+u/Dp
	x7/AVdxVMQwZPHptb4iGvQBk8w==
X-Google-Smtp-Source: APBJJlHUOJzuwGo9OC3JAs49N7xR49/3ERb2ro6C6WSUdW7HBaG/5+x3Y+5j8TVtFpulBD3/BAoBkQ==
X-Received: by 2002:ac2:464a:0:b0:4f8:651f:9bbe with SMTP id s10-20020ac2464a000000b004f8651f9bbemr823848lfo.54.1689241570305;
        Thu, 13 Jul 2023 02:46:10 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id u30-20020a056512041e00b004f86673a47dsm1052827lfk.75.2023.07.13.02.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:46:10 -0700 (PDT)
Message-ID: <c8e6c501-7006-d051-872c-3e86cf627ed3@blackwall.org>
Date: Thu, 13 Jul 2023 12:46:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH net-next 3/4] bridge: Add backup nexthop ID support
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, dsahern@gmail.com, petrm@nvidia.com,
 taspelund@nvidia.com
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-4-idosch@nvidia.com>
 <ef77b43d-0b5a-9e5f-640a-5e3c981bd642@blackwall.org>
In-Reply-To: <ef77b43d-0b5a-9e5f-640a-5e3c981bd642@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 12:33, Nikolay Aleksandrov wrote:
> On 13/07/2023 10:09, Ido Schimmel wrote:
>> Add a new bridge port attribute that allows attaching a nexthop object
>> ID to an skb that is redirected to a backup bridge port with VLAN
>> tunneling enabled.
>>
>> Specifically, when redirecting a known unicast packet, read the backup
>> nexthop ID from the bridge port that lost its carrier and set it in the
>> bridge control block of the skb before forwarding it via the backup
>> port. Note that reading the ID from the bridge port should not result in
>> a cache miss as the ID is added next to the 'backup_port' field that was
>> already accessed. After this change, the 'state' field still stays on
>> the first cache line, together with other data path related fields such
>> as 'flags and 'vlgrp':
>>
>> struct net_bridge_port {
>>          struct net_bridge *        br;                   /*     0     8 */
>>          struct net_device *        dev;                  /*     8     8 */
>>          netdevice_tracker          dev_tracker;          /*    16     0 */
>>          struct list_head           list;                 /*    16    16 */
>>          long unsigned int          flags;                /*    32     8 */
>>          struct net_bridge_vlan_group * vlgrp;            /*    40     8 */
>>          struct net_bridge_port *   backup_port;          /*    48     8 */
>>          u32                        backup_nhid;          /*    56     4 */
>>          u8                         priority;             /*    60     1 */
>>          u8                         state;                /*    61     1 */
>>          u16                        port_no;              /*    62     2 */
>>          /* --- cacheline 1 boundary (64 bytes) --- */
>> [...]
>> } __attribute__((__aligned__(8)));
>>
>> When forwarding an skb via a bridge port that has VLAN tunneling
>> enabled, check if the backup nexthop ID stored in the bridge control
>> block is valid (i.e., not zero). If so, instead of attaching the
>> pre-allocated metadata (that only has the tunnel key set), allocate a
>> new metadata, set both the tunnel key and the nexthop object ID and
>> attach it to the skb.
>>
>> By default, do not dump the new attribute to user space as a value of
>> zero is an invalid nexthop object ID.
>>
>> The above is useful for EVPN multihoming. When one of the links
>> composing an Ethernet Segment (ES) fails, traffic needs to be redirected
>> towards the host via one of the other ES peers. For example, if a host
>> is multihomed to three different VTEPs, the backup port of each ES link
>> needs to be set to the VXLAN device and the backup nexthop ID needs to
>> point to an FDB nexthop group that includes the IP addresses of the
>> other two VTEPs. The VXLAN driver will extract the ID from the metadata
>> of the redirected skb, calculate its flow hash and forward it towards
>> one of the other VTEPs. If the ID does not exist, or represents an
>> invalid nexthop object, the VXLAN driver will drop the skb. This
>> relieves the bridge driver from the need to validate the ID.
>>
>> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>> ---
>>   include/uapi/linux/if_link.h |  1 +
>>   net/bridge/br_forward.c      |  1 +
>>   net/bridge/br_netlink.c      | 12 ++++++++++++
>>   net/bridge/br_private.h      |  3 +++
>>   net/bridge/br_vlan_tunnel.c  | 15 +++++++++++++++
>>   net/core/rtnetlink.c         |  2 +-
>>   6 files changed, 33 insertions(+), 1 deletion(-)
>>
[snip]
>> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
>> index 6116eba1bd89..9d7bc8b96b53 100644
>> --- a/net/bridge/br_forward.c
>> +++ b/net/bridge/br_forward.c
>> @@ -154,6 +154,7 @@ void br_forward(const struct net_bridge_port *to,
>>           backup_port = rcu_dereference(to->backup_port);
>>           if (unlikely(!backup_port))
>>               goto out;
>> +        BR_INPUT_SKB_CB(skb)->backup_nhid = READ_ONCE(to->backup_nhid);
>>           to = backup_port;
>>       }
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>> index 05c5863d2e20..10f0d33d8ccf 100644
>> --- a/net/bridge/br_netlink.c
>> +++ b/net/bridge/br_netlink.c
>> @@ -211,6 +211,7 @@ static inline size_t br_port_info_size(void)
>>           + nla_total_size(sizeof(u8))    /* IFLA_BRPORT_MRP_IN_OPEN */
>>           + nla_total_size(sizeof(u32))    /* IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT */
>>           + nla_total_size(sizeof(u32))    /* IFLA_BRPORT_MCAST_EHT_HOSTS_CNT */
>> +        + nla_total_size(sizeof(u32))    /* IFLA_BRPORT_BACKUP_NHID */
>>           + 0;
>>   }
>> @@ -319,6 +320,10 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>>                   backup_p->dev->ifindex);
>>       rcu_read_unlock();
>> +    if (p->backup_nhid &&
>> +        nla_put_u32(skb, IFLA_BRPORT_BACKUP_NHID, p->backup_nhid))
>> +        return -EMSGSIZE;
>> +
> 
> READ_ONCE(), see the comment above backup_port :)
> 

Actually the updates are done with port lock as well.
This should be fine. Patch looks good.




