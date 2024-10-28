Return-Path: <netdev+bounces-139437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 549379B251E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 07:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75E2B20C5B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05CA18CC12;
	Mon, 28 Oct 2024 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZEk9UsC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA117A596
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095976; cv=none; b=l1NS8c/oGLQwce/8+peY5eO7jCDw08gn9j7Y3kUiGrmPx+ViMh8Ud2G5Ng7p2AWUaYz2o8XOBAieaRnJ6bcTuqrDXIWgVGek0o0F2siWUwpHY26Y+9ScZBbaSPSICKZymvzzg4vYS86suJx7DYZanCsyUtcDQTlEygLkTwfR7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095976; c=relaxed/simple;
	bh=aFKuH9nVbtC0ZkRrh/M9jpQfvq12RJ+0LBd5hje0Xbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seX1o2fLj/tL9f+Cac0XSSOp2TKYU5lJw2sZ5c+KYzWV34UbOFEp6TnIiQN8q/NJDis99uwyKsD9KJkvIfgOocOLUDKqXUGFRnUpSKHK0vWHLpBPRXUlMdXaEw/m/beXxu8Tg8cnGB1GaZQXz2+KtVCXOVSEmmVrbrVNgGSyNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZEk9UsC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730095975; x=1761631975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aFKuH9nVbtC0ZkRrh/M9jpQfvq12RJ+0LBd5hje0Xbo=;
  b=eZEk9UsClkUH3GGXcHM1bUwubEW6QC/YUGwkH1gcC+aFubgoclVqcp2O
   ClkP/IXF21px7rmMYi0XPDoVDQWxLyZa1bR020CkI4xi6un90zQjbA5Tu
   IhA4bl61FrznPOJsVZi7OfEH2RWatvK4wfv9FwONJVqnJC62EfINBG8Tw
   CtF3R0xPYfMUSfm3p+8otb4S9eR+KS5jPBxshhT/Q7KJDb9MQHZ2+RrUG
   1jcINxWwXiIi5m8ICxBHD21lhYRkvM/y8jzo4yiym49oPyfbvEqShSxOs
   qeEYq92xhbySdlAldlsGma27VHNPBXzJ5LK5sbI8afaMLnTzq+JQ9v0Go
   A==;
X-CSE-ConnectionGUID: LTYAHiToT6WVk2dnBGVUQQ==
X-CSE-MsgGUID: VzYUolitSIqGSa8qWM1qqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29642072"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29642072"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 23:12:54 -0700
X-CSE-ConnectionGUID: kyV8Tj/gQymNQvf+2pFy9A==
X-CSE-MsgGUID: rgK1zgujTC6xK1nXNcH8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81462453"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 23:12:51 -0700
Date: Mon, 28 Oct 2024 07:10:12 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com
Subject: Re: [iwl-next v5 2/9] ice: devlink PF MSI-X max and min parameter
Message-ID: <Zx8qxF+4EPQZnO0k@mev-dev.igk.intel.com>
References: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
 <20241024121230.5861-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024121230.5861-3-michal.swiatkowski@linux.intel.com>

On Thu, Oct 24, 2024 at 02:12:23PM +0200, Michal Swiatkowski wrote:
> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> range.
> 
> Add notes about this parameters into ice devlink documentation.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  Documentation/networking/devlink/ice.rst      | 11 +++
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
>  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
>  4 files changed, 107 insertions(+), 1 deletion(-)
> 

[...]

> diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> index ad82ff7d1995..0659b96b9b8c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> @@ -254,6 +254,13 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
>  	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
>  	int vectors, max_vectors;
>  
> +	/* load default PF MSI-X range */
> +	if (!pf->msix.min)
> +		pf->msix.min = ICE_MIN_MSIX;
> +
> +	if (!pf->msix.max)
> +		pf->msix.max = total_vectors / 2;

Probably it will be better to set max to the value that PF needs after
calling ice_ena_msix_range(). I will send next version with that change,
please not pull.

Thanks,
Michal

> +
>  	vectors = ice_ena_msix_range(pf);
>  
>  	if (vectors < 0)
> -- 
> 2.42.0
> 

