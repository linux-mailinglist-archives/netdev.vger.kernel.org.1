Return-Path: <netdev+bounces-14698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D897432BE
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 04:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB04280F15
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3FE17E1;
	Fri, 30 Jun 2023 02:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F617D4
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 02:28:04 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D035AA
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:27:59 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-440ad576d87so536760137.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688092078; x=1690684078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTo9hY6za6sp4iN6jnPaCNqbOXw5FRoNumhZ0qdWDT0=;
        b=VTJbmNvHjTej6lTE/CJNYZ8fA/ivIlXHmJZFdOes0lUdz1zqTfw57H4fzp1rceKSSC
         KUDAuNDxQqD7xl3FXiJ0X3uKm6wsNeq4fJ9QjDIaJW+LIm1p98ZXtYj3XNfo0a/LtlvT
         nk1uIeHhrVsTqVow7LQY2IqrA5qs/sPY3TQU0YNoLFoUi9mktogOXr1pj6Dt5+XeoYoj
         UgaiDx/5a3R/GpHU82ujOzlyOjq/rAky0x+0JHf7o0SV4I436BP9BX4pOv/Iue4YBBNe
         4UaC/kOCWJvUWvc/C56iyq3pkxJNkpoitRmW5H4NmXQh5P0FtNNEGebEsgAFTAtv3V51
         GZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688092078; x=1690684078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTo9hY6za6sp4iN6jnPaCNqbOXw5FRoNumhZ0qdWDT0=;
        b=b2yOI8BRdnlXvI1MwsyhYzWoL66Uz/M5zIVfloBn7aUZgdVgSefkEmQG0KlCfH12o1
         CvzvizsgO5ISnOexuFbTrk9DLtyKcehf4TplXudSLJ+Ve2mrasEnR7tRX+DRDaHCLMuo
         /fcM6smWyj0VQFAWhFUI9MSZmQ0cdxjMYm38QcXvRF6lMuRU56zUlMgSyLKyhiGX6EV2
         m9Xqv28HbGlgP2EM2zGD3/djGTHQQyDL1jqfpRKJzyI1mA9DGPEd1ua+8aT6zSsJZ+AX
         8xm3vqcw/OOt/gaKL9H4cRdn9Z5e6kvr5fx2bAJvSfkAxaXzdDMlUBE+gfslGFMpx741
         HWjQ==
X-Gm-Message-State: ABy/qLZGxTtYLpGGaHx0Njzn0XSj46cHm6EeQqwa13yd7z1noT5V3bSh
	SzXALq9NvydH8p5PwDlycdtg8tCtQH6boy043rJGiw==
X-Google-Smtp-Source: APBJJlGS5fPCjeCoPCceVsMEDJwZdtv3ffVTv0LqhfudUaRPcxeWgOGwlh4B4Gc06mRDoibfLyP/0aoGiRpvBDUVDfE=
X-Received: by 2002:a05:6102:407:b0:440:bee1:e811 with SMTP id
 d7-20020a056102040700b00440bee1e811mr1357973vsq.22.1688092077918; Thu, 29 Jun
 2023 19:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612130256.4572-1-linyunsheng@huawei.com> <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org> <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org> <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com> <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
In-Reply-To: <20230619110705.106ec599@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 29 Jun 2023 19:27:46 -0700
Message-ID: <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 11:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 16 Jun 2023 22:42:35 +0200 Jesper Dangaard Brouer wrote:
> > > Former is better for huge pages, latter is better for IO mem
> > > (peer-to-peer DMA). I wonder if you have different use case which
> > > requires a different model :(
> >
> > I want for the network stack SKBs (and XDP) to support different memory
> > types for the "head" frame and "data-frags". Eric have described this
> > idea before, that hardware will do header-split, and we/he can get TCP
> > data part is another page/frag, making it faster for TCP-streams, but
> > this can be used for much more.
> >
> > My proposed use-cases involves more that TCP.  We can easily imagine
> > NVMe protocol header-split, and the data-frag could be a mem_type that
> > actually belongs to the harddisk (maybe CPU cannot even read this).  Th=
e
> > same scenario goes for GPU memory, which is for the AI use-case.  IIRC
> > then Jonathan have previously send patches for the GPU use-case.
> >
> > I really hope we can work in this direction together,
>
> Perfect, that's also the use case I had in mind. The huge page thing
> was just a quick thing to implement as a PoC (although useful in its
> own right, one day I'll find the time to finish it, sigh).
>
> That said I couldn't convince myself that for a peer-to-peer setup we
> have enough space in struct page to store all the information we need.
> Or that we'd get a struct page at all, and not just a region of memory
> with no struct page * allocated :S
>
> That'd require serious surgery on the page pool's fast paths to work
> around.
>
> I haven't dug into the details, tho. If you think we can use page pool
> as a frontend for iouring and/or p2p memory that'd be awesome!
>

Hello Jakub, I'm looking into device memory (peer-to-peer) networking
actually, and I plan to pursue using the page pool as a front end.

Quick description of what I have so far:
current implementation uses device memory with struct pages; I am
putting all those pages in a gen_pool, and we have written an
allocator that allocates pages from the gen_pool. In the driver, we
use this allocator instead of alloc_page() (the driver in question is
gve which currently doesn't use the page pool). When the driver is
done with the p2p page, it simply decrements the refcount on it and
the page is freed back to the gen_pool.

Test results are good; our best results we're able to achieve ~96%
line rate with incoming packets going straight to device memory and
without bouncing the memory to a host buffer (albeit these results are
on our slighly older, production LTS, I need to work on getting
results from linus/master).

I've discussed your page pool frontend idea with our gve owners and
the idea is attractive. In particular it would be good not to insert
much custom code into the driver to support device memory pages or
other page types. I plan on trying to change my approach to match the
page pool provider you have in progress here:
https://github.com/kuba-moo/linux/tree/pp-providers

In particular the main challenge right now seems to be that my device
memory pages are ZONE_DEVICE pages, which can't be inserted to the
page pool as-is due to the union in struct page between the page pool
entries and the ZONE_DEVICE entries. I have some ideas on how to work
around that I'm looking into.

It sounds like you don't have the time at the moment to work on the
page pool provider idea; I plan to try and get my code working with
that model and propose it if it's successful. Let me know if you have
concerns here.

> The workaround solution I had in mind would be to create a narrower API
> for just data pages. Since we'd need to sprinkle ifs anyway, pull them
> up close to the call site. Allowing to switch page pool for a
> completely different implementation, like the one Jonathan coded up for
> iouring. Basically
>
> $name_alloc_page(queue)
> {
>         if (queue->pp)
>                 return page_pool_dev_alloc_pages(queue->pp);
>         else if (queue->iouring..)
>                 ...
> }
>


--=20
Thanks,
Mina

