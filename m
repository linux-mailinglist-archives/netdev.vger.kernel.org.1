Return-Path: <netdev+bounces-246188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B01CE55DC
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79C2E300751C
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01453195811;
	Sun, 28 Dec 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLJj+ydG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CC2AEE4;
	Sun, 28 Dec 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766948034; cv=none; b=CUtzUyRW7sozb/zyptQwjm1Ce29IID2JXOGv4GSyR7ySJBZ6bYt2aB0unmMHoYKsJFZ6tInbs452abIYaYiqRFn+9Xx6jbTwgKaq8Z9GuCh6ofHhwx3bWT4fTbh57IIcmF2reu6eEeNdvraKNfGAQuJY0jlTdMGbS8jt+S9VgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766948034; c=relaxed/simple;
	bh=eQosC/TPc5q0yMWWm2GAOQLVb6z5Z/VFfgL3N4lyZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As7THuXgkItYYYvFPBUQpQlJ50dUpqLSiSZlhde8rADQzqTe+nbNOJNB3rpx/c731tnc2mzxX6muVAl5Z23moGvJdBvX1AXC+uRqmj0OBcKmyRQgUf+chJXE+Q3eTO8c8USOipu9hC5j/OIsa4bFVOhIHvBVRgUszQoHsInfgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLJj+ydG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766948033; x=1798484033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQosC/TPc5q0yMWWm2GAOQLVb6z5Z/VFfgL3N4lyZt4=;
  b=GLJj+ydGR2gJideG5a8L08qYxxTlJ8KHSjo8WPtVcTkcnwi9BfBHtrYO
   Nwwayrvv5ttRnXefyyyDeIqjlgxue5s4hYGct2cuxA25xibyDEOAD+IEj
   Na2g9vt6YgeATbKH8C0YeKzvsxdScmQoYWfDrr8iHyjzGM5srLK2pvKk9
   VZQdwD316OzFhFm1b2Vl3VFy1P2nDCrA2HHz6I1UzVdaT6Nj1rCEf2M9f
   x8OJ5984s/MCBTiEu20snNFx9t/hCzU7WyhjQgz05IekWYbCX1tnt26tL
   cYp+6fcWCrMbkE75EQX5NUg1iaifcBo2X9g70fCnzV7cAb+mA4IwxsXF2
   A==;
X-CSE-ConnectionGUID: SAJLJRgARSuOVzd2/MDVvg==
X-CSE-MsgGUID: MI/0LoIPTv2OqPLt+zJnQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="68563255"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="68563255"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 10:53:52 -0800
X-CSE-ConnectionGUID: RGzjkSAvRj+oO0K+rWxk1A==
X-CSE-MsgGUID: e+EmFYUQRsmiVY/k4dGm+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="199893935"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 10:53:48 -0800
Date: Sun, 28 Dec 2025 20:53:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 08/16] bitfield: Simplify __BF_FIELD_CHECK_REG()
Message-ID: <aVF8uQxjz9trZAHY@smile.fi.intel.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
 <20251212193721.740055-9-david.laight.linux@gmail.com>
 <20251217102618.0000465f@huawei.com>
 <20251217223155.52249236@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217223155.52249236@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 17, 2025 at 10:31:55PM +0000, David Laight wrote:
> On Wed, 17 Dec 2025 10:26:18 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > On Fri, 12 Dec 2025 19:37:13 +0000
> > david.laight.linux@gmail.com wrote:

...

> > > +	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
> > > +			 ~0ULL >> (64 - 8 * sizeof (reg)),		\  
> > 
> > Trivial.  sizeof(reg) is much more comment syntax in kernel code.
>                                      (common)
> 
> Hmm. sizeof is an operator not a function.
> Its argument is either a variable/expression or a bracketed type
> (I don't usually put variables in brackets).
> So 'sizeof(reg)' is nearly as bad as 'return(reg)'.

Yet, it's a style used de facto in the Linux kernel. I am with Jonathan on this.

-- 
With Best Regards,
Andy Shevchenko



