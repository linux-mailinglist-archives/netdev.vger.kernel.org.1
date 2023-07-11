Return-Path: <netdev+bounces-16933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC274F72F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCED1C203DB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395851E505;
	Tue, 11 Jul 2023 17:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EF17FE0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:24:45 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A721728
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:24:24 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7948540a736so2018969241.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689096263; x=1691688263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxEt0Z2eexi8Ljxbl6AxsjACGcp0PhbeI1Zbkig5Ea8=;
        b=2MNo9qcQE70ijvOMfhfeCr5b57NMCaHmxyfLaple5c0ON72I6Fl6KkCpEF2ZUAP6Ja
         V0z2dG+x+IsgZmudM/8wwO3HeFqajJZZHGPKbEt6SALfCu+Pjnxdii+e3bsqiFj2E3my
         Y/ErVdBmKyVEkX5L9MQap9ZPz0HWB43sGOmSZ/vOEk0haEGCaJ4BXm0i68AOESbjIK//
         yHeVhjhPwmEJgs7OzM7NHltcgWysktGwYwz4yjqmTJOBKT8q9CDeeMZvsmkc/oZsH0tp
         3B2iJT8PUjxWK3Udzzlf3cKSa9yNqS4nY+xFqcPU5ISJors0n4DWQZ0X9dxbx9KCcKzN
         SXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096263; x=1691688263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxEt0Z2eexi8Ljxbl6AxsjACGcp0PhbeI1Zbkig5Ea8=;
        b=EiTNEZSstPkbmNWQvgnYXVpIwg2j+pgqLR6VHzq6PbHJB7n69+X0vDeFCoxxzIFdeo
         IRwWV+7R7bHqNQAfaMCg9U8tPzU5RjSR8okRNNikPsEMMtwFr+ceg5dopu+XX6MS5Obq
         YDNtzdN4tbvdYPVZfAqJxDSUOjaoehHyc2BQ61sM7gRAXsmN1byy4ZnZOoIkQOwAXJmG
         aqgXaZ8OtYIHeExXG6A1uvLlG8HSb2OGWnjUI8hpVcPCEglsbb683JaBlslFucQhfLKf
         uBNS+aWN2gLO90edoB/N6d/2FaGKTcLEe0qoLRvsBSBuJwqZX6+Rw0DmmE1nEaZiHXl8
         Vy7g==
X-Gm-Message-State: ABy/qLbBfMCa48gyLKP0wpktVvButV2nCJhBnCo+tf+R38SU6wKc587Q
	gpWbZ5qNQ+30q/UU9drW1msjE5iAG/ALX62v/2X6Dg==
X-Google-Smtp-Source: APBJJlEbNbeKglx24tA12e4BmXAPi9rr0ZNOak9iV8KnYQWaC46zN/l1EJsSvydC+DrZ4BU4kBJ0Te5mDCNhUBfgEcw=
X-Received: by 2002:a67:fd59:0:b0:440:cfc5:f91a with SMTP id
 g25-20020a67fd59000000b00440cfc5f91amr8676055vsr.29.1689096263370; Tue, 11
 Jul 2023 10:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619110705.106ec599@kernel.org> <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca> <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca> <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca> <CAHS8izOTiSO5PkM+x-CASjwew=U2j=JRNpbz_6NC6AsDTQ17Ug@mail.gmail.com>
 <ZK1U/Vo0NvhNm9pq@ziepe.ca>
In-Reply-To: <ZK1U/Vo0NvhNm9pq@ziepe.ca>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Jul 2023 10:24:11 -0700
Message-ID: <CAHS8izOnw8KEu_Sm7Vf3UfqD88XheTBDHkoTmBx7r=i9g0pJRw@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, logang@deltatee.com
Cc: Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, 
	Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
	Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Eric Dumazet <edumazet@google.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 6:11=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jul 10, 2023 at 05:45:05PM -0700, Mina Almasry wrote:
>
> > > At least from my position I want to see MEMORY_DEVICE_PCI_P2PDMA used
> > > to represent P2P memory.
> >
> > Would using p2pdma API instead of dmabuf be an acceptable direction?
>
> "p2pdma API" is really just using MEMORY_DEVICE_PCI_P2PDMA and
> teaching the pagepool how to work with ZONE_DEVICE pages.
>

Yes, that's what I have in mind. Roughly something along the lines
where the device memory provider (GPU or what not) does something like
a pci_p2pdma_add_resource(), and the NIC client driver allocates the
pages from the resource, and if is_pci_p2pdma_page() use
pci_p2pdma_map_sg() instead of dma_map_sg() and whatnot.

> I suspect this will clash badly with Matthew's work here:
>
> https://lore.kernel.org/all/20230111042214.907030-1-willy@infradead.org/
>
> As from a mm side we haven't ever considered that ZONE_DEVICE and
> "netmem" can be composed together. The entire point of netmem like
> stuff is that the allocator hands over the majority of struct page to
> the allocatee, and ZONE_DEVICE can't work like that.
>
> However, assuming that can be solved in some agreeable way then it
> would be OK to go down this path.
>

I think there is potential to solve this in an agreeable way. We may
be able to get netmem ZONE_DEVICE pages using the memdesc idea you
proposed, or something like the xarray meta data you mention below. If
not that, I think Jakub already said that he is considering coming up
with a 'page pool like' API that drivers can use, with an
implementation that is compatible with ZONE_DEVICE pages.

> But, I feel like this is just overall too hard a direction from the mm
> perspective.
>
> I don't know anything about page pool, but the main sticking point is
> its reliance on struct page. If it can find another way to locate its
> meta data (eg an xarray), at least for some cases, it would make
> things alot easier.
>



--=20
Thanks,
Mina

