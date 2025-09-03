Return-Path: <netdev+bounces-219683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4FB429BF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257811BC60C0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C935FC23;
	Wed,  3 Sep 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdA0JHcM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DF36996E
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927274; cv=none; b=LAivnI0G8Efs2dyx0sI6j0uBAo1ap0rE5WIY//QmyxExm+w+Se04zu9emJIN95fcCj8MQaySCh/8OqQNVT346+e03nAjG0lzO1Bed74fpNIuqitrAtqdsXPaaHmoR5EneOs/iWE9AhKZKcbqFnSBLFgq+S1qp6Z+8thNpxf3I7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927274; c=relaxed/simple;
	bh=B0C3HqLjJrxPmuqoq9BR1gfOrlkFD/kDcF+bPmMHumI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HccIf/G0e8yoGoayGhk8EY/f8GWkXVj/aUgn2UtOCiay9PgMFioRPUGFklT8V4STX9Ja1U0drGfuwixoC+2Z01MHX7pqPJVVwz4wImgORJsxbjBywY6U+FfY8/UB2qrG+Otvu+zby+7NRO7W//Yg79s1UZlCybqh5LPKF9T4KUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdA0JHcM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756927272; x=1788463272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0C3HqLjJrxPmuqoq9BR1gfOrlkFD/kDcF+bPmMHumI=;
  b=DdA0JHcMW3nFR9NR0KgdXsJ1jYugnfVsaeTCPEjM0BJfZbmRnp4Nr3C8
   qGAKZ/mxJ1qO3AfAbsQ+L0ykJdJf+Zpi9Q/K7A6VzOCGfl99UBwP6KSKl
   TB+ntKlflVb5cxGrv8UV1IWcbC2/sUEqJEGXn2uMFLSvVf73eM7F23vIi
   SEqH7OhKo9DM1SHucOIwh4DdbknLdZ4aR5LwBxzDNEhea8d04qc6z2Ox0
   eDVt8/FmMcKybhzZvyOiNDlmWrxbEbEXp8puqHq4SzrE7YsllhTfoLW06
   YIb7mN1ih/sUGMj8kahw/NM/kZWvPdNZouoRl8d0Cmoj8SY+4BrYcPf0i
   g==;
X-CSE-ConnectionGUID: aNP/Cl5rTW+Liw4ezj3Dgw==
X-CSE-MsgGUID: 4HWh42lIRpaRyDaptvtlmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="62898335"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="62898335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:21:12 -0700
X-CSE-ConnectionGUID: y4RB/p5LQzazpADN3Ik4ww==
X-CSE-MsgGUID: B3f1SfsnQGGOL5CGYAX8DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="172120265"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:21:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utt2V-0000000B4Fx-3aJG;
	Wed, 03 Sep 2025 22:21:03 +0300
Date: Wed, 3 Sep 2025 22:21:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Marginean <alexandru.marginean@nxp.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64
Message-ID: <aLiVHw4WQW69A5qL@smile.fi.intel.com>
References: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 24, 2025 at 05:35:12PM +0100, Simon Horman wrote:
> enetc_hw.h provides two versions of _enetc_rd_reg64.
> One which simply calls ioread64() when available.
> And another that composes the 64-bit result from ioread32() calls.
> 
> In the second case the code appears to assume that each ioread32() call
> returns a little-endian value. However both the shift and logical or
> used to compose the return value would not work correctly on big endian
> systems if this were the case. Moreover, this is inconsistent with the
> first case where the return value of ioread64() is assumed to be in host
> byte order.
> 
> It appears that the correct approach is for both versions to treat the
> return value of ioread*() functions as being in host byte order. And
> this patch corrects the ioread32()-based version to do so.
> 
> This is a bug but would only manifest on big endian systems
> that make use of the ioread32-based implementation of _enetc_rd_reg64.
> While all in-tree users of this driver are little endian and
> make use of the ioread64-based implementation of _enetc_rd_reg64.
> Thus, no in-tree user of this driver is affected by this bug.

...

> @@ -507,7 +507,7 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
>  		tmp = ioread32(reg + 4);
>  	} while (high != tmp);
>  
> -	return le64_to_cpu((__le64)high << 32 | low);
> +	return (u64)high << 32 | low;
>  }

Description and the visible context rings a bell like this is probably a
reimplementation of ioread64_lo_hi().

-- 
With Best Regards,
Andy Shevchenko



