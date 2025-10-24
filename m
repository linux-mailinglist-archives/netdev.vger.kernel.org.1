Return-Path: <netdev+bounces-232324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050DC041B7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 061804E199B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263171DD525;
	Fri, 24 Oct 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUhtkhwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057724C85;
	Fri, 24 Oct 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272568; cv=none; b=IUWoh3KeABcRtT+a51/6jUwSlZNnvw71JD/DWgnS7026w5xwLbPPJ0wZzw0suTEMi/vfRuHhzBfkYTfaztuZvM+qbXwiUABjwOzq0fu8Nj9fqdTVdTNZCzWqCZdsOQRrp6EkEfrdzh/4uZoP6xGneJVJ9XerDCdR5lLaz1iwKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272568; c=relaxed/simple;
	bh=UBq6wLEILW3Sn87s9h1Xkl1RidnJdWAVJ7kWvH15Cd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJH1/VfuTADiFlJmoGrftbarEL1lX7ntwlAaMtt5XVvjdWzRFh73RLmXuUG/5R8uGNf5HFwURuLB6KVhmCZ/J0aOldfEZiRbfsDOaKqp/bzKydHFPWeTzO4K9oNQzRUd468wdlqkXDo7qJIvAfgX+o5Io3Yw4UGPK9FqozV1Qn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUhtkhwZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761272565; x=1792808565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBq6wLEILW3Sn87s9h1Xkl1RidnJdWAVJ7kWvH15Cd4=;
  b=iUhtkhwZAI2XE9klzl1g/DFsBZWu8I0oKVsq+DiOy1q0/RP0gHZDsJMj
   PDc3+IZmzCmIoLMx7a646TF6rsiAbvP9jqgqsdFtPX//FqvUzXNPpJZNP
   cih/rOvcdLWAxI0/3DBKT+/RcS32QIeG9jpOMPSDex06Ma1XRk3gNq73j
   4HNs6NT/Xgk1ZXMxdshgRq3QWpmkYX/Z6dzdEw6gwIOd/WCw7a+oyoKYy
   sXTx4Y0zilSNjDVKRVyRIISKNODc4xNZMCXmcDT1ewJWNoDS5Q/+yjrmV
   AXnDOhsvcCGm32CcbE9iBPnn0yz2LOls0g9ABcG7HtLsLX6XJhh2NNA/b
   w==;
X-CSE-ConnectionGUID: 1MmBX1ftR3Gah3i6wbmLjw==
X-CSE-MsgGUID: +4D8sQFxQKmv1pAnvYK5Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74892618"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74892618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:22:44 -0700
X-CSE-ConnectionGUID: 8YLCj+iIRMGviZoMR1gySw==
X-CSE-MsgGUID: LljsV714RzOKNxTQmsFHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188703703"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Oct 2025 19:22:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vC7Rw-000E6L-0Q;
	Fri, 24 Oct 2025 02:22:40 +0000
Date: Fri, 24 Oct 2025 10:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrey.bokhanko@huawei.com,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 7/8] ipvlan: Support IPv6 for learnable l2-bridge
Message-ID: <202510241011.2cTY5v7o-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-Implement-learnable-L2-bridge/20251021-224923
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251021144410.257905-8-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net-next 7/8] ipvlan: Support IPv6 for learnable l2-bridge
config: sparc-randconfig-r132-20251023 (https://download.01.org/0day-ci/archive/20251024/202510241011.2cTY5v7o-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510241011.2cTY5v7o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510241011.2cTY5v7o-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ipvlan/ipvlan_core.c:55:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] a @@     got restricted __be32 const [usertype] s_addr @@
   drivers/net/ipvlan/ipvlan_core.c:55:36: sparse:     expected unsigned int [usertype] a
   drivers/net/ipvlan/ipvlan_core.c:55:36: sparse:     got restricted __be32 const [usertype] s_addr
>> drivers/net/ipvlan/ipvlan_core.c:760:22: sparse: sparse: cast from restricted __be16
>> drivers/net/ipvlan/ipvlan_core.c:760:22: sparse: sparse: incorrect type in initializer (different base types) @@     expected int ndsize @@     got restricted __be16 [usertype] @@
   drivers/net/ipvlan/ipvlan_core.c:760:22: sparse:     expected int ndsize
   drivers/net/ipvlan/ipvlan_core.c:760:22: sparse:     got restricted __be16 [usertype]
   drivers/net/ipvlan/ipvlan_core.c:819:18: sparse: sparse: cast from restricted __be16
>> drivers/net/ipvlan/ipvlan_core.c:819:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] ndsize @@     got restricted __be16 [usertype] @@
   drivers/net/ipvlan/ipvlan_core.c:819:16: sparse:     expected unsigned short [usertype] ndsize
   drivers/net/ipvlan/ipvlan_core.c:819:16: sparse:     got restricted __be16 [usertype]

vim +760 drivers/net/ipvlan/ipvlan_core.c

   753	
   754	static u8 *ipvlan_search_icmp6_ll_addr(struct sk_buff *skb, u8 icmp_option)
   755	{
   756		/* skb is ensured to pullable for all ipv6 payload_len by caller */
   757		struct ipv6hdr *ip6h = ipv6_hdr(skb);
   758		struct icmp6hdr *icmph = (struct icmp6hdr *)(ip6h + 1);
   759		int curr_off = sizeof(*icmph);
 > 760		int ndsize = htons(ip6h->payload_len);
   761	
   762		if (icmph->icmp6_type != NDISC_ROUTER_SOLICITATION)
   763			curr_off += sizeof(struct in6_addr);
   764	
   765		while ((curr_off + 2) < ndsize) {
   766			u8  *data = (u8 *)icmph + curr_off;
   767			u32 opt_len = data[1] << 3;
   768	
   769			if (unlikely(opt_len == 0))
   770				return NULL;
   771	
   772			if (data[0] != icmp_option) {
   773				curr_off += opt_len;
   774				continue;
   775			}
   776	
   777			if (unlikely(opt_len < ETH_ALEN + 2))
   778				return NULL;
   779	
   780			if (unlikely(curr_off + opt_len > ndsize))
   781				return NULL;
   782	
   783			return data + 2;
   784		}
   785	
   786		return NULL;
   787	}
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
 > 819		ndsize = htons(ip6h->payload_len);
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
   832		icmph->icmp6_cksum = csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
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

