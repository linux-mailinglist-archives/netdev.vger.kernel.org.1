Return-Path: <netdev+bounces-36318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39147AF047
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 676171F25CFA
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520A30FA1;
	Tue, 26 Sep 2023 16:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218730FB5
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 16:08:36 +0000 (UTC)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BEA120
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 09:08:35 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-493542a25dfso3108201e0c.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695744514; x=1696349314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oDat+15Yv8jvHk03dbPKuk8zwd+AnRHF/euH49EJVQ=;
        b=NuyOzP/DWf4voc16E2dj9DrPPrwOxd94+8zXYfe7+ecH6L1ZrfSIH76BWDFuYjKGsV
         33wVqpui0drGWf4dc4v+tZEAFMWh8esOr4XwQFvS+xZGSAwwxQS7vzJRI1oFMqIqqJ8o
         t0aBzVqYZt3WngMIWjk32+CLZMir0IetEt90yxpYQHRSAbVHupfFaNKYx2+Gt0hTJ3q/
         YUD4zF89IGMt7Aqgt8Fy5SsablBwTB0F8RgC6cDsgU9W4W1pA2tPgPq5+cPWAtmLVq2i
         ftNFgthNAgjRZhttvWZjCSPyW3T5bhTGtcVtOBLVJdZDKjivp/BXq5pl00zApZUPwaLP
         33/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695744514; x=1696349314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oDat+15Yv8jvHk03dbPKuk8zwd+AnRHF/euH49EJVQ=;
        b=rkiIDPuqckUg83cQWaQZ0t+H2rEgSorG4aUNd57oBKvkqiDV9sxgTP5O4Q49iQT/bT
         pWcYsVxUoGvt0+CKFH3d5mj/tCM35gZPtXLmT1Vy80SbR0q5MbzQE2rfd18Rb4GGWM37
         CA+nIaiXghFHf5IV3+pVZm0IX/zaOBQRBssDkKQ2+dU4bTP2720uzUdC7E093qInilzg
         0WskSQR2QfchCUJrD076vlBMS8SIt/iZwPsJZVsuhu5ExUPHvw+mwketBrlaIIjWRq3s
         fHZf7cT0wpZYkpiSbJlmhVlQqpzbVKVicGlG68p1f43eVQOYqoV1YETFX/GcJirgBL5W
         pf4g==
X-Gm-Message-State: AOJu0YwGuBxB2ghAHoOwXoMZLyKYmDI2cdyjlww7hhK5K/y1Cvfzxxdx
	1yIozGOGvbqb4/uZlpVgNry7Ug==
X-Google-Smtp-Source: AGHT+IFDQgBrhIPwgsFhbivVL+D36TCzBymyRjeSj3OWewpTHgWhOtDO4u30/jSZ3MjQP6HcqK5sVA==
X-Received: by 2002:a1f:c582:0:b0:48f:9778:2b9f with SMTP id v124-20020a1fc582000000b0048f97782b9fmr6177336vkf.11.1695744514328;
        Tue, 26 Sep 2023 09:08:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id d8-20020a0cb2c8000000b0065b13180892sm1817688qvf.16.2023.09.26.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:08:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qlAbw-001Evg-HO;
	Tue, 26 Sep 2023 13:08:32 -0300
Date: Tue, 26 Sep 2023 13:08:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Will Deacon <will@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Pierre Morel <pmorel@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Message-ID: <20230926160832.GM13795@ziepe.ca>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
 <ZRLy_AaJiXxZ2AfK@8bytes.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRLy_AaJiXxZ2AfK@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 05:04:28PM +0200, Joerg Roedel wrote:
> Hi Niklas,
> 
> On Fri, Aug 25, 2023 at 12:11:15PM +0200, Niklas Schnelle wrote:
> > Niklas Schnelle (6):
> >       iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
> >       s390/pci: prepare is_passed_through() for dma-iommu
> >       s390/pci: Use dma-iommu layer
> >       iommu/s390: Disable deferred flush for ISM devices
> >       iommu/dma: Allow a single FQ in addition to per-CPU FQs
> >       iommu/dma: Use a large flush queue and timeout for shadow_on_flush
> 
> Turned out this series has non-trivial conflicts with Jasons
> default-domain work so I had to remove it from the IOMMU tree for now.
> Can you please rebase it to the latest iommu/core branch and re-send? I
> will take it into the tree again then.

Niklas, I think you just 'take yours' to resolve this. All the
IOMMU_DOMAIN_PLATFORM related and .default_domain = parts should be
removed. Let me know if you need anything

Thanks,
Jason

