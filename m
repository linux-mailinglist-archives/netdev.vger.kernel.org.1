Return-Path: <netdev+bounces-52031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383217FD014
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19791B213C1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648D1119F;
	Wed, 29 Nov 2023 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="t9W8z0G+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETb3Lfw6"
X-Original-To: netdev@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF51710
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:49:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4F3C23200BBE;
	Wed, 29 Nov 2023 02:49:49 -0500 (EST)
Received: from imap53 ([10.202.2.103])
  by compute1.internal (MEProxy); Wed, 29 Nov 2023 02:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701244188; x=1701330588; bh=ww
	kE8lsdD1lmCvJ6vHeRL3ETi3+Yj2miubjiEiAIJqc=; b=t9W8z0G+rKj+fJP/uq
	4jeGFrbuuZF1b6qaifXXUlxdX8fIUmziIZKzklJ3VPwryXYnKES//UQ0WMtFf/zS
	Fryf6BgWUr//UG7Y5fRhb11YUnCK5iIGHRZmNXN6XNN67y2OLSPmIKTQqJInnLUA
	4caRAwO/eQD8z7nqYdygKQ+CwgtHnPm/8dx2XphefBrEeCN4ZV1AxCc9IrsFJSjc
	7pwgm3e9ZF8XZ9BryRWrdCrP5tx1AWyeFeG+18UYOxzt1c74+Ee2vtn7fmy5W4jc
	J6zilqCK0tHfPDFNFoEkvWiHTT/hacWTMKmCDSRzyrpZtX5GdDWM804lq34z/g5h
	18+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701244188; x=1701330588; bh=wwkE8lsdD1lmC
	vJ6vHeRL3ETi3+Yj2miubjiEiAIJqc=; b=ETb3Lfw6DkCOxFOIUbkE6Xk9xn8um
	NYWplq3Zi/JH90uEVvltbRpBn1wB/b+EQRP7pe4qG572wF88U6upNDi1p3DQFPgm
	uEGZgQReqqg66how6rTDxPpf+RuzjsG2ht0t+YZsCuUnu2m6M7Impm1iFoCvGOsa
	2OXdsEqUdenzpPv4RRUTHwA49cx9pUjMvzc2Lw+8GtpiJDuv5UTQVWDoV/Qc9lOi
	AeBSj6viebzRwEZLd7XYyLC+L38gGZb0nZ2hn9+AkFhe3+cJ0Hdn00pVgBBFTwv3
	UtEKxjupMgfPlqEeqmKEOWvZHvAtjb4nMMDThmXHg/+deh1+9M/P3Da7w==
X-ME-Sender: <xms:HO1mZbv4wGj3Srjcrh_ucPqlMdcIQcZsF9_l2mcTnXjDNeqpT9Kgxw>
    <xme:HO1mZccF_Lf06F4_oO94jRXa9W82Nv9CIf91SQ9SOZ6RWcw2pxKP3Gme7riUPG6lH
    iEweHR5wewMQbE97W4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfgr
    nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeugeeltdelffetleetudejgfejieegudekleekleeifffffefgfefgfeeukeef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjh
    grnhhnrghurdhnvght
X-ME-Proxy: <xmx:HO1mZeyXU6CqgDCKUxM8sqDclknCD8zwOMN1ZWRae-psogxnQ1g7LQ>
    <xmx:HO1mZaMjiVj2uuThL0ShgX8w1msut5PxatT_2wCPwTK8mQT7pOXWSw>
    <xmx:HO1mZb9i8FiLv_TxM-47D10nHOVfxjeLY2MMuD1JMCO_rhQ-qVD47w>
    <xmx:HO1mZYKKmh3HcygK20IWja9Bnbqqgm8Y10_g83DLGkgV2RR-8PN5pA>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5DF0E3640069; Wed, 29 Nov 2023 02:49:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
In-Reply-To: <20231128204938.1453583-5-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-5-pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 08:49:18 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 alex.williamson@redhat.com, alim.akhtar@samsung.com,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 "Lu Baolu" <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
 "David Woodhouse" <dwmw2@infradead.org>, hannes@cmpxchg.org,
 heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
 jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
 "Joerg Roedel" <joro@8bytes.org>, "Kevin Tian" <kevin.tian@intel.com>,
 krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
 "Hector Martin" <marcan@marcan.st>, mhiramat@kernel.org, mst@redhat.com,
 m.szyprowski@samsung.com, netdev@vger.kernel.org, paulmck@kernel.org,
 rdunlap@infradead.org, "Robin Murphy" <robin.murphy@arm.com>,
 samuel@sholland.org, suravee.suthikulpanit@amd.com,
 "Sven Peter" <sven@svenpeter.dev>, thierry.reding@gmail.com,
 tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
 virtualization@lists.linux.dev, wens@csie.org,
 "Will Deacon" <will@kernel.org>, yu-cheng.yu@intel.com
