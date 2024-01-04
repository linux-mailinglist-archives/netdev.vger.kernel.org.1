Return-Path: <netdev+bounces-61701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B067824AA6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A036A1C22A44
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B432C84F;
	Thu,  4 Jan 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hA9pEBl5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7F2CCB3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704405693; x=1735941693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=93H6Vpc0MBiRTEHJHtgDGfDXmbGHCPaPX/Nlcjcqjws=;
  b=hA9pEBl5T0C+hQdfueZ1gFPhLxJxi2rlU02fjkUO5kKMOFE8M4aiRg3Z
   ocenNYIwLjLqF6+LGe3nObbXBtevD/U7M8+M4HvjXEScVWj26Cz/NqMEd
   mHuD0Gdhm1rTkozqvc2mpB51lcalbU/ZLE/AUbdK3qTOuggAf8eA1Vo4F
   XBy/83LikdcMujwy45vJQpP1IbV/IGRh3VW4SnnKYsL0ZvgozjF4FWaQh
   tdcG7XnzRinpkXQAHNo2zmAmOp4L7dT8/3GVv16p2tfeuqEix/mZTDhPZ
   dfr+dJEXuX1Fg4z9qcgR3HoOr62SlSLB+hNLkzlqnSwmd4qZtB7NYSwby
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382351046"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="382351046"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 14:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773660446"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="773660446"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2024 14:01:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLVmB-0000T0-0F;
	Thu, 04 Jan 2024 22:01:19 +0000
Date: Fri, 5 Jan 2024 06:01:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Add LED support for
 6393X
Message-ID: <202401050539.Y9LYQsgz-lkp@intel.com>
References: <20240103103351.1188835-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103103351.1188835-3-tobias@waldekranz.com>

Hi Tobias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tobias-Waldekranz/net-dsa-mv88e6xxx-Add-LED-infrastructure/20240103-183726
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240103103351.1188835-3-tobias%40waldekranz.com
patch subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Add LED support for 6393X
config: loongarch-randconfig-r113-20240104 (https://download.01.org/0day-ci/archive/20240105/202401050539.Y9LYQsgz-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240105/202401050539.Y9LYQsgz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401050539.Y9LYQsgz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/dsa/mv88e6xxx/leds.c:77:21: sparse: sparse: symbol 'mv88e6393x_led_map' was not declared. Should it be static?

vim +/mv88e6393x_led_map +77 drivers/net/dsa/mv88e6xxx/leds.c

    76	
  > 77	const unsigned long *mv88e6393x_led_map(struct mv88e6xxx_led *led)
    78	{
    79		switch (led->port) {
    80		case 1:
    81		case 2:
    82		case 3:
    83		case 4:
    84		case 5:
    85		case 6:
    86		case 7:
    87		case 8:
    88			return mv88e6393x_led_map_p1_p8[led->index];
    89		case 9:
    90		case 10:
    91			return mv88e6393x_led_map_p9_p10[led->index];
    92		}
    93	
    94		return NULL;
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

