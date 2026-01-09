Return-Path: <netdev+bounces-248328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BEDD06FA6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D47CD3011189
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F322423A;
	Fri,  9 Jan 2026 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWoZG2fl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610214A0BC;
	Fri,  9 Jan 2026 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929003; cv=none; b=PChL50As1wgHUOjkELKEFPKgXDBUi0uZtxrw6eN27+eGofx8TsL+6b/gfXGL3SfRHDJgvYjJQUcp7KZcJjCItwi86yG2Otvc87CWsRMqgxkxQ2SvihyBNSKBVAA798wz88vvUB2DruXNgUU5Ys0Yy2tQDD3BABjoHtNCrdTFntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929003; c=relaxed/simple;
	bh=iIJcmF0XXRvZOmAjjdIxNRX4M7iM2qspisZDE0dYE8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2ih/Br8rSbCd9oq3R8+HmTCuPMQiYyPii8up/KxWNf1T5HklYdUZcB5mfVlLeFVGqFq4dWA/gDepqfo5mY1fw63R7/bW8g827G1CTupHL9A0+HTIMMTOu2g/3ba7tzTL8UQ2Kpk0LDWs9qdZvT+336Ke4GIpP2S3HsEeRgo40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWoZG2fl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767929002; x=1799465002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iIJcmF0XXRvZOmAjjdIxNRX4M7iM2qspisZDE0dYE8Y=;
  b=UWoZG2flgBl75sGdwMBlzHbzqfgmz520r5QiFICM+buMnJWrn3RaPcXs
   SpjgZAulSxCIbnSMUNSf4/ODFSsGCHVo2Rexp9YM/6c9KRGMTBhv0//R4
   0n/SWaOZZm1Y5ns5fV41WoCt/0Az8h+OxQcTUk0AhuUrOEcotGKuSY31B
   wyLJ6wj6YIkPkOHXtXeySShClXbysoyutJdyoGRDPqMyOKDsbRL1nR0r5
   qjHk8hat4KIS1y1qP9FBihFUPs+Zut6NZHPky+jlAloFyuB1xLtHPpMkz
   dMeQ1y3GLxjU+WuPY/KPPCslfyjBwV7cddTu2e2bjjOCyzsk7+SmYOoaI
   A==;
X-CSE-ConnectionGUID: 310M31EMRVa/iaqtVbMDIQ==
X-CSE-MsgGUID: RaVP4usRTuOFo9zmEfKLJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69471305"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69471305"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 19:23:22 -0800
X-CSE-ConnectionGUID: GA3G+sabT4qGuRgDhaBJ2Q==
X-CSE-MsgGUID: Z6E9GJUcRyek3y7V7nNbxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207900137"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 08 Jan 2026 19:23:17 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ve35m-000000001wa-3Fbo;
	Fri, 09 Jan 2026 03:23:14 +0000
Date: Fri, 9 Jan 2026 04:22:27 +0100
From: kernel test robot <lkp@intel.com>
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, huangdonghua3@h-partners.com,
	yangshuaisong@h-partners.com, lantao5@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaojijie@huawei.com
Subject: Re: [PATCH net-next] net: phy: change of_phy_leds() to
 fwnode_phy_leds()
Message-ID: <202601090427.Duo7dPR0-lkp@intel.com>
References: <20260108073405.3036482-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108073405.3036482-1-shaojijie@huawei.com>

Hi Jijie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jijie-Shao/net-phy-change-of_phy_leds-to-fwnode_phy_leds/20260108-153742
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260108073405.3036482-1-shaojijie%40huawei.com
patch subject: [PATCH net-next] net: phy: change of_phy_leds() to fwnode_phy_leds()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260109/202601090427.Duo7dPR0-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260109/202601090427.Duo7dPR0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601090427.Duo7dPR0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy_device.c:3291:31: warning: unused variable 'led' [-Wunused-variable]
    3291 |         struct fwnode_handle *leds, *led;
         |                                      ^~~
   1 warning generated.


vim +/led +3291 drivers/net/phy/phy_device.c

  3287	
  3288	static int fwnode_phy_leds(struct phy_device *phydev)
  3289	{
  3290		struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
> 3291		struct fwnode_handle *leds, *led;
  3292		int err;
  3293	
  3294		if (!fwnode)
  3295			return 0;
  3296	
  3297		leds = fwnode_get_named_child_node(fwnode, "leds");
  3298		if (!leds)
  3299			return 0;
  3300	
  3301		/* Check if the PHY driver have at least an OP to
  3302		 * set the LEDs.
  3303		 */
  3304		if (!(phydev->drv->led_brightness_set ||
  3305		      phydev->drv->led_blink_set ||
  3306		      phydev->drv->led_hw_control_set)) {
  3307			phydev_dbg(phydev, "ignoring leds node defined with no PHY driver support\n");
  3308			goto exit;
  3309		}
  3310	
  3311		fwnode_for_each_available_child_node_scoped(leds, led) {
  3312			err = fwnode_phy_led(phydev, led);
  3313			if (err) {
  3314				fwnode_handle_put(leds);
  3315				phy_leds_unregister(phydev);
  3316				return err;
  3317			}
  3318		}
  3319	
  3320	exit:
  3321		fwnode_handle_put(leds);
  3322		return 0;
  3323	}
  3324	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

