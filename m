Return-Path: <netdev+bounces-46735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF37E621E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A84E280FFC
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9715A1;
	Thu,  9 Nov 2023 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlyDzmSO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382B15C2
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:22:30 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E1726A4
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:22:29 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba45fc8619so132989241.2
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 18:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699496549; x=1700101349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSPMpbnqaJyO3ODc5clIYENUiJuL1UHQWRmXr36pztw=;
        b=RlyDzmSOWrFr2afjl1LMHYfOrfjAq/WxdLFn/kSO6f/ZQtOEw3Rf7b3uNFdoM3NrJ+
         Ard2qe0iR6mXwfz0+70E/pK+NvnMlhGPVAHhAZBWL63PoKS0SbHu8Zjxaghp7j59tCHq
         qjsRyTS4EePECuSsp4s91yH1nG3exRl4U7lPVnbzU4lMVhXCulPTm7JmkxXaPRBXwMyX
         nwo4urL1D9ltIMRWul9nNlU7AwBYIXGwzS5+StuAoIhEUH3RjzfIGgh7akbjrj80aDit
         zmBxk8xGrciLKlnBbS0orzy/XLs2F3QaVUL8wDqFbE48bNY6COpU1yuPiuuviInS10SI
         vl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699496549; x=1700101349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSPMpbnqaJyO3ODc5clIYENUiJuL1UHQWRmXr36pztw=;
        b=DsnX81fqmaEKlzRtTsdoqUrb6TV+HXyWBJ5JBEWudPEjRtq93VJi5p1a9UyT89LyPB
         KM1NMykvhVB+7qOFUOVWm0bp2UtB2O9E0DOSOlTQGm+N4lqHWnNn4O50o6GCVl6gZm3j
         tpYmDEnIhbRJytYcNjqOWxzfscaU+1gfbTzWIIJz/PFNHZeDEjG4S2dVfy5/CFuTiqvK
         UWHcyA+VvdqTR0sY5r5bgbrj42D3SBSg6EB7l7CvKunWPzYnz54JVPMCTqky+1WQL/kD
         0MFno1z/BEVRoKnYji7X5YjRBUS6kZPlniaLGGIfCVhjNaMKAva6oVHyo//TF9WjZp8/
         Q9Vw==
X-Gm-Message-State: AOJu0YwzuO67LCeb3sNX6ScLQHJAMa4QhOQIO7V69d4wDl6UVxb/jDA2
	T5QtmrfayOX8BLzN2ILLDfYcxEAiwNw1b7lbTslp4A==
X-Google-Smtp-Source: AGHT+IEbBLd4OCYTD+BfgjfRtM1GreJwxjpgz5yBDiudeMGW3y2SaeG7nGhsX8PgjqXOfiWkFQ0hU/lXsKFFFArEvCc=
X-Received: by 2002:a05:6102:104f:b0:45d:a05f:8d7d with SMTP id
 h15-20020a056102104f00b0045da05f8d7dmr3347254vsq.22.1699496548881; Wed, 08
 Nov 2023 18:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
 <CAHS8izPV3isMWyjFnr7bJDDPANg-zm_M=UbHyuhYWv1Viy7fRw@mail.gmail.com> <c1b689bd-a05b-85e9-0ce4-7264c818c2dc@huawei.com>
In-Reply-To: <c1b689bd-a05b-85e9-0ce4-7264c818c2dc@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 8 Nov 2023 18:22:17 -0800
Message-ID: <CAHS8izMXkaGE_jqYJJk9KpfxWEYDu95XAJNqajws57QWV2yRJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 7:40=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/11/8 5:59, Mina Almasry wrote:
> > On Mon, Nov 6, 2023 at 11:46=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/11/6 10:44, Mina Almasry wrote:
> >>> +
> >>> +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *bind=
ing)
> >>> +{
> >>> +     size_t size, avail;
> >>> +
> >>> +     gen_pool_for_each_chunk(binding->chunk_pool,
> >>> +                             netdev_devmem_free_chunk_owner, NULL);
> >>> +
> >>> +     size =3D gen_pool_size(binding->chunk_pool);
> >>> +     avail =3D gen_pool_avail(binding->chunk_pool);
> >>> +
> >>> +     if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%lu, =
avail=3D%lu",
> >>> +               size, avail))
> >>> +             gen_pool_destroy(binding->chunk_pool);
> >>
> >>
> >> Is there any other place calling the gen_pool_destroy() when the above
> >> warning is triggered? Do we have a leaking for binding->chunk_pool?
> >>
> >
> > gen_pool_destroy BUG_ON() if it's not empty at the time of destroying.
> > Technically that should never happen, because
> > __netdev_devmem_binding_free() should only be called when the refcount
> > hits 0, so all the chunks have been freed back to the gen_pool. But,
> > just in case, I don't want to crash the server just because I'm
> > leaking a chunk... this is a bit of defensive programming that is
> > typically frowned upon, but the behavior of gen_pool is so severe I
> > think the WARN() + check is warranted here.
>
> It seems it is pretty normal for the above to happen nowadays because of
> retransmits timeouts, NAPI defer schemes mentioned below:
>
> https://lkml.kernel.org/netdev/168269854650.2191653.8465259808498269815.s=
tgit@firesoul/
>
> And currently page pool core handles that by using a workqueue.

Forgive me but I'm not understanding the concern here.

__netdev_devmem_binding_free() is called when binding->ref hits 0.

binding->ref is incremented when an iov slice of the dma-buf is
allocated, and decremented when an iov is freed. So,
__netdev_devmem_binding_free() can't really be called unless all the
iovs have been freed, and gen_pool_size() =3D=3D gen_pool_avail(),
regardless of what's happening on the page_pool side of things, right?

--=20
Thanks,
Mina

