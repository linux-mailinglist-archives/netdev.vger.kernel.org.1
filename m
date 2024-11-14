Return-Path: <netdev+bounces-144632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456D9C7F77
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D238D282969
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225EDC2E0;
	Thu, 14 Nov 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3K3uWlp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EA8F45
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545225; cv=none; b=LP46AJX24Brz10OWjoE4vJ5tujFfdLBFPnyyfb7Lf5d2KVKpTRM/LDd3khdgGnfdNdtkOmWQqzBIxepryX0JYKwrXBcq2xJTqCQhJ/J4bexedbpD2WJHgkcDAE+RiJIWlWdmDGY153CHhnNPQ0pf/fOpRtglDSDZjXUHlb3oDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545225; c=relaxed/simple;
	bh=jHgYQcryUr1GaM+hJ9CMbD8s/m6IjUnincZCJBLwLYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAxoNNqhhXXyFmnnHgfVQfBUbHlve99BDZrOlD0j+Q42KqBwNSbM5kn1KU08D9FPh8YlCmmfbAreXjQ5i9/XP/4DVrDelediRlQNYYARxSss4xKTIH6iZD0xQtSzkGGL5dP7VbFwCWCYQOQikyLzv1g2p3HWJYYd7jQV9MU5QxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3K3uWlp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731545224; x=1763081224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jHgYQcryUr1GaM+hJ9CMbD8s/m6IjUnincZCJBLwLYY=;
  b=k3K3uWlp6mxBZk8REGvXlG7MT2Rye2wEd7k/98LHCmmjFZUgKolZUw7O
   AOZtYXP1KjJthFlVpt0FtsCVGkEidQ8uayKV5BEsSS5ygPb4YHUJXgnDn
   ggE140klBX1SKkxjnl1MySdibezKqiEoC8kpOA21rvBttptQV71gNQc2x
   tCqz/itm7k9zHYQTKt3HGkSka2oeUdCdpp3j3uzAgKX5mZgauOpzte0PQ
   noFkIllx1Km6z7luTYgdDt/rxzroi9rDsmDFqmB2XV6N/q5RhBTLeL5Pt
   4nI2q5NFDPzuiPNT4eCQNzU8bHLvGM5NFGWyZvfAs5Zvxemf3UNW6oMGm
   w==;
X-CSE-ConnectionGUID: RtRDYu1iR6mhCwDLAL0bfw==
X-CSE-MsgGUID: Mh5bvSOoQluQ3kzzyorilQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="35260707"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="35260707"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:47:03 -0800
X-CSE-ConnectionGUID: nUxA+CzRQKCi/S9ZhEs9MA==
X-CSE-MsgGUID: olXz5HStQnim6Q+DrOnQxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88143996"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2024 16:46:59 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBO0f-0000zt-0u;
	Thu, 14 Nov 2024 00:46:57 +0000
Date: Thu, 14 Nov 2024 08:46:46 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <202411140820.ybeyWmcE-lkp@intel.com>
References: <20241113180034.714102-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113180034.714102-4-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-DR-expand-SWS-STE-callbacks-and-consolidate-common-structs/20241114-022031
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241113180034.714102-4-tariqt%40nvidia.com
patch subject: [PATCH net-next 3/8] devlink: Extend devlink rate API with traffic classes bandwidth management
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20241114/202411140820.ybeyWmcE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140820.ybeyWmcE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140820.ybeyWmcE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/devlink/devl_internal.h:14,
                    from net/devlink/rate.c:7:
   include/net/devlink.h:121:19: error: 'IEEE_8021QAZ_MAX_TCS' undeclared here (not in a function)
     121 |         u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
         |                   ^~~~~~~~~~~~~~~~~~~~
   net/devlink/rate.c: In function 'devlink_nl_rate_set':
>> net/devlink/rate.c:335:13: warning: unused variable 'tc_bw' [-Wunused-variable]
     335 |         u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
         |             ^~~~~


