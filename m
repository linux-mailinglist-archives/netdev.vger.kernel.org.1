Return-Path: <netdev+bounces-46826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F47E6936
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E77280FF6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F653199A2;
	Thu,  9 Nov 2023 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjyTf0bP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DB19475
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:09:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921552D44
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699528183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ezu0iXe5WM3zfDfpiwhiAtccNmWTLMMx0akG9lcRF/g=;
	b=CjyTf0bPtHLHNbCf/Zc/P5nwyWCg9EJN7rTfDtuTIsESPnGzL1TLk3Uxe7i4S8C5s8qPqO
	FY4BqMBJTMAMJmOEFb84kEVlp7H97WGguv/j+gmAOKmvGIoT2K3xGuYGH8iXkU7sanhJnr
	gu1/QsT1NWIeoqJ5Dww1Zte7JaFY/7c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-NQVDgQOzM0uvCfE8o9joSg-1; Thu, 09 Nov 2023 06:09:42 -0500
X-MC-Unique: NQVDgQOzM0uvCfE8o9joSg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41eb42115e9so2209051cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 03:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699528182; x=1700132982;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ezu0iXe5WM3zfDfpiwhiAtccNmWTLMMx0akG9lcRF/g=;
        b=lJxGDCMMqizb7u7EZkadhTOUiTus9Cz86GH8/dA+FH9cz+dDhOfYVXBXlObxnqej1W
         5cTkRSzrVWhWPQG68UZH1SYpcfe9XPBdBrH5OlJut0fU1CnRol0sJ5Oit22cngXuNSKK
         ih7XOh/zwjIcSvZPpaDJdA34JGAQIWdNoW2esPIPGK8pHn+h/2ji2w7neAOm0ApJ0WFP
         WIsj8Gaj5Etkg5Mh6581bdrIdOPGlRFxWuPIZ+9KkJHXYIOlocGM2MkBwO/dD3IHotXg
         YoDDyq+RajHYaamcbaIi3QZT+N9Cm2UvjY+1Qyra6Epgydpx/jNoKQ4a2ohJpD2orv+T
         fiug==
X-Gm-Message-State: AOJu0YxYFuHXm+IOVfWSdnVazSun8IF3tj4G0GzSySKzNxD93uqcz7zY
	Kh1LPtIGDONJJN5Ahzz8fHadEPS48HSjsT+Ag7cziSwUqu6LZdD6FVRHio09QAuUSBAuIzU8J2d
	L6B0HIZ0plhNtmltVaVaaIfRx
X-Received: by 2002:a05:622a:2b46:b0:41c:d433:6c86 with SMTP id hb6-20020a05622a2b4600b0041cd4336c86mr5854599qtb.4.1699528182034;
        Thu, 09 Nov 2023 03:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEczlBkEToxT5HA1bWloT/vSc9WPJn4E7V19w/sRlEABI2nrBuMePu+oCzKYFBd5r1xDIeGg==
X-Received: by 2002:a05:622a:2b46:b0:41c:d433:6c86 with SMTP id hb6-20020a05622a2b4600b0041cd4336c86mr5854566qtb.4.1699528181732;
        Thu, 09 Nov 2023 03:09:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id n5-20020ac86745000000b0041977932fc6sm1828045qtp.18.2023.11.09.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:09:41 -0800 (PST)
Message-ID: <fdf6b2e9c5a734b1a03336f7d5bcfd06bdef47c5.camel@redhat.com>
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom
 page providers
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 09 Nov 2023 12:09:37 +0100
In-Reply-To: <20231106024413.2801438-3-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-3-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 6fc5134095ed..d4bea053bb7e 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -60,6 +60,8 @@ struct page_pool_params {
>  	int		nid;
>  	struct device	*dev;
>  	struct napi_struct *napi;
> +	u8		memory_provider;
> +	void            *mp_priv;

Minor nit: swapping the above 2 fields should make the struct smaller.

>  	enum dma_data_direction dma_dir;
>  	unsigned int	max_len;
>  	unsigned int	offset;
> @@ -118,6 +120,19 @@ struct page_pool_stats {
>  };
>  #endif
> =20
> +struct mem_provider;
> +
> +enum pp_memory_provider_type {
> +	__PP_MP_NONE, /* Use system allocator directly */
> +};
> +
> +struct pp_memory_provider_ops {
> +	int (*init)(struct page_pool *pool);
> +	void (*destroy)(struct page_pool *pool);
> +	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> +	bool (*release_page)(struct page_pool *pool, struct page *page);
> +};
> +
>  struct page_pool {
>  	struct page_pool_params p;
> =20
> @@ -165,6 +180,9 @@ struct page_pool {
>  	 */
>  	struct ptr_ring ring;
> =20
> +	const struct pp_memory_provider_ops *mp_ops;
> +	void *mp_priv;

Why the mp_ops are not part of page_pool_params? why mp_priv is
duplicated here?

Cheers,

Paolo


