Return-Path: <netdev+bounces-203209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E40AF0C0C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AFC7A6C32
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95272223DDF;
	Wed,  2 Jul 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdzdUKG4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69A221F37
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439301; cv=none; b=shufSZWJBEUH1PvXdCH2eMLB2tAIBdO0YFNkwfofsax/+dq4vkkRlaIVqz3lkUHaI3vPndkmYXqio0V94GtMHOkEzYbQBJOZI+rvOF761MN6ad3o/oIhqjnzcV6iHeM2I1XHbNMiE71qFL6V95bjHkBjAs3fjl+EVQF1qS/yaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439301; c=relaxed/simple;
	bh=LDGNXuYwT8Fh4cOCf0zdW7ATVlSQNuYGPOhRopSIAJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z93Uy0wi8P++LsyKZYYUZgvMYNV7GK0wqAZVhUfx1Y9KK0xA3R0dQjND72eR9myE1OOMQKk5F/oKhiIiOQW/GX+PxcVjas/Kon61EE6FhrkUfEdxpUmvc+DzQ/GObyYZinXqQUKCloXMuMhnd7HvxMCLm1e1yLajgHKKkeBGSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdzdUKG4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751439300; x=1782975300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LDGNXuYwT8Fh4cOCf0zdW7ATVlSQNuYGPOhRopSIAJI=;
  b=KdzdUKG4n3DivRe7hz1JoA8dx96pfqwtxKX8YPt8UokdiRSlM/V2ir/f
   Guyob4lHenKeQW7d8c71D2pStdengJjVQnMqNZ0LKjw4LjDbvgGpn6Wm7
   W7CBVubTa4RE+saljhw3lW53OI4poXWOABhuV4SzTl4I6nFjkR9Uq9x4g
   ih7VVlpWMqpF6qXFi7lcXsQ/qnJqRXzV/3kNlwKWW9+Gum/z0+Lxomj+/
   jqrc+NP/xJ0vWJQpO4RPDv/of7/4SUUbScjuAuHsL6nEo9rVEDFS/WQuo
   zSwA1N5BITacUSr0b4zS6uIXO9DgU3t/KAwXpKoS9Gd/7LlzmJZUxEJHP
   w==;
X-CSE-ConnectionGUID: p7XU+x9rS7CEymlx6Rg9VQ==
X-CSE-MsgGUID: YCPE46kLT4yx2SlRQWXVaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52954051"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="52954051"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:54:59 -0700
X-CSE-ConnectionGUID: LbfLQ7TmT1a3aV60NwjuCw==
X-CSE-MsgGUID: t+o73O4DT0mXjj2YU9rRTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158547907"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Jul 2025 23:54:58 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWrMt-0000Hb-06;
	Wed, 02 Jul 2025 06:54:55 +0000
Date: Wed, 2 Jul 2025 14:54:22 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/8] net:
 s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Message-ID: <202507021431.lqWTrQAr-lkp@intel.com>
References: <20250630164222.712558-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630164222.712558-5-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-s-dev_get_stats-netif_get_stats/20250701-004408
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250630164222.712558-5-sdf%40fomichev.me
patch subject: [PATCH net-next v2 4/8] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
config: microblaze-defconfig (https://download.01.org/0day-ci/archive/20250702/202507021431.lqWTrQAr-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507021431.lqWTrQAr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507021431.lqWTrQAr-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module bridge uses symbol netif_pre_changeaddr_notify from namespace NETDEV_INTERNAL, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

