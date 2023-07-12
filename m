Return-Path: <netdev+bounces-17321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0AD7513B8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202741C210B2
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15771D2E8;
	Wed, 12 Jul 2023 22:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFA384
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:42:02 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5919A6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:42:00 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-794779e1044so11062241.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689201720; x=1691793720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz/xfQs228JkD+EmKHVt4aMZuBD4Ky+nWhlpQiowkyI=;
        b=3JuEXg+yPSc6oD9k/gVHY9JmrXpcmYz2DdmUKfAenXycWth8Ys52+0sfJNBJqhx+JA
         POfjtfGzT4R2YWrxkgajUcAHuZwh0tHTbms8ZnyvNuUeIHHVBkyqjnNmi7pVjn+1p2XO
         FT+BJijgfx1i+WKA7jlT7PyuiJDtM4V2bSpZ2ORkcz5BPrprzhZVrwTkYbGJtevpuwWu
         +4s8IYxiO+jzUiXLxbNo6SvC/rtIpPMvBFlxMxrSFT5yrglpO/RRHqDNwsQ7XIWt3Mrm
         6q7/TIQmwLLzR3bbJ6UgAadSF6ClWCYMawulX/tcO2I2umBPB5clyz54VDHR+jYWjASk
         +o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201720; x=1691793720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz/xfQs228JkD+EmKHVt4aMZuBD4Ky+nWhlpQiowkyI=;
        b=Myh9ehsYdNpJnjare7UF5NJFcw1viEsmqZVzVrFrqqxJU2WnMK1rQj2Qh00Q3G9+Da
         bn2Sat3LyXBnnMIoOItGknkzBFNM5b4MmaNrkWqepLQDmMZNbrFiral4tSLKBqY/51hn
         n7fQZKHwbuNg3nt+su3kLF4VwasNemE1FTag/P1l+NJYWXKpcdTzTo+SrudrWnQ0Lv7b
         PvuVvTbrmn+RVscPEvSZpU92tiCns0a89p0C80a4Nnv3kqREI/frbKE/UW7Df/o3q5Rb
         s07YzKeravwgzOOqXfxrT6k/8mcglqb9HfpiAZLVBMEGp+B0oU5tyUXJ+4APkjIXYmSZ
         OnaQ==
X-Gm-Message-State: ABy/qLami0mNOQLk0ZTGugMl1PT48oKjhL4aooCfGFCA15ERqwGGBpwp
	dxXxXP4LBhM3iwNxBKZ3ZVZOt5YJE3JPDl01ahwuLg==
X-Google-Smtp-Source: APBJJlHG9tuCdU7vOjJOYos5RKoNNv0/pCxlxo2gIMlFQovsMtvJLWra+WgillnY1AK2C/ycTstYjvsR47Bt+BOekOU=
X-Received: by 2002:a67:b407:0:b0:443:4eca:f7f0 with SMTP id
 x7-20020a67b407000000b004434ecaf7f0mr99255vsl.11.1689201719631; Wed, 12 Jul
 2023 15:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711050445.GA19323@lst.de> <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org> <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org> <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org> <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <20f6cbda-e361-9a81-de51-b395ec13841a@amd.com> <ZK6ktnwIjXIobFIM@ziepe.ca> <4f6e62e0-b4c2-9fca-6964-28cfea902de0@amd.com>
In-Reply-To: <4f6e62e0-b4c2-9fca-6964-28cfea902de0@amd.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Jul 2023 15:41:47 -0700
Message-ID: <CAHS8izPK4DZ-7JKuxh712tjuh1zpB+Stu6aSdC6vbN3YWHLfMg@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Ahern <dsahern@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
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
	Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 6:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 12.07.23 um 15:03 schrieb Jason Gunthorpe:
> > On Wed, Jul 12, 2023 at 09:55:51AM +0200, Christian K=C3=B6nig wrote:
> >
> >>> Anyone see any glaring issues with this approach? I plan on trying to
> >>> implement a PoC and sending an RFC v2.
> >> Well we already have DMA-buf as user API for this use case, which is
> >> perfectly supported by RDMA if I'm not completely mistaken.
> >>
> >> So what problem do you try to solve here actually?
> > In a nutshell, netdev's design currently needs struct pages to do DMA
> > to it's packet buffers.
> >
> > So it cannot consume the scatterlist that dmabuf puts out
> >
> > RDMA doesn't need struct pages at all, so it is fine.
> >
> > If Mina can go down the path of changing netdev to avoid needing
> > struct pages then no changes to DRM side things.
> >
> > Otherwise a P2P struct page and a co-existance with netmem on a
> > ZONE_DEVICE page would be required. :\
>
> Uff, depending on why netdev needs struct page (I think I have a good
> idea why) this isn't really going to work generically either way.
>
> What we maybe able to do is to allow copy_file_range() between DMA-buf
> file descriptor and a TCP socket.
>
> If I'm not completely mistaken that should then end up in DMA-bufs
> file_operations->copy_file_range callback (maybe with some minor change
> to allows this).
>
> The DMA-buf framework could then forward this to the exporter of the
> memory which owns the backing memory could then do the necessary steps.
>

I may be missing something, but the way it works on our end for
receive is that we give a list of buffers (dma_addr + length + other
metadata) to the network card, and the network card writes incoming
packets to these dma_addrs and gives us an rx completion pointing to
the data it DMA'd. Usually the network card does something like an
alloc_page() + dma_map_page() and provides the to the network card.
Transmit path works similarly. Not sure that adding copy_file_range()
support to dma-buf enables this in some way.

--=20
Thanks,
Mina

