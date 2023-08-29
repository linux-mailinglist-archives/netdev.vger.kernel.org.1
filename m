Return-Path: <netdev+bounces-31237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AA78C48E
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6AD280CB0
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AE156DB;
	Tue, 29 Aug 2023 12:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB7156C7
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:55:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB61CCE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313700; x=1724849700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OqrJ7NCugAHCrcBizDstYU3tAj/RSOo3I5oth/zsfMI=;
  b=P4eUdrx4SXeO6Buj4yfsPu3YR3UOrQMEjIzmIxI4Oo1O640Ab8/kaq4e
   JchrVGCkfRwe1e0QVWZXO123e5EeveCbGPgPRt0R5E2ziUy3EmYC+e9Lu
   NJFSmcc6yUJLudytvViOO7k13UnI/L5/0heqy1OO4CdZ1ln67Bft7Iclo
   jaMSTs+c1nDfU372a0fcQ1z9Lk5fJ/ZHeRm8KCZNLLUpnsnC7TJJur+6v
   op7YIu9duw+hpFYN7/wkT3JeXajTWhwYCpA1DcX3WhEPq2gW6Pq6ek/fq
   uK69d8OhyBR7oCXyGxdOe5AauKbx2PbNOW8wyEIp4OBDcdswD4+ANlhzx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379128822"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="379128822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="828785221"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="828785221"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2023 05:54:57 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qayF8-0008jn-1C;
	Tue, 29 Aug 2023 12:54:52 +0000
Date: Tue, 29 Aug 2023 20:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v4 iwl-next 02/11] ice: introduce PTP
 state machine
Message-ID: <202308292029.9Je6bgXn-lkp@intel.com>
References: <20230829104041.64131-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829104041.64131-3-karol.kolacinski@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Karol,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 938672aefaeb88c4e3b6d8bc04ff97900e0809dd]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-use-ice_pf_src_tmr_owned-where-available/20230829-184543
base:   938672aefaeb88c4e3b6d8bc04ff97900e0809dd
patch link:    https://lore.kernel.org/r/20230829104041.64131-3-karol.kolacinski%40intel.com
patch subject: [Intel-wired-lan] [PATCH v4 iwl-next 02/11] ice: introduce PTP state machine
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230829/202308292029.9Je6bgXn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308292029.9Je6bgXn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308292029.9Je6bgXn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_ptp.c:265:20: warning: 'ice_ptp_state_str' defined but not used [-Wunused-function]
     265 | static const char *ice_ptp_state_str(enum ice_ptp_state state)
         |                    ^~~~~~~~~~~~~~~~~


vim +/ice_ptp_state_str +265 drivers/net/ethernet/intel/ice/ice_ptp.c

   257	
   258	/**
   259	 * ice_ptp_state_str - Convert PTP state to readable string
   260	 * @state: PTP state to convert
   261	 *
   262	 * Returns: the human readable string representation of the provided PTP
   263	 * state, used for printing error messages.
   264	 */
 > 265	static const char *ice_ptp_state_str(enum ice_ptp_state state)
   266	{
   267		switch (state) {
   268		case ICE_PTP_UNINIT:
   269			return "UNINITIALIZED";
   270		case ICE_PTP_INITIALIZING:
   271			return "INITIALIZING";
   272		case ICE_PTP_READY:
   273			return "READY";
   274		case ICE_PTP_RESETTING:
   275			return "RESETTING";
   276		case ICE_PTP_ERROR:
   277			return "ERROR";
   278		}
   279	
   280		return "UNKNOWN";
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

