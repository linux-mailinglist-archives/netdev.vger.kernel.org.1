Return-Path: <netdev+bounces-175830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081CA67A1F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80913BD3DD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EBE2116E6;
	Tue, 18 Mar 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJvk6Ow9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E721019E;
	Tue, 18 Mar 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316895; cv=none; b=TWkaBXEPz+MT6rleLtwyw/kN341GUsuegObIQgcgY6wWd7nRkey+ko73iNPEhW9D8jU84yABacVRnT9DnPOWYFk+0BxXbdLcCbc/T2qD6fYd+N461KuqOmOVNWLNd+m2L3j+Q8oAkwCIFzeKnqGKAXuD3TEFUHG0Zx/sK2UVT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316895; c=relaxed/simple;
	bh=uL4fe/lzvNeHWEYG1xxLE96oJ0amotH0JxVWLXkUHwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnH8vo6XDXCzu61n6Dlj/T5av54pvRqCpcDyvGmMigPD3Og+zOOELQlx7kCoqkrE5hLqsxy/NvrT7LkN3Rn9TubLBWRpkO3DswyV92oKGNkMrLtc6zx7M36uD/+zmOnsfxEzeBW8xFzSuCc2Ua7ikKJ40zPMFAzljBKfs+aJxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJvk6Ow9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742316894; x=1773852894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uL4fe/lzvNeHWEYG1xxLE96oJ0amotH0JxVWLXkUHwE=;
  b=VJvk6Ow9+cWhPt4/vW7G+bZUiiThu2mp4sytxGAWqk4vwOzPBs6zNVP0
   r5bWWBKXDnw3Z2iMGXKSKupdCoUDrTxgh6BSPVAc6/Qxxllyuq6o5EPOu
   HIoAPubLH68CJRtH5zUB8GboAfgSoJy72872UwciwQSznflnIs2yiIJpR
   aTo9dQ7JZDcPnLil23TXzUUuG39MsFo1XTJw2IJayLKWHBCWr6j9Ys82+
   QDUHek1tirGMv6wFMsh3LyxN8Mt9zwcvjoVLFGydtGnPdT6gBJAoTGxkh
   oO0n+RynxTgac7RQRXRlpUvo1XOyoO7jGmBnE+rMSKuzoS6/3mLDLA/Vz
   w==;
X-CSE-ConnectionGUID: M19mfeObSamjpo1+n0dTJg==
X-CSE-MsgGUID: +wgP6n+MS+KxZrrIQgg77g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68823118"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="68823118"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:54:53 -0700
X-CSE-ConnectionGUID: t9VDzsomRbKiWBHs9E5xsw==
X-CSE-MsgGUID: ZpSOmTNWSTyxla4x77d4Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122149628"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:54:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuaDI-00000003gWe-1mgb;
	Tue, 18 Mar 2025 18:54:48 +0200
Date: Tue, 18 Mar 2025 18:54:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9mlWNdvWXohc6aM@smile.fi.intel.com>
References: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>
 <481268aa-c8e9-4475-bd5c-8d0f82a6652a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481268aa-c8e9-4475-bd5c-8d0f82a6652a@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:49:05PM +0100, Andrew Lunn wrote:

...

> > -	char phy_name[20];
> > +	char phy_name[MII_BUS_ID_SIZE + 5];
> 
> Could you explain the + 5?
> 
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/davicom/dm9051.c#L1156
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/freescale/fec_main.c#L2454
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/xilinx/ll_temac.h#L348
> 
> The consensus seems to be + 3.

u16, gcc can't proove the range, it assumes 65536 is the maximum.

include/linux/phy.h:312:20: note: directive argument in the range [0, 65535]

-- 
With Best Regards,
Andy Shevchenko



