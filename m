Return-Path: <netdev+bounces-37666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5067B685C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 61E1B2815E0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899722EEB;
	Tue,  3 Oct 2023 11:54:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E621373
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:54:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C93A6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696334061; x=1727870061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuUBS98GIeSeyEiT0rDr6RqvPbt3U21tkUiVvYVC4iM=;
  b=Yof+La8ZWn9ta0jAWmT4eRxb3V79C8UTFoB2zg1YlNAwuCWUFsjQ1WH/
   lZnbMBdn3Do8D91/cvSUkG+Z8ayWTTkJxd+QF35cCNMgcMepmmRwStSKi
   N/VH7ooKdbdHIK0IeM0iLvMYeUIueBGZ34DJZp5ldxkbyaNS7b58AcFr5
   MI5gkQ2Nz8HTwHHQeqUA8/SGtSh4RQ1ifpXghfnkBHu880pbGTnhEuvE6
   TrRlvT98AOonu0fymu28oY6j9t7ReEuvuQKwzPVM3H/w0u53fR3dtCgBh
   KIYbIcvqP4al99qydHfCyHtROgjF9LnNtjdERfFeV3N0WkqoTF0O1SmPa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382764328"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="382764328"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 04:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841324637"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841324637"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2023 04:54:18 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qndyi-00075s-2M;
	Tue, 03 Oct 2023 11:54:16 +0000
Date: Tue, 3 Oct 2023 19:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: Aniruddha Paul <aniruddha.paul@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, marcin.szycik@intel.com,
	netdev@vger.kernel.org, Aniruddha Paul <aniruddha.paul@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net,v2] ice: Fix VF-VF filter rules in switchdev mode
Message-ID: <202310031925.uHjPXxCu-lkp@intel.com>
References: <20231003081639.1915967-1-aniruddha.paul@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003081639.1915967-1-aniruddha.paul@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Aniruddha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc4 next-20231003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aniruddha-Paul/ice-Fix-VF-VF-filter-rules-in-switchdev-mode/20231003-161801
base:   linus/master
patch link:    https://lore.kernel.org/r/20231003081639.1915967-1-aniruddha.paul%40intel.com
patch subject: [PATCH iwl-net,v2] ice: Fix VF-VF filter rules in switchdev mode
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231003/202310031925.uHjPXxCu-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310031925.uHjPXxCu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310031925.uHjPXxCu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_tc_lib.c: In function 'ice_eswitch_tc_parse_action':
>> drivers/net/ethernet/intel/ice/ice_tc_lib.c:678:26: warning: unused variable 'repr' [-Wunused-variable]
     678 |         struct ice_repr *repr;
         |                          ^~~~


vim +/repr +678 drivers/net/ethernet/intel/ice/ice_tc_lib.c

   672	
   673	static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
   674					       struct ice_tc_flower_fltr *fltr,
   675					       struct flow_action_entry *act)
   676	{
   677		int err;
 > 678		struct ice_repr *repr;
   679	
   680		switch (act->id) {
   681		case FLOW_ACTION_DROP:
   682			fltr->action.fltr_act = ICE_DROP_PACKET;
   683			break;
   684	
   685		case FLOW_ACTION_REDIRECT:
   686			err = ice_tc_setup_redirect_action(filter_dev, fltr, act->dev);
   687			if (err)
   688				return err;
   689	
   690			break;
   691	
   692		default:
   693			NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action in switchdev mode");
   694			return -EINVAL;
   695		}
   696	
   697		return 0;
   698	}
   699	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

