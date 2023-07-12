Return-Path: <netdev+bounces-17335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93A7514D7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 01:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938C31C21096
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432001D305;
	Wed, 12 Jul 2023 23:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140F1D2E8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:57:40 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0B1BF2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:57:38 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9610b8a64so68592a34.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689206258; x=1691798258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w48DGD9rzIYkzJBQTh6OIxxXx9CGgucCjaW9OKrfELw=;
        b=dZNheAfiCySsh2SaF2XcW+MMtkBXzAtYE1bKH9YhwIV5aznEQU+CjZeCa77zb9yIk6
         qG+SrhnIMvWxK7E7LJBxvt7kKYojgedSKLDV175irtZzmYSzdjxrNR/orOxNwsksjvXf
         GDMRbGW9fLNbDSM+t3gp6eKGlvp16V9gJTJZ6uT9KJBkGxPNxs9avkoNwrmJ6V9aLc6T
         WfD5p0qtqYKkvHFwuvXwBDY0D/CSjiNJn7J8dSA2CKs095u3oYzL0q4Cvz5tIaiRrOT3
         gRxMAUo38ckigMsyz9+7UyLvXeSyTkAho0dZS5xKm5199rXgmqJgmB2X2XuqQVPPGFxq
         1MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206258; x=1691798258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w48DGD9rzIYkzJBQTh6OIxxXx9CGgucCjaW9OKrfELw=;
        b=R5vHw2PIU9b2JbgiVZVN3P1gEcgwZGFDjRn4edr+onK3BsmMIRU6A6vrMMSpYfpUVM
         B2+2gtH1RCyIOSNbydybMdvU4WwUD8UjtaJjy844cc99oj8Djy2cpIw3br0VnJd6Rh8n
         WFQLwuLTZBCbrqUDKjz+lBSi4HWAibEApcZ3K4odnn6ZGhCggXpDWJa+BgW7KC1hK+t5
         2uss3tgstQ4WwFVjppp96W4nRI3yFWVhOt1zgJWMK/Yy5eEe3M1mq6F40OKXeoCpNWdb
         b5phtPywe5YnUWW0PrdM3iUCeuUjLO1tFDeclTwarQe8Jn1647MhzLd1sqVGHMBkfH8D
         P2WA==
X-Gm-Message-State: ABy/qLau4bvXD1NM+X5l0HQuB25WCMbd1CqVBDuhLh3tpcxMmoEg+Coh
	EDVz2A+aDoiA+hsS8UvXpHLHP0rwu4uilsatjbI=
X-Google-Smtp-Source: APBJJlHj3zv5+y0d8YqMlYnepQ1WLcvsZHbqObTNCneoz62gOcAbi9uLTi3aOdJ7p2PueOx0bKfwWQ==
X-Received: by 2002:a05:6870:7309:b0:1b3:c39a:7c34 with SMTP id q9-20020a056870730900b001b3c39a7c34mr397690oal.25.1689206258019;
        Wed, 12 Jul 2023 16:57:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090acf8e00b0026596b8f33asm8834060pju.40.2023.07.12.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:57:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qJjiB-000gjk-N4;
	Wed, 12 Jul 2023 20:57:35 -0300
Date: Wed, 12 Jul 2023 20:57:35 -0300
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
Message-ID: <ZK8978wUKKP3/zIW@ziepe.ca>
References: <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 01:16:00PM -0700, Mina Almasry wrote:

> The proposal was that the uapi in step #1 allocates a region of GPU
> memory, and sets up a p2pdma provider for this region of memory.

Honestly that feels too hacky, which is why I've said a few times
you'd actually need to integrate p2p pages into a DRM driver properly.

> 2. The p2pdma semantics seem to be global to the pci device. I.e., 1
> GPU can export 1 p2pdma resource at a time (the way I'm reading the
> API).

All of this is just a reflection that you are trying to use it in a
wrong hacky way. The driver is supposed to create a p2p registration
for its entire BAR at startup. Not on demand and not in fragments.

Jason

