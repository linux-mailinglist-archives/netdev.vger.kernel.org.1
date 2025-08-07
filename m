Return-Path: <netdev+bounces-212078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8FB1DC7B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C08727A6E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2E626E715;
	Thu,  7 Aug 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfGb6W4c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68726D4C6;
	Thu,  7 Aug 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587988; cv=none; b=k4NfyV/IYqIAM33rWo3RaGo/vx1czTcTzASXGnsFE7JWtVYgNptupoAV9C+vzqVGY0RkZ27+6CvzbO8mmxl7lc9dHnXFwk/w5DzQ0gikESZ2qHAGpkSEoK7S8WbWhNc4qECtzJSs6LZwfKMtaCLlELawAYneaUE82WB/MqKC60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587988; c=relaxed/simple;
	bh=DZ6NOr0ehfLg9BnUOTsa6g/71Hf2SIfO/iwKjdaAA7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1426LPeP9902RTZ/iO/ZWzvKAq9tR5r/lMpf4uf0gf8VeMprVQG1iKe03jZyYiJtTpvW/ikssAjrBf/lPvJiqWosDvXCPr9NQMRRb1wvC8Z6bXbPUdI15/COfRSHdnddiHj5a6g2NvQj77KiG0/v+EU5/uSF37PQyD71fGQ64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfGb6W4c; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754587987; x=1786123987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZ6NOr0ehfLg9BnUOTsa6g/71Hf2SIfO/iwKjdaAA7w=;
  b=HfGb6W4cV7tylg5cGCKpjPtE/1n0kZZXln2BCdauEOOzq7u3WLvNjVyN
   a2XvGk35jCAL5FLQTZaLLRnLuLCxwDRpu/LcdXPg2/aA5LKjiE0D+hhjh
   bBCyTA7Ja96tZdv6F7XG/l061PoGdOgitJK1xXoRMAhCrn12SRnCfNYd0
   +Cx5Ddv5fAe6p6EHWdFU/28LitpmKvsHoM/AC660jQO8U1baiPnl1Wf3K
   RZlqDJLvCcNXlEkv8lXpRX87a/HYf8NzpGKXgBZPPAVOl4y6R2brWc8RR
   CcjChceJwjuLoFegaTa1l54kVUfKhU+Hy4mBlYSPXfQGwyetlrKP/V0GA
   Q==;
X-CSE-ConnectionGUID: Q4y2qtGbTB+ibtPDnQX2Jg==
X-CSE-MsgGUID: 5UHDbTKzQcSvn44oqzlRLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67524295"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67524295"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:33:06 -0700
X-CSE-ConnectionGUID: Mtwx5TdMQy6/jwJ7WC8qBg==
X-CSE-MsgGUID: GbNqTIhZQ2KbqsOwRT42hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164367144"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 07 Aug 2025 10:33:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk4U2-000338-31;
	Thu, 07 Aug 2025 17:32:59 +0000
Date: Fri, 8 Aug 2025 01:32:12 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, idosch@idosch.org
Cc: oe-kbuild-all@lists.linux.dev, dsahern@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: vrf: don't down the interface when add
 slave
