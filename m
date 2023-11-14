Return-Path: <netdev+bounces-47723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDA7EB069
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DDFB20AB8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43E3FE22;
	Tue, 14 Nov 2023 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgLWtCeA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D53FB3A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:58:21 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B788196
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:58:19 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45d8c405696so1996170137.3
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699966698; x=1700571498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS8IAn5PULatUOjoN0juShog4xVcwSnYkfc1t7O7Fqc=;
        b=zgLWtCeAYL2C2gKK2qs7YktWDrMB8x6eebTgjQ85r5THZ8PXiS5Ucp3LRNEOxiNPyO
         A7w6lYO74SkU10VuWjuL/3NLrXq49rxklDF+pX3L+HQWwtl7JX80/efJDwh5VYqO62WO
         /GQRFrYKeLxxIvGI91Va2S45b4eGodIYxEzhzDf+jgBKj03ZxbLc2tI2vZlYYPfnQkfi
         fvyhtfGCbEDId2yX0iS9q4wqvXu3S1aMciCRKQvKpa4xKbQ6lqx/o0poQx4mo67WhJ49
         bWLKKmYFeynAJNgCFZ6HNUwCRFIq/ybFxkNzKP9NNAPjnB8AwTew41GIt6dHqcMQ2EzA
         x0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966698; x=1700571498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS8IAn5PULatUOjoN0juShog4xVcwSnYkfc1t7O7Fqc=;
        b=ngtSQ3rNPXz+Bu8dUapo0BbfCZlDFH4btY/IZU/EkonUi8Dif330Qrl6DOskED0Bou
         rMqzZ3LVRIxVNF8UqSu/EnkWtEoMadpcMpwaufo+dbasooHsv4s5tutsHn/I5bMT3Rsd
         w4WPI5Artj37enukLiISw84W/7OUu+v8ZJq2d/TRf1yBBx8Cs4m+7rRHkfv82jOSzjhl
         4/CKANBNbXagIH/PGUSoCes8CXiJ4wdkUuXBdzhAko2zhAIyAold2YQVVQMxEPpbKHSv
         U8rSfjiKD/2PWDhbJ3erhrjEvQgwFy0AzwdQ6aA76gcxMZfNjnSFYQSGGSt1AUuQZKaD
         63vQ==
X-Gm-Message-State: AOJu0YwXkMGiJcBr3a4xANvTKC1PXC03ah9obxifXCMh4pFyNxAA/wAO
	zdFF/MxCJuO/z7XiY5uoacZ3x17MJfe/mM8iqpMZLA==
X-Google-Smtp-Source: AGHT+IEenboxEXPbs90yp1639VqsCglLDY6FsP46EbOdp/50wGHYhS7OCQcFdZpT4KtLJ77fxxytJq6E2le6U4eGtFw=
X-Received: by 2002:a67:c999:0:b0:45f:1d2:30d7 with SMTP id
 y25-20020a67c999000000b0045f01d230d7mr7570368vsk.8.1699966698373; Tue, 14 Nov
 2023 04:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com> <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com>
