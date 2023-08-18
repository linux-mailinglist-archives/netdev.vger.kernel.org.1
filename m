Return-Path: <netdev+bounces-28805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7E780BDC
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3576B2823DE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4363B4;
	Fri, 18 Aug 2023 12:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD27ED
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:32:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75A3590
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692361971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ATl9txClTeyFS43Gz+BmRqKkfsNzRjUF7Xi3kCKd4M=;
	b=OJD9wMHcmZpSHhJLrdu3I6XUVWfxK5zpNcRsfK3DUFntlU0hQ7rDOQIdA6rKu6y+GAEKXE
	l03AFNgbnFaofzxyPoGH8HYods4gHq6TWQM0Z74mEU2a1ik7reOTlxcAEeP0bxDudjDwDw
	r1e5vo3iAH14KvpCMU5a+jFdkNgUgSs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-udl8ZfDsNZCTtM1W5X7Z3w-1; Fri, 18 Aug 2023 08:32:50 -0400
X-MC-Unique: udl8ZfDsNZCTtM1W5X7Z3w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bebfada8cso52701066b.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692361969; x=1692966769;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ATl9txClTeyFS43Gz+BmRqKkfsNzRjUF7Xi3kCKd4M=;
        b=D9ecGFL/YYyDj4bPnDUiBq3HMuPQamc1kahtAQZPzG5gqwrKaOPoFN9+wWtX8uBpty
         umZt3PVRhiNs8qbfcNXJKOA8Pr15EQJ75/y7sIz46Y1dtk05uiSh0IV7bQBKby+fFdTg
         rEbu902OXqcmCCeluwG2STjYWmbdobA6xs/N8wB72O9T3D0okTwbCkaDsoZ7MEjqBAMt
         ghbWvBvC87Qq29PVFON73yMwPHfs1JWO4JsA27F8nkATlMsD3Rpe/xYyHfW6GQRaA6+P
         S/yRfE0GTEQ6idnF2ORFfT3Ka2LTk2J4N0DrdkVbJBhmuhoeEA5NYt9GiT8PQ1axJIgK
         1vUw==
X-Gm-Message-State: AOJu0YzXsyXqxSJArvXQYkRthXVqMzMbf8rBWB4s1Q1u6R4aC0wf4y89
	bpGWg2wszLuo+ZkbQ56Nl9FcTIBnUo96h66sqDM4PUir/Cuhe1sIyPH9yT7IKHJ0WVI4Lqt6iWW
	2J3oi1f+n1qAQ3RJ5
X-Received: by 2002:a17:907:770f:b0:99b:c845:791d with SMTP id kw15-20020a170907770f00b0099bc845791dmr2188848ejc.76.1692361968872;
        Fri, 18 Aug 2023 05:32:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ApDDkLOafImYFHoqGc8sjCqfJOhxfg/Pc+R5EnT8nlhWHaw7jqeaygQpDirJcWPd7GARbw==
X-Received: by 2002:a17:907:770f:b0:99b:c845:791d with SMTP id kw15-20020a170907770f00b0099bc845791dmr2188834ejc.76.1692361968580;
        Fri, 18 Aug 2023 05:32:48 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906841700b0099ce23c57e6sm1121679ejx.224.2023.08.18.05.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 05:32:47 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <0f77001b-8bd3-f72e-7837-cc0d3485aaf8@redhat.com>
Date: Fri, 18 Aug 2023 14:32:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, netdev@vger.kernel.org, vbabka@suse.cz,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Christoph Lameter <cl@linux.com>,
 roman.gushchin@linux.dev, dsterba@suse.com
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
 <ZNufkkauiS20IIJw@casper.infradead.org>
In-Reply-To: <ZNufkkauiS20IIJw@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 15/08/2023 17.53, Matthew Wilcox wrote:
> On Tue, Aug 15, 2023 at 05:17:36PM +0200, Jesper Dangaard Brouer wrote:
>> For the bulk API to perform efficiently the slub fragmentation need to
>> be low. Especially for the SLUB allocator, the efficiency of bulk free
>> API depend on objects belonging to the same slab (page).
> 
> Hey Jesper,
> 
> You probably haven't seen this patch series from Vlastimil:
> 
> https://lore.kernel.org/linux-mm/20230810163627.6206-9-vbabka@suse.cz/
> 
> I wonder if you'd like to give it a try?  It should provide some immunity
> to this problem, and might even be faster than the current approach.
> If it isn't, it'd be good to understand why, and if it could be improved.

I took a quick look at:
  - 
https://lore.kernel.org/linux-mm/20230810163627.6206-11-vbabka@suse.cz/#Z31mm:slub.c

To Vlastimil, sorry but I don't think this approach with spin_lock will 
be faster than SLUB's normal fast-path using this_cpu_cmpxchg.

My experience is that SLUB this_cpu_cmpxchg trick is faster than spin_lock.

On my testlab CPU E5-1650 v4 @ 3.60GHz:
  - spin_lock+unlock : 34 cycles(tsc) 9.485 ns
  - this_cpu_cmpxchg :  5 cycles(tsc) 1.585 ns
  - locked cmpxchg   : 18 cycles(tsc) 5.006 ns

SLUB does use a cmpxchg_double which I don't have a microbench for.

> No objection to this patch going in for now, of course.
> 


