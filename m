Return-Path: <netdev+bounces-168905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8902CA4162F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A3A3AC784
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD31DF963;
	Mon, 24 Feb 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKiwQORs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A24414;
	Mon, 24 Feb 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381953; cv=none; b=LyYv+xkMr8WMN9U3ar8GhQptrK2K2QA2SVzQGtTKj6d1pC1U2K/jwz5VUYvn151M8bStUhB9kUAg0Z2QL0pAds+OmoJUjd/h5N/VTJNo/IwD2uhZXpxvVshFaTopjK0feaI663KdYlufNiFhi1yiTdCryW2kTFSOvuhR2tRB2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381953; c=relaxed/simple;
	bh=V5PrS03/1N+lOBDHmbvokVfJz8kHXIKEr5Xg2RwNgD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5EU/TM95UY/0fUL91OY6n2yCe9JprkXaA8rtzY9F3CT2TGrUvhUlS3cvYunYW48iylcM0/tXAcrs4lDD8vJHiFbUyidI5NuszZC0GOavspWn2ivi62B5LZMHwrMgcRO2UYJuPbquFIy/z0gB0XiCLjbkFeVcP2B3MFmzffrL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKiwQORs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740381952; x=1771917952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V5PrS03/1N+lOBDHmbvokVfJz8kHXIKEr5Xg2RwNgD8=;
  b=LKiwQORss2MSk4AZEYnPTzI4OUCb4kvZ/DZpITUYmfj/7jmkMfZ0xeMk
   ToqNnozDt6dU8XPxblJS3DdDVPXHifBMyHwHeUTZbuSGuvBOne5TYOmXg
   Sv0pyNjR+Nz8ea+I67fHCTwSZtk80EyGTjypgvXpsZAFuLKNXPKnb7gwG
   UsfFc4eTCUIxYi7a3h+tgubtZUo1GeMHvaK+3h/VVrj0JReQSqO5NET/3
   9sHusVQfaA72rmn5EJWaEfC920Apvk8pyoMyQoIJAECYgza9Bmr6Ok9ZD
   cwD7qGRuSZYIQCvAhFh9tgIIqz6ADphfrzmvaUk7cwtzT4ef0ltRZ1W53
   Q==;
X-CSE-ConnectionGUID: iwrXaTj4Qhasgqb99FEbgA==
X-CSE-MsgGUID: zKSpuJSlQMyhshEhQNBuOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="43955173"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="43955173"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 23:25:51 -0800
X-CSE-ConnectionGUID: 70pRwv/LTdC4zptT1ieOBg==
X-CSE-MsgGUID: 4LiYCxXWQS+sdNNNNe8ixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115817879"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 23:25:49 -0800
Date: Mon, 24 Feb 2025 08:22:05 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: select PAGE_POOL
Message-ID: <Z7weHW5bJnYpiAEN@mev-dev.igk.intel.com>
References: <20250224-net-am654-nuss-kconfig-v2-1-c124f4915c92@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-net-am654-nuss-kconfig-v2-1-c124f4915c92@pengutronix.de>

On Mon, Feb 24, 2025 at 06:17:16AM +0100, Sascha Hauer wrote:
> am65-cpsw uses page_pool_dev_alloc_pages(), thus needs PAGE_POOL
> selected to avoid linker errors. This is missing since the driver
> started to use page_pool helpers in 8acacc40f733 ("net: ethernet:
> ti: am65-cpsw: Add minimal XDP support")
> 
> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Changes in v2:
> - Add missing Fixes: tag
> - Link to v1: https://lore.kernel.org/r/20250220-net-am654-nuss-kconfig-v1-1-acc813b769de@pengutronix.de
> ---
>  drivers/net/ethernet/ti/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 0d5a862cd78a6..3a13d60a947a8 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -99,6 +99,7 @@ config TI_K3_AM65_CPSW_NUSS
>  	select NET_DEVLINK
>  	select TI_DAVINCI_MDIO
>  	select PHYLINK
> +	select PAGE_POOL
>  	select TI_K3_CPPI_DESC_POOL
>  	imply PHY_TI_GMII_SEL
>  	depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS
> 
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250220-net-am654-nuss-kconfig-ab8e4f4e318b
> 
> Best regards,
> -- 
> Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>



