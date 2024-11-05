Return-Path: <netdev+bounces-142027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB7F9BD00D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5951C2119F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CF1D9350;
	Tue,  5 Nov 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNM71KmF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD11D7E35
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819199; cv=none; b=BIduYafMaKClGppwE5I7Tw55RlLCzlpcyIUSXb86+cn1MFEtxsSKfDo09SZdC+4bLEOUffwUqxaJvopWngAr+sSFEe8nsAMhSmXdC+LEWkQvEHgo6/S0UfUewXfaAc6+a12dhy1nhfMZOzZyXoPgjnQ8rz+1CCw6Pjrx2pQlPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819199; c=relaxed/simple;
	bh=9Q5dwSvyqgDmSwRGRw9zJGGnRrKN0YKi5hD81fpL2PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRijx4jj07H392KURq5Y15kxysdxVDHPbWHVFLnDxQiCFP0UNZoGTkHq2XPgEZisso1fLp1UYBa4drX66gsGoZDJ4Bluc91ZeCzGyMb67jX61GcuDvsTq1Gxcf35cK8bbHJ2vnrbiFJH5JGNlMxLvI4pPTFkPbY10kkBzbBeAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNM71KmF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730819197; x=1762355197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Q5dwSvyqgDmSwRGRw9zJGGnRrKN0YKi5hD81fpL2PA=;
  b=mNM71KmFz5NCWvXR1DlOGYltm5382dcMHB36Jf+Y8tlGTCO2RphSGkMQ
   BOENH8huieynCm5TOM1wFxPdhDU/lqFlI3L6SKIUSLolzyyzipKKg+kZi
   2SvLsInY6VV/2pmZew0EQCsrfXHBF6ob2MO35v7GdUOTexW3hY0qNVGBm
   O7BFshd5r/Xb54Ff9qThJ7p1pJ6FrZl5IukO296KrafE4H+2WuojuMFUv
   kGDDBh8nZBflXDl1nykkEB7ZWhSr0mo2ygguAmUasbW88kLCeG/fSZyud
   qDzfxEPvumeAk/EmjE4fggx3NKeUP7O1pGzaF7DwznZxE3Zu3Q7YVv5px
   w==;
X-CSE-ConnectionGUID: nbWv3PLnQJaISq38QVYCBQ==
X-CSE-MsgGUID: etuYApOhRtGPbk4trzP3zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34262025"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34262025"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:06:36 -0800
X-CSE-ConnectionGUID: Bxi6eyQZTumAQ0kiqBBZuA==
X-CSE-MsgGUID: PE7P5odZRUOt4qXTvgSRgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84000033"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Nov 2024 07:06:34 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8L8Z-000mB1-2h;
	Tue, 05 Nov 2024 15:06:31 +0000
Date: Tue, 5 Nov 2024 23:06:00 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>, Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v13 15/15] xfrm: iptfs: add tracepoint
 functionality
Message-ID: <202411052231.OM2TTHhn-lkp@intel.com>
References: <20241105083759.2172771-16-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105083759.2172771-16-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on next-20241105]
[cannot apply to klassert-ipsec/master netfilter-nf/main linus/master nf-next/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20241105-164740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20241105083759.2172771-16-chopps%40chopps.org
patch subject: [PATCH ipsec-next v13 15/15] xfrm: iptfs: add tracepoint functionality
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20241105/202411052231.OM2TTHhn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411052231.OM2TTHhn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411052231.OM2TTHhn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/xfrm/xfrm_iptfs.c:194:12: warning: '__trace_ip_proto_seq' defined but not used [-Wunused-function]
     194 | static u32 __trace_ip_proto_seq(struct iphdr *iph)
         |            ^~~~~~~~~~~~~~~~~~~~
>> net/xfrm/xfrm_iptfs.c:187:12: warning: '__trace_ip_proto' defined but not used [-Wunused-function]
     187 | static u32 __trace_ip_proto(struct iphdr *iph)
         |            ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/__trace_ip_proto_seq +194 net/xfrm/xfrm_iptfs.c

   186	
 > 187	static u32 __trace_ip_proto(struct iphdr *iph)
   188	{
   189		if (iph->version == 4)
   190			return iph->protocol;
   191		return ((struct ipv6hdr *)iph)->nexthdr;
   192	}
   193	
 > 194	static u32 __trace_ip_proto_seq(struct iphdr *iph)
   195	{
   196		void *nexthdr;
   197		u32 protocol = 0;
   198	
   199		if (iph->version == 4) {
   200			nexthdr = (void *)(iph + 1);
   201			protocol = iph->protocol;
   202		} else if (iph->version == 6) {
   203			nexthdr = (void *)(((struct ipv6hdr *)(iph)) + 1);
   204			protocol = ((struct ipv6hdr *)(iph))->nexthdr;
   205		}
   206		switch (protocol) {
   207		case IPPROTO_ICMP:
   208			return ntohs(((struct icmphdr *)nexthdr)->un.echo.sequence);
   209		case IPPROTO_ICMPV6:
   210			return ntohs(((struct icmp6hdr *)nexthdr)->icmp6_sequence);
   211		case IPPROTO_TCP:
   212			return ntohl(((struct tcphdr *)nexthdr)->seq);
   213		case IPPROTO_UDP:
   214			return ntohs(((struct udphdr *)nexthdr)->source);
   215		default:
   216			return 0;
   217		}
   218	}
   219	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

