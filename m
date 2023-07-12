Return-Path: <netdev+bounces-17299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F17511BE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C551C21094
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8124193;
	Wed, 12 Jul 2023 20:16:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD821514
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:16:16 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6851FF5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:16:14 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-443571eda4dso25766137.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689192973; x=1691784973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZSa4NetAP62hVIVyvAbNH/+emK9xW+vVSDSphd0g5Y=;
        b=f3Ii093FW9+oc2F8zRSaiEu5EyBxsVuk08e/GPtsqsSeShWLCXC1bZxIOmmMmcmq1X
         oK6yGMz/yKUAxH6edgErEdCMXXNog2fkqOIotGgFfIVUj0iCgmVT+v8LC5kpCquThfT7
         s7k5uUiWkhgOwmaUx18/OOTEOwqIkO3nmFoBTk4Dexu9TnDZDg74BS662UfijW794wbe
         4mv5gp2rm0Aw88kz4kO6NM+04OR7peKtJVIioaYBTxh1ruVx+TUQsaXoyF64QJDSCbCU
         fJTbKpPR0YESffxmDzel4+2Y9WS8i4XOsqrufpBhzDjq1QWzp4YaNmCPgw4rBSNvB9NK
         5lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689192973; x=1691784973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZSa4NetAP62hVIVyvAbNH/+emK9xW+vVSDSphd0g5Y=;
        b=Cm5iF1jI3zDU22/yPcSALfgZgHXQpiHww6NgAcvoY4q+oebNl9NtvEZRsA2aTdXb6V
         7hS3NGJCf0Dp1RbKailWLFZBwREYFJSYP+z5L+Ygw9tdUYa0WO07OGfkYyrN1q8hUiGW
         ivH/NtKybHkU0nAKKxjID7XBaqcfR+Wgo4UsM7LraSbCLWyuyTAgC0kjm+sdJM+eN62J
         IGPjCwKbzq83ZYm/O+cYwHMFSXZS24xjLqxwaqRjUSu8NRS1sk7rD0MwN7gtTjTTPP32
         xRwNxXzhcti+iBbh7Uq43GX2Hm2SlE1mqMGDXy47DkRjQJcgv8sKG8oHeDejFpZscHIc
         vZXg==
X-Gm-Message-State: ABy/qLbHlrB28jwVyH28xUlLU9VEFQfKOPFPSMCYUNTCZneYzd6YvH1a
	U67B3GQvchxtX4N0sELQDEsy197FAtrkF75ySvJPkw==
X-Google-Smtp-Source: APBJJlEZodLxymYp6zmTXbF705s1wpVAmKh0FiHChRMpwA1Y+RhEAUbnIuR5QMDX6deaSzma4SHNwgy0sovv8EPmhPw=
X-Received: by 2002:a67:af0b:0:b0:445:208:2d62 with SMTP id
 v11-20020a67af0b000000b0044502082d62mr12673636vsl.23.1689192973170; Wed, 12
 Jul 2023 13:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org> <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org> <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com> <ZK6kOBl4EgyYPtaD@ziepe.ca>
In-Reply-To: <ZK6kOBl4EgyYPtaD@ziepe.ca>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Jul 2023 13:16:00 -0700
Message-ID: <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Ahern <dsahern@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
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
	Jonathan Lemon <jonathan.lemon@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	logang@deltatee.com, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 6:01=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jul 11, 2023 at 08:42:24PM -0700, Mina Almasry wrote:
>
> > 1. The device memory driver would be the p2pdma provider. It would
> > expose a user API which allocates a device memory region, calls
> > pci_p2pdma_add_resource() and pci_p2pmem_publish() on it, and returns
> > a reference to it to the userspace.
>
> This is not quite right, if you convert any of the GPU drivers to use
> P2PDMA you are going to need to restructure the p2pmem stuff to
> seperate the genalloc. The GPU driver must continue to be the owner
> and allocator of the MMIO memory it already controls, we can't have
> two allocators working in parallel.
>
> The genalloc stuff supports the special NVMe use case, I don't know of
> anything else that would like to work that way.
>

