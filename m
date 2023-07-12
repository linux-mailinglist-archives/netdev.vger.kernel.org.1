Return-Path: <netdev+bounces-17164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C521750A4A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6551C210DE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BF34CC8;
	Wed, 12 Jul 2023 14:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0334CC5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:01:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F91FD2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689170450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+envmtPY9i9HUFtiXgV4M6siOkLHy/vhKgy6QygKM8=;
	b=O0pJn8zxZbONx7HxI94M5eMftGDY4dfPZ6dcFhJObbOL5DUtgXpKaBVGlzM3pNUGOCWjwP
	mJKR1IkZ4e6R1IEFcx9bMayKdjIH8pmnUxwtkJQJ13ITqovZdTY+YfCUML9EHX4aj5DAum
	dPgvL4tHg1erY8hgsQ9hwYXaEKG+fc8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Q_aB1ZuyNpSgC6DruFO1hQ-1; Wed, 12 Jul 2023 10:00:49 -0400
X-MC-Unique: Q_aB1ZuyNpSgC6DruFO1hQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-994320959f4so17644266b.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170448; x=1691762448;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+envmtPY9i9HUFtiXgV4M6siOkLHy/vhKgy6QygKM8=;
        b=HpTPLJgLV1QRFBsxZ6c8VXnooTOSjlAGQvXIGaMMivc3dw3Sdz3UCOcyQdYOHFg+q1
         /Hj3yhYCFaEuEFVqdzTh5qe2dBIv0cYBrKDRDnxQBoDgb9zGEVXhyxbuYoS46mK5RpnF
         FxVzdCI/rdoM1PZQ8qNRyU8s3wpT8EFfdqmQiUqOFUHMzZB5kD7GRPFJ008mPHSEL0wK
         nbHbDY6AH8U8fh09HaSSAExh0Skd8xrA7Qu4+mDlGBZZA8HvtTxVav10VZubk3yzIMTX
         kl6k1EDAQZY8xKSYlgYlVlhmn2vmMx+Mts6BYrBaFvtoEzjVCnNcmI17DCBJ5h4YoLK5
         /low==
X-Gm-Message-State: ABy/qLbOMmFnNp7ReOuXU+JSy8ZjfdQlMhaYYYmEK/arsWL978U98hgB
	5SOSX7hPk9soLErNy/6XlavntOltjJlrjP2bXD27FZxOcRWNGvwAYD+NNF/yY0HnIqdjD1LjoGL
	Al6KZeh8I3oScMv2Z
X-Received: by 2002:a17:906:a015:b0:992:ef60:ab0d with SMTP id p21-20020a170906a01500b00992ef60ab0dmr17392139ejy.69.1689170448076;
        Wed, 12 Jul 2023 07:00:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBod0KG0DcnJFSN+n4ceW5pzP5oVsWcChg2FpbGNwNsSSo86UTZSPU/Lxh7dvjZIYCeKplTQ==
X-Received: by 2002:a17:906:a015:b0:992:ef60:ab0d with SMTP id p21-20020a170906a01500b00992ef60ab0dmr17392111ejy.69.1689170447692;
        Wed, 12 Jul 2023 07:00:47 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090638cb00b00992f309cfe8sm2620589ejd.178.2023.07.12.07.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:00:47 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <28bde9e2-7d9c-50d9-d26c-a3a9d37e9e50@redhat.com>
Date: Wed, 12 Jul 2023 16:00:46 +0200
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
 Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
 <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
 <20230711170838.08adef4c@kernel.org>
