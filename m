Return-Path: <netdev+bounces-17528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF26751E64
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA1A1C212BB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3EC101EC;
	Thu, 13 Jul 2023 10:07:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022410782
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:07:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B64358B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689242831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeiJEO4/e4/Pi4P4IfUJO/7SFEKkMj+6/FbuO8fjYfY=;
	b=Hu3ngx2kvWRzTOBdNuuKyxxWQXWHKdJEi4jGSjoK0hN8ZMkHNmk9hy6HAZ7zHQyL6LEIqO
	mX0MUlj5gHPlx6gvcNvu6gGH4sxw4yyfwQln3l3kS9xCbN7/eCHNN3l1H1F++RB7picqoO
	6XvgvuS8o+OEzCPmGWv83g+523T32w8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Kat4BbOjNuWpvt_Y5DU45Q-1; Thu, 13 Jul 2023 06:07:10 -0400
X-MC-Unique: Kat4BbOjNuWpvt_Y5DU45Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-992e684089aso38007366b.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242828; x=1691834828;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeiJEO4/e4/Pi4P4IfUJO/7SFEKkMj+6/FbuO8fjYfY=;
        b=iTB43QBkCcncOIhpZPAB0TjObs0O4nuIG126xSZkyN7b5aLzPlTIqqpRHtx8f5GeNn
         ie2/JPOViDMX+4lCsil5vDZxoMRCkEfVwx3oYnaQuRZUlSG1RIVdXNmcvSmliio6EJaL
         Vhrfwladbme2hRBI70WVu1fJBTwjKN7qH0V+XC7KE61hna1o4F4/VprlUhoVBiBhrwYQ
         So4IQ9bIpQAhdacvjoGhoxhfi1vugLpH5ZkmK1nBBrQsJZQK2vJGCRtx1PtC4IMoDIoY
         RxvYO5UNwM7lzuJZd+1TwJ6AMVcrNbVtkNqhdP1X1NSPUCHyh3a0gPHt0MvSYKYifC+5
         nX+Q==
X-Gm-Message-State: ABy/qLanNAgDwaGnR0fpRtlSEZ/2VPbfcQtwaueztDfKNRp5TFJHWF5L
	PSk6opJLuovPHKxBVC9u6ayu3cqBpFCnZDe3VwHMcDTYhgBfAEfos9pFxP1XY7kna7iGXwh+Azu
	dqq7y7solJH2hgfhp
X-Received: by 2002:a17:906:51d1:b0:993:d920:87cb with SMTP id v17-20020a17090651d100b00993d92087cbmr1034494ejk.23.1689242828706;
        Thu, 13 Jul 2023 03:07:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzGyushSXF3bttQVjI1kRPdv0j06kRdrCZSXuj9SmS4floj6HURzhYyVaZ6S2WeIQxiPsOBg==
X-Received: by 2002:a17:906:51d1:b0:993:d920:87cb with SMTP id v17-20020a17090651d100b00993d92087cbmr1034470ejk.23.1689242828333;
        Thu, 13 Jul 2023 03:07:08 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id jo7-20020a170906f6c700b0098e34446464sm3782668ejb.25.2023.07.13.03.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:07:07 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <4b42f2eb-dc29-153e-ace9-5584ea2e5070@redhat.com>
Date: Thu, 13 Jul 2023 12:07:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, netdev@vger.kernel.org, almasrymina@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, edumazet@google.com,
 dsahern@gmail.com, michael.chan@broadcom.com, willemb@google.com,
 Ulrich Drepper <drepper@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, farshin@kth.se
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
 <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
 <20230711170838.08adef4c@kernel.org>
 <28bde9e2-7d9c-50d9-d26c-a3a9d37e9e50@redhat.com>
 <20230712101926.6444c1cc@kernel.org>
