Return-Path: <netdev+bounces-164562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB55A2E3D3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE6A166A91
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5515A85A;
	Mon, 10 Feb 2025 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvBjTAdu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2C02F2E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739166897; cv=none; b=CHoUE8eNFYhUOu8ic8dQV1lDmPSII0a41FQ5xK2SNCJg6UtEPxuBM55pEZ69vkAX2zcTY7rPHWaFGiPcdoiQ2CyYG/ZopHqd/PwYF7mmWmmUOZIWxztOflnv73thQf/lvzASVfjQDKWMHbTrMHG/OtcTMaCdP9ou0ZYH/3b45yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739166897; c=relaxed/simple;
	bh=lNSEhFBAD60ZJCgpylPSqXMzlErGD62bkb2XntiZG3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX8GZiUnxUcQKNpkgpFw43FtSZH+CceSnTeSgeelYg3kU+ef7ltV/Fya11GMGRHpxLVHwfJMMkW0pyGM03g6MBV+DPLGMstIdDDI0YNdPS1X4ZhOKQNVnMi9TR4StxWa1kv96wxtPsVapSLo3VQg2SYDE1Nu134nhK0ipqPQkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvBjTAdu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739166896; x=1770702896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lNSEhFBAD60ZJCgpylPSqXMzlErGD62bkb2XntiZG3c=;
  b=ZvBjTAduu797FQ5OC3PA+5k/MvLXivG/wQrvIZqV5kPAX955RRC+5pPB
   wi5Nm27viwbjMOwKCTVBAriEn1414ht9Z4aenjQxQ6MEZXhWCHJXRRB0I
   5rly5Jm59mVdG8a2QjBEiJviS0C2qGEpKNA0ybinWI2tSVqbbAgrTOc4z
   AfRhKMmYwfLOL55qlaBo8zo8TeoJdcTdBeXrcJy6+JZ7Cmd7iPmtBvqcR
   WaDZIZ+0amPcptnHtvTMTlAQelctEM35rQJPoir/7mTx67p731nqTudQs
   1i0b1IdQkCbsyNOJ0GzOPuRP3fYpUdZ8ncUuNYg42Sb3bIYJMPEpEBj/5
   w==;
X-CSE-ConnectionGUID: AHilMMUcS9mt04l/izOFag==
X-CSE-MsgGUID: vTWHX0FlRjumXvgp1VFBGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43658850"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43658850"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:54:56 -0800
X-CSE-ConnectionGUID: oopQwjHhTjmtbn1zxQVksw==
X-CSE-MsgGUID: Hgwyqh8AQJmPN7uOFeAZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117031203"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:54:53 -0800
Date: Mon, 10 Feb 2025 06:51:21 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com
Subject: Re: [iwl-next v1 1/4] ixgbe: add MDD support
Message-ID: <Z6mT2UzaZsIQXb66@mev-dev.igk.intel.com>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
 <20250207104343.2791001-2-michal.swiatkowski@linux.intel.com>
 <20250207150749.GY554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207150749.GY554665@kernel.org>

On Fri, Feb 07, 2025 at 03:07:49PM +0000, Simon Horman wrote:
> On Fri, Feb 07, 2025 at 11:43:40AM +0100, Michal Swiatkowski wrote:
> > From: Paul Greenwalt <paul.greenwalt@intel.com>
> > 
> > Add malicious driver detection. Support enabling MDD, disabling MDD,
> > handling a MDD event, and restoring a MDD VF.
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> 
> ...
> 
> > +/**
> > + * ixgbe_handle_mdd_x550 - handle malicious driver detection event
> > + * @hw: pointer to hardware structure
> > + * @vf_bitmap: output vf bitmap of malicious vfs
> > + */
> > +void ixgbe_handle_mdd_x550(struct ixgbe_hw *hw, unsigned long *vf_bitmap)
> > +{
> > +	u32 i, j, reg, q, div, vf, wqbr;
> > +
> > +	/* figure out pool size for mapping to vf's */
> > +	reg = IXGBE_READ_REG(hw, IXGBE_MRQC);
> > +	switch (reg & IXGBE_MRQC_MRQE_MASK) {
> > +	case IXGBE_MRQC_VMDQRT8TCEN:
> > +		div = IXGBE_16VFS_QUEUES;
> > +		break;
> > +	case IXGBE_MRQC_VMDQRSS32EN:
> > +	case IXGBE_MRQC_VMDQRT4TCEN:
> > +		div = IXGBE_32VFS_QUEUES;
> > +		break;
> > +	default:
> > +		div = IXGBE_64VFS_QUEUES;
> > +		break;
> > +	}
> > +
> > +	/* Read WQBR_TX and WQBR_RX and check for malicious queues */
> > +	for (i = 0; i < IXGBE_QUEUES_REG_AMOUNT; i++) {
> > +		wqbr = IXGBE_READ_REG(hw, IXGBE_WQBR_TX(i)) |
> > +		       IXGBE_READ_REG(hw, IXGBE_WQBR_RX(i));
> > +		if (!wqbr)
> > +			continue;
> > +
> > +		/* Get malicious queue */
> > +		for_each_set_bit(j, (unsigned long *)&wqbr,
> > +				 IXGBE_QUEUES_PER_REG) {
> 
> The type of wqbr is a u32, that is it is 32-bits wide.
> Above it's address is cast to unsigned long *.
> But, unsigned long may be 64-bits wide, e.g. on x86_64.
> 
> GCC 14.2.0 EXTRA_CFLAGS=-Warray-bounds builds report this as:
> 
> In file included from ./include/linux/bitmap.h:11,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/paravirt.h:21,
>                  from ./arch/x86/include/asm/cpuid.h:71,
>                  from ./arch/x86/include/asm/processor.h:19,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:59,
>                  from ./include/linux/thread_info.h:60,
>                  from ./include/linux/uio.h:9,
>                  from ./include/linux/socket.h:8,
>                  from ./include/uapi/linux/if.h:25,
>                  from ./include/linux/mii.h:12,
>                  from ./include/uapi/linux/mdio.h:15,
>                  from ./include/linux/mdio.h:9,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe_type.h:8,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h:7,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:4:
> In function ‘find_next_bit’,
>     inlined from ‘ixgbe_handle_mdd_x550’ at drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3907:3:
> ./include/linux/find.h:65:23: error: array subscript ‘long unsigned int[0]’ is partly outside array bounds of ‘u32[1]’ {aka ‘unsigned int[1]’} [-Werror=array-bounds=]
>    65 |                 val = *addr & GENMASK(size - 1, offset);
>       |                       ^~~~~
> 
> I think this can be addressed by changing the type of wqmbr to unsigned long.

Thanks for catching that, I will fix.

> 
> > +			/* Get queue from bitmask */
> > +			q = j + (i * IXGBE_QUEUES_PER_REG);
> > +			/* Map queue to vf */
> > +			vf = q / div;
> > +			set_bit(vf, vf_bitmap);
> > +		}
> > +	}
> > +}
> > +
> >  #define X550_COMMON_MAC \
> >  	.init_hw			= &ixgbe_init_hw_generic, \
> >  	.start_hw			= &ixgbe_start_hw_X540, \
> 
> ...

