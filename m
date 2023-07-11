Return-Path: <netdev+bounces-16850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4095374EFEB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E561F2816F3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CB18C0A;
	Tue, 11 Jul 2023 13:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6937182B6
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:11:30 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC41A8
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:11:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55779047021so3901380a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689081088; x=1691673088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPdyri92L3qWMfLakhYh6hhyYNfXQVLXTm4MfbgrCSM=;
        b=HwueZwYKGASMpnXA54qa8kJRp+Y4TROwaWVjgJT4DHOi3ase5SMQmwObiWZdcOnT2b
         CwCMZWz9Hl0Nf8clwIL1/U8+96qtWxYbRLt78/Fl90aPtkcN457gFUR5xSld5i5HM9tr
         Oavf4f466zEk31fxGKU7oxnYu6069ftd+pioCLw9L1Zz95x2dH0oN3DPndP4gxw9RR2l
         Q+6idxu3a9Gwva3IUt/XaDHCSfP8VtvG4OKolu00OkEPrPR6Bss4kT7j64ItS/p+g4OJ
         /yCYIbcFLFzGPz5W1FDVexH7CCmz3cmPkKfhUC40s6RPZmxWu/Wm088eTy+yzVLEHOUU
         7VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689081088; x=1691673088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPdyri92L3qWMfLakhYh6hhyYNfXQVLXTm4MfbgrCSM=;
        b=ZFVaN7ri5slpZqFBnhZb1/iEdzA83PVZxU8RwBMpV4KJa+Gw9nA4D9uH8p0Q03fH14
         PGj9ttA9VVZLPApiqqLjVSrO5+UndIDawo5UdIRSMPmebMVCC76OD9vwR++fJsvJawXS
         Pe/N6wb/bYKdtEUtBD73dD1VQrM4mBwnNbuGq6lLfQ0/6N9WBo+BmfKVJjeTJldkXSqx
         4dRq7Da5QTguwbIPx/SWH3Y/OfqcGV5M7xnw6BT1/VIDxFO8tpbvSeL6Xux2+PB51Xil
         L+hc5kvmufX4rDZXAgSP98+t//PCoNRVtzM/9c/hMAPebLJKRrADSnyB94dLVDxi/4x2
         iWPw==
X-Gm-Message-State: ABy/qLYYQjuKtPyw1FeLQ9ZAbLp37I526H0wO/mQsziehkmX5muhlFKS
	gaaNTJraP0K3N1g9NuzqEMsj9Q==
X-Google-Smtp-Source: APBJJlH/pNqhx9Sk3rAUvsyO9Yo5N3ENJbgYjIKEPGeTeHsBGXcH1oaexcEKAHIm23DxD+Q1c2BUkg==
X-Received: by 2002:a17:90a:df02:b0:25c:571:44bc with SMTP id gp2-20020a17090adf0200b0025c057144bcmr12789299pjb.28.1689081087984;
        Tue, 11 Jul 2023 06:11:27 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090a2e1100b00256353eb8f2sm7811671pjd.5.2023.07.11.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:11:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qJD9J-0009xq-LG;
	Tue, 11 Jul 2023 10:11:25 -0300
Date: Tue, 11 Jul 2023 10:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
	Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZK1U/Vo0NvhNm9pq@ziepe.ca>
References: <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca>
 <CAHS8izOTiSO5PkM+x-CASjwew=U2j=JRNpbz_6NC6AsDTQ17Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOTiSO5PkM+x-CASjwew=U2j=JRNpbz_6NC6AsDTQ17Ug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 05:45:05PM -0700, Mina Almasry wrote:

> > At least from my position I want to see MEMORY_DEVICE_PCI_P2PDMA used
> > to represent P2P memory.
> 
> Would using p2pdma API instead of dmabuf be an acceptable direction?

"p2pdma API" is really just using MEMORY_DEVICE_PCI_P2PDMA and
teaching the pagepool how to work with ZONE_DEVICE pages.

I suspect this will clash badly with Matthew's work here:

https://lore.kernel.org/all/20230111042214.907030-1-willy@infradead.org/

As from a mm side we haven't ever considered that ZONE_DEVICE and
"netmem" can be composed together. The entire point of netmem like
stuff is that the allocator hands over the majority of struct page to
the allocatee, and ZONE_DEVICE can't work like that. 

However, assuming that can be solved in some agreeable way then it
would be OK to go down this path.

But, I feel like this is just overall too hard a direction from the mm
perspective.

I don't know anything about page pool, but the main sticking point is
its reliance on struct page. If it can find another way to locate its
meta data (eg an xarray), at least for some cases, it would make
things alot easier.

Jason

