Return-Path: <netdev+bounces-43934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE47D57C9
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E663F1C20BCB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E72E62F;
	Tue, 24 Oct 2023 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iapgXHGF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E1266C4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:17:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E98118
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698164236; x=1729700236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vU6NUxn0dSy8CYFpKW21RatM/5zlQn8ad7r9qtdb8U4=;
  b=iapgXHGFcwqgC4c37OBq9E2w3Sz/ff+2brfdMDtKdseSzRncxgqXIPc+
   g6bMFlbFV88i8nmbY8vRe3ARtOD9TrddcsB7x3DRj7WijkSb3P8q5wPFV
   77v30zoYGPqF4hpXUuPrefABxuy06thsZuYBK4R1QWzeiAHy9qVMIz7kO
   6YoSHRcNJsNI5Ou056gbUXxfj4hMbjVPdDc7btsmiq32gebo+iM3o3hn1
   zSTRh0BBrhgTRbadDHxLQMjLf0kbN6vuQax9MVp/R6b861Rh1i4dMLIbV
   DlzUV1AQgVBysaUlbgxeef5aZTbGnx1QYlhgAQbvJ9kiqrq/piM4emiAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5725474"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="5725474"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="735081789"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="735081789"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2023 09:17:10 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qvK5b-00081n-38;
	Tue, 24 Oct 2023 16:17:07 +0000
Date: Wed, 25 Oct 2023 00:16:18 +0800
From: kernel test robot <lkp@intel.com>
To: Shenwei Wang <shenwei.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
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
Message-ID: <202310250045.xYg3qn6G-lkp@intel.com>
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

Hi Shenwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenwei-Wang/net-stmmac-dwmac-imx-request-high-frequency-mode/20231005-035606
base:   net/main
patch link:    https://lore.kernel.org/r/20231004195442.414766-1-shenwei.wang%40nxp.com
patch subject: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231025/202310250045.xYg3qn6G-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310250045.xYg3qn6G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310250045.xYg3qn6G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:9:10: fatal error: 'linux/busfreq-imx.h' file not found
   #include <linux/busfreq-imx.h>
            ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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

