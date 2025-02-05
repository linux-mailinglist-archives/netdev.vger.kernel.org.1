Return-Path: <netdev+bounces-162912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FEA2866A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370DD162F15
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3CD22A4F5;
	Wed,  5 Feb 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEcs4xDI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF322A4DF;
	Wed,  5 Feb 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747398; cv=none; b=jAiWJ6WOvh/StBAd0zF0b7cXrFyssPdFKLxYLur+odEujwPs4hqcn8y5P9JABdbvlxCK+rJ/vTNBXeNYH/zzqrGWV5tYgke/wOA9O/KNMrWOXtw0dp4VoErBYXGmyzRBMYJcY7ob1x97jvTTwGtSlZzLRGReRkQ4UYj/ZoaBtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747398; c=relaxed/simple;
	bh=ZIKAtnPAyNIjmRnPJX5oThyH4/D0PWvHXvgPBAiMKSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvHpljwRnpI7w+dVCv2JPk4jTBzeP1UsG4YS9BiOy5T0iyzccT5Ze3sducqKiW0We56y88wsMyprjKnmk9K4eTroDx7jNRmhpESAl4lnmL2t4xUnqbqwmD+TJV8BbxTdKpXmu4zFoKNckgVr7InVsdUez2iKgHTKyxTnKDAG0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEcs4xDI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738747397; x=1770283397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZIKAtnPAyNIjmRnPJX5oThyH4/D0PWvHXvgPBAiMKSw=;
  b=OEcs4xDIiUorrBSkIOyUgUWoG18Z6+fiJxyvV383+Csd+xewLqpcmo6u
   hftzrs8/WjAYTxOCTNrhRbAtD5wdTudPJWtQTzK2nVvNVI5RHH4QzUVs0
   9NdxJMCEH4dKPiJPf7l1ZwoP0X4smn5X+jsPaPtEM4qZgo7q+XdESguHt
   GyinBhSsGz/0DMXtoF/YeastTsp9B0iqiWUh16USuShpQFM+jCNjk3+zm
   y1k4LkCxYrmGtJiwq1danl+oy2+leIMTFyImCBHorTOr/CJQwP0AHPrJU
   syWuAbC4LhnY+wRBbBotqnuLimXErqg1lIN2IYQSsPnR8zafqWqC1LHP3
   Q==;
X-CSE-ConnectionGUID: 7iJeLTAjQ7KHuHFfST/bWA==
X-CSE-MsgGUID: obJyZSOxRfGXjSCOKku0pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39198845"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39198845"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:23:16 -0800
X-CSE-ConnectionGUID: 0p90qPdvTUW8DbIsBJdpKA==
X-CSE-MsgGUID: o1M10QCJTjSRDdZazQc0qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="110826770"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Feb 2025 01:23:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfbcl-000tgt-22;
	Wed, 05 Feb 2025 09:23:11 +0000
Date: Wed, 5 Feb 2025 17:22:21 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, edumazet@google.com,
	sridhar.samudrala@intel.com, Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] netdev-genl: Elide napi_id when not present
Message-ID: <202502051756.62x7XJ1n-lkp@intel.com>
References: <20250204192724.199209-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204192724.199209-1-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c2933b2befe25309f4c5cfbea0ca80909735fd76]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/netdev-genl-Elide-napi_id-when-not-present/20250205-033024
base:   c2933b2befe25309f4c5cfbea0ca80909735fd76
patch link:    https://lore.kernel.org/r/20250204192724.199209-1-jdamato%40fastly.com
patch subject: [PATCH net-next v3] netdev-genl: Elide napi_id when not present
config: i386-buildonly-randconfig-004-20250205 (https://download.01.org/0day-ci/archive/20250205/202502051756.62x7XJ1n-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250205/202502051756.62x7XJ1n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502051756.62x7XJ1n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/netdev-genl.c: In function 'netdev_nl_queue_fill_one':
>> net/core/netdev-genl.c:380:30: warning: variable 'txq' set but not used [-Wunused-but-set-variable]
     380 |         struct netdev_queue *txq;
         |                              ^~~


vim +/txq +380 net/core/netdev-genl.c

4e43e696a7aeb2 Joe Damato      2025-02-04  373  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  374  static int
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  375  netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  376  			 u32 q_idx, u32 q_type, const struct genl_info *info)
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  377  {
d0caf9876a1c9f Mina Almasry    2024-09-10  378  	struct net_devmem_dmabuf_binding *binding;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  379  	struct netdev_rx_queue *rxq;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01 @380  	struct netdev_queue *txq;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  381  	void *hdr;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  382  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  383  	hdr = genlmsg_iput(rsp, info);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  384  	if (!hdr)
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  385  		return -EMSGSIZE;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  386  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  387  	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  388  	    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  389  	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  390  		goto nla_put_failure;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  391  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  392  	switch (q_type) {
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  393  	case NETDEV_QUEUE_TYPE_RX:
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  394  		rxq = __netif_get_rx_queue(netdev, q_idx);
4e43e696a7aeb2 Joe Damato      2025-02-04  395  		if (nla_put_napi_id(rsp, rxq->napi))
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  396  			goto nla_put_failure;
d0caf9876a1c9f Mina Almasry    2024-09-10  397  
d0caf9876a1c9f Mina Almasry    2024-09-10  398  		binding = rxq->mp_params.mp_priv;
d0caf9876a1c9f Mina Almasry    2024-09-10  399  		if (binding &&
d0caf9876a1c9f Mina Almasry    2024-09-10  400  		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
d0caf9876a1c9f Mina Almasry    2024-09-10  401  			goto nla_put_failure;
d0caf9876a1c9f Mina Almasry    2024-09-10  402  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  403  		break;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  404  	case NETDEV_QUEUE_TYPE_TX:
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  405  		txq = netdev_get_tx_queue(netdev, q_idx);
4e43e696a7aeb2 Joe Damato      2025-02-04  406  		if (nla_put_napi_id(rsp, rxq->napi))
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  407  			goto nla_put_failure;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  408  	}
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  409  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  410  	genlmsg_end(rsp, hdr);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  411  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  412  	return 0;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  413  
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  414  nla_put_failure:
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  415  	genlmsg_cancel(rsp, hdr);
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  416  	return -EMSGSIZE;
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  417  }
6b6171db7fc8f7 Amritha Nambiar 2023-12-01  418  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

