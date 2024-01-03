Return-Path: <netdev+bounces-61382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382518238E6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C530C287243
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA71EB4B;
	Wed,  3 Jan 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jj6NOADN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8691DDE6
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704323046; x=1735859046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vGcq2wZ/3MoECeI1AeLjvaoDIUNBuDGWAUDnBR7yXGQ=;
  b=jj6NOADNMgHcbjhvkBTMdHAyrdo2ieCRmx78SoDj9Ahfi7Q9JgxlnTix
   Bci4whZIyMKDha3fftjZEjJBr5jj6NJNJ1GEaQbXsaWBnTIHcTcHTtcw4
   RKyWBY+wS04C3FwAFsJTh/A+/ZRBYQuTymUQ+AQuJM2e9PyyZy1K/xc3V
   kTIUGbfaL3g884trWZi0C8zCkxPrPJYRYE5Iu3AlpXNjqMGtLiFNiedA4
   WHLC2gctn1a+HFBYKNO6ObDdMOUohAXJJojbWRb6kwEwhjVYZAUpqR77L
   onTyLyRhYaEg+Air6sEA2jLxDIcPSLsqmd7w/jyqcYheVUUrmOByrljrj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10484838"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="10484838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 15:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="923716566"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="923716566"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2024 15:04:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLAHH-000Meq-1H;
	Wed, 03 Jan 2024 23:03:59 +0000
Date: Thu, 4 Jan 2024 07:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Add LED infrastructure
Message-ID: <202401040647.fVDMN6wS-lkp@intel.com>
References: <20240103103351.1188835-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103103351.1188835-2-tobias@waldekranz.com>

Hi Tobias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tobias-Waldekranz/net-dsa-mv88e6xxx-Add-LED-infrastructure/20240103-183726
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240103103351.1188835-2-tobias%40waldekranz.com
patch subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Add LED infrastructure
config: arm64-randconfig-001-20240104 (https://download.01.org/0day-ci/archive/20240104/202401040647.fVDMN6wS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040647.fVDMN6wS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040647.fVDMN6wS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/mv88e6xxx/leds.c:171:5: warning: no previous prototype for 'mv88e6xxx_port_setup_leds' [-Wmissing-prototypes]
     171 | int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mv88e6xxx_port_setup_leds +171 drivers/net/dsa/mv88e6xxx/leds.c

   170	
 > 171	int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

