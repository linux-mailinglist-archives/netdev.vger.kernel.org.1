Return-Path: <netdev+bounces-16831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263174ED8D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395CC1C20DE2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273718B1B;
	Tue, 11 Jul 2023 12:05:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BA1774C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:05:07 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29336E4B
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 05:05:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765942d497fso526289785a.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689077104; x=1691669104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDj/nUPhv/hb6kVZTAGV+ec/xse6Mtcau18exq4wFfg=;
        b=mJnWqKwDMLasfvZIgnnLjeZubYFEXhgQUriyniboKusYls6+C/mL95Tb4P3ahgb2ly
         UfehINYtKiyzWMJO7IBeL7aNkUVN35SC7VJSVhsw9KFV+q6daoC6BFGPiFkn9FxJajzq
         DGaYAQI13Yu06T7GpFqdzzv2PTbbTGLptVEHwLsBhHqorONeJqwlaEcsfs34Zcq3U9NW
         XheotZD5oo/pIyPuubqGr9ReOeVNnM5310WYJjx2KhOphWoCWgsJm7SEkfyGIZEM39en
         /F4Qgy6k5T17Cq8QWsHYSMwY4649dC6Iii0F1d1VtBiEHgup1B7AOz6IJUhmKOxeJZFa
         AZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077104; x=1691669104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDj/nUPhv/hb6kVZTAGV+ec/xse6Mtcau18exq4wFfg=;
        b=GvFRDpj7L/AOq7PL6YWnTgPkoaPEIPLkUOrhC2LbWxs4czHxN/D8AsVDJXdvyrYRHs
         0enWgWHw7OebYWOOats4pYqAIzS2st4Lx0soPrgcSBqxEK0nK6mc4q2hAIp41xm/piD5
         JLohM+z9fZ9uVQ8RwSrS+5IBgJfUYXGvCqfCELINgjZGZ9uHFJ5BBckQu7fV29GfKTxE
         RKQ2Db5oEa/XtyuWLd5Be247YLq53Gx1KYHoBUNtyGQenijJdlXrAvLZrSZJWZ39H4vj
         ILPFxQtcA5lPUJI1ot93asUhMrLybNE3WvmacWHdXTZHXuS30ajLIhqQjpMF0rfTQLM8
         65iQ==
X-Gm-Message-State: ABy/qLajuh2gq1UieH/Z+maPk+NrU/lp+SzROjh1tCp9/VhJSaGGQvsv
	gYxuCIMvRG9JnUa+zDv3LHqMRA==
X-Google-Smtp-Source: APBJJlHlMSiZUq+WY356by/kwiQKIEq734XHbryNHy9OPRb10YQGqsssS7qFeOD/eSjn/EPBX8tRnQ==
X-Received: by 2002:a0c:a98d:0:b0:635:e209:178c with SMTP id a13-20020a0ca98d000000b00635e209178cmr12615604qvb.10.1689077104237;
        Tue, 11 Jul 2023 05:05:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id q17-20020a0ce211000000b006362d4eeb6esm956869qvl.144.2023.07.11.05.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:05:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qJC74-0008zp-Q7;
	Tue, 11 Jul 2023 09:05:02 -0300
Date: Tue, 11 Jul 2023 09:05:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
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
Message-ID: <ZK1FbjG+VP/zxfO1@ziepe.ca>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711050445.GA19323@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 07:04:45AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 09:59:06PM -0700, Jakub Kicinski wrote:
> > On Tue, 11 Jul 2023 06:27:08 +0200 Christoph Hellwig wrote:
> > > Not going to comment on the rest of this as it seems bat shit crazy
> > > hacks for out of tree junk.  Why is anyone even wasting time on this?
> > 
> > Noob question - how does RDMA integrate with the out of tree junk?
> > AFAIU it's possible to run the "in-tree" RDMA stack and get "GPU
> > direct".
> 
> I don't care and it has absolutel no business being discussed here.
> 
> FYI at leat iWarp is a totally open standard.

So is Infiniband, Jakub has a unique definition of "proprietary".

RDMA works with the AMD and Intel intree drivers using DMABUF without
requiring struct pages using the DRM hacky scatterlist approach.

Jason

