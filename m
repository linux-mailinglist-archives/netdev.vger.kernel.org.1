Return-Path: <netdev+bounces-17947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2146753B92
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F128202C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E11373D;
	Fri, 14 Jul 2023 13:13:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967013731
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:13:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BBD1B6
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689340400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36HhvwwCwNRISkyKnM/sv2zqdgTqt3zr0Ydeg6lZGjI=;
	b=IJfBXw/v8K9Jz6psuZkLikq/RAOxGtb3Tkv05E8CRRBAaJhM5lAUzqp6Df012BkYiNveNA
	iUeBR7ryXefLa/Vz3y0+WECW8ykUisnrIE4dNQA567zI1e4wyMEK6+DHL/GPTILVmrsKWD
	vQ9rwwBFaP8zHvkdzOi8Il86OQ6Oocc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-lgppSX_xMRCePKizwgJ1Lw-1; Fri, 14 Jul 2023 09:13:19 -0400
X-MC-Unique: lgppSX_xMRCePKizwgJ1Lw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b703d64832so17235561fa.2
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689340397; x=1691932397;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36HhvwwCwNRISkyKnM/sv2zqdgTqt3zr0Ydeg6lZGjI=;
        b=aUzccD+xs80PJIJDSsn9hdj694khCA0gzE047eJlsGwu4EmLmJFEf4bORRR+oyDdxs
         uyYjjSLqlCYu2HUx9ZCBABau9AMLRwv621y0xrhw8pN0UegOxn6/QqXn6DsFFrHcul4h
         LMLsfIYb8k7+EQONZcyL/yE76g1ZaS51sHLVSK9h4guF3SY9XozY2pnGmPlsJou+qwnV
         9KcqztbqHKcFAB2DuVpZZYhrxbK+Wi7u27Ucv+LVQZgotDEKv/qpS8QmCAt3Wfhk/592
         iF7/QK5BDz4DhuceIkvtNytGnK8W4cZr4E0D77XSwztfY/MRBlEepJ/3ypufeXofnvFo
         6LPg==
X-Gm-Message-State: ABy/qLb53sBnTVzZNIBckFBMpUdbFaVdiA4a1p3NqyR6NjPF2D+/8QRA
	MPPB4OuCDJbVj5kwAfwKyKAI/WxQBP9RlsdULFFjKrCZxhlhmP6otdzf1/LWshGhpB6ykAIvjL5
	xiTRUHHAIRcib3uqA
X-Received: by 2002:a05:6512:114e:b0:4f8:5e8b:5ec8 with SMTP id m14-20020a056512114e00b004f85e8b5ec8mr4799848lfg.9.1689340397778;
        Fri, 14 Jul 2023 06:13:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUZKsDBZIffHa15ofyhKzNHwZj9wwVByfwtni8shzuZklgsuym2B+BpTxYpImmZmtelIMblA==
X-Received: by 2002:a05:6512:114e:b0:4f8:5e8b:5ec8 with SMTP id m14-20020a056512114e00b004f85e8b5ec8mr4799812lfg.9.1689340397336;
        Fri, 14 Jul 2023 06:13:17 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id y17-20020aa7c251000000b0050bc4600d38sm5686281edo.79.2023.07.14.06.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:13:16 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
Date: Fri, 14 Jul 2023 15:13:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
 <leon@kernel.org>, Long Li <longli@microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
 <ast@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
 "hawk@kernel.org" <hawk@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
 <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
 <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 14/07/2023 14.51, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>> On 14/07/2023 05.53, Jakub Kicinski wrote:
>>> On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
>>>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>>>> usage.
>>>>
>>>> Get an extra ref count of a page after allocation, so after upper
>>>> layers put the page, it's still referenced by the pool. We can reuse
>>>> it as RX buffer without alloc a new page.
>>>
>>> Please use the real page_pool API from include/net/page_pool.h
>>> We've moved past every driver reinventing the wheel, sorry.
>>
>> +1
>>
>> Quoting[1]: Documentation/networking/page_pool.rst
>>
>>    Basic use involves replacing alloc_pages() calls with the
>> page_pool_alloc_pages() call.
>>    Drivers should use page_pool_dev_alloc_pages() replacing
>> dev_alloc_pages().
>   
> Thank Jakub and Jesper for the reviews.
> I'm aware of the page_pool.rst doc, and actually tried it before this
> patch, but I got lower perf. If I understand correctly, we should call
> page_pool_release_page() before passing the SKB to napi_gro_receive().
> 
> I found the page_pool_dev_alloc_pages() goes through the slow path,
> because the page_pool_release_page() let the page leave the pool.
> 
> Do we have to call page_pool_release_page() before passing the SKB
> to napi_gro_receive()? Any better way to recycle the pages from the
> upper layer of non-XDP case?
> 

Today SKB "upper layers" can recycle page_pool backed packet data/page.

Just use skb_mark_for_recycle(skb), then you don't need 
page_pool_release_page().

I guess, we should update the documentation, mentioning this.

--Jesper



