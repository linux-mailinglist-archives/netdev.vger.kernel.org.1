Return-Path: <netdev+bounces-100483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1758FADFD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816DE1F260B4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA12142E8E;
	Tue,  4 Jun 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXm/XwhC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B69142E76;
	Tue,  4 Jun 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491038; cv=none; b=S01DF1XQ9+5nprPC7gB/+AMBPGPlpsttsSKH9a1mzcprJuXcSDUxWmx3D8nXtky247vAwAKbu0h2ZCsQ+7g/laJKsrd7RyzZ2hh6Wyv1bL/ygMNeifcXIRt4bv6eFXXU7b2UmeK6YAnBRpvAI2T6Xe4GNQGhwHg2ny91c+V35Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491038; c=relaxed/simple;
	bh=jsePevRiIhDkdVXD80oV8Y9zSm3mcSPIVKYbBwvy7G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJqzl/HhqoTqjekyihe4ocfRN0odRUoU1zuY5311DPbx+NYnlQ2hInXME6CdZJLK9ISmyf+jU7o2WPs79sl9p4qiPSB+p8SQsBN/aKBB49rRGobXnZXvgj5ZwsPrbrzqw2qmTn0WUaVg0vv+bOfQ50wFzB39iFj+SJwJgitnYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXm/XwhC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717491034; x=1749027034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsePevRiIhDkdVXD80oV8Y9zSm3mcSPIVKYbBwvy7G0=;
  b=HXm/XwhCQnLeRePw0y3pGsVGDM5WZsmwMlmJGVcbmVmjczco7aIt6Bzh
   gNkcqrLYfcYPiI+Y8Hab7frKBqrwUAWBwm5SOE+o0TlUbsfTeZdFYxfg0
   qMT512zTGEc9JpF0h/NRiirvAW+g41mhuTp8qKchk5m8D9YGyPt8nVdVi
   1ObneYY1vrkWqqUhF0xlOoMjISbN1ok0u0EUaRBWY3hBQJyN9amZX6D4H
   4jpsS0e+EY3N1zKcFBXpc1BGSgOGG/QzkSqagIZjXPxtNo4Epiu4GdVmC
   MbhyRSKLjDnIcbn8bHr8OMR09PnTq9evfNC3UBbUZSQaKKiJC/d26FBhF
   A==;
X-CSE-ConnectionGUID: 9asW5QEdQji7iCx5vAxyBQ==
X-CSE-MsgGUID: G6iYR54FS72rnZ9Ow4DX2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25422250"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="25422250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:50:33 -0700
X-CSE-ConnectionGUID: muE7e3PGTp6QpkFk7l5Dpw==
X-CSE-MsgGUID: jJ+fMvi1R76uL0GyoUCxcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37038342"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 01:50:29 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEPs9-000Myv-14;
	Tue, 04 Jun 2024 08:50:25 +0000
Date: Tue, 4 Jun 2024 16:49:39 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
Message-ID: <202406041623.ycwsuP85-lkp@intel.com>
References: <20240603185647.2310748-7-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-7-amorenoz@redhat.com>

Hi Adrian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240603185647.2310748-7-amorenoz%40redhat.com
patch subject: [PATCH net-next v2 6/9] net: openvswitch: store sampling probability in cb.
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240604/202406041623.ycwsuP85-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041623.ycwsuP85-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406041623.ycwsuP85-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
>> actions.c:(.text+0x214e): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

