Return-Path: <netdev+bounces-213176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA2B23FDF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BE91B6628A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D72BE039;
	Wed, 13 Aug 2025 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmB21kcX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CE2BDC3E;
	Wed, 13 Aug 2025 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060377; cv=none; b=nICbCyiqIESnpP45bL6KSy3oNmCsC6U9RK7KGXFL73be8XOerK+JoVo4o7B1Rj/NIzpsMMRi16IKCZIyuTWZ7iAB7fOYyRnq/N7IXV3xv4UOkOzK7W8SuS2RmmFiVYDBHsskunrs7lwrCBYWo4LHn4p+oX5Zx1HpQ8DWD/3nJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060377; c=relaxed/simple;
	bh=CNCPr3061lzFu/y/M0rHp79zv5MIDNX8YMnD5Ix53Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLGQ0aaWWkbgKjzvkmScO6hXuTZ9breVJKUh7jMa1cCtiVgBmJcAr5vFUhyL+l1L3H/TlBiepyb4FpMfKrCyyPEGsGc2bEbxDpk4IN/JL7IhRVuxoF3Gzsz/PL1YhU7yGeKcav1Jd5WkahLJQavbsJngpH1WiJTl0wpzRMXm7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmB21kcX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755060375; x=1786596375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CNCPr3061lzFu/y/M0rHp79zv5MIDNX8YMnD5Ix53Jo=;
  b=NmB21kcXpnILhp3s4NlKKq5K7bseKLgG47aqhATHKiKsD8tuwCjNLfn+
   qm4WippDEITbVfhkwluUkaoupFsOdMBtbMy0NEUFuCAgH/38FHtJWIIuj
   k2bf6zoptj7LMkWjM+bFD5lNI/PiLPFLVscExMyfhto9wXesEUHDDOgGI
   cnUGUdnOVFyjY+iditLAOwiKTGIsFstHoIpGxf7xo7UN+jqE5x0rElpT2
   E5Xs77NiwRJ1PCRyyi+5/SUJSvol9xo44EjJfmxJAKs/sP61s0OPs2hqL
   o2fPuGtZjLRG7pD4sXVP5u/RPvZbfdl4IknrBWCiL5FxYfhqg80qtbv6c
   Q==;
X-CSE-ConnectionGUID: Ylcc0oXLSQ2PbymArTcNEw==
X-CSE-MsgGUID: ieOBbSHlTpWWEhrVmXFBKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56553157"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56553157"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 21:46:14 -0700
X-CSE-ConnectionGUID: 73YJIUzuTVOR1yb0seCTWw==
X-CSE-MsgGUID: z+eiv8i/SgKgheRVY/VAhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170573343"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 21:46:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um3NG-0009XE-2t;
	Wed, 13 Aug 2025 04:46:06 +0000
Date: Wed, 13 Aug 2025 12:45:38 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Message-ID: <202508131032.BQJ5m6ky-lkp@intel.com>
References: <20250812094634.489901-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-5-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-ptp-add-NETC-Timer-PTP-clock/20250812-181510
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250812094634.489901-5-wei.fang%40nxp.com
patch subject: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20250813/202508131032.BQJ5m6ky-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508131032.BQJ5m6ky-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131032.BQJ5m6ky-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ptp/ptp_netc.c: In function 'netc_timer_get_reference_clk_source':
>> drivers/ptp/ptp_netc.c:365:45: warning: left shift count >= width of type [-Wshift-count-overflow]
     365 |         priv->period = div_u64(NSEC_PER_SEC << 32, priv->clk_freq);
         |                                             ^~


vim +365 drivers/ptp/ptp_netc.c

   333	
   334	static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
   335	{
   336		struct device *dev = &priv->pdev->dev;
   337		struct clk *clk;
   338		int i;
   339	
   340		/* Select NETC system clock as the reference clock by default */
   341		priv->clk_select = NETC_TMR_SYSTEM_CLK;
   342		priv->clk_freq = NETC_TMR_SYSCLK_333M;
   343	
   344		/* Update the clock source of the reference clock if the clock
   345		 * is specified in DT node.
   346		 */
   347		for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
   348			clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
   349			if (IS_ERR(clk))
   350				return PTR_ERR(clk);
   351	
   352			if (clk) {
   353				priv->clk_freq = clk_get_rate(clk);
   354				priv->clk_select = i ? NETC_TMR_EXT_OSC :
   355						       NETC_TMR_CCM_TIMER1;
   356				break;
   357			}
   358		}
   359	
   360		/* The period is a 64-bit number, the high 32-bit is the integer
   361		 * part of the period, the low 32-bit is the fractional part of
   362		 * the period. In order to get the desired 32-bit fixed-point
   363		 * format, multiply the numerator of the fraction by 2^32.
   364		 */
 > 365		priv->period = div_u64(NSEC_PER_SEC << 32, priv->clk_freq);
   366	
   367		return 0;
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

