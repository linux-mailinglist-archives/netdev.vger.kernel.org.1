Return-Path: <netdev+bounces-23322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7EF76B8E6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E89280F1A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7621ADCB;
	Tue,  1 Aug 2023 15:44:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7144DC96
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:44:30 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E52A1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:44:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9ec15e014so5310191a34.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690904668; x=1691509468;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFqYevSgs6Br9AI2U0Cna+lV2yfFaajqsWvesdVwLv8=;
        b=eJ+aV5cCjlqyKv+BLbvDidQHnG+1XNKEJyJer6S5AT2SqnVLy/1xPRHbvP0XKG5Jlc
         Ae7/oP0xwR7jQjyW9PdAZXu+EmYZ3u0VR6jlDRuP7bOgrX0IS8bz00JlXQSCveRw3SFY
         WgOXnubGNlYMe3Qy9reThnKtVVlhyWf/u40rnzD3JeJaeK1o3/ubbfwRxQn4kkidNs1d
         IK3XEOP/AWSrz7oKYL4wYYXCYIjRtDPSRkOgvg4RJRGeVAJ9Kch+yPratVmnvxU+C8lz
         ghZsYl1hEIUlYiBW/jVRe4U1NmJ/1UzJoXF5gM9QjNlpiMbzkUy04VyZmoAsPTqKshdY
         vqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690904668; x=1691509468;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FFqYevSgs6Br9AI2U0Cna+lV2yfFaajqsWvesdVwLv8=;
        b=Hr7L0LojkESBpatTVY3C7hT5kqUfyMmErWHCu8iwIUiAT4XsikVIRB4fL486dxLAus
         oKoMwJo4p9s+dO8UeYcDux1KSAT/DVlsDLbM4/oSz1PTlLC426bfYpwF0cdSic74CbS6
         tTApTwgzsCofdT+Gce7VI6T9td0HLd9vAKY8WPoP2lf7ZI/DvAl2+Oik35yD+1zdjuBY
         KfG9mlMynAn+y9WOCgF8MgcFe+gWLq4s4f+eYvX9pIjNb3JvZWU3Ns7QdkB2iQT6qHEM
         3U5YHWYNrRCgUOyHrxlWYMfCpkHYv4n0uhlBn4fGOTIJcX1Wl5bFYCETxbmAemWceiOm
         0hEw==
X-Gm-Message-State: ABy/qLYp6l838aFSMyET/95+/uISX+ATF4EHM8y6uUvXWLX1d0N6eoCv
	98GXBaZ5vX+HIApub/5GiEs=
X-Google-Smtp-Source: APBJJlEWulh0D6yhEWZB57tDKDmIHVHW3MKvnscV4o5eyqM0RE4Cm55KP9M6z4btanDNTMSsgTz9jQ==
X-Received: by 2002:a05:6358:9392:b0:134:c650:cc0a with SMTP id h18-20020a056358939200b00134c650cc0amr3594982rwb.15.1690904668279;
        Tue, 01 Aug 2023 08:44:28 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id m9-20020a0cdb89000000b0063d2898f210sm4660032qvk.103.2023.08.01.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:44:27 -0700 (PDT)
Date: Tue, 01 Aug 2023 11:44:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Tahsin Erdogan <trdgn@amazon.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230801135455.268935-2-edumazet@google.com>
References: <20230801135455.268935-1-edumazet@google.com>
 <20230801135455.268935-2-edumazet@google.com>
Subject: RE: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to
 allocate bigger packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> Refactor alloc_skb_with_frags() to allow bigger packets allocations.
> 
> Instead of assuming that only order-0 allocations will be attempted,
> use the caller supplied max order.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Tahsin Erdogan <trdgn@amazon.com>
> ---
>  net/core/skbuff.c | 56 +++++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6efdecb87c7ffc8290eafe330583f..0ac70a0144a7c1f4e7824ddc19980aee73e4c121 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6204,7 +6204,7 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
>   *
>   * @header_len: size of linear part
>   * @data_len: needed length in frags
> - * @max_page_order: max page order desired.
> + * @order: max page order desired.
>   * @errcode: pointer to error code if any
>   * @gfp_mask: allocation mask
>   *
> @@ -6212,21 +6212,17 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
>   */
>  struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>  				     unsigned long data_len,
> -				     int max_page_order,
> +				     int order,
>  				     int *errcode,
>  				     gfp_t gfp_mask)
>  {
> -	int npages = (data_len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
>  	unsigned long chunk;
>  	struct sk_buff *skb;
>  	struct page *page;
> -	int i;
> +	int nr_frags = 0;
>  
>  	*errcode = -EMSGSIZE;
> -	/* Note this test could be relaxed, if we succeed to allocate
> -	 * high order pages...
> -	 */
> -	if (npages > MAX_SKB_FRAGS)
> +	if (unlikely(data_len > MAX_SKB_FRAGS * (PAGE_SIZE << order)))
>  		return NULL;
>  
>  	*errcode = -ENOBUFS;
> @@ -6234,34 +6230,32 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>  	if (!skb)
>  		return NULL;
>  
> -	skb->truesize += npages << PAGE_SHIFT;
> -
> -	for (i = 0; npages > 0; i++) {
> -		int order = max_page_order;
> -
> -		while (order) {
> -			if (npages >= 1 << order) {
> -				page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
> -						   __GFP_COMP |
> -						   __GFP_NOWARN,
> -						   order);
> -				if (page)
> -					goto fill_page;
> -				/* Do not retry other high order allocations */

Is this heuristic to only try one type of compound pages and else
fall back onto regular pages still relevant? I don't know the story
behind it.

> -				order = 1;
> -				max_page_order = 0;
> -			}
> +	while (data_len) {
> +		if (nr_frags == MAX_SKB_FRAGS - 1)
> +			goto failure;
> +		while (order && data_len < (PAGE_SIZE << order))
>  			order--;

Why decrement order on every iteration through the loop, not just when
alloc_pages fails?

> +
> +		if (order) {
> +			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
> +					   __GFP_COMP |
> +					   __GFP_NOWARN,
> +					   order);
> +			if (!page) {
> +				order--;
> +				continue;
> +			}
> +		} else {
> +			page = alloc_page(gfp_mask);
> +			if (!page)
> +				goto failure;
>  		}
> -		page = alloc_page(gfp_mask);
> -		if (!page)
> -			goto failure;
> -fill_page:
>  		chunk = min_t(unsigned long, data_len,
>  			      PAGE_SIZE << order);
> -		skb_fill_page_desc(skb, i, page, 0, chunk);
> +		skb_fill_page_desc(skb, nr_frags, page, 0, chunk);
> +		nr_frags++;
> +		skb->truesize += (PAGE_SIZE << order);
>  		data_len -= chunk;
> -		npages -= 1 << order;
>  	}
>  	return skb;
>  
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 



