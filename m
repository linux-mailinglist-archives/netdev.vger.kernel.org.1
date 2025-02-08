Return-Path: <netdev+bounces-164282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB3A2D3A1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0151684DA
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B61632CA;
	Sat,  8 Feb 2025 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX7HsPoF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E064EB51;
	Sat,  8 Feb 2025 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738987384; cv=none; b=OEqAYn+JD6Wir8+cBMFVHfDxY2MYjfUxdjYcq8QoTrfed2AAx7YRg49FdHW9Yzu5u1xNn86jEOaJUq7BYMLc5mTwmqOkrL04hD3Ek9hlEqCzhHc3h1qRFfleRhuUP8y840UixP6GYojM9rO0RoLWD6nxhFqCxb9a1PbcWLFZaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738987384; c=relaxed/simple;
	bh=7w1wbifFqli/Z6iK9htLZF5fuWaXyXeAXa24eNfZ1rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8dmCOO8rNSwD4AbiLXL3xa1TI/kWOEmlSWVoshTxocbYt8JuMIt1qAdc9XQf/bNB8ygCw7JS8lZVEljoxgaG4CJcBBILWvY+KG0KD3B+FlAVh/cs5IVFBx53EOU//aLN42hYvHxEnxSeyZAvv9KRmVwXoPHEwMHP0Q3PDs2+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX7HsPoF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738987381; x=1770523381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7w1wbifFqli/Z6iK9htLZF5fuWaXyXeAXa24eNfZ1rM=;
  b=JX7HsPoF+NBnhjRJOYy1lYa5933tlTjvUaphfEppsLBniv+Ut1pWy6Yc
   sAFi1jAHJgP03uvvVE6wTznjDLpWRS+opAx+kbHhw0XDtvmPcjrWAknOS
   qaHU7SY6vH3oN0Pss+kzVGuh9YOduUL/KcnSn+b6JTOJnBpazByjw5G30
   TVT0EkrPv3vocJcRyB21EKRgOKzhNUi058v0wm2DHVBFrMuqJKJkBog7k
   roGIy5CP6Z3Ot5RilMOw7ufErbMPXIsunjkj72enEqr2hdiGbgXDpKSUR
   NBTqFGuFKiSaKGdiwstX4gcU8ikJ+V3uI+r61tWImfp9n0gahg2jUVfWe
   A==;
X-CSE-ConnectionGUID: e+t3wjFNQdyFZAqWO41ZeA==
X-CSE-MsgGUID: XaBvzwIdT3yCK1r7W8EZ4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57055706"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="57055706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 20:03:00 -0800
X-CSE-ConnectionGUID: H6AH0HuzSGSs2dQn5qyBlw==
X-CSE-MsgGUID: BEj6K6kNS9mAXJ5iad85+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="111906998"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Feb 2025 20:02:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgc3S-000zVL-0p;
	Sat, 08 Feb 2025 04:02:54 +0000
Date: Sat, 8 Feb 2025 12:02:01 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, edumazet@google.com,
	sridhar.samudrala@intel.com, Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	David Wei <dw@davidwei.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <202502081141.R4zMr9v1-lkp@intel.com>
References: <20250207030916.32751-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207030916.32751-3-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f3eba8edd885db439f4bfaa2cf9d766bad1ae6c5]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/netlink-Add-nla_put_empty_nest-helper/20250207-111126
base:   f3eba8edd885db439f4bfaa2cf9d766bad1ae6c5
patch link:    https://lore.kernel.org/r/20250207030916.32751-3-jdamato%40fastly.com
patch subject: [PATCH net-next v4 2/3] netdev-genl: Add an XSK attribute to queues
config: i386-buildonly-randconfig-001-20250208 (https://download.01.org/0day-ci/archive/20250208/202502081141.R4zMr9v1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502081141.R4zMr9v1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502081141.R4zMr9v1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/netdev-genl.c: In function 'netdev_nl_queue_fill_one':
>> net/core/netdev-genl.c:383:13: warning: unused variable 'ret' [-Wunused-variable]
     383 |         int ret;
         |             ^~~


vim +/ret +383 net/core/netdev-genl.c

   374	
   375	static int
   376	netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
   377				 u32 q_idx, u32 q_type, const struct genl_info *info)
   378	{
   379		struct pp_memory_provider_params *params;
   380		struct netdev_rx_queue *rxq;
   381		struct netdev_queue *txq;
   382		void *hdr;
 > 383		int ret;
   384	
   385		hdr = genlmsg_iput(rsp, info);
   386		if (!hdr)
   387			return -EMSGSIZE;
   388	
   389		if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
   390		    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
   391		    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
   392			goto nla_put_failure;
   393	
   394		switch (q_type) {
   395		case NETDEV_QUEUE_TYPE_RX:
   396			rxq = __netif_get_rx_queue(netdev, q_idx);
   397			if (nla_put_napi_id(rsp, rxq->napi))
   398				goto nla_put_failure;
   399	
   400			params = &rxq->mp_params;
   401			if (params->mp_ops &&
   402			    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
   403				goto nla_put_failure;
   404	
   405			if (rxq->pool)
   406				if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
   407					goto nla_put_failure;
   408	
   409			break;
   410		case NETDEV_QUEUE_TYPE_TX:
   411			txq = netdev_get_tx_queue(netdev, q_idx);
   412			if (nla_put_napi_id(rsp, txq->napi))
   413				goto nla_put_failure;
   414	
   415			if (txq->pool)
   416				if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
   417					goto nla_put_failure;
   418	
   419			break;
   420		}
   421	
   422		genlmsg_end(rsp, hdr);
   423	
   424		return 0;
   425	
   426	nla_put_failure:
   427		genlmsg_cancel(rsp, hdr);
   428		return -EMSGSIZE;
   429	}
   430	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

