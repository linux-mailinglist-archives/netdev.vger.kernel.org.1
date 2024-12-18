Return-Path: <netdev+bounces-152851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC559F6029
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0548B188DA95
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6C165F18;
	Wed, 18 Dec 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcLRuGsZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696BC1607B4;
	Wed, 18 Dec 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510810; cv=none; b=P1fH3k2kFYzNU5tXTolZmyiphVbNEiy7rVc88286hY+e4W4sDAFgzV578Rs+7fpUnD00tIEyYpiS8Jh1w9SodLp6IeSWb9J1IudZEuqa5/QIhxTjC45YkdKH9/0ObH2YzkrB6SvKQnHBgOccDG7jyDxe+zIE0feg4K83GjUuN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510810; c=relaxed/simple;
	bh=awQyJfyXWCoQxbbBwzUfL+n7Fr+Crs0prjb5pWJy2KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKtAUXuoaa+zL4RUu0IGlPE6EQ/zTrAQ8qD8GdblzjMsCZRc8Tj5eguZoCM3oDWHOmcUIPR+Vqx/S3ZsyQMi/wP+JW8h4IWLFbAHZ5Jkhekzl/jRu8TS/3HD6Yiym6yryueh87m5pG8G0rluMA3ETxjIM4qp3esVyYQ8J+CSu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcLRuGsZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734510809; x=1766046809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awQyJfyXWCoQxbbBwzUfL+n7Fr+Crs0prjb5pWJy2KE=;
  b=FcLRuGsZRzDMiqf2V/JZyinOkAuSMM3Nb2XO9kRw/yrYI9jfp9gMh/OU
   sPauz5no1P4Ow4C0mExd/uY/lm0sa8e7I3nZ2au4DMt3x8FECHBBTjpBI
   roNpOnqaL3Uoydun5YEHYbc/QgRuIWdXrNlX8pKa/KbhCAOh/G3eNrP2N
   Ihr4KebDh/kaFG+pGF1+Assb31eky+dE08ChHXhQrSeSksq0oE6/n6PLo
   twTzgb1PRv3eeWVYU9xtio/c9rj/w/b0JPqwKrchfiS//ieU5g1J+hJ9o
   yXt9Hp7iAZJi6sm2Rh2hu1TWFM3cAK8BWUKgCQ3LS3HVCrupFG1dU+9xD
   A==;
X-CSE-ConnectionGUID: HDIfYp4IRTO9sDPQxRaqsg==
X-CSE-MsgGUID: N/8PwXwHRg2yDFQncbJ9OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="45669663"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45669663"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 00:33:27 -0800
X-CSE-ConnectionGUID: gktdEMQcS+erluuaSTQWpA==
X-CSE-MsgGUID: /2v9EbPfRvmQX0pUpgabuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97854971"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Dec 2024 00:33:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNpUf-000GCc-09;
	Wed, 18 Dec 2024 08:33:21 +0000
Date: Wed, 18 Dec 2024 16:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <202412181638.7XsHSwtp-lkp@intel.com>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a14a429069bb1a18eb9fe63d68fcaa77dffe0e23]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/net-phy-dp83822-Add-support-for-PHY-LEDs-on-DP83822/20241217-172305
base:   a14a429069bb1a18eb9fe63d68fcaa77dffe0e23
patch link:    https://lore.kernel.org/r/20241217-dp83822-leds-v1-1-800b24461013%40gmail.com
patch subject: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on DP83822
config: x86_64-buildonly-randconfig-002-20241218 (https://download.01.org/0day-ci/archive/20241218/202412181638.7XsHSwtp-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241218/202412181638.7XsHSwtp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412181638.7XsHSwtp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/dp83822.c:7:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
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
>> drivers/net/phy/dp83822.c:1029:39: warning: use of logical '||' with constant operand [-Wconstant-logical-operand]
    1029 |         if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
         |                                              ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/dp83822.c:1029:39: note: use '|' for a bitwise operation
    1029 |         if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
         |                                              ^~
         |                                              |
   5 warnings generated.


vim +1029 drivers/net/phy/dp83822.c

  1023	
  1024	static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
  1025					      unsigned long *rules)
  1026	{
  1027		int val;
  1028	
> 1029		if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
  1030			val = phy_read_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_MLEDCR);
  1031			if (val < 0)
  1032				return val;
  1033	
  1034			val = FIELD_GET(DP83822_MLEDCR_CFG, val);
  1035		} else {
  1036			val = phy_read_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_LEDCFG1);
  1037			if (val < 0)
  1038				return val;
  1039	
  1040			if (index == DP83822_LED_INDEX_LED_1_GPIO1)
  1041				val = FIELD_GET(DP83822_LEDCFG1_LED1_CTRL, val);
  1042			else
  1043				val = FIELD_GET(DP83822_LEDCFG1_LED3_CTRL, val);
  1044		}
  1045	
  1046		switch (val) {
  1047		case DP83822_LED_FN_LINK:
  1048			*rules = BIT(TRIGGER_NETDEV_LINK);
  1049			break;
  1050		case DP83822_LED_FN_LINK_10_BT:
  1051			*rules = BIT(TRIGGER_NETDEV_LINK_10);
  1052			break;
  1053		case DP83822_LED_FN_LINK_100_BTX:
  1054			*rules = BIT(TRIGGER_NETDEV_LINK_100);
  1055			break;
  1056		case DP83822_LED_FN_FULL_DUPLEX:
  1057			*rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX);
  1058			break;
  1059		case DP83822_LED_FN_TX:
  1060			*rules = BIT(TRIGGER_NETDEV_TX);
  1061			break;
  1062		case DP83822_LED_FN_RX:
  1063			*rules = BIT(TRIGGER_NETDEV_RX);
  1064			break;
  1065		case DP83822_LED_FN_RX_TX:
  1066			*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
  1067			break;
  1068		case DP83822_LED_FN_RX_TX_ERR:
  1069			*rules = BIT(TRIGGER_NETDEV_TX_ERR) | BIT(TRIGGER_NETDEV_RX_ERR);
  1070			break;
  1071		case DP83822_LED_FN_LINK_RX_TX:
  1072			*rules = BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
  1073				 BIT(TRIGGER_NETDEV_RX);
  1074			break;
  1075		default:
  1076			*rules = 0;
  1077			break;
  1078		}
  1079	
  1080		return 0;
  1081	}
  1082	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

