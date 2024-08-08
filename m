Return-Path: <netdev+bounces-117040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F494C75C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659D91F23970
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B871D15FD04;
	Thu,  8 Aug 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THPdx+Jr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964D15F3E6;
	Thu,  8 Aug 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159733; cv=none; b=kDnHkaH4r9SjRF6nAST+WIBsd6OesWwBAaY6wWQjyzuzyoIHs+7j8Y2tq+M/rq0OadZWOD/VgT0eRvl9HVtm5MYy/1msv7/MnUNC+7iyTMAgyrhftivUNJxCh+mXSDY3d8mL7abO+/wOn/1Q5BsyK4Zn7yI2RhrPV3WD5D5pS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159733; c=relaxed/simple;
	bh=7T6z9rkm3U/1nCTIfjEAJ/4vtOZ5BhHQxzLT9IJc17w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNCBPv6b0JqDly/RoZu/RWXGIkbQ8gkrrqhqUTyssBJ0LPRqUBjlBWSsgayQwoZ3E7OSLa9oHmljqUv/sDe6kEjDg+v63DWcVPRGn0UGgPtUIZif5z6CFmOwCLrTX2Af6TNjNSAAHs4ciH9SJJsrFwJFCyWdr/dN4C2G97yUZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THPdx+Jr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723159732; x=1754695732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7T6z9rkm3U/1nCTIfjEAJ/4vtOZ5BhHQxzLT9IJc17w=;
  b=THPdx+JrPdzp9TfCQWpFkPHUMpOqO8ckdmDYMMOryyCx6Rzy/QqQKthR
   /g2TNsCdqgg+dk/fU3QtIXjcmUm92dDDntfEQje92b928P08Z5WLluUqg
   ZOdhuW6AR55RQjAdAjSw5Ikgj33xNoI9qqZZnodycwDxlROoU9veIyR5T
   4LruTFLf2grKkSbqQOho5YpSx8pEeOpfaUnwM9JU9n/MsklXJtzZzlPjq
   EPdrBj9vVIumG3k1dhNVaVPKEYWCPq/Z6rPA5NIad7vcVb0e/HNdvEwLw
   XcH8xrWzK0g1H5kFiJ+I7tsHdHNkycHTP8Z7CA4BxoOHTHg220YKZydUA
   g==;
X-CSE-ConnectionGUID: l41sCSFRTnWhKcb8GUV/bg==
X-CSE-MsgGUID: heP67PfmRMSpRu+chhDp8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38825987"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38825987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 16:28:51 -0700
X-CSE-ConnectionGUID: ymqTIQVcR/OjzQXhMSQm1A==
X-CSE-MsgGUID: N+7qjUO6SA6E4bdt8nVHmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57616008"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 08 Aug 2024 16:28:48 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scCYk-0006cU-1Y;
	Thu, 08 Aug 2024 23:28:43 +0000
Date: Fri, 9 Aug 2024 07:28:41 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <202408090754.e4G2nq88-lkp@intel.com>
References: <20240808130833.2083875-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808130833.2083875-3-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/phy-Add-Open-Alliance-helpers-for-the-PHY-framework/20240808-211730
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240808130833.2083875-3-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v2 3/3] net: phy: dp83tg720: Add cable testing support
config: i386-buildonly-randconfig-001-20240809 (https://download.01.org/0day-ci/archive/20240809/202408090754.e4G2nq88-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408090754.e4G2nq88-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408090754.e4G2nq88-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "oa_1000bt1_get_ethtool_cable_result_code" [drivers/net/phy/dp83tg720.ko] undefined!
>> ERROR: modpost: "oa_1000bt1_get_tdr_distance" [drivers/net/phy/dp83tg720.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

