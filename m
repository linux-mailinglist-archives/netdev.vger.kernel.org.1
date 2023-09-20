Return-Path: <netdev+bounces-35203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22237A7971
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273EE1C20921
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5FF9EB;
	Wed, 20 Sep 2023 10:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0879FA
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:38:48 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D44AC
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:38:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so8557069a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206326; x=1695811126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdSo+Yj9RqpysydqoW13PgqmyUcBvx2Eis/Ti0rFlec=;
        b=O8uno3frTZMddpPEumUm6IKgSwSI0RN0ydfs0QetyNt43sO5Q10L1NRNR0hlDLz7+1
         zcFzWrzoYxXIJEBgtNpoLheXZ8ATK5Y+d4zwmBbV6K2s4POjMeLUd0GRO9dmZXMztELb
         k+2xEtD8SVXw7p2ta1q+qS2d8QijG7PronpTGYnZEgaWVw4SZ/k3StCWMH/B0j5MguBy
         3g183Zp1sPCZ2OU+lU5xIU4nox8nIE4lKk6h9ZdgXVE8zB/hQSQBghaau1PvIdjk7W0B
         aPIvxYeMYtcoJ6ytYw9TNFxw1nsfw9kB89lgPAH0bHB7+NT8C7Na/xVin7bIBq9DlgY0
         NO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206326; x=1695811126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdSo+Yj9RqpysydqoW13PgqmyUcBvx2Eis/Ti0rFlec=;
        b=vi05LBZ+8dfqrCrxHwRbV3lPVEoPywfgQ+q39JAxJzQudfI3U27gOL9aCTHXsW/PT1
         HpZ1Wd2nWbElm2B0ug9VwKEY2TxMLoPzD9D1YKblmjcUqinpoJzknaAVkxZyP3U+G7Uo
         Kmm5xsl3rYcPByOsZp4zimzpLrxDjdeqvXqnV8UWM3KSm+eSXx8Re4klRiTLsXEFjgWd
         qfD7AwVUPTMJs7uSU5qcYwAe8kFsLbUWMlJcoP4zp37mjWunvHdVRROi8XkJXpEZvrPb
         5PllSqk2cQ03IqC551SDnHq7GQWcMdQzw1TSKNN+RBKqk+T6l85nf+zQEJHCL1GV2DDT
         aMlw==
X-Gm-Message-State: AOJu0Yz+ke6Ot/59NXxCFDFOVOSgwctfCsQkinh1eg0YgvO1YldFvNn4
	0zHz49HPglPgtOJw+NLGPt3tUg==
X-Google-Smtp-Source: AGHT+IFehE89tHvs0SlmIuyGhWVwt6FDd+QNohM1Xfis9aQK/Bb6UsCymjX4NSQAWlxdHCs1Rw7DvA==
X-Received: by 2002:a17:906:25b:b0:9ad:e7d8:1e26 with SMTP id 27-20020a170906025b00b009ade7d81e26mr1471526ejl.57.1695206325802;
        Wed, 20 Sep 2023 03:38:45 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906698800b00988dbbd1f7esm9076712ejr.213.2023.09.20.03.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:38:45 -0700 (PDT)
Message-ID: <e6b9ed8b-7044-0fab-a735-fa9cbeeb97c1@blackwall.org>
Date: Wed, 20 Sep 2023 13:38:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC Draft PATCH net-next 0/1] Bridge doc update
To: Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
 <ZQq5NDqPAbwi98yU@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZQq5NDqPAbwi98yU@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 12:19, Hangbin Liu wrote:
> Hi Nikolay, Roopa,
> 
> Do you have any comments for this RFC?
> 
> Thanks
> Hangbin
> On Wed, Sep 13, 2023 at 05:28:52PM +0800, Hangbin Liu wrote:
>> Hi,
>>
>> After a long busy period. I got time to check how to update the bridge doc.
>> Here is the previous discussion we made[1].
>>
>> In this update. I plan to convert all the bridge description/comments to
>> the kernel headers. And add sphinx identifiers in the doc to show them
>> directly. At the same time, I wrote a script to convert the description
>> in kernel header file to iproute2 man doc. With this, there is no need
>> to maintain the doc in 2 places.
>>
>> For the script. I use python docutils to read the rst comments. When dump
>> the man page. I do it manually to match the current ip link man page style.
>> I tried rst2man, but the generated man doc will break the current style.
>> If you have any other better way, please tell me.
>>
>> [1] https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/
>>
>>
>> Hangbin Liu (1):
>>    Doc: update bridge doc
>>
>>   Documentation/networking/bridge.rst |  85 ++++++++++--
>>   include/uapi/linux/if_bridge.h      |  24 ++++
>>   include/uapi/linux/if_link.h        | 194 ++++++++++++++++++++++++++++
>>   3 files changed, 293 insertions(+), 10 deletions(-)
>>
>> -- 
>> 2.41.0
>>

Hi Hangbin,
I support all efforts to improve documentation, but I do share the same 
concerns that Stephen has already voiced. I don't think we should be 
generating the man page from the kernel docs, IMO it would be simpler
and easier for everyone to support both docs - one is for the user-space
iproute2 commands, the other could go into the kernel api details. All
attribute descriptions can still be added to headers, that would be very
valuable on its own. I prefer to have the freedom to change the docs 
format in any way, generating them from comments is kind of limiting.
The purpose of each document is different and it will be difficult
to combine them for a man page. It would be much easier for everyone
to add user-related command descriptions and examples in iproute2's 
documentation, and to add kernel-specific (or uapi) documentation to the
kernel doc. We can add references for each with a short description.
W.r.t the kernel doc topics covered, I think the list is a good start.

Thank you,
  Nik

