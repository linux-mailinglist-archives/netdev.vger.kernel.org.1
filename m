Return-Path: <netdev+bounces-174274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C237A5E1A5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85819175D95
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228B1D514E;
	Wed, 12 Mar 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nlkuphmq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37431C5F1E;
	Wed, 12 Mar 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796425; cv=none; b=BWKG4UakTH66ZDrMxm0UAyGk3qIZMWXZOXvgYStQ19oBbtYWQD4kfD4d6vrr0x6L+OMo7dOEeeTrmMNjHVssHXHRNVZz7Wq8UtIpWBDGydv8SttFfzS+saGOmatXx1t5jzbOFJuJUuHAMB8NkZIToV3Jiem5Acp99eJ4Fz+XnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796425; c=relaxed/simple;
	bh=dVocHVpBW+LBL15aYGRyDXL1g4TfZ+fwRCHVkR5W5Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqmVQOYG6yxzk7OYdgf4hvgjJHtxoN84NWpKm6DYC17S7RmUDl7NxMiRyG3/3G0dV7UfByxbvwWuIkeJ8IPL1OWHZ2CxKS42ihjH7ztqJs+os2olqnyrosPfYuV4CxEMrmo2eQcZu+dYpxsipbYdbPgae2cyNlufAidJj0OjORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nlkuphmq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741796424; x=1773332424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVocHVpBW+LBL15aYGRyDXL1g4TfZ+fwRCHVkR5W5Cs=;
  b=NlkuphmqN7NbcRLf9tXL1Zws0qO+L4Xj+ZKovwyMgpf2ADfu5WFWnrFy
   sJ9GPNVbZSZBuALqwUUluLlZZX+MHTELM8kSVfWyJnpl+hBIcWafZdHFo
   cHTT9mXKYWD7H/fGVAXtkk2aC7HmLBgSDpML88wmmubhHQEWrHKQOh2+F
   f9BxbGCoHAMIAsjhPUlwhqCYYPaRVzDCnJjHxBMHc768qIpXeQUZClTAP
   LL6mmoj77rPC17YCz9LFVhiMIdZY+ckjwejO5nHXsrUe0viQvp3kFSRk3
   bJC/N2Cq7Y75a8CpmvayeMAKCRI4QFCu45Q2RijmypD7ncfllPVFq/8sa
   Q==;
X-CSE-ConnectionGUID: 68YgSO+PSV6z5OWjZ9wauQ==
X-CSE-MsgGUID: SnbgzMV3T+a+csiU+NBo9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46668505"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="46668505"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:20:23 -0700
X-CSE-ConnectionGUID: 38r3MANaTLOfTmQWKjlcow==
X-CSE-MsgGUID: 7jO2IG3CSCiylrUpIxtlJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120706886"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:20:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsOob-00000001uod-47GW;
	Wed, 12 Mar 2025 18:20:17 +0200
Date: Wed, 12 Mar 2025 18:20:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z9G0QU5Ew3FusrJH@smile.fi.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org>
 <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
 <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
 <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
 <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
 <20250304083524.3fe2ced4@kernel.org>
 <CGME20250305100010eucas1p1986206542bc353300aee7ac8d421807f@eucas1p1.samsung.com>
 <Z8ggoUoKpSPPcs5S@smile.fi.intel.com>
 <067bd072-eb3f-451a-b1c4-59eae777cf00@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067bd072-eb3f-451a-b1c4-59eae777cf00@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 11, 2025 at 01:51:21PM +0100, Marek Szyprowski wrote:
> On 05.03.2025 11:00, Andy Shevchenko wrote:
> > On Tue, Mar 04, 2025 at 08:35:24AM -0800, Jakub Kicinski wrote:
> >> On Tue, 4 Mar 2025 15:41:19 +0200 Andy Shevchenko wrote:

...

> >> I meant something more like (untested):
> > We are starving for the comment from the DMA mapping people.
> 
> I'm really sorry for this delay. Just got back to the everyday stuff 
> after spending a week in bed recovering from flu...

Oh, I hope you feel much better now!

...

> >>   #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
> >>   #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> >> -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> >> -#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
> >> -#define dma_unmap_len(PTR, LEN_NAME)             (0)
> >> -#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> >> +#define dma_unmap_addr(PTR, ADDR_NAME)           ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> >> +#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
> >> +#define dma_unmap_len(PTR, LEN_NAME)             ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> >> +#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { typeof(PTR) __p __maybe_unused = PTR; } while (0)

> >> I just don't know how much code out there depends on PTR not
> >> existing if !CONFIG_NEED_DMA_MAP_STATE
> > Brief checking shows that only drivers/net/ethernet/chelsio/* comes
> > with ifdeffery, the rest most likely will fail in the same way
> > (note, overwhelming majority of the users is under the network realm):
> 
> Frankly speaking I wasn't aware of this API till now.
> 
> If got it right the above proposal should work fine. The addr/len names 
> can be optimized out, but the pointer to the container should exist.

Thanks for the reply, would you or Jakub will to send a formal patch?
I can test it on my configuration and build.

-- 
With Best Regards,
Andy Shevchenko



