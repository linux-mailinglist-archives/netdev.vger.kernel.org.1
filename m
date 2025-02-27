Return-Path: <netdev+bounces-170373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EBA485ED
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519C6189408A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93AF1BD03F;
	Thu, 27 Feb 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEl7AAL1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407D1BCA0A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675287; cv=none; b=ncFah8E9AYqezNADA91xzKDrE+TeM5JI8Hg397CB2W6UEb+IaFeGzH1JC7vXoU+R3uInFwY+8VynzcDYptERvOfwRMz0e7LzYZdBfZwu3/9pIlhrmWnsy4p6fFkCgnUPGbvEv0jF2Tx70E//qakUmZZ2CMXVKY/4i+1H+w9sVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675287; c=relaxed/simple;
	bh=iHxrFhFny83WmNWdCod6QcehhB4oKb3HS0mSV0lvjsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7a/qajJWYQHLcHudFwpfCqXhL0zZfbXFIdBwMQFkMpLWG4TueGon7vrl9LpxyAoCxsSsUmBwzJpdiRVRHISA0y2PJhVJopV9S42iUXLfcFdHEvzYzOvCDSDEstQsXJMdhuzWAHXixa5BcvyV7sF2l3fkfS+JHVctKtGEz1zsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEl7AAL1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740675286; x=1772211286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iHxrFhFny83WmNWdCod6QcehhB4oKb3HS0mSV0lvjsM=;
  b=BEl7AAL1re9gHMoSE4aVXDiL+2DSvjxw3jkeixiSVvyuA/GOa6zz739a
   I4uCjpH5rImLmNE5bA99yAX5WBGHw6QUSqfG0Nb4jNBufL33z2+Y3NcTI
   //xLvbq6yeJ3uYV5z/tHpF05dMEUEwQVl8Ft5uDmFfvOk5NPNzSk0y+qH
   Vqg8h2Z+6enMYxchZE/pa6KtsO/ZLfFLWaE5WuBX614EJDYDj3/r0XN91
   rx4e7t3U8xLkXTYAwEM6wLb7+nfy4EnEEO1zLbfnYkzQFei370xwholX1
   Ec+promj48pGqwrSKMjPikqZPrmrk8iKj3GOZr66N8YDKy4zfwUlwNbnK
   w==;
X-CSE-ConnectionGUID: dMB3CgfsS6KXQHbB9oA9hQ==
X-CSE-MsgGUID: UBvDZGGqSlSuULiwZAIVVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45491724"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45491724"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:54:45 -0800
X-CSE-ConnectionGUID: 9TW28CJ7SrCShaLWzmAKWQ==
X-CSE-MsgGUID: SsDBisBgTp2P76hZoAwH/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117106485"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2025 08:54:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnh9j-000Dja-39;
	Thu, 27 Feb 2025 16:54:39 +0000
Date: Fri, 28 Feb 2025 00:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v8 6/8] net: selftests: Support selftest sets
Message-ID: <202502280012.b32B74S1-lkp@intel.com>
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
config: mips-randconfig-r064-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280012.b32B74S1-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 204dcafec0ecf0db81d420d2de57b02ada6b09ec)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280012.b32B74S1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280012.b32B74S1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/usb/smsc95xx.c:25:
>> include/net/selftests.h:48:59: error: 'void' must be the first and only parameter if specified
      48 | static inline int net_selftest_set_get_count(int set, void)
         |                                                           ^
>> include/net/selftests.h:48:59: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
   1 warning and 1 error generated.


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

