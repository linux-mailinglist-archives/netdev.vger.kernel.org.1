Return-Path: <netdev+bounces-16955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF59074F92A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747C728199E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506731DDCB;
	Tue, 11 Jul 2023 20:34:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065451FCF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AAEC433C7;
	Tue, 11 Jul 2023 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689107662;
	bh=Tvmu/JdqsFHoqwxn8e5DiBMwjsswLbqpvPrbdWqX3mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KT2GetEFtYlkaoWB9SkIWERR/pM6252wtR3+uYa5U8hU6Z72yd0jGdfKEHGRCUPDg
	 cV6CxM61kiS9aR8QbLm1lVOKFqo7tiDLKsmIyqsbhxa0VksU16jxRrop0XkHgITqSP
	 EFW3qqHEOocqEyXqP1oLbP2Pw7wZbnpXltb/judIGIutmoF5JzbncOkM51LN3SO7bm
	 E6tbNJFPipV38BWXPsj0vvodOwB6lnCc+5okEl9j4wKGIrXJaVLbiLW7Ru/TvHo4J8
	 Gr9Nye/bZVAOskwP2AUf4LN5Tsox+cB+wfVMSPjU9nO5urg3uBLRwuMcGC+sSUCrVw
	 seVSCxPh1GKNg==
Date: Tue, 11 Jul 2023 13:34:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Mina Almasry <almasrymina@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams
 <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, Jesper
 Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, Alexander Duyck
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
Message-ID: <20230711133420.5df88f02@kernel.org>
In-Reply-To: <ZK2k9YQiXTtcGhp0@ziepe.ca>
References: <ZKxDZfVAbVHgNgIM@ziepe.ca>
	<CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
	<ZKyZBbKEpmkFkpWV@ziepe.ca>
	<20230711042708.GA18658@lst.de>
	<20230710215906.49514550@kernel.org>
	<20230711050445.GA19323@lst.de>
	<ZK1FbjG+VP/zxfO1@ziepe.ca>
	<20230711090047.37d7fe06@kernel.org>
	<ZK2Gh2qGxlpZexCM@ziepe.ca>
	<20230711100636.63b0a88a@kernel.org>
	<ZK2k9YQiXTtcGhp0@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 15:52:37 -0300 Jason Gunthorpe wrote:
> > Now we're getting into our favorite argument and completely
> > sidetracking the conversation, aren't we? :) And as usual 
> > our ability to present facts is limited by various NDAs..  
> 
> Yes, well, maybe I should stop taking the bait everytime you write
> "proprietary" :)
> 
> > > We also have the roce support in the switch from all major
> > > switch vendors.  
> > 
> > By which you mean all major switch vendors should support basic RoCE
> > requirements. But most vendors will try to put special features into
> > their switches trying to make the full NIC + switch solution as sticky
> > as possible.  
> 
> Yep. At the high end open standards based ethernet has also notably
> "failed" as well. Every switch vendor now offers their own proprietary
> ecosystem on a whole bunch of different axis. They all present
> "ethernet" toward the host but the host often needs to work in a
> special way to really take full advantage of the proprietary fabric
> behaviors.

I'm not familiar with "high end open standards based on ethernet", would
those be some RDMA / storage things? For TCP/IP networks pretty much
the only things that matter in a switch are bandwidth, size of buffers,
power... Implementation stuff.

> > Last I checked every generation of HW from even a single vendor came out
> > with a new congestion control algorithm and add-ons.   
> 
> Probably, but I don't really view this as an IB or roce issue.
> 
> Back in the day, there was "data center ethernet" which was a
> standardization effort to try and tame some of these problems. roce
> was imagined as an important workload over DCE, but the effort was
> ethernet focused and generic. Sadly DCE and successor standard based
> congestion mangement approaches did not work, or were "standardized"
> in a way that had a big hole that needed to be filled with proprietary
> algorithms. Eventualy the interest in standardization seems to have
> waned and several of the big network operators seem to be valuing
> their unique congestion management as a proprietary element. From a
> vendor perspective this is has turned into an interop train
> wreck. Sigh.
> 
> roce is just highly sensitive to loss - which is managed in ethernet
> through congestion management. This is why you see roce and congestion
> management so tightly linked, and perhaps in some deployments becomes
> the motivating reason to look at congestion management.

A lot of "standardization" efforts are just attempts to prove to 
a buyers that an ecosystem exists.

Open source the firmware. Let people actually hack on it and when
the users bring their own algorithms de facto standardization will
happen. Short of that it's all smoke and mirrors.