I think maybe you misunderstood the proposal. AFAICT the genalloc
stuff works for us, although there are other issues with p2pdma that I
need to solve.

The proposal was that the uapi in step #1 allocates a region of GPU
memory, and sets up a p2pdma provider for this region of memory. From
the perspective of the GPU, the memory is allocated, and in use by the
user. The p2pdma provider uses genalloc to give out 4K regions with
struct pages to in-kernel allocators from this memory region. Why
would that not work? Looking at the code, that seems to be how p2pdma
works today. The p2pdma provider does p2pdma_add_resource() on a chunk
of its memory, and the genalloc allocates memory from that chunk?

The actual issues I see with this approach are:

1. There is no way for the p2pdma provider to relinquish back the
memory it has provided via pci_p2pdma_add_resource(), in the case that
the user crashed or would like to free the GPU buffer. I would need to
add a pci_p2pdma_remove_resource(). Would that be  acceptable?

2. The p2pdma semantics seem to be global to the pci device. I.e., 1
GPU can export 1 p2pdma resource at a time (the way I'm reading the
API). This is not usable for my use case. I would need multiple users
to be able to use the uapi in step #1 simultaneously. I would need the
same pci device to export different p2pdma resources simultaneously
and the p2pdma clients would need to be able to import some of the
resources. I would likely need to add an api like this:

diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..c9d754713fdc 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -19,6 +19,33 @@ struct scatterlist;
 #ifdef CONFIG_PCI_P2PDMA
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
                u64 offset);
+
+/* Adds a resource similar to pci_p2pdma_add_resource, and returns a file
+ * handle referring to this resource. Multiple such resources can be expor=
ted
+ * by the same pci device.
+ */
+struct file *pci_p2pdma_add_resource_with_handle(struct pci_dev *pdev,
+               int bar,
+               size_t size,
+               u64 offset);
+
+/* Remove a resource added via pci_p2pdma_add_resource_with_handle() */
+struct file *pci_p2pdma_remove_resource_with_handle(
+               struct file *p2pdma_resource_file);
+
+/* Allocates memory from a resource created using
+ * pci_p2pdma_add_resource_with_handle()
+ */
+void *pci_alloc_p2pmem_from_handle(struct file *p2pdma_resource_file,
+               size_t size);
+
+/* Frees p2pmem to a resource created using
+ * pci_p2pdma_add_resource_with_handle()
+ */
+void pci_free_p2pmem_to_handle(struct pci_dev *p2pdma_resource_file,
+               void *addr,
+               size_t size);
+

Looking for feedback from anyone knowledgeable, but the p2pdma
maintainers as well if possibl.

> > 2. The NIC driver would be the p2pdma client and orchestrator. It
> > would expose a user API which binds an rxq to a pci device. Prior to
> > the bind the user API would check that the pci device has published
> > p2p memory (pci_has_p2pmem()), and check the the p2p mem is accessible
> > to the driver (pci_p2pdma_distance() I think), etc.
>
> This doesn't fit the programming model for GPUs at all. You don't want
> to get packets landing in random GPU memory that a kernel side
> allocator selects, you want packets landing in GPU memory owned by a
> specific process that owns the TCP connection.
>

I think this comment is maybe a side effect of the misunderstanding.
In the proposal, the user allocates a GPU buffer using the API in step
#1, and then binds the memory to the NIC rx queue using the API
specified in step #2. We use flow steering & RSS to steer this user's
TCP traffic to the buffer owned by them.

> This is why DMABUF is used here as it gives a handle to the GPU
> memory. What you want is to get the P2P pages either directly from the
> DMABUF or via pin_user_pages() on the DMABUF's mmap.
>
> > AFAICT, all the concerns brought up in this thread are sidestepped by
> > using p2pdma. I need not allocate struct pages in the core dma-buf
> > code anymore (or anywhere), and I need not allocate pgmaps. I would
> > just re-use the p2pdma support.
>
> Well, as I said it is going to be a big ask to P2P enable any of the
> DRM drivers.
>
> And you still have the netmem vs zone_device struct page conflict to
> figure out
>
> But it is alot closer to reasonable than this RFC.
>
> Jason

--=20
Thanks,
Mina

