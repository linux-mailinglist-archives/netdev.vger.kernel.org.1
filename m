Return-Path: <netdev+bounces-239275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8595C66990
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E399359042
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F0322541;
	Mon, 17 Nov 2025 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QStP5Nah"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBF2FD685;
	Mon, 17 Nov 2025 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423549; cv=none; b=L75HMRU6WtRxasV9PA5eypCLFC+kouZuSYY7iLM3ZlUXwoq4dRh8kas0bLfQpn+bImz9JakkMPwNy3ZrKgzKzg3bG3X4QOk+lqBXAtKAsby8IptFlYqK+kOodkKS/DOPpod+S2hVzAnMuXWfJjL8pKNlaWxVZjM0in7G9cJTCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423549; c=relaxed/simple;
	bh=5/9ZzKmjLweeA38iqstqFd7qFRxWZyVJzBW331JQpQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcJlzpUnl5K5nuzqzsDuDeu/AOJE5T6Ktp3jD7qzVpQrXrsTFeo0NH/+9VWi8/yVcdeYivZQvlFXpfB53fdgfWt/WjYJlOdvdfPx4DACHXw/PHCfUv6a/1p9Xhl2BbHlUCzXqvPjmuH9Gi152fMVXpevqOx9QiY+j+V/F1vOBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QStP5Nah; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763423546; x=1794959546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/9ZzKmjLweeA38iqstqFd7qFRxWZyVJzBW331JQpQ4=;
  b=QStP5NahAHGs1K3tUHN2eK5P9t8OcrNr3/JMUonbLn8VfVv+QO1DOImx
   j/CyWE1C/8e41yRNoC6EI2rcuKTSIEHxi7qqQbQf8PEZj43xYXcyM3+53
   28ARko/2FX4z3UvPcPmGtpfaysfF9Uz/7nZQSlmsXdgu/mM1ac6pFlMAH
   JrfWhzXaw66WuzAE9d0OhH1GvP3VmIBODmorXBOSHXypfN/JXsA7AG+rI
   45B0swWWNAG/Ii2IjkeGf7j+2U63imZ2HK1zvsMn1lEHzHtid59ev09fq
   ByH668+1DyJ2d2P1jNh0w+krf+DpzqSE8pVizzoRnimP6pU+d/Q1RlFKo
   w==;
X-CSE-ConnectionGUID: gC9ln54qST2f4ckcz3zNgA==
X-CSE-MsgGUID: nI1zPgzmTXCI0pqj2W96SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64635189"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="64635189"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 15:52:20 -0800
X-CSE-ConnectionGUID: B7bQ6hbSTbiJpeSGv5mwnA==
X-CSE-MsgGUID: 8iDxqdBESAqGIb5qImQBgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="221501639"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 15:52:08 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vL90t-0001A3-1U;
	Mon, 17 Nov 2025 23:52:03 +0000
Date: Tue, 18 Nov 2025 07:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: azey <me@azey.net>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath API
Message-ID: <202511180742.7iC868V8-lkp@intel.com>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>

Hi azey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main klassert-ipsec/master linus/master v6.18-rc6 next-20251117]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/azey/net-ipv6-allow-device-only-routes-via-the-multipath-API/20251117-023331
base:   net-next/main
patch link:    https://lore.kernel.org/r/a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi%40ychcxqnmy5us
patch subject: [PATCH] net/ipv6: allow device-only routes via the multipath API
config: i386-randconfig-141-20251117 (https://download.01.org/0day-ci/archive/20251118/202511180742.7iC868V8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511180742.7iC868V8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511180742.7iC868V8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/route.c: In function 'rtm_to_fib6_multipath_config':
>> net/ipv6/route.c:5122:22: warning: variable 'has_gateway' set but not used [-Wunused-but-set-variable]
    5122 |                 bool has_gateway = cfg->fc_flags & RTF_GATEWAY;
         |                      ^~~~~~~~~~~


vim +/has_gateway +5122 net/ipv6/route.c

86872cb57925c4 Thomas Graf       2006-08-22  5105  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5106  static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
bd11ff421d36ab Kuniyuki Iwashima 2025-04-17  5107  					struct netlink_ext_ack *extack,
bd11ff421d36ab Kuniyuki Iwashima 2025-04-17  5108  					bool newroute)
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5109  {
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5110  	struct rtnexthop *rtnh;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5111  	int remaining;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5112  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5113  	remaining = cfg->fc_mp_len;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5114  	rtnh = (struct rtnexthop *)cfg->fc_mp;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5115  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5116  	if (!rtnh_ok(rtnh, remaining)) {
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5117  		NL_SET_ERR_MSG(extack, "Invalid nexthop configuration - no valid nexthops");
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5118  		return -EINVAL;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5119  	}
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5120  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5121  	do {
e6f497955fb6a0 Kuniyuki Iwashima 2025-04-17 @5122  		bool has_gateway = cfg->fc_flags & RTF_GATEWAY;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5123  		int attrlen = rtnh_attrlen(rtnh);
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5124  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5125  		if (attrlen > 0) {
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5126  			struct nlattr *nla, *attrs;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5127  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5128  			attrs = rtnh_attrs(rtnh);
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5129  			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5130  			if (nla) {
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5131  				if (nla_len(nla) < sizeof(cfg->fc_gateway)) {
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5132  					NL_SET_ERR_MSG(extack,
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5133  						       "Invalid IPv6 address in RTA_GATEWAY");
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5134  					return -EINVAL;
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5135  				}
e6f497955fb6a0 Kuniyuki Iwashima 2025-04-17  5136  
e6f497955fb6a0 Kuniyuki Iwashima 2025-04-17  5137  				has_gateway = true;
e6f497955fb6a0 Kuniyuki Iwashima 2025-04-17  5138  			}
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5139  		}
e6f497955fb6a0 Kuniyuki Iwashima 2025-04-17  5140  
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5141  		rtnh = rtnh_next(rtnh, &remaining);
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5142  	} while (rtnh_ok(rtnh, remaining));
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5143  
f0a56c17e64bb5 Kuniyuki Iwashima 2025-05-15  5144  	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len, extack);
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5145  }
4cb4861d8c3b3b Kuniyuki Iwashima 2025-04-17  5146  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

