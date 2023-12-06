Return-Path: <netdev+bounces-54215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91A806409
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EFD282089
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFABA48;
	Wed,  6 Dec 2023 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD9hokcN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F73D1A4;
	Tue,  5 Dec 2023 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701825757; x=1733361757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YygeRsuBpeLkRrcyXXjICZLGAaAyfBRAuKmnlwjKokc=;
  b=OD9hokcNLIEbXgd2tMPyu/B48LU08yM6J0acuE+yS/pDvUx+lc7OF8/q
   O/yhhRDywBEa73+2BvP5DS7jGWxZbey0OZmNTTbEax1kBURllCAV0raVy
   7y1m2zvf3xbXA/h/bwgOmsTmXaX+JBzmGCrcBbo1eoGktYMa3llBiudFE
   rw1qQgfIOl2cE/7dkJxw5EPmASaS7KU8WRQsUN9lLNXNnqPd9n54Zgj8R
   mh/zWw7kTJgPlVz1TFXsxYvcJTxR8Bb7jAMDZNjWJ9tKkdZCTpoumYu2K
   l2wrZjagHwyaVpaJNmLkGqB1XYXMx31z7i2yIOFedyeKgOFjdHxPdTbqR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396777238"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="396777238"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944462196"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944462196"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 17:22:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAgcM-000A0v-1U;
	Wed, 06 Dec 2023 01:22:26 +0000
Date: Wed, 6 Dec 2023 09:21:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, shaojijie@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: hns: fix fake link up on xge port
Message-ID: <202312060909.F00QN1zB-lkp@intel.com>
References: <20231201102703.4134592-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201102703.4134592-3-shaojijie@huawei.com>

Hi Jijie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jijie-Shao/net-hns-fix-wrong-head-when-modify-the-tx-feature-when-sending-packets/20231201-183325
base:   net/main
patch link:    https://lore.kernel.org/r/20231201102703.4134592-3-shaojijie%40huawei.com
patch subject: [PATCH net 2/2] net: hns: fix fake link up on xge port
config: i386-buildonly-randconfig-001-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060909.F00QN1zB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060909.F00QN1zB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060909.F00QN1zB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:69:6: warning: no previous prototype for function 'hns_mac_link_anti_shake' [-Wmissing-prototypes]
   void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
        ^
   drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
   ^
   static 
   1 warning generated.


vim +/hns_mac_link_anti_shake +69 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c

    68	
  > 69	void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
    70	{
    71	#define HNS_MAC_LINK_WAIT_TIME 5
    72	#define HNS_MAC_LINK_WAIT_CNT 40
    73	
    74		int i;
    75	
    76		if (!mac_ctrl_drv->get_link_status) {
    77			*link_status = 0;
    78			return;
    79		}
    80	
    81		for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
    82			msleep(HNS_MAC_LINK_WAIT_TIME);
    83			mac_ctrl_drv->get_link_status(mac_ctrl_drv, link_status);
    84			if (!*link_status)
    85				break;
    86		}
    87	}
    88	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

