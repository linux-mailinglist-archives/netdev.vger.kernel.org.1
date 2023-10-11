Return-Path: <netdev+bounces-39910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886787C4DB3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B902C1C20B35
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC01A29B;
	Wed, 11 Oct 2023 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMg+1Lo0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B0199D4;
	Wed, 11 Oct 2023 08:54:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA469D;
	Wed, 11 Oct 2023 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697014448; x=1728550448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=714S6mut/9WqubXB7r7ivANIejuGEiLpzLr+etG14No=;
  b=OMg+1Lo0QWi/rokKLtCKlWKOLsSbKzXptdiAkb3a+8pon0O3oKHdgaXP
   eCFdWfes/Wvmn6RSgdiKnGR+zMD6IQQX9q5OcMkP2FfueIEfdGhw5nVyL
   fWJZxhP7WjLvZhXqF2Ia0OrOuRducnbDGbcA//u1bb/IejlNkNzxunFt7
   JBdqoGfv94Y3VSytxm3PeTW2bc5aGQ5aCuVD02us3zsm6pWjZYEBwWHGp
   cgyL40rJ6s2BIlb/fh07MnTu7Mogp3OAGjHVeBlnxHvO2gvKZFJMvC3RQ
   NlgWMtwX0luMLYvI+djoX/RCk+695Hd7WYaEeMxbx98CjqQW7nsGz/GNR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387455863"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387455863"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="819610252"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="819610252"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2023 01:54:05 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqUyh-000223-2n;
	Wed, 11 Oct 2023 08:54:03 +0000
Date: Wed, 11 Oct 2023 16:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: Use conduit and user terms
Message-ID: <202310111600.FwR1laqR-lkp@intel.com>
References: <20231010213942.3633407-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010213942.3633407-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-dsa-Use-conduit-and-user-terms/20231011-054044
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231010213942.3633407-2-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next 1/2] net: dsa: Use conduit and user terms
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310111600.FwR1laqR-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310111600.FwR1laqR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111600.FwR1laqR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_ppe_offload.c: In function 'mtk_flow_get_dsa_port':
   drivers/net/ethernet/mediatek/mtk_ppe_offload.c:178:16: error: implicit declaration of function 'dsa_port_to_master'; did you mean 'dsa_port_is_user'? [-Werror=implicit-function-declaration]
     178 |         *dev = dsa_port_to_master(dp);
         |                ^~~~~~~~~~~~~~~~~~
         |                dsa_port_is_user
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:178:14: warning: assignment to 'struct net_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     178 |         *dev = dsa_port_to_master(dp);
         |              ^
   cc1: some warnings being treated as errors


vim +178 drivers/net/ethernet/mediatek/mtk_ppe_offload.c

502e84e2382d92 Felix Fietkau   2021-03-24  164  
502e84e2382d92 Felix Fietkau   2021-03-24  165  static int
502e84e2382d92 Felix Fietkau   2021-03-24  166  mtk_flow_get_dsa_port(struct net_device **dev)
502e84e2382d92 Felix Fietkau   2021-03-24  167  {
502e84e2382d92 Felix Fietkau   2021-03-24  168  #if IS_ENABLED(CONFIG_NET_DSA)
502e84e2382d92 Felix Fietkau   2021-03-24  169  	struct dsa_port *dp;
502e84e2382d92 Felix Fietkau   2021-03-24  170  
502e84e2382d92 Felix Fietkau   2021-03-24  171  	dp = dsa_port_from_netdev(*dev);
502e84e2382d92 Felix Fietkau   2021-03-24  172  	if (IS_ERR(dp))
502e84e2382d92 Felix Fietkau   2021-03-24  173  		return -ENODEV;
502e84e2382d92 Felix Fietkau   2021-03-24  174  
502e84e2382d92 Felix Fietkau   2021-03-24  175  	if (dp->cpu_dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
502e84e2382d92 Felix Fietkau   2021-03-24  176  		return -ENODEV;
502e84e2382d92 Felix Fietkau   2021-03-24  177  
8f6a19c0316deb Vladimir Oltean 2022-09-11 @178  	*dev = dsa_port_to_master(dp);
502e84e2382d92 Felix Fietkau   2021-03-24  179  
502e84e2382d92 Felix Fietkau   2021-03-24  180  	return dp->index;
502e84e2382d92 Felix Fietkau   2021-03-24  181  #else
502e84e2382d92 Felix Fietkau   2021-03-24  182  	return -ENODEV;
502e84e2382d92 Felix Fietkau   2021-03-24  183  #endif
502e84e2382d92 Felix Fietkau   2021-03-24  184  }
502e84e2382d92 Felix Fietkau   2021-03-24  185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

