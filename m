Return-Path: <netdev+bounces-171964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE87A4FAEF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6297A204D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CED205E34;
	Wed,  5 Mar 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0T2bHOT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58C20551F;
	Wed,  5 Mar 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168811; cv=none; b=HUxyAW5E5z2czEayCh6xU6IaULQR3AJrd8onLx2iVX5ztgfDK8otFbIClsZykvKz/HIj6F1XnTTGHp9PaQ3tBsVxx5GUK+PjQ9ABdugzwpkniWl7MS+W2GEv18nbB5dY7kfskTBrzJY283j8BLfSGwzw8xQJ7CUrMcQ4MyDGd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168811; c=relaxed/simple;
	bh=9AKHIt39EdqvkjHlj2wT3ud7NdHaZNclpnxb3Ax38TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtQpvJAmsHLJLIGOk2Gve8M7D60cE94rlvI1n5g+odcFwEbi4AhHbsrRwRA4CWWpJ8aM4WF06A4BNXcmG20mQL5/ZlhjkyTmzzWLJLZrpTe3Qbvj4iK6jTNBbI/VWbHPNLrXGbkawa7UOX8aRNMt6gZ6xld2RyhT5JeqScRW9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0T2bHOT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741168808; x=1772704808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9AKHIt39EdqvkjHlj2wT3ud7NdHaZNclpnxb3Ax38TM=;
  b=E0T2bHOTbWFa53QoXpyr/d4swQ8g+C9o1qD+EXgs0HPfpe4QVlagA90l
   NUIX0vah+QoRqhpKRYPgcEzeIVa7diwD2BGbBSxYZYdQsE+vS7SM0Q82f
   zNtAQFxfMj9RE2pCaZhI1ib2ARIgIYltceBqkyAiTu7yvWh5Z6sa5dpKt
   JQ2+EGRadvui+ovtTOgojy3TYy/IYH9ugt8sMUI63kVS5NWpfdEZF3WGj
   OMJKJ4MFjVJ/5QboOpY770Sb7iDfxzsNnJo9RWmp2Akhs/GMD1Z0Htqwy
   g4nwmRn1VUmtyEcTXU07Vfn5VdSlALZ3ZNdqKMtrEarVlAsa16aUIqKid
   g==;
X-CSE-ConnectionGUID: UhpzxuUITBOApBptkub1cQ==
X-CSE-MsgGUID: UtbwXEMuRbe4sf8A8DugCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="44932341"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="44932341"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 02:00:07 -0800
X-CSE-ConnectionGUID: BeuCliEWR0Ofj/db2Rg7rA==
X-CSE-MsgGUID: sE7nJ2EQRDW8J61KQiHmkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="119133426"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 02:00:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tplXm-0000000HNNt-09xm;
	Wed, 05 Mar 2025 12:00:02 +0200
Date: Wed, 5 Mar 2025 12:00:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z8ggoUoKpSPPcs5S@smile.fi.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org>
 <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
 <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
 <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
 <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
 <20250304083524.3fe2ced4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304083524.3fe2ced4@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 08:35:24AM -0800, Jakub Kicinski wrote:
> On Tue, 4 Mar 2025 15:41:19 +0200 Andy Shevchenko wrote:

...

> > > > Would that work?  
> > 
> > Actually it won't work because the variable is under the same ifdeffery.
> > What will work is to spreading the ifdeffery to the users, but it doesn't any
> > better than __maybe_unsused, which is compact hack (yes, I admit that it is not
> > the nicest solution, but it's spread enough in the kernel).
> 
> I meant something more like (untested):

We are starving for the comment from the DMA mapping people.

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index b79925b1c433..a7ebcede43f6 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -629,10 +629,10 @@ static inline int dma_mmap_wc(struct device *dev,
>  #else
>  #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
>  #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> -#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
> -#define dma_unmap_len(PTR, LEN_NAME)             (0)
> -#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> +#define dma_unmap_addr(PTR, ADDR_NAME)           ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> +#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
> +#define dma_unmap_len(PTR, LEN_NAME)             ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> +#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
>  #endif
>  
>  #endif /* _LINUX_DMA_MAPPING_H */
> 
> I just don't know how much code out there depends on PTR not
> existing if !CONFIG_NEED_DMA_MAP_STATE

Brief checking shows that only drivers/net/ethernet/chelsio/* comes
with ifdeffery, the rest most likely will fail in the same way
(note, overwhelming majority of the users is under the network realm):

$ git grep -lw dma_unmap_[al][de].*

drivers/infiniband/hw/cxgb4/cq.c
drivers/infiniband/hw/cxgb4/qp.c
drivers/infiniband/hw/mthca/mthca_allocator.c
drivers/infiniband/hw/mthca/mthca_eq.c
drivers/net/ethernet/alacritech/slicoss.c
drivers/net/ethernet/alteon/acenic.c
drivers/net/ethernet/amazon/ena/ena_netdev.c
drivers/net/ethernet/arc/emac_main.c
drivers/net/ethernet/atheros/alx/main.c
drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
drivers/net/ethernet/broadcom/bcmsysport.c
drivers/net/ethernet/broadcom/bnx2.c
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
drivers/net/ethernet/broadcom/bnxt/bnxt.c
drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
drivers/net/ethernet/broadcom/genet/bcmgenet.c
drivers/net/ethernet/broadcom/tg3.c
drivers/net/ethernet/brocade/bna/bnad.c
drivers/net/ethernet/chelsio/cxgb/sge.c
drivers/net/ethernet/chelsio/cxgb3/sge.c
drivers/net/ethernet/emulex/benet/be_main.c
drivers/net/ethernet/engleder/tsnep_main.c
drivers/net/ethernet/google/gve/gve_tx.c
drivers/net/ethernet/google/gve/gve_tx_dqo.c
drivers/net/ethernet/intel/fm10k/fm10k_main.c
drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
drivers/net/ethernet/intel/i40e/i40e_main.c
drivers/net/ethernet/intel/i40e/i40e_txrx.c
drivers/net/ethernet/intel/i40e/i40e_xsk.c
drivers/net/ethernet/intel/iavf/iavf_txrx.c
drivers/net/ethernet/intel/ice/ice_txrx.c
drivers/net/ethernet/intel/ice/ice_txrx_lib.c
drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
drivers/net/ethernet/intel/idpf/idpf_txrx.c
drivers/net/ethernet/intel/igb/igb_ethtool.c
drivers/net/ethernet/intel/igb/igb_main.c
drivers/net/ethernet/intel/igc/igc_dump.c
drivers/net/ethernet/intel/igc/igc_main.c
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
drivers/net/ethernet/marvell/skge.c
drivers/net/ethernet/marvell/sky2.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/net/ethernet/mscc/ocelot_fdma.c
drivers/net/ethernet/myricom/myri10ge/myri10ge.c
drivers/net/ethernet/qlogic/qla3xxx.c
drivers/net/ethernet/rocker/rocker_main.c
drivers/net/ethernet/wangxun/libwx/wx_lib.c
drivers/net/wireless/intel/iwlegacy/3945-mac.c
drivers/net/wireless/intel/iwlegacy/3945.c
drivers/net/wireless/intel/iwlegacy/4965-mac.c
drivers/net/wireless/intel/iwlegacy/common.c
drivers/net/wireless/marvell/mwl8k.c

include/net/libeth/tx.h

-- 
With Best Regards,
Andy Shevchenko



