Return-Path: <netdev+bounces-153246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B69F75CA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C3189604E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E662163B5;
	Thu, 19 Dec 2024 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gfq7meRw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5171B4233
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593664; cv=none; b=DBQwvQZSklyWxshRpD1Ba9VIPEcFvceNLEtFOV03HfxKC7GB2L62cBnwDxVEo03iVvvAWY5py2k2iiIOLHIFETB6S77YBUdDzbGTNtIBfMF5KBuMEcl+044WRwZHDsF+e+Q0/lMUK7Mfr+ugkFQ+/vWDJDMvyg1Ii+rOggcS4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593664; c=relaxed/simple;
	bh=+51xot8Vafc/JtMGNnDxqaLzHM+k06YQ2GVjV3nmC1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ96JC1tFoK+ivpD9XtdviYg5MtTbz33qwxuzMmzdIaSKSK7P5ceacyrLHZRRko7kICivVi8UrkV7Ya/RdcplkrmmDwryoDRRrJg1s92M0T92OW5vdLG6jYotUQiw6rBSkD89ImXI0GpbeZFXJFOOC90W2qIEfmq8NpheqU1Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gfq7meRw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734593663; x=1766129663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+51xot8Vafc/JtMGNnDxqaLzHM+k06YQ2GVjV3nmC1M=;
  b=Gfq7meRw9JKxLsi1zzTggFV/+WjDyc+GxxYCviHQnY7/vK9zinLMRBs4
   tZ/ORW5ey5w2ByUg6nECPPnlMMdCJvLBKFhKTc1ab/n2jt26dZohPtofD
   AKAvtxTxjF1FZnYGSqE7Rh184GWrQ5XJPB/zjFA/vZbK9FBXf9eSrAcRt
   MAFPAkZ/SBUSF42UzEtgt/IvAQVFNgt1C71URKXaMAxtxcnTMSgMlygFH
   IQqS+ICyKb8ncMcLPMqvsqAhxqIKmqHUnLiSx9DLffBiPOJN+ldPSiwh8
   54tEVgIIrrhDEyqvxSUF/5YoVzPX8xQ/CBKexQmNDJiTUyc4nNiO8O0us
   Q==;
X-CSE-ConnectionGUID: /dEqudVjSr2jeY8sQrCuug==
X-CSE-MsgGUID: tBUYGYrNQPuVqZlv3y//bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45776334"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="45776334"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:34:11 -0800
X-CSE-ConnectionGUID: sdH2/1x8SH2GwQpZhr274Q==
X-CSE-MsgGUID: NiWjj/7QQdSlR/xH26Fd1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97941271"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:34:09 -0800
Date: Thu, 19 Dec 2024 08:31:02 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH net-next] eth: fbnic: fix csr boundary for RPM RAM section
Message-ID: <Z2PLtrFNzYsRSstx@mev-dev.igk.intel.com>
References: <20241218232614.439329-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218232614.439329-1-mohsin.bashr@gmail.com>

On Wed, Dec 18, 2024 at 03:25:58PM -0800, Mohsin Bashir wrote:
> The CSR dump support leverages the FBNIC_BOUNDS macro, which pads the end
> condition for each section by adding an offset of 1. However, the RPC RAM
> section, which is dumped differently from other sections, does not rely
> on this macro and instead directly uses end boundary address. Hence,
> subtracting 1 from the end address results in skipping a register.
> 
> Fixes 3d12862b216d (âeth: fbnic: Add support to dump registersâ)
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
> index 2118901b25e9..aeb9f333f4c7 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
> @@ -64,7 +64,7 @@ static void fbnic_csr_get_regs_rpc_ram(struct fbnic_dev *fbd, u32 **data_p)
>  	u32 i, j;
>  
>  	*(data++) = start;
> -	*(data++) = end - 1;
> +	*(data++) = end;
>  
>  	/* FBNIC_RPC_TCAM_ACT */
>  	for (i = 0; i < FBNIC_RPC_TCAM_ACT_NUM_ENTRIES; i++) {
> -- 

Thanks,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 2.43.5

