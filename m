Return-Path: <netdev+bounces-48305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB57EDFE4
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8271C20878
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048F2E632;
	Thu, 16 Nov 2023 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLRDGWJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736EDA
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:31:08 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4ac71c558baso254977e0c.2
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700134267; x=1700739067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5ZN/4d17A7tB0MhyQTTzrWx/HMOUSq5lA4jSyJp+JY=;
        b=dLRDGWJf4zNUR4H7RfGacDCuD2S86aykgyrzMZrPGMASFO3+YE45G6STwedAvruSph
         Ingm5tX++H+YkQIOcl5Hpe9QXF5CjFajZnChinoOlxXsvs7P+E36/DyTUnJllDJs2ybr
         Ce+HBOPNNMDY75daNeP7Qo/L1Mcz0lu1x3n4dFpoW74IGJrJWuIjwXYA1Vy357tf/z8n
         8xzwdn/alFYnznKaheCNWehTq8jMG3sWWqTtM5jKBBnd0qoCAFw2DFRJuOcb9i1lLn9x
         8rs2V2MQU1RFNP45ZRtdDbQ7qeOhDWxZF7zry3hkBNWO+wdwUh4ZVqDK/EJPb9oVEF4+
         r5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134267; x=1700739067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5ZN/4d17A7tB0MhyQTTzrWx/HMOUSq5lA4jSyJp+JY=;
        b=jirmbD5VO5K+Cb7otoj1dIF4L/ME1pmsokmexfxHgVtSnyAIo+sk+LoVAlb/ncWvx+
         nphuDMj2r2C9piQgtuC0Tf+LcRgvbqo32iJzOe09MI3oEnvOEqeYgfYJhzZB5kQUq0eK
         tWAeZEdO32JpLAvgV2tPV3+xiuoSZuReYgUo3QzO7sRZeU1i+t0nHS8LRxgPgyrTftct
         Y5w/3aWFrbbz1iWs3TI2CcFayQS2b7fMxdfvxLnaOn/D2Jd7aAU1Rizt2CsYgT/F5+YJ
         atYAQMQpYbboq/AbB4ti/rAOb8xuhOuxx0p4gFVyohfgof6Kx4nvcaflRbgDHBKrCcNo
         lOeQ==
X-Gm-Message-State: AOJu0YxHma0IwV3LjQTJfDnE2v0BUZbB4X8v/T8b3ChMvQiUG+YXfFgi
	50CiB4wc/n/Gk0eNlRBIsdRyluhaMUAEuMC/UiLbig==
X-Google-Smtp-Source: AGHT+IHFKFgWat9IoRWwq8su2ufFgXT3dkMF7jf+D3n8ImjCoAZTvVLo9HLgvhei72vQNdk1/LYi/TVgFGX3xOftTNk=
X-Received: by 2002:a05:6122:914:b0:4ac:b0a6:4c16 with SMTP id
 j20-20020a056122091400b004acb0a64c16mr12023352vka.10.1700134267121; Thu, 16
 Nov 2023 03:31:07 -0800 (PST)
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
 <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com> <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
 <CAHS8izO8bJSpD9ziNQHxpraLsUc8JnazgLA5=ziDBtzriRSQHA@mail.gmail.com> <0366d9e8-7796-b15a-d309-d2fd81f9d700@huawei.com>
In-Reply-To: <0366d9e8-7796-b15a-d309-d2fd81f9d700@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 16 Nov 2023 03:30:53 -0800
Message-ID: <CAHS8izNBq_p4otYi+RFNdRfjXvWMjYJoxYrrp24Q4gTaaRX+wQ@mail.gmail.com>
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

On Thu, Nov 16, 2023 at 3:12=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/16 3:05, Mina Almasry wrote:
> > On Wed, Nov 15, 2023 at 10:07=E2=80=AFAM Mina Almasry <almasrymina@goog=
le.com> wrote:
> >>
> >> On Wed, Nov 15, 2023 at 1:29=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>
> >>> On 2023/11/14 23:41, Willem de Bruijn wrote:
> >>>>>
> >>>>> I am not sure dma-buf maintainer's concern is still there with this=
 patchset.
> >>>>>
> >>>>> Whatever name you calling it for the struct, however you arrange ea=
ch field
> >>>>> in the struct, some metadata is always needed for dmabuf to intergr=
ate into
> >>>>> page pool.
> >>>>>
> >>>>> If the above is true, why not utilize the 'struct page' to have mor=
e unified
> >>>>> handling?
> >>>>
> >>>> My understanding is that there is a general preference to simplify s=
truct
> >>>> page, and at the least not move in the other direction by overloadin=
g the
> >>>> struct in new ways.
> >>>
> >>> As my understanding, the new struct is just mirroring the struct page=
 pool
