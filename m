Return-Path: <netdev+bounces-44551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5D7D8917
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A5281F51
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E593C064;
	Thu, 26 Oct 2023 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns0bI/OA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474E3B7A7
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 19:42:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE491AC
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698349362; x=1729885362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpvUTfYs7vHDtBYHUrs6zCXfncXkM3VoEmewNy6+y/E=;
  b=ns0bI/OAqPO6Wrravn29FGJrBq0AX4d/t3cVOFSz+mBNQgPFjPam2wY5
   8d4SaXYwt2fJrTtiCWIm7ZG6s9Xpfo1+vjgzOcFsVg6Gem9+Vx5xtTZKR
   0k0gYV0Gg9qbC9Wh+iv9AcJoAe2zNS67P20bUbd31Gp59+t8HmaawGKs6
   kWzwrqqUsz5bdOHnvohESoFbZClqBIzDsoDZoFIQpf8fmOGXaIGyuYH8/
   dR4tF/OD0SZw94559Fy5dzAeiG4SpISs57V2/YJmIj/Fh1Q/+ZsbBwbQo
   /546wYnZmhsPn7g5iyAx3BuxFS2C8h8OMRRfAN3x3df7EutZgoNme8/aL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="446049"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="446049"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 12:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="1090695032"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="1090695032"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2023 12:42:38 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qw6FY-000A56-35;
	Thu, 26 Oct 2023 19:42:36 +0000
Date: Fri, 27 Oct 2023 03:41:45 +0800
From: kernel test robot <lkp@intel.com>
To: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: oe-kbuild-all@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
	Antony Antony <antony.antony@secunet.com>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <202310270353.sobcrQay-lkp@intel.com>
References: <4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony@secunet.com>

Hi Antony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on klassert-ipsec/master net-next/main net/main linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antony-Antony/xfrm-fix-source-address-in-icmp-error-generation-from-IPsec-gateway/20231026-234542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony%40secunet.com
patch subject: [PATCH ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error messages
config: csky-randconfig-002-20231027 (https://download.01.org/0day-ci/archive/20231027/202310270353.sobcrQay-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270353.sobcrQay-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310270353.sobcrQay-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/xfrm/xfrm_policy.c: In function 'icmp_err_packet':
>> net/xfrm/xfrm_policy.c:3490:30: warning: unused variable 'fl6' [-Wunused-variable]
    3490 |         const struct flowi6 *fl6 = &fl->u.ip6;
         |                              ^~~


vim +/fl6 +3490 net/xfrm/xfrm_policy.c

  3487	
  3488	static bool icmp_err_packet(const struct flowi *fl, unsigned short family)
  3489	{
> 3490		const struct flowi6 *fl6 = &fl->u.ip6;
  3491		const struct flowi4 *fl4 = &fl->u.ip4;
  3492	
  3493		if (family == AF_INET &&
  3494		    fl4->flowi4_proto == IPPROTO_ICMP &&
  3495		    (fl4->fl4_icmp_type == ICMP_DEST_UNREACH ||
  3496		     fl4->fl4_icmp_type == ICMP_TIME_EXCEEDED))
  3497			return true;
  3498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

