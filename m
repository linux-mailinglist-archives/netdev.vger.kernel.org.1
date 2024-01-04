Return-Path: <netdev+bounces-61393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B14823982
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A3C1C24AEE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC337A;
	Thu,  4 Jan 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf6cqASp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65737C
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704327376; x=1735863376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J2mVultJttywMWzo72cxl7a4ROmKo5Py2nb8ykvjPXc=;
  b=Qf6cqASpaxRkEcVJx7nELlTPuO7u770MyjTEHhfAWSGXl5e/PWLaurNK
   inruPIoexMxtmdtNVzL+SBOT7PKyFqNimigzoLccBQg2Tt+stKN2tANhI
   lFfVprCHDJShE7J3z84o/QBIaAkMgQcfJyCC4ey4cxMdf3DPG2WM0z2b+
   cLutV48lGSMj5EjwNh5Law1ZZaUwHVYdnmbjNNfPeeWz/GpzKoaEJegP5
   4BbFcF2QZKELUB2pS2qTjT8usZNAU9TBXIWSeE35EnxMku6gosPBcpzYk
   7c5hDg80M81ZgFJptOIITi1m28LD8fxlGuD4FYrelJILAV/NZ75oa/jyL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="394237444"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="394237444"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 16:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027223913"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="1027223913"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2024 16:16:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLBP6-000Mi0-0i;
	Thu, 04 Jan 2024 00:16:08 +0000
Date: Thu, 4 Jan 2024 08:15:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Add LED infrastructure
Message-ID: <202401040808.PYrPvsd9-lkp@intel.com>
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
config: arm-orion5x_defconfig (https://download.01.org/0day-ci/archive/20240104/202401040808.PYrPvsd9-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040808.PYrPvsd9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040808.PYrPvsd9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/mv88e6xxx/leds.c:171:5: warning: no previous prototype for function 'mv88e6xxx_port_setup_leds' [-Wmissing-prototypes]
     171 | int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)
         |     ^
   drivers/net/dsa/mv88e6xxx/leds.c:171:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     171 | int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)
         | ^
         | static 
   1 warning generated.


vim +/mv88e6xxx_port_setup_leds +171 drivers/net/dsa/mv88e6xxx/leds.c

   170	
 > 171	int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

