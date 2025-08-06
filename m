Return-Path: <netdev+bounces-211980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9584DB1CE36
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1AA47AACBC
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F72253A0;
	Wed,  6 Aug 2025 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFzoPzTU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47621FF57;
	Wed,  6 Aug 2025 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514287; cv=none; b=sqPpVNDwY3XeemAucscDQPOKc/v/fPrkG4ybKd6xyK+iS2RoNSmHDCDw66iBNGp0IlgNa4puVq7OimDQgHl6XjxGzQABI+qT3OCaMCnjeV+wFWfGl6VbJzPiEXBsp+gd6x2J+CtpJdMncYvYjo6EQrtmJbViJHl/wTjhFKQyvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514287; c=relaxed/simple;
	bh=BvwC0JqVwXmYHx1CLjC/SFG/BU+TU7ntLRN/Vr6NJyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiUL0Uhf3MGxc880wuIC4eUK/NwvFlyIbE4LvqnZvOWOV+26qNnCgWa6XYTEQA5TcFsUelXS/NPs92zXSqS93B8/Ij3Pp6jDEQLvmnAYKwLxUkikYo/szWlWNvjN5qraO6dmTfOUpcCo0bptXG0Rfqddk9xkZOGS0gMmCPRW8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFzoPzTU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754514286; x=1786050286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BvwC0JqVwXmYHx1CLjC/SFG/BU+TU7ntLRN/Vr6NJyg=;
  b=fFzoPzTUW2PstpNK7hO/2OaDQuNLU5n17li18LHZ81IFOLdmffZYd8u4
   l2+gCJiInsIjHSvbyxm6WVchIZDeZWxOMpQbThaCQIC6lSTVWTzNWzLZN
   AhsAvvorw2HZfDb/NxQHvRUWYzK4bjX2AOEUC2bohto9rURuKlU8YDyCH
   eQ04PgXmoYeLdYP6Knc71df1PTR/r+YmU8HD4sBZelCb4nojSq4Awdj2I
   d7m1jH6dK75R2R/+m/VHV63StTtoXLG5bZj/baRQP6Yc8+LYSaBj/yWUT
   lfTkWEL1A3P3dRbSgr31+Q8/2N3LDIohgBzfu3M5lgko6paHFA1Zqjc9u
   Q==;
X-CSE-ConnectionGUID: NCgbnWdCQbabaY5z10jr6A==
X-CSE-MsgGUID: S0NsdwGGT6y8xIKyFFphDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59459604"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="59459604"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:04:45 -0700
X-CSE-ConnectionGUID: 24nlF0ShST+tysqyxgcqwg==
X-CSE-MsgGUID: /6d3uZKzQ8KBFInOFLPPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="202039038"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 14:04:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujlJI-00026c-0g;
	Wed, 06 Aug 2025 21:04:33 +0000
Date: Thu, 7 Aug 2025 05:03:17 +0800
From: kernel test robot <lkp@intel.com>
To: bsdhenrymartin@gmail.com, huntazhang@tencent.com, jitxie@tencent.com,
	landonsun@tencent.com, bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH] VSOCK: fix Integer Overflow in
 vmci_transport_recv_dgram_cb()
Message-ID: <202508070446.83Vp7qaK-lkp@intel.com>
References: <20250805041748.1728098-1-tcs_kernel@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805041748.1728098-1-tcs_kernel@tencent.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/bsdhenrymartin-gmail-com/VSOCK-fix-Integer-Overflow-in-vmci_transport_recv_dgram_cb/20250806-105210
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250805041748.1728098-1-tcs_kernel%40tencent.com
patch subject: [PATCH] VSOCK: fix Integer Overflow in vmci_transport_recv_dgram_cb()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250807/202508070446.83Vp7qaK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070446.83Vp7qaK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070446.83Vp7qaK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from net/vmw_vsock/vmci_transport.c:8:
   net/vmw_vsock/vmci_transport.c: In function 'vmci_transport_recv_dgram_cb':
>> include/linux/stddef.h:16:33: error: 'struct vmci_datagram' has no member named 'payload'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   net/vmw_vsock/vmci_transport.c:634:43: note: in expansion of macro 'offsetof'
     634 |         if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
         |                                           ^~~~~~~~
--
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from vmci_transport.c:8:
   vmci_transport.c: In function 'vmci_transport_recv_dgram_cb':
>> include/linux/stddef.h:16:33: error: 'struct vmci_datagram' has no member named 'payload'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   vmci_transport.c:634:43: note: in expansion of macro 'offsetof'
     634 |         if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
         |                                           ^~~~~~~~


vim +16 include/linux/stddef.h

6e218287432472 Richard Knutsson 2006-09-30  14  
^1da177e4c3f41 Linus Torvalds   2005-04-16  15  #undef offsetof
14e83077d55ff4 Rasmus Villemoes 2022-03-23 @16  #define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
3876488444e712 Denys Vlasenko   2015-03-09  17  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

