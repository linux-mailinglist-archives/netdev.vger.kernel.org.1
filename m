Return-Path: <netdev+bounces-48227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8677ED925
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 03:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA091F2308A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD87E;
	Thu, 16 Nov 2023 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6MBdnK/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD61A8
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 18:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700100678; x=1731636678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hhlyXxGrC/E9zAEp+Y8MQVMk7XkRKYj0CGW6kL41jyg=;
  b=Q6MBdnK/yFLsddMdOlE84GkB5PVK5YpWPVX/qUkNpuIqTqMZBmH34DZC
   d2LZM+3eA+l3NUU389CeP1BKq1YvSHkfJUZ7RvFXg1BR0qzYWh2DTPRrG
   Z/rxiEubAMJNXUUbkekbVD/ZxemFET748vo2qjGWNobEmhLPAkgTJviyQ
   ycF5ZBv3b2XtIVBxxn2J5YldA8aN9hcCtFvvtOK1YYddMwXfzF8l96kGt
   GtjxqQVDVKey6ROfoFrq3x3HtMi6TAWIvzYeJRZ8Pzn6joeIrt/51HTXP
   WlXLvsQaqfvyJvzd4Yy1X3MiCkGM/Wg77B/bXU/WZL9eI3JAo3y7agNY9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371181329"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="371181329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 18:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096629973"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="1096629973"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2023 18:11:11 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3RqH-00017W-3B;
	Thu, 16 Nov 2023 02:10:57 +0000
Date: Thu, 16 Nov 2023 10:09:48 +0800
From: kernel test robot <lkp@intel.com>
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	davem@davemloft.net, kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boris Pismenny <borisp@nvidia.com>, aaptel@nvidia.com,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com,
	mgurtovoy@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v19 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <202311161023.IHztbwM3-lkp@intel.com>
References: <20231114124255.765473-2-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114124255.765473-2-aaptel@nvidia.com>

Hi Aurelien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.7-rc1 next-20231115]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aurelien-Aptel/net-Introduce-direct-data-placement-tcp-offload/20231114-205106
base:   net/main
patch link:    https://lore.kernel.org/r/20231114124255.765473-2-aaptel%40nvidia.com
patch subject: [PATCH v19 01/20] net: Introduce direct data placement tcp offload
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231116/202311161023.IHztbwM3-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161023.IHztbwM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161023.IHztbwM3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/core/skbuff.c:79:
>> include/net/ulp_ddp.h:317:6: warning: no previous prototype for function 'ulp_ddp_is_cap_active' [-Wmissing-prototypes]
   bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
        ^
   include/net/ulp_ddp.h:317:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
   ^
   static 
   1 warning generated.


vim +/ulp_ddp_is_cap_active +317 include/net/ulp_ddp.h

   316	
 > 317	bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
   318	{
   319		return false;
   320	}
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

