Return-Path: <netdev+bounces-28340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED577F162
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029A71C212FC
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93336D51E;
	Thu, 17 Aug 2023 07:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874796AAA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:41:02 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB22D78
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:40:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so12095242e87.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692258047; x=1692862847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pXoDzuYpw0eKPXmUaDJ4Nyha1F3P6ZrKdGeG1LEqhtU=;
        b=J77n1sU7cxK342vtTJu4zF2TrXYe/iMeeT6TOBwfouPio5CMA2+8513r4XiIKMBEGt
         8Y1N5qmlgoRxmwU8Viu8ItYJPJEJUaQ4cOCWwdOclzBY7CTIncSS2/2GUpxbtnZwLVrp
         Bw+W6L8NgTpAw94iZmrrdCE2nNz9+YkZnqKyX31nBWXFVpPur3upAVPe2mbcyqekNVWy
         3pzQqXLFYdbnnYju9tlH/hCZsyepZnnTzU558QK+UWNmbtkwTN8fVlCq72QVk/e9xl95
         Ry9Z2r75rnjzA6QqV3LUp2HAywnb6PQo2sxmE8mRBy2OX6Iawly9b9DjwtE8e7pdu0TD
         RaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692258047; x=1692862847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXoDzuYpw0eKPXmUaDJ4Nyha1F3P6ZrKdGeG1LEqhtU=;
        b=APCXlVHn/yqNOsnmhO4I20HNYtx+FN0t5CRScQoYt4UgGyfBw0Lr0vsMRmusbeBw+c
         uPdvc3t5EI+aUJmOve3ZAKYSnaC4MAIZya1TlPqt6Imfgv/LQqrn7nam6DxV9cKLQNV6
         fhrO9/oPvQxWLXop2AgWNaIAM0kTuck89/A9bBw4Ubm6DGVV9BWdKGMqjilZ0RiL/6xD
         6xZ45TgKXjkljQjqP2Ulyt//8IzhRJtFN1z+5TW0wGLucnZO3pkyLfsJhlldHj0pWkTI
         8Y2w5axZLoJwPCbhhll9tagWmWlfTyRRnS2YcSJVoSRQmCEnnFxNR2aQnysbf2hF5ZuV
         OloA==
X-Gm-Message-State: AOJu0YyqFtfj6UauxLdYVhXmpo+W2eapDNmEG62PCFiWezyIioqjvCmP
	lB3iiLDH/Ku4+HmNPofwLGOx1DMfC+IPHYVlLfcnjA==
X-Google-Smtp-Source: AGHT+IEzE3DGOE3mi1V3BlzsQJtw9zD79/PzNvhBWGuIMsdnBvXy44YiVSqGL7LCDw+rrCNStQQdwX42HQZyF7MezPc=
X-Received: by 2002:ac2:484a:0:b0:4fe:5741:9eb9 with SMTP id
 10-20020ac2484a000000b004fe57419eb9mr3203768lfy.49.1692258047188; Thu, 17 Aug
 2023 00:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-4-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-4-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 10:40:09 +0300
Message-ID: <CAC_iWjLRR3sEZNDTAtD2sZ4UY3aZxGZSyA8y9mOB3SkZsVp7ZA@mail.gmail.com>
Subject: Re: [RFC net-next 03/13] net: page_pool: factor out uninit
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, aleksander.lobakin@intel.com, 
	linyunsheng@huawei.com, almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

[...]

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

I am not sure I am following the reasoning here.  The only extra thing
page_pool_free() does is disconnect the pool. So I assume no one will
call page_pool_uninit() directly.  Do you expect page_pool_free() to
grow in the future, so factoring out the uninit makes the code easier
to read?

Thanks
/Ilias
> +
>  /**
>   * page_pool_create() - create a page pool.
>   * @params: parameters, see struct page_pool_params
> @@ -806,14 +818,7 @@ static void page_pool_free(struct page_pool *pool)
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

