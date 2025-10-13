Return-Path: <netdev+bounces-228707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4312BD2B85
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 13:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE03D4F0D96
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE626A087;
	Mon, 13 Oct 2025 11:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDA19D087
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353543; cv=none; b=Wah9pXTdyhG3g2zU1MDtlsSfaPcE5FFp19dSLhuUnbY1Hw4qbduvqKdAvvYK6rj+GY/R7QujNnGqHQ/xM/3lsn3z/C/2FKytdkzdZ3N/TYgAlohWH6cgekecuUVOPbRP5Sr41IcsNEEiB3WrZVVDGfOeRPo/Q8UpHx0UseWYeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353543; c=relaxed/simple;
	bh=2VR10E5wmg+4Yys6nHjV3FIVrHeBrYXrjEeeXKow4Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svF4xSlDyAjfNzWWWaeCyqYLxMOdkDgp95RQDZ/e2x4qB2ByWE8AWYcreLTHtNJFTUHvKBg8GVwHBpJCXfY8JmzNRefiqEoAeFAamSMX11zo1v4ZeItFkNXBn/7Y3TEcncucHOzhKJeOHHPt4zrgRihs16ibeAQ0fwG7K0h6e8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso8123831a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 04:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353540; x=1760958340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmLqeppxe73hh13JxtM2ixOg3mr3dSJTkeBYNyqFybw=;
        b=QyhvH50SHv8mLMdhqFeJ/YgqNOjzZYAkJDQoThv/ov2U7z7bC94OM/NaEvFduSHpKL
         ZEo1KnlF9cQQ3a1OGMKBb2CqaOTPRunGU6sxZNTvw21B0bKK8PeKQ4uB7s2rc5bb2efX
         NnQbVnkVbuKNtZoZsA1KRMNrE3a7yC5UbSMeqJN5UrdRf8uUb3re1JbqzSN2/J5Lgsu0
         jfaxgK2xMPyPaNC6eQUqDGI5hAZMfYrKouOMR7xZtE1zT6gIybNicEDmb7qkdm6pn1IA
         EnXqlkmd2//rqZ/gT0/VAgl09QG5wFjnkqboI7o4tdaZxEqs3nRVFluLqi6MYk9XIxB/
         6OYg==
X-Gm-Message-State: AOJu0Yy1gUd9H+AKzctd6tpjU4Y4MKXNXTWbi1ZsD6V9N56UfQx6pbL1
	qqbM0Xnw90oUj4bvF8xxcgA9S9fYHRehEzsqIYNr+vbOO/L0Aysve3Me
X-Gm-Gg: ASbGnctnzBzqLN4l20qMHXqvbyOaWooGTywB96gUGgsudNR/Y+LGA6+t//eznn4eJ68
	FOc0x1N7jQohta079rBVRlduBy+jYKL2TI8kFnrJBkS2Dz5xfDW7nFdOw+UPb/hYegr2xBSYMX8
	EDnknGukD29zCVv1mJ5/wEzXi4j8rUJwbFCbDrUJ4DC/EcKiTTqhRLcPk1K6iY/Ox11UoBuom73
	XvNdjZ+ahDc6X69LW6e3yBp4sN6EKKM4wsQavzYuh++3TuSV1CZBYhDshBGpBU74RYDMjuEx3kk
	fahjsM/sb7gid8lbWT9qRulC1lOMpoBH0kTOWmW2GfCA/gk6FuQDsWxAuoU9VnMbh/3kWEbx5HA
	FPK/I1kjMcDodR4eIq1s5oOLc/VMJ2MC+RXo=
X-Google-Smtp-Source: AGHT+IGfjpsttXQ6mVNBCI+WQJkc+SoRWJBewz2mUjprO6UzkXnxv8IdBN8hGF8N7hiFPxEeQBzZ/g==
X-Received: by 2002:a05:6402:40cd:b0:639:dbe7:37c1 with SMTP id 4fb4d7f45d1cf-639dbe73c81mr18605916a12.15.1760353539497;
        Mon, 13 Oct 2025 04:05:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c132b68sm8775862a12.31.2025.10.13.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:05:39 -0700 (PDT)
Date: Mon, 13 Oct 2025 04:05:36 -0700
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, gustavold@gmail.com
Subject: Re: [PATCH net] netpoll: Fix deadlock caused by memory allocation
 under spinlock
Message-ID: <rozn3jx2kbtlpcfvymykyqp2wapqw3jp4wkv6ehrzfqynokr7z@eij4fqog2ldu>
References: <20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org>

On Mon, Oct 13, 2025 at 02:42:29AM -0700, Breno Leitao wrote:
> Fix a AA deadlock in refill_skbs() where memory allocation while holding
> skb_pool->lock can trigger a recursive lock acquisition attempt.
> 
> The deadlock scenario occurs when the system is under severe memory
> pressure:
> 
> 1. refill_skbs() acquires skb_pool->lock (spinlock)
> 2. alloc_skb() is called while holding the lock
> 3. Memory allocator fails and calls slab_out_of_memory()
> 4. This triggers printk() for the OOM warning
> 5. The console output path calls netpoll_send_udp()
> 6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
> 7. Deadlock: the lock is already held by the same CPU
> 
> Call stack:
>   refill_skbs()
>     spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
>     __alloc_skb()
>       kmem_cache_alloc_node_noprof()
>         slab_out_of_memory()
>           printk()
>             console_flush_all()
>               netpoll_send_udp()
>                 skb_dequeue()
>                   spin_lock_irqsave()     <- deadlock attempt
> 
> Refactor refill_skbs() to never allocate memory while holding
> the spinlock.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> ---
>  net/core/netpoll.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 60a05d3b7c249..788cec4d527f8 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -232,14 +232,26 @@ static void refill_skbs(struct netpoll *np)
>  
>  	skb_pool = &np->skb_pool;
>  
> -	spin_lock_irqsave(&skb_pool->lock, flags);
> -	while (skb_pool->qlen < MAX_SKBS) {
> +	while (1) {
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			goto unlock;
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> +
>  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
>  		if (!skb)
> -			break;
> +			return;
>  
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			/* Discard if len got increased (TOCTOU) */
> +			goto discard;
>  		__skb_queue_tail(skb_pool, skb);
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
>  	}

We probably want to return in here, as pointed out by Rik van Riel
offline.

If there are no more concerns, I will wait the 24-hours period and send
a v2.

