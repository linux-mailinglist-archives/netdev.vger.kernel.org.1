Return-Path: <netdev+bounces-46778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD87E660C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BFAB20C40
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177021096A;
	Thu,  9 Nov 2023 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2Yok3QH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF110953
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:01:23 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB630DF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:01:22 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso6673901fa.3
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520481; x=1700125281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vTPoa0YiuT1ZlZP4+pv+g9I2X4gvWs/AYca8L8v/3E=;
        b=n2Yok3QHeVNQgSq1Q8os/GYvtBRAk0o4nM81QJFJKwRt++Fu+NT3WrI8SSbDh/yiKr
         W28eW95zsOzvIC/E5nVm8i8L2EyVvEG5dxlmhtWx2nMeBoAy52EAbIpPyZmKvvunswZN
         adk7fqlEO2DT0rlhhR+5AnEaqUEdFdUl6pXvSy6lFWm1DQuOq6xO2U/VGoTMVew3J66b
         npwuwK4R0iSv4b3bUFQWfEZyujtHX6LHYfeo5fbOLZTgRASDFAHIA3ws8jhxerUBY9Ls
         Xict5vqYgQqgEYZmbh17YYBYWrIfUlM8+or3pjEmRKg8sDY+5Fx34Vw9ezwpsAHOq/Fc
         HJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520481; x=1700125281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vTPoa0YiuT1ZlZP4+pv+g9I2X4gvWs/AYca8L8v/3E=;
        b=QXvqipUIOyz5hNo0e0/YXbjIKiHguDSzK2iZX3+GByx8RgGU7sgRxUmB3p5zFOVa3p
         FGtpEnfWZTliikAlOodTjEV3EFBxnDc/vEzHy/F6VpFyW32TON08VIxpQqNoCc7b4d1F
         GlpTzWUnNixjQtiqF14ijfNvKvVQ5HNzn7L4Az7j5/9TNRMrMJUmeEPoNG1sR9Y8KWV0
         VCOx9aMJ5t/GlImz/sLvzy59mJpX8WiDA8mOZyLILwxTw+Afo9fyDsDbOUC5MHTkVRpn
         RwkjACU/Ft4ZPZvMqdbGmNJq7IpuWOKwPhiUgYuBflTR4V0lvrdtp0q+GDSni6UMcTx+
         hbGQ==
X-Gm-Message-State: AOJu0YxVWalkIaTmW65NvuV05WmozxagByBE6lS5P0seLzGaiqUb0zW9
	Su7cBIWRBr1O/twDA1IbRSgFggfDyIqmnls+r22syuCSCK6YoPKdFAw=
X-Google-Smtp-Source: AGHT+IFQfOpbMKJ9Y7BDuaHioC8DzpumSuY/EGWkymKP2izi9WHFmBiSjbNzxJOHjPjXbUXrZYRXshlgNrP/6IZaMGU=
X-Received: by 2002:a2e:818c:0:b0:2c5:9b16:199 with SMTP id
 e12-20020a2e818c000000b002c59b160199mr3460975ljg.17.1699520480749; Thu, 09
 Nov 2023 01:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-3-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-3-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 11:00:44 +0200
Message-ID: <CAC_iWjKWf5cT-L7O6HwkWxGBeKajhqq2DTe1djxmPj04L3P5wg@mail.gmail.com>
Subject: Re: [PATCH net-next 02/15] net: page_pool: avoid touching slow on the fastpath
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 19:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> To fully benefit from previous commit add one byte of state
> in the first cache line recording if we need to look at
> the slow part.
>
> The packing isn't all that impressive right now, we create
> a 7B hole. I'm expecting Olek's rework will reshuffle this,
> anyway.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h | 2 ++
>  net/core/page_pool.c          | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 23950fcc4eca..e1bb92c192de 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -125,6 +125,8 @@ struct page_pool_stats {
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> +       bool has_init_callback;
> +
>         long frag_users;
>         struct page *frag_page;
>         unsigned int frag_offset;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 5cae413de7cc..08af9de8e8eb 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -212,6 +212,8 @@ static int page_pool_init(struct page_pool *pool,
>                  */
>         }
>
> +       pool->has_init_callback = !!pool->slow.init_callback;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>         if (!pool->recycle_stats)
> @@ -385,7 +387,7 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>          * the overhead is negligible.
>          */
>         page_pool_fragment_page(page, 1);
> -       if (pool->slow.init_callback)
> +       if (pool->has_init_callback)
>                 pool->slow.init_callback(page, pool->slow.init_arg);
>  }
>
> --
> 2.41.0
>

Same here, please swap my ack with
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

