Return-Path: <netdev+bounces-103922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6D190A5C8
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31F71F21248
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139E186288;
	Mon, 17 Jun 2024 06:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6D1836DF
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605799; cv=none; b=VzxAxLAbX3toginugR/5zEdqFPQCBEgqIixrndBxHWk9xYjfUvW5C0V8+vvF2q961RaMj0TR33ip2FIgYfh8q45OgzDcpaVYQZYIftaFXDY09DzzbuddGNSePPWk7aTsia3S7CDm7yc1pz72R3dTINlsAnWvHAWDVmcGWbvqVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605799; c=relaxed/simple;
	bh=7L2L+mqB2GnpxBgXJomqOiBE6YgsK74wzFa9vHbYSa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBk7R2nSetcFbKT66j96JZ4EkZhMQjwDi921tI+Pv9gShLofy4PaqMkpuJFT8qlwjKstBQDurhuv9oGPdGcG4YVAGEmxSy+ETiHvQW5UqrM4NpM9l1GD1YuULehazZzyjk4p3yhIVw2mstd5TlKOeBuuGUzL8VBpFZNS7l9f2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3590b63f659so277932f8f.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 23:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605796; x=1719210596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVUiwuGsa9k+yiZxjURTV+XS0g5oBgiJFPhcdonfit8=;
        b=jd2gNEfaE2VKTEGyBPRhW6tvda0zO6UI2d1LMrbwN9KdAMdQarnt6tcwGWVAX3uTYJ
         n0935dmjV792srQkRC2D+BsURfFTaDrTU9rXMbd7n8lCNCFFN6Vh93DiEJwjOcWLQJtu
         f6ZtSFpIH0jtZ0IB7HBI2/cz0dcDe6NLtpWV8+36PCcFN3aodPNi0UG78yalSfYum7e2
         lTynMilZKZdMHLbb5U/HZdLo0Ufsn/SMgAd6ifAyyzELDKNB4Ao+W+e+NVsgBU4QzlyE
         Q5YHaMoeWkh2j8ucnWFdgDffYK5HtgN4fynMb27VFdVQ/sbbK+JHcd2Quy3ljUm8ZY/T
         omLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4nJKpqUAqVRKzgcAKhMXprAsffuOO3E+zWlK4quvbsI3mOfggEWP3AjiOzJh5bjvCJPYc0I1DfBhZ7vDnQA2iz6/KtaM
X-Gm-Message-State: AOJu0YxjsiUnjfE5SRINoZuIeRw4An6TMpag8aES/oZrE5a11oqcS9W2
	JvOzLm0EzENQdUtcnFL/6jNgGO/teJwJuKu+syOuOuynSq9m+Xj2
X-Google-Smtp-Source: AGHT+IFMMekEYVXUKHOIgRQ5y3J5UG5+EOGA2WdnkSS7BWEOiCg9rgyh0bAkFBTRKufFCJSYKijz6w==
X-Received: by 2002:a05:600c:3510:b0:421:7dc3:99ff with SMTP id 5b1f17b1804b1-42304852324mr67975845e9.3.1718605795415;
        Sun, 16 Jun 2024 23:29:55 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c7e5sm11261973f8f.30.2024.06.16.23.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 23:29:55 -0700 (PDT)
Message-ID: <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me>
Date: Mon, 17 Jun 2024 09:29:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
 <Zm9fju2J6vBvl-E0@casper.infradead.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zm9fju2J6vBvl-E0@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/06/2024 0:56, Matthew Wilcox wrote:
> On Sun, Jun 16, 2024 at 12:24:28PM +0300, Sagi Grimberg wrote:
>>> [   13.495377][  T189] ------------[ cut here ]------------
>>> [   13.495862][  T189] kernel BUG at mm/usercopy.c:102!
>>> [   13.496372][  T189] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
>>> [   13.496927][  T189] CPU: 0 PID: 189 Comm: systemctl Not tainted 6.10.0-rc2-00258-g18f0423b9ecc #1
>>> [   13.497741][  T189] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>> [ 13.498663][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12))
>>> [   13.499424][  T194] usercopy: Kernel memory exposure attempt detected from kmap (offset 0, size 8192)!
>> Hmm, not sure I understand exactly why changing kmap() to kmap_local_page()
>> expose this,
>> but it looks like mm/usercopy does not like size=8192 when copying for the
>> skb frag.
>>
>> quick git browse directs to:
>> --
>> commit 4e140f59d285c1ca1e5c81b4c13e27366865bd09
>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Date:   Mon Jan 10 23:15:27 2022 +0000
>>
>>      mm/usercopy: Check kmap addresses properly
>>
>>      If you are copying to an address in the kmap region, you may not copy
>>      across a page boundary, no matter what the size of the underlying
>>      allocation.  You can't kmap() a slab page because slab pages always
>>      come from low memory.
>>
>>      Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>      Acked-by: Kees Cook <keescook@chromium.org>
>>      Signed-off-by: Kees Cook <keescook@chromium.org>
>>      Link:
>> https://lore.kernel.org/r/20220110231530.665970-2-willy@infradead.org
>> --
>>
>> CCing willy.
>>
>> The documentation suggest that under single-context usage kmap() can be
>> freely converted
>> to kmap_local_page()? But seems that when using kmap() the size is not an
>> issue, still trying to
>> understand why.
> Probably because kmap() returns page_address() for non-highmem pages
> while kmap_local_page() actually returns a kmap address:
>
>          if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
>                  return page_address(page);
>          return __kmap_local_pfn_prot(page_to_pfn(page), prot);
>
> so if skb frags are always lowmem (are they?) this is a false positive.

AFAIR these buffers are coming from the RX ring, so they should be 
coming from a page_frag_cache,
so I want to say always low memory?

> if they can be highmem, then you've uncovered a bug that nobody's
> noticed because nobody's testing on 32-bit any more.

Not sure, Jakub? Eric?

