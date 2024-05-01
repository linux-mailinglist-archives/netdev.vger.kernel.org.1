Return-Path: <netdev+bounces-92725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF118B86DA
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3111F2394B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AE50281;
	Wed,  1 May 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAuj5UpH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDED4F20C;
	Wed,  1 May 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552109; cv=none; b=sX52FUhe9OKBT907LwkkSuZ2clb/T9WDUopDfJCKEhvju1Z+VtQfbLVKGJL+7poD8C/89mc67VZOYdKVruesztilguQGx5LA/9vNlQcmVwmDOX5K54UXiIcazpdkGyv4aYEyvkDoqkaXTZEW8MHdZS/pAeD4llghA+xKj7nPgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552109; c=relaxed/simple;
	bh=56AxXogpxFKhh8f1HjGkA7OqFSCTJhvPZmPtVivTpdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzNvO7z/yHp7BwnycCDIx+uWEpC0XV6L6m/AYQzqBLWnO07NHx2k2LlCkkgr7Fvy4aiKuSl9Q4BhLrlZJIHR5kiJG5lQLW/yoD8sx0W71j918t/VhxAKShz4gUA8AqwdKllwxUgH9GxVC0qgInTuajgsw1q5gIGrePgyBKVUOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAuj5UpH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714552108; x=1746088108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=56AxXogpxFKhh8f1HjGkA7OqFSCTJhvPZmPtVivTpdc=;
  b=iAuj5UpHK8GWGdGELrh4/J8NnCKEJkKS/aU0lo2jeeIuS9O5RYwo2ok0
   gO5z1jPSWXbCjy5MCglZRhNH9aD6vjw1Y/Jk3g/EFfviEgXDGylB06F2F
   JdtKvlANQcNkCU8nXggePpMCINn4FaikjRaaY61leGqvlOCy7BV0OfsY1
   nhN21/QpP15IDztNXUKJpkRblusfOYWz2/clxwDiR+U+IqDX8S8sV/KPV
   ATHytSEtH0scj1W9Vlqa0482i0h+guSfB8ikn3Cqn0eqpOSGCmcD9CsZ0
   FFDF2nY0D9cA4eB+zG1WKhTyuOyk/YrBJlu+L7swxkA3k4ukRf3vpnpKg
   A==;
X-CSE-ConnectionGUID: T/W9RQ0DTeufo3OZ46YEBw==
X-CSE-MsgGUID: qB3QKYdlStGy0SMk7oCJLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14055932"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="14055932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 01:28:27 -0700
X-CSE-ConnectionGUID: hvc6ldjUT2ajfHjFR9pZFA==
X-CSE-MsgGUID: NQQhXkt5QWG/nOARfEMwHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="31335521"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 May 2024 01:28:22 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s25K7-0009EE-0y;
	Wed, 01 May 2024 08:28:19 +0000
Date: Wed, 1 May 2024 16:27:25 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202405011500.J5qSgquf-lkp@intel.com>
References: <20240430173136.15807-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430173136.15807-3-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240501-013413
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240430173136.15807-3-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240501/202405011500.J5qSgquf-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011500.J5qSgquf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405011500.J5qSgquf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/ethtool/coalesce.c:3:
   In file included from include/linux/dim.h:12:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/ethtool/coalesce.c:3:
   In file included from include/linux/dim.h:12:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/ethtool/coalesce.c:3:
   In file included from include/linux/dim.h:12:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/ethtool/coalesce.c:3:
   In file included from include/linux/dim.h:12:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> net/ethtool/coalesce.c:453:41: error: no member named 'irq_moder' in 'struct net_device'
     453 |         struct dim_irq_moder *irq_moder = dev->irq_moder;
         |                                           ~~~  ^
   13 warnings and 1 error generated.


vim +453 net/ethtool/coalesce.c

   424	
   425	/**
   426	 * ethnl_update_profile - get a profile nest with child nests from userspace.
   427	 * @dev: netdevice to update the profile
   428	 * @dst: profile get from the driver and modified by ethnl_update_profile.
   429	 * @nests: nest attr ETHTOOL_A_COALESCE_*X_PROFILE to set profile.
   430	 * @extack: Netlink extended ack
   431	 *
   432	 * Layout of nests:
   433	 *   Nested ETHTOOL_A_COALESCE_*X_PROFILE attr
   434	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
   435	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
   436	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
   437	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
   438	 *     ...
   439	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
   440	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
   441	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
   442	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
   443	 *
   444	 * Return: 0 on success or a negative error code.
   445	 */
   446	static int ethnl_update_profile(struct net_device *dev,
   447					struct dim_cq_moder __rcu **dst,
   448					const struct nlattr *nests,
   449					struct netlink_ext_ack *extack)
   450	{
   451		int len_irq_moder = ARRAY_SIZE(coalesce_irq_moderation_policy);
   452		struct nlattr *tb[ARRAY_SIZE(coalesce_irq_moderation_policy)];
 > 453		struct dim_irq_moder *irq_moder = dev->irq_moder;
   454		struct dim_cq_moder *new_profile, *old_profile;
   455		int ret, rem, i = 0, len;
   456		struct nlattr *nest;
   457	
   458		if (!nests)
   459			return 0;
   460	
   461		if (!*dst)
   462			return -EOPNOTSUPP;
   463	
   464		old_profile = rtnl_dereference(*dst);
   465		len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*old_profile);
   466		new_profile = kmemdup(old_profile, len, GFP_KERNEL);
   467		if (!new_profile)
   468			return -ENOMEM;
   469	
   470		nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
   471					 nests, rem) {
   472			ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
   473					       coalesce_irq_moderation_policy,
   474					       extack);
   475			if (ret)
   476				goto err_out;
   477	
   478			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].usec,
   479						     ETHTOOL_A_IRQ_MODERATION_USEC,
   480						     tb, DIM_COALESCE_USEC,
   481						     extack);
   482			if (ret)
   483				goto err_out;
   484	
   485			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].pkts,
   486						     ETHTOOL_A_IRQ_MODERATION_PKTS,
   487						     tb, DIM_COALESCE_PKTS,
   488						     extack);
   489			if (ret)
   490				goto err_out;
   491	
   492			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].comps,
   493						     ETHTOOL_A_IRQ_MODERATION_COMPS,
   494						     tb, DIM_COALESCE_COMPS,
   495						     extack);
   496			if (ret)
   497				goto err_out;
   498	
   499			i++;
   500		}
   501	
   502		rcu_assign_pointer(*dst, new_profile);
   503		kfree_rcu(old_profile, rcu);
   504	
   505		return 0;
   506	
   507	err_out:
   508		kfree(new_profile);
   509		return ret;
   510	}
   511	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

