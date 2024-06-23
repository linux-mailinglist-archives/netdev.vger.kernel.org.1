Return-Path: <netdev+bounces-105932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA669913B1A
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951EB1F218E3
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB51891C3;
	Sun, 23 Jun 2024 13:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BB188CC1
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150279; cv=none; b=kvgnT9PBcr9bkte3OENCrOSBfLRRJ/D3qm7kvbdqIwXJneSRq09DVDy58M4bQ4r0cg1zdvAWcwsU7AdUO8sP1rfpfa4AbfbsReivp2mPpvfJ5NXEOAzIeZIZuOfVXBh7WroVWpHWws4gA1/NQ2Jy659/aYD2PhADyyjT64iYJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150279; c=relaxed/simple;
	bh=1VswI0f/qOzQ5sc+LDTPnH433INfnqx79axKPFFIOvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAWkBxacRIOFmXaz6hgSmvQSRdyb/oPKGB4wVJclRUwtZeG2dfYiwd1pYUtM+kS3pBErjS1WxrtTK2iZgE6jF8sxtncvo+tc9qe/dVDoTive4jffbDG1nt36Udth4JODsZlzTWp5THGKmO2AlGrsS2l+eiH9n1wurakcCiAlNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217ee64ac1so4346205e9.2
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 06:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719150276; x=1719755076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNTMoG6G7B9EyEx2SY4OYSW4HcDLGFoQ/vFBDIukx18=;
        b=QaQYCElGAOE58HKZkEDLoq38qC4RBZ15Jh6hZ8W9B9aI/E+O5mzUJgZ3+lhGOjwaFJ
         MNc09YZhfRb21SQuyl6asQVQ7uakOPAHydj11lAFIJZw0VUdhEYg+JaCX3YpWCmN7rIG
         RKINeQuJL+rJjhz3I9aHFXSjl18bCVwF89JgFKqmEb1Zx+txhs/vrh9khsHMzn1QlxiV
         yFlsV454Au4hpQxk8CkA10rC43i3A0xt9tYzbLIeFUfYHzVpB3Zxmg92ubi5JaZGH9Rl
         AYdqW68AmjcE+5RWQyu54pALGhK1kIKQwnl5brWraharxC+BeRO4Aq6q+vbCodC4GV9i
         B+Zw==
X-Gm-Message-State: AOJu0Yz8M4TxSx+USCub0K4gI+wELmdGmpP3zCAx5Yz7NCJV79M+JPq4
	rMBHh7/25Derm+kdnwh5XnftpOR/E2IVU8cSxZPsof0+b1EyiONss0E7tA==
X-Google-Smtp-Source: AGHT+IHMZt8jiuXfebREYmKTnpb0780u8c2gw5Pmm6Lm1CbWKYKYAwQZZ2buMZIvG4ZRbSyX4GRseQ==
X-Received: by 2002:a05:600c:4749:b0:421:bb51:d630 with SMTP id 5b1f17b1804b1-42487eea39bmr31317865e9.2.1719150275471;
        Sun, 23 Jun 2024 06:44:35 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54e4sm142873135e9.23.2024.06.23.06.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 06:44:35 -0700 (PDT)
Message-ID: <36c8a5a8-94cd-4d81-9fef-125970c10ed5@grimberg.me>
Date: Sun, 23 Jun 2024 16:44:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: allow skb_datagram_iter to be called from any
 context
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, David Howells <dhowells@redhat.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20240623081248.170613-1-sagi@grimberg.me>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240623081248.170613-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/06/2024 11:12, Sagi Grimberg wrote:
> We only use the mapping in a single context, so kmap_local is sufficient
> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> contain highmem compound pages and we need to map page by page.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v2:

Changes from v1 actually...

> - Fix usercopy BUG() due to copy from highmem pages across page boundary
>    by using skb_frag_foreach_page
>
>   net/core/datagram.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index a8b625abe242..cb72923acc21 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -435,15 +435,22 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
>   
>   		end = start + skb_frag_size(frag);
>   		if ((copy = end - offset) > 0) {
> -			struct page *page = skb_frag_page(frag);
> -			u8 *vaddr = kmap(page);
> +			u32 p_off, p_len, copied;
> +			struct page *p;
> +			u8 *vaddr;
>   
>   			if (copy > len)
>   				copy = len;
> -			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
> -					vaddr + skb_frag_off(frag) + offset - start,
> -					copy, data, to);
> -			kunmap(page);
> +
> +			skb_frag_foreach_page(frag,
> +					      skb_frag_off(frag) + offset - start,
> +					      copy, p, p_off, p_len, copied) {
> +				vaddr = kmap_local_page(p);
> +				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
> +					vaddr + p_off, p_len, data, to);
> +				kunmap_local(vaddr);
> +			}
> +
>   			offset += n;
>   			if (n != copy)
>   				goto short_copy;


