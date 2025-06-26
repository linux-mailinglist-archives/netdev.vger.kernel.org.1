Return-Path: <netdev+bounces-201369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49219AE933B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2331C27AC2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7A13B58D;
	Thu, 26 Jun 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnfROHME"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011F73451;
	Thu, 26 Jun 2025 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896471; cv=none; b=tXdifgbu2JlOzGu8rLmyI8IqcGMUA3RwtOIkXtKmmJjyNUkqCzwsOYZzax15DxNX0fAJHc7VSuBpBUb+7vSWSvoF9ZxBW/ie8vkUabWgLiGrliwFg4L+yl8S+vmj5WfkUolXrv/roFq2fZAF9yt5hsbfuZCb/5eNBJ31FZTQJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896471; c=relaxed/simple;
	bh=C3hz+TTEceJ65LIM6563d2BqKNpBHkLD6nboo3kPOXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDtRI8n7wDKYKzq9Lv4BoU91b0xGajmaU82Urj+DAJwL6xvJ0VSKBCtlpCRw+kM3wDrjVvqplNLvvIeacNEiEk/RY9cmZAA3pYulMzrBXTu97vctylik9fsRuaokiR4tarSXUAgXt+c/j8U96ZCyx+kwZNb72/g2aSK7cMcVv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnfROHME; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750896470; x=1782432470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C3hz+TTEceJ65LIM6563d2BqKNpBHkLD6nboo3kPOXo=;
  b=PnfROHMEoGlNKTRBddhXL2L1fgI5f//IX/vHvQxJc8PVXYkDHz3l3S+l
   pnN1xDNR2x9QSQBq2mDz7QKojQwKgF0PhP3TSVGcTgGqyr0ceYgVSIsfl
   5WkJQftCEwnn81C0sMn/TL6tLfORwwZDm6NCiAWtmaztm/A58XuSstQyk
   sZD8hfldMK5KY6xboAoXysCoOCRFC9m1XdT/3Ustpt7fVSb3wRFJk70ci
   UOCYhfV71ZIWiq8YkSDvtnbJXxT72fsFUY/Zmc++5yKWYtNaMjSQ/MN1w
   RFmv/o3H1Dulk3m3m0emO1kYKMJdg0IPLwAh6ldAvefG0Q9Efy4CN2qWJ
   Q==;
X-CSE-ConnectionGUID: lzf7WiPSRSGi6xQWZ+/dag==
X-CSE-MsgGUID: kzJia0nLQYiv8+3wu4ps0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52904175"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="52904175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 17:07:50 -0700
X-CSE-ConnectionGUID: plp4ybH+QhCL0Ta6GYKqGQ==
X-CSE-MsgGUID: fg5ZsG4xT0WtUFO3hx3AFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157858423"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 17:07:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUa9Y-000TYc-09;
	Thu, 26 Jun 2025 00:07:44 +0000
Date: Thu, 26 Jun 2025 08:07:02 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
Message-ID: <202506260756.KhOdmLCy-lkp@intel.com>
References: <20250625124127.4176960-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625124127.4176960-1-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/phy-micrel-add-Signal-Quality-Indicator-SQI-support-for-KSZ9477-switch-PHYs/20250625-204330
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250625124127.4176960-1-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality Indicator (SQI) support for KSZ9477 switch PHYs
config: i386-buildonly-randconfig-004-20250626 (https://download.01.org/0day-ci/archive/20250626/202506260756.KhOdmLCy-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506260756.KhOdmLCy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506260756.KhOdmLCy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/micrel.c:2247:5: warning: variable 'channels' set but not used [-Wunused-but-set-variable]
    2247 |         u8 channels;
         |            ^
   1 warning generated.


vim +/channels +2247 drivers/net/phy/micrel.c

  2231	
  2232	/**
  2233	 * kszphy_get_sqi - Read, average, and map Signal Quality Index (SQI)
  2234	 * @phydev: the PHY device
  2235	 *
  2236	 * This function reads and processes the raw Signal Quality Index from the
  2237	 * PHY. Based on empirical testing, a raw value of 8 or higher indicates a
  2238	 * pre-failure state and is mapped to SQI 0. Raw values from 0-7 are
  2239	 * mapped to the standard 0-7 SQI scale via a lookup table.
  2240	 *
  2241	 * Return: SQI value (0–7), or a negative errno on failure.
  2242	 */
  2243	static int kszphy_get_sqi(struct phy_device *phydev)
  2244	{
  2245		int sum = 0;
  2246		int i, val, raw_sqi, avg_raw_sqi;
> 2247		u8 channels;
  2248	
  2249		/* Determine applicable channels based on link speed */
  2250		if (phydev->speed == SPEED_1000)
  2251			/* TODO: current SQI API only supports 1 channel. */
  2252			channels = 1;
  2253		else if (phydev->speed == SPEED_100)
  2254			channels = 1;
  2255		else
  2256			return -EOPNOTSUPP;
  2257	
  2258		/*
  2259		 * Sample and accumulate SQI readings for each pair (currently only one).
  2260		 *
  2261		 * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
  2262		 * - The SQI register is updated every 2 µs.
  2263		 * - Values may fluctuate significantly, even in low-noise environments.
  2264		 * - For reliable estimation, average a minimum of 30–50 samples
  2265		 *   (recommended for noisy environments)
  2266		 * - In noisy environments, individual readings are highly unreliable.
  2267		 *
  2268		 * We use 40 samples per pair with a delay of 3 µs between each
  2269		 * read to ensure new values are captured (2 µs update interval).
  2270		 */
  2271		for (i = 0; i < KSZ9477_SQI_SAMPLE_COUNT; i++) {
  2272			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
  2273					   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A);
  2274			if (val < 0)
  2275				return val;
  2276	
  2277			raw_sqi = FIELD_GET(KSZ9477_MMD_SQI_MASK, val);
  2278			sum += raw_sqi;
  2279	
  2280			udelay(KSZ9477_MMD_SQI_READ_DELAY_US);
  2281		}
  2282	
  2283		avg_raw_sqi = sum / KSZ9477_SQI_SAMPLE_COUNT;
  2284	
  2285		/* Handle the pre-fail/failed state first. */
  2286		if (avg_raw_sqi >= ARRAY_SIZE(ksz_sqi_mapping))
  2287			return 0;
  2288	
  2289		/* Use the lookup table for the good signal range. */
  2290		return ksz_sqi_mapping[avg_raw_sqi];
  2291	}
  2292	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

