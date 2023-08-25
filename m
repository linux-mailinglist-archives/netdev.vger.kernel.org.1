Return-Path: <netdev+bounces-30794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4A7891AC
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33A9281945
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363F1AA6B;
	Fri, 25 Aug 2023 22:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DA19883
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 22:23:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D92110
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693002208; x=1724538208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JBnc0QG+1aFQQroftxh2ThC8FXzf6nI5IRhrwD0d8tY=;
  b=aEOX1LhWAoHdxKZRQR5eQ51Sp/YSBLl9LFl8Vy/4p0fT09n45oEwhsOe
   Ko+j6eofu1b4qcuPozApmnnbOOFHUmu4jmpieugPmc1XY9yaSY79sKuvI
   P6hM6wSqLCpM6M3lOvzFoTkMsr3ySR+B0TRB3AuEFVhMMQ0cGgXoqXIVm
   oZmhd1ArTCcZLPRWu1TkNcOl7WlRYm/NT5wNDZobBYQLWu4/k+GQytu2w
   7J8lEOnXhzVsBJfajg28HZLpb6ML+mOdO7FcZlXDytiaF0dZMb1ufI/+N
   lX/E2poKt7uSvO3VF1CvyQGVLz+1O0OOyIhFV8SZuKt/2Oicsz0lLVrjp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="374789365"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="374789365"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 15:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772640758"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="772640758"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 15:22:09 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qZfBu-000445-0v;
	Fri, 25 Aug 2023 22:22:06 +0000
Date: Sat, 26 Aug 2023 06:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>,
	intel-wired-lan@osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	aelior@marvell.com, manishc@marvell.com, andrew@lunn.ch
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 2/8] ethtool: Add forced
 speed to supported link modes maps
Message-ID: <202308260616.Sf8QzI7c-lkp@intel.com>
References: <20230823180633.2450617-3-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823180633.2450617-3-pawel.chmielewski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pawel,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Chmielewski/ice-Add-E830-device-IDs-MAC-type-and-registers/20230824-021235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20230823180633.2450617-3-pawel.chmielewski%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v3 2/8] ethtool: Add forced speed to supported link modes maps
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230826/202308260616.Sf8QzI7c-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260616.Sf8QzI7c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260616.Sf8QzI7c-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/qlogic/qede/qede_ethtool.c: In function 'qede_set_link_ksettings':
>> drivers/net/ethernet/qlogic/qede/qede_ethtool.c:584:29: error: assignment to 'const struct qede_forced_speed_map *' from incompatible pointer type 'struct ethtool_forced_speed_map *' [-Werror=incompatible-pointer-types]
     584 |                         map = qede_forced_speed_maps + i;
         |                             ^
>> drivers/net/ethernet/qlogic/qede/qede_ethtool.c:586:47: error: invalid use of undefined type 'const struct qede_forced_speed_map'
     586 |                         if (base->speed != map->speed ||
         |                                               ^~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:588:53: error: invalid use of undefined type 'const struct qede_forced_speed_map'
     588 |                                                  map->caps))
         |                                                     ^~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:592:70: error: invalid use of undefined type 'const struct qede_forced_speed_map'
     592 |                                      current_link.supported_caps, map->caps);
         |                                                                      ^~
   cc1: some warnings being treated as errors


vim +584 drivers/net/ethernet/qlogic/qede/qede_ethtool.c

