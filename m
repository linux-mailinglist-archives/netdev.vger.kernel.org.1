Return-Path: <netdev+bounces-20377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191BC75F385
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E3C280DE0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AD46B2;
	Mon, 24 Jul 2023 10:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3241869
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:38:46 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B950710F4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:38:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so5531417a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690195092; x=1690799892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ielYHzUrYNTg1vO1OyNLSAd+Y6bxAWIGr7ALSNd/VnA=;
        b=FLEc6P9XLwXpzZPKVljuJLSGG+G36rdrqUSkkl4ZD4MkaNcFGBDcBPr0pkpzEmlP/7
         2NbyOPDZtFRWBKOeU1nixSOo5wd5HWdUeYBIaky9a79mk3M9Kph27a5K1VHMHuaRN4HU
         9QM4baKQOnI9Bfw4JP82TS0+Kwfv16uOELFt0al0hz3EEt4+01gJfWkxfCr0WDVsuhjw
         WQN6Psz+bl/eNkXquY+mfgnIMuTwFZmba7L99YHDvZyfXVg1oQCSBk9KwA5tA+n5pAxB
         YYBwZEflyq8xduXCWK+RzrSL2ai/LaghOZZXNHDdoGFSbRFxO4LX4+KqIhArmNAxuzJs
         wHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690195092; x=1690799892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ielYHzUrYNTg1vO1OyNLSAd+Y6bxAWIGr7ALSNd/VnA=;
        b=EzkRkwm+4NqZPxeHRwqLSADX0youf501ZPSZqg+14gbaIY1SgySlUYGoXGN68w6u05
         Mcvmq/dgWIfWu4gOa17gkAsNKisYq6DF+dcwdnzabCTY+i31S/3RgXpnMsv6BXSrCCnm
         LtUaqhGda7QrkARTjOKxSBirxF5tpvoOmVyYnTXJw7eKkgFSEFMIMjQZmtCTq8YGmo5c
         /ZJcdsKTDNiimzmZBGM2BJNLwWX/NolQ67QigR3uxUUORTu0lO6NRfG/AKYwtgY5ySty
         h8Jo2gtbbjMPE7u16De3SyBfIVkOkiyyElJ1L4QRNLiE5i9Bz4yBAKtiJXhJmFSK51+R
         S56g==
X-Gm-Message-State: ABy/qLbc2rNACm8ya1Duw7LAGvd2rH+cGG68B7xiChCHQHNClKR7w8O4
	S/30aHlavx2j/8XGFj/r98dpXA==
X-Google-Smtp-Source: APBJJlG0ivl9qydkBr1odu0uOOzuwT32303BMTuMr5q1sYlLdxedtbS0EHMjOdCXo5gNEN2SiCacGQ==
X-Received: by 2002:a17:906:30d5:b0:993:d5bd:a757 with SMTP id b21-20020a17090630d500b00993d5bda757mr8454057ejb.19.1690195092017;
        Mon, 24 Jul 2023 03:38:12 -0700 (PDT)
Received: from hera (ppp046103056065.access.hol.gr. [46.103.56.65])
        by smtp.gmail.com with ESMTPSA id op10-20020a170906bcea00b00989027eb30asm6514131ejb.158.2023.07.24.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:38:11 -0700 (PDT)
Date: Mon, 24 Jul 2023 13:38:09 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, hawk@kernel.org
Subject: Re: [PATCH net-next 4/4] net: page_pool: merge
 page_pool_release_page() with page_pool_return_page()
Message-ID: <ZL5UkY+4wq4raIlv@hera>
References: <20230720010409.1967072-1-kuba@kernel.org>
 <20230720010409.1967072-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720010409.1967072-5-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 06:04:09PM -0700, Jakub Kicinski wrote:
> Now that page_pool_release_page() is not exported we can
> merge it with page_pool_return_page(). I believe that
> the "Do not replace this with page_pool_return_page()"
> comment was there in case page_pool_return_page() was
> not inlined, to avoid two function calls.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> ---
>  net/core/page_pool.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2c7cf5f2bcb8..7ca456bfab71 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -492,7 +492,7 @@ static s32 page_pool_inflight(struct page_pool *pool)
>   * a regular page (that will eventually be returned to the normal
>   * page-allocator via put_page).
>   */
> -static void page_pool_release_page(struct page_pool *pool, struct page *page)
> +static void page_pool_return_page(struct page_pool *pool, struct page *page)
>  {
>  	dma_addr_t dma;
>  	int count;
> @@ -518,12 +518,6 @@ static void page_pool_release_page(struct page_pool *pool, struct page *page)
>  	 */
>  	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>  	trace_page_pool_state_release(pool, page, count);
> -}
> -
> -/* Return a page to the page allocator, cleaning up our state */
> -static void page_pool_return_page(struct page_pool *pool, struct page *page)
> -{
> -	page_pool_release_page(pool, page);
>
>  	put_page(page);
>  	/* An optimization would be to call __free_pages(page, pool->p.order)
> @@ -615,9 +609,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>  	 * will be invoking put_page.
>  	 */
>  	recycle_stat_inc(pool, released_refcnt);
> -	/* Do not replace this with page_pool_return_page() */
> -	page_pool_release_page(pool, page);
> -	put_page(page);
> +	page_pool_return_page(pool, page);

That comment is my fault.  In hindsight, it wasn't very helpful ...
IIRC Jesper wanted to keep the calls discrete because we could optimize the
page pool internal and eventually not call put_page().  But I am fine with
the change regardless, it makes the code easier to read.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  	return NULL;
>  }
> --
> 2.41.0
>

