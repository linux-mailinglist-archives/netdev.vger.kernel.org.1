Return-Path: <netdev+bounces-238549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37EC5AEC7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D9D334BFE3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF3254B19;
	Fri, 14 Nov 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFwvVR6+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389F256C71;
	Fri, 14 Nov 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083956; cv=none; b=VHrGllP3rtLCiWmulUP5+lp8fmOZhA6nliCrxFsxpYg98b4mnQU1Qb0vjzW0rD8UeMk4vQHRdk3BxIML5fkknJPCPd3L/648c4o6tv+4wJQE+5iygUBcfalwqwMBUJPMCyWjsmTam/8UzhKsU9qsxGhTZulUijCb/p3W5ulrfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083956; c=relaxed/simple;
	bh=c6WMavBeC4GmkaYdIJt/VYZZTX1d+gckXJJXF03K/XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re14MraWEJelqgA3I79pS7KrXvm16pVwR0NOOOliu1P7uXLoYVaXnL95LCeN8H2IrVD/8mlsOCic1CJwnnLiomL6mqqVLivEweIgayOfpDhbiGIvVDwawESytn0LeA+uzxmWdw2w7dkXFucdVxeSVSe/2f9K6J/VHUAsSX7a4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFwvVR6+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763083955; x=1794619955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c6WMavBeC4GmkaYdIJt/VYZZTX1d+gckXJJXF03K/XQ=;
  b=YFwvVR6+J6BwvE9wkvLvM0fHqi1HYiDuD6i7rNPQ2PoOE84vPw9Ty7Il
   gRbnRTzt4T7j5kIiwHFZTDRbqDhlnT54aHJpDZNP+/3nTqhgJ0FCW3rjc
   f9qT9wuPe7RaAdKFuILuvi8QrFYSI6ONhnbe+AAVCV2f5ezEtEltFH9Y1
   EkPcJkeHwApl0h+2sImty+ARZFXW8z74W/6r/vemArdWIqt37zkZZ5yBm
   zNMSf4rB+GfD6QbY7Ip/ueInGq2OSYPAToT/ESDhgPkZeLsuZnNv9zILi
   3ZLaeoxBeDFzMVvYCZ7jA1NeYP91dqSmO8BDia0+VKs6Mack9TmL7EApe
   g==;
X-CSE-ConnectionGUID: COtwXCqmS6O7mIHo3kiFGw==
X-CSE-MsgGUID: BI30rrf3QYmqdBi/VvfcOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65114165"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65114165"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 17:32:34 -0800
X-CSE-ConnectionGUID: 7OiWLs2rQnSNcqplvU/PIQ==
X-CSE-MsgGUID: USynJ5uYRBSDgXd96p7JSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="190074403"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Nov 2025 17:32:31 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJift-000639-27;
	Fri, 14 Nov 2025 01:32:29 +0000
Date: Fri, 14 Nov 2025 09:31:36 +0800
From: kernel test robot <lkp@intel.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Message-ID: <202511140914.gSDRcCEL-lkp@intel.com>
References: <20251113115206.140339-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113115206.140339-2-parthiban.veerasooran@microchip.com>

Hi Parthiban,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 68fa5b092efab37a4f08a47b22bb8ca98f7f6223]

url:    https://github.com/intel-lab-lkp/linux/commits/Parthiban-Veerasooran/net-phy-phy-c45-add-SQI-and-SQI-support-for-OATC14-10Base-T1S-PHYs/20251113-195905
base:   68fa5b092efab37a4f08a47b22bb8ca98f7f6223
patch link:    https://lore.kernel.org/r/20251113115206.140339-2-parthiban.veerasooran%40microchip.com
patch subject: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20251114/202511140914.gSDRcCEL-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511140914.gSDRcCEL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511140914.gSDRcCEL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/phy/phy-c45.c:1700 bad line:                                    OATC14 10Base-T1S PHY
>> Warning: drivers/net/phy/phy-c45.c:1742 bad line:                                10Base-T1S PHY

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

