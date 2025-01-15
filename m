Return-Path: <netdev+bounces-158390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF3A11961
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 06:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B53C7A1EB8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 05:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DC22E419;
	Wed, 15 Jan 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh7ydqTO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB929A5;
	Wed, 15 Jan 2025 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920706; cv=none; b=sXED4UnNLuo7BSSkM8DRl8a/2RMzQcHKViOh0LIlLagskGA8WP41UnyOpQFvbv3WWWk08/kX7PPVdWIhmhIUXTYc0pa1k6XF2qBJD2qkckPMI4naTawI6LGpdH+jpT5rM0EPF1ztnXoJurwxk3d2TwaZqtn0LdchoZOl8B577kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920706; c=relaxed/simple;
	bh=ee7/cU8Rh7hsiv0IFSWaCv5xbg/nU6TL/m27ZjUv5WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0iuRH1051dT1ayXxfmX2tJ9F6pfOmh+OlDCHvm1LTaTzC3f8wQUyTtqR/cswC0hToUavrKoHjcZoOyGVlu+kuote1jQ0jIfFnRK4a0xmzoENSMZ8xrlN9pRJDWeV6SeZfeW1IYjYQrL8kOvpwtnmW02VIyW2X5NOq6ncWE0Roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh7ydqTO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736920705; x=1768456705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ee7/cU8Rh7hsiv0IFSWaCv5xbg/nU6TL/m27ZjUv5WQ=;
  b=Nh7ydqTO0TRcbvOhgXwJTJBsBlAX3Lps1iU6NU37xt7v5i7lJyUXLajX
   llU3umM40hvhjyBFcklTOFLnm8qiPBl1F6FFlv+tmfQCfyOyK7ZVZTQU4
   +1YC25vF01aVtLIcLX32DVgLcORmUovAKt8xaxglE+CjsfNQSu7mzJ9fy
   ZysgfXD1LrYfoDvhNKcRA2rn0mAlKtADXzkv+TyGja39kKrgB8thWsp41
   ZHamnA68BDX14MV0piEV1+ey9quP3rxOfQ9wriZAf6Ko10N4vG4E8Zbjw
   GRpEMh3U8qJ/AN/NljeAjiWrd8exsSDV2N+EL4SJP6trB2YKnxRmOagYI
   w==;
X-CSE-ConnectionGUID: mtb1M9prQwSZQiXbKji7ow==
X-CSE-MsgGUID: NqKSFYPVTyu2fg1hxyHsRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40053090"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="40053090"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:58:24 -0800
X-CSE-ConnectionGUID: Z/y2dthoQ62/tnmXEbvudg==
X-CSE-MsgGUID: 8WCvsK4hT1+UlRAsc8mHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105627746"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:58:21 -0800
Date: Wed, 15 Jan 2025 06:55:01 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI
 descriptor registers
Message-ID: <Z4dNkNLkQlSPA/SA@mev-dev.igk.intel.com>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>

On Wed, Jan 15, 2025 at 09:11:17AM +0530, Dheeraj Reddy Jonnalagadda wrote:
> The ixgbe driver was missing proper endian conversion for ACI descriptor
> register operations. Add the necessary conversions when reading and
> writing to the registers.
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
> Changelog
> 
> v2:
> 	- Updated the patch to include suggested fix
> 	- Updated the commit message to describe the issue
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 683c668672d6..3b9017e72d0e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -113,7 +113,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  
>  	/* Descriptor is written to specific registers */
>  	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> -		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> +		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), cpu_to_le32(raw_desc[i]));
>  
>  	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
>  	 * PF_HICR_EV
> @@ -145,7 +145,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_SV)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];
> +			raw_desc[i] = le32_to_cpu(raw_desc[i]);
>  		}
>  	}
>  
> @@ -153,7 +153,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];
> +			raw_desc[i] = le32_to_cpu(raw_desc[i]);
>  		}
>  	}
>  
> -- 
> 2.34.1
> 
Thanks for fixing it
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

