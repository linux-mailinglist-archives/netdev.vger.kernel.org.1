Return-Path: <netdev+bounces-45536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3B7DE02C
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0589A28134C
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710BA10974;
	Wed,  1 Nov 2023 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiD8IRTA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221B101CE
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 11:11:52 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9ABF7
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:11:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so92240901fa.3
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698837106; x=1699441906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WljMIn9oOVQ8xvgl/cyiqAsCMw6Ur1FNTMuZ2oBE+gw=;
        b=EiD8IRTAcbxeZLYteg296XQlerco54RyGGC+tc6wu+uf5ffFOII7WNDwO2r1fX3SgT
         Y4PUBMiM/6wO7lvP1iV58KZ2I/9TTChZTs95P6/wO9YIBnR67LSCdUcEmT2LXDua3WE3
         xTk/OkowTg0E3mtN8aAmYKSHiJicRRWEwiJNjVnJEKsbfyJsKEuR7b06d/jfFvHyaIR6
         RzrIYtBiUasApFXhkIaZMHOetSZR8WBdQNxpcP9sB5ZkwojWRhCvpIFkAJICl560Fqis
         mEANTNW+QdYkKaETOi0ljA5SoTF36ReJayvLZ+wXtrQIwEjmkL4e3IAAa1gN+BYRK2QY
         B3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698837106; x=1699441906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WljMIn9oOVQ8xvgl/cyiqAsCMw6Ur1FNTMuZ2oBE+gw=;
        b=g2yWWToxpnAcbYQ69q67sDUJjnos0KgLZ5DngmXx/KASYAQkxh5VvEVg3+YwpUBbYC
         f6o86pml6ERxqqVPx05+Yh4TXaeEt5pnDx8NlCNG0nDQFpRnRLXSjyRTHeKJZrcd/UZW
         9Dg0qPeVrcfMu+U4rli4H5qzxVCxTUBa153wyQCdIiLNo1coZoVeyIcENTud3S0my+3p
         9AmDy7lxh4PVjzlMCSix71iBb9UHnruRMSLZA4clKKDXdm+dn4wagq4nfZYAA59o8JVe
         P6fR08DhwCWNA2Tb/imEfSWyKxcLQuzyjXxZfWVZlNKNTcwsbM1UOP7pEIPUgJRuRAIp
         kk0w==
X-Gm-Message-State: AOJu0Yw+x5sbYvp0b419FOcQ2E+4SstdaivnC+jZ9PWcv++obPXgpJK6
	UcGShUI35i4HU+kig5ZvOS8hxyTPqF4mRYaF7MAh5A==
X-Google-Smtp-Source: AGHT+IEERy59/IWp+6dIDuWyJKEXUBb4ORPPPzSmdWnQwEDxVK4Rm6OzsdMBvXm42b1Hb5I5OFDnRRjHTqziQDUvCJs=
X-Received: by 2002:ac2:4846:0:b0:507:aaa4:e3b3 with SMTP id
 6-20020ac24846000000b00507aaa4e3b3mr10709203lfy.50.1698837106260; Wed, 01 Nov
 2023 04:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030091256.2915394-1-shaojijie@huawei.com>
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Nov 2023 13:11:10 +0200
Message-ID: <CAC_iWj+V8KB2TE=6e0z4SRoq7pY+3gStKawX_-8UfYh+cP9ndQ@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
To: Jijie Shao <shaojijie@huawei.com>
Cc: hawk@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jdamato@fastly.com, shenjian15@huawei.com, 
	wangjie125@huawei.com, liuyonglong@huawei.com, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 11:17, Jijie Shao <shaojijie@huawei.com> wrote:
>
> From: Jian Shen <shenjian15@huawei.com>
>
> When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
> is not called to free pool->recycle_stats, which may cause memory
> leak.
>
> Fixes: ad6fa1e1ab1b ("page_pool: Add recycle stats")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  net/core/page_pool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..31f923e7b5c4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -221,8 +221,12 @@ static int page_pool_init(struct page_pool *pool,
>                 return -ENOMEM;
>  #endif
>
> -       if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
> +       if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
> +#ifdef CONFIG_PAGE_POOL_STATS
> +               free_percpu(pool->recycle_stats);
> +#endif
>                 return -ENOMEM;
> +       }
>
>         atomic_set(&pool->pages_state_release_cnt, 0);
>
> --
> 2.30.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

