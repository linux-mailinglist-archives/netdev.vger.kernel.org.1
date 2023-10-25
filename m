Return-Path: <netdev+bounces-44237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777557D7351
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E041C20DF8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02237C8C0;
	Wed, 25 Oct 2023 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIBzdvWn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3972D631
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:33:55 +0000 (UTC)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD7DC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:33:54 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso25232e0c.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698258833; x=1698863633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NpOY/dhswWv6RPAZn93pRuk+edemS4bWkiqe+RTmAI=;
        b=qIBzdvWnLeJKdlvupEd5IfEqu1TaeX1uEhkaArRry5fCG+IhyS2RRC67/tCAMtxQA2
         OSDfdXOGYfqS7IMIu8T2b+UgtVkuJw48J0l/fiX71cFU6QH1W8Y6TDLYlNbH9WnltEP/
         A1+1IPiZBji6bO20gwbdrrwKFAtfIkhZzp1mwFO1zRBDFS99WGqTMPAGjJCBC4AmwXCW
         6+bdfpbWcuRRG3h9IIdACuFQEJBEqbcgoag816PZTP1TDFAQCmByzzlPfPR6hl8UIyQu
         uHy57lC6nV7+OS4Co+3SvGiu/XFW7N/X3azqfMpaiJ4/9kE2dm+hHKU6PZAmVmaXr9p3
         OQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258833; x=1698863633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NpOY/dhswWv6RPAZn93pRuk+edemS4bWkiqe+RTmAI=;
        b=cQNba3yT5jJoDrzForrfcIx5UP38Uo47SQfOzoDOy69VjDe5rHPW+B+AG9RVWswb4b
         aHUUp1A+OV+mbnKdkoI5PAFmBQmj7vVvl4ivOtrTAJ880Q974JHeTzYc0nMDJup0LSLs
         jjBjssj/GVLlflBVynQUHcGKbv8U/Z/Zx+EbiUCqFcgANjMzIrN6USxr0DXEvWiNlxN+
         4F6DXu4adxW0Ayfq8N9YIJIBWf0EEtaUPEJvZIqgxhOUZi7xD13E7IEqnL1sp6PxKzlD
         /QwI7heULmeFm5hKiR2Dqw6pvfHbG/p50dkVMi1sy/zl6nW6+0I//Ahbl+eLwag0tDb/
         qB7w==
X-Gm-Message-State: AOJu0YzgmOVUibKduzuyOgyYtQd37pQXjLYyybciHrKhX1sfwF7YoRRt
	SZn3cZzVbEeXnrz1wuYJSlxXeKnOv4EO0WaJzgerww==
X-Google-Smtp-Source: AGHT+IGeM6482Y1usyjZoyqh83bzaaJVkygcjzzMdu+E/8n8ram5ekcNpjCHPigpbvaMXQP1J8iyGPM+nvw+Oqup5Nk=
X-Received: by 2002:a67:e083:0:b0:457:c981:6f5 with SMTP id
 f3-20020a67e083000000b00457c98106f5mr14244544vsl.22.1698258832843; Wed, 25
 Oct 2023 11:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-4-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-4-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Oct 2023 11:33:40 -0700
Message-ID: <CAHS8izPYAO5fbQJBrOuGxiybXGwXuPBoqFwznFQeRQ27b+jtQA@mail.gmail.com>
Subject: Re: [PATCH net-next 03/15] net: page_pool: factor out uninit
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We'll soon (next change in the series) need a fuller unwind path
> in page_pool_create() so create the inverse of page_pool_init().
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/page_pool.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 08af9de8e8eb..4aed4809b5b4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -234,6 +234,18 @@ static int page_pool_init(struct page_pool *pool,
>         return 0;
>  }
>
> +static void page_pool_uninit(struct page_pool *pool)
> +{
> +       ptr_ring_cleanup(&pool->ring, NULL);
> +
> +       if (pool->p.flags & PP_FLAG_DMA_MAP)
> +               put_device(pool->p.dev);
> +
> +#ifdef CONFIG_PAGE_POOL_STATS
> +       free_percpu(pool->recycle_stats);
> +#endif
> +}
> +
>  /**
>   * page_pool_create() - create a page pool.
>   * @params: parameters, see struct page_pool_params
> @@ -817,14 +829,7 @@ static void __page_pool_destroy(struct page_pool *po=
ol)
>         if (pool->disconnect)
>                 pool->disconnect(pool);
>
> -       ptr_ring_cleanup(&pool->ring, NULL);
> -
> -       if (pool->p.flags & PP_FLAG_DMA_MAP)
> -               put_device(pool->p.dev);
> -
> -#ifdef CONFIG_PAGE_POOL_STATS
> -       free_percpu(pool->recycle_stats);
> -#endif
> +       page_pool_uninit(pool);
>         kfree(pool);
>  }
>
> --
> 2.41.0
>


--=20
Thanks,
Mina

