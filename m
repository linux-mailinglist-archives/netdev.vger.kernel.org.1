Return-Path: <netdev+bounces-139938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575989B4B9D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7138C1C22C13
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1E20696B;
	Tue, 29 Oct 2024 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc44QJdV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC342A92
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210468; cv=none; b=nzuvmtOn1Tpdrrwvoa6oNzAB8wVVcCFX/o3YHZBVH6QNohQGOOT0RckXgIi23utwWigXJVDLQgCjGo2VhF33a7SrQ0A5BEeO6bGlp0KmP8EMHzvlz0kpogD9BW/oPAKdQy0+9NKs76t8DAs/tvWftco3ZeB1ZXJ48s/tHysCtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210468; c=relaxed/simple;
	bh=9ZJTsG8lRG8BvG9jQcA5w06trFne16YwpHIHqY8L2Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuamJYrnFCgan9fxPJtYXr66DNX7aQsKHROiacafVO7mAMhVA9uN2xTKeEVTEaCCa1Fm5vEoNpYhA7oUxEPLDhtbJGvx/bAETy/KpjgQeEcmboU+f5T9nzZ8U8ENWyUwWXEROSsxd4DPnK/C4KQRraLl7SaWOLsaeCsK/Z44Lmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc44QJdV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730210466; x=1761746466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZJTsG8lRG8BvG9jQcA5w06trFne16YwpHIHqY8L2Tk=;
  b=Bc44QJdVe6puaK3Ey7X79Qnlc0j8AOyQE1TNGRl2X/ggCu9AVbfEs8Ex
   tYcOgtkbfiiEMjzBMfLVLIuvewsMlCO0W4goQ9IuK6QLVlOxQ3o4zZUUU
   9eN+Jb4MbuSDRUWbZgrffXHWC77XBj7y5LIgALVIYQkfO7UdkGDpdS81k
   kQYwGHZoeRezxgJHhAuV+lOtcOCn2g1V6xlHXEgf5P3HKWFz2IBa3Pm3K
   tSR1o3KDlBeH1+zk8rFxE7bTHt7ZBcx6w2ufIeYsNGlHWMNrNHmOzkMJH
   VNKK7g5CXSxvzhcnz8iXMrhJ6pOI/dLg0TwPktdOMfV8qgWKhoD5p4I7O
   g==;
X-CSE-ConnectionGUID: 4wNQgBopRXG5iQQC2Gdzhw==
X-CSE-MsgGUID: xe95dYvSTW+nGne0KyB1Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40434770"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="40434770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:01:05 -0700
X-CSE-ConnectionGUID: 7ljc5z6CTV+p2ixm683YkQ==
X-CSE-MsgGUID: 3P1/p2zzRWym7OK4v1yRFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82064223"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2024 07:01:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5mmL-000djg-1n;
	Tue, 29 Oct 2024 14:01:01 +0000
Date: Tue, 29 Oct 2024 22:00:48 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202410292151.ozZhCbRL-lkp@intel.com>
References: <20241028213541.1529-13-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-13-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241029-095137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241028213541.1529-13-ouster%40cs.stanford.edu
patch subject: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241029/202410292151.ozZhCbRL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410292151.ozZhCbRL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410292151.ozZhCbRL-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/homa/homa_incoming.c: In function 'homa_incoming_sysctl_changed':
>> net/homa/homa_incoming.c:1078:22: error: 'cpu_khz' undeclared (first use in this function)
    1078 |         tmp = (tmp * cpu_khz) / 1000;
         |                      ^~~~~~~
   net/homa/homa_incoming.c:1078:22: note: each undeclared identifier is reported only once for each function it appears in
--
   net/homa/homa_outgoing.c: In function 'homa_outgoing_sysctl_changed':
>> net/homa/homa_outgoing.c:579:46: error: 'cpu_khz' undeclared (first use in this function)
     579 |         homa->cycles_per_kbyte = (8 * (__u64)cpu_khz) / homa->link_mbps;
         |                                              ^~~~~~~
   net/homa/homa_outgoing.c:579:46: note: each undeclared identifier is reported only once for each function it appears in
--
   net/homa/homa_peer.c: In function 'homa_dst_refresh':
>> net/homa/homa_peer.c:189:48: error: 'cpu_khz' undeclared (first use in this function)
     189 |                         dead->gc_time = now + (cpu_khz << 7);
         |                                                ^~~~~~~
   net/homa/homa_peer.c:189:48: note: each undeclared identifier is reported only once for each function it appears in
--
   net/homa/homa_plumbing.c: In function 'homa_softirq':
>> net/homa/homa_plumbing.c:712:61: error: 'cpu_khz' undeclared (first use in this function)
     712 |                 int scaled_ms = (int)(10 * (start - last) / cpu_khz);
         |                                                             ^~~~~~~
   net/homa/homa_plumbing.c:712:61: note: each undeclared identifier is reported only once for each function it appears in
--
   net/homa/homa_utils.c: In function 'homa_spin':
>> net/homa/homa_utils.c:122:36: error: 'cpu_khz' undeclared (first use in this function)
     122 |         end = get_cycles() + (ns * cpu_khz) / 1000000;
         |                                    ^~~~~~~
   net/homa/homa_utils.c:122:36: note: each undeclared identifier is reported only once for each function it appears in


vim +/cpu_khz +1078 net/homa/homa_incoming.c

223bab41c36796 John Ousterhout 2024-10-28  1063  
223bab41c36796 John Ousterhout 2024-10-28  1064  /**
223bab41c36796 John Ousterhout 2024-10-28  1065   * homa_incoming_sysctl_changed() - Invoked whenever a sysctl value is changed;
223bab41c36796 John Ousterhout 2024-10-28  1066   * any input-related parameters that depend on sysctl-settable values.
223bab41c36796 John Ousterhout 2024-10-28  1067   * @homa:    Overall data about the Homa protocol implementation.
223bab41c36796 John Ousterhout 2024-10-28  1068   */
223bab41c36796 John Ousterhout 2024-10-28  1069  void homa_incoming_sysctl_changed(struct homa *homa)
223bab41c36796 John Ousterhout 2024-10-28  1070  {
223bab41c36796 John Ousterhout 2024-10-28  1071  	__u64 tmp;
223bab41c36796 John Ousterhout 2024-10-28  1072  
223bab41c36796 John Ousterhout 2024-10-28  1073  	/* Code below is written carefully to avoid integer underflow or
223bab41c36796 John Ousterhout 2024-10-28  1074  	 * overflow under expected usage patterns. Be careful when changing!
223bab41c36796 John Ousterhout 2024-10-28  1075  	 */
223bab41c36796 John Ousterhout 2024-10-28  1076  
223bab41c36796 John Ousterhout 2024-10-28  1077  	tmp = homa->busy_usecs;
223bab41c36796 John Ousterhout 2024-10-28 @1078  	tmp = (tmp * cpu_khz) / 1000;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

