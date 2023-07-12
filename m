Return-Path: <netdev+bounces-17143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2F750903
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E3E1C20F02
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9199C27727;
	Wed, 12 Jul 2023 13:01:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847252AB27
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:01:56 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A11982
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:01:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-765942d497fso651062885a.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689166911; x=1691758911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWpuSX94flQxvT/7GFNnyt8FcFburvzifDepq9lHVso=;
        b=iYD+caT5C5DZuj4SVL8bXKmm54Fife2Oz9uLMzl6trcTZ3BhImO/CJ2diP8cel4MIq
         XvWzM2pXRBQEjLiVo3Hgt06eJWjI2g2knQDKpA2bpSVnKpPcB5kCx3F2DSBXcUoh1RcW
         evRk6qNJjMFTRHZraP9CHksMsuP51beQli1rjtg5cRvCFZIiXfjjqzmq7912pS2ynyNH
         /SqCiWdXv8u7bRbNQhIjI9Y4D6U/0F8mt1bkXpyu60M2tzC25xcrXZUnG7XOxux/chyn
         iUj28ba/siqynf7x2SgrK9XpRda5v7gelAg/mnDloWN4XKIrIZHL0ttb9xLfMYOzQPpS
         n/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166911; x=1691758911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpuSX94flQxvT/7GFNnyt8FcFburvzifDepq9lHVso=;
        b=JToaEk42ANESL6mKSYT4FtORStv8PdgSGBCH6XvqenTZ/Qs2Lxit65J8E9BzxOrlIi
         rYPe9j3xqyiD7FU1CjiD2o3gznmzZCdiMubBOM1PaR6hVGW+r0iw9l84cZ1bbTFIHaN3
         ZGqx0M3RkY5g6Gi2BwMvxaxnnayvC/Wal6AAotMSdttzBmC2nfPQsbvE6T6Jj0GgWYjP
         JN1OrPAsv08y8J/+vO5rV2vgo8/fp6uByiG0gaO5s60cnI6tMIrqp+4Oov/Gl4M5xEQl
         aIdUhLVWvKYXlhnYl3Cg1qDkerRzuUlUVuIep+QsSinzCtErSzEpKL5QXuIJavkO1XtF
         hduw==
X-Gm-Message-State: ABy/qLYk50h171IUO6TfXv1pIWiswfCnYdG+59SdviO7Nn2N2ytVPfqH
	GgPTuJYOJItcq5/S9KfchUG9Vw==
X-Google-Smtp-Source: APBJJlFY1e3i66W1OtOcIX3n2XlytjAfsqmXfgyyy6DjtCl2reodlKdOdi1miiqTfvLyhJirNei5sQ==
X-Received: by 2002:ae9:dfc5:0:b0:767:d847:278a with SMTP id t188-20020ae9dfc5000000b00767d847278amr6940605qkf.74.1689166911567;
        Wed, 12 Jul 2023 06:01:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a121100b007673f8803c3sm2105604qkj.96.2023.07.12.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:01:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qJZTU-000OJR-6S;
	Wed, 12 Jul 2023 10:01:44 -0300
Date: Wed, 12 Jul 2023 10:01:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	logang@deltatee.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZK6kOBl4EgyYPtaD@ziepe.ca>
References: <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 08:42:24PM -0700, Mina Almasry wrote:

> 1. The device memory driver would be the p2pdma provider. It would
> expose a user API which allocates a device memory region, calls
> pci_p2pdma_add_resource() and pci_p2pmem_publish() on it, and returns
> a reference to it to the userspace.

This is not quite right, if you convert any of the GPU drivers to use
P2PDMA you are going to need to restructure the p2pmem stuff to
seperate the genalloc. The GPU driver must continue to be the owner
and allocator of the MMIO memory it already controls, we can't have
two allocators working in parallel. 

The genalloc stuff supports the special NVMe use case, I don't know of
anything else that would like to work that way.

> 2. The NIC driver would be the p2pdma client and orchestrator. It
> would expose a user API which binds an rxq to a pci device. Prior to
> the bind the user API would check that the pci device has published
> p2p memory (pci_has_p2pmem()), and check the the p2p mem is accessible
> to the driver (pci_p2pdma_distance() I think), etc.

This doesn't fit the programming model for GPUs at all. You don't want
to get packets landing in random GPU memory that a kernel side
allocator selects, you want packets landing in GPU memory owned by a
specific process that owns the TCP connection.

This is why DMABUF is used here as it gives a handle to the GPU
memory. What you want is to get the P2P pages either directly from the
DMABUF or via pin_user_pages() on the DMABUF's mmap.

> AFAICT, all the concerns brought up in this thread are sidestepped by
> using p2pdma. I need not allocate struct pages in the core dma-buf
> code anymore (or anywhere), and I need not allocate pgmaps. I would
> just re-use the p2pdma support.

Well, as I said it is going to be a big ask to P2P enable any of the
DRM drivers.

And you still have the netmem vs zone_device struct page conflict to
figure out

But it is alot closer to reasonable than this RFC.

Jason

