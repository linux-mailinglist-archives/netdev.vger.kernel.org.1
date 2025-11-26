Return-Path: <netdev+bounces-241925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A6C8A95D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C684E1E77
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE466328B54;
	Wed, 26 Nov 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHhIWrH0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6332936A;
	Wed, 26 Nov 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170294; cv=none; b=MlD4RM4arYtWugmMZ9HlHbsffkxLMRWJFqdCQFmTu0KND09ic3mk4Gl9H7bP8lLRZKIA32S/gjmu1WS1nKKLfG5Zb0TDY415QgbyaMn13Rq/pbcxcfzBasHB9HvhAblK53iKxtN/F0cHOGyhKgFQZ1buDYIDULIOdtn4p1dANys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170294; c=relaxed/simple;
	bh=9+hR7kxFgEDpd/P2N5Yq1iIDYHVOIcry0cvJa5c8pcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6GeKf6bMjUr/5dUgYhgyqixRCqeyMoUyd0QoxxXmiKcfypf6LBJe+t6d3A5mz3IhjSiyW5bOGa7lEpvv5d6n0O813hnikG40jLWocTB/P2aUXCyDsKgNs7M/BsToiN4q9bp6ZCuOjX6jWY/cDS3aSeCQWmJ0WCmjhx7qeO0MHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHhIWrH0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764170288; x=1795706288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9+hR7kxFgEDpd/P2N5Yq1iIDYHVOIcry0cvJa5c8pcM=;
  b=RHhIWrH0wW4TuNpzzUkdyta1+FSLNFnJ1xrrEj3Kvaf2ZDfU8mA/muY8
   j5ESOAPP7qiROREY5x5CClWlsuySuPMy5yw8yqIg1bxkQ+3Cd2+wPqyjS
   px/O1teVyZDERYBw73QMPqw7RswWaUZmawWw+xYeHhglk7JvPM9Fxcgal
   m9CDfqk2ufNIYtu41UpTAcXWasRdPLPS1PDkmsgeNxL+L+4Z3ZoBt/1eO
   w7it4B3dc9HsC7PcS8pi75wnUKNCH/XDG0n7+ILdWZT9twuS32GLfnP7v
   Ee9/ZZH+gYKAUMv327t16Sdo9ADpZ2wtvPeBZHKMYMfX0BuDPt2sO4i/g
   g==;
X-CSE-ConnectionGUID: p/B30dawRlOeSbf52+Q6rg==
X-CSE-MsgGUID: 53RbYq2xSESfeh9mhKm+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77682937"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="77682937"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 07:18:05 -0800
X-CSE-ConnectionGUID: 6WowPgJeSa+dyjEO+cTwTw==
X-CSE-MsgGUID: NAIktyboSQGVf95RP6xDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197915013"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Nov 2025 07:18:02 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOHHM-0000000032T-1p57;
	Wed, 26 Nov 2025 15:18:00 +0000
Date: Wed, 26 Nov 2025 23:17:28 +0800
From: kernel test robot <lkp@intel.com>
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Buday Csaba <buday.csaba@prolan.hu>
Subject: Re: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to
 access ID register
Message-ID: <202511262214.pygdUoQY-lkp@intel.com>
References: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>

Hi Buday,

kernel test robot noticed the following build errors:

[auto build test ERROR on e2c20036a8879476c88002730d8a27f4e3c32d4b]

url:    https://github.com/intel-lab-lkp/linux/commits/Buday-Csaba/net-mdio-reset-PHY-before-attempting-to-access-ID-register/20251125-191906
base:   e2c20036a8879476c88002730d8a27f4e3c32d4b
patch link:    https://lore.kernel.org/r/6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba%40prolan.hu
patch subject: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to access ID register
config: arm-randconfig-003-20251126 (https://download.01.org/0day-ci/archive/20251126/202511262214.pygdUoQY-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511262214.pygdUoQY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511262214.pygdUoQY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mdio_device_register_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
>> ERROR: modpost: "mdio_device_unregister_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

