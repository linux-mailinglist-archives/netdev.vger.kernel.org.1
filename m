Return-Path: <netdev+bounces-109723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48750929C1B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0449E280D19
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961CE18EB0;
	Mon,  8 Jul 2024 06:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCD14F98;
	Mon,  8 Jul 2024 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419693; cv=none; b=LS40ih9RKz+/AqncGNxmUs3TXf4LANeWgxNBf0Yvq5pilXnAJ2BuwtTJcGV1gy6+kcYAeTQ7vrHrXoaQtZjPCIHG/+WwVD2IWgArFXf+b7ZChTzi8IbvD3SOjU5P8OPCbTLjwhPJ3EJtkv1iC574td+y4E+CE82suW5gfHTnk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419693; c=relaxed/simple;
	bh=NXqmtX9H4lGddM3GtDGBv4tkmQOCzeYrSZgUWYLBEvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IINysD8D3Efqz8F4kPYHR9q+dVQiA8f8Psz240DMr7aiw5EpkS/FN2H7U82csPq4Q83mWL01X8/XNGyoxUvSuETOZ3sDA0OTr4gu4RS0p6dxKgnPbTzmJyZDBxdS+C/J8bxdL7tVSC3VIyuPOV65Hm/Q5YtmnZxt/7E8Kfl6gZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42111cf2706so4081735e9.0;
        Sun, 07 Jul 2024 23:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419689; x=1721024489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uO72vVxQUZzkutSQqH00zSC8a8TLpd6bNH/lML+P6zY=;
        b=I191wDsk6h8haTFJ8MNdeWmfqJUp2pmdYI9Rn9ZR1z877qPqhiSaIgWECa/3tRLiNl
         p8u0zyK/svLU3CpsNJBvgn2wjCQiobpnAzYQrUrbA9b/Oo6BNpfb8s+BLWTxxA2dbW8C
         KtT07/I6sqeA9qT4H3ezip9MvGlaUiDuvNQlSpVyGvymfarZ4XaKirbrUWEOHNjqPBh9
         mbU7i40qd28g1b7Rx+CJChQVQq5Ac0tPFBzIWbhbhct7YZiw21sSEumG0nM8CJcN8dzZ
         uzlpVDZCXiGJgf2Nj9LwKDa0XB0/H5AkHoFLHzkvDnwFQ0TUEdlsuielIWk8ehOtg3ts
         Lhtw==
X-Forwarded-Encrypted: i=1; AJvYcCXGBWHByWfO5G7gqBtBJBcMqX74gEJvIcGj+0SLy5zlCyMB0vh63qtzfk7Vc9Qa4WU1nNsEXGlpd/SNNt2jpX3A3wTWzXdXY4UbsUIcWeOWN9kqC+qWIUk+XvKi9JFYbv5au6YW
X-Gm-Message-State: AOJu0YyjtTdZtP3AK/8sqZEabVehN55UOEP6050R4cFLar8iNzdiCgxk
	UKnOAH4fJNsF0DP7iFOIkkveYGIoOfhdm7XNQiM78v1I1Eoz+TaM
X-Google-Smtp-Source: AGHT+IGpyO4liVd2tgb7IiFu35V36A0cowb7nNkS2fWia1UPyanXjQOWtl2aQl5cAdG/V/YJzFI/Gw==
X-Received: by 2002:a05:600c:1c85:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-42667e0075dmr17560075e9.1.1720419689162;
        Sun, 07 Jul 2024 23:21:29 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d50f5sm150203565e9.9.2024.07.07.23.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 23:21:28 -0700 (PDT)
Message-ID: <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
Date: Mon, 8 Jul 2024 09:21:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix rc7's __skb_datagram_iter()
To: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/07/2024 6:00, Hugh Dickins wrote:
> X would not start in my old 32-bit partition (and the "n"-handling looks
> just as wrong on 64-bit, but for whatever reason did not show up there):
> "n" must be accumulated over all pages before it's added to "offset" and
> compared with "copy", immediately after the skb_frag_foreach_page() loop.

That is indeed strange. I see the issue. It didn't happen in my local 
testing either.

>
> Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   net/core/datagram.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index e9ba4c7b449d..ea69d01156e6 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -420,6 +420,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
>   			struct page *p;
>   			u8 *vaddr;
>   
> +			n = 0;

I think its better to reset n right before the skb_frag_foreach_page() 
iteration.

Thanks Hugh for addressing this!

