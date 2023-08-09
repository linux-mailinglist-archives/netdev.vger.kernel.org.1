Return-Path: <netdev+bounces-25705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10A77536B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD791C2111B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96D443F;
	Wed,  9 Aug 2023 07:03:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F97F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:03:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F54E7D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691564635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+PT749huOPzWp4/bapaR8c3dqxTbRG4HOW9ELd5+zg=;
	b=IH1BqR7s+DaJ+RwKL+tZpfIeujJGD3j/uk8ZC+0RCbkOwHHGjZkihIPCQZMpIvkh0M7m13
	3fahAjB8HCf7dTW6jdW8WIU8l8Yv5ZJ7VVYm+nYI3oCesqNkx/ccLikIlAm+7BABzacuS8
	b6JbE/wCyQ5ZlpIodmmujPoNPgJFZ9U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-cdlYbXElODulWe74VadWGw-1; Wed, 09 Aug 2023 03:03:53 -0400
X-MC-Unique: cdlYbXElODulWe74VadWGw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9bf493456so65960791fa.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691564632; x=1692169432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+PT749huOPzWp4/bapaR8c3dqxTbRG4HOW9ELd5+zg=;
        b=ghdoTTXggTX5Neztc2LNhpaZNpgsYdxlZ1BFjx1ydle7CTKd2UdgeLfvipYa18MAYq
         Z8HUU4FfShAvyzu7s2SmR9GnnOGxQgUJPRNUKqu17dm/PWvmfqEo5L4ayPM3vUA+CwGp
         O7fDLxSQ4JJKXrjvZ0uzlDk+A5IOfsspKhSaChVUr95mYbsKt4WMqANRb4JA6i6V3gam
         89gAg6V9O2L7YSQqJjCqP4ez3/rNKKilhAnxtBFeFob6vyrbwlJ1N6TTbwGHOVMFjUnL
         K+fTr5okohq06qggPl8B4qyWVvvzCGPloCmuur0UYvdLZZch0CXIH2+s2dGm1l6o4Xvr
         /PFg==
X-Gm-Message-State: AOJu0Ywtsm8GQeSo11+HvDghZROPpQhrVkse7bY9q7X9C5ldDvj6kJo2
	6oP6eRzi7mWJ7ueZHA7BPodnh2YpGM1HBgKs2ktZzMuGTL7lDxbfMCXiv49b5VH/3F8+CvRqJ5g
	x4K04crgBda4JZXAe
X-Received: by 2002:a2e:9b8d:0:b0:2b9:581d:73bb with SMTP id z13-20020a2e9b8d000000b002b9581d73bbmr1077430lji.26.1691564631965;
        Wed, 09 Aug 2023 00:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYWsYP6K7vGg8Qh7oeFHahkLV5Nnxm+kdsUK8FiaXB7FT9SiT+MOxTyJ3NTvEyLKyPcioBlA==
X-Received: by 2002:a2e:9b8d:0:b0:2b9:581d:73bb with SMTP id z13-20020a2e9b8d000000b002b9581d73bbmr1077411lji.26.1691564631607;
        Wed, 09 Aug 2023 00:03:51 -0700 (PDT)
Received: from [192.168.1.131] ([139.47.21.132])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fbb1a9586esm1000746wmj.15.2023.08.09.00.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:03:51 -0700 (PDT)
Message-ID: <9d3d0ed6-7d34-711b-85ea-89521fc53eca@redhat.com>
Date: Wed, 9 Aug 2023 09:03:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next v3 3/7] net: openvswitch: add explicit drop action
Content-Language: en-US
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Eric Garver <eric@garver.life>, aconole@redhat.com, dev@openvswitch.org
References: <20230807164551.553365-1-amorenoz@redhat.com>
 <20230807164551.553365-4-amorenoz@redhat.com>
 <d3eb91d9-7ce5-8ac9-e718-4212ab838696@ovn.org>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <d3eb91d9-7ce5-8ac9-e718-4212ab838696@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/8/23 20:10, Ilya Maximets wrote:
> On 8/7/23 18:45, Adrian Moreno wrote:
>> From: Eric Garver <eric@garver.life>
>>
>> From: Eric Garver <eric@garver.life>
>>
>> This adds an explicit drop action. This is used by OVS to drop packets
>> for which it cannot determine what to do. An explicit action in the
>> kernel allows passing the reason _why_ the packet is being dropped or
>> zero to indicate no particular error happened (i.e: OVS intentionally
>> dropped the packet).
>>
>> Since the error codes coming from userspace mean nothing for the kernel,
>> we squash all of them into only two drop reasons:
>> - OVS_DROP_EXPLICIT_ACTION_ERROR to indicate a non-zero value was passed
>> - OVS_DROP_EXPLICIT_ACTION to indicate a zero value was passed (no
>>    error)
>>
>> e.g. trace all OVS dropped skbs
>>
>>   # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
>>   [..]
>>   106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
>>    location:0xffffffffc0d9b462, protocol: 2048, reason: 196611)
>>
>> reason: 196611 --> 0x30003 (OVS_DROP_EXPLICIT_ACTION)
>>
>> Signed-off-by: Eric Garver <eric@garver.life>
>> Co-developed-by: Adrian Moreno <amorenoz@redhat.com>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/uapi/linux/openvswitch.h                     |  2 ++
>>   net/openvswitch/actions.c                            |  9 +++++++++
>>   net/openvswitch/drop.h                               |  2 ++
>>   net/openvswitch/flow_netlink.c                       | 10 +++++++++-
>>   tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  3 +++
>>   5 files changed, 25 insertions(+), 1 deletion(-)
> 
> <snip>
> 
>> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
>> index 3cd6489a5a2b..be51ff5039fb 100644
>> --- a/net/openvswitch/drop.h
>> +++ b/net/openvswitch/drop.h
>> @@ -10,6 +10,8 @@
>>   #define OVS_DROP_REASONS(R)			\
>>   	R(OVS_DROP_FLOW)		        \
>>   	R(OVS_DROP_ACTION_ERROR)		\
>> +	R(OVS_DROP_EXPLICIT_ACTION)		\
>> +	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
> 
> These drop reasons are a bit unclear as well.  Especially since we
> have OVS_DROP_ACTION_ERROR and OVS_DROP_EXPLICIT_ACTION_ERROR that
> mean completely different things while having similar names.
> 
> Maybe remove the 'ACTION' part from these and add a word 'with'?
> E.g. OVS_DROP_EXPLICIT and OVS_DROP_EXPLICIT_WITH_ERROR.  I suppose,
> 'WITH' can also be shortened to 'W'.  It's fairly obvious that
> explicit drops are caused by the explicit drop action.
> 
> What do you think?

Agree: OVS_DROP_EXPLICIT{,_WITH_ERROR} are better names. Thanks!

> 
> Best regards, Ilya Maximets.
> 

-- 
Adrián Moreno


