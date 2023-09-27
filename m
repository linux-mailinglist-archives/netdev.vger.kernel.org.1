Return-Path: <netdev+bounces-36532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFC7B0516
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 722A0B20B90
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50830CEE;
	Wed, 27 Sep 2023 13:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA8C8E2
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 13:17:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575B121;
	Wed, 27 Sep 2023 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695820667; x=1727356667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+BpWTQS4cjrg0/4ItX5h1/FTVqglpHuksfECXMzkUU=;
  b=KoSn5z7NHhMPC+LLlCnmh0J93hTcSFYizWGJR1+ApgtV7qik9JfG3gI4
   Ug3dC8+zzTqMdvnKksJZv0K7TlvE0H7zY6JUDh92TROsp/qZAnA9auMGJ
   3BFkTCUc5kbXfvDXDrGch1JG12V0m8MnyyvXHMJt7muLV6zY+T/lnmlyr
   FizFrwIia0gy4pTLtXMzEQxZe4EMkW+nbu3siVzGrL4WANRFNiR1HhV2T
   tKSSDYzeX25M9jyq2znk0YETZnEUwcGitGHepgnifM9LDlQTHce4hUmVM
   GV3iw0TSGno1+jd8isg4zyhmbfIcPdjmwsI4L3DQyXWlSDbVt0LBJ3jaz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="445954377"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="445954377"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749195792"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="749195792"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2023 06:17:43 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qlUQ8-0000DT-0F;
	Wed, 27 Sep 2023 13:17:40 +0000
Date: Wed, 27 Sep 2023 21:17:27 +0800
From: kernel test robot <lkp@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vadim.fedorenko@linux.dev,
	jiri@resnulli.us, corbet@lwn.net, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH net-next 4/4] ice: dpll: implement phase related callbacks
Message-ID: <202309272113.rttl6e6s-lkp@intel.com>
References: <20230927092435.1565336-5-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927092435.1565336-5-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arkadiusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Arkadiusz-Kubalewski/dpll-docs-add-support-for-pin-signal-phase-offset-adjust/20230927-172843
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230927092435.1565336-5-arkadiusz.kubalewski%40intel.com
patch subject: [PATCH net-next 4/4] ice: dpll: implement phase related callbacks
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230927/202309272113.rttl6e6s-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309272113.rttl6e6s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309272113.rttl6e6s-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_dpll.c:1064: warning: Function parameter or member 'phase_offset' not described in 'ice_dpll_phase_offset_get'
>> drivers/net/ethernet/intel/ice/ice_dpll.c:1064: warning: Excess function parameter 'phase_adjust' description in 'ice_dpll_phase_offset_get'


vim +1064 drivers/net/ethernet/intel/ice/ice_dpll.c

  1039	
  1040	#define ICE_DPLL_PHASE_OFFSET_DIVIDER	100
  1041	#define ICE_DPLL_PHASE_OFFSET_FACTOR		\
  1042		(DPLL_PHASE_OFFSET_DIVIDER / ICE_DPLL_PHASE_OFFSET_DIVIDER)
  1043	/**
  1044	 * ice_dpll_phase_offset_get - callback for get dpll phase shift value
  1045	 * @pin: pointer to a pin
  1046	 * @pin_priv: private data pointer passed on pin registration
  1047	 * @dpll: registered dpll pointer
  1048	 * @dpll_priv: private data pointer passed on dpll registration
  1049	 * @phase_adjust: on success holds pin phase_adjust value
  1050	 * @extack: error reporting
  1051	 *
  1052	 * Dpll subsystem callback. Handler for getting phase shift value between
  1053	 * dpll's input and output.
  1054	 *
  1055	 * Context: Acquires pf->dplls.lock
  1056	 * Return:
  1057	 * * 0 - success
  1058	 * * negative - error
  1059	 */
  1060	static int
  1061	ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
  1062				  const struct dpll_device *dpll, void *dpll_priv,
  1063				  s64 *phase_offset, struct netlink_ext_ack *extack)
> 1064	{
  1065		struct ice_dpll *d = dpll_priv;
  1066		struct ice_pf *pf = d->pf;
  1067	
  1068		mutex_lock(&pf->dplls.lock);
  1069		if (d->active_input == pin)
  1070			*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
  1071		else
  1072			*phase_offset = 0;
  1073		mutex_unlock(&pf->dplls.lock);
  1074	
  1075		return 0;
  1076	}
  1077	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