Message-ID: <202508080147.1G52KerV-lkp@intel.com>
References: <20250807055634.113753-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807055634.113753-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-vrf-don-t-down-the-interface-when-add-slave/20250807-140407
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250807055634.113753-1-dongml2%40chinatelecom.cn
patch subject: [PATCH net-next v2] net: vrf: don't down the interface when add slave
config: arc-randconfig-001-20250808 (https://download.01.org/0day-ci/archive/20250808/202508080147.1G52KerV-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250808/202508080147.1G52KerV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508080147.1G52KerV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/lock_debug.c: In function 'netdev_debug_event':
>> net/core/lock_debug.c:20:9: warning: enumeration value 'NETDEV_VRF_MASTER' not handled in switch [-Wswitch]
      20 |         switch (cmd) {
         |         ^~~~~~


vim +/NETDEV_VRF_MASTER +20 net/core/lock_debug.c

03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  11  
1901066aab7654 net/core/lock_debug.c     Stanislav Fomichev 2025-04-01  12  int netdev_debug_event(struct notifier_block *nb, unsigned long event,
1901066aab7654 net/core/lock_debug.c     Stanislav Fomichev 2025-04-01  13  		       void *ptr)
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  14  {
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  15  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  16  	struct net *net = dev_net(dev);
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  17  	enum netdev_cmd cmd = event;
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  18  
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  19  	/* Keep enum and don't add default to trigger -Werror=switch */
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04 @20  	switch (cmd) {
22cbc1ee268b7e net/core/lock_debug.c     Jakub Kicinski     2025-04-15  21  	case NETDEV_XDP_FEAT_CHANGE:
22cbc1ee268b7e net/core/lock_debug.c     Jakub Kicinski     2025-04-15  22  		netdev_assert_locked(dev);
22cbc1ee268b7e net/core/lock_debug.c     Jakub Kicinski     2025-04-15  23  		fallthrough;
cb7103298d1c5d net/core/lock_debug.c     Jakub Kicinski     2025-04-10  24  	case NETDEV_CHANGE:
1901066aab7654 net/core/lock_debug.c     Stanislav Fomichev 2025-04-01  25  	case NETDEV_REGISTER:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  26  	case NETDEV_UP:
1901066aab7654 net/core/lock_debug.c     Stanislav Fomichev 2025-04-01  27  		netdev_ops_assert_locked(dev);
1901066aab7654 net/core/lock_debug.c     Stanislav Fomichev 2025-04-01  28  		fallthrough;
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  29  	case NETDEV_DOWN:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  30  	case NETDEV_REBOOT:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  31  	case NETDEV_UNREGISTER:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  32  	case NETDEV_CHANGEMTU:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  33  	case NETDEV_CHANGEADDR:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  34  	case NETDEV_PRE_CHANGEADDR:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  35  	case NETDEV_GOING_DOWN:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  36  	case NETDEV_FEAT_CHANGE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  37  	case NETDEV_BONDING_FAILOVER:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  38  	case NETDEV_PRE_UP:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  39  	case NETDEV_PRE_TYPE_CHANGE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  40  	case NETDEV_POST_TYPE_CHANGE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  41  	case NETDEV_POST_INIT:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  42  	case NETDEV_PRE_UNINIT:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  43  	case NETDEV_RELEASE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  44  	case NETDEV_NOTIFY_PEERS:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  45  	case NETDEV_JOIN:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  46  	case NETDEV_CHANGEUPPER:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  47  	case NETDEV_RESEND_IGMP:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  48  	case NETDEV_PRECHANGEMTU:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  49  	case NETDEV_CHANGEINFODATA:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  50  	case NETDEV_BONDING_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  51  	case NETDEV_PRECHANGEUPPER:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  52  	case NETDEV_CHANGELOWERSTATE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  53  	case NETDEV_UDP_TUNNEL_PUSH_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  54  	case NETDEV_UDP_TUNNEL_DROP_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  55  	case NETDEV_CHANGE_TX_QUEUE_LEN:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  56  	case NETDEV_CVLAN_FILTER_PUSH_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  57  	case NETDEV_CVLAN_FILTER_DROP_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  58  	case NETDEV_SVLAN_FILTER_PUSH_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  59  	case NETDEV_SVLAN_FILTER_DROP_INFO:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  60  	case NETDEV_OFFLOAD_XSTATS_ENABLE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  61  	case NETDEV_OFFLOAD_XSTATS_DISABLE:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  62  	case NETDEV_OFFLOAD_XSTATS_REPORT_USED:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  63  	case NETDEV_OFFLOAD_XSTATS_REPORT_DELTA:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  64  		ASSERT_RTNL();
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  65  		break;
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  66  
be94cfdb993ff0 net/core/rtnl_net_debug.c Kuniyuki Iwashima  2025-01-15  67  	case NETDEV_CHANGENAME:
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  68  		ASSERT_RTNL_NET(net);
be94cfdb993ff0 net/core/rtnl_net_debug.c Kuniyuki Iwashima  2025-01-15  69  		break;
be94cfdb993ff0 net/core/rtnl_net_debug.c Kuniyuki Iwashima  2025-01-15  70  	}
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  71  
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  72  	return NOTIFY_DONE;
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  73  }
1901066aab7654 net/core/lock_debug.c     Stanislav Fomichev 2025-04-01  74  EXPORT_SYMBOL_NS_GPL(netdev_debug_event, "NETDEV_INTERNAL");
03fa534856593b net/core/rtnl_net_debug.c Kuniyuki Iwashima  2024-10-04  75  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

