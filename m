Return-Path: <netdev+bounces-17063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8114750079
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966271C20F4A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B9D314;
	Wed, 12 Jul 2023 07:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4920F2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:53:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EFE6F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689148426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0SiqzwS4fEBLmP2ldMEOEFGJF5rw9/0euMJNYfhfYs=;
	b=jSa8kszSQrLcZ+RHfYjpFDbuMIMzM8b1iu6EQJOHoFS64MIDsxb+XIt+rV0JW0ExjB65Pk
	F6ng43PdUNsVxOSJcYmIsVR+GMxmP9aNyYFISBlmt8tKEj1teFGhF9h9TFqRRd3LnDp9lf
	dOcknkkD+LkXWzgXxvHM2OUERcfZqsQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-SMzK_m7ZOQieeBgwXYY1uw-1; Wed, 12 Jul 2023 03:53:44 -0400
X-MC-Unique: SMzK_m7ZOQieeBgwXYY1uw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7659c6caeaeso882428585a.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689148424; x=1691740424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0SiqzwS4fEBLmP2ldMEOEFGJF5rw9/0euMJNYfhfYs=;
        b=DA6K0zMf21Yw4D19lQ4+g5VLNMuu0UwRve2G7khQiUuIVvx+u0dRa7G81bWjiDTrCK
         h/SfyNv4y9BUtaD8vrAenj2JFQS2grvIkjdsWskhzZeRYiUoHH+Pdn+zaypQqa+6l14a
         21TwdEs3nVRj17QtiVwOEHhtbgsnGG5oTQ9SYleb2c+3uq2cyQw5cFElE93mhNDzkIjL
         4P5S9I4rU8ZSR+p+kOl5QV+fjCX6gzMqHM2XBaeQAeYAyFjVGXfvpwivPfJdSSKoQq5+
         kWV1bPtHUKCcjSwSbUi3DgP3ky4MByZJVs+TK1c2eav4AJr5OVOu03bB5ZqGYJ1nf8Ye
         CuTA==
X-Gm-Message-State: ABy/qLZfmntWnZ0m4MAKLFdIoPpSx4QG+2F+IpcquOWpcYnwwaqn5vR6
	Nno2wzgfiQP4kQV+Q2UulnulzN9Iz1Jua0tXdr4A6RvgtYYb3UU0Tg92S2chlFxgoIJX3KgCH0h
	cjP1CyfJsGW3keVVp
X-Received: by 2002:a05:620a:2486:b0:767:e0c0:baaa with SMTP id i6-20020a05620a248600b00767e0c0baaamr5122854qkn.76.1689148424064;
        Wed, 12 Jul 2023 00:53:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsNpkeXDw33tz+nvaRoKU7kK2TDCyRQts7+nOo/UbQOtXANvYHI1esf0YU/xF492whaGsiYA==
X-Received: by 2002:a05:620a:2486:b0:767:e0c0:baaa with SMTP id i6-20020a05620a248600b00767e0c0baaamr5122849qkn.76.1689148423817;
        Wed, 12 Jul 2023 00:53:43 -0700 (PDT)
Received: from [192.168.0.136] ([139.47.72.15])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a128d00b00767cb5beda2sm1945563qki.125.2023.07.12.00.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 00:53:43 -0700 (PDT)
Message-ID: <9206d5e6-bdea-8ebf-aa80-6f996ba53c28@redhat.com>
Date: Wed, 12 Jul 2023 09:53:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>, Eric Garver <eric@garver.life>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eelco Chaudron <echaudro@redhat.com>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life> <f7tr0plgpzb.fsf@redhat.com>
 <ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
 <6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
 <20230707080025.7739e499@kernel.org>
 <eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
 <dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
 <20230707150610.4e6e1a4d@kernel.org>
 <096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
 <ZKxMJOdz8LoAA-A5@egarver-thinkpadt14sgen1.remote.csb>
 <f7tpm4ych1b.fsf@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7tpm4ych1b.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/11/23 22:46, Aaron Conole wrote:
> Eric Garver <eric@garver.life> writes:
> 
>> On Mon, Jul 10, 2023 at 06:51:19PM +0200, Ilya Maximets wrote:
>>> On 7/8/23 00:06, Jakub Kicinski wrote:
>>>> On Fri, 7 Jul 2023 18:04:36 +0200 Ilya Maximets wrote:
>>>>>>> That already exists, right? Johannes added it in the last release for WiFi.
>>>>>>
>>>>>> I'm not sure.  The SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE behaves similarly
>>>>>> to that on a surface.  However, looking closer, any value that can be passed
>>>>>> into ieee80211_rx_handlers_result() and ends up in the kfree_skb_reason() is
>>>>>> kind of defined in net/mac80211/drop.h, unless I'm missing something (very
>>>>>> possible, because I don't really know wifi code).
>>>>>>
>>>>>> The difference, I guess, is that for openvswitch values will be provided by
>>>>>> the userpsace application via netlink interface.  It'll be just a number not
>>>>>> defined anywhere in the kernel.  Only the subsystem itself will be defined
>>>>>> in order to occupy the range.  Garbage in, same garbage out, from the kernel's
>>>>>> perspective.
>>>>>
>>>>> To be clear, I think, not defining them in this particular case is better.
>>>>> Definition of every reason that userspace can come up with will add extra
>>>>> uAPI maintenance cost/issues with no practical benefits.  Values are not
>>>>> going to be used for anything outside reporting a drop reason and subsystem
>>>>> offset is not part of uAPI anyway.
>>>>
>>>> Ah, I see. No, please don't stuff user space defined values into
>>>> the drop reason. The reasons are for debugging the kernel stack
>>>> itself. IOW it'd be abuse not reuse.
>>>
>>> Makes sense.  I wasn't sure that's a good solution from a kernel perspective
>>> either.  It's better than defining all these reasons, IMO, but it's not good
>>> enough to be considered acceptable, I agree.
>>>
>>> How about we define just 2 reasons, e.g. OVS_DROP_REASON_EXPLICIT_ACTION and
>>> OVS_DROP_REASON_EXPLICIT_ACTION_WITH_ERROR (exact names can be different) ?
>>> One for an explicit drop action with a zero argument and one for an explicit
>>> drop with non-zero argument.
>>>
>>> The exact reason for the error can be retrieved by other means, i.e by looking
>>> at the datapath flow dump or OVS logs/traces.
>>>
>>> This way we can give a user who is catching packet drop traces a signal that
>>> there was something wrong with an OVS flow and they can look up exact details
>>> from the userspace / flow dump.
>>>
>>> The point being, most of the flows will have a zero as a drop action argument,
>>> i.e. a regular explicit packet drop.  It will be hard to figure out which flow
>>> exactly we're hitting without looking at the full flow dump.  And if the value
>>> is non-zero, then it should be immediately obvious which flow is to blame from
>>> the dump, as we should not have a lot of such flows.
>>>
>>> This would still allow us to avoid a maintenance burden of defining every case,
>>> which are fairly meaningless for the kernel itself, while having 99% of the
>>> information we may need.
>>>
>>> Jakub, do you think this will be acceptable?
>>>
>>> Eric, Adrian, Aaron, do you see any problems with such implementation?
>>
>> I see no problems. I'm content with this approach.
> 
> +1

Sounds like a good plan. Thanks.

> 
>>> P.S. There is a plan to add more drop reasons for other places in openvswitch
>>>       module to catch more regular types of drops like memory issues or upcall
>>>       failures.  So, the drop reason subsystem can be extended later.
>>>       The explicit drop action is a bit of an odd case here.
>>>
>>> Best regards, Ilya Maximets.
>>>
> 


