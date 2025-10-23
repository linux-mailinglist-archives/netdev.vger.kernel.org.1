Return-Path: <netdev+bounces-231922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F1BFEA99
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3C634F0D55
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839DCBA45;
	Thu, 23 Oct 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVk5e08s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83EA8821;
	Thu, 23 Oct 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177872; cv=none; b=e0+ZeUctt3ekI8u5Ab3YCwURly73ZoFCuMimery6jMK7/14rv96UVx5jvSYI80dX0ZH3FKsHi8SYkcSi7ueCvbmzLy7iUX4kweqimoBzMcKd1LjniZKXy6wpu3mTOTqTvtzaIRII9/iiLiRhySpZTNmAxUB+2ILQDR+VaBp3ds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177872; c=relaxed/simple;
	bh=VmKIfqbGp+sERaU5zAzANQnfoYUaDUG0CsvMmCPWWG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xjo68kOePlN/7IECKJKtwAlfrB8wxmzRb8PI4oc/5p+xJGxUxvhG1ZAaGJ7V/L1XTyZps/HGUH8SLK/YpCHw2TDEeBpQnW5WKFHkst/A/+44o3MLbIEzs5a+Gg98UdgDR9lPgy3XbUB3ya+36OQNm7YD1zx7CNP4itmZUgY9VBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVk5e08s; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761177871; x=1792713871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VmKIfqbGp+sERaU5zAzANQnfoYUaDUG0CsvMmCPWWG8=;
  b=kVk5e08s3qpDwghI04sZ+lAvGT32DB5rIzVNfmUr0SYEnLq+dit2V3XA
   6EMd/RoLrUW+Vd8DGU+hJxeRTnUbJV4FRnfzuhwUt6/mjAQnd3z90xrZK
   ytCp3CXpqtp7UjLK+oEWWb0gFIb52uLtiMQg6M8Bs1iyHXtgDM4M4o1Mi
   Nb8DxxsxStk7EJv0H40BWTz0JYaS4wdhVKy0/yeKAyv+/Rb3GLw1mi4nM
   E6iL/BG2dbAmwMhMCeW40j0YM7P89IvME0VARwMuiAqny/xS1k6Sh3rtQ
   gGk6cYEG8JxBXbIqqoUcUJJ0S6Vc0MsiaqnMbDwFtOd+h7JqrCJcMT/Zm
   Q==;
X-CSE-ConnectionGUID: +YbAQtfhQN6UO8O7+yPXow==
X-CSE-MsgGUID: /S5Cc/e5Sm2cXeLe4OkMLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74685985"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="74685985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 17:04:30 -0700
X-CSE-ConnectionGUID: BFmTa4RDRgezEuMZtnhy4A==
X-CSE-MsgGUID: pw6/2XUfSvu0P92j/MfVQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="207670240"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 22 Oct 2025 17:04:27 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBiob-000CqX-27;
	Thu, 23 Oct 2025 00:04:25 +0000
Date: Thu, 23 Oct 2025 08:03:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrey.bokhanko@huawei.com,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 7/8] ipvlan: Support IPv6 for learnable l2-bridge
Message-ID: <202510230706.1LUrP6NA-lkp@intel.com>
References: <20251021144410.257905-8-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144410.257905-8-skorodumov.dmitry@huawei.com>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-Implement-learnable-L2-bridge/20251021-224923
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251021144410.257905-8-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net-next 7/8] ipvlan: Support IPv6 for learnable l2-bridge
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251023/202510230706.1LUrP6NA-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510230706.1LUrP6NA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510230706.1LUrP6NA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ipvlan/ipvlan_core.c:832:23: error: call to undeclared function 'csum_ipv6_magic'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     832 |         icmph->icmp6_cksum = csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
         |                              ^
   drivers/net/ipvlan/ipvlan_core.c:832:23: note: did you mean 'csum_tcpudp_magic'?
   arch/hexagon/include/asm/checksum.h:21:9: note: 'csum_tcpudp_magic' declared here
      21 | __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
         |         ^
   arch/hexagon/include/asm/checksum.h:20:27: note: expanded from macro 'csum_tcpudp_magic'
      20 | #define csum_tcpudp_magic csum_tcpudp_magic
         |                           ^
   1 error generated.


vim +/csum_ipv6_magic +832 drivers/net/ipvlan/ipvlan_core.c

   788	
   789	static void ipvlan_snat_patch_tx_ipv6(struct ipvl_dev *ipvlan,
   790					      struct sk_buff *skb)
   791	{
   792		struct ipv6hdr *ip6h;
   793		struct icmp6hdr *icmph;
   794		u8 icmp_option;
   795		u8 *lladdr;
   796		u16 ndsize;
   797	
   798		if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
   799			return;
   800	
   801		if (ipv6_hdr(skb)->nexthdr != NEXTHDR_ICMP)
   802			return;
   803	
   804		if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h) + sizeof(*icmph))))
   805			return;
   806	
   807		ip6h = ipv6_hdr(skb);
   808		icmph = (struct icmp6hdr *)(ip6h + 1);
   809	
   810		/* Patch Source-LL for solicitation, Target-LL for advertisement */
   811		if (icmph->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
   812		    icmph->icmp6_type == NDISC_ROUTER_SOLICITATION)
   813			icmp_option = ND_OPT_SOURCE_LL_ADDR;
   814		else if (icmph->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT)
   815			icmp_option = ND_OPT_TARGET_LL_ADDR;
   816		else
   817			return;
   818	
   819		ndsize = htons(ip6h->payload_len);
   820		if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h) + ndsize)))
   821			return;
   822	
   823		lladdr = ipvlan_search_icmp6_ll_addr(skb, icmp_option);
   824		if (!lladdr)
   825			return;
   826	
   827		ether_addr_copy(lladdr, ipvlan->phy_dev->dev_addr);
   828	
   829		ip6h = ipv6_hdr(skb);
   830		icmph = (struct icmp6hdr *)(ip6h + 1);
   831		icmph->icmp6_cksum = 0;
 > 832		icmph->icmp6_cksum = csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
   833						     ndsize,
   834						     IPPROTO_ICMPV6,
   835						     csum_partial(icmph,
   836								  ndsize,
   837								  0));
   838		skb->ip_summed = CHECKSUM_COMPLETE;
   839	}
   840	#else
   841	static void ipvlan_snat_patch_tx_ipv6(struct ipvl_dev *ipvlan,
   842					      struct sk_buff *skb)
   843	{
   844	}
   845	#endif
   846	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

