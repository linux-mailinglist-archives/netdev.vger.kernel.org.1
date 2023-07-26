Return-Path: <netdev+bounces-21252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C7762FF2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB30C281CA3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F438838;
	Wed, 26 Jul 2023 08:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FCAD39
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:34:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF01268B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690360484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/RH08avROXlOzex154AJlI7WBOCJKyaCkixITQWr+s=;
	b=Z0XPt0CnRl49WY6tD+1AlSuE9mH0M7bZIufjEk0xGzEQXTtbpIfuD2hyajCmCJJ1qXTnGN
	HP+TV/4HefKT8n0TVGJMNtn9mIj26pscVzSH+FJtbyrzwT355BvLSVQDA2YxDDJVaq53Rh
	M6y1dSVOp8xrZnWYH62CvGx5vYBdidI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-RcrGfEEfO2aO9UwODcvRVA-1; Wed, 26 Jul 2023 04:34:42 -0400
X-MC-Unique: RcrGfEEfO2aO9UwODcvRVA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3175efd89e4so1425726f8f.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360481; x=1690965281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/RH08avROXlOzex154AJlI7WBOCJKyaCkixITQWr+s=;
        b=WzI8FEHiXMWOi/3dWVX+breZZgFAmuMpjCrMJarIjQzDFUPZREQrDtg6j/5mrHtvLv
         kIrgM7UwLbI7TqgT3699L3ykRf68B+0nH0MTCbhYeCSWVax7xtaB1FdS8ziiEi6WivWa
         A1c+48dldU+4qWsiIhiim5wHVHRwCArUHed9bQCCOOmMjNtdbDC9YE6e302yO1hmoZ4s
         6+NZPyhvUG9RESt9tS/QR6yiW2NwAjnS+762QqEC2g6mL4+HPxEpMJOzHDvxnIT0ag66
         u/rDYnVdbkAsuLwMO7QUcFypcouEPW8EV6HcNMkJSql5GuntipJzenJ5aaHCX/f/kfgp
         llVw==
X-Gm-Message-State: ABy/qLYTgVjWcfqSbkjylvwP78I1SHvsdwo6oVabV3iq1iwcS3F70lrv
	04hgVEbLaLhvnLfLkUHjKEx8LPBoDLEHRzMkpYvNl99S0t1hMyoQs4D6WjpQ+WnjH7bfLbTOAe7
	i5oy0I0CLOST1LMu3enyZMK1v
X-Received: by 2002:adf:f283:0:b0:317:6855:d576 with SMTP id k3-20020adff283000000b003176855d576mr759171wro.30.1690360480938;
        Wed, 26 Jul 2023 01:34:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhrQ4Gte7WRePts+UQ16UOwXqgKM0M7uut8+aRC20cjSS9ioSsVtBHtm0AlfWVPbyiY/CxwQ==
X-Received: by 2002:adf:f283:0:b0:317:6855:d576 with SMTP id k3-20020adff283000000b003176855d576mr759149wro.30.1690360480603;
        Wed, 26 Jul 2023 01:34:40 -0700 (PDT)
Received: from [192.168.1.21] (217.pool92-172-46.dynamic.orange.es. [92.172.46.217])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b0031417fd473csm5801832wru.78.2023.07.26.01.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:34:40 -0700 (PDT)
Message-ID: <aa04a440-1e5f-c39c-a731-b2d4e8dac0e8@redhat.com>
Date: Wed, 26 Jul 2023 10:34:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 0/7] openvswitch: add drop reasons
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, i.maximets@ovn.org,
 eric@garver.life, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230722094238.2520044-1-amorenoz@redhat.com>
 <f7th6ptl6o2.fsf@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7th6ptl6o2.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/23 16:34, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
> 
>> There is currently a gap in drop visibility in the openvswitch module.
>> This series tries to improve this by adding a new drop reason subsystem
>> for OVS.
>>
>> Apart from adding a new drop reasson subsystem and some common drop
>> reasons, this series takes Eric's preliminary work [1] on adding an
>> explicit drop action and integrates it into the same subsystem.
>>
>> This series also adds some selftests and so it requires [2] to be
>> applied first.
>>
>> A limitation of this series is that it does not report upcall errors.
>> The reason is that there could be many sources of upcall drops and the
>> most common one, which is the netlink buffer overflow, cannot be
>> reported via kfree_skb() because the skb is freed in the netlink layer
>> (see [3]). Therefore, using a reason for the rare events and not the
>> common one would be even more misleading. I'd propose we add (in a
>> follow up patch) a tracepoint to better report upcall errors.
> 
> I guess you meant to add RFC tag to this, since it depends on other
> series that aren't accepted yet.
> 

Yep, sorry I should have added RFC tag.

> If it's okay, I will pull in your patch 5/7 when I re-post my flow
> additions series, since it will need to be added there at some point
> anyway.
> 

Sure, please go ahead.

>> [1] https://lore.kernel.org/netdev/202306300609.tdRdZscy-lkp@intel.com/T/
>> [2] https://lore.kernel.org/all/9375ccbc-dd40-9998-dde5-c94e4e28f4f1@redhat.com/T/
>> [3] commit 1100248a5c5c ("openvswitch: Fix double reporting of drops in dropwatch")
>>
>> Adrian Moreno (6):
>>    net: openvswitch: add datapath flow drop reason
>>    net: openvswitch: add meter drop reason
>>    net: openvswitch: add misc error drop reasons
>>    selftests: openvswitch: support key masks
>>    selftests: openvswitch: add drop reason testcase
>>    selftests: openvswitch: add explicit drop testcase
>>
>> Eric Garver (1):
>>    net: openvswitch: add explicit drop action
>>
>>   include/net/dropreason.h                      |   6 +
>>   include/uapi/linux/openvswitch.h              |   2 +
>>   net/openvswitch/actions.c                     |  40 ++++--
>>   net/openvswitch/conntrack.c                   |   3 +-
>>   net/openvswitch/datapath.c                    |  16 +++
>>   net/openvswitch/drop.h                        |  33 +++++
>>   net/openvswitch/flow_netlink.c                |   8 +-
>>   .../selftests/net/openvswitch/openvswitch.sh  |  92 +++++++++++++-
>>   .../selftests/net/openvswitch/ovs-dpctl.py    | 115 ++++++++++++------
>>   9 files changed, 267 insertions(+), 48 deletions(-)
>>   create mode 100644 net/openvswitch/drop.h
> 

-- 
Adrián Moreno


