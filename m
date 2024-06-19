Return-Path: <netdev+bounces-104884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF0490EF77
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DDBB25359
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB614EC6E;
	Wed, 19 Jun 2024 13:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C714B970
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805267; cv=none; b=VOFiPMfOLetXROv03Cmgxa7UUHLmn5f2IH2wQbQ7ZayqdLYamWD4ZAfhocF2hW/1Ax79B7pRBn4OWYW3uJTbEYZ2X0heQucpjFba2xA5z7LV2Q6tbdohNxhBrNe7n+YkCfCOsFoe035RkNMcuyToSgiFHswMun293iRvhI9Kjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805267; c=relaxed/simple;
	bh=jmV7wlVNy3gdHxYJ4O+6sHOivhoFVOQVYUx2t3ExHFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPeQUmb+xx3l8A3Y34AhP8bWtY3iO4wXrukB7959rfFSvT8z03aMrNwJyy9nd7dbXzO0NsDdJeHeoWB6ZCCO6Yt0ec/7WRvbeIRe7d1EGIjeP70DzS6NIPfOvMwEhcyyOnlsAQMrHvmD5qbVDoLyH3QM/WaZViS3+npLed6gr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3632e0f80e5so61994f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805264; x=1719410064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib3UUGzH7Y2fj72LrSFDKI4abJQLfpbgmiV7twXb3j4=;
        b=UZqbivEojFkygRVyJcvByRG/8AGSR3Z0asoAOhXOveYWZJSI703tbdBtQnzLVhlRtr
         DE7CCbB1oYKf3RhMbGxbpdq1vDCQ9yHNPjofbgisrpc8Yh/ogwy3tDr9VnkdP0T+V35d
         jedCpKJgdOExwYeMDrQuqEP4WZYbeIXv+bBp2jl0EQomsawtmG2Qe94HTJMalMONwvzY
         +JMulppV9xN8jb6sSgOlFl/v1PJzPqfM7AL5GMEWfC+vxcC+51G9JuE0vJG2IUYMHUgd
         uq09wa2p0fbxncPfEn/NLLGLptepdht3Tj/7gViPuOZKFEnSw+Wa7edrwHWBOow7lqMI
         ILGA==
X-Forwarded-Encrypted: i=1; AJvYcCWDX591lDmPOm0ByCiWKjRDqAESJYT1W8uJFnihF8YEwElyzFgjZxsszb4Ce+mJ/bxmbe1/twNjsm2FCAFYPT3wqIgECLP2
X-Gm-Message-State: AOJu0YzvFO6uVPyEbbgn8+GgFBDjdeQifKBJ1GmVxG8QnS2NzqoimKA6
	rU/kcwfGqmxF/Ae89VffYN4c4GNDzFoxFSsRfHD/vkN5CE6n5ojA
X-Google-Smtp-Source: AGHT+IFP0JVbw8oCUaY2m/r2Te+YabVW4Kq5267se4cPey7g9f+4kqK1W7B2HQCoQ3czy1TJAoQvtw==
X-Received: by 2002:a05:6000:1f86:b0:360:8490:74d with SMTP id ffacd0b85a97d-36319990f76mr1809255f8f.5.1718805264252;
        Wed, 19 Jun 2024 06:54:24 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm268509615e9.33.2024.06.19.06.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 06:54:23 -0700 (PDT)
Message-ID: <0aaaeabc-6f65-4e5d-bdb1-aa124ed08e8b@grimberg.me>
Date: Wed, 19 Jun 2024 16:54:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
To: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
References: <20240617095852.66c96be9@kernel.org>
 <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
 <Zm9fju2J6vBvl-E0@casper.infradead.org>
 <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me>
 <407790.1718801177@warthog.procyon.org.uk>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <407790.1718801177@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/06/2024 15:46, David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
>
>> On Mon, 17 Jun 2024 09:29:53 +0300 Sagi Grimberg wrote:
>>>> Probably because kmap() returns page_address() for non-highmem pages
>>>> while kmap_local_page() actually returns a kmap address:
>>>>
>>>>           if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
>>>>                   return page_address(page);
>>>>           return __kmap_local_pfn_prot(page_to_pfn(page), prot);
>>>>
>>>> so if skb frags are always lowmem (are they?) this is a false positive.
>>> AFAIR these buffers are coming from the RX ring, so they should be
>>> coming from a page_frag_cache,
>>> so I want to say always low memory?
>>>
>>>> if they can be highmem, then you've uncovered a bug that nobody's
>>>> noticed because nobody's testing on 32-bit any more.
>>> Not sure, Jakub? Eric?
>> My uneducated guess would be that until recent(ish) sendpage rework
>> from David Howells all high mem pages would have been single pages.
> Um.  I touched the Tx side, not the Rx side.
>
> I also don't know whether all high mem pages would be single pages.  I'll have
> to defer that one to the MM folks.

What prevents from gro to expand frags from crossing PAGE_SIZE?

btw, at least from the code in skb_gro_receive() it appears that 
page_address() is called directly,
which suggest that these netmem pages are lowmem?