In-Reply-To: <20230711170838.08adef4c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12/07/2023 02.08, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 17:49:19 +0200 Jesper Dangaard Brouer wrote:
>> I see you have discovered that the next bottleneck are the IOTLB misses.
>> One of the techniques for reducing IOTLB misses is using huge pages.
>> Called "super-pages" in article (below), and they report that this trick
>> doesn't work on AMD (Pacifica arch).
>>
>> I think you have convinced me that the pp_provider idea makes sense for
>> *this* use-case, because it feels like natural to extend PP with
>> mitigations for IOTLB misses. (But I'm not 100% sure it fits Mina's
>> use-case).
> 
> We're on the same page then (no pun intended).
> 
>> What is your page refcnt strategy for these huge-pages. I assume this
>> rely on PP frags-scheme, e.g. using page->pp_frag_count.
>> Is this correctly understood?
> 
> Oh, I split the page into individual 4k pages after DMA mapping.
> There's no need for the host memory to be a huge page. I mean,
> the actual kernel identity mapping is a huge page AFAIU, and the
> struct pages are allocated, anyway. We just need it to be a huge
> page at DMA mapping time.
> 
> So the pages from the huge page provider only differ from normal
> alloc_page() pages by the fact that they are a part of a 1G DMA
> mapping.
> 
> I'm talking mostly about the 1G provider, 2M providers can be
> implemented using various strategies cause 2M is smaller than
> MAX_ORDER.
> 
>> Generally the pp_provider's will have to use the refcnt schemes
>> supported by page_pool.  (Which is why I'm not 100% sure this fits
>> Mina's use-case).
>>
>> [IOTLB details]:
>>
>> As mentioned on [RFC 08/12] there are other techniques for reducing
>> IOTLB misses, described in:
>>    IOMMU: Strategies for Mitigating the IOTLB Bottleneck
>>     - https://inria.hal.science/inria-00493752/document
>>
>> I took a deeper look at also discovered Intel's documentation:
>>    - Intel virtualization technology for directed I/O, arch spec
>>    -
>> https://www.intel.com/content/www/us/en/content-details/774206/intel-virtualization-technology-for-directed-i-o-architecture-specification.html
>>
>> One problem that is interesting to notice is how NICs access the packets
>> via ring-queue, which is likely larger that number of IOTLB entries.
>> Thus, a high change of IOTLB misses.  They suggest marking pages with
>> Eviction Hints (EH) that cause pages to be marked as Transient Mappings
>> (TM) which allows IOMMU to evict these faster (making room for others).
>> And then combine this with prefetching.
> 
> Interesting, didn't know about EH.
> 

I was looking for a way to set this Eviction Hint (EH) the article
talked about, but I'm at a loss.


>> In this context of how fast a page is reused by NIC and spatial
>> locality, it is worth remembering that PP have two schemes, (1) the fast
>> alloc cache that in certain cases can recycle pages (and it based on a
>> stack approach), (2) normal recycling via the ptr_ring that will have a
>> longer time before page gets reused.
> 
> I read somewhere that Intel IOTLB can be as small as 256 entries.

Are IOTLB hardware different from the TLB hardware block?

I can find data on TLB sizes, which says there are two levels on Intel,
quote from "248966-Software-Optimization-Manual-R047.pdf":

  Nehalem microarchitecture implements two levels of translation 
lookaside buffer (TLB). The first level consists of separate TLBs for 
data and code. DTLB0 handles address translation for data accesses, it 
provides 64 entries to support 4KB pages and 32 entries for large pages.
The ITLB provides 64 entries (per thread) for 4KB pages and 7 entries 
(per thread) for large pages.

  The second level TLB (STLB) handles both code and data accesses for 
4KB pages. It support 4KB page translation operation that missed DTLB0 
or ITLB. All entries are 4-way associative. Here is a list of entries
in each DTLB:

  • STLB for 4-KByte pages: 512 entries (services both data and 
instruction look-ups).
  • DTLB0 for large pages: 32 entries.
  • DTLB0 for 4-KByte pages: 64 entries.

  An DTLB0 miss and STLB hit causes a penalty of 7cycles. Software only 
pays this penalty if the DTLB0 is used in some dispatch cases. The 
delays associated with a miss to the STLB and PMH are largely nonblocking.


> So it seems pretty much impossible for it to cache accesses to 4k
> pages thru recycling. I thought that even 2M pages will start to
> be problematic for multi queue devices (1k entries on each ring x
> 32 rings == 128MB just sitting on the ring, let alone circulation).
> 

Yes, I'm also worried about how badly these NIC rings and PP ptr_ring
affects the IOTLB's ability to cache entries.  Why I suggested testing
out the Eviction Hint (EH), but I have not found a way to use/enable
these as a quick test in your environment.

--Jesper