vim +/tc_bw +335 net/devlink/rate.c

   329	
   330	static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
   331				       const struct devlink_ops *ops,
   332				       struct genl_info *info)
   333	{
   334		struct nlattr *nla_parent, **attrs = info->attrs;
 > 335		u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
   336		int err = -EOPNOTSUPP;
   337		u32 priority;
   338		u32 weight;
   339		u64 rate;
   340	
   341		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE]) {
   342			rate = nla_get_u64(attrs[DEVLINK_ATTR_RATE_TX_SHARE]);
   343			if (devlink_rate_is_leaf(devlink_rate))
   344				err = ops->rate_leaf_tx_share_set(devlink_rate, devlink_rate->priv,
   345								  rate, info->extack);
   346			else if (devlink_rate_is_node(devlink_rate))
   347				err = ops->rate_node_tx_share_set(devlink_rate, devlink_rate->priv,
   348								  rate, info->extack);
   349			if (err)
   350				return err;
   351			devlink_rate->tx_share = rate;
   352		}
   353	
   354		if (attrs[DEVLINK_ATTR_RATE_TX_MAX]) {
   355			rate = nla_get_u64(attrs[DEVLINK_ATTR_RATE_TX_MAX]);
   356			if (devlink_rate_is_leaf(devlink_rate))
   357				err = ops->rate_leaf_tx_max_set(devlink_rate, devlink_rate->priv,
   358								rate, info->extack);
   359			else if (devlink_rate_is_node(devlink_rate))
   360				err = ops->rate_node_tx_max_set(devlink_rate, devlink_rate->priv,
   361								rate, info->extack);
   362			if (err)
   363				return err;
   364			devlink_rate->tx_max = rate;
   365		}
   366	
   367		if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY]) {
   368			priority = nla_get_u32(attrs[DEVLINK_ATTR_RATE_TX_PRIORITY]);
   369			if (devlink_rate_is_leaf(devlink_rate))
   370				err = ops->rate_leaf_tx_priority_set(devlink_rate, devlink_rate->priv,
   371								     priority, info->extack);
   372			else if (devlink_rate_is_node(devlink_rate))
   373				err = ops->rate_node_tx_priority_set(devlink_rate, devlink_rate->priv,
   374								     priority, info->extack);
   375	
   376			if (err)
   377				return err;
   378			devlink_rate->tx_priority = priority;
   379		}
   380	
   381		if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT]) {
   382			weight = nla_get_u32(attrs[DEVLINK_ATTR_RATE_TX_WEIGHT]);
   383			if (devlink_rate_is_leaf(devlink_rate))
   384				err = ops->rate_leaf_tx_weight_set(devlink_rate, devlink_rate->priv,
   385								   weight, info->extack);
   386			else if (devlink_rate_is_node(devlink_rate))
   387				err = ops->rate_node_tx_weight_set(devlink_rate, devlink_rate->priv,
   388								   weight, info->extack);
   389	
   390			if (err)
   391				return err;
   392			devlink_rate->tx_weight = weight;
   393		}
   394	
   395		if (attrs[DEVLINK_ATTR_RATE_TC_BW]) {
   396			struct nlattr *nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW];
   397			struct nlattr *tb[DEVLINK_ATTR_RATE_TC_7_BW + 1];
   398			int i;
   399	
   400			err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_TC_7_BW, nla_tc_bw,
   401					       devlink_dl_rate_tc_bw_nl_policy, info->extack);
   402			if (err)
   403				return err;
   404	
   405			for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
   406				if (tb[DEVLINK_ATTR_RATE_TC_0_BW + i])
   407					tc_bw[i] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_0_BW + i]);
   408				else
   409					tc_bw[i] = 0;
   410			}
   411	
   412			if (devlink_rate_is_leaf(devlink_rate))
   413				err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv,
   414							       tc_bw, info->extack);
   415			else if (devlink_rate_is_node(devlink_rate))
   416				err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv,
   417							       tc_bw, info->extack);
   418	
   419			if (err)
   420				return err;
   421	
   422			memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
   423		}
   424	
   425		nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
   426		if (nla_parent) {
   427			err = devlink_nl_rate_parent_node_set(devlink_rate, info,
   428							      nla_parent);
   429			if (err)
   430				return err;
   431		}
   432	
   433		return 0;
   434	}
   435	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

