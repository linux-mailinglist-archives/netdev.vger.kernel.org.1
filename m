Return-Path: <netdev+bounces-162405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81310A26C18
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A731888BE1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B359C200B89;
	Tue,  4 Feb 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiwF+bc8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910A25A655;
	Tue,  4 Feb 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650019; cv=none; b=sg0kAT4CXv52Y8SxK1b7DeM9veRgY04Jy/PvTKWAnCHY/SkpB5Hxh4XryCXPFmBGP0e/qeX+wI1i+aiqia3Db+RbgRJGaB2Kk5S4t1cxcZ9Z66cYDv7F0n8UAEu4ax7ogJ2C9h3UwOkPzr0qJcS1B+FueJXSgPv1uAOdOHkDJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650019; c=relaxed/simple;
	bh=HkcZscvvD3gCXyz29syjOg7HivyYRZkHBV9qK8IwClI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvJ32n5kH2bTIMBy/VGuLS1NAxJGWtqoHuKZeT4Uo4lcUG4ToS+QI75o4nSPtQuituBTHdxcpux4FhMZCRqiA71Jrhfdyjp5h/+do9z24VJb68YMXSVUY2Mq8m8K2AVVCuKJo029ar2cbklmakLefvW76wZga0xAs4VylHBLhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiwF+bc8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738650018; x=1770186018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HkcZscvvD3gCXyz29syjOg7HivyYRZkHBV9qK8IwClI=;
  b=YiwF+bc8fty90hNnOU6hfWGGwvj3vYZv1i3fbmoJZXLyWqNUOjbj6Nts
   TW+14U2/nG6/y44NOlbszQ4FZX6ZCUAfaOlD4CHzDSUCG3tdrSe1+sYH0
   dZtsnuRvyyqI3yT2RqrUuQhUh6pduj39WTRE4Y69ASHaQANQAJSU8fRoE
   Rft8TRFYtNMo9bIzphPPrBiw5biqRiFz7koouftdJdQjgPp5CnhMoF7Iw
   7FAlkdEJUPWA7YVUUr1PR/UsPry/hIT50IzvSP/T2pZMF/RKRZtc6vCie
   XABj8UAgvSpqKqn9T9dupNF6C8CPjl+34RV1XYuS9+HREKejm5qwpwwZ1
   w==;
X-CSE-ConnectionGUID: ZiN7WtePTYawQRPoIPRvvA==
X-CSE-MsgGUID: rGgwreD2Tc6aiY6Nk6uceA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50580252"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50580252"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:20:16 -0800
X-CSE-ConnectionGUID: bVraY+nvRnmI6DT4JpRhIg==
X-CSE-MsgGUID: G5FdLvNeS8mBz2ueWN9oeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110280685"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:20:14 -0800
Date: Tue, 4 Feb 2025 07:16:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] net: atlantic: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6GwydOggtMRqYCY@mev-dev.igk.intel.com>
References: <Z6F3KZVfnAZ2FoJm@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6F3KZVfnAZ2FoJm@kspp>

On Tue, Feb 04, 2025 at 12:40:49PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unused flexible-array member `buf` and, with this, fix the following
> warnings:
> drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Suggested-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Remove unused flex-array member. (Igor)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZrDwoVKH8d6TdVxn@cute/
> 
>  drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
> index f5901f8e3907..f6b990b7f5b4 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
> @@ -226,7 +226,6 @@ struct __packed offload_info {
>  	struct offload_port_info ports;
>  	struct offload_ka_info kas;
>  	struct offload_rr_info rrs;
> -	u8 buf[];
>  };

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
>  struct __packed hw_atl_utils_fw_rpc {
> -- 
> 2.43.0
> 

