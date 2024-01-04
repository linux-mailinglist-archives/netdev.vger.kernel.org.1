Return-Path: <netdev+bounces-61443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C265823B09
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 04:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BF5287FDB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265E5231;
	Thu,  4 Jan 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzfW1GzW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E7522A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704338242; x=1735874242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4t+8AGUkr5qIig1mL92sAc1AjdDSVehKzDxwpmnmh4Y=;
  b=bzfW1GzW1npcsBoVghzICRnlxcGZQal4OHXcjrKh1OxbRvLeuxU2L7Zb
   FVnxj6yo1o9pWNOQt1QYo8WDxzWTySFTlVjArYcrlwR92L0SJ6qb8j/Kr
   hLr0K9po8Iwo+Zd4N4clWn9+A8ivgtr146ciGLpfyP6JG9gemKc4qGeOO
   OevaWGYeWeGRXcn8V/r437WLhz/+8nrxQhLvSgl846KuSvRVloge+Zgdm
   oVY7nY6CQjk7xBMbwoxa7Rpx7niE9WUrriQidzCsXvVgo0PlCLh5sf3FF
   qWJ92/jKOdQiTmZrCiucWMt1Nbg29UgmxOQ64VE+YZL2MzIW182uiVAaE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="463516644"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="463516644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="814466507"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="814466507"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2024 19:17:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLEEP-000MqO-11;
	Thu, 04 Jan 2024 03:17:17 +0000
Date: Thu, 4 Jan 2024 11:16:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Add LED support for
 6393X
Message-ID: <202401041120.UXiohfGq-lkp@intel.com>
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
config: arm64-randconfig-001-20240104 (https://download.01.org/0day-ci/archive/20240104/202401041120.UXiohfGq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401041120.UXiohfGq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401041120.UXiohfGq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/mv88e6xxx/leds.c:77:22: warning: no previous prototype for 'mv88e6393x_led_map' [-Wmissing-prototypes]
      77 | const unsigned long *mv88e6393x_led_map(struct mv88e6xxx_led *led)
         |                      ^~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/leds.c:398:5: warning: no previous prototype for 'mv88e6xxx_port_setup_leds' [-Wmissing-prototypes]
     398 | int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


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

