Return-Path: <netdev+bounces-157633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1212FA0B150
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B31887C12
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F2233D8F;
	Mon, 13 Jan 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYO2z+qq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FD23315B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757509; cv=none; b=PqoMkRwtczusYWiuWawNvSqyMOqRaY+m8gYMSqzbTCZLpl0D/lt7iFwhsTslt/guA+GGoxsgAxfnCTJzIzpSP0BkQr5jAM7t08k24EpcH/agFWBwFipMHDSuYzsxM7jbmHWE3zV8XpVtnKUlD8mwc6OibpKfJH+wWIONYQc3UKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757509; c=relaxed/simple;
	bh=BspYZRAt7MCgE0PD2ijME2OppR515dtn89RrQpBJV1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+Rluq+R3v6MhNfeY3R0PVoLF+l8xCoo7rbnO3kaU2EKaZ0B24Pff0bPFX+GqpSc33JYKUIGuHVuRijfx1/YnMT7zrn1+V5Ip8cpqEZCAMakjfl+AwukLjMDXEAAqUp/Sd5fr6uhzbHBX7axzvGSJ6vfWkiTrReUQa4b7pVIE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYO2z+qq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736757509; x=1768293509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BspYZRAt7MCgE0PD2ijME2OppR515dtn89RrQpBJV1Y=;
  b=VYO2z+qqEq9rkNxOM1HkFBvK4JZPj742Vnavr18XacPQ7ozanIRq9YSd
   0xjeD1khnnAo1nY4urAiTeiJSskUoZ52XhgbJB1Vi2+k9lfpCCvdMB3t+
   BYNlDLT1D6R63JRsGyej3mC7OxzA54+ST6NnJsmqp4Vt5M6udPV90A3oG
   mKmglfG9RPvu/nvl38sBRO3nNe0jLrQoA+3djhdZQ7JN7ehsW/5LBQVU9
   1+mNPiVCUGY6iitHMUKhRJhD4GuGy8hDk6G/EBahRIcRttze5+CD8SpOB
   OsdY0xE4UyhEoODxa+0S+4cucejM3gC+xwNUJln30BWeuoojGieOP/nLU
   g==;
X-CSE-ConnectionGUID: BRvOlTdkRC2KehCI0OElcA==
X-CSE-MsgGUID: y2aZo7b0Qbi5KIXdptJALg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40681045"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40681045"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:38:28 -0800
X-CSE-ConnectionGUID: Qa0CgibYQYKYcf07CHHDPQ==
X-CSE-MsgGUID: zeBYJq4JQvmQIll42tyHqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109335788"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:38:25 -0800
Date: Mon, 13 Jan 2025 09:35:07 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 08/10] bnxt_en: Reallocate Rx completion ring
 for TPH support
Message-ID: <Z4TQK4pSFJd0y1Jd@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-9-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:25PM -0800, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> In order to program the correct Steering Tag during an IRQ affinity
> change, we need to free/re-allocate the Rx completion ring during
> queue_restart.  Call FW to free the Rx completion ring and clear the
> ring entries in queue_stop().  Re-allocate it in queue_start().
> 
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 +++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 30a57bbc407c..fe350d0ba99c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7399,6 +7399,19 @@ static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
>  	ring->fw_ring_id = INVALID_HW_RING_ID;
>  }
>  
> +static void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
> +{
> +	struct bnxt_ring_struct *ring = &cpr->cp_ring_struct;
> +	int i, size = ring->ring_mem.page_size;
> +
> +	cpr->cp_raw_cons = 0;
> +	cpr->toggle = 0;
> +
> +	for (i = 0; i < bp->cp_nr_pages; i++)
> +		if (cpr->cp_desc_ring[i])
> +			memset(cpr->cp_desc_ring[i], 0, size);
> +}
> +
>  static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
>  {
>  	u32 type;
> @@ -15618,10 +15631,15 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
>  	if (rc)
>  		return rc;
> -	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
> +
> +	rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
>  	if (rc)
>  		goto err_free_hwrm_rx_ring;
>  
> +	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
> +	if (rc)
> +		goto err_free_hwrm_cp_ring;
> +
>  	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
>  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
>  		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
> @@ -15645,6 +15663,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  
>  	return 0;
>  
> +err_free_hwrm_cp_ring:
> +	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
>  err_free_hwrm_rx_ring:
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	return rc;
> @@ -15669,11 +15689,13 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> -	rxr->rx_next_cons = 0;
Unrelated?

>  	page_pool_disable_direct_recycling(rxr->page_pool);
>  	if (bnxt_separate_head_pool())
>  		page_pool_disable_direct_recycling(rxr->head_pool);
>  
> +	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
> +	bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
> +
>  	memcpy(qmem, rxr, sizeof(*rxr));
>  	bnxt_init_rx_ring_struct(bp, qmem);
>  

Rest looks fine:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.30.1

