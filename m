Return-Path: <netdev+bounces-16888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469C74F546
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B661C20FDF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8E182C5;
	Tue, 11 Jul 2023 16:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E123A5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058E9C433C9;
	Tue, 11 Jul 2023 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689093146;
	bh=/yz1VNIx8w5vnZQUrnW46zn2dCf4xJSJ/w4OLb6WBAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yg4EUjxEPD06/Bn6reOhE6TdmtCBNfXmQqLeCVeuc3B4GVfMn6aCEif09HCeYn0Uz
	 Uh06QjoXyuXz76Qh5WxlMsRGgkCEP7GU/xz19BFKHWMX9QP3c0f6H0pfTBv/CMzFNR
	 Gce9NhJ0EAOEBKlWz+3t/42M+JkZEBcqbImWn7g+k7QPFZpUzXnG2Z1YmAU3XT7xgc
	 etgVuONKYWYaRKo7d3AavNFlRtsW7kOs9f5RUjTcfpugo5ljkNFTIaY6eHMNaVhk9c
	 uHeshfY+jsKSE6st5tdcIBLc4raTCwWlwmHFJSEDn5De4UwjLIv6N+Hw3CwjBc6UeH
	 ZQDhJ2SfdHm6Q==
Date: Tue, 11 Jul 2023 09:32:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Mina
 Almasry <almasrymina@google.com>, John Hubbard <jhubbard@nvidia.com>, Dan
 Williams <dan.j.williams@intel.com>, Jesper Dangaard Brouer
 <jbrouer@redhat.com>, brouer@redhat.com, Alexander Duyck
 <alexander.duyck@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, Yisen
 Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Eric Dumazet <edumazet@google.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Felix Fietkau
 <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
 <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
 <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Jonathan Lemon
 <jonathan.lemon@gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <20230711093224.1bf30ed5@kernel.org>
In-Reply-To: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
	<CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
	<ZKNA9Pkg2vMJjHds@ziepe.ca>
	<CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
	<ZKxDZfVAbVHgNgIM@ziepe.ca>
	<CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
	<ZKyZBbKEpmkFkpWV@ziepe.ca>
	<20230711042708.GA18658@lst.de>
	<20230710215906.49514550@kernel.org>
	<20230711050445.GA19323@lst.de>
	<ZK1FbjG+VP/zxfO1@ziepe.ca>
	<20230711090047.37d7fe06@kernel.org>
	<04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 10:20:58 -0600 David Ahern wrote:
> On 7/11/23 10:00 AM, Jakub Kicinski wrote:
> >> RDMA works with the AMD and Intel intree drivers using DMABUF without
> >> requiring struct pages using the DRM hacky scatterlist approach.  
> > I see, thanks. We need pages primarily for refcounting. Avoiding all
> > the infamous problems with memory pins. Oh well.  
> 
> io_uring for example already manages the page pinning. An skb flag was
> added for ZC Tx API to avoid refcounting in the core networking layer.

Right, we can refcount in similar fashion. Still tracking explicitly
when buffers are handed over to the NIC.

> Any reason not to allow an alternative representation for skb frags than
> struct page?

I don't think there's a hard technical reason. We can make it work.

