Return-Path: <netdev+bounces-156168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D14A0533B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BB71881BF6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21219EEBF;
	Wed,  8 Jan 2025 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwKfgJn2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1C3FBB3
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318017; cv=none; b=HCm9b/Vr0Rl8/INP00TKlP1cTOGtEv1JTlikLzbaNewhmC5uHCzzsou0Os5o1T4EtlJ0BBxsefpyd3Lg8MOP5NSzKv8Z2LCQ6N20HPCbSCgtFZFmvtwfaTL0IAj5kr8fIIx9Vbns1sigwwTD6TRY4oUzNWRU3BF1rYJ8jNDUuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318017; c=relaxed/simple;
	bh=Y+3WLFUHiecuWtf4CXQDQ2ItKyEPSslOv3K2SCmEsxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNWVGioMSf/aZAhSNm42l33hlxvH9O6wvS0MPAjbmQ4tKGTPB8gkdfn1jHhbMxldZ0QdMm2xw3WSOhj2KHobXiKJk/Sx70tiA5AmXgKDj6wtQ2yPV2aYm3pL7W6jN8l9C/F09DCoa0qNWRlbA0Hp2Kcdd1J+24vjPfHF/Hjy10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwKfgJn2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736318016; x=1767854016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y+3WLFUHiecuWtf4CXQDQ2ItKyEPSslOv3K2SCmEsxo=;
  b=iwKfgJn2no9ZXHJbFfc5K9X1F40fV3NdOs2MFPHnXY9MxqqfqdFHFFoK
   gVdlOrsWwiwahTkoxuxktkXUeXwc/3wDXyttfmSYcjKH0Q2JUmhK+OcpW
   VIESyLGERkbJ5HHHcR0xAw96hy6hrPJK4UGHiAGbp9hu4q2arehNnQMxO
   6PBQ+7Y7gA+dvxwBf/kFlxqkotdkzRIw8bmbi/V8buxV3D5BMRr1aoT3z
   v3yosI6AEXn78nPJsR6zTVy5E/dLrKZU+0wS057cPJTZnEeSHAp3OuK86
   mI1LHkJH0Rtx/Wl4DNFCypqRdHqmFq8+oU0q/iKaNn8VRjpS2s2qjWi37
   w==;
X-CSE-ConnectionGUID: JyZ0A8klQRankp4YK9dZSw==
X-CSE-MsgGUID: 7VK0Pfz7TUCbWsmzw+au0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47521170"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="47521170"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 22:33:35 -0800
X-CSE-ConnectionGUID: TecSxbjGQvKbnbP5KhRkPg==
X-CSE-MsgGUID: kI9T8cReSyu5/EPHLmXTuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="103505686"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 22:32:43 -0800
Date: Wed, 8 Jan 2025 07:29:24 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbe: Remove redundant self-assignments in ACI
 command execution
Message-ID: <Z34bRACSRyOWRQoM@mev-dev.igk.intel.com>
References: <20250108053614.53924-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108053614.53924-1-dheeraj.linuxdev@gmail.com>

On Wed, Jan 08, 2025 at 11:06:14AM +0530, Dheeraj Reddy Jonnalagadda wrote:
> Remove redundant statements in ixgbe_aci_send_cmd_execute() where
> raw_desc[i] is assigned to itself. These self-assignments have no
> effect and can be safely removed.
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 683c668672d6..408c0874cdc2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -145,7 +145,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_SV)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];

raw_desc should be always in le32, probably there was a conversion which
was removed between patchset versions. Adding orginal author in CC to
confirm that no conversion here is fine.

Thanks,
Michal

>  		}
>  	}
>  
> @@ -153,7 +152,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];
>  		}
>  	}
>  
> -- 
> 2.34.1

