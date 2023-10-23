Return-Path: <netdev+bounces-43457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388317D34DC
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C231C208D0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598A15EA9;
	Mon, 23 Oct 2023 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="At2P8Uxx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98015EA5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:43:18 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D210C6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 04:43:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so4614108a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698061393; x=1698666193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lK2Os4ki3ybOrLldklG2GHNhaGnXGVR5XIYnYtMlps=;
        b=At2P8Uxxzv6GI6YeQtOqwWEEtGW7rpN+HK5vowzXObtwm1phbFN8RTQzN0JAUI7ui9
         6bu0hDr+YIOvp6vhkNWaVKzfG3jIzduVH9cKsBQyefNKj3eBHU8mYht5BHrH6tCg9hLn
         bUJiP9X/LZy8B6m5URFKaoSTpTM4oDbOY+s9EqjBa48+U3dvItekLOtmDxr/qT96F3dD
         59q1SYJYk/lRmBez6MhdqMdzMzaP5YP/3BcwgSfu2aguyS/IcXWNJPn0VzFSrQmWbzft
         iaF2JXeQ6GiA9xDrZ7gQvZ6kOas0lwIYrz5Fvh4JqDQLb82y2iYXuM1ZkP3pTE2zC1ni
         drvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061393; x=1698666193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lK2Os4ki3ybOrLldklG2GHNhaGnXGVR5XIYnYtMlps=;
        b=gNPsgwNGBmij4Ik8Z7bmstiJNQrk0RNrth8M1TU7idHYSYan+Muq2081gsFwO+qQBg
         8B0U8i2AQK0hZcgOO7cNZqpaYrPxa2xqhL3zVJDrVu1JhdCVQq/F6goSFnkplqgT/jsQ
         wIzsKhM7J+j+cFcPfpDjbwOFQg3EuNmpPvJ/IRT/tiiBfgh/JXYYaHTeyCqD77FDI+WS
         mmlb52F4NxRhb63/suuKu1IFZBKAQm9pEzXITjr8Ha++ZfAr1/zEL8/O4Zrrt7aXBYl6
         SSKt/zXFeOjxL0/K8I3bwplyAkpWKG2TCu19WH4NF3aDGATOgpGjWIr7zw9vwmUv4+zQ
         Mwyw==
X-Gm-Message-State: AOJu0YzCZOX/rejKnnNeDtxhSMrqz6CUm4qhRKTwq2NZsxtRKPzJCSvW
	7gBiJ2kqJ4+AatA16MAe+eq7HQ==
X-Google-Smtp-Source: AGHT+IHaDNA1PlbIvGMsp8KrQL7HEt0juPuIGQjc61yTnJpKaLFvghgW32JA5h2Rqz7s/BmlD8HzRg==
X-Received: by 2002:a05:6402:5114:b0:53f:efbc:e42b with SMTP id m20-20020a056402511400b0053fefbce42bmr5172581edd.34.1698061393557;
        Mon, 23 Oct 2023 04:43:13 -0700 (PDT)
Received: from hades (ppp046103219117.access.hol.gr. [46.103.219.117])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7d51a000000b0053dda7926fcsm6146215edq.60.2023.10.23.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:43:13 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:43:10 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v12 1/5] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
Message-ID: <ZTZcTrTy9ulPast5@hades>
References: <20231020095952.11055-1-linyunsheng@huawei.com>
 <20231020095952.11055-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020095952.11055-2-linyunsheng@huawei.com>

Hi Yunsheng, 

[...]

> +	 * 1. 'n == 1': no need to actually overwrite it.
> +	 * 2. 'n != 1': overwrite it with one, which is the rare case
> +	 *              for pp_frag_count draining.
>  	 *
> -	 * The main advantage to doing this is that an atomic_read is
> -	 * generally a much cheaper operation than an atomic update,
> -	 * especially when dealing with a page that may be partitioned
> -	 * into only 2 or 3 pieces.
> +	 * The main advantage to doing this is that not only we avoid a atomic
> +	 * update, as an atomic_read is generally a much cheaper operation than
> +	 * an atomic update, especially when dealing with a page that may be
> +	 * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
> +	 * handling by ensuring all pages have partitioned into only 1 piece
> +	 * initially, and only overwrite it when the page is partitioned into
> +	 * more than one piece.
>  	 */
> -	if (atomic_long_read(&page->pp_frag_count) == nr)
> +	if (atomic_long_read(&page->pp_frag_count) == nr) {
> +		/* As we have ensured nr is always one for constant case using
> +		 * the BUILD_BUG_ON(), only need to handle the non-constant case
> +		 * here for pp_frag_count draining, which is a rare case.
> +		 */
> +		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
> +		if (!__builtin_constant_p(nr))
> +			atomic_long_set(&page->pp_frag_count, 1);

Aren't we changing the behaviour of the current code here? IIRC is
atomic_long_read(&page->pp_frag_count) == nr we never updated the atomic
pp_frag_count and the reasoning was that the next caller can set it
properly. 

> +
>  		return 0;
> +	}
>  
>  	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
>  	WARN_ON(ret < 0);
> +
> +	/* We are the last user here too, reset pp_frag_count back to 1 to
> +	 * ensure all pages have been partitioned into 1 piece initially,
> +	 * this should be the rare case when the last two fragment users call
> +	 * page_pool_defrag_page() currently.
> +	 */
> +	if (unlikely(!ret))
> +		atomic_long_set(&page->pp_frag_count, 1);
> +
>  	return ret;
>  }
>  
 
 [....]

 Thanks
 /Ilias

