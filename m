Return-Path: <netdev+bounces-46776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1467E6586
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2111C208D2
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AEAD297;
	Thu,  9 Nov 2023 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKbo6XHb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6A10782
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:44:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E151BDF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699519463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTFEp4CMLoFdUcZdEGfmISXt6fDITsZHDJnL/kZD0Z4=;
	b=cKbo6XHbnavfrKYxdPMwfU9izlpcdyoF8h7ZzedfYYH/SoodiUu/A3yjIKDib7TmpQWEzL
	SWgw/d9doEpWjyUJmxMaozSFido0MJWl+14keAR+kkFJ43+lmlul/J/PwWw95jyCxOKqGY
	vU+CMFFikuL6aNGAN9GmmPG6IDpBnrw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-_DGU9PdoNsmrH7VSrQXhYQ-1; Thu, 09 Nov 2023 03:44:22 -0500
X-MC-Unique: _DGU9PdoNsmrH7VSrQXhYQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d358c03077so8396566b.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699519461; x=1700124261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTFEp4CMLoFdUcZdEGfmISXt6fDITsZHDJnL/kZD0Z4=;
        b=uzHlSHO7It8AEqqrR8OENgAV+Eg6SXh/B78v/SFViUe4vb7nravGC5xZOZ2SzLI1M4
         E8hQCsZ4eIy6DtmTz9uXIoVfAtdNQvjZ+CdneipAwSv9Gxsxar7Gqt5xJeodWWo4QvnQ
         3X2JfxyKiF1ya8ZlwXbcT8E2LMXVcSYRZDfDH6fQDEsdrryFAusWV/1Pfl1x5wj9XVao
         076dSI7/BMp0EFX4WrABsJNmeB3CnYVTxZpvoBEfdYbGZZMb3rRapYmwjO05wq+kMmOC
         6oYP63viB9ZCAz9Kxt/2vZk/e11/NR4yuf4mWwL80OtDfk79s4ayDmAl4o7GTBNKi5dT
         uyew==
X-Gm-Message-State: AOJu0Yyj3vzawQcn6W5DtxrUYhdt5w0AyATkxXI9SGbfuheYTBbj+JmJ
	SVfEzDEWU8+VUCHaLdqYp1vvkj8zbUHH+J5/fIWFvdGTiFp1Jy9Y2U72GY5EGzFvi0Hgln7Xy7C
	iWofHVFe1fOPDsb54
X-Received: by 2002:a17:906:6a0e:b0:9ae:50de:1aaf with SMTP id qw14-20020a1709066a0e00b009ae50de1aafmr3323725ejc.4.1699519461240;
        Thu, 09 Nov 2023 00:44:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpt6f4OXVKtH4i3m412g4H1Y1OUcpmAtKJLGhLybamCWeX8G1/7ze6DLbaN+L9dFmPNZ/PZg==
X-Received: by 2002:a17:906:6a0e:b0:9ae:50de:1aaf with SMTP id qw14-20020a1709066a0e00b009ae50de1aafmr3323714ejc.4.1699519460914;
        Thu, 09 Nov 2023 00:44:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id ha12-20020a170906a88c00b0099d804da2e9sm2235687ejb.225.2023.11.09.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:44:20 -0800 (PST)
Message-ID: <21e4ef7d4a1b4ad298b0688f2b9ce8f5572e1e69.camel@redhat.com>
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
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
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Date: Thu, 09 Nov 2023 09:44:18 +0100
In-Reply-To: <20231106024413.2801438-6-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-6-almasrymina@google.com>
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
[...]
> +void netdev_free_devmem(struct page_pool_iov *ppiov)
> +{
> +	struct netdev_dmabuf_binding *binding =3D page_pool_iov_binding(ppiov);
> +
> +	refcount_set(&ppiov->refcount, 1);
> +
> +	if (gen_pool_has_addr(binding->chunk_pool,
> +			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
> +		gen_pool_free(binding->chunk_pool,
> +			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE);

Minor nit: what about caching the dma_addr value to make the above more
readable?

Cheers,

Paolo


