Return-Path: <netdev+bounces-176221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B4A69668
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8C217C43F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904861F09BB;
	Wed, 19 Mar 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiSFuCYC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4081EF37B;
	Wed, 19 Mar 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405286; cv=none; b=u7E7nl1Ps9QH7xPBiYfC2+gnr5buddzkVt/z/SRUeoScmkd3qjh3xP0vjocBz/gpFJ5egNNtyPtne3CAaUej+z5VenAqg2HvhcUwXRH59e0e4iQBFsF1pKvNebYJOAbIvHjQBcIzCIClFn9DRYwnK/CXCwiD8foLqMhAv+kEoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405286; c=relaxed/simple;
	bh=aFLtsNGSrtVmzExFbH/dbtFNmYuS7QOyHpWRr4vHvQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnV6Cm46d1ALbkN+quiA7JOLcR2zlZMLWnr8dZLjUr1OhsfGEYKfZVZ03P2QNnWVX32Sas2crJZ8gnr3uX2FCg4xkIkAyCXxanuzuiMm7CtxH2yha/TVn+ujakzTM8GgerLb+1O2kN2U7654iaOPSOt8xjJUJ7bkdkTMJa5Whok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiSFuCYC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742405283; x=1773941283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aFLtsNGSrtVmzExFbH/dbtFNmYuS7QOyHpWRr4vHvQo=;
  b=ZiSFuCYChCjLg/yc6g9jV++36EAkHoXLbEUDvOEqi7ayQi1md43CwIt/
   DJ13Ijr7G4zB/9Ixmco45NIXwOteyLUy32VDgNycxZJXOvIIbsF0TVS/a
   yCZ3NcuLCdErYGpYCq4omxmSthsBZWjiDzgbs5oiXiLMgBeE7bZfzt6ol
   5jqQ88QzKe4EbhVCh7PulCdRzbd7O27A7E+HDRftKqyPwtaTFv7QbXlj5
   H7dzNHAEdX8eDZXhtxUYk8XexLmbvlzmNXfU6xCwylCOmsV6+V7MxOZvw
   ck67pTk6rr8WB2zUbTa89yRAbIqwKGiph5lM0b52W342pakyAXI3utJZv
   Q==;
X-CSE-ConnectionGUID: 2tvCnqjNSvaCs0RcMZF0pw==
X-CSE-MsgGUID: 3RzuXEBXSaK5aSOUtF0hdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43714478"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43714478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 10:28:01 -0700
X-CSE-ConnectionGUID: skn/x0DDTZqosT/FlJHvHg==
X-CSE-MsgGUID: 0BwikP2CRMWgZSbI5GKuXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122538433"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Mar 2025 10:27:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuxCt-000FYs-1b;
	Wed, 19 Mar 2025 17:27:55 +0000
Date: Thu, 20 Mar 2025 01:27:31 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid
 potential string cuts
Message-ID: <202503200024.WkseT3sA-lkp@intel.com>
References: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-phy-Fix-formatting-specifier-to-avoid-potential-string-cuts/20250319-190433
base:   net/main
patch link:    https://lore.kernel.org/r/20250319105813.3102076-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid potential string cuts
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250320/202503200024.WkseT3sA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200024.WkseT3sA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200024.WkseT3sA-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/genet/bcmmii.c:17:
   drivers/net/ethernet/broadcom/genet/bcmmii.c: In function 'bcmgenet_mii_pd_init':
>> include/linux/phy.h:312:20: warning: '%02hhx' directive output may be truncated writing 2 bytes into a region of size between 0 and 60 [-Wformat-truncation=]
     312 | #define PHY_ID_FMT "%s:%02hhx"
         |                    ^~~~~~~~~~~
   drivers/net/ethernet/broadcom/genet/bcmmii.c:604:53: note: in expansion of macro 'PHY_ID_FMT'
     604 |                 snprintf(phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT,
         |                                                     ^~~~~~~~~~
   include/linux/phy.h:312:24: note: format string is defined here
     312 | #define PHY_ID_FMT "%s:%02hhx"
         |                        ^~~~~~
   include/linux/phy.h:312:20: note: using the range [0, 255] for directive argument
     312 | #define PHY_ID_FMT "%s:%02hhx"
         |                    ^~~~~~~~~~~
   drivers/net/ethernet/broadcom/genet/bcmmii.c:604:53: note: in expansion of macro 'PHY_ID_FMT'
     604 |                 snprintf(phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT,
         |                                                     ^~~~~~~~~~
   drivers/net/ethernet/broadcom/genet/bcmmii.c:604:17: note: 'snprintf' output between 4 and 64 bytes into a destination of size 61
     604 |                 snprintf(phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     605 |                          mdio_bus_id, pd->phy_address);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   loongarch64-linux-ld: arch/loongarch/kernel/head.o: relocation R_LARCH_B26 overflow 0xfffffffff3911f74
   arch/loongarch/kernel/head.o: in function `smpboot_entry':
>> (.ref.text+0x15c): relocation truncated to fit: R_LARCH_B26 against symbol `start_secondary' defined in .text section in arch/loongarch/kernel/smp.o
   loongarch64-linux-ld: final link failed: bad value


vim +312 include/linux/phy.h

   310	
   311	/* Used when trying to connect to a specific phy (mii bus id:phy device id) */
 > 312	#define PHY_ID_FMT "%s:%02hhx"
   313	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

