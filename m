Return-Path: <netdev+bounces-43265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199ED7D2107
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 06:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6028173A
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 04:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660F336A;
	Sun, 22 Oct 2023 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg+Jl20s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D01A29
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 04:57:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD5DA
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697950666; x=1729486666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J4r5qgzhbH7bz03iXKn+50K03N+gw6/ZpdVJMMpGSL0=;
  b=Eg+Jl20sr0v1b15vNZyMiIni89blW2GrKjYi5WNUXgl4Sw7ha7ro6Mn8
   AzwxCgPvfJyFRmVOi76sYf9ja3oK0L8LMc0+ZjaDRnJmDNJLhd0OlYZgN
   KdDncwmYHPZ3dez4DYkuryQxZrK3C6k6e13BBUuMZzS4jkZfaYg6sS7kn
   eu7Uxii+7IP2t0soOdgoYOA7f3aMyMTdT2sZQlJHk89D6zvOaSVpjznm7
   sXdFnGhThgNTnZeTMojYikdEt5+L3/zLlX0AbEJfsdkMkm4xlYB0B9xpg
   EZ/4B68QsZb2sOYdKWmUMlcqZm6zl0QG4zU08DvZ0LETeK1rTln/m02m4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="389533312"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="389533312"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 21:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="1004971636"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="1004971636"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2023 21:57:42 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quQWx-0005bG-2w;
	Sun, 22 Oct 2023 04:57:39 +0000
Date: Sun, 22 Oct 2023 12:57:32 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH net-next 2/2] amd-xgbe: Add support for AMD Crater
 ethernet device
Message-ID: <202310221212.UV7uO9yX-lkp@intel.com>
References: <20231018144450.2061125-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018144450.2061125-3-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-add-support-for-new-pci-device-id-0x1641/20231018-224804
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231018144450.2061125-3-Raju.Rangoju%40amd.com
patch subject: [PATCH net-next 2/2] amd-xgbe: Add support for AMD Crater ethernet device
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231022/202310221212.UV7uO9yX-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310221212.UV7uO9yX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221212.UV7uO9yX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/amd/xgbe/xgbe-main.c:125:
>> drivers/net/ethernet/amd/xgbe/xgbe.h:136:10: fatal error: asm/amd_nb.h: No such file or directory
     136 | #include <asm/amd_nb.h>
         |          ^~~~~~~~~~~~~~
   compilation terminated.


vim +136 drivers/net/ethernet/amd/xgbe/xgbe.h

   119	
   120	#include <linux/dma-mapping.h>
   121	#include <linux/netdevice.h>
   122	#include <linux/workqueue.h>
   123	#include <linux/phy.h>
   124	#include <linux/if_vlan.h>
   125	#include <linux/bitops.h>
   126	#include <linux/ptp_clock_kernel.h>
   127	#include <linux/timecounter.h>
   128	#include <linux/net_tstamp.h>
   129	#include <net/dcbnl.h>
   130	#include <linux/completion.h>
   131	#include <linux/cpumask.h>
   132	#include <linux/interrupt.h>
   133	#include <linux/dcache.h>
   134	#include <linux/ethtool.h>
   135	#include <linux/list.h>
 > 136	#include <asm/amd_nb.h>
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

