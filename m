Return-Path: <netdev+bounces-56813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73074810E9D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CA1281AA3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785D224C9;
	Wed, 13 Dec 2023 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlRlJnsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E5AC
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:40:18 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2cb20b965dbso69384781fa.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702464017; x=1703068817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAnCwkpD9Clm17EvFcOgcNWHD04WUebyzX5rNk+ix80=;
        b=NlRlJnsPDcc+pYZMDa63nwquPPtlBc5DsohP5uVSeP8qa4E31/tqff8zP1pVr8gBhl
         z6DkZQYQ2ToI+nvraU9hZCeRxC4tuCXdr6wMvUHBLuO8GypwFf4xNezZ11ChGDaf+EFm
         +JinMVuYReTHBosdJB4NcsPRqsAvpwsDt+XWGahf9Z0vNz3XSgBMLRlLT/NCsq8xml2u
         5UKFNdpl0IGkqcQfcDH5J75cgC2as8ApAYFnjvQmZUfgLbzjvSE61+AdlGvfEGKAPyTr
         EBsvD6bL/y+4qpYm0SsDqjgY1Ah+vo+tK14b67/XI4yTinFj5o+ZoWLgtQaZUZjS8z/n
         3k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464017; x=1703068817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAnCwkpD9Clm17EvFcOgcNWHD04WUebyzX5rNk+ix80=;
        b=p4iWbSKkzuHd7Jpos/njIfjfvUpq+bFtjv5Ltjr6yA6/yu6mLABeMavGfGTWyEtx+T
         m09tycgekCj6zxm0PfixGyKitmEbE0flgTYY0z6IUMivcqWZ00dp3eSFOABV62FnT41V
         ld/f+wv5iTTdv/dRkUVoyKzNPDHr6QUmYp5zWodqdstersres3eSGvvcR5bGS2YG7/+Q
         wr4crd+2YwnwcOGLjbx/5/9B9pE+36YhXqjISyyPSZ3wcvAlLUes6DlAGWuo4pZCf74l
         iPtm82F4cCpYDbWMgbzg/jYq6ExM6LEVRp5dAo55nraULMtGhZkFwUXfqajQXeI5DsO1
         dlXg==
X-Gm-Message-State: AOJu0YznpIUPbG835wYwBIfEFsQk7/saf3xTuX/ijW7HaHiSlG+JJBHH
	f0+eKHqHpHOwFm1fMPIDYjNXGAxRXzCV/yOhc+Z1IgnnbVWBfjTcZrE=
X-Google-Smtp-Source: AGHT+IGKBKLezE/IAF+5UYJIESDiymRckScXO9uWhF25DDlxS3cjLPksfNiYAW71DZRoHRl6kLOtgcUXJt8Sju5FciQ=
X-Received: by 2002:a2e:82c7:0:b0:2ca:1c54:ceba with SMTP id
 n7-20020a2e82c7000000b002ca1c54cebamr1409253ljh.132.1702464016698; Wed, 13
 Dec 2023 02:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213043650.12672-1-rdunlap@infradead.org>
In-Reply-To: <20231213043650.12672-1-rdunlap@infradead.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Dec 2023 12:39:40 +0200
Message-ID: <CAC_iWjK=4A8CLF0yKtbQ7vDKmohCCu4KQgGQ__tH__hKY8kjng@mail.gmail.com>
Subject: Re: [PATCH] page_pool: fix typos and punctuation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Randy,

Thanks for cleaning this up

On Wed, 13 Dec 2023 at 06:36, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct spelling (s/and/any) and a run-on sentence.
> Spell out "multi".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/page_pool/helpers.h |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff -- a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -11,7 +11,7 @@
>   * The page_pool allocator is optimized for recycling page or page fragment used
>   * by skb packet and xdp frame.
>   *
> - * Basic use involves replacing and alloc_pages() calls with page_pool_alloc(),
> + * Basic use involves replacing any alloc_pages() calls with page_pool_alloc(),
>   * which allocate memory with or without page splitting depending on the
>   * requested memory size.
>   *
> @@ -37,15 +37,15 @@
>   * attach the page_pool object to a page_pool-aware object like skbs marked with
>   * skb_mark_for_recycle().
>   *
> - * page_pool_put_page() may be called multi times on the same page if a page is
> - * split into multi fragments. For the last fragment, it will either recycle the
> - * page, or in case of page->_refcount > 1, it will release the DMA mapping and
> - * in-flight state accounting.
> + * page_pool_put_page() may be called multiple times on the same page if a page
> + * is split into multiple fragments. For the last fragment, it will either
> + * recycle the page, or in case of page->_refcount > 1, it will release the DMA
> + * mapping and in-flight state accounting.
>   *
>   * dma_sync_single_range_for_device() is only called for the last fragment when
>   * page_pool is created with PP_FLAG_DMA_SYNC_DEV flag, so it depends on the
>   * last freed fragment to do the sync_for_device operation for all fragments in
> - * the same page when a page is split, the API user must setup pool->p.max_len
> + * the same page when a page is split. The API user must setup pool->p.max_len
>   * and pool->p.offset correctly and ensure that page_pool_put_page() is called
>   * with dma_sync_size being -1 for fragment API.
>   */

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

