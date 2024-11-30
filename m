Return-Path: <netdev+bounces-147900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716A9DEF0B
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 06:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E157C281954
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 05:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0813AD3F;
	Sat, 30 Nov 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvoZvbZC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114D43179;
	Sat, 30 Nov 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732945714; cv=none; b=ZT6e1xDVSigdNfAmTlxxmxrX50G4D2x1P7wx7dhu/TDLkaxRi+LMWKIoc2w/UrtFeB5KZYEpfqA44uzL/hNY3Qi4ROJ8odTLvLC10zY1FGZ8BWBjUU8v4A4D/yXmIH1kR2CJ/2bFyRPBL75b4qWxNPSeDD6vLGRXRHDYKytDFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732945714; c=relaxed/simple;
	bh=drGWNSrEydr7H0DEuuYjrcKDU4y0qKHm3EoNDN1Dzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6ewGMwTdRAetodVUQPaXq3dCY5L+z0D1ggx3iXU7xzhuGNS0Y+owIc2B/KCmGJg5UuGzw/6e21tHvBB65ss0JnbuWOCUYhZd5Pl0P9SzhVVhjz+7KafzEatHo7NMJl8Surp9eijEOfUo988aZdqvaGQorzP+MUHEOIXT8FtUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvoZvbZC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732945713; x=1764481713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=drGWNSrEydr7H0DEuuYjrcKDU4y0qKHm3EoNDN1Dzqw=;
  b=HvoZvbZCl8s4qDos2os+HS6EQMOEhYfTpuxSY2VrDhj/7Yvi3vrP8hgZ
   9GyxHqM7jaOPwytP1imEy3swN0TUTkF0r1BWcmLO3kBCbk+lRJh2EXiZt
   hJi4JlV36zQK7g7xt0PfWf1Ck/DG/ZL/HlZ0ncThiQx5rw4pc+frscpTj
   YYg4RnEYNIbhFCWZzAg05ALxbifcTR6gbHAI9x6Gi9jbOgtCiqTHK1Cdx
   BFRaO4oheViuEzMy+LvhvsKlTXHQGji7r+ush427+RCzbjDVI5GUX5WAQ
   ftcmmYKCLo+OrmO4/QHPZsJCRCk/oQLT1WVlYjlS+sWcH9VA9IYED35Ce
   A==;
X-CSE-ConnectionGUID: Cp3t9EymTbGJdh92yOSJ1A==
X-CSE-MsgGUID: tH2TU+lvQdq841mOMjHhRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="33299916"
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="33299916"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 21:48:32 -0800
X-CSE-ConnectionGUID: FXvhDrQBTAu3VqVCqlvLPw==
X-CSE-MsgGUID: B/pukYGWRnKC5J2rNJpL+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="92804226"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 29 Nov 2024 21:48:26 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHGL9-00007T-1A;
	Sat, 30 Nov 2024 05:48:23 +0000
Date: Sat, 30 Nov 2024 13:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Strohman <andrew@andrewstrohman.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Andy Strohman <andrew@andrewstrohman.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for
 Q-in-Q
Message-ID: <202411301325.5uGYbi6q-lkp@intel.com>
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130000802.2822146-1-andrew@andrewstrohman.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Strohman/bridge-Make-the-FDB-consider-inner-tag-for-Q-in-Q/20241130-080335
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241130000802.2822146-1-andrew%40andrewstrohman.com
patch subject: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241130/202411301325.5uGYbi6q-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411301325.5uGYbi6q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411301325.5uGYbi6q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_main.c:13106: warning: Function parameter or struct member 'inner_vid' not described in 'i40e_ndo_fdb_add'
--
>> drivers/net/ethernet/intel/ice/ice_main.c:6167: warning: Function parameter or struct member 'inner_vid' not described in 'ice_fdb_add'
>> drivers/net/ethernet/intel/ice/ice_main.c:6208: warning: Function parameter or struct member 'inner_vid' not described in 'ice_fdb_del'


vim +13106 drivers/net/ethernet/intel/i40e/i40e_main.c

