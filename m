Return-Path: <netdev+bounces-158666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5DA12E62
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0555C3A4A11
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8F1DC197;
	Wed, 15 Jan 2025 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiobjkc5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DB1D88BE;
	Wed, 15 Jan 2025 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981078; cv=none; b=FrTmB3c1Io3Tw8q0yM+egOfThKoRSvK3WX1uWHdl6iUZEjnYx2aCskzjo2FH9s986Djae8+raSl/YSJnjLKOGsAB7sBCnQ6kvZBJIeSeqznjw0iMewb8htoh8z7jhPAKwIwuQqGD1b4LBn3OdAXsJaVesI+Zm6DKkqBNZ29k4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981078; c=relaxed/simple;
	bh=h29t99tH8d0ulLIw31frUgVv8vrqxeoFmGQof/fXOq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiE6+fSAY5SYxufc9ufILnsiyELOLw8TPBn0AQr4MCOeMCNeR3NqQUzgY1M2AHKnXmL+Moi3t2qEDTJBFsRg9r1SI9Csyg/kG2JGpKyxiXNCZkiDUzhvq/d9zMrPqpDHDn0PBFjKEAEwez5CgWUumkXTfTNZgh2WJEzIT3hP78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiobjkc5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736981076; x=1768517076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h29t99tH8d0ulLIw31frUgVv8vrqxeoFmGQof/fXOq8=;
  b=aiobjkc5u+Ujy8n2IIJ6HxHNF3muAcUB5xQMZdz1T5RYJ1D10frwd7Tk
   YJocDA8gUfw0Td8xVCWuta3nAIS1LWpff+uNmnQrNXyDc22dxCQzY3Eo0
   Bf2l/f818AGJ3UjXAF+yupqlcH1zoao0nZQXAr85EOVH9KCflNX29l9n/
   tmGxwsMBfi/7KaremDYVueU6k8IJs+cb5OgPLz6Xt0sCti99fOp6M5P1n
   0VbXDBXpObhBr/vJ1XYOHtKJaLRCYwasN7cSM5fbY4UWU7J/bI4O39cs+
   1+nEONEsC3SXEvjnr2mFwPLL4RK9B+1Ozjm0IJ39cBd+0izutb8EGiPYv
   Q==;
X-CSE-ConnectionGUID: EIvwdIndSw+RoIP9h4PD3A==
X-CSE-MsgGUID: StFhTXdNRDWmbx52tL1LGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47825675"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="47825675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 14:44:36 -0800
X-CSE-ConnectionGUID: lfhihHR0S8qiNflhmlzWwg==
X-CSE-MsgGUID: h4yqM785RDupXz8qgM2NOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="105105786"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jan 2025 14:44:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYC7i-000QyB-0B;
	Wed, 15 Jan 2025 22:44:30 +0000
Date: Thu, 16 Jan 2025 06:44:22 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next 2/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <202501160621.sg88rASV-lkp@intel.com>
References: <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>

Hi Dimitri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7d0da8f862340c5f42f0062b8560b8d0971a6ac4]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau-via-B4-Relay/dt-bindings-net-dp83822-Add-support-for-changing-the-transmit-amplitude-voltage/20250113-134317
base:   7d0da8f862340c5f42f0062b8560b8d0971a6ac4
patch link:    https://lore.kernel.org/r/20250113-dp83822-tx-swing-v1-2-7ed5a9d80010%40liebherr.com
patch subject: [PATCH net-next 2/2] net: phy: dp83822: Add support for changing the transmit amplitude voltage
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250116/202501160621.sg88rASV-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250116/202501160621.sg88rASV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501160621.sg88rASV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/dp83822.c:7:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/dp83822.c:207:18: warning: unused variable 'tx_amplitude_100base_tx' [-Wunused-const-variable]
     207 | static const u32 tx_amplitude_100base_tx[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +/tx_amplitude_100base_tx +207 drivers/net/phy/dp83822.c

   206	
 > 207	static const u32 tx_amplitude_100base_tx[] = {
   208		1600, 1633, 1667, 1700, 1733, 1767, 1800, 1833,
   209		1867, 1900, 1933, 1967, 2000, 2033, 2067, 2100,
   210	};
   211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