In-Reply-To: <20230712101926.6444c1cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12/07/2023 19.19, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 16:00:46 +0200 Jesper Dangaard Brouer wrote:
>> On 12/07/2023 02.08, Jakub Kicinski wrote:
>>>> Generally the pp_provider's will have to use the refcnt schemes
>>>> supported by page_pool.  (Which is why I'm not 100% sure this fits
>>>> Mina's use-case).
>>>>
>>>> [IOTLB details]:
>>>>
>>>> As mentioned on [RFC 08/12] there are other techniques for reducing
>>>> IOTLB misses, described in:
>>>>     IOMMU: Strategies for Mitigating the IOTLB Bottleneck
>>>>      - https://inria.hal.science/inria-00493752/document
>>>>
>>>> I took a deeper look at also discovered Intel's documentation:
>>>>     - Intel virtualization technology for directed I/O, arch spec
>>>>     -
>>>> https://www.intel.com/content/www/us/en/content-details/774206/intel-virtualization-technology-for-directed-i-o-architecture-specification.html
>>>>
>>>> One problem that is interesting to notice is how NICs access the packets
>>>> via ring-queue, which is likely larger that number of IOTLB entries.
>>>> Thus, a high change of IOTLB misses.  They suggest marking pages with
>>>> Eviction Hints (EH) that cause pages to be marked as Transient Mappings
>>>> (TM) which allows IOMMU to evict these faster (making room for others).
>>>> And then combine this with prefetching.
>>>
>>> Interesting, didn't know about EH.
>>
>> I was looking for a way to set this Eviction Hint (EH) the article
>> talked about, but I'm at a loss.
> 
> Could possibly be something that the NIC has to set inside the PCIe
> transaction headers? Like the old cache hints that predated DDIO?
> 

Yes, perhaps it is outdated?

>>>> In this context of how fast a page is reused by NIC and spatial
>>>> locality, it is worth remembering that PP have two schemes, (1) the fast
>>>> alloc cache that in certain cases can recycle pages (and it based on a
>>>> stack approach), (2) normal recycling via the ptr_ring that will have a
>>>> longer time before page gets reused.
>>>
>>> I read somewhere that Intel IOTLB can be as small as 256 entries.
>>
>> Are IOTLB hardware different from the TLB hardware block?

Anyone knows this?

>> I can find data on TLB sizes, which says there are two levels on Intel,
>> quote from "248966-Software-Optimization-Manual-R047.pdf":
>>
>>    Nehalem microarchitecture implements two levels of translation
>> lookaside buffer (TLB). The first level consists of separate TLBs for
>> data and code. DTLB0 handles address translation for data accesses, it
>> provides 64 entries to support 4KB pages and 32 entries for large pages.
>> The ITLB provides 64 entries (per thread) for 4KB pages and 7 entries
>> (per thread) for large pages.
>>
>>    The second level TLB (STLB) handles both code and data accesses for
>> 4KB pages. It support 4KB page translation operation that missed DTLB0
>> or ITLB. All entries are 4-way associative. Here is a list of entries
>> in each DTLB:
>>
>>    • STLB for 4-KByte pages: 512 entries (services both data and
>> instruction look-ups).
>>    • DTLB0 for large pages: 32 entries.
>>    • DTLB0 for 4-KByte pages: 64 entries.
>>
>>    An DTLB0 miss and STLB hit causes a penalty of 7cycles. Software only
>> pays this penalty if the DTLB0 is used in some dispatch cases. The
>> delays associated with a miss to the STLB and PMH are largely nonblocking.
> 
> No idea :( This is an old paper from Rolf in his Netronome days which
> says ~Sandy Bridge had only IOTLB 64 entries:
> 
> https://dl.acm.org/doi/pdf/10.1145/3230543.3230560
> 
Title: "Understanding PCIe performance for end host networking"

> But it's a pretty old paper.

I *HIGHLY* recommend this paper, and I've recommended it before [1].

  [1] 
https://lore.kernel.org/all/b8fa06c4-1074-7b48-6868-4be6fecb4791@redhat.com/

There is a very new (May 2023) publication[2].
  - Title: Overcoming the IOTLB wall for multi-100-Gbps Linux-based 
networking
  - By Luigi Rizzo (netmap inventor) and Alireza Farshin (author of prev 
paper).
  - [2] https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10280580/

There are actually benchmarking page_pool and are suggesting using 2MiB
huge-pages, which you just implemented for page_pool.
p.s. pretty cool to see my page_pool design being described in such 
details and with a picture [3]/

  [3] 
https://www.ncbi.nlm.nih.gov/core/lw/2.0/html/tileshop_pmc/tileshop_pmc_inline.html?title=Click%20on%20image%20to%20zoom&p=PMC3&id=10280580_peerj-cs-09-1385-g020.jpg

> 
>>> So it seems pretty much impossible for it to cache accesses to 4k
>>> pages thru recycling. I thought that even 2M pages will start to
>>> be problematic for multi queue devices (1k entries on each ring x
>>> 32 rings == 128MB just sitting on the ring, let alone circulation).
>>>    
>>
>> Yes, I'm also worried about how badly these NIC rings and PP ptr_ring
>> affects the IOTLB's ability to cache entries.  Why I suggested testing
>> out the Eviction Hint (EH), but I have not found a way to use/enable
>> these as a quick test in your environment.
> 
> FWIW the first version of the code I wrote actually had the coherent
> ring memory also use the huge pages - the MEP allocator underlying the
> page pool can be used by the driver directly to allocate memory for
> other uses than the page pool.
> 
> But I figured that's going to be a nightmare to upstream, and Alex said
> that even on x86 coherent DMA memory is just write combining not cached
> (which frankly IDK why, possibly yet another thing we could consider
> optimizing?!)
> 
> So I created two allocators, one for coherent (backed by 2M pages) and
> one for non-coherent (backed by 1G pages).

I think it is called Coherent vs Streaming DMA.

> 
> For the ptr_ring I was considering bumping the refcount of pages
> allocated from outside the 1G pool, so that they do not get recycled.
> I deferred optimizing that until I can get some production results.
> The extra CPU cost of loss of recycling could outweigh the IOTLB win.
> 
> All very exciting stuff, I wish the days were slightly longer :)
> 

Know the problem of (human) cycles in a day.
Rizzo's article describes a lot of experiments, that might save us/you 
some time.

--Jesper