1f224ad2f76028 Neerav Parikh    2014-02-12  13089  
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13090  /**
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13091   * i40e_ndo_fdb_add - add an entry to the hardware database
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13092   * @ndm: the input from the stack
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13093   * @tb: pointer to array of nladdr (unused)
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13094   * @dev: the net device pointer
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13095   * @addr: the MAC address entry being added
f5254429e1756a Jacob Keller     2018-04-20  13096   * @vid: VLAN ID
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13097   * @flags: instructions from stack about fdb operation
4b42fbc6bd8f73 Petr Machata     2024-11-14  13098   * @notified: whether notification was emitted
b50f7bca5e83d9 Jesse Brandeburg 2020-09-25  13099   * @extack: netlink extended ack, unused currently
2f90ade661b3bd Jesse Brandeburg 2014-11-20  13100   */
4ba0dea5b17369 Greg Rose        2014-03-06  13101  static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
4ba0dea5b17369 Greg Rose        2014-03-06  13102  			    struct net_device *dev,
eae5d6a6f80427 Andy Strohman    2024-11-30  13103  			    const unsigned char *addr, u16 vid, u16 inner_vid,
4b42fbc6bd8f73 Petr Machata     2024-11-14  13104  			    u16 flags, bool *notified,
87b0984ebfabaf Petr Machata     2019-01-16  13105  			    struct netlink_ext_ack *extack)
4ba0dea5b17369 Greg Rose        2014-03-06 @13106  {
4ba0dea5b17369 Greg Rose        2014-03-06  13107  	struct i40e_netdev_priv *np = netdev_priv(dev);
4ba0dea5b17369 Greg Rose        2014-03-06  13108  	struct i40e_pf *pf = np->vsi->back;
4ba0dea5b17369 Greg Rose        2014-03-06  13109  	int err = 0;
4ba0dea5b17369 Greg Rose        2014-03-06  13110  
70756d0a4727fe Ivan Vecera      2023-11-13  13111  	if (!test_bit(I40E_FLAG_SRIOV_ENA, pf->flags))
4ba0dea5b17369 Greg Rose        2014-03-06  13112  		return -EOPNOTSUPP;
4ba0dea5b17369 Greg Rose        2014-03-06  13113  
eae5d6a6f80427 Andy Strohman    2024-11-30  13114  	if (vid || inner_vid) {
65891feac27e26 Or Gerlitz       2014-12-14  13115  		pr_info("%s: vlans aren't supported yet for dev_uc|mc_add()\n", dev->name);
65891feac27e26 Or Gerlitz       2014-12-14  13116  		return -EINVAL;
65891feac27e26 Or Gerlitz       2014-12-14  13117  	}
65891feac27e26 Or Gerlitz       2014-12-14  13118  
4ba0dea5b17369 Greg Rose        2014-03-06  13119  	/* Hardware does not support aging addresses so if a
4ba0dea5b17369 Greg Rose        2014-03-06  13120  	 * ndm_state is given only allow permanent addresses
4ba0dea5b17369 Greg Rose        2014-03-06  13121  	 */
4ba0dea5b17369 Greg Rose        2014-03-06  13122  	if (ndm->ndm_state && !(ndm->ndm_state & NUD_PERMANENT)) {
4ba0dea5b17369 Greg Rose        2014-03-06  13123  		netdev_info(dev, "FDB only supports static addresses\n");
4ba0dea5b17369 Greg Rose        2014-03-06  13124  		return -EINVAL;
4ba0dea5b17369 Greg Rose        2014-03-06  13125  	}
4ba0dea5b17369 Greg Rose        2014-03-06  13126  
4ba0dea5b17369 Greg Rose        2014-03-06  13127  	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
4ba0dea5b17369 Greg Rose        2014-03-06  13128  		err = dev_uc_add_excl(dev, addr);
4ba0dea5b17369 Greg Rose        2014-03-06  13129  	else if (is_multicast_ether_addr(addr))
4ba0dea5b17369 Greg Rose        2014-03-06  13130  		err = dev_mc_add_excl(dev, addr);
4ba0dea5b17369 Greg Rose        2014-03-06  13131  	else
4ba0dea5b17369 Greg Rose        2014-03-06  13132  		err = -EINVAL;
4ba0dea5b17369 Greg Rose        2014-03-06  13133  
4ba0dea5b17369 Greg Rose        2014-03-06  13134  	/* Only return duplicate errors if NLM_F_EXCL is set */
4ba0dea5b17369 Greg Rose        2014-03-06  13135  	if (err == -EEXIST && !(flags & NLM_F_EXCL))
4ba0dea5b17369 Greg Rose        2014-03-06  13136  		err = 0;
4ba0dea5b17369 Greg Rose        2014-03-06  13137  
4ba0dea5b17369 Greg Rose        2014-03-06  13138  	return err;
4ba0dea5b17369 Greg Rose        2014-03-06  13139  }
4ba0dea5b17369 Greg Rose        2014-03-06  13140  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

