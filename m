Return-Path: <netdev+bounces-177111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C3FA6DF1F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DDA188C915
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23AF26136A;
	Mon, 24 Mar 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRXdpi2d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A013A41F;
	Mon, 24 Mar 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831830; cv=none; b=vCNk+OwhWb+wyMbIbuP60npqFl1iiZv2r41sycO0V81hpWLQg9azsSPf95EfxMLsnr+IEsiRDSzSRHFydqalWYfllXADXEJGU64XhJPn4hEsre1zUXXUcxTKNKYGU0Yl8RTVgPgtJgl1EOcDZDupU8sKu08BNPergZz0x6ZTVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831830; c=relaxed/simple;
	bh=jfjnwEkBLi3PfQdxPsqUKhh+jSE868y00jgyIrGrW6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS1Zl/tze4Vd6vqeVtLWD5gyn/NM6SBJ836r4s0jm4z0zFQRDWnoyyA19B9UGSnSohzViGkVw+uePLgba5sb4Qrkwx1Q2OfMo7XyKPRNUlUlr/pFigB73BWcDUq705I/FLwNg//Mfg1VsshFcC71EdfSCD5HFz+cInUo3Cyqwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRXdpi2d; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742831829; x=1774367829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfjnwEkBLi3PfQdxPsqUKhh+jSE868y00jgyIrGrW6A=;
  b=XRXdpi2d6KjtCDWOVvw7qLO0wfeJg2tZGc5BaDxK3Z6H2WioW2mXPT/S
   kSk6KlQamm2Yq54tPNwJ/7Z9YC9jxclMaqGTbEY5HppMN2X32K+sb0YA7
   6ObspecdQC/mxddDuacJpIQVD7WK+E6oTbZx7PtcIGtK20GnKjF2vZA5K
   oPzB4vDRJHvhMLNfrU22mtk023BBEommmWZPcAHUHomoCTQd3vjP1ELhe
   cNf8EAoozJJLEnh6EtL1Zr3DZ6QW9gWMyaocB3I95CpLJpT452llR7KJ8
   dNW37+DwiROg8rQIdkZSn1lAuJhB+qltaCsiqZaN2Es0T/CV9CBj3uZbR
   w==;
X-CSE-ConnectionGUID: kFkwW+hzQW+01eJTbO/MXg==
X-CSE-MsgGUID: t1fS9etJSluzn7tGEQ0SZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61570145"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61570145"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 08:57:08 -0700
X-CSE-ConnectionGUID: 84dOsVTaRh+IT2+lIuCNRQ==
X-CSE-MsgGUID: ila8i/3ATJq9kS8fbM7mkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124039803"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 08:57:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twkAg-00000005UQO-29nK;
	Mon, 24 Mar 2025 17:57:02 +0200
Date: Mon, 24 Mar 2025 17:57:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: =?utf-8?Q?phy?=
 =?utf-8?Q?=3A_Introduce_PHY=5FID=5FSIZE_?= =?utf-8?B?4oCU?= minimum size for
 PHY ID string
Message-ID: <Z-GAzlPEVR8p5l7-@smile.fi.intel.com>
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
 <20250324144751.1271761-2-andriy.shevchenko@linux.intel.com>
 <Z-F07j7tlez_94aK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-F07j7tlez_94aK@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 03:06:22PM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 24, 2025 at 04:39:29PM +0200, Andy Shevchenko wrote:
> > The PHY_ID_FMT defines the format specifier "%s:%02x" to form
> > the PHY ID string, where the maximum of the first part is defined
> > in MII_BUS_ID_SIZE, including NUL terminator, and the second part
> > is implied to be 3 as the maximum address is limited to 32, meaning
> > that 2 hex digits is more than enough, plus ':' (colon) delimiter.
> > However, some drivers, which are using PHY_ID_FMT, customise buffer
> > size and do that incorrectly. Introduce a new constant PHY_ID_SIZE
> > that makes the minimum required size explicit, so drivers are
> > encouraged to use it.
> > 
> > Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!

Thank you!

And just a bit of offtopic, can you look at
20250312194921.103004-1-andriy.shevchenko@linux.intel.com
and comment / apply?

That is one of the only few obstacles for me (and perhaps others, like CIs)
to enable CONFIG_WERROR when build with `make W=1` (implying existing defconfigs
for x86).

-- 
With Best Regards,
Andy Shevchenko



