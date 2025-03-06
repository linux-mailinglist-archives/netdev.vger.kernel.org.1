Return-Path: <netdev+bounces-172520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E4A551B4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6093A6257
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C223FC55;
	Thu,  6 Mar 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f63+H2di"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1423FC4C;
	Thu,  6 Mar 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279409; cv=none; b=ogCtn7fkdZ4/iH2QxDjdLzBfN0yBA02JFT0kmj7Ijn6WlpcKJdFN+81Gp2cv5dIZhCji+m39Otru1ZFNaVem+pdNMXxquXEr8awbGnt4/uCSAMNH81X/dMTNEsTYSjXdYpROc8bP5hVGEtml1WcwYt0WhDSMgqELRiTyjLBCsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279409; c=relaxed/simple;
	bh=2XKxCns3kXFvBAxhquUJVwabD6paWBBQ9HcLo0UhYZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/KMBHAGe8tNu/tNx5aTpZ5YK4HQjPFT9GQOUPFGZ0c5M6XIj9jj9UnCxFvCBWCPywLZpIzpjJBLVZusZH27ijQyRXjfi7d3XHX3veUEAdR8nk02RCPfVkPsvRs1uInmPW5AMjuLcZn1lJ6DPyKHiMir5+AyiMIoTWULhnG/scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f63+H2di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9762C4CEE0;
	Thu,  6 Mar 2025 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741279408;
	bh=2XKxCns3kXFvBAxhquUJVwabD6paWBBQ9HcLo0UhYZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f63+H2dixTDpO6BLeaDYs/vxjxaQuGabs6addvjRLdA9t6xcKtnjJ9w2oQI2wrvSx
	 AdozKcwOtRZWxkPtZH4PM4Dzq2FkUightt1SbZtvGDdSKtgXJgwbuj82L7H97nZqSV
	 uyodVbYS9NZlPwxVB/bIPPmykJuwXoDXcwfHQpynhluIVqen+ySrgz/YDTA6DP0xaN
	 LlhQZQ4g3fqKdLWSYkWHuJOv8HPBBepRE8vva+NXqM4ezw5ChuChWwt8DrIq6pESJ0
	 yJqikXEdLIda8MNgACPkn4XCsiEpckC/AgkACOOHjKijj++UBFj3MRNwsjKwrlF/8Z
	 7DBRGC8b1Vz+A==
Date: Thu, 6 Mar 2025 16:43:22 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	bbhushan2@marvell.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, llvm@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v2] octeontx2-af: fix build warnings flagged by
 clang, sparse ,kernel test robot
Message-ID: <20250306164322.GC3666230@kernel.org>
References: <20250305094623.2819994-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305094623.2819994-1-saikrishnag@marvell.com>

On Wed, Mar 05, 2025 at 03:16:23PM +0530, Sai Krishna wrote:
> This cleanup patch avoids build warnings flagged by clang,
> sparse, kernel test robot.
> 
> Warning reported by clang:
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:2993:47:
> warning: arithmetic between different enumeration types
> ('enum rvu_af_int_vec_e' and 'enum rvu_pf_int_vec_e')
> [-Wenum-enum-conversion]
>  2993 | return (pfvf->msix.max >= RVU_AF_INT_VEC_CNT +
> RVU_PF_INT_VEC_CNT) &&

Hi Sai,

I think it would be good to address each set of errors in separate patches.
And in each case include a report of the errors the tools reported.

And I think that the subject(s) could be tightened up a bit.
E.g.:

	Subject: octeontx2-af: correct __iomem annotations

	Sparse flags a number of inconsistent usage of __iomem annotations:

	  .../otx2_pf.c:611:24: sparse:     expected void [noderef] __iomem *hwbase
          .../otx2_pf.c:611:24: sparse:     got void *
          .../otx2_pf.c:620:56: sparse: sparse: cast removes address space '__iomem' of expression
          .../otx2_pf.c:671:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *hwbase @@
          .../otx2_pf.c:671:35: sparse:     expected void volatile [noderef] __iomem *addr
          .../otx2_pf.c:671:35: sparse:     got void *hwbase
          .../otx2_pf.c:1344:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __iomem * @@
          .../otx2_pf.c:1344:21: sparse:     expected unsigned long long [usertype] *ptr
          .../otx2_pf.c:1344:21: sparse:     got void [noderef] __iomem *
          .../otx2_pf.c:1383:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __iomem * @@
          .../otx2_pf.c:1383:21: sparse:     expected unsigned long long [usertype] *ptr
          .../otx2_pf.c:1383:21: sparse:     got void [noderef] __iomem *
          .../otx2_pf.c: note: in included file (through .../mbox.h, .../otx2_common.h):

	Address this by, ...

	Reported-by: ...
	...

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202410221614.07o9QVjo-lkp@intel.com/
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/common.h |  2 +-
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c    | 14 ++++++++------
>  .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 10 +++++-----
>  .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  9 ++++-----
>  4 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 406c59100a35..8a08bebf08c2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -39,7 +39,7 @@ struct qmem {
>  	void            *base;
>  	dma_addr_t	iova;
>  	int		alloc_sz;
> -	u16		entry_sz;
> +	u32		entry_sz;
>  	u8		align;
>  	u32		qsize;
>  };

Further to my point above, I am unsure what problem this is addressing.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index cd0d7b7774f1..c850ea5d1960 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -591,7 +591,7 @@ static void rvu_check_min_msix_vec(struct rvu *rvu, int nvecs, int pf, int vf)
>  
>  check_pf:
>  	if (pf == 0)
> -		min_vecs = RVU_AF_INT_VEC_CNT + RVU_PF_INT_VEC_CNT;
> +		min_vecs = (int)RVU_AF_INT_VEC_CNT + (int)RVU_PF_INT_VEC_CNT;
>  	else
>  		min_vecs = RVU_PF_INT_VEC_CNT;
>  

I think that in the light of Linus's feedback and the subsequent patch
that demoted -Wenum-enum-conversion from W=1 to W=1 this is not necessary.

[1] https://lore.kernel.org/all/CAHk-=wjMux0w49bTdSbC3DOoc9FRctDrRvaqFUS4KFTmkbtKWg@mail.gmail.com/
[2] 8f6629c004b1 ("kbuild: Move -Wenum-enum-conversion to W=2")

> @@ -819,13 +819,14 @@ static int rvu_fwdata_init(struct rvu *rvu)
>  		goto fail;
>  
>  	BUILD_BUG_ON(offsetof(struct rvu_fwdata, cgx_fw_data) > FWDATA_CGX_LMAC_OFFSET);
> -	rvu->fwdata = ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));
> +	rvu->fwdata = (__force struct rvu_fwdata *)
> +		ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));

I am concerned that this and similar changes in this patch are masking
problems. In my view __iomem annotations are there for a reason, to help
use the correct access mechanism for iomem. So my question is why is that
not the case for fwdata?

Similarly for other cases in this patch where __iomem is cast or cast-away.

...

