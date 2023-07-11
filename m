Return-Path: <netdev+bounces-16880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2574F40D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03B21C20DCE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31019BC5;
	Tue, 11 Jul 2023 15:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB914AB5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 15:49:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A0FB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689090564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX/bugiPbGAi4hiiJdpng9W+Y6ZpIcdTGWLTqWzJ+Wk=;
	b=LvbLppYynvtctfLsV1f0LzFwuNCJv/AZz3DHOnMvAtHlhCcPtRfUBzUU3kbGVqt3KE9DuZ
	wVKBCoaoIDLnVzQPrNNVNIOftpDPxOeKvxXVjc2BU8HBH7KoXQTWfYmm7hOZvJwN76b+vb
	dxB0i96paK4GMHQcsoGjPRbqvA3SNt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-afhOhm0mNLqG_RCd90QCdw-1; Tue, 11 Jul 2023 11:49:22 -0400
X-MC-Unique: afhOhm0mNLqG_RCd90QCdw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51866148986so3678743a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090561; x=1691682561;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX/bugiPbGAi4hiiJdpng9W+Y6ZpIcdTGWLTqWzJ+Wk=;
        b=NSYEAmGt0scheCT5qh9VDJJ4Fut4PFggfk/1prGaNixO48WWWDV0jSFcnREOmd5MmW
         mVlEmPiIpdTuIg/x83CmC0aD8+X1sSAnu6Wdq0R08aTaj4JZmMtQkcnn9tzU0OpK3Y2E
         UixbwFZffBK5Vlk3rBKNtOcHCJk9BpT+r3DPOgsddFWRE5vfuxOF+dcsMTmR/ND90/Kv
         xvfs/1IiVizQfJAywgTpw5r/KAMOYrxEhmoiH5mgaK2zegOmURorPeBqsAJBm2yACGR/
         fj9Wo1nXwgOHhUl286pzexuCshRBDneuN6bEAtK40Uwdm2gqKdOGvgW5IE0nvnyhMw/8
         /MrQ==
X-Gm-Message-State: ABy/qLbvrDD7XwJzfbuRfgAQcOUKEYaLd4G/Z6MSEljQndtRuRez5x5c
	lp4wwpEfQDRmafaGJkKWrXd6ppesSdgV9LMrTL7Rufk8N3/71MHhulqTwrkcK/LjWzuRTdryDn/
	WXVTdDsvzIuJxCzk3
X-Received: by 2002:a17:906:410e:b0:991:cfce:7a09 with SMTP id j14-20020a170906410e00b00991cfce7a09mr16873195ejk.67.1689090561196;
        Tue, 11 Jul 2023 08:49:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEQ6se5OkpjF6wPS4CgkWGD/o8hsYxQXqFSSDAOWk0hYWy0jD/Ta83/6L0TJJtneoSuEuzUfw==
X-Received: by 2002:a17:906:410e:b0:991:cfce:7a09 with SMTP id j14-20020a170906410e00b00991cfce7a09mr16873178ejk.67.1689090560910;
        Tue, 11 Jul 2023 08:49:20 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906338a00b0096f7500502csm1310203eja.199.2023.07.11.08.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 08:49:20 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
Date: Tue, 11 Jul 2023 17:49:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, edumazet@google.com, dsahern@gmail.com,
 michael.chan@broadcom.com, willemb@google.com
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230707183935.997267-1-kuba@kernel.org>
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 07/07/2023 20.39, Jakub Kicinski wrote:
> Hi!
> 
> This is an "early PoC" at best. It seems to work for a basic
> traffic test but there's no uAPI and a lot more general polish
> is needed.
> 
> The problem we're seeing is that performance of some older NICs
> degrades quite a bit when IOMMU is used (in non-passthru mode).
> There is a long tail of old NICs deployed, especially in PoPs/
> /on edge. From a conversation I had with Eric a few months
> ago it sounded like others may have similar issues. So I thought

Using page_pool on systems with IOMMU is a big performance gain in
itself.  As it removes the DMA map+unmap call that need to change the
IOMMU setup/table.

> I'd take a swing at getting page pool to feed drivers huge pages.
> 1G pages require hooking into early init via CMA but it works
> just fine.
> 
> I haven't tested this with a real workload, because I'm still
> waiting to get my hands on the right machine. But the experiment
> with bnxt shows a ~90% reduction in IOTLB misses (670k -> 70k).
> 

I see you have discovered that the next bottleneck are the IOTLB misses.
One of the techniques for reducing IOTLB misses is using huge pages.
Called "super-pages" in article (below), and they report that this trick
doesn't work on AMD (Pacifica arch).

I think you have convinced me that the pp_provider idea makes sense for
*this* use-case, because it feels like natural to extend PP with
mitigations for IOTLB misses. (But I'm not 100% sure it fits Mina's
use-case).

What is your page refcnt strategy for these huge-pages. I assume this
rely on PP frags-scheme, e.g. using page->pp_frag_count.
Is this correctly understood?

Generally the pp_provider's will have to use the refcnt schemes
supported by page_pool.  (Which is why I'm not 100% sure this fits
Mina's use-case).


[IOTLB details]:

As mentioned on [RFC 08/12] there are other techniques for reducing 
IOTLB misses, described in:
  IOMMU: Strategies for Mitigating the IOTLB Bottleneck
   - https://inria.hal.science/inria-00493752/document

I took a deeper look at also discovered Intel's documentation:
  - Intel virtualization technology for directed I/O, arch spec
  - 
https://www.intel.com/content/www/us/en/content-details/774206/intel-virtualization-technology-for-directed-i-o-architecture-specification.html

One problem that is interesting to notice is how NICs access the packets
via ring-queue, which is likely larger that number of IOTLB entries.
Thus, a high change of IOTLB misses.  They suggest marking pages with
Eviction Hints (EH) that cause pages to be marked as Transient Mappings
(TM) which allows IOMMU to evict these faster (making room for others).
And then combine this with prefetching.

In this context of how fast a page is reused by NIC and spatial
locality, it is worth remembering that PP have two schemes, (1) the fast
alloc cache that in certain cases can recycle pages (and it based on a
stack approach), (2) normal recycling via the ptr_ring that will have a
longer time before page gets reused.


--Jesper

[RFC 08/12] 
https://lore.kernel.org/all/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/


