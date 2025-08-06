Return-Path: <netdev+bounces-211977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1738B1CD73
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7F33ABA0A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E510E4;
	Wed,  6 Aug 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gW3Tw9Fh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD51E25ED;
	Wed,  6 Aug 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512153; cv=none; b=ny/Ewtdv97+FYvV+b+XvJRWC1dK5VN2WPXvOkLEzMLKikJJxWBG+lwPB7MejxtQVPo+INKnv6WZ9OzVYLSlKz17c7Wpw3b2wpm5wHeyz0sfF0MlRXmFHOJgNDXXd8FIxDnw2pADTkSaFZBAkFueAKG8zM1d4rnWJ0F+sXk+mXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512153; c=relaxed/simple;
	bh=a+87Pw3CxGgExCGo239uu1vTCQEUqmPQtZjqoW+heDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMc6z5i6+KEZ6QMdFl6NWU5xLI4WkVZKwDQK+BipqT0VFatuXUEjQPwMKGRDW7Aud8MriPjAEdsKu8mkXwvL1YIG1XpClRBD1wKH/rOPP3kHf+2wTPKHY7cGho9EW06/fk3j7XOVEbSMYotfB4lbmYDnQPOOBk6EWLyQWIdw2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gW3Tw9Fh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512152; x=1786048152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a+87Pw3CxGgExCGo239uu1vTCQEUqmPQtZjqoW+heDg=;
  b=gW3Tw9Fh7G1ixtEq98wYDhuRgTJZddWLivlLC4RXqqEzbCxaThQXu3ik
   +lIuqCxU3VEAlvG9ED55zrdPOAXJ/YMp3aguygG4xFfCC3GpHBEjc3HGn
   kN8V/Ej9aBdWDZx88Y+MnbUxi9NA2DHLUAbpG9Jsr1u7GiviJrE0zj8TA
   Ljf/FZW+8MsxzOndwvyP/Zf0znhDFBhnGWo1miroCDFlQI2Xc7LtzyiiW
   yEjYsRIdxlRUZnMxdSnnO5x+JnvfrnQybuFA1AWh25PWrTDBwGDOvImGl
   nOfw9i7ETdMoUAKyt3FN/y9Tz9++TJ5qNdQ+6tvCwXVyy51GBVuxikhxW
   w==;
X-CSE-ConnectionGUID: Y8gfpGY/T7aty9gJhHNhpg==
X-CSE-MsgGUID: o47+b6fIRjyrybD7Yp0JgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56975203"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56975203"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:29:11 -0700
X-CSE-ConnectionGUID: HZq8wMGdTDq7AwssYwec3Q==
X-CSE-MsgGUID: xtAiFekAS36m9ospDvkgCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165205701"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2025 13:29:08 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujkkd-000242-2M;
	Wed, 06 Aug 2025 20:28:59 +0000
Date: Thu, 7 Aug 2025 04:28:35 +0800
From: kernel test robot <lkp@intel.com>
To: Xin Zhao <jackzxcui1989@163.com>, willemdebruijn.kernel@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
Message-ID: <202508070419.1T0vxudH-lkp@intel.com>
References: <20250806055210.1530081-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806055210.1530081-1-jackzxcui1989@163.com>

Hi Xin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.16 next-20250806]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Zhao/net-af_packet-add-af_packet-hrtimer-mode/20250806-135354
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250806055210.1530081-1-jackzxcui1989%40163.com
patch subject: [PATCH] net: af_packet: add af_packet hrtimer mode
config: x86_64-randconfig-004-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070419.1T0vxudH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070419.1T0vxudH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070419.1T0vxudH-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/packet/af_packet.c: In function 'prb_setup_retire_blk_timer':
>> net/packet/af_packet.c:615:9: error: implicit declaration of function 'hrtimer_init'; did you mean 'hrtimers_init'? [-Werror=implicit-function-declaration]
     615 |         hrtimer_init(&pkc->retire_blk_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
         |         ^~~~~~~~~~~~
         |         hrtimers_init
   cc1: some warnings being treated as errors


vim +615 net/packet/af_packet.c

   608	
   609	static void prb_setup_retire_blk_timer(struct packet_sock *po)
   610	{
   611		struct tpacket_kbdq_core *pkc;
   612	
   613		pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
   614	#ifdef CONFIG_PACKET_HRTIMER
 > 615		hrtimer_init(&pkc->retire_blk_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
   616		pkc->retire_blk_timer.function = prb_retire_rx_blk_timer_expired;
   617		if (pkc->tov_in_msecs == 0)
   618			pkc->tov_in_msecs = jiffies_to_msecs(1);
   619	#else
   620		timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
   621			    0);
   622		pkc->retire_blk_timer.expires = jiffies;
   623	#endif
   624	}
   625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

