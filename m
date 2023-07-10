Return-Path: <netdev+bounces-16515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF474DABE
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557A62810D6
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9F12B9A;
	Mon, 10 Jul 2023 16:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4C33E3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:07:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1122BCA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689005227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWiIZe3IQ53PYjOqAGgSM04HvFoUmNUVGs7k+iQr98s=;
	b=BFbGU9BIE/Y6c2XrrxUkabso142nnTRlWoBwX+1AxVcgR30Fse5kWNS+aIO16bwi21keoU
	V9GEk+9ePwAqyqf0l0qzp0r9DYrqzX6MDK1T2/A/N3JHnXhCHpZ4YYiLxvaNFHcu82B82Q
	7UkA/I+am+cRHA7NgGGayCdT4dTjFKQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-dIE7LkHCPRCSzsQLlw3dlQ-1; Mon, 10 Jul 2023 12:07:05 -0400
X-MC-Unique: dIE7LkHCPRCSzsQLlw3dlQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993d631393fso216963466b.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005224; x=1691597224;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiIZe3IQ53PYjOqAGgSM04HvFoUmNUVGs7k+iQr98s=;
        b=GjHj2GWezSyynjjKjvUNLgLXxWA777dhQOmcAqiiTs3CxqdT/v81TFYs6sNe6LuZfp
         hqdNSnlQb1rr0ry3AnyIjvzTQtuvs6jcgscfQFyULU5EACnt15jHi2IGrGuZJ9lraovN
         FI2awfzG79nCdBwdA3tcRGnvK4+mifgv7TC6dL9glS9D+oJXpvF7SJ1g4/7rQccW/Mc/
         s3y1gI4IMEICPxhtjxHmjcDswAzUegak+DKoeEQ5+QGwNdi+kEU8dbPvDbIzEMS/LAK7
         cN0IP9ZMcPgvFsRFB+30X/X8J0tGK38Jn5qRHmPlgWAon8zQ4yjMb/OajWOustdIHtmt
         cyag==
X-Gm-Message-State: ABy/qLator8T6TNBq+Fgzgnhqa6GQPO7DCK7bPZRYnHYg2xLGX7YrbOt
	vD/9SXlJAanj4+zV4keHaFlI0Sq0P76fu4nJlzXOaxdYCNUraRoBH60satUWWiknIi346fM1GoW
	smmyGuVtjdFC5qrjkRmQuYWsK
X-Received: by 2002:a17:907:3a4a:b0:991:fef4:bb9 with SMTP id fc10-20020a1709073a4a00b00991fef40bb9mr11668552ejc.58.1689005224144;
        Mon, 10 Jul 2023 09:07:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFf54riBNADGeqj5jE2yAEEGB1xUZ+DB0OZq6xJaA2gRL34/NmWlhtp5FmeAhPsifKS0fXuYA==
X-Received: by 2002:a17:907:3a4a:b0:991:fef4:bb9 with SMTP id fc10-20020a1709073a4a00b00991fef40bb9mr11668532ejc.58.1689005223861;
        Mon, 10 Jul 2023 09:07:03 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906115b00b00992b2c55c67sm6241656eja.156.2023.07.10.09.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 09:07:03 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6a492751-8d35-0c81-dd3e-c32417a2e06e@redhat.com>
Date: Mon, 10 Jul 2023 18:07:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, edumazet@google.com, dsahern@gmail.com,
 michael.chan@broadcom.com, willemb@google.com
Subject: Re: [RFC 04/12] net: page_pool: merge page_pool_release_page() with
 page_pool_return_page()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230707183935.997267-1-kuba@kernel.org>
 <20230707183935.997267-5-kuba@kernel.org>
In-Reply-To: <20230707183935.997267-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 07/07/2023 20.39, Jakub Kicinski wrote:
> Now that page_pool_release_page() is not exported we can
> merge it with page_pool_return_page(). I believe that
> the "Do not replace this with page_pool_return_page()"
> comment was there in case page_pool_return_page() was
> not inlined, to avoid two function calls.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I forgot the exact reason, but the "avoid two function calls" argument
makes sense.  As this is no-longer an issues, I'm okay with this change.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   net/core/page_pool.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2c7cf5f2bcb8..7ca456bfab71 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -492,7 +492,7 @@ static s32 page_pool_inflight(struct page_pool *pool)
>    * a regular page (that will eventually be returned to the normal
>    * page-allocator via put_page).
>    */
> -static void page_pool_release_page(struct page_pool *pool, struct page *page)
> +static void page_pool_return_page(struct page_pool *pool, struct page *page)
>   {
>   	dma_addr_t dma;
>   	int count;
> @@ -518,12 +518,6 @@ static void page_pool_release_page(struct page_pool *pool, struct page *page)
>   	 */
>   	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>   	trace_page_pool_state_release(pool, page, count);
> -}
> -
> -/* Return a page to the page allocator, cleaning up our state */
> -static void page_pool_return_page(struct page_pool *pool, struct page *page)
> -{
> -	page_pool_release_page(pool, page);
>   
>   	put_page(page);
>   	/* An optimization would be to call __free_pages(page, pool->p.order)
> @@ -615,9 +609,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>   	 * will be invoking put_page.
>   	 */
>   	recycle_stat_inc(pool, released_refcnt);
> -	/* Do not replace this with page_pool_return_page() */
> -	page_pool_release_page(pool, page);
> -	put_page(page);
> +	page_pool_return_page(pool, page);
>   
>   	return NULL;
>   }


