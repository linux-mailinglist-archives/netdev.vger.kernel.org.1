Return-Path: <netdev+bounces-123075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A556996398D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5090A1F21D76
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF0854652;
	Thu, 29 Aug 2024 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JT+HypB+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433893C482
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907261; cv=none; b=RcowNRYCb5Jl7qvOVm8oZjjqE5yUFWqHER/i7Is8yuqUZ4xGj54TZP0FWckEUJYPOJHca1kEVxSwAzDxx8NSbHcttG2Zqj1roe1OuuKs2phEW7G2RctiCsGqz6sBYwUCBAVUdZ7fah/eP7MEQ6W4Dprsqq52hon0oXBePRuu1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907261; c=relaxed/simple;
	bh=cXFzntfIyxI7W5Ve4C3WFxkZ1PmXt/SoiLVxKVar2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgUL3JhcSeR/aW5XBuDrbPGAdJoa1Me6QOku4E1X6DhkqV30xhTnzzLNJlwqSTOA6xMqOjNZfNaqbBjtVki9VwnLXicIO31vUyUj9yMqsUz0DLxZx5Jk12Lx7+NJlVJ12hrhE+O7AJLh4fK6QO/Sz97u3GUBZtmeyQ5Ga7YbMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JT+HypB+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724907260; x=1756443260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXFzntfIyxI7W5Ve4C3WFxkZ1PmXt/SoiLVxKVar2V4=;
  b=JT+HypB+b6BNeEQcz2Q0OM9wlSjNG4a/PFPKEnBlS4+UYJrvFtY+U0SZ
   omhvUOuA/89taJeCHBQAwu2J0Ves2GT6vviEmj7i5UDWO8j0OA5ccdL8c
   Ksa/wTSCo8HaQbDhlJoPp6MV4IpBQuVgSQSP2UCI1OyErVxTRUhIBWYVM
   nxh/h25AJhEQEwMzJUV579bdo0ipw7mF7REXyM4zxin4zm3yfoGBL3Z8I
   eSKRcB3CzTHcICDAVZ70Y/MHB8Sj06Rtsx42WFSdQi5WTWHiZmLLTrCzi
   zdIQSi8aMHKw/fuEoBi8Oabw6WAL8fHJyEcXKnuqhDrZmuT7+tXznjAZg
   A==;
X-CSE-ConnectionGUID: sOcUJRcOSZGA+Qn4x3/cpw==
X-CSE-MsgGUID: vIsaNBWESrGoL5PKzT3yAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23641748"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23641748"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:54:20 -0700
X-CSE-ConnectionGUID: KpEOCzIfSvaXNkChtqmNhg==
X-CSE-MsgGUID: x3bUiK/fQjWX2suWI63jHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63093276"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:54:16 -0700
Date: Thu, 29 Aug 2024 06:52:21 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, horms@kernel.org,
	helgaas@kernel.org, przemyslaw.kitszel@intel.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v4 9/9] bnxt_en: Support dynamic MSIX
Message-ID: <Zs/+hbsyBVHUgoYl@mev-dev.igk.intel.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
 <20240828183235.128948-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828183235.128948-10-michael.chan@broadcom.com>

On Wed, Aug 28, 2024 at 11:32:35AM -0700, Michael Chan wrote:
> A range of MSIX vectors are allocated at initialization for the number
> needed for RocE and L2.  During run-time, if the user increases or
> decreases the number of L2 rings, all the MSIX vectors have to be
> freed and a new range has to be allocated.  This is not optimal and
> causes disruptions to RoCE traffic every time there is a change in L2
> MSIX.
> 
> If the system supports dynamic MSIX allocations, use dynamic
> allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
> vectors.  RoCE traffic is not affected using this scheme.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> v4: Simplify adding and deleting MSIX
> v2: Fix typo in changelog
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 37 +++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index fa4115f6dafe..c9248ed9330c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -10622,6 +10622,30 @@ static void bnxt_setup_msix(struct bnxt *bp)
>  
>  static int bnxt_init_int_mode(struct bnxt *bp);
>  
> +static int bnxt_change_msix(struct bnxt *bp, int total)
> +{
> +	struct msi_map map;
> +	int i;
> +
> +	/* add MSIX to the end if needed */
> +	for (i = bp->total_irqs; i < total; i++) {
> +		map = pci_msix_alloc_irq_at(bp->pdev, i, NULL);
> +		if (map.index < 0)
> +			return bp->total_irqs;
> +		bp->irq_tbl[i].vector = map.virq;
> +		bp->total_irqs++;
> +	}
> +
> +	/* trim MSIX from the end if needed */
> +	for (i = bp->total_irqs; i > total; i--) {
> +		map.index = i - 1;
> +		map.virq = bp->irq_tbl[i - 1].vector;
> +		pci_msix_free_irq(bp->pdev, map);
> +		bp->total_irqs--;
> +	}
> +	return bp->total_irqs;
> +}
> +
>  static int bnxt_setup_int_mode(struct bnxt *bp)
>  {
>  	int rc;
> @@ -10788,6 +10812,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
>  int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  {
>  	bool irq_cleared = false;
> +	bool irq_change = false;
>  	int tcs = bp->num_tc;
>  	int irqs_required;
>  	int rc;
> @@ -10806,15 +10831,21 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	}
>  
>  	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
> -		bnxt_ulp_irq_stop(bp);
> -		bnxt_clear_int_mode(bp);
> -		irq_cleared = true;
> +		irq_change = true;
> +		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
> +			bnxt_ulp_irq_stop(bp);
> +			bnxt_clear_int_mode(bp);
> +			irq_cleared = true;
> +		}
>  	}
>  	rc = __bnxt_reserve_rings(bp);
>  	if (irq_cleared) {
>  		if (!rc)
>  			rc = bnxt_init_int_mode(bp);
>  		bnxt_ulp_irq_restart(bp, rc);
> +	} else if (irq_change && !rc) {
> +		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
> +			rc = -ENOSPC;
>  	}
>  	if (rc) {
>  		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
> -- 
> 2.30.1

Thanks,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 

