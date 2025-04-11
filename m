Return-Path: <netdev+bounces-181500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E96FA853DB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071F3161EDE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD51EE00C;
	Fri, 11 Apr 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcitliSo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4D1E0E15
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351371; cv=none; b=KLIVCiP9rMnhnZhveNlvSw4sBmpoTYO1zLhKGAIt0wBWcGDDfijUXcyJDScdCUO4AWcxuYbKDIk94UFB7kT5q1VCMt71q0FPXO5t3QsKxgOhqwtE1RMh7+PfxqsW8rgB5Cqkv8bTEWsoNs75eUfbG+M+EgTki//gAf8SsuoG+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351371; c=relaxed/simple;
	bh=NKf5KeOfLVorPYyoK1YgtGvlZbAV4fKd+y+iIgoc1QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+0KPhkSCj8va3gxhauJRYh2GWMyVe6ez0r9nEHdVJMAusmwCN29mJE4a3MQ6yzc0G25nA6ng9tiS4U0cEXFLQ23/r2Zr/GwRiHDOQfOx5Df+Pr+mKRQ++vStZRWgRuK1LTJlpV/If1XVaaz99hJcB+CGMRoZsrk5DldeLq3OTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcitliSo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744351370; x=1775887370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKf5KeOfLVorPYyoK1YgtGvlZbAV4fKd+y+iIgoc1QM=;
  b=JcitliSobItio4XOZul2V0FQ9Bl/00i+ufKX//eZ3XPVCLyy5hZ0mi2z
   BBF7+TkEEiMWnjdqZuzJ/ghXpQ3ZM/FbHyFRdZLXBbzP3FRIbcBBHLcsi
   C8ZsD6AAls5ijb3mrD4WB8CiHG1HlgcfEYKD83vmGcdjTOdrqfmRCEZMA
   81ivJuJ9C5tqCkUumB0Dq6v+Ulwe4jUho1dQ5M0LriugyRx61zQdqPAY6
   pJpqOpQwA7eg9Y50J7nD0n0DldcWPC/CFVRJtiT/z/6keCUujrpMCDDu7
   TPkJUISHQnA73hKtqf6PpcXKoYS39MyLHBpkVfQRn/zp/jvNKeVBc5B5X
   w==;
X-CSE-ConnectionGUID: uFQx8oQAShqGbRYtN8a5vA==
X-CSE-MsgGUID: e46FKx8mTIGgH+i4YneSmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45134283"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45134283"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:02:49 -0700
X-CSE-ConnectionGUID: Ffy9UZLTSQ+xVtBq5owDwg==
X-CSE-MsgGUID: m+1ODMQyQL+LR7bUxitJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129072671"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:02:48 -0700
Date: Fri, 11 Apr 2025 08:02:31 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] ibmveth: Use WARN_ON with error handling rather
 than BUG_ON
Message-ID: <Z/iwd8qonlrfOkO5@mev-dev.igk.intel.com>
References: <20250410183918.422936-1-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410183918.422936-1-davemarq@linux.ibm.com>

On Thu, Apr 10, 2025 at 01:39:18PM -0500, Dave Marquardt wrote:
> - Replaced BUG_ON calls with WARN_ON calls with error handling,
>   with calls to a new ibmveth_reset routine, which resets the device.
> - Added KUnit tests for ibmveth_remove_buffer_from_pool and
>   ibmveth_rxq_get_buffer under new IBMVETH_KUNIT_TEST config option.
> - Removed unneeded forward declaration of ibmveth_rxq_harvest_buffer.

It will be great if you split this patch into 3 patches according to
your description.

> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/Kconfig   |  13 ++
>  drivers/net/ethernet/ibm/ibmveth.c | 242 ++++++++++++++++++++++++++---
>  drivers/net/ethernet/ibm/ibmveth.h |  65 ++++----
>  3 files changed, 269 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/Kconfig b/drivers/net/ethernet/ibm/Kconfig
> index c0c112d95b89..4f4b23465c47 100644
> --- a/drivers/net/ethernet/ibm/Kconfig
> +++ b/drivers/net/ethernet/ibm/Kconfig
> @@ -27,6 +27,19 @@ config IBMVETH
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called ibmveth.
>  
> +config IBMVETH_KUNIT_TEST
> +	bool "KUnit test for IBM LAN Virtual Ethernet support" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	depends on KUNIT=y && IBMVETH=y
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds unit tests for the IBM LAN Virtual Ethernet driver.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  source "drivers/net/ethernet/ibm/emac/Kconfig"
>  
>  config EHEA
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 04192190beba..ea201e5cc8bc 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -28,6 +28,7 @@
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>  #include <asm/hvcall.h>
>  #include <linux/atomic.h>
>  #include <asm/vio.h>
> @@ -39,8 +40,6 @@
>  #include "ibmveth.h"
>  
>  static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance);
> -static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> -				       bool reuse);
>  static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
>  
>  static struct kobj_type ktype_veth_pool;
> @@ -231,7 +230,10 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  		index = pool->free_map[free_index];
>  		skb = NULL;
>  
> -		BUG_ON(index == IBM_VETH_INVALID_MAP);
> +		if (WARN_ON(index == IBM_VETH_INVALID_MAP)) {
> +			(void)schedule_work(&adapter->work);

What is the purpose of void casting here (and in other places in this
patch)?

> +			goto failure2;

Maybe increment_buffer_failure, or sth that is telling what happen after
goto.

> +		}
>  
>  		/* are we allocating a new buffer or recycling an old one */
>  		if (pool->skbuff[index])
> @@ -300,6 +302,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  		                 DMA_FROM_DEVICE);
>  	dev_kfree_skb_any(pool->skbuff[index]);
>  	pool->skbuff[index] = NULL;
> +failure2:
>  	adapter->replenish_add_buff_failure++;
>  
>  	mb();
> @@ -370,20 +373,36 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>  	}
>  }
>  

[...]