> >>> is already using, see:
> >>> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux=
/mm_types.h#L119
> >>>
> >>> If there is simplifying to the struct page_pool is using, I think the=
 new
> >>> stuct the devmem memory provider is using can adjust accordingly.
> >>>
> >>> As a matter of fact, I think the way 'struct page' for devmem is deco=
upled
> >>> from mm subsystem may provide a way to simplify or decoupled the alre=
ady
> >>> existing 'struct page' used in netstack from mm subsystem, before thi=
s
> >>> patchset, it seems we have the below types of 'struct page':
> >>> 1. page allocated in the netstack using page pool.
> >>> 2. page allocated in the netstack using buddy allocator.
> >>> 3. page allocated in other subsystem and passed to the netstack, such=
 as
> >>>    zcopy or spliced page?
> >>>
> >>> If we can decouple 'struct page' for devmem from mm subsystem, we may=
 be able
> >>> to decouple the above 'struct page' from mm subsystem one by one.
> >>>
> >>>>
> >>>> If using struct page for something that is not memory, there is ZONE=
_DEVICE.
> >>>> But using that correctly is non-trivial:
> >>>>
> >>>> https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/
> >>>>
> >>>> Since all we need is a handle that does not leave the network stack,
> >>>> a network specific struct like page_pool_iov entirely avoids this is=
sue.
> >>>
> >>> Yes, I am agree about the network specific struct.
> >>> I am wondering if we can make the struct more generic if we want to
> >>> intergrate it into page_pool and use it in net stack.
> >>>
> >>>> RFC v3 seems like a good simplification over RFC v1 in that regard t=
o me.
> >>>> I was also pleasantly surprised how minimal the change to the users =
of
> >>>> skb_frag_t actually proved to be.
> >>>
> >>> Yes, I am agreed about that too. Maybe we can make it simpler by usin=
g
> >>> a more abstract struct as page_pool, and utilize some features of
> >>> page_pool too.
> >>>
> >>> For example, from the page_pool doc, page_pool have fast cache and
> >>> ptr-ring cache as below, but if napi_frag_unref() call
> >>> page_pool_page_put_many() and return the dmabuf chunk directly to
> >>> gen_pool in the memory provider, then it seems we are bypassing the
> >>> below caches in the page_pool.
> >>>
> >>
> >> I think you're just misunderstanding the code. The page recycling
> >> works with my patchset. napi_frag_unref() calls napi_pp_put_page() if
> >> recycle =3D=3D true, and that works the same with devmem as with regul=
ar
> >> pages.
> >>
> >> If recycle =3D=3D false, we call page_pool_page_put_many() which will =
call
> >> put_page() for regular pages and page_pool_iov_put_many() for devmem
> >> pages. So, the memory recycling works exactly the same as before with
> >> devmem as with regular pages. In my tests I do see the devmem being
> >> recycled correctly. We are not bypassing any caches.
> >>
> >>
> >
> > Ah, taking a closer look here, the devmem recycling works for me but I
> > think that's a side effect to the fact that the page_pool support I
> > implemented with GVE is unusual. I currently allocate pages from the
> > page_pool but do not set skb_mark_for_recycle(). The page recycling
> > still happens when GVE is done with the page and calls
> > page_pool_put_full_pgae(), as that eventually checks the refcount on
> > the devmem and recycles it.
> >
> > I will fix up the GVE to call skb_mark_for_recycle() and ensure the
> > napi_pp_put_page() path recycles the devmem or page correctly in the
> > next version.
>
> What about other features? Like dma mapping optimization and frag support
> in the page pool.
>

PP_FLAG_DMA_MAP will be supported and required in the next version per
Jakub's request.

frag support is something I disabled in the initial versions of the
patchset, but only out of convenience and to simplify the initial
implementation. At google we typically use page aligned MSS and the
frag support isn't really that useful for us. I don't see an issue
extending frag support to devmem and iovs in the future if needed.
We'd probably add the pp_frag_count field to page_pool_iov and handle
it similarly to how it's handled for pages.

> I understand that you use some trick in the gen_gool to avoid the per chu=
nk
> dma_addr storage in the 'struct page_pool_iov' and do not need frag suppo=
rt
> for now.
>
> But for other memory provider, if they need those supports, we probably n=
eed
> to extend 'struct page_pool_iov' to support those features, then we may h=
ave
> a 'struct page_pool_iov' to be looking alike to the sepcific union for pa=
ge_pool
> in 'struct page', see:
>
> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/mm_=
types.h#L119
>
> We currently don't have a way to decouple the existing 'struct page' from=
 mm
> subsystem yet as my understanding, if we don't mirror the above union in =
the
> 'struct page', we may have more 'if' checking added in the future.



--=20
Thanks,
Mina

