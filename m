Return-Path: <netdev+bounces-162911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDBA28668
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3946C161A1E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84E22A4ED;
	Wed,  5 Feb 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbtZa1zQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25B22A4DF;
	Wed,  5 Feb 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747339; cv=none; b=dlxGpR92wAjnkJ5tLPRvdWKhRziEDSpTwEH5RFhFOvS5xcwzQEIad23zaQIgeuP6LpgMLnDl3lwZ7JCLkQS9YC8mRQhS0BVF2h1OTVm5Xe4qgV5lhcYIXkrv1beR2tgUkJGRuE8uCp/a++H/Im5M3r8AJBnDjh4NEwB86Jx0j14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747339; c=relaxed/simple;
	bh=omFieM6V/YBx+5h1gv1mtyqffa2yseE/TMNhk4/FaJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5twOuGijGg9hWumtEq7747FNtz7VQImLL5ZRKQ1XcJCKLXEgCchPKVDbbh6ZU+rg6/JZipu8w4zXqYyXP1aQ8MYeClLSOPU2XOL/Dj4CbteDJ+7tytS0enklwFzLixDNwnKLn4ar0ql2UF2OmyifM2GAoBU6tH1k9JxjCSZAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbtZa1zQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738747337; x=1770283337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omFieM6V/YBx+5h1gv1mtyqffa2yseE/TMNhk4/FaJM=;
  b=LbtZa1zQ8gaE9brLJY+CiFfldylr0VFvW/XMIk52WL20HI26hhyhuLiJ
   7FynS3Y7Qkmp9xOR5JfcF0dVTYk+IctH6kEwnj5Ia5uMspW8mGKbnEifq
   CqJPt4AfpA6BtP9xzWLjwDY2qvQQph3MZiUyOvTGuePQ1sza9tGJeJ3lV
   zWTsqfWFNiiXhXBopoxmYyYKjI0YxMo+GhKaRznuXuK//Bs2SgQ/cNBQO
   AKqL5k4pIdiJievN6G4yw6+Y4J+KvjYs6KCCXEExCf3FaoC86Xlj8X535
   HErvD5pA6z1ezy14SGPGgl+S2A/3p9OsKYOo/TnwuWAjQgzsl6O56yakU
   A==;
X-CSE-ConnectionGUID: PGofnNlUQRy0qfbK8NU/rQ==
X-CSE-MsgGUID: lmxXH5cuQjW3CZ20IFWhYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43056416"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43056416"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:22:17 -0800
X-CSE-ConnectionGUID: UYzIa9LxQQ6j3d39LmOylA==
X-CSE-MsgGUID: ujuNv5kERDC+mUiEhi0QAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115897627"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 01:22:13 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfbbn-000tgh-1V;
	Wed, 05 Feb 2025 09:22:11 +0000
Date: Wed, 5 Feb 2025 17:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] netdev-genl: Elide napi_id when not present
Message-ID: <202502051721.hL1sw85A-lkp@intel.com>
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
config: i386-buildonly-randconfig-006-20250205 (https://download.01.org/0day-ci/archive/20250205/202502051721.hL1sw85A-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250205/202502051721.hL1sw85A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502051721.hL1sw85A-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/netdev-genl.c:380:23: warning: variable 'txq' set but not used [-Wunused-but-set-variable]
     380 |         struct netdev_queue *txq;
         |                              ^
>> net/core/netdev-genl.c:406:28: warning: variable 'rxq' is uninitialized when used here [-Wuninitialized]
     406 |                 if (nla_put_napi_id(rsp, rxq->napi))
         |                                          ^~~
   net/core/netdev-genl.c:379:29: note: initialize the variable 'rxq' to silence this warning
     379 |         struct netdev_rx_queue *rxq;
         |                                    ^
         |                                     = NULL
   2 warnings generated.


vim +/rxq +406 net/core/netdev-genl.c

   373	
   374	static int
   375	netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
   376				 u32 q_idx, u32 q_type, const struct genl_info *info)
   377	{
   378		struct net_devmem_dmabuf_binding *binding;
   379		struct netdev_rx_queue *rxq;
   380		struct netdev_queue *txq;
   381		void *hdr;
   382	
   383		hdr = genlmsg_iput(rsp, info);
   384		if (!hdr)
   385			return -EMSGSIZE;
   386	
   387		if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
   388		    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
   389		    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
   390			goto nla_put_failure;
   391	
   392		switch (q_type) {
   393		case NETDEV_QUEUE_TYPE_RX:
   394			rxq = __netif_get_rx_queue(netdev, q_idx);
   395			if (nla_put_napi_id(rsp, rxq->napi))
   396				goto nla_put_failure;
   397	
   398			binding = rxq->mp_params.mp_priv;
   399			if (binding &&
   400			    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
   401				goto nla_put_failure;
   402	
   403			break;
   404		case NETDEV_QUEUE_TYPE_TX:
   405			txq = netdev_get_tx_queue(netdev, q_idx);
 > 406			if (nla_put_napi_id(rsp, rxq->napi))
   407				goto nla_put_failure;
   408		}
   409	
   410		genlmsg_end(rsp, hdr);
   411	
   412		return 0;
   413	
   414	nla_put_failure:
   415		genlmsg_cancel(rsp, hdr);
   416		return -EMSGSIZE;
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

