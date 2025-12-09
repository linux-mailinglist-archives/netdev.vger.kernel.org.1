Return-Path: <netdev+bounces-244147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5A4CB0778
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59D57301B757
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86462F8BF0;
	Tue,  9 Dec 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiDAAz9v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F781A9F90;
	Tue,  9 Dec 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295516; cv=none; b=a78U+1RiJj4rZ5pNisfOmK4YGrf1rpn3r4vCMCfmRF99sZJ0j0ppQOk6BWCSVPsJbrnKjYVXnfRrCW2YxOZO4HjCswHj+1O+ni2oZpb3TyEXGCR+bX7lZrLh0EsR5As43brTIWQE/DJMX28Tzb09/vpQOh53GNodVUUloykX8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295516; c=relaxed/simple;
	bh=6mg2CkJorsnNZoHV+XNn3fPDZs4y0mdGz4LgGO8RmiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx5rVx/hg7ZPjjHDlOdtWUXhR3h4411FKS4Af9pZ/Zy8fvqKdL/sMq12POupMcMHzo83MM7iFB6FnCG0ygoQPD7ZT1cRPtvfi4ugASKj1qVN77D+tbbrQYHhZDNXgre4oAVQIKuM5EdMiDwMu7/x9RCqt/KBfeqrJRC/SVNYNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiDAAz9v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765295515; x=1796831515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6mg2CkJorsnNZoHV+XNn3fPDZs4y0mdGz4LgGO8RmiY=;
  b=UiDAAz9vaW2CXeTli28jeHscUKUc8HLHF0ft7m0cqv5dY+bxEzlcBXBG
   HgSLcLFZy9XApPDCJcJNdMX0fMS/xWm96yk9tHBWoUtzOroQyuQKjqfn/
   Z3QjN0144GheFa7injrpwSioon10IwMQu+Myxkcbi2h4WCAV5m+cEzCfR
   uYCznzMwmmah7PpcLH7KX201xmNhkelbIB8H/Uhr587yCJ18ehRDDbFm3
   XdTLfjp2S6p446b3SL+qVmpq90U5twb2OPhksPo1pYTV9/rTmeqIotFRe
   y5P5d7eOsLP3AbJl+aCR8tC+GewYKWhFn6TTOjYARJKngbW6BrIE6ZvHc
   A==;
X-CSE-ConnectionGUID: kQ5r+H5vQFaZC4hFzB6HjA==
X-CSE-MsgGUID: dEzbK1EUSrui5vayadrOuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67150541"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="67150541"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:51:54 -0800
X-CSE-ConnectionGUID: br5OU7fgRXuuzNyJqVLLpw==
X-CSE-MsgGUID: qeYNKFb7Q7yvIrOVw1CeCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="201178544"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:51:50 -0800
Date: Tue, 9 Dec 2025 17:51:48 +0200
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
Subject: Re: [PATCH 4/9] bitfield: Copy #define parameters to locals
Message-ID: <aThFlDZVFBEyBhFq@smile.fi.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-5-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100313.2867-5-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 10:03:08AM +0000, david.laight.linux@gmail.com wrote:

> Use __auto_type to take copies of parameters to both ensure they are
> evaluated only once and to avoid bloating the pre-processor output.
> In particular 'mask' is likely to be GENMASK() and the expension
> of FIELD_GET() is then about 18KB.
> 
> Remove any extra (), update kerneldoc.

> Consistently use xxx for #define formal parameters and _xxx for
> local variables.

Okay, I commented below, and I think this is too huge to be in this commit.
Can we make it separate?

> Rather than use (typeof(mask))(val) to ensure bits aren't lost when
> val is shifted left, use '__auto_type _val = 1 ? (val) : _mask;'
> relying on the ?: operator to generate a type that is large enough.
> 
> Remove the (typeof(mask)) cast from __FIELD_GET(), it can only make
> a difference if 'reg' is larger than 'mask' and the caller cares about
> the actual type.
> Note that mask usually comes from GENMASK() and is then 'unsigned long'.
> 
> Rename the internal defines __FIELD_PREP to __BF_FIELD_PREP and
> __FIELD_GET to __BF_FIELD_GET.
> 
> Now that field_prep() and field_get() copy their parameters there is
> no need for the __field_prep() and __field_get() defines.
> But add a define to generate the required 'shift' to use in both defines.

...

> -#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
> +#define __BF_FIELD_CHECK_MASK(mask, val, pfx)				\
>  	({								\
> -		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
> -				 _pfx "mask is not constant");		\
> -		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> -		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> -				 ~((_mask) >> __bf_shf(_mask)) &	\
> -					(0 + (_val)) : 0,		\
> -				 _pfx "value too large for the field"); \
> -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> -					      (1ULL << __bf_shf(_mask))); \
> +		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
> +				 pfx "mask is not constant");		\
> +		BUILD_BUG_ON_MSG((mask) == 0, _pfx "mask is zero");	\
> +		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
> +				 ~((mask) >> __bf_shf(mask)) &		\
> +					(0 + (val)) : 0,		\
> +				 pfx "value too large for the field");	\
> +		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
> +					      (1ULL << __bf_shf(mask))); \
>  	})

I looks like renaming parameters without any benefit, actually the opposite
it's very hard to see if there is any interesting change here. Please, drop
this or make it clear to focus only on the things that needs to be changed.

-- 
With Best Regards,
Andy Shevchenko