Subject: Re: [PATCH 04/16] iommu/io-pgtable-dart: use page allocation function provided
 by iommu-pages.h
Content-Type: text/plain

Hej,

On Tue, Nov 28, 2023, at 21:49, Pasha Tatashin wrote:
> Convert iommu/io-pgtable-dart.c to use the new page allocation functions
> provided in iommu-pages.h.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/io-pgtable-dart.c | 37 +++++++++++++--------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
> index 74b1ef2b96be..ad28031e1e93 100644
> --- a/drivers/iommu/io-pgtable-dart.c
> +++ b/drivers/iommu/io-pgtable-dart.c
> @@ -23,6 +23,7 @@
>  #include <linux/types.h>
> 
>  #include <asm/barrier.h>
> +#include "iommu-pages.h"
> 
>  #define DART1_MAX_ADDR_BITS	36
> 
> @@ -106,18 +107,12 @@ static phys_addr_t iopte_to_paddr(dart_iopte pte,
>  	return paddr;
>  }
> 
> -static void *__dart_alloc_pages(size_t size, gfp_t gfp,
> -				    struct io_pgtable_cfg *cfg)
> +static void *__dart_alloc_pages(size_t size, gfp_t gfp)
>  {
>  	int order = get_order(size);
> -	struct page *p;
> 
>  	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> -	p = alloc_pages(gfp | __GFP_ZERO, order);
> -	if (!p)
> -		return NULL;
> -
> -	return page_address(p);
> +	return iommu_alloc_pages(gfp, order);
>  }
> 
>  static int dart_init_pte(struct dart_io_pgtable *data,
> @@ -262,13 +257,13 @@ static int dart_map_pages(struct io_pgtable_ops 
> *ops, unsigned long iova,
> 
>  	/* no L2 table present */
>  	if (!pte) {
> -		cptep = __dart_alloc_pages(tblsz, gfp, cfg);
> +		cptep = __dart_alloc_pages(tblsz, gfp);
>  		if (!cptep)
>  			return -ENOMEM;
> 
>  		pte = dart_install_table(cptep, ptep, 0, data);
>  		if (pte)
> -			free_pages((unsigned long)cptep, get_order(tblsz));
> +			iommu_free_pages(cptep, get_order(tblsz));
> 
>  		/* L2 table is present (now) */
>  		pte = READ_ONCE(*ptep);
> @@ -419,8 +414,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg 
> *cfg, void *cookie)
>  	cfg->apple_dart_cfg.n_ttbrs = 1 << data->tbl_bits;
> 
>  	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i) {
> -		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL,
> -					   cfg);
> +		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL);
>  		if (!data->pgd[i])
>  			goto out_free_data;
>  		cfg->apple_dart_cfg.ttbr[i] = virt_to_phys(data->pgd[i]);
> @@ -429,9 +423,10 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg 
> *cfg, void *cookie)
>  	return &data->iop;
> 
>  out_free_data:
> -	while (--i >= 0)
> -		free_pages((unsigned long)data->pgd[i],
> -			   get_order(DART_GRANULE(data)));
> +	while (--i >= 0) {
> +		iommu_free_pages(data->pgd[i],
> +				 get_order(DART_GRANULE(data)));
> +	}
>  	kfree(data);
>  	return NULL;
>  }
> @@ -439,6 +434,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg 
> *cfg, void *cookie)
>  static void apple_dart_free_pgtable(struct io_pgtable *iop)
>  {
>  	struct dart_io_pgtable *data = io_pgtable_to_data(iop);
> +	int order = get_order(DART_GRANULE(data));
>  	dart_iopte *ptep, *end;
>  	int i;
> 
> @@ -449,15 +445,10 @@ static void apple_dart_free_pgtable(struct 
> io_pgtable *iop)
>  		while (ptep != end) {
>  			dart_iopte pte = *ptep++;
> 
> -			if (pte) {
> -				unsigned long page =
> -					(unsigned long)iopte_deref(pte, data);
> -
> -				free_pages(page, get_order(DART_GRANULE(data)));
> -			}
> +			if (pte)
> +				iommu_free_pages(iopte_deref(pte, data), order);
>  		}
> -		free_pages((unsigned long)data->pgd[i],
> -			   get_order(DART_GRANULE(data)));
> +		iommu_free_pages(data->pgd[i], order);
>  	}
> 
>  	kfree(data);

Reviewed-by: Janne Grunau <j@jannau.net>

Janne

