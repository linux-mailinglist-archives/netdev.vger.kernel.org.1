Return-Path: <netdev+bounces-226014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC6B9AC33
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958B61894041
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BD31283D;
	Wed, 24 Sep 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJ3L0M9w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5A3074B3
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728735; cv=none; b=HjmHYwf1Sh1zbYuknQHaAMnjXRpjmJffL3HUrSwPN2I7xWpX9kPv/Ck1N/hZEVleDYNb4kFPBNgcwH7NrgWKecyLEGNGjuC3tgxaA0myuC66H04hp2Jq00iez8jlzT2VugKPtnfcZ09u6zb/X6l1rRVR9QwmDxCS2tnfNw2aSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728735; c=relaxed/simple;
	bh=EYbabVKCBl3/xYzb7P452QckLGmQkx7kIzVjguTWoec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbwy1E+WbMh6Js6c1zBqTMTVhAtXwzs8QR8DIGGypSrIPhboMXptZVdiAOrMrzNdWj6XUpvFPlXFgWFCMZexRi4nu9wwSTyijckqldgGuyDVCQBcLL1eZ+R93eBeonNIYwyRfQMgiuoU2mMqjmI1o8cjboJ9OK+UZvDedmRvdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJ3L0M9w; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758728734; x=1790264734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYbabVKCBl3/xYzb7P452QckLGmQkx7kIzVjguTWoec=;
  b=PJ3L0M9wIG+kkip4RHykas0m6O3NtCSMzLrrHr7iM7bMZgE51ghJU7pF
   0OTNsvd/vowb5cM/pE3BieliWNwqdAFsmunK958QAAWwg6FFP4zdb9rc0
   +GmFK+dVJLz7w0r1sxz168UNlvYLsHG5hNm0PcgCMbu7xgMTItzHSiJRh
   NxgltJBAi+XFcJDdBSuT5K21zOlc3A8R/qllZkm+/vEtZnPpF78jSQ2Jg
   eFBPrqPdxU9fqfsrHKkupYHKw0PeOivPxM74iFPLgcPGg+5Zp7skjhrSl
   B3yUkYAXFEv7ZbcnCjGDXbXPLLlYuX7cGgxLwiMG4Vcy9VBSmSH5NdxzT
   w==;
X-CSE-ConnectionGUID: DvGax+iVRcKUeoTk+cx9Bw==
X-CSE-MsgGUID: A6lyU3WdQ9O/EbBT5EPg7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="48595911"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="48595911"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 08:45:33 -0700
X-CSE-ConnectionGUID: RD1auOQATYGMMJ0QfVfNyg==
X-CSE-MsgGUID: Y+lQqbYdQCWiwJ/2z8rwYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176909727"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2025 08:45:29 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1RgM-0004H7-3D;
	Wed, 24 Sep 2025 15:45:26 +0000
Date: Wed, 24 Sep 2025 23:44:41 +0800
From: kernel test robot <lkp@intel.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	parav@nvidia.com, jerinj@marvell.com, ndabilpuram@marvell.com,
	sburla@marvell.com, schalla@marvell.com
Subject: Re: [PATCH v1 net-next  3/3] vhost/net: enable outer nw header
 offset support.
Message-ID: <202509242332.EMhAL1a2-lkp@intel.com>
References: <20250923202258.2738717-4-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923202258.2738717-4-kshankar@marvell.com>

Hi Kommula,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kommula-Shiva-Shankar/net-implement-virtio-helper-to-handle-outer-nw-offset/20250924-042602
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250923202258.2738717-4-kshankar%40marvell.com
patch subject: [PATCH v1 net-next  3/3] vhost/net: enable outer nw header offset support.
config: arc-randconfig-r071-20250924 (https://download.01.org/0day-ci/archive/20250924/202509242332.EMhAL1a2-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509242332.EMhAL1a2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509242332.EMhAL1a2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bits.h:5,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from drivers/vhost/net.c:8:
>> include/vdso/bits.h:8:33: warning: excess elements in array initializer
       8 | #define BIT_ULL(nr)             (ULL(1) << (nr))
         |                                 ^
   include/linux/virtio_features.h:10:33: note: in expansion of macro 'BIT_ULL'
      10 | #define VIRTIO_BIT(b)           BIT_ULL((b) & 0x3f)
         |                                 ^~~~~~~
   drivers/vhost/net.c:81:9: note: in expansion of macro 'VIRTIO_BIT'
      81 |         VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),
         |         ^~~~~~~~~~
   include/vdso/bits.h:8:33: note: (near initialization for 'vhost_net_features')
       8 | #define BIT_ULL(nr)             (ULL(1) << (nr))
         |                                 ^
   include/linux/virtio_features.h:10:33: note: in expansion of macro 'BIT_ULL'
      10 | #define VIRTIO_BIT(b)           BIT_ULL((b) & 0x3f)
         |                                 ^~~~~~~
   drivers/vhost/net.c:81:9: note: in expansion of macro 'VIRTIO_BIT'
      81 |         VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),
         |         ^~~~~~~~~~


vim +8 include/vdso/bits.h

3945ff37d2f48d Vincenzo Frascino 2020-03-20  6  
3945ff37d2f48d Vincenzo Frascino 2020-03-20  7  #define BIT(nr)			(UL(1) << (nr))
cbdb1f163af2bb Andy Shevchenko   2022-11-28 @8  #define BIT_ULL(nr)		(ULL(1) << (nr))
3945ff37d2f48d Vincenzo Frascino 2020-03-20  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

