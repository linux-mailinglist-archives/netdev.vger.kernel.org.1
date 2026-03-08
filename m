Return-Path: <netdev+bounces-265225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DvWKHCYBrWlZxAEAu9opvQ
	(envelope-from <netdev+bounces-265225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 05:55:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDDB22E84C
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 05:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50225300DEDF
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 04:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF730E834;
	Sun,  8 Mar 2026 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDPINuoO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589662D7DF2
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772945697; cv=none; b=I4WhvauBCYlFQFigrYmIoj7pODcrnfRlQTtUou9JUUche6dzchcnMHuoaD8mx69q67WdubC1BcF8/6HPj+gcPWLHVI36+4eb7AfXtNxekAfU/5C+Dx0S5cuS6MSWm6+6Jkuf/7nNYx/KVGeptWhcsTOguKJF256yV/wf+BDF93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772945697; c=relaxed/simple;
	bh=7F69hxQscy3x4ZOx14RCUd+MmcJIXWWOQPq5jek0S2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzNa3bsKXMQvkPX4J1E+DxIyYczV87CQzdQopEe51TryounfgMS8+/CQyV5LrhrerU9F1K9Akzi3/ijZVTLkOPshYCSUJHHcv7raE/TpBQug+6hBgyfRasa6l+VaxV+XL0cyneyqK5RFDB2lkd95ytwKKGGDzkynBtOYRvm+plI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDPINuoO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772945695; x=1804481695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7F69hxQscy3x4ZOx14RCUd+MmcJIXWWOQPq5jek0S2I=;
  b=hDPINuoOTurcBJLFR7EG0vfmkx6vuPBGomZEXwLOPeBcSzHn0/i/3tPU
   UXKxwH0VcUUN6z7nMWqEvTIMVrDu+n8kvfwxchvYwOAW7fkUMRLF+EFDl
   KBDprfAoFrW/Kes/Ibyw9SjNG7ArGSMI6EuGZbvXqQTWX9l9NwFlqdKAC
   cv+FaK+M2p2aeH/zOWZ8DC9BxnVSNUh5AqjDf62Ug2yj5fMH1sE0eXu4U
   rui1IRTDf3DwaUg+0VYZbet2kULOJcV1VvhfhJM1amBIX+oqXDZq4SqDF
   lI1GBpsAfdfr104tkVo6h1xxggVKHQdqPANFtAZHXIn33x3A3fmqTlWfW
   w==;
X-CSE-ConnectionGUID: 4NtBd7T9QmSiieusEESiLg==
X-CSE-MsgGUID: aRdLp96dRaSmVehjj1nK/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="77882122"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="77882122"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 20:54:54 -0800
X-CSE-ConnectionGUID: LilETv9LQEaEZwsRIYVwDw==
X-CSE-MsgGUID: 0Y/roQQnRk2cFL2Jud1MCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="242422393"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2026 20:54:52 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz6AD-000000002uT-2RrX;
	Sun, 08 Mar 2026 04:54:49 +0000
Date: Sun, 8 Mar 2026 12:54:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: Re: [PATCH net] page_pool: store detach_time as ktime_t to avoid
 false-negatives
Message-ID: <202603081213.0a8noL8L-lkp@intel.com>
References: <20260307204022.1897614-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307204022.1897614-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 5CDDB22E84C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265225-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/page_pool-store-detach_time-as-ktime_t-to-avoid-false-negatives/20260308-044057
base:   net/main
patch link:    https://lore.kernel.org/r/20260307204022.1897614-1-kuba%40kernel.org
patch subject: [PATCH net] page_pool: store detach_time as ktime_t to avoid false-negatives
config: mips-decstation_defconfig (https://download.01.org/0day-ci/archive/20260308/202603081213.0a8noL8L-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603081213.0a8noL8L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603081213.0a8noL8L-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/page_pool_user.c: In function 'page_pool_nl_fill':
>> net/core/page_pool_user.c:248:26: error: implicit declaration of function 'ktime_to_seconds'; did you mean 'ktime_get_seconds'? [-Wimplicit-function-declaration]
     248 |                          ktime_to_seconds(pool->user.detach_time)))
         |                          ^~~~~~~~~~~~~~~~
         |                          ktime_get_seconds


vim +248 net/core/page_pool_user.c

   214	
   215	static int
   216	page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
   217			  const struct genl_info *info)
   218	{
   219		size_t inflight, refsz;
   220		unsigned int napi_id;
   221		void *hdr;
   222	
   223		hdr = genlmsg_iput(rsp, info);
   224		if (!hdr)
   225			return -EMSGSIZE;
   226	
   227		if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id))
   228			goto err_cancel;
   229	
   230		if (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
   231		    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
   232				pool->slow.netdev->ifindex))
   233			goto err_cancel;
   234	
   235		napi_id = pool->p.napi ? READ_ONCE(pool->p.napi->napi_id) : 0;
   236		if (napi_id_valid(napi_id) &&
   237		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, napi_id))
   238			goto err_cancel;
   239	
   240		inflight = page_pool_inflight(pool, false);
   241		refsz =	PAGE_SIZE << pool->p.order;
   242		if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT, inflight) ||
   243		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
   244				 inflight * refsz))
   245			goto err_cancel;
   246		if (pool->user.detach_time &&
   247		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
 > 248				 ktime_to_seconds(pool->user.detach_time)))
   249			goto err_cancel;
   250	
   251		if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
   252			goto err_cancel;
   253	
   254		genlmsg_end(rsp, hdr);
   255	
   256		return 0;
   257	err_cancel:
   258		genlmsg_cancel(rsp, hdr);
   259		return -EMSGSIZE;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

