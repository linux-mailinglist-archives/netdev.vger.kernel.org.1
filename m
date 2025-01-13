Return-Path: <netdev+bounces-157632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D0A0B128
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440091882869
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093623312B;
	Mon, 13 Jan 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kW5LbSe+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FB233120
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757156; cv=none; b=RKC2SmnYr9Xsrpd4fBNzv5KHJraPkalOhAqkIORJyNIm4b/r96+VF/Z8npvwddqgM6K18COFWLKSdkpSHhWiZPV0ByVHkxEPW16SmtrQmzS0fSOjKKnrCsYnjipLpY+GPAaMcDTBiErkfOv/FaS0JkTANrSeLpJA1iuJ+y5IrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757156; c=relaxed/simple;
	bh=u1jLxSP+3t+kxan8TQ8KEtykO5Kw5Zw/Cy7nziodO4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoR0JS8tkcufar2hNZWW5K6j6TMhmrcRXcWlhz7AXlI2hlI209+eSQ7P/iDrlJlhEDN9rIjTlsOD07VgXGGGG/svp+xTb1aOAQHEuDe5AXe/+IVlQkOMZlh+oNU3P9xlDn4tHo/mi2j2OZItMXJ/Vdgr6golGJ7o7ZOODJ2FVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kW5LbSe+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736757155; x=1768293155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1jLxSP+3t+kxan8TQ8KEtykO5Kw5Zw/Cy7nziodO4k=;
  b=kW5LbSe+BQV3rWEUqFV/W+28/iIh8xSwPkNOLaU2xeHlVUPGjJ5zHFcx
   ozCgTdAOwyBB5BlbrYqh+VLEYHpSZh419bScCXb+nx2xn9wQFiUv807Tj
   RmZcoVpGXFP5VuZarD6Ye018ag9Ygw066GLZJrxVlMbCL0kFDH98NZ4PA
   PfYiQjMb5PBTBa4M3oTC+ADfWU16DLAiuh4D/FxbynbQwGOGmjawa28f6
   TnV8yK5M4ymKgxkJkpoWaQkZD8xRfCCTsZhvYaQysHj/ETmmVWfmZnSxs
   iKvEZ720zfoq34aUudU/7Fu1sdl/D4MNvdUrR1P9J4vf6B+8slQjfHGe8
   w==;
X-CSE-ConnectionGUID: PH55VIHIT9ybJHgouEIyYw==
X-CSE-MsgGUID: jL7ulam1TaeZSbRGlRw9RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37025091"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37025091"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:32:34 -0800
X-CSE-ConnectionGUID: wCRy7sOLQNqHQhjgeg4Kaw==
X-CSE-MsgGUID: A+6UUpJcTcGSMeYAW/Q2Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108466362"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:32:31 -0800
Date: Mon, 13 Jan 2025 09:29:13 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 07/10] bnxt_en: Pass NQ ID to the FW when
 allocating RX/RX AGG rings
Message-ID: <Z4TO2fPPhvcPmPyb@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-8-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:24PM -0800, Michael Chan wrote:
> Newer firmware can use the NQ ring ID associated with each RX/RX AGG
> ring to enable PCIe Steering Tags on P5_PLUS chips.  When allocating
> RX/RX AGG rings, pass along NQ ring ID for the firmware to use.  This
> information helps optimize DMA writes by directing them to the cache
> closer to the CPU consuming the data, potentially improving the
> processing speed.  This change is backward-compatible with older
> firmware, which will simply disregard the information.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c862250d3b77..30a57bbc407c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -6922,7 +6922,8 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
>  				       struct bnxt_ring_struct *ring)
>  {
>  	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
> -	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
> +	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
> +		      RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID;
>  
>  	if (ring_type == HWRM_RING_ALLOC_AGG) {
>  		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
> @@ -6936,6 +6937,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
>  				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
>  	}
>  	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
> +	req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
>  	req->enables |= cpu_to_le32(enables);
>  }
>  
> -- 
> 2.30.1

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

