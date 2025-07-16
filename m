Return-Path: <netdev+bounces-207416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DEEB0716D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0297B5DAB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FC286D4E;
	Wed, 16 Jul 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKMsjsIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8028A1C8
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657480; cv=none; b=mzKaKGcuoFMz48u45+mFIpaEZBjqsj8PtmJrWG/AjsjjEKeGGxTNPg+0xw0vz4lkD6dGbixLnDIePg+GG4v+LVxHXvzCra75f1mqn5vYjf18Tutcb9BiwX4VEY70G8eXpLxriOHp3VylEK9krGiC5lgk41qwyGuRjQ+jDzaPwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657480; c=relaxed/simple;
	bh=sZzw9kyY34jAPBznLdNul9tVLE2NyjDRxXRBW3M/ue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPel/Q6EanUlbTcjSZbioE8MS2HiUC8oAleqPkHoOFBvvNMgbL8XaLaarAunJ+SoPzG/FWxO1Wdt+M2R+e+Y4sZ1njodlImwT9sWXdiLKeNN2W7IiGq/ds8TlzdCHFDSjwjJYlvH/0ZwG8k4eL2UQ447uw4gKGw0Wx0hSh7JlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKMsjsIQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752657478; x=1784193478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZzw9kyY34jAPBznLdNul9tVLE2NyjDRxXRBW3M/ue0=;
  b=VKMsjsIQy1pbWv6sBZaLG+lXY4CMGplKcVVheFhjntCtSPjOVPZszEJU
   qXv4RLUAkO3O3na9x2ZgLYqPCrAeD+iHG5D04Q867WjGrLkzH0UG3CiPN
   WjK8UcZjICBiGPPsqLc/1ufZti+V+Yey8prvGt1DcTnFVXuK/fULc/alt
   tKC4u7DgB2ZWjLeBOTpZpG/vprNBSvvmVIvZgmCVa4f7dsk6dGKzPpXGO
   0GSxRs2PywxLvgZu4H/ixD+Bc6kY+jHL9L7SKtr3gg63AMkxeOKG9YwnL
   Lzj31tBMEa/NVvEKkgdZnGIqmDOs0n5tmMgGW3eXNBdUKae50bA9Z3yfS
   g==;
X-CSE-ConnectionGUID: hmOsmp0ZRbyEV1ZiB44QwA==
X-CSE-MsgGUID: 7vmciUPPROu4gYdws9FHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58664874"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58664874"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:17:58 -0700
X-CSE-ConnectionGUID: apUx6ZhvTv+x8JB8XteqEQ==
X-CSE-MsgGUID: ZYonpdxFQT2m0kSvW3xiGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="158005134"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jul 2025 02:17:55 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubyGu-000CAX-2x;
	Wed, 16 Jul 2025 09:17:52 +0000
Date: Wed, 16 Jul 2025 17:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jv@jvosburgh.net, wilder@us.ibm.com,
	pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com, i.maximets@ovn.org,
	amorenoz@redhat.com, haliu@redhat.com
Subject: Re: [PATCH net-next v5 6/7] bonding: Update for extended
 arp_ip_target format.
Message-ID: <202507161722.3vSVtA6S-lkp@intel.com>
References: <20250714225533.1490032-7-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714225533.1490032-7-wilder@us.ibm.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wilder/bonding-Adding-struct-bond_arp_target/20250715-065747
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250714225533.1490032-7-wilder%40us.ibm.com
patch subject: [PATCH net-next v5 6/7] bonding: Update for extended arp_ip_target format.
config: i386-randconfig-063-20250716 (https://download.01.org/0day-ci/archive/20250716/202507161722.3vSVtA6S-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507161722.3vSVtA6S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507161722.3vSVtA6S-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/bonding/bond_netlink.c:712:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __be32 [usertype] target_ip @@
   drivers/net/bonding/bond_netlink.c:712:35: sparse:     expected unsigned int [usertype] addr
   drivers/net/bonding/bond_netlink.c:712:35: sparse:     got restricted __be32 [usertype] target_ip

vim +712 drivers/net/bonding/bond_netlink.c

   660	
   661	static int bond_fill_info(struct sk_buff *skb,
   662				  const struct net_device *bond_dev)
   663	{
   664		struct bonding *bond = netdev_priv(bond_dev);
   665		unsigned int packets_per_slave;
   666		int ifindex, i, targets_added;
   667		struct nlattr *targets;
   668		struct slave *primary;
   669	
   670		if (nla_put_u8(skb, IFLA_BOND_MODE, BOND_MODE(bond)))
   671			goto nla_put_failure;
   672	
   673		ifindex = bond_option_active_slave_get_ifindex(bond);
   674		if (ifindex && nla_put_u32(skb, IFLA_BOND_ACTIVE_SLAVE, ifindex))
   675			goto nla_put_failure;
   676	
   677		if (nla_put_u32(skb, IFLA_BOND_MIIMON, bond->params.miimon))
   678			goto nla_put_failure;
   679	
   680		if (nla_put_u32(skb, IFLA_BOND_UPDELAY,
   681				bond->params.updelay * bond->params.miimon))
   682			goto nla_put_failure;
   683	
   684		if (nla_put_u32(skb, IFLA_BOND_DOWNDELAY,
   685				bond->params.downdelay * bond->params.miimon))
   686			goto nla_put_failure;
   687	
   688		if (nla_put_u32(skb, IFLA_BOND_PEER_NOTIF_DELAY,
   689				bond->params.peer_notif_delay * bond->params.miimon))
   690			goto nla_put_failure;
   691	
   692		if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
   693			goto nla_put_failure;
   694	
   695		if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))
   696			goto nla_put_failure;
   697	
   698		targets = nla_nest_start_noflag(skb, IFLA_BOND_ARP_IP_TARGET);
   699		if (!targets)
   700			goto nla_put_failure;
   701	
   702		targets_added = 0;
   703		for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
   704			struct bond_arp_target *target = &bond->params.arp_targets[i];
   705			struct Data {
   706				__u32 addr;
   707				struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
   708			} data;
   709			int size = 0;
   710	
   711			if (target->target_ip) {
 > 712				data.addr = target->target_ip;
   713				size = sizeof(target->target_ip);
   714			}
   715	
   716			for (int level = 0; target->flags & BOND_TARGET_USERTAGS && target->tags; level++) {
   717				if (level > BOND_MAX_VLAN_TAGS)
   718					goto nla_put_failure;
   719	
   720				memcpy(&data.vlans[level], &target->tags[level],
   721				       sizeof(struct bond_vlan_tag));
   722				size = size + sizeof(struct bond_vlan_tag);
   723	
   724				if (target->tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
   725					break;
   726			}
   727	
   728			if (size) {
   729				if (nla_put(skb, i, size, &data))
   730					goto nla_put_failure;
   731				targets_added = 1;
   732			}
   733		}
   734	
   735		if (targets_added)
   736			nla_nest_end(skb, targets);
   737		else
   738			nla_nest_cancel(skb, targets);
   739	
   740		if (nla_put_u32(skb, IFLA_BOND_ARP_VALIDATE, bond->params.arp_validate))
   741			goto nla_put_failure;
   742	
   743		if (nla_put_u32(skb, IFLA_BOND_ARP_ALL_TARGETS,
   744				bond->params.arp_all_targets))
   745			goto nla_put_failure;
   746	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

