Return-Path: <netdev+bounces-101127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929458FD6C1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD89B26175
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43B15359B;
	Wed,  5 Jun 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSDmy4nH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F41527BC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616936; cv=none; b=mB7ZpoNNg8jUBzxFUTgUDcXtpx4Xok9Ohvisf1HYI9rO4ub9WC+fK4rcj+BsLuQKPUr7ptz6MqmquCgKifuSMCPq1Sf5ZeHvKy5hWMTTfIQ/RPcF/3dKJ5T3Shq91b5GKdRs1Gevj1TjNRAlacslY5taXAzmSqdZQHk48pTq5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616936; c=relaxed/simple;
	bh=ce7MGeBqGKigM4qYn6QRHIo8lFlWk1dQx2w37OUDRLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvTIU0Lw56WlFkXRDqCcnaJabgLxyh37f/lCf9259s5uJjHLnJbg9R36pYWS4UGjiSeLPWTtyPzEn3fgdeGvSjjcYyrFPkqkLoRSxXq0ika2STPzXT3S9RZ+HWc4IZ7VP5Vhd1vitVRJ5IfbdqITRphiGiD/wpOeeqELcssJRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSDmy4nH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717616935; x=1749152935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ce7MGeBqGKigM4qYn6QRHIo8lFlWk1dQx2w37OUDRLs=;
  b=lSDmy4nH67/XdrN+iSgCFedl8SrvE5MmUD34E+H7nkEiWG4BamCgFQq8
   CvKJzvpDP0ntbIQuYOmb5OtVy+2b7QeEZ9UpAB+Zupvbw/iNmpQBQzpqj
   a7P6cmA/TA2pKW7+LCxTrRaPCvh2sWy9lHDu8m0hu5eaVr120BGk1zbXf
   9MWj7Bcqoovh9GNcrJTyfG0VoeIEtYv5LTKR94fX0a+pIE/e129GtYBxj
   Fq3OaDB2r1zPiEXgu/aHUP/RdlAuxle83DG0SEZTVyVVkdHPcQGmf5RMF
   AXtgLtncMqURFw8gDuE8d6dl0cnpdn/3ehjEEh8yj0bPbBGfyGDk1KxuY
   g==;
X-CSE-ConnectionGUID: SkA3udcQTmOM/v9kTRy98g==
X-CSE-MsgGUID: cjwfGhHDSV6BEzUqRGpB/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14370708"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14370708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 12:48:54 -0700
X-CSE-ConnectionGUID: aaYlXdF4QjmLQVxKtiqlSA==
X-CSE-MsgGUID: 6FbZcjgPTc+Yhc6DIbUEOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37589384"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 05 Jun 2024 12:48:52 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEwcr-00029c-1n;
	Wed, 05 Jun 2024 19:48:49 +0000
Date: Thu, 6 Jun 2024 03:48:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: core: Implement dstats-type stats collections
Message-ID: <202406060345.LfJ8GAJM-lkp@intel.com>
References: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32f88d65f01bf6f45476d7edbe675e44fb9e1d58]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-core-vrf-Change-pcpu_dstat-fields-to-u64_stats_t/20240605-143942
base:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
patch link:    https://lore.kernel.org/r/20240605-dstats-v1-2-1024396e1670%40codeconstruct.com.au
patch subject: [PATCH 2/3] net: core: Implement dstats-type stats collections
config: x86_64-randconfig-121-20240606 (https://download.01.org/0day-ci/archive/20240606/202406060345.LfJ8GAJM-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060345.LfJ8GAJM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406060345.LfJ8GAJM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3379:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3379:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3379:23: sparse:     got unsigned int
   net/core/dev.c:3379:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:10871:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct pcpu_dstats const * @@
   net/core/dev.c:10871:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   net/core/dev.c:10871:26: sparse:     got struct pcpu_dstats const *
   net/core/dev.c:3819:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5257:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block

vim +10871 net/core/dev.c

 10851	
 10852	/**
 10853	 *	dev_fetch_dstats - collate per-cpu network dstats statistics
 10854	 *	@s: place to store stats
 10855	 *	@dstats: per-cpu network stats to read from
 10856	 *
 10857	 *	Read per-cpu network statistics from dev->dstats and populate the
 10858	 *	related fields in @s.
 10859	 */
 10860	void dev_fetch_dstats(struct rtnl_link_stats64 *s,
 10861			      const struct pcpu_dstats __percpu *dstats)
 10862	{
 10863		int cpu;
 10864	
 10865		for_each_possible_cpu(cpu) {
 10866			u64 rx_packets, rx_bytes, rx_drops;
 10867			u64 tx_packets, tx_bytes, tx_drops;
 10868			const struct pcpu_dstats *dstats;
 10869			unsigned int start;
 10870	
 10871			dstats = per_cpu_ptr(dstats, cpu);
 10872			do {
 10873				start = u64_stats_fetch_begin(&dstats->syncp);
 10874				rx_packets = u64_stats_read(&dstats->rx_packets);
 10875				rx_bytes   = u64_stats_read(&dstats->rx_bytes);
 10876				rx_drops   = u64_stats_read(&dstats->rx_drops);
 10877				tx_packets = u64_stats_read(&dstats->tx_packets);
 10878				tx_bytes   = u64_stats_read(&dstats->tx_bytes);
 10879				tx_drops   = u64_stats_read(&dstats->tx_drops);
 10880			} while (u64_stats_fetch_retry(&dstats->syncp, start));
 10881	
 10882			s->rx_packets += rx_packets;
 10883			s->rx_bytes   += rx_bytes;
 10884			s->rx_dropped += rx_drops;
 10885			s->tx_packets += tx_packets;
 10886			s->tx_bytes   += tx_bytes;
 10887			s->tx_dropped += tx_drops;
 10888		}
 10889	}
 10890	EXPORT_SYMBOL_GPL(dev_fetch_dstats);
 10891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

