Return-Path: <netdev+bounces-15244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B417464FE
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AE11C20921
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DB125CD;
	Mon,  3 Jul 2023 21:43:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822211CA8
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 21:43:19 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8DE47
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:43:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89114266dso14161165ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1688420598; x=1691012598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zb/tmr/noeY2rNeZVS/rd5RWOm9XHi+842eE/ic0+a0=;
        b=AiAmewfofTMCDjim2n5Tw+1ZtqlOIk0bXi6iRE5v5TlHNIye7/DkwQc6W3qq8LjOIp
         Xqa4BLwykqMBs3rTWLQCqB46cY7yk3e1UlXmD3dachyhxKT3HwGyQ5ZQUBoEeRTg6FWt
         V3FoZeb/Pfcslwv6G9ml4ZN+Vhlb3NLpYwVIhyIi4T14lqPagW7Xqsj1Vy9HAv94g+UV
         eCE+uAt/Ww3sa8lilIbrUy2CO/y3njkzPQf1M1G2yc4qYYfB6dr/PTXL5EfFbJB+6aSL
         RGoqXV5w3f2vXm8fzuxp5DSKfDMzQA8c3OkoqHlFbZHcWSFOF/jGyPHFIwQaqg3O6Ipn
         SNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688420598; x=1691012598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zb/tmr/noeY2rNeZVS/rd5RWOm9XHi+842eE/ic0+a0=;
        b=dEZDs1MrZ3Nd1jvAdTWEbEpbjcjpKKnmrvTIOFP4ogKGyVE9pfXWYM7Pmwxd6Hbgnu
         G+exVGkSEAfxzTiGsYKJdWNsdd3TJK/ZgSuZUe2THs5pp04FoFGUNSSd8zgc/B33nAdm
         OuEDKOAarRvYyBF9tKrteDS1jeR8UTZKEpG3d7l0yPnsocHsqb3LlMRjXB06TT2+tzG2
         RjsvFd7V3KSgiLXo8vitCVoLVyt2+w+E37SAIPI4dASaddKBwnA4vWUXRyVwKxWgCkNW
         iNQjDIFWHOju1uN2QNsEs9fvMIKlGvpw5jYAXZDAmhvRaSlRiaGR+J2zXlqi/VStPE2A
         +EZw==
X-Gm-Message-State: ABy/qLaEl/KFrt2osdoQM1I7aZBdVp5IMB+Ul7y1FFJcTV0IojFDzIOP
	2U08I+E5OUOzV5/gdd6rkvE4SA==
X-Google-Smtp-Source: APBJJlFY5Wk4ycN3RNcdbeJSOzZJDY4GA9boj1G/G7OddE78CxDwcF9OafgCPpqmAI1xuqydRL+o/g==
X-Received: by 2002:a17:902:c1cd:b0:1b8:400a:48f2 with SMTP id c13-20020a170902c1cd00b001b8400a48f2mr12348909plc.62.1688420597872;
        Mon, 03 Jul 2023 14:43:17 -0700 (PDT)
Received: from ziepe.ca (ip-216-194-73-131.syban.net. [216.194.73.131])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090aea9700b0025dc5749b4csm14888942pjz.21.2023.07.03.14.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:43:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qGRKG-000BU8-Jc;
	Mon, 03 Jul 2023 18:43:16 -0300
Date: Mon, 3 Jul 2023 18:43:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZKNA9Pkg2vMJjHds@ziepe.ca>
References: <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
 <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
 <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
 <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 02, 2023 at 11:22:33PM -0700, Mina Almasry wrote:
> On Sun, Jul 2, 2023 at 9:20 PM David Ahern <dsahern@kernel.org> wrote:
> >
> > On 6/29/23 8:27 PM, Mina Almasry wrote:
> > >
> > > Hello Jakub, I'm looking into device memory (peer-to-peer) networking
> > > actually, and I plan to pursue using the page pool as a front end.
> > >
> > > Quick description of what I have so far:
> > > current implementation uses device memory with struct pages; I am
> > > putting all those pages in a gen_pool, and we have written an
> > > allocator that allocates pages from the gen_pool. In the driver, we
> > > use this allocator instead of alloc_page() (the driver in question is
> > > gve which currently doesn't use the page pool). When the driver is
> > > done with the p2p page, it simply decrements the refcount on it and
> > > the page is freed back to the gen_pool.
> 
> Quick update here, I was able to get my implementation working with
> the page pool as a front end with the memory provider API Jakub wrote
> here:
> https://github.com/kuba-moo/linux/tree/pp-providers
> 
> The main complication indeed was the fact that my device memory pages
> are ZONE_DEVICE pages, which are incompatible with the page_pool due
> to the union in struct page. I thought of a couple of approaches to
> resolve that.
> 
> 1. Make my device memory pages non-ZONE_DEVICE pages. 

Hard no on this from a mm perspective.. We need P2P memory to be
properly tagged and have the expected struct pages to be DMA mappable
and otherwise, you totally break everything if you try to do this..

> 2. Convert the pages from ZONE_DEVICE pages to page_pool pages and
> vice versa as they're being inserted and removed from the page pool.

This is kind of scary, it is very, very, fragile to rework the pages
like this. Eg what happens when the owning device unplugs and needs to
revoke these pages? I think it would likely crash..

I think it also technically breaks the DMA API as we may need to look
into the pgmap to do cache ops on some architectures.

I suggest you try to work with 8k folios and then the tail page's
struct page is empty enough to store the information you need..
Or allocate per page memory and do a memdesc like thing..

Though overall, you won't find devices creating struct pages for their
P2P memory today, so I'm not sure what the purpose is. Jonathan
already got highly slammed for proposing code to the kernel that was
unusable. Please don't repeat that. Other than a special NVMe use case
the interface for P2P is DMABUF right now and it is not struct page
backed.

Even if we did get to struct pages for device memory, it is highly
likely cases you are interested in will be using larger than 4k
folios, so page pool would need to cope with this nicely as well.

Jason

