Return-Path: <netdev+bounces-38274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A87B9E52
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 44D662825AB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08042868E;
	Thu,  5 Oct 2023 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqbtSawU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1927726
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:04:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8E6602
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514676; x=1728050676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GqKe2kbO3tMy/0EgmQO31nknlkfPS8TEimBu+0qpdrE=;
  b=lqbtSawUacLu+EBwU3J/l/zCaiy77S325+RBkOyiTAqTHWrly9gChCyJ
   gnmK0nWkUmoIas5scAn4BopDsb6HY3NN3q70Ky72xJxc8XdBEjYxSx2zx
   pfiMXf+ldXlWZVl1rxpzah+7jj329dv/7V0Z/grIPiqGw/jmffu2cEmFW
   xirxUlHIoqGst0S4RGXf4SoPhd6iLY91c1C+cKDPWaZT2dvXd/pv8X612
   4emL7DVboi/A/UC0rvFyMlTzAYuyO/Nc6PF8tQ0JAYOJPfZa9I+dzTfF7
   ZocXAKi+EvptGKFTphlYcJZJy12GFfv9INSToUxx7O7QM+1F0J+8C2PLs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="380743620"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="380743620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786921899"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="786921899"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Oct 2023 03:42:54 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qoLoi-000LJS-2I;
	Thu, 05 Oct 2023 10:42:52 +0000
Date: Thu, 5 Oct 2023 18:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Shenwei Wang <shenwei.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Mario Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
Message-ID: <202310051811.Rltsgr8J-lkp@intel.com>
References: <20231004195442.414766-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004195442.414766-1-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shenwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenwei-Wang/net-stmmac-dwmac-imx-request-high-frequency-mode/20231005-035606
base:   net/main
patch link:    https://lore.kernel.org/r/20231004195442.414766-1-shenwei.wang%40nxp.com
patch subject: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231005/202310051811.Rltsgr8J-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310051811.Rltsgr8J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310051811.Rltsgr8J-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:9:10: fatal error: linux/busfreq-imx.h: No such file or directory
       9 | #include <linux/busfreq-imx.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +9 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c

   > 9	#include <linux/busfreq-imx.h>
    10	#include <linux/clk.h>
    11	#include <linux/gpio/consumer.h>
    12	#include <linux/kernel.h>
    13	#include <linux/mfd/syscon.h>
    14	#include <linux/module.h>
    15	#include <linux/of.h>
    16	#include <linux/of_net.h>
    17	#include <linux/phy.h>
    18	#include <linux/platform_device.h>
    19	#include <linux/pm_wakeirq.h>
    20	#include <linux/regmap.h>
    21	#include <linux/slab.h>
    22	#include <linux/stmmac.h>
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

