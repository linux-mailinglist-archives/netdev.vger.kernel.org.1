Return-Path: <netdev+bounces-202203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC0AECA9C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 00:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB137A5BE8
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 22:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471101B0416;
	Sat, 28 Jun 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiOhmEKH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF21E7C27
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751148918; cv=none; b=EHuzRjneyra4ELUOIOdf+0wUQ/Pg2ohON1TihPa77dP/oYlvWFq9xFQcVI1RUSzLCQJQ5IsX4nr/eFmVHysEoXLK3978gYre+8pOfW6wGTeZELuVHTscCsFtE08pFDDAiuRfOCHUOvq1gpi3dyWsVYqU6I8rslk/B+hezXa2euE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751148918; c=relaxed/simple;
	bh=i7+EmW2a/ovIfkqGuD41eAsx98c0Dx6zctfDs0y//2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu1fH5IgvviOD+oKpDQPSIYf4VeOgTBDoCQSqRcXOaYHwEeVOI7a6pwtZhlvAQAsS7rp8gAcvJ2H5mg/0rMnmEIPOs+U/DmZYsG5MBz/vcUqwZ1T/MJUhVT5crD00xogP+8l3AUbo4fODNL8DVtwFKNEQYfpoucd94ncWY8eL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiOhmEKH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751148916; x=1782684916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i7+EmW2a/ovIfkqGuD41eAsx98c0Dx6zctfDs0y//2I=;
  b=PiOhmEKHrqKD89VHnKMacriEzKqIF0reivFB3auPaNCfaRwIO2DAEbxc
   tUpNnmuS/rLWLE9BT3szszarkmRwEJGE70c6NZEtbqJg87Q8kpNTRZ7KP
   73NKqTan9+TGEBexbtsGvX9Kpr+XvIW3gTSkJu18c9AfZV3m2Iz2wgt2i
   QlBO1OjJQpZqBWtt9yQt8tq9oID7v3ftbQ7svACwOJkbr4tq/ZEzAY/j+
   8EH/uDXiSNziYxVVBjd730i5DrLqIoGr2BB3l14XksUPVn9wDUyAqcA4Z
   ZCaCERdm7XOTYhxLVHsjvCBPOnukEp1xJeP/D4/lE7kets6OPVebOhD0M
   A==;
X-CSE-ConnectionGUID: mNQ+cByVSLa6o9pyhh6feA==
X-CSE-MsgGUID: Ul+B53eYRvSGDOegW8FDSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="41047638"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="41047638"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 15:15:15 -0700
X-CSE-ConnectionGUID: O24xXQUETYSn4YNSIwQYbg==
X-CSE-MsgGUID: N9vwVKmaTTCpjSDZKQwMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="152835100"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jun 2025 15:15:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVdpG-000XQs-20;
	Sat, 28 Jun 2025 22:15:10 +0000
Date: Sun, 29 Jun 2025 06:14:28 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] tcp: move tcp_memory_allocated into
 net_aligned_data
Message-ID: <202506290837.0mGwXgmy-lkp@intel.com>
References: <20250627200551.348096-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627200551.348096-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-add-struct-net_aligned_data/20250628-040753
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250627200551.348096-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] tcp: move tcp_memory_allocated into net_aligned_data
config: riscv-randconfig-002-20250629 (https://download.01.org/0day-ci/archive/20250629/202506290837.0mGwXgmy-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506290837.0mGwXgmy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506290837.0mGwXgmy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/hotdata.c:5:
   include/net/aligned_data.h:12:9: error: unknown type name 'atomic64_t'
      12 |         atomic64_t      net_cookie ____cacheline_aligned_in_smp;
         |         ^~~~~~~~~~
>> include/net/aligned_data.h:14:9: error: unknown type name 'atomic_long_t'
      14 |         atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
         |         ^~~~~~~~~~~~~


vim +/atomic_long_t +14 include/net/aligned_data.h

     6	
     7	/* Structure holding cacheline aligned fields on SMP builds.
     8	 * Each field or group should have an ____cacheline_aligned_in_smp
     9	 * attribute to ensure no accidental false sharing can happen.
    10	 */
    11	struct net_aligned_data {
    12		atomic64_t	net_cookie ____cacheline_aligned_in_smp;
    13	#if defined(CONFIG_INET)
  > 14		atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
    15	#endif
    16	};
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

