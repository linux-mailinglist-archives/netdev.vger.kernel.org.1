Return-Path: <netdev+bounces-142628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BA9BFC9A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B3F1F21594
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004D539FD9;
	Thu,  7 Nov 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jg7vVZdL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45766AA7;
	Thu,  7 Nov 2024 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947077; cv=none; b=RB8KIvVxLp3KodJUdDUVPr3u4holTijRKuOK99byhLw4QS3bQMBYjctqsjsZuOsDh+lQkgnAehfnJbENuG6J/XKaLduN/+KZHjmKFVGIH1DHTdkPgI5nXNDp8ymWlDOTAhCYWmk/qUZPp5J3bJNNnrXxZWC+TsBR3I3OS9wec/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947077; c=relaxed/simple;
	bh=0Rbco+fVVE+WKrntisQUqv4Xf3VKHufAddMWQTy1UOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+fHKjA2Y4nS0YZwPmA6u1aoXfHctzqskovQSIFIaSbPqY2JdSf/OjKY6ez1mR0OhG61q6wjo0kTsMfNwzsifVjxkYy0Un6ATH6lfoLpIPELMu6/SKoWXJFiNLQT43Ih+GRDyrI5ynhqcBpGxHSKl4H8TPsroIp4DbAyKbZPW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jg7vVZdL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730947075; x=1762483075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Rbco+fVVE+WKrntisQUqv4Xf3VKHufAddMWQTy1UOo=;
  b=jg7vVZdLVtNmvYwDqmyD8evKoc3n7kK2dE7fqnRI/JcWBa4jdZBC9RTB
   9PVYh+D8+CIQsgKiIDkg9S2yHtjSLns0S++PWXjgPTN/jdNYP+FQ9yxXG
   xY9NmV8FYov9F0NZaMPvnuH3PA0ONsg0H50/88xAIX7UReaHlxHotv8gh
   /kk96Kqs+1pSSD+vIEb1/+UBV3i1kYZrrP2Ft/qgsO0Cq41Wi9zJv4Wxx
   9/xHr7A7WTcJvPm7mmfHkLOvk3scr9bvsi0Djf+s5IQ3TmJd6IcCNsHNG
   sqVJvVanvvcaN1n3ZsSL6IqsbfFgrgjh3AIn6o8HJcuBeeGc5+DPTmh3p
   g==;
X-CSE-ConnectionGUID: SSMS/GE4Soi3K1O+a0W5eQ==
X-CSE-MsgGUID: sf6UiSQCSfqzfq+Yyh4cqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34695256"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="34695256"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 18:37:54 -0800
X-CSE-ConnectionGUID: H0tfHc/KTCOBcpT2EROUpg==
X-CSE-MsgGUID: Y25ZMZNcQteAno0NZmlSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="90004633"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 18:37:49 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8sP4-000phm-2P;
	Thu, 07 Nov 2024 02:37:46 +0000
Date: Thu, 7 Nov 2024 10:37:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <202411071000.uL10bu3r-lkp@intel.com>
References: <20241106122254.13228-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106122254.13228-4-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-net-dsa-Add-Airoha-AN8855-Gigabit-Switch-documentation/20241106-203624
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241106122254.13228-4-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241107/202411071000.uL10bu3r-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411071000.uL10bu3r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411071000.uL10bu3r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/air_an8855.c:6:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/air_an8855.c:137:6: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     137 |         if (saved_page >= 0)
         |             ^~~~~~~~~~~~~~~
   drivers/net/phy/air_an8855.c:139:45: note: uninitialized use occurs here
     139 |         ret = phy_restore_page(phydev, saved_page, val);
         |                                                    ^~~
   drivers/net/phy/air_an8855.c:137:2: note: remove the 'if' if its condition is always true
     137 |         if (saved_page >= 0)
         |         ^~~~~~~~~~~~~~~~~~~~
     138 |                 val = __phy_read(phydev, AN8855_PHY_EXT_REG_14);
   drivers/net/phy/air_an8855.c:133:9: note: initialize the variable 'val' to silence this warning
     133 |         int val;
         |                ^
         |                 = 0
>> drivers/net/phy/air_an8855.c:155:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     155 |         if (saved_page >= 0) {
         |             ^~~~~~~~~~~~~~~
   drivers/net/phy/air_an8855.c:164:46: note: uninitialized use occurs here
     164 |         return phy_restore_page(phydev, saved_page, ret);
         |                                                     ^~~
   drivers/net/phy/air_an8855.c:155:2: note: remove the 'if' if its condition is always true
     155 |         if (saved_page >= 0) {
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/air_an8855.c:152:9: note: initialize the variable 'ret' to silence this warning
     152 |         int ret;
         |                ^
         |                 = 0
   6 warnings generated.


vim +137 drivers/net/phy/air_an8855.c

   129	
   130	static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
   131	{
   132		int saved_page;
   133		int val;
   134		int ret;
   135	
   136		saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
 > 137		if (saved_page >= 0)
   138			val = __phy_read(phydev, AN8855_PHY_EXT_REG_14);
   139		ret = phy_restore_page(phydev, saved_page, val);
   140		if (ret)
   141			return ret;
   142	
   143		*data = val & AN8855_PHY_EXT_REG_14 ? DOWNSHIFT_DEV_DEFAULT_COUNT :
   144						      DOWNSHIFT_DEV_DISABLE;
   145	
   146		return 0;
   147	}
   148	
   149	static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
   150	{
   151		int saved_page;
   152		int ret;
   153	
   154		saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
 > 155		if (saved_page >= 0) {
   156			if (cnt != DOWNSHIFT_DEV_DISABLE)
   157				ret = __phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
   158						     AN8855_PHY_EN_DOWN_SHFIT);
   159			else
   160				ret = __phy_clear_bits(phydev, AN8855_PHY_EXT_REG_14,
   161						       AN8855_PHY_EN_DOWN_SHFIT);
   162		}
   163	
   164		return phy_restore_page(phydev, saved_page, ret);
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

