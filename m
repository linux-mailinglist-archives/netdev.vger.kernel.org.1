Return-Path: <netdev+bounces-40025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C57C56F2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CEE1C20D86
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF114264;
	Wed, 11 Oct 2023 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqqUeYLo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FC208A8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:36:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6579D;
	Wed, 11 Oct 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697034963; x=1728570963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMysvAu4HmtiroPGPpdiHPdQSFqPeu7h59Zw9qgde50=;
  b=FqqUeYLoPVYlq3kHHSRA9rZIxGP5TcHBw58t61HD8izTUMgeycfi0wCE
   waQXrOXCrzziXnpqGgtN7O06nGgpebgCSEA8bfkOdj9xiUuJ/ueCHMa3c
   MEO8+OhPy+lnp2cFXyQDOaXvLn6VPzqDWvL5e8a7GhwrtitZm5t+4pR9x
   +u0NyoS/REvbPUdi6jSmg9SdJQ3MCiSs5HQbEFnfZzcx6sbcJ1odAZYpu
   xkXtw6hmykOY6ExA98e8PIHNrjuBAqRg2yfwQ+AUcooxHHU7Kx6XVrTuD
   jZKc7VHAWwM/1pGFfe29jl4Ym4tKf0jFYsIH2m5pie6R3xdnqiyLKB6uH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383543388"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="383543388"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="757586628"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="757586628"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2023 07:35:52 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqaJQ-0002K3-21;
	Wed, 11 Oct 2023 14:35:48 +0000
Date: Wed, 11 Oct 2023 22:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: ksz8: Enable MIIM
 PHY Control reg access
Message-ID: <202310112224.iYgvjBUy-lkp@intel.com>
References: <20231011123856.1443308-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011123856.1443308-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/net-dsa-microchip-ksz8-Enable-MIIM-PHY-Control-reg-access/20231011-204502
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231011123856.1443308-2-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v1 2/3] net: dsa: microchip: ksz8: Enable MIIM PHY Control reg access
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310112224.iYgvjBUy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310112224.iYgvjBUy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310112224.iYgvjBUy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/microchip/ksz8795.c:646: warning: Function parameter or member 'val' not described in 'ksz8_r_phy_ctrl'


vim +646 drivers/net/dsa/microchip/ksz8795.c

   634	
   635	/**
   636	 * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a MIIM PHY
   637	 *		     Control register (Reg. 31).
   638	 * @dev: The KSZ device instance.
   639	 * @port: The port number to be read.
   640	 *
   641	 * This function reads the SMI interface and translates the hardware register
   642	 * bit values into their corresponding control settings for a MIIM PHY Control
   643	 * register.
   644	 */
   645	static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)
 > 646	{
   647		const u16 *regs = dev->info->regs;
   648		u8 reg_val;
   649		int ret;
   650	
   651		*val = 0;
   652	
   653		ret = ksz_pread8(dev, port, regs[P_LINK_STATUS], &reg_val);
   654		if (ret < 0)
   655			return ret;
   656	
   657		if (reg_val & PORT_MDIX_STATUS)
   658			*val |= KSZ886X_CTRL_MDIX_STAT;
   659	
   660		ret = ksz_pread8(dev, port, REG_PORT_LINK_MD_CTRL, &reg_val);
   661		if (ret < 0)
   662			return ret;
   663	
   664		if (reg_val & PORT_FORCE_LINK)
   665			*val |= KSZ886X_CTRL_FORCE_LINK;
   666	
   667		if (reg_val & PORT_POWER_SAVING)
   668			*val |= KSZ886X_CTRL_PWRSAVE;
   669	
   670		if (reg_val & PORT_PHY_REMOTE_LOOPBACK)
   671			*val |= KSZ886X_CTRL_REMOTE_LOOPBACK;
   672	
   673		return 0;
   674	}
   675	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

