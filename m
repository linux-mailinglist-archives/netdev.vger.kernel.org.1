Return-Path: <netdev+bounces-237387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEBBC49E16
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D50F4E423A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5AA2264BD;
	Tue, 11 Nov 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9FX4d3j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B294223DF0;
	Tue, 11 Nov 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821243; cv=none; b=oIEoZ6lJGhXKIlZgJTIsPrZW8NHLpkoypxxTGZuxZAN+xLxuhOjUCzW0b5Szik2WU0hDBc+W0ioQnmFhzC/hmzud5et9Vn/8U6EiIeKN5P3yfSQWszUieWCYFNY4ldPtY1yiH1vwXXAxAZmrTHoGCAVmZJhaPCayewZkKxAE21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821243; c=relaxed/simple;
	bh=FN4CweFd1C3K2bDEXrQI2FrcndJARFnGCMf20zgvu1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiYz8GelN2qoP8Jbleh86dOdLqkE0JDkxgDtvJshrBrfsEfBChlTTHRHWAqsZyzXJlJtTM8jG8XN+gFVgfPoFzT6X7FSEr2p00AEuSRwO0Qv5ZlBhxnYmDq5WZ3O4vZrZVPA8aDtVX7hhaBZrGREflAnGg7Ob57b4thmQy1/0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9FX4d3j; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762821242; x=1794357242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FN4CweFd1C3K2bDEXrQI2FrcndJARFnGCMf20zgvu1Y=;
  b=N9FX4d3j8bfY76J5jMxcVaXPPMpeVLD+PxVCmHKgDV1xWD386hafL9Ll
   aVrLz2mD79zHrRg6BkTHt+NtE5dk3Kx2VA3FcWp+qU0+QqkxLYTyT+/3w
   NL4Am7Vc7u2iXnfGsxBFEIvAo5ESCB683ujwEw1RsA5ZAh5x2yDVRSJf4
   Zgu8lZU1pj1Lzzv6dXIPbAaYv3uHYnEOKy2tID3gdM71+kCzUazbXzX7x
   uiP+l5FK67Yz1Zl8KoqTySzOVHoMv92JRAxbRYOvb4jxnbm39Iby8oO9V
   jRDH6ao2NzCIBDtQyEKPowQpHlvmaz2ytd3MeKPEJsNO2BW9xkDRF5Uv0
   Q==;
X-CSE-ConnectionGUID: FOCneySvSkS3u9CqAUoy0g==
X-CSE-MsgGUID: bynp3tFtRW2liu3yXrKw2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52435523"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="52435523"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:34:01 -0800
X-CSE-ConnectionGUID: gia5D1ZLTXaavUo3tBquPQ==
X-CSE-MsgGUID: R6VyaGQBT6+ndZWr6l0zkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193069502"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Nov 2025 16:33:57 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIcKa-0001A3-24;
	Tue, 11 Nov 2025 00:33:56 +0000
Date: Tue, 11 Nov 2025 08:33:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrey.bokhanko@huawei.com,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 07/14] ipvlan: Support IPv6 for learnable
 l2-bridge
Message-ID: <202511110823.oBrdGTfa-lkp@intel.com>
References: <20251105161450.1730216-8-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105161450.1730216-8-skorodumov.dmitry@huawei.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-Preparation-to-support-mac-nat/20251106-004449
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251105161450.1730216-8-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net-next 07/14] ipvlan: Support IPv6 for learnable l2-bridge
config: um-randconfig-r123-20251110 (https://download.01.org/0day-ci/archive/20251111/202511110823.oBrdGTfa-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d445cba39f4dd3dcda4fa1433eca825cf8fc09)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511110823.oBrdGTfa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511110823.oBrdGTfa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ipvlan/ipvlan_core.c:56:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] a @@     got restricted __be32 const [usertype] s_addr @@
   drivers/net/ipvlan/ipvlan_core.c:56:36: sparse:     expected unsigned int [usertype] a
   drivers/net/ipvlan/ipvlan_core.c:56:36: sparse:     got restricted __be32 const [usertype] s_addr
>> drivers/net/ipvlan/ipvlan_core.c:794:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __be16 [usertype] payload_len @@
   drivers/net/ipvlan/ipvlan_core.c:794:23: sparse:     expected unsigned short [usertype] val
   drivers/net/ipvlan/ipvlan_core.c:794:23: sparse:     got restricted __be16 [usertype] payload_len
   drivers/net/ipvlan/ipvlan_core.c:794:23: sparse: sparse: cast from restricted __be16
   drivers/net/ipvlan/ipvlan_core.c:794:23: sparse: sparse: cast from restricted __be16
   drivers/net/ipvlan/ipvlan_core.c:794:19: sparse: sparse: cast from restricted __be16
   drivers/net/ipvlan/ipvlan_core.c:854:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __be16 [usertype] payload_len @@
   drivers/net/ipvlan/ipvlan_core.c:854:23: sparse:     expected unsigned short [usertype] val
   drivers/net/ipvlan/ipvlan_core.c:854:23: sparse:     got restricted __be16 [usertype] payload_len
   drivers/net/ipvlan/ipvlan_core.c:854:23: sparse: sparse: cast from restricted __be16
   drivers/net/ipvlan/ipvlan_core.c:854:23: sparse: sparse: cast from restricted __be16
   drivers/net/ipvlan/ipvlan_core.c:854:19: sparse: sparse: cast from restricted __be16

vim +794 drivers/net/ipvlan/ipvlan_core.c

   785	
   786	static u8 *ipvlan_search_icmp6_ll_addr(struct sk_buff *skb, u8 icmp_option)
   787	{
   788		/* skb is ensured to pullable for all ipv6 payload_len by caller */
   789		struct ipv6hdr *ip6h = ipv6_hdr(skb);
   790		struct icmp6hdr *icmph;
   791		int ndsize, curr_off;
   792	
   793		icmph = (struct icmp6hdr *)(ip6h + 1);
 > 794		ndsize = (int)htons(ip6h->payload_len);
   795		curr_off = sizeof(*icmph);
   796	
   797		if (icmph->icmp6_type != NDISC_ROUTER_SOLICITATION)
   798			curr_off += sizeof(struct in6_addr);
   799	
   800		while ((curr_off + 2) < ndsize) {
   801			u8  *data = (u8 *)icmph + curr_off;
   802			u32 opt_len = data[1] << 3;
   803	
   804			if (unlikely(opt_len == 0))
   805				return NULL;
   806	
   807			if (data[0] != icmp_option) {
   808				curr_off += opt_len;
   809				continue;
   810			}
   811	
   812			if (unlikely(opt_len < ETH_ALEN + 2))
   813				return NULL;
   814	
   815			if (unlikely(curr_off + opt_len > ndsize))
   816				return NULL;
   817	
   818			return data + 2;
   819		}
   820	
   821		return NULL;
   822	}
   823	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