In-Reply-To: <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 14 Nov 2023 04:58:05 -0800
Message-ID: <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 4:49=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/14 20:21, Mina Almasry wrote:
> > On Tue, Nov 14, 2023 at 12:23=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>
> >> +cc Christian, Jason and Willy
> >>
> >> On 2023/11/14 7:05, Jakub Kicinski wrote:
> >>> On Mon, 13 Nov 2023 05:42:16 -0800 Mina Almasry wrote:
> >>>> You're doing exactly what I think you're doing, and what was nacked =
in RFC v1.
> >>>>
> >>>> You've converted 'struct page_pool_iov' to essentially become a
> >>>> duplicate of 'struct page'. Then, you're casting page_pool_iov* into
> >>>> struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
> >>>> mm APIs like page_ref_*() on the page_pool_iov* because you've foole=
d
> >>>> the mm stack into thinking dma-buf memory is a struct page.
> >>
> >> Yes, something like above, but I am not sure about the 'fooled the mm
> >> stack into thinking dma-buf memory is a struct page' part, because:
> >> 1. We never let the 'struct page' for devmem leaking out of net stacki=
ng
> >>    through the 'not kmap()able and not readable' checking in your patc=
hset.
> >
> > RFC never used dma-buf pages outside the net stack, so that is the same=
.
> >
> > You are not able to get rid of the 'net kmap()able and not readable'
> > checking with this approach, because dma-buf memory is fundamentally
> > unkmapable and unreadable. This approach would still need
> > skb_frags_not_readable checks in net stack, so that is also the same.
>
> Yes, I am agreed that checking is still needed whatever the proposal is.
>
> >
> >> 2. We inititiate page->_refcount for devmem to one and it remains as o=
ne,
> >>    we will never call page_ref_inc()/page_ref_dec()/get_page()/put_pag=
e(),
> >>    instead, we use page pool's pp_frag_count to do reference counting =
for
> >>    devmem page in patch 6.
> >>
> >
> > I'm not sure that moves the needle in terms of allowing dma-buf
> > memory to look like struct pages.
> >
> >>>>
> >>>> RFC v1 was almost exactly the same, except instead of creating a
> >>>> duplicate definition of struct page, it just allocated 'struct page'
> >>>> instead of allocating another struct that is identical to struct pag=
e
> >>>> and casting it into struct page.
> >>
> >> Perhaps it is more accurate to say this is something between RFC v1 an=
d
> >> RFC v3, in order to decouple 'struct page' for devmem from mm subsyste=
m,
> >> but still have most unified handling for both normal memory and devmem
> >> in page pool and net stack.
> >>
> >> The main difference between this patchset and RFC v1:
> >> 1. The mm subsystem is not supposed to see the 'struct page' for devme=
m
> >>    in this patchset, I guess we could say it is decoupled from the mm
> >>    subsystem even though we still call PageTail()/page_ref_count()/
> >>    page_is_pfmemalloc() on 'struct page' for devmem.
> >>
> >
> > In this patchset you pretty much allocate a struct page for your
> > dma-buf memory, and then cast it into a struct page, so all the mm
> > calls in page_pool.c are seeing a struct page when it's really dma-buf
> > memory.
> >
> > 'even though we still call
> > PageTail()/page_ref_count()/page_is_pfmemalloc() on 'struct page' for
> > devmem' is basically making dma-buf memory look like struct pages.
> >
> > Actually because you put the 'strtuct page for devmem' in
> > skb->bv_frag, the net stack will grab the 'struct page' for devmem
> > using skb_frag_page() then call things like page_address(), kmap,
> > get_page, put_page, etc, etc, etc.
>
> Yes, as above, skb_frags_not_readable() checking is still needed for
> kmap() and page_address().
>
> get_page, put_page related calling is avoided in page_pool_frag_ref()
> and napi_pp_put_page() for devmem page as the above checking is true
> for devmem page:
> (pp_iov->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE
>

So, devmem needs special handling with if statement for refcounting,
even after using struct pages for devmem, which is not allowed (IIUC
the dma-buf maintainer).

> >
> >> The main difference between this patchset and RFC v3:
> >> 1. It reuses the 'struct page' to have more unified handling between
> >>    normal page and devmem page for net stack.
> >
> > This is what was nacked in RFC v1.
> >
> >> 2. It relies on the page->pp_frag_count to do reference counting.
> >>
> >
> > I don't see you change any of the page_ref_* calls in page_pool.c, for
> > example this one:
> >
> > https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L60=
1
> >
> > So the reference the page_pool is seeing is actually page->_refcount,
> > not page->pp_frag_count? I'm confused here. Is this a bug in the
> > patchset?
>
> page->_refcount is the same as page_pool_iov->_refcount for devmem, which
> is ensured by the 'PAGE_POOL_MATCH(_refcount, _refcount);', and
> page_pool_iov->_refcount is set to one in mp_dmabuf_devmem_alloc_pages()
> by calling 'refcount_set(&ppiov->_refcount, 1)' and always remains as one=
.
>
> So the 'page_ref_count(page) =3D=3D 1' checking is always true for devmem=
 page.

Which, of course, is a bug in the patchset, and it only works because
it's a POC for you. devmem pages (which shouldn't exist according to
the dma-buf maintainer, IIUC) can't be recycled all the time. See
SO_DEVMEM_DONTNEED patch in my RFC and refcounting needed for devmem.

--=20
Thanks,
Mina

