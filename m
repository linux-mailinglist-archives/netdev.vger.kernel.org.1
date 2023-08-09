Return-Path: <netdev+bounces-25696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9677531D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D6B281A5D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A97F3;
	Wed,  9 Aug 2023 06:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE6525F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:47:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51EE1BFB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691563636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62kh1muVPq2ybyDW9o1R5THvakNvh+7hOpgYo1mhebo=;
	b=QxMaVrI+8D0xwRm+XyOrGJtp2QH1oPZCz0gTG9XvtYPyuSg1Jao4otCkxeUDW+C/IxSR2S
	tpXskw+yYXRCFkwPXMYirmqRIlCXAHdUT0AbXHi+qEAOLmKDhspc81wfe+dnxSWJMadYdj
	p/3kcnpWQMaki9YgRQKUC7uZqJYsfNU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-BBlbtR0XMgmlX2ZVpxvgqQ-1; Wed, 09 Aug 2023 02:47:15 -0400
X-MC-Unique: BBlbtR0XMgmlX2ZVpxvgqQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9ba719605so73613751fa.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563634; x=1692168434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62kh1muVPq2ybyDW9o1R5THvakNvh+7hOpgYo1mhebo=;
        b=W0rmyL+v1fzU10L6ZWdSwD65J0V+cZMOJNS7Xa1dJZY5v9duROxOw9sEAp0Pc+FZvq
         r2/8rNkfqdO/8fSJOs8qz1bVwln63VFJFMcOFNBRKzr2YmFlejiFLv5tAgdR8CqPwCPp
         EjgjuB1yvSDZKe8g120eXwZOLvOmk+K5QaKS1sdZ6nlwkgCPC7ngQcqjjay73Mc4/2dT
         5IWLDCg9ikhQEwgD35VYZ7gF14H8UJlZ7eJUyaaroT7y75P/7t1A7cYGBip1jD6Wz9io
         e9RLAw/A3Ticgdk003jYvlLqTwex6+nZuUXn5KbHzTbDab3WlwHcc9v0H4XzBNblMGXu
         ageg==
X-Gm-Message-State: AOJu0Yyt3hQyTpXaTM3Jss3yfZZcNiHxLmVbSeCsP7K0KvWSQhzR+G6O
	muju+X2pCbQGhQYOjmgbbjDpPXEXogm3xykd9a6s6x33pE3i2gG7SKD3Hrfg8RNwSI8Bff41Jvs
	FEtDDoFwcrARL39MW
X-Received: by 2002:a2e:9d99:0:b0:2b9:5695:d10d with SMTP id c25-20020a2e9d99000000b002b95695d10dmr1012697ljj.36.1691563634089;
        Tue, 08 Aug 2023 23:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/1h+MrqpCPEFEJZ+PCbKHbvR44PFu3+CsbN1cc5UGcxiO0k1/518GgXUKtcUby5D/WADs4w==
X-Received: by 2002:a2e:9d99:0:b0:2b9:5695:d10d with SMTP id c25-20020a2e9d99000000b002b95695d10dmr1012687ljj.36.1691563633731;
        Tue, 08 Aug 2023 23:47:13 -0700 (PDT)
Received: from [192.168.1.131] ([139.47.21.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b003fe601a7d46sm957607wmj.45.2023.08.08.23.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 23:47:13 -0700 (PDT)
Message-ID: <a4dd0cf5-716a-feb9-5ba1-ec09636735a0@redhat.com>
Date: Wed, 9 Aug 2023 08:47:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next v3 1/7] net: openvswitch: add datapath flow drop reason
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: aconole@redhat.com, eric@garver.life, dev@openvswitch.org
References: <20230807164551.553365-1-amorenoz@redhat.com>
 <20230807164551.553365-2-amorenoz@redhat.com>
 <40427d41-dc23-e777-4536-6bd0a8c1cb33@ovn.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <40427d41-dc23-e777-4536-6bd0a8c1cb33@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/8/23 20:02, Ilya Maximets wrote:
> On 8/7/23 18:45, Adrian Moreno wrote:
>> Create a new drop reason subsystem for openvswitch and add the first
>> drop reason to represent flow drops.
>>
>> A flow drop happens when a flow has an empty action-set or there is no
>> action that consumes the packet (output, userspace, recirc, etc).
>>
>> Implementation-wise, most of these skb-consuming actions already call
>> "consume_skb" internally and return directly from within the
>> do_execute_actions() loop so with minimal changes we can assume that
>> any skb that exits the loop normally is a packet drop.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/net/dropreason.h   |  6 ++++++
>>   net/openvswitch/actions.c  | 12 ++++++++++--
>>   net/openvswitch/datapath.c | 16 ++++++++++++++++
>>   net/openvswitch/drop.h     | 24 ++++++++++++++++++++++++
>>   4 files changed, 56 insertions(+), 2 deletions(-)
>>   create mode 100644 net/openvswitch/drop.h
> 
> <snip>
> 
>> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
>> new file mode 100644
>> index 000000000000..cdd10629c6be
>> --- /dev/null
>> +++ b/net/openvswitch/drop.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * OpenvSwitch drop reason list.
>> + */
>> +
>> +#ifndef OPENVSWITCH_DROP_H
>> +#define OPENVSWITCH_DROP_H
>> +#include <net/dropreason.h>
>> +
>> +#define OVS_DROP_REASONS(R)			\
>> +	R(OVS_DROP_FLOW)		        \
> 
> Hi, Adrian.  Not a full review, just complaining about names. :)
> 
> The OVS_DROP_FLOW seems a bit confusing and unclear.  A "flow drop"
> is also a strange term to use.  Maybe we can somehow express in the
> name that this drop reason is used when there are no actions left
> to execute?  e.g. OVS_DROP_NO_MORE_ACTIONS or OVS_DROP_LAST_ACTION
> or OVS_DROP_END_OF_ACTION_LIST or something of that sort?  These may
> seem long, but they are not longer than some other names introduced
> later in the set.  What do yo think?
> 

Hi Ilya,

Thanks for the suggestion. It looks reasonable. I did consider something similar 
but then it felt like having a bit of an "unexpected" or "involuntary" 
connotation. Given that there are other drop reasons that are involutary I 
wanted to somehow differentiate this one from the rest.

Semantically it'd mean something like: When a flow is deliberately installed 
with an empty action list it means "it" (the flow?) _wants_ to drop the packet, 
that's why I ended at that name.

OVS_DROP_LAST_ACTION seems to convey this intentionality as well. I'll can send 
another version changing all names.

Thanks.

-- 
Adrián Moreno


