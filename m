Return-Path: <netdev+bounces-16894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E674F5BB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37851281878
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234C1DDC0;
	Tue, 11 Jul 2023 16:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BA19BC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:42:55 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522910C2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:42:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-765942d497fso553580985a.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689093769; x=1691685769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu6KIyFq5ICxck51tOZTlrhfx/dAZN9zejRdcXCeDIQ=;
        b=hutFTkWd80/JWvtlN74IkzBT25OF7LVT1vr1QbOtoLia7gCMDN/IthFasmJc6qiQay
         3tVmOsZw93jMQD1ismCSE3/TO08LFEoKmWO4bSv0VW+Fcc+nXAGs1l4AEEucg2NIWTfz
         qtsg3PHnJJ+65RVJUeDP0+OnLtSMLDGe8uG31BIeuyVQUZmFXwqtQpoxmzPe0CWl2vF+
         PVSnB774tyoY7PSisg55xASa4YKGevTLCboavkgbiFWYJv3oSZ8GGZIln/OlViAGZJQ0
         1osG2kQZAkLmJs3+qeezOegAZ4lq6SI4eQiiwkKS9Ht/DJCtY3YykcRdmrRaLS2HudM/
         80kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093769; x=1691685769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu6KIyFq5ICxck51tOZTlrhfx/dAZN9zejRdcXCeDIQ=;
        b=VF7+k60eQoHMTv3c76pkYzLvCoDpHNmciW9R6wPKHB6M/j8Se+v3OwaqGA//0CT1UY
         MKlX54RZ/Z6ZdOO+A6IA6t0pk6/PjyarqzWbkKgYPjbIAOK05bWaohkrPe8hFW+0XHaF
         IXMmdwsnsfFKpTTHQUaEq33idGAjkefiqxYE4Ua+NSHi3NBWCiji6UzSfll8as8btcAa
         yxmyvTI/A5Jpr6w3Y6tuJQ38ljevDayYu2AvHRqtud7Crn1C2KRUzf1P6aFHFphHs6qE
         RGmnw8qFKWIaUHztn9nKBvzizUnSkVQffxNWtoLg9jZsfhFAvBYzzxmqxEcb6WZBxRAK
         55Aw==
X-Gm-Message-State: ABy/qLbjbiV6dsNXAdRcKBmsdSOkDYaFJQauqlI4gHdqGrl88zQkw6kC
	L8Dsu7VPs2R9c0H1MIKMop87lw==
X-Google-Smtp-Source: APBJJlHrfEpx0F5ZCb1qXKIKZ/LjogbATKeqxd6U5nNdJ3jhzMUvs4D3C+kS3MbzveBt3oiLYSo3MA==
X-Received: by 2002:a37:f70f:0:b0:767:5689:bc7a with SMTP id q15-20020a37f70f000000b007675689bc7amr15355662qkj.25.1689093769195;
        Tue, 11 Jul 2023 09:42:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k2-20020a05620a138200b00767d6427339sm1165653qki.69.2023.07.11.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:42:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qJGRr-000IQx-QI;
	Tue, 11 Jul 2023 13:42:47 -0300
Date: Tue, 11 Jul 2023 13:42:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mina Almasry <almasrymina@google.com>,
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
Message-ID: <ZK2Gh2qGxlpZexCM@ziepe.ca>
References: <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca>
 <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711090047.37d7fe06@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 09:00:47AM -0700, Jakub Kicinski wrote:

> > So is Infiniband, Jakub has a unique definition of "proprietary".
> 
> For IB AFAIU there's only one practically usable vendor, such an
> impressive ecosystem!!

IB has roce (RDMA Over Converged Ethernet, better thought of as IB
over Ethernet) under it's standization umbrella and every major
commodity NIC vendor (mellanox, broadcom, intel) now implements
roce. We also have the roce support in the switch from all major
switch vendors.

IB as a link layer "failed" with most implementors leaving the
ecosystem broadly because Ethernet link layer always wins in
networking - this is more of an economic outcome than a
standardization outcome in my mind.

Due to roce, IB as a transport and software protocol has a solid
multi-vendor ecosystem.

Jason

