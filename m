Return-Path: <netdev+bounces-176179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86DA6942C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94585188C955
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FCE1D5CE7;
	Wed, 19 Mar 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZTPa0hb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165BF1FB3;
	Wed, 19 Mar 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399541; cv=none; b=P8sdac4u0sPsEtFsx60Ww1H2OQIjjB1CC2zHYn+oGzaeLFLZ2E4YmBIsS3pD6MDgoiKJgubG+nWreLWAD0CrtmyETq3fsWuac0mm09dImpaeyCHSwkV7Qo/9fUvxD7QD6yMjgHoyKdogggfcOeSzOlYm5a/2EVH2xIBEUWhpiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399541; c=relaxed/simple;
	bh=NGbAHTuhvzBd3gWV5Ye2Nzx6lDdvF9IFw6FYrwoAGCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpmkrN/kZOcML8FBKf1Fo4GLfkbmgo7CHHR6Hi3PdWSiNNfAk+0SQfB8jQ/WpCjc3xqjVxeXwbG+8OytRWz8kVrPaHHxe3+BtW64KZ5gT6rYvPeWOywJcGz/CSpdAgk6OJWgp9MLeZc62q/64EXxBl0/rDTGoeAPYyUQQHlR8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZTPa0hb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742399540; x=1773935540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGbAHTuhvzBd3gWV5Ye2Nzx6lDdvF9IFw6FYrwoAGCA=;
  b=LZTPa0hbaMAJC4xeDyoeThQfd4DosHNllRC0+xbVdgoxNzFlY1AeE1+L
   yFIIVgAjRTUD7dT4IE5DoW2wU+HJgo0aqoQhsXtrpmRo5R3vnd1tAGB1p
   TQltjgq010MaIFkzFZ2hWsMzhyocvhKg8Hg52mJMzaCspxjTcBFy0Zt9Y
   wztG3QDtmCWscINKgPLcrYSxANTDjx8Na0L+eVzYnResGreKeHJq2UDUZ
   1llMIvTIbTuZs5FWPFUPAZlW+XWj+KzSxjx3tY8nzRV1/+1LJySeSs2DT
   SNcizCbYHJc/vv3thcXBpzMS9L+K6iOy2OmGvRP0S3rgjkOlA2Hc3DU+9
   Q==;
X-CSE-ConnectionGUID: mpettNl8S9+omMFx6eSI1Q==
X-CSE-MsgGUID: dIEk1mVkSn2cCZ5sqw2c9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43329731"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43329731"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:52:19 -0700
X-CSE-ConnectionGUID: Jy8p7MkERuK5RMcf/Qoi8A==
X-CSE-MsgGUID: FnoODpthSLmorvjzmDrRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127749013"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:52:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuviH-00000003z02-3mIi;
	Wed, 19 Mar 2025 17:52:13 +0200
Date: Wed, 19 Mar 2025 17:52:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid
 potential string cuts
Message-ID: <Z9roLbRN7Dyf22G2@smile.fi.intel.com>
References: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
 <202503192340.iVN44lM2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503192340.iVN44lM2-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 11:37:19PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-phy-Fix-formatting-specifier-to-avoid-potential-string-cuts/20250319-190433
> base:   net/main
> patch link:    https://lore.kernel.org/r/20250319105813.3102076-2-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid potential string cuts
> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503192340.iVN44lM2-lkp@intel.com/config)
> compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192340.iVN44lM2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503192340.iVN44lM2-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/usb/ax88172a.c:312:20: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
>      311 |         snprintf(priv->phy_name, 20, PHY_ID_FMT,
>          |                                      ~~~~~~~~~~
>      312 |                  priv->mdio->id, priv->phy_addr);
>          |                                  ^~~~~~~~~~~~~~
>    1 warning generated.

It's fun: while working around GCC complain, clang does not agree with... :-)
Let's wait more, probably the simplest fix (if this becomes only a single user
of the non-byte parameter) is to move it to u8.

-- 
With Best Regards,
Andy Shevchenko



