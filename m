Return-Path: <netdev+bounces-22413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C87675E7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0771C211A9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CB16408;
	Fri, 28 Jul 2023 18:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36721426E
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 18:56:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1D44B0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690570583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j136DvJk7pPXQqotAv++siCTVyBYGjx4gmn9v17BtCI=;
	b=UZyl3yd8hel6/EwAaGZD5hnONbIXhxZBA2FplgPYhsVUUE84wv6W89Wec7vkThZLrKqMbl
	XqGPX605XXo2Dm/banbe7j+z0TPLW2z45JsE1lLt9T5Do6l/gjWLPt6XF0XpikyzM7v+Ji
	3QAXwzj9WeJBOBibqzMTb3A/Ey1qKYg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-Xu2vaDOvPa67bpcvsKmVGg-1; Fri, 28 Jul 2023 14:56:21 -0400
X-MC-Unique: Xu2vaDOvPa67bpcvsKmVGg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-997c891a88dso150732666b.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690570580; x=1691175380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j136DvJk7pPXQqotAv++siCTVyBYGjx4gmn9v17BtCI=;
        b=Subrgc8lwK0PpBHBHjUnkyUtiinBd/RpVACZZWd8ATiWYANimLcQEWcM8Ron66Izio
         TwD/d4OFgKWVhpCT0xtYfQSVTDhghnt9Wcqi4/hFNxcQTPGpa27nG5mwh1eVqfI/Kh+f
         oahQOwnqGXGPL24ndpj0lng7FGtPM+w8SBLLGcH38+O34YSMmhNh1suiDmxaW3LQmDXM
         EXgYptVcht726Lanvg1dKDxihNbMkGmiMzcUc9t2hU41GeWeKfxR8Ke4GPB3MDuy2s33
         RcPCPfM4No2qrRNcMuC5+6oebrHTqPUJWu/uCtW+T8cAPpqh7YtBH+5mhx7CUQvETNLk
         dAuQ==
X-Gm-Message-State: ABy/qLYlvohTqeG/lGpm17tLCFs2WtuoLK4ng2vUOb5MWSc3M78wnRra
	CF4IDZGAgSJgqf6jhOTs9ud382jSRTqmr6CC0uztyLLrtioe8tfQqRYk5N1Dwb13Y4bf5lickBk
	WoKxEAPuD+ozxqGg9GBxdFIX1
X-Received: by 2002:a17:906:190:b0:99b:f59c:9d90 with SMTP id 16-20020a170906019000b0099bf59c9d90mr214538ejb.44.1690570580515;
        Fri, 28 Jul 2023 11:56:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFN9non5w0Caj5CGKAgluRzkS1wq1eVSJuCNx5K8h4CElyHVvmb0FjfijvsW9kBlWeiKwhgRA==
X-Received: by 2002:a17:906:190:b0:99b:f59c:9d90 with SMTP id 16-20020a170906019000b0099bf59c9d90mr214527ejb.44.1690570580148;
        Fri, 28 Jul 2023 11:56:20 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id jt9-20020a170906dfc900b0098dfec235ccsm2348010ejc.47.2023.07.28.11.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 11:56:19 -0700 (PDT)
Message-ID: <076b6063-7bb6-4180-a86b-ce6336a2fa36@redhat.com>
Date: Fri, 28 Jul 2023 20:56:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net:bonding:support balance-alb with openvswitch
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <1a471c1b-b78c-d646-6d9b-5bbb753a2a0b@redhat.com>
 <ZMOusD1BnLXqiUEE@kernel.org>
 <1bfe95c4-80f0-4163-6717-947c37d4f569@redhat.com>
 <ZMQKy7xp8+pf/Bqx@kernel.org>
From: Mat Kowalski <mko@redhat.com>
In-Reply-To: <ZMQKy7xp8+pf/Bqx@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 28/07/2023 20:36, Simon Horman wrote:
> On Fri, Jul 28, 2023 at 02:17:03PM +0200, Mat Kowalski wrote:
>> Hi Simon,
>>
>> Thanks a lot for the pointers, not much experienced with contributing here
>> so I really appreciate. Just a question inline regarding the net vs net-next
>>
>> On 28/07/2023 14:04, Simon Horman wrote:
>>> Hi Mat,
>>>
>>> + Jay Vosburgh <j.vosburgh@gmail.com>
>>>     Andy Gospodarek <andy@greyhouse.net>
>>>     "David S. Miller" <davem@davemloft.net>
>>>     Eric Dumazet <edumazet@google.com>
>>>     Jakub Kicinski <kuba@kernel.org>
>>>     Paolo Abeni <pabeni@redhat.com>
>>>     netdev@vger.kernel.org
>>>
>>>     As per the output of
>>>     ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
>>>     which is the preferred method to determine the CC list for
>>>     Networking patches. LKML can, in general, be excluded.
>>>
>>>> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
>>>> vlan to bridge") introduced a support for balance-alb mode for
>>>> interfaces connected to the linux bridge by fixing missing matching of
>>>> MAC entry in FDB. In our testing we discovered that it still does not
>>>> work when the bond is connected to the OVS bridge as show in diagram
>>>> below:
>>>>
>>>> eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>>>>                         |
>>>>                       bond0.150(mac:eth0_mac)
>>>>                                 |
>>>>                       ovs_bridge(ip:bridge_ip,mac:eth0_mac)
>>>>
>>>> This patch fixes it by checking not only if the device is a bridge but
>>>> also if it is an openvswitch.
>>>>
>>>> Signed-off-by: Mateusz Kowalski <mko@redhat.com>
>>> Hi,
>>>
>>> unfortunately this does not seem to apply to net-next.
>>> Perhaps it needs to be rebased.
>>>
>>> Also.
>>>
>>> 1. For Networking patches, please include the target tree, in this case
>>>      net-next, as opposed to net, which is for fixes, in the subject.
>>>
>>> 	Subject: [PATCH net-next] ...
>> It makes me wonder as in my view this is a fix for something that doesn't
>> work today, not necessarily a new feature. Is net-next still a preferred
>> target?
> Hi Mat,
>
> Certainly there is a discussion to be had on if this is a fix or a feature.
>
> I would argue that it is a feature as it makes something new work
> that did not work before. As opposed to fixing something that worked
> incorrectly.
>
> But there is certainly room for interpretation.
>
Of course, I am not pushing any way as I am perfectly fine with getting 
it only into net-next. An updated patch has already been submitted with 
the tag in subject fixed. Thanks for your input !
>>> 2. Perhaps 'bonding; ' is a more appropriate prefix.
>>>
>>> 	Subject: [PATCH net-next] bonding: ...
>>>
>>> ...
>>>
>>


