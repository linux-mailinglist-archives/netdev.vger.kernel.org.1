Return-Path: <netdev+bounces-197997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD76ADAC9E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE54172765
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032C274FEF;
	Mon, 16 Jun 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gt8MozBb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24D20CCC9;
	Mon, 16 Jun 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067926; cv=none; b=bZYaOMNqViD4hYspobFkhVA8L+prysNZPQqVsniIB9Wk8s6Ro8BjP3Esd77w5YrDG3sgZB0ehGxHPPQNSNLW5TMbG6OR32YosKxwc95+ND/ZWVFt6dbq+pYsjv/uuLAKKovBAa45D8PSEmOA3oU7hutZ/BRWoeGq+j2G+PxZ+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067926; c=relaxed/simple;
	bh=+Csrh8Kfzn8kd4FJmLF8SymNL20EH5htPPZSRg0AMZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7psyREqp4ACVg4h4Z7W9MiCaPfzC9srix+U1MFPDncCxBQkn10nnKrUnUUB7L0B3y1qse0xS3lGpIU3Nox9erKco6pujnaxsQDzhgmgHYEyTE7z3vE/i/ViCmJ9B2RbKOCwK3a+C0CmCfmYywES59cjV2QAC2dUNNO+iyDiK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gt8MozBb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750067925; x=1781603925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Csrh8Kfzn8kd4FJmLF8SymNL20EH5htPPZSRg0AMZg=;
  b=Gt8MozBb5C4drUWjPF1HQiBGV7JjlvLds9chHJey9K2m+6SU49ozwLaz
   jqdQkHbRwvggIMeuHZUiNGIK9vzTMSNR99Fa6uPiQXjaUYux7b5VEnNCK
   LiVL1PPweBqUR/1bYyEPXTGe+NwI/VmiNWKVOs1WBK18DVxJdx7jqkb2Y
   Sck0+P5YKdQiB5/W3BQrUpX5fGhNw67PSMGkoGvg57AaL215LFBdnlyXj
   nYxHbhjNefyijoHaxwtcIJvWn4xH/EISazdmRBnpeTTYws7MhPYTrA+HH
   lf2klPUyYvd6TBarslLVWYgS7rG6llGV0xxybXP69e1jzBNY/sRAoIMx0
   g==;
X-CSE-ConnectionGUID: 9ugAcghVS+acWaCvijYahA==
X-CSE-MsgGUID: F7ksmCk2QWCn7ymIsI8+Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="55881259"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="55881259"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 02:58:44 -0700
X-CSE-ConnectionGUID: KUOhbcipS3u5b+RKIrlUvw==
X-CSE-MsgGUID: pcYx1Yo8TNWJwQll4VsULg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148418811"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 02:58:42 -0700
Date: Mon, 16 Jun 2025 11:57:53 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: linux@treblig.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: liquidio: Remove unused
 validate_cn23xx_pf_config_info()
Message-ID: <aE/qoenmfq00npVJ@mev-dev.igk.intel.com>
References: <20250614234941.61769-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614234941.61769-1-linux@treblig.org>

On Sun, Jun 15, 2025 at 12:49:41AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> [Note, I'm wondering if actually this is a case of a missing call;
> the other similar function is called in __verify_octeon_config_info(),
> but I don't have or know the hardware.]
> 
> validate_cn23xx_pf_config_info() was added in 2016 by
> commit 72c0091293c0 ("liquidio: CN23XX device init and sriov config")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  .../cavium/liquidio/cn23xx_pf_device.c        | 39 -------------------
>  .../cavium/liquidio/cn23xx_pf_device.h        |  3 --
>  2 files changed, 42 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> index ff8f2f9f9cae..75f22f74774c 100644
> --- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> +++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> @@ -1208,45 +1208,6 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
>  }
>  EXPORT_SYMBOL_GPL(setup_cn23xx_octeon_pf_device);
>  
> -int validate_cn23xx_pf_config_info(struct octeon_device *oct,
> -				   struct octeon_config *conf23xx)
> -{
> -	if (CFG_GET_IQ_MAX_Q(conf23xx) > CN23XX_MAX_INPUT_QUEUES) {
> -		dev_err(&oct->pci_dev->dev, "%s: Num IQ (%d) exceeds Max (%d)\n",
> -			__func__, CFG_GET_IQ_MAX_Q(conf23xx),
> -			CN23XX_MAX_INPUT_QUEUES);
> -		return 1;
> -	}
> -
> -	if (CFG_GET_OQ_MAX_Q(conf23xx) > CN23XX_MAX_OUTPUT_QUEUES) {
> -		dev_err(&oct->pci_dev->dev, "%s: Num OQ (%d) exceeds Max (%d)\n",
> -			__func__, CFG_GET_OQ_MAX_Q(conf23xx),
> -			CN23XX_MAX_OUTPUT_QUEUES);
> -		return 1;
> -	}
> -
> -	if (CFG_GET_IQ_INSTR_TYPE(conf23xx) != OCTEON_32BYTE_INSTR &&
> -	    CFG_GET_IQ_INSTR_TYPE(conf23xx) != OCTEON_64BYTE_INSTR) {
> -		dev_err(&oct->pci_dev->dev, "%s: Invalid instr type for IQ\n",
> -			__func__);
> -		return 1;
> -	}
> -
> -	if (!CFG_GET_OQ_REFILL_THRESHOLD(conf23xx)) {
> -		dev_err(&oct->pci_dev->dev, "%s: Invalid parameter for OQ\n",
> -			__func__);
> -		return 1;
> -	}
> -
> -	if (!(CFG_GET_OQ_INTR_TIME(conf23xx))) {
> -		dev_err(&oct->pci_dev->dev, "%s: Invalid parameter for OQ\n",
> -			__func__);
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
>  int cn23xx_fw_loaded(struct octeon_device *oct)
>  {
>  	u64 val;
> diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
> index 234b96b4f488..bbe9f3133b07 100644
> --- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
> +++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
> @@ -54,9 +54,6 @@ struct oct_vf_stats {
>  
>  int setup_cn23xx_octeon_pf_device(struct octeon_device *oct);
>  
> -int validate_cn23xx_pf_config_info(struct octeon_device *oct,
> -				   struct octeon_config *conf23xx);
> -

Looks like it was never used, even in the patch when it was introduced.
I wonder if it shouldn't go to __verify_octeon_config_info() for
OCTEON_CN23XX_PF_VID, but if it works for such long time, I think it is
fine to drop.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  u32 cn23xx_pf_get_oq_ticks(struct octeon_device *oct, u32 time_intr_in_us);
>  
>  int cn23xx_sriov_config(struct octeon_device *oct);
> -- 
> 2.49.0

