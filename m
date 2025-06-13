Return-Path: <netdev+bounces-197521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D695BAD9028
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9713A3B83AF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228E19FA93;
	Fri, 13 Jun 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3sOHVTr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704C9444;
	Fri, 13 Jun 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826313; cv=none; b=gWf8OINN49QtwFFu8alNq/OZV1tLSTVqH5esf4iaWRx6OXiSvaQfdWHm08+qYB0qcR5U70kA964zAuLNDm0T4N/kJu3iMTbMSzPpMn3hxvnjvWhT+XVQUxhu+8cL9RQvPuWEo+HjAYPlZKnnGU88P3B/b/ulI5sODxzpVW9NvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826313; c=relaxed/simple;
	bh=uE0ZDwVkukg/QxjYkXVtj4KHDh7Mopm+MTwTfQzQK6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kshckPI/FkHLebbBHxNqPNgTBc9u6g7+bJuGUDa3m3s8IKoOWboE4Y4AE3d1e5mcz8t7uFBAzKSnnljue0QtKfj9EBFkq4iJ4QdUlImm4e1q8PjwLqf+bIDdkMjk8ytlcN7WLolUWypBt2c9KW9Mtx166bzmGkbSar2a5Ygz69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3sOHVTr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749826311; x=1781362311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uE0ZDwVkukg/QxjYkXVtj4KHDh7Mopm+MTwTfQzQK6E=;
  b=G3sOHVTr6ZyjDJs3R9LKFjg66VB6vu9nSQCxkeTds16IcseEDgMnH8XI
   AOy+p3G74+CVYuR7RVdBYyz3nwVjcmpHoz0Radi7X+5mLenW38DDT4BHz
   krXiP2GZG9YywFTTrb00M5rr7S8bYCmEry91eti13UTBIFYGnM5vWyfKn
   k6a50fpZsvcSSbwddXnTwGBe8bfyd6dvvqFs0upvtFxLY9npdnYTWGuzN
   7tLfkBw7qW5JDTosZvynNEPq2vBudH6mVy1UxBDhuceodVLyeBmj47A3w
   AVu28sM3ftaB7syus2hEMWt2MYjr8PCiq2RYa/wqRWbMIhE9txc9eGxSY
   Q==;
X-CSE-ConnectionGUID: Lc4Nij40SZOq8R/9jqdZbw==
X-CSE-MsgGUID: 8F4kckI1QBa5eSLbuCpBCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52192246"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52192246"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:51:51 -0700
X-CSE-ConnectionGUID: kh3lcKhgT6KCXynKXf8Keg==
X-CSE-MsgGUID: FiP3cSsoQ5CGmvHLgaAtiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148392187"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Jun 2025 07:51:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ5kt-000Cic-1d;
	Fri, 13 Jun 2025 14:51:43 +0000
Date: Fri, 13 Jun 2025 22:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [net-next PATCH v6 09/10] net: macb: Support external PCSs
Message-ID: <202506132226.hNuGyG9l-lkp@intel.com>
References: <20250610233642.3588414-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610233642.3588414-1-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250611-143544
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250610233642.3588414-1-sean.anderson%40linux.dev
patch subject: [net-next PATCH v6 09/10] net: macb: Support external PCSs
config: xtensa-randconfig-r062-20250613 (https://download.01.org/0day-ci/archive/20250613/202506132226.hNuGyG9l-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250613/202506132226.hNuGyG9l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506132226.hNuGyG9l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/cadence/macb_main.c:24:
   include/linux/pcs.h: In function 'pcs_get_by_fwnode_compat':
   include/linux/pcs.h:201:16: error: implicit declaration of function '_pcs_get_tail' [-Werror=implicit-function-declaration]
     201 |         return _pcs_get_tail(dev, fwnode, NULL);
         |                ^~~~~~~~~~~~~
>> include/linux/pcs.h:201:16: warning: returning 'int' from a function with return type 'struct phylink_pcs *' makes pointer from integer without a cast [-Wint-conversion]
     201 |         return _pcs_get_tail(dev, fwnode, NULL);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +201 include/linux/pcs.h

56201bc1ac71fc Sean Anderson 2025-06-10  187  
56201bc1ac71fc Sean Anderson 2025-06-10  188  #ifdef CONFIG_OF_DYNAMIC
56201bc1ac71fc Sean Anderson 2025-06-10  189  struct phylink_pcs *
56201bc1ac71fc Sean Anderson 2025-06-10  190  pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
56201bc1ac71fc Sean Anderson 2025-06-10  191  			 int (*fixup)(struct of_changeset *ocs,
56201bc1ac71fc Sean Anderson 2025-06-10  192  				      struct device_node *np, void *data),
56201bc1ac71fc Sean Anderson 2025-06-10  193  			 void *data);
56201bc1ac71fc Sean Anderson 2025-06-10  194  #else
56201bc1ac71fc Sean Anderson 2025-06-10  195  static inline struct phylink_pcs *
56201bc1ac71fc Sean Anderson 2025-06-10  196  pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
56201bc1ac71fc Sean Anderson 2025-06-10  197  			 int (*fixup)(struct of_changeset *ocs,
56201bc1ac71fc Sean Anderson 2025-06-10  198  				      struct device_node *np, void *data),
56201bc1ac71fc Sean Anderson 2025-06-10  199  			 void *data)
56201bc1ac71fc Sean Anderson 2025-06-10  200  {
56201bc1ac71fc Sean Anderson 2025-06-10 @201  	return _pcs_get_tail(dev, fwnode, NULL);
56201bc1ac71fc Sean Anderson 2025-06-10  202  }
56201bc1ac71fc Sean Anderson 2025-06-10  203  #endif
56201bc1ac71fc Sean Anderson 2025-06-10  204  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

