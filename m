Return-Path: <netdev+bounces-180609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C9A81D5F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEB68A07A2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD301DF25D;
	Wed,  9 Apr 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHRhJMKx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547581B81DC;
	Wed,  9 Apr 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181080; cv=none; b=grctfgFoVHdas3BdD6OP98+LsPYRoClow7zXbqiEuziUg8R8t/Yhi/C30d0L0XMOnFNdp9FtAHbNMWqK+o7PcqXPEcRDMbRRvoSMCTCHie0Got/pj8qyZRTDtb7VdjsMZXt9TTC1XUq1NRA6+9bV0SlQ8dMro7a+odCu5+E69ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181080; c=relaxed/simple;
	bh=ALBnrSfHV8g4GMuPHWFFLTfPQLBL6JiGSf0XrqgvB2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfSXjDLyH7ga69BqDB9EoNndzi+4VCSeedmVT9WulagWIRuaMz4SiUeG+LhjndsWv5AFoyy7tU0OVLof2Z1BCcXAxchqQOv6x0/bnSzMt83AibBEc/TYW7QoavPRQ1L44qHj8ew+1MQLWxWQut4WQoUsl7iRyaGRl5mKGpR8M6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHRhJMKx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744181078; x=1775717078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALBnrSfHV8g4GMuPHWFFLTfPQLBL6JiGSf0XrqgvB2w=;
  b=FHRhJMKxJc1ablkHMeGxiAnVmhFs5e5C60EX5t6jEDrNngF62wCBDqJm
   pa5bixfNHZyD+g+JB09d+3WGqExdayQs2oW7lttxoCeqwIec/6tezANfO
   d6nunvQbnk8aOJpnreKXYsRE1u1DIXg60yThWcS7vrHvRQMQlQBoubZbi
   BtjuyYJr/2lDimEW/PcGub2zIHRhEQnWlGc18paVbOQrRtVzL3B0CcG5Z
   Dsh60NRgV+a14VJT5pd+dxOhylH7TMsaHkDL0nDsfw5z0gP9iLFI7v3ra
   pqVy8IFGreHyiEfV8D7sRxe63E5nOoBvPXJol7JX81CQnDSM+tGYY2qJG
   g==;
X-CSE-ConnectionGUID: yO+mWpBWSZOh9bmZeHmr7A==
X-CSE-MsgGUID: cpcK/FvcSQuDrSuBMHhLNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44782354"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="44782354"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:44:37 -0700
X-CSE-ConnectionGUID: b/FVb1UPT6qv4CdqTE5qLA==
X-CSE-MsgGUID: ZiQndo1+TFuqri8K0Hg3cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="165726005"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:44:35 -0700
Date: Wed, 9 Apr 2025 08:44:19 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pds_core: fix memory leak in
 pdsc_debugfs_add_qcq()
Message-ID: <Z/YXQ7N2lCQxCn0L@mev-dev.igk.intel.com>
References: <20250409054450.48606-1-abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409054450.48606-1-abdun.nihaal@gmail.com>

On Wed, Apr 09, 2025 at 11:14:48AM +0530, Abdun Nihaal wrote:
> The memory allocated for intr_ctrl_regset, which is passed to
> debugfs_create_regset32() may not be cleaned up when the driver is
> removed. Fix that by using device managed allocation for it.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>  drivers/net/ethernet/amd/pds_core/debugfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
> index ac37a4e738ae..04c5e3abd8d7 100644
> --- a/drivers/net/ethernet/amd/pds_core/debugfs.c
> +++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
> @@ -154,8 +154,9 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>  		debugfs_create_u32("index", 0400, intr_dentry, &intr->index);
>  		debugfs_create_u32("vector", 0400, intr_dentry, &intr->vector);
>  
> -		intr_ctrl_regset = kzalloc(sizeof(*intr_ctrl_regset),
> -					   GFP_KERNEL);
> +		intr_ctrl_regset = devm_kzalloc(pdsc->dev,
> +						sizeof(*intr_ctrl_regset),
> +						GFP_KERNEL);
>  		if (!intr_ctrl_regset)
>  			return;
>  		intr_ctrl_regset->regs = intr_ctrl_regs;

In ionic driver it is also devm_ version, thanks for catching that.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

For future submission remember to set correct target (net instead of
net-next as it is a fix)

Thanks,
Michal

> -- 
> 2.47.2

