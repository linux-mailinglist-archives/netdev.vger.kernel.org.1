Return-Path: <netdev+bounces-104925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477390F211
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F11C20FAA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A0115099A;
	Wed, 19 Jun 2024 15:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE6182B5
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810737; cv=none; b=I9FaYZ1vLCgupe9NCOR4A5C/N2EI3mM5rZSfjLd5MRVtudBpcHodEoZrDQ1QArZA0zcJsSxJZZoDVspV5+j8r51LVq2HZqqwDKU8o5LYOWZeH29qtvE3eaMtBBQowUspRSKVCZQ53eHAuaAz0BA9/mg4qVwzaStroIQFtx7BUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810737; c=relaxed/simple;
	bh=7lLHL7WbtmnVTokudSZCsjF75Xj14OPUUSGO5t3o/W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2SdI1kZMSEHNxGUh9fxF96ptuncc7fXGrE8+9za9+wf8cU8B1HDE4f97M00Y/6Dd7WN2LyVY5Ke4i3B7TUiTidJWdVtobsRVkUjNoDYDNn3UQQ9ULc0YEOSxbyd9fCs2WzzOEAYi9CIWUUiRhSCASl6IT7eimgreeQz/A5zGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3590b63f659so513611f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810734; x=1719415534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzIZgoUq63mX73VxCwwJIV3CEA76deHPFGsC3cFCI3w=;
        b=MceAWQ0eou/sUioN5bvOnyH99bu7d0ErdovQLtXtJZqWX9fy406BjBKfhCfDTpWbAd
         d/Uzvz24/xzBYCeHucdny1vgTA6750xNDYnZi1ThULOrp1+c+ozkciOxkOvPKZ+G1GZG
         AsOtWvGq6p2BqiVK8gZ4bB2XxAfQgrczdtJmZjPNwoKJsAsBoLVz618vkncSuclxZeeg
         YrYHUwgp29aT98xpgYTvheOyrutZoYMDVf/aLt8GHPqc4wz0MkKyHuLtVOY8U1Lq3Vgv
         7/lHGMCxUQLTweCKH+5mC0kvliDomL4NVquwQhW82jUoTXCC+gaqL+AqC3rDhwbeX1CI
         y/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXzmJCAh9PKmaqT7xcgN6oRmEcYizcqTKG5C1pCgugwTSPYcjyagDlSMa3yoiV/beb8Pz0vhWrgGplbGq/4C3H11Rruqy68
X-Gm-Message-State: AOJu0Yy58V/75RPObov+I1C8GRrM6xgoWKuS4uFPpJ/GIBUfTXTWkMVg
	SilqJHvI3n34mKqP9eOPz/J6LcKmvxcTwt519RaiFF7+ZiHx7tpJ
X-Google-Smtp-Source: AGHT+IEf3sBjCXzX93lySh/7g4Tm+IBr0zNaAnkDAVMjgUhsUo+S1T8n1ms7EyN4QACfrLyfXjDyrg==
X-Received: by 2002:a05:6000:18a2:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-36316ff7978mr2237855f8f.2.1718810733768;
        Wed, 19 Jun 2024 08:25:33 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33bcfsm230292215e9.1.2024.06.19.08.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:25:33 -0700 (PDT)
Message-ID: <e26bf274-8600-4862-ab3c-9ce6df7d86e9@grimberg.me>
Date: Wed, 19 Jun 2024 18:25:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
To: Eric Dumazet <edumazet@google.com>
Cc: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, netdev@vger.kernel.org
References: <20240617095852.66c96be9@kernel.org>
 <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
 <Zm9fju2J6vBvl-E0@casper.infradead.org>
 <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me>
 <407790.1718801177@warthog.procyon.org.uk>
 <0aaaeabc-6f65-4e5d-bdb1-aa124ed08e8b@grimberg.me>
 <CANn89iLQ+9GYYn0pQpueFP+aYHnoWhqZSws6t6VCNoxs8pwL7w@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CANn89iLQ+9GYYn0pQpueFP+aYHnoWhqZSws6t6VCNoxs8pwL7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/06/2024 17:51, Eric Dumazet wrote:
> On Wed, Jun 19, 2024 at 3:54 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>> On 19/06/2024 15:46, David Howells wrote:
>>> Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>>> On Mon, 17 Jun 2024 09:29:53 +0300 Sagi Grimberg wrote:
>>>>>> Probably because kmap() returns page_address() for non-highmem pages
>>>>>> while kmap_local_page() actually returns a kmap address:
>>>>>>
>>>>>>            if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
>>>>>>                    return page_address(page);
>>>>>>            return __kmap_local_pfn_prot(page_to_pfn(page), prot);
>>>>>>
>>>>>> so if skb frags are always lowmem (are they?) this is a false positive.
>>>>> AFAIR these buffers are coming from the RX ring, so they should be
>>>>> coming from a page_frag_cache,
>>>>> so I want to say always low memory?
>>>>>
>>>>>> if they can be highmem, then you've uncovered a bug that nobody's
>>>>>> noticed because nobody's testing on 32-bit any more.
>>>>> Not sure, Jakub? Eric?
>>>> My uneducated guess would be that until recent(ish) sendpage rework
>>>> from David Howells all high mem pages would have been single pages.
>>> Um.  I touched the Tx side, not the Rx side.
>>>
>>> I also don't know whether all high mem pages would be single pages.  I'll have
>>> to defer that one to the MM folks.
>> What prevents from gro to expand frags from crossing PAGE_SIZE?
>>
>> btw, at least from the code in skb_gro_receive() it appears that
>> page_address() is called directly,
>> which suggest that these netmem pages are lowmem?
> GRO should only be fed with lowmem pages.
>
> But the trace involves af_unix, not GRO ?
>
> I guess that with splice games, it is possible to add high order pages to skbs.
>
> I think skb_frag_foreach_page() could be used to fix this issue.

Thanks Eric, that is indeed the missing piece.

I'll give it go.

