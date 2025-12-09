Return-Path: <netdev+bounces-244146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310ACB0722
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436BF3079E88
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BC12D4B71;
	Tue,  9 Dec 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldYeujln"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943928312F;
	Tue,  9 Dec 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295190; cv=none; b=WT3mub5DgYR4qQRsaSSM/YGB5WJv3uCJy4V1lw3hyj9qltLx+Y3RGULTY+hmc4R5UccoUw3+XD9rAaA48uEB1xKDT4wUAqgaXSQRSMJw3bS6u4M3Oy0/xwimhZXBiVJZzl9dlT4AvjScJr9pEKg3zUkGeLT0OAJQhLQEqiYKgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295190; c=relaxed/simple;
	bh=zPaY9nwK+AbBDHWFRaUpJfWWqz2efRmRruQnj7KFzKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNmcmoFGhXD9sNp5ugXfMMtzDtoyDDBUJeiTxXGyqxMB6vVL4XJzbNHwNJiFv3VIm02Sx/3bwJzxWUPXjT0MgCLOJuUOsgca0D8uQcHEGDV23l5p6Tvk7+3rY7bggIMSPdVetLR8xyQ6g3hXTZpFNM/COelmfKcfpECvf45B/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldYeujln; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765295189; x=1796831189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zPaY9nwK+AbBDHWFRaUpJfWWqz2efRmRruQnj7KFzKg=;
  b=ldYeujlnWVETzRXt4QeyybXDWOY8mTyUHB1xMJlQwHsxJt5s7llKtWSt
   j1L2BGf/1oSkE39zjiFPh5h7cMUdR4AST7ulJ/FoC+VJlRl/srW8nmSxN
   Fo9eSJKoYHoyKrDtlzUaRDSSmBDhlcL3MeHAajJmr2xaFnVdWRH6g+Qca
   0cBjZBsAL3KkX+HAqMKm+Wi9LGiAPAww8kmbDy+xsAT038plBQ6pXEtjy
   IjPDJYL+tJUqsU7fzeekHe6SZKXnqwyHmLimTKW4V5fQGf//g447sTaoX
   7atOkppyYACmMHWiGz5cAS3gGQZAX+r0tUucQV2Ec2t7RVc6zl0RhujL5
   w==;
X-CSE-ConnectionGUID: 4Qw62/SxSvKWO3B72U26nA==
X-CSE-MsgGUID: ob7s4oO7QN+qUjo0sI/tbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67149897"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="67149897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:46:28 -0800
X-CSE-ConnectionGUID: AEYrSNBdSAq1pMTZtZMAaQ==
X-CSE-MsgGUID: Z4FFwG7rRlakjNXE4B6qGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="196557819"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:46:23 -0800
Date: Tue, 9 Dec 2025 17:46:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 3/9] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Message-ID: <aThETSRch_okmCbe@smile.fi.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100313.2867-4-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 10:03:07AM +0000, david.laight.linux@gmail.com wrote:

> Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> not be used outside bitfield) and open-coding the generation of the
> masked value, just call FIELD_PREP() and add an extra check for
> the mask being at most 16 bits.

...

> +#define FIELD_PREP_WM16(mask, val)				\
> +({								\
> +	__auto_type _mask = mask;				\
> +	u32 _val = FIELD_PREP(_mask, val);			\

> +	BUILD_BUG_ON_MSG(_mask > 0xffffu,			\
> +			 "FIELD_PREP_WM16: mask too large");	\

Can it be static_assert() instead?

> +	_val | (_mask << 16);					\
> +})

-- 
With Best Regards,
Andy Shevchenko



