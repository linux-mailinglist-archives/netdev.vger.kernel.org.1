Return-Path: <netdev+bounces-192990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0216AC2008
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C27A504D1A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FFD22539E;
	Fri, 23 May 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaIGlC30"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275352F3E;
	Fri, 23 May 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747993543; cv=none; b=AKCcZcAesy/Bnw/OC5/1GPyCjdXyrySb6nCh2Vjwvga7O2JiwcPCuY81TfED8oYgJqKWqaBK3D2ZKf9WpQeLRgAkyz3BtYFr7I8Z15ngGCrgq/I5E3o621BOML4+EbKojp6a2jO3e7beTNgely0sKaXFt9EYcDug3IUBzfWJGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747993543; c=relaxed/simple;
	bh=nG88vYZabys4ZuUQnt2umFX7vl5FYzFeVs7uVcok0Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbqJUY0A1kkqo6PA14/tLXVflLw6Xu+MicWrsWi8DMY+BMMQaG4eTxxiOZ1DskEvUqJASoxgm5oiFA9T9NnLtARtTt4hb7BcVD85QEY6bD9hd1w7ueJYTNko5cgr4o5uI3VxVze90UBKfEyjL17JyQvuOObo4Q4m59XcTdA0wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaIGlC30; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747993542; x=1779529542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nG88vYZabys4ZuUQnt2umFX7vl5FYzFeVs7uVcok0Ak=;
  b=YaIGlC30B+1r7i27Ra4XUR6dW5kUqf5YpVifWSSVNsn15YQkIpiun6Bl
   R42NOljPEbRks537bD6vKhy4ayypd8z5ZJazSwXDSJENIMbD3X0sZLTvm
   nk5/Gjvx96iD8Ww6STxBK/POOe6NAcBJu2ZyBJQgM1ffLI1JcV8uKUUb8
   4NPEox7fgG4VRZEnUCYsckwVM+wm6rezKdCMR1FGZwti2zUlG7uT9EhM1
   tkNlXTDF4UJjyUv3+phKyy+/MzFWmxFR/h0bBuZbHwz2HizXgceVr82oa
   5Ax8sRf/dFiSsDgBeKOa7Civolw2uqo4AapF+UFbCQMU+1OBC1rirmY2s
   w==;
X-CSE-ConnectionGUID: YzNkBvHpRSmm9wR5F2Q3TQ==
X-CSE-MsgGUID: STkDFozvREyBkqvXC9ITgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53855539"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="53855539"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 02:45:41 -0700
X-CSE-ConnectionGUID: b57hpsxyT9qLeCy43FmWyQ==
X-CSE-MsgGUID: 5ZikwWKkT0S+GHSPVkeX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="140941571"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 May 2025 02:45:35 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIOy5-000QGK-1l;
	Fri, 23 May 2025 09:45:33 +0000
Date: Fri, 23 May 2025 17:44:57 +0800
From: kernel test robot <lkp@intel.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	bridge@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, openwrt-devel@lists.openwrt.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH net-next 1/5] net: bridge: mcast: explicitly track active
 state
Message-ID: <202505231710.LnCUsJMF-lkp@intel.com>
References: <20250522195952.29265-2-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522195952.29265-2-linus.luessing@c0d3.blue>

Hi Linus,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on linus/master v6.15-rc7 next-20250523]
[cannot apply to net-next/main horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-L-ssing/net-bridge-mcast-explicitly-track-active-state/20250523-040914
base:   net/main
patch link:    https://lore.kernel.org/r/20250522195952.29265-2-linus.luessing%40c0d3.blue
patch subject: [PATCH net-next 1/5] net: bridge: mcast: explicitly track active state
config: x86_64-buildonly-randconfig-004-20250523 (https://download.01.org/0day-ci/archive/20250523/202505231710.LnCUsJMF-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505231710.LnCUsJMF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505231710.LnCUsJMF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bridge/br_multicast.c:1135:6: error: expected value in expression
    1135 | #elif
         |      ^
>> net/bridge/br_multicast.c:1180:11: error: no member named 'ip6_active' in 'struct net_bridge_mcast'; did you mean 'ip4_active'?
    1180 |                 brmctx->ip6_active = ip6_active;
         |                         ^~~~~~~~~~
         |                         ip4_active
   include/trace/events/../../../net/bridge/br_private.h:161:10: note: 'ip4_active' declared here
     161 |         bool                            ip4_active;
         |                                         ^
   2 errors generated.


vim +1135 net/bridge/br_multicast.c

  1122	
  1123	static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
  1124						 bool *active)
  1125	{
  1126	#if IS_ENABLED(CONFIG_IPV6)
  1127		if (!__br_multicast_querier_exists(brmctx, &brmctx->ip6_other_query,
  1128						   true))
  1129			*active = false;
  1130	
  1131		if (brmctx->ip6_active == *active)
  1132			return false;
  1133	
  1134		return true;
> 1135	#elif
  1136		*active = false;
  1137		return false;
  1138	#endif
  1139	}
  1140	
  1141	/**
  1142	 * __br_multicast_update_active() - update mcast active state
  1143	 * @brmctx: the bridge multicast context to check
  1144	 * @force_inactive: forcefully deactivate mcast active state
  1145	 * @extack: netlink extended ACK structure
  1146	 *
  1147	 * This (potentially) updates the IPv4/IPv6 multicast active state. And by
  1148	 * that enables or disables snooping of multicast payload traffic in fast
  1149	 * path.
  1150	 *
  1151	 * The multicast active state is set, per protocol family, if:
  1152	 *
  1153	 * - an IGMP/MLD querier is present
  1154	 * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
  1155	 *
  1156	 * And is unset otherwise.
  1157	 *
  1158	 * This function should be called by anything that changes one of the
  1159	 * above prerequisites.
  1160	 *
  1161	 * Return: 0 on success, a negative value otherwise.
  1162	 */
  1163	static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
  1164						bool force_inactive,
  1165						struct netlink_ext_ack *extack)
  1166	{
  1167		bool ip4_active, ip6_active, ip4_changed, ip6_changed;
  1168		int ret = 0;
  1169	
  1170		lockdep_assert_held_once(&brmctx->br->multicast_lock);
  1171	
  1172		ip4_active = !force_inactive;
  1173		ip6_active = !force_inactive;
  1174		ip4_changed = br_ip4_multicast_check_active(brmctx, &ip4_active);
  1175		ip6_changed = br_ip6_multicast_check_active(brmctx, &ip6_active);
  1176	
  1177		if (ip4_changed)
  1178			brmctx->ip4_active = ip4_active;
  1179		if (ip6_changed)
> 1180			brmctx->ip6_active = ip6_active;
  1181	
  1182		return ret;
  1183	}
  1184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

