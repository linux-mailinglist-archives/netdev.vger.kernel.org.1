Return-Path: <netdev+bounces-170332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA9A482F9
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9D3B3787
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576613AA5D;
	Thu, 27 Feb 2025 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7o5+hwe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738B2222BA
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670280; cv=none; b=iZf6DY3sXJ9MEMtnB1ese8Z5oooFGZQN7Q67WtOLM2pbKbJ+RsqrzBe1dlqwtW2KZwkKJPkyMyK9SUA9RBtd8FHHna8LnuEHNEiugKfXRgJxNjv77DHkCY7jit9d+VHH3T4GzleYWKDW+XpUdRtImTzuwFRk4FVWp6n8vPFebTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670280; c=relaxed/simple;
	bh=8nn4JeTVgl99RbEnJwQaRq9PrAd4wl3f/dCMNIpJdpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8PqnAKSdK1bgjUOcRY0NtEUw9KOTr8n+FemSj0kqnHXmKuDGddNWgsFxBglj1UK66OgLDcO5Lgx4TujfHd7gTrslI0lxNs8lo7i5buGt+EamZNFaGLToGFeSCYtyX5vV9gSRvr72AKAKPfoQ9gT1ZwkYhmnfU1pYHyPv72BJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7o5+hwe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740670279; x=1772206279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8nn4JeTVgl99RbEnJwQaRq9PrAd4wl3f/dCMNIpJdpI=;
  b=H7o5+hwekUKfwSh5mZdkjmxsDObVLT0dMTHB2lG2Fh+TptC2A8eSbiPT
   h9PFRNVZZ4JX26SSDX7MK3vz1d2fhQnWiTVz7IZdnpH8rQBEWY7ImFI5A
   9vUwBW1FFZABIVJGWy5HCtcZKuyU7qSPn5R3q2WtDF94BIg699TNoj6m3
   1zfCc1WUYxF2cVD30a482o6qef/hlHrqNvuJQ8kEaDbFlQsH3WJfXwVkP
   +rUguZPcqfXMh8rmz7brUxf+Ob3Yfva+YDDv0jrKU36DqvS9l4AmSBtiY
   jHa0PHRaixSCgKEWVoNUOTLnibfvagxGsWoLWlKeZPK2Xtw1QGWqa5q9g
   g==;
X-CSE-ConnectionGUID: vpCEEAJbSwKslaFpIgAwVQ==
X-CSE-MsgGUID: 9KJO6/3URzO2urUvHgbaOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52976757"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52976757"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:31:18 -0800
X-CSE-ConnectionGUID: 4IoEK63oQZW6Il8nQ7dNTQ==
X-CSE-MsgGUID: AH6evKc0SPmSI3MQqOVYLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117079478"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2025 07:31:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnfqy-000DaW-2Q;
	Thu, 27 Feb 2025 15:31:12 +0000
Date: Thu, 27 Feb 2025 23:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v8 6/8] net: selftests: Support selftest sets
Message-ID: <202502272355.8SzfMboW-lkp@intel.com>
References: <20250224211531.115980-7-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224211531.115980-7-gerhard@engleder-embedded.com>

Hi Gerhard,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerhard-Engleder/net-phy-Allow-loopback-speed-selection-for-PHY-drivers/20250225-103125
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250224211531.115980-7-gerhard%40engleder-embedded.com
patch subject: [PATCH net-next v8 6/8] net: selftests: Support selftest sets
config: sh-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502272355.8SzfMboW-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272355.8SzfMboW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272355.8SzfMboW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/usb/smsc95xx.c:25:
>> include/net/selftests.h:48:55: error: 'void' must be the only parameter
      48 | static inline int net_selftest_set_get_count(int set, void)
         |                                                       ^~~~


vim +/void +48 include/net/selftests.h

    47	
  > 48	static inline int net_selftest_set_get_count(int set, void)
    49	{
    50		return 0;
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

