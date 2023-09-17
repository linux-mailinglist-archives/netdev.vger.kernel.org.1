Return-Path: <netdev+bounces-34365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2637A3D9F
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 22:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF7281424
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B97472;
	Sun, 17 Sep 2023 20:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAB63B8
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 20:51:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61576131;
	Sun, 17 Sep 2023 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694983906; x=1726519906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=paznUEp5GxW/Ux7AJ7asXSl9DWPKdN6uyysmYb20O+E=;
  b=gw5pRvvFAD8Do1CzoE5ufdwYaPBd8sgP+Fv0HshxM0YvbxfgS84/1YYD
   +8ycOfCrPWRqLs8Y5hhlu2pv6zrT1OLcGT60tAaAd0K1e5auAD/KemB/E
   ngB3aT4j/ag5SvBigaonXqobotcZAxMFOkvEpTEA2nwHggsep0K6DBn+z
   X5v3EApHb2zWsH7X6D0+bIx+CE3kZ6jF0cu022h3/1JJ+yqFfocdIOJ+x
   bj548k7siI8ADJQKF76wwYxPr7wA5TG+q+huQmJNqyNW4+erY9lw89eKk
   gNjzbAdsn41UZSlYHnCzA/RPG5P02s0VTDOO0bpih8LyLzMOWtTTsuzWS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359780755"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="359780755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 13:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815798331"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="815798331"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2023 13:51:43 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qhyk1-0005Sa-2g;
	Sun, 17 Sep 2023 20:51:41 +0000
Date: Mon, 18 Sep 2023 04:50:59 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>, linux-doc@vger.kernel.org
Subject: [net-next:main 2/43] htmldocs:
 Documentation/driver-api/dpll.rst:427: WARNING: Error in "code-block"
 directive:
Message-ID: <202309180456.lOhxy9gS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   d692873cbe861a870cdc9cbfb120eefd113c3dfd
commit: dbb291f19393b628a1d15b94a78d471b9d94e532 [2/43] dpll: documentation on DPLL subsystem interface
reproduce: (https://download.01.org/0day-ci/archive/20230918/202309180456.lOhxy9gS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309180456.lOhxy9gS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/dpll.rst:427: WARNING: Error in "code-block" directive:

vim +427 Documentation/driver-api/dpll.rst

   426	
 > 427	.. code-block:: c
   428		static const struct dpll_device_ops dpll_ops = {
   429			.lock_status_get = ptp_ocp_dpll_lock_status_get,
   430			.mode_get = ptp_ocp_dpll_mode_get,
   431			.mode_supported = ptp_ocp_dpll_mode_supported,
   432		};
   433	
   434		static const struct dpll_pin_ops dpll_pins_ops = {
   435			.frequency_get = ptp_ocp_dpll_frequency_get,
   436			.frequency_set = ptp_ocp_dpll_frequency_set,
   437			.direction_get = ptp_ocp_dpll_direction_get,
   438			.direction_set = ptp_ocp_dpll_direction_set,
   439			.state_on_dpll_get = ptp_ocp_dpll_state_get,
   440		};
   441	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

