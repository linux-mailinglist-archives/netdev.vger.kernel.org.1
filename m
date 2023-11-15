Return-Path: <netdev+bounces-48154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2DB7ECA3E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C968B280DF5
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BD3DBA5;
	Wed, 15 Nov 2023 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9mSL6RO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6AC1
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:07:23 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45f3b583ce9so707513137.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700071643; x=1700676443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=237jqdz3sNQ/lMkcIJ++z3uG+l/JTotWsahyw09GVyw=;
        b=Q9mSL6RObvk6NyMJ1igdQ8hfCosR6lmrelkQbqqR+H+GnmVt59tRWJw+AjOk0PR/Pz
         D6wVNaD7HHExG9FLMFuxKw2ciFODZyAGHVgdOw/97eG3koqiQnvz+zxmnEbliXMXekub
         y59fkRzHXu5tm+oHa0gMKewrmCAxTcM+uqST3xDY/8zc32h5IOazcIJlwx0R3zXJcODO
         1thEyHdOuEGc4HYsx9Wrub9C5Jw9noT49u0nZwC/ngaF9aZzVjFbIMxioWk09SE0lTgz
         Y2Rvb4onBis5vLb1e2tIPxbOanq/IjLJ2SfL4fxyz/6CvkvfkCWHtd1lkUyuIgAVJa9T
         MxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700071643; x=1700676443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=237jqdz3sNQ/lMkcIJ++z3uG+l/JTotWsahyw09GVyw=;
        b=dsI7kgsFrpRi0u2/o42OQUMmjyq47cFNJNHZdhBpxzZ1WFoNJYgI3Aug4/3q8jO6JR
         cZ2UfNgK5YZIyQsp7MlAXw4nwv0OYSYUDQ3bIRFJ5nHqdubBcfyii+BFzQKt9Vycr8Sh
         vzxUBcLAlSHiiTPJeNsChoA/lewz8XOQVZC/caWnKm7wVv9r94lZDxnANacqefX6xwp2
         fwMprI9TMohRkMmpidtFuLOde8Lqh+7+Cg4vNnZ21QmpuIqFfRolWb5/O04WqgIIOSZZ
         zh4SgB7TVCewGY8dY6nOCVinRnKfJt4KSvtCi07b9z2y103J7ZavhoodJSUcy5UcwUn4
         dxZA==
X-Gm-Message-State: AOJu0YxnR+K3OVZalyR0WBpbg1bvwtHjYan48UvAe+Bf5fMaIpdu16Ui
	K0B6mxsP38zpAl8anrtVhHPahTLNQ0B80CcUB5YKAg==
X-Google-Smtp-Source: AGHT+IG8CUZxP+tWJWjpLoHj4LC1OTaS/XqIvVoVoDj81d6WPEvc60nVIzPKPJjPrVoQRYOjBqsIakFeKXa7RcJYk5g=
X-Received: by 2002:a05:6102:5c5:b0:452:6d82:56e3 with SMTP id
 v5-20020a05610205c500b004526d8256e3mr4378226vsf.6.1700071642710; Wed, 15 Nov
 2023 10:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com> <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
 <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com> <6553954141762_1245c529423@willemb.c.googlers.com.notmuch>
 <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com>
In-Reply-To: <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 15 Nov 2023 10:07:11 -0800
Message-ID: <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 1:29=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/14 23:41, Willem de Bruijn wrote:
> >>
> >> I am not sure dma-buf maintainer's concern is still there with this pa=
tchset.
> >>
> >> Whatever name you calling it for the struct, however you arrange each =
field
> >> in the struct, some metadata is always needed for dmabuf to intergrate=
 into
> >> page pool.
> >>
> >> If the above is true, why not utilize the 'struct page' to have more u=
nified
> >> handling?
> >
> > My understanding is that there is a general preference to simplify stru=
ct
> > page, and at the least not move in the other direction by overloading t=
he
> > struct in new ways.
>
> As my understanding, the new struct is just mirroring the struct page poo=
l
> is already using, see:
> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/mm_=
types.h#L119
>
> If there is simplifying to the struct page_pool is using, I think the new
> stuct the devmem memory provider is using can adjust accordingly.
>
> As a matter of fact, I think the way 'struct page' for devmem is decouple=
d
> from mm subsystem may provide a way to simplify or decoupled the already
> existing 'struct page' used in netstack from mm subsystem, before this
> patchset, it seems we have the below types of 'struct page':
> 1. page allocated in the netstack using page pool.
> 2. page allocated in the netstack using buddy allocator.
> 3. page allocated in other subsystem and passed to the netstack, such as
>    zcopy or spliced page?
>
> If we can decouple 'struct page' for devmem from mm subsystem, we may be =
able
> to decouple the above 'struct page' from mm subsystem one by one.
>
> >
> > If using struct page for something that is not memory, there is ZONE_DE=
VICE.
> > But using that correctly is non-trivial:
> >
> > https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/
> >
> > Since all we need is a handle that does not leave the network stack,
> > a network specific struct like page_pool_iov entirely avoids this issue=
.
>
> Yes, I am agree about the network specific struct.
> I am wondering if we can make the struct more generic if we want to
> intergrate it into page_pool and use it in net stack.
>
> > RFC v3 seems like a good simplification over RFC v1 in that regard to m=
e.
> > I was also pleasantly surprised how minimal the change to the users of
> > skb_frag_t actually proved to be.
>
> Yes, I am agreed about that too. Maybe we can make it simpler by using
> a more abstract struct as page_pool, and utilize some features of
> page_pool too.
>
> For example, from the page_pool doc, page_pool have fast cache and
> ptr-ring cache as below, but if napi_frag_unref() call
> page_pool_page_put_many() and return the dmabuf chunk directly to
> gen_pool in the memory provider, then it seems we are bypassing the
> below caches in the page_pool.
>

I think you're just misunderstanding the code. The page recycling
works with my patchset. napi_frag_unref() calls napi_pp_put_page() if
recycle =3D=3D true, and that works the same with devmem as with regular
pages.

If recycle =3D=3D false, we call page_pool_page_put_many() which will call
put_page() for regular pages and page_pool_iov_put_many() for devmem
pages. So, the memory recycling works exactly the same as before with
devmem as with regular pages. In my tests I do see the devmem being
recycled correctly. We are not bypassing any caches.


>     +------------------+
>     |       Driver     |
>     +------------------+
>             ^
>             |
>             |
>             |
>             v
>     +--------------------------------------------+
>     |                request memory              |
>     +--------------------------------------------+
>         ^                                  ^
>         |                                  |
>         | Pool empty                       | Pool has entries
>         |                                  |
>         v                                  v
>     +-----------------------+     +------------------------+
>     | alloc (and map) pages |     |  get page from cache   |
>     +-----------------------+     +------------------------+
>                                     ^                    ^
>                                     |                    |
>                                     | cache available    | No entries, re=
fill
>                                     |                    | from ptr-ring
>                                     |                    |
>                                     v                    v
>                           +-----------------+     +------------------+
>                           |   Fast cache    |     |  ptr-ring cache  |
>                           +-----------------+     +------------------+
>
>
> >
> > .
> >



--=20
Thanks,
Mina