133fac0eedc355 Sudarsana Kalluru            2015-10-26  546  
054c67d1c82afd Sudarsana Reddy Kalluru      2016-08-09  547  static int qede_set_link_ksettings(struct net_device *dev,
054c67d1c82afd Sudarsana Reddy Kalluru      2016-08-09  548  				   const struct ethtool_link_ksettings *cmd)
133fac0eedc355 Sudarsana Kalluru            2015-10-26  549  {
054c67d1c82afd Sudarsana Reddy Kalluru      2016-08-09  550  	const struct ethtool_link_settings *base = &cmd->base;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  551  	struct qede_dev *edev = netdev_priv(dev);
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  552  	const struct qede_forced_speed_map *map;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  553  	struct qed_link_output current_link;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  554  	struct qed_link_params params;
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  555  	u32 i;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  556  
fe7cd2bfdac4d8 Yuval Mintz                  2016-04-22  557  	if (!edev->ops || !edev->ops->common->can_link_change(edev->cdev)) {
054c67d1c82afd Sudarsana Reddy Kalluru      2016-08-09  558  		DP_INFO(edev, "Link settings are not allowed to be changed\n");
133fac0eedc355 Sudarsana Kalluru            2015-10-26  559  		return -EOPNOTSUPP;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  560  	}
133fac0eedc355 Sudarsana Kalluru            2015-10-26  561  	memset(&current_link, 0, sizeof(current_link));
133fac0eedc355 Sudarsana Kalluru            2015-10-26  562  	memset(&params, 0, sizeof(params));
133fac0eedc355 Sudarsana Kalluru            2015-10-26  563  	edev->ops->common->get_link(edev->cdev, &current_link);
133fac0eedc355 Sudarsana Kalluru            2015-10-26  564  
133fac0eedc355 Sudarsana Kalluru            2015-10-26  565  	params.override_flags |= QED_LINK_OVERRIDE_SPEED_ADV_SPEEDS;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  566  	params.override_flags |= QED_LINK_OVERRIDE_SPEED_AUTONEG;
bdb5d8ec47611c Alexander Lobakin            2020-07-20  567  
054c67d1c82afd Sudarsana Reddy Kalluru      2016-08-09  568  	if (base->autoneg == AUTONEG_ENABLE) {
bdb5d8ec47611c Alexander Lobakin            2020-07-20  569  		if (!phylink_test(current_link.supported_caps, Autoneg)) {
161adb046b9119 sudarsana.kalluru@cavium.com 2017-05-04  570  			DP_INFO(edev, "Auto negotiation is not supported\n");
161adb046b9119 sudarsana.kalluru@cavium.com 2017-05-04  571  			return -EOPNOTSUPP;
161adb046b9119 sudarsana.kalluru@cavium.com 2017-05-04  572  		}
161adb046b9119 sudarsana.kalluru@cavium.com 2017-05-04  573  
133fac0eedc355 Sudarsana Kalluru            2015-10-26  574  		params.autoneg = true;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  575  		params.forced_speed = 0;
bdb5d8ec47611c Alexander Lobakin            2020-07-20  576  
bdb5d8ec47611c Alexander Lobakin            2020-07-20  577  		linkmode_copy(params.adv_speeds, cmd->link_modes.advertising);
133fac0eedc355 Sudarsana Kalluru            2015-10-26  578  	} else {		/* forced speed */
133fac0eedc355 Sudarsana Kalluru            2015-10-26  579  		params.override_flags |= QED_LINK_OVERRIDE_SPEED_FORCED_SPEED;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  580  		params.autoneg = false;
054c67d1c82afd Sudarsana Reddy Kalluru      2016-08-09  581  		params.forced_speed = base->speed;
bdb5d8ec47611c Alexander Lobakin            2020-07-20  582  
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  583  		for (i = 0; i < ARRAY_SIZE(qede_forced_speed_maps); i++) {
1d4e4ecccb1144 Alexander Lobakin            2020-07-20 @584  			map = qede_forced_speed_maps + i;
bdb5d8ec47611c Alexander Lobakin            2020-07-20  585  
1d4e4ecccb1144 Alexander Lobakin            2020-07-20 @586  			if (base->speed != map->speed ||
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  587  			    !linkmode_intersects(current_link.supported_caps,
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  588  						 map->caps))
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  589  				continue;
bdb5d8ec47611c Alexander Lobakin            2020-07-20  590  
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  591  			linkmode_and(params.adv_speeds,
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  592  				     current_link.supported_caps, map->caps);
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  593  			goto set_link;
bdb5d8ec47611c Alexander Lobakin            2020-07-20  594  		}
bdb5d8ec47611c Alexander Lobakin            2020-07-20  595  
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  596  		DP_INFO(edev, "Unsupported speed %u\n", base->speed);
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  597  		return -EINVAL;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  598  	}
133fac0eedc355 Sudarsana Kalluru            2015-10-26  599  
1d4e4ecccb1144 Alexander Lobakin            2020-07-20  600  set_link:
133fac0eedc355 Sudarsana Kalluru            2015-10-26  601  	params.link_up = true;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  602  	edev->ops->common->set_link(edev->cdev, &params);
133fac0eedc355 Sudarsana Kalluru            2015-10-26  603  
133fac0eedc355 Sudarsana Kalluru            2015-10-26  604  	return 0;
133fac0eedc355 Sudarsana Kalluru            2015-10-26  605  }
133fac0eedc355 Sudarsana Kalluru            2015-10-26  606  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

