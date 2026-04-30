Return-Path: <netdev+bounces-282563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM4YBmGn8mlwtQEAu9opvQ
	(envelope-from <netdev+bounces-282563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA149BD80
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79336302BA44
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0320ADF8;
	Thu, 30 Apr 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEmqunZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B21CAA6C;
	Thu, 30 Apr 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510223; cv=none; b=g5FFznbjDMXa3Oe3qlGzKoMX/Rgdg5/OMFtaAY0cLRSvmpr1OnFlBbDFN5c2iuHNvln2p8U9nhQJthvtmX6ALEkm2LNQyBQmA4uHVKM+fkkh+PLaWVGr0CaEx7lmdmfpZR51C3eqZif55dc/xgnWww31cYxsEMKqMd4KIFgdgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510223; c=relaxed/simple;
	bh=fV6sGDNM+Y0n3whqzyhFI/5lBWn8kaDaiHz6kmdUz8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkHyB3S6nkrmII/ynUR+M6Xb2+SAnB1pA6WXTpiFS5lTAd33NdyXdrX6fSX0IrQhaF9fKgQVuO9zoVuxM9mjZLrZE1hraiskyak/Q1ny1f2T0d64XMEMJsQq4hssrc962O56rE9A4rJCh0hKhMnejd+Qvfnu8lMq4mxq5Iw52Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEmqunZ1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777510222; x=1809046222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fV6sGDNM+Y0n3whqzyhFI/5lBWn8kaDaiHz6kmdUz8k=;
  b=oEmqunZ1lU5uqiUX6UQowc58B1YysLUp7IJ/FV0Ps1XsAdJhtI4l1ZPL
   OhlAk8+TnJA7jZk/gszY/VHF7XrWIx4kKswcBbdJQnHcvQqbpQYcNeGq6
   G9LLWOkFQduqIyUeLTlRFch7Zg/0qOpg2NnWAfdyKOyy/OkE9SVvdCfdn
   obBHjiAtncNq7Hio8HmM61p4m5q8HLBZJEBIm9EYshr39nFfXs4Xc+lak
   6WxcIF4vW1jxPkeGZJtZ6K+qSxn3KfCXs25LBUOr62mKZCfkw17gyVbR9
   p/EX93Kg/aI/8oOaQsu/GVXAxsls4tG+62BOrxeaahYYxDqCjRzFU7w/s
   Q==;
X-CSE-ConnectionGUID: gJZHgLjTRCmtC4sizZTKMQ==
X-CSE-MsgGUID: NrHXdqPQQ4KsHACTmSKkvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78163733"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78163733"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:50:20 -0700
X-CSE-ConnectionGUID: Dqc2zjXCTtqy46pLShY4xQ==
X-CSE-MsgGUID: ZFa2OBOTRKu+Z+xEW9/Xqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="233379027"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2026 17:50:17 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIFba-00000000Bjc-0kyc;
	Thu, 30 Apr 2026 00:50:14 +0000
Date: Thu, 30 Apr 2026 08:49:23 +0800
From: kernel test robot <lkp@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: sit: remove redundant ret = 0 assignment
Message-ID: <202604300826.7OKegoUR-lkp@intel.com>
References: <20260403084402.4105936-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403084402.4105936-1-yuehaibing@huawei.com>
X-Rspamd-Queue-Id: 6AAA149BD80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-282563-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]

Hi Yue,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yue-Haibing/ipv6-sit-remove-redundant-ret-0-assignment/20260425-024700
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260403084402.4105936-1-yuehaibing%40huawei.com
patch subject: [PATCH net-next] ipv6: sit: remove redundant ret = 0 assignment
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260430/202604300826.7OKegoUR-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300826.7OKegoUR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300826.7OKegoUR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv6/sit.c:362:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     362 |         if ((len && copy_to_user(a + 1, kp, len)) || put_user(len, &a->datalen))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv6/sit.c:367:9: note: uninitialized use occurs here
     367 |         return ret;
         |                ^~~
   net/ipv6/sit.c:362:2: note: remove the 'if' if its condition is always true
     362 |         if ((len && copy_to_user(a + 1, kp, len)) || put_user(len, &a->datalen))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     363 |                 ret = -EFAULT;
   net/ipv6/sit.c:312:9: note: initialize the variable 'ret' to silence this warning
     312 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +362 net/ipv6/sit.c

fadf6bf0606913 Templin, Fred L   2008-03-11  305  
3e7a1c7c561ed8 Arnd Bergmann     2021-07-27  306  static int ipip6_tunnel_get_prl(struct net_device *dev, struct ip_tunnel_prl __user *a)
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  307  {
fd5d687b76b325 Christoph Hellwig 2020-05-19  308  	struct ip_tunnel *t = netdev_priv(dev);
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  309  	struct ip_tunnel_prl kprl, *kp;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  310  	struct ip_tunnel_prl_entry *prl;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  311  	unsigned int cmax, c = 0, ca, len;
3c6132ccc58e8a Yue Haibing       2026-04-08  312  	int ret;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  313  
fd5d687b76b325 Christoph Hellwig 2020-05-19  314  	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev)
fd5d687b76b325 Christoph Hellwig 2020-05-19  315  		return -EINVAL;
fd5d687b76b325 Christoph Hellwig 2020-05-19  316  
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  317  	if (copy_from_user(&kprl, a, sizeof(kprl)))
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  318  		return -EFAULT;
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  319  	cmax = kprl.datalen / sizeof(kprl);
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  320  	if (cmax > 1 && kprl.addr != htonl(INADDR_ANY))
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  321  		cmax = 1;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  322  
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  323  	/* For simple GET or for root users,
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  324  	 * we try harder to allocate.
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  325  	 */
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  326  	kp = (cmax <= 1 || capable(CAP_NET_ADMIN)) ?
69050f8d6d075d Kees Cook         2026-02-20  327  		kzalloc_objs(*kp, cmax, GFP_KERNEL_ACCOUNT | __GFP_NOWARN) :
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  328  		NULL;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  329  
284fda1eff8a8b kernel test robot 2021-03-27  330  	ca = min(t->prl_count, cmax);
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  331  
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  332  	if (!kp) {
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  333  		/* We don't try hard to allocate much memory for
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  334  		 * non-root users.
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  335  		 * For root users, retry allocating enough memory for
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  336  		 * the answer.
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  337  		 */
69050f8d6d075d Kees Cook         2026-02-20  338  		kp = kzalloc_objs(*kp, ca,
69050f8d6d075d Kees Cook         2026-02-20  339  				  GFP_ATOMIC | __GFP_ACCOUNT | __GFP_NOWARN);
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  340  		if (!kp) {
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  341  			ret = -ENOMEM;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  342  			goto out;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  343  		}
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  344  	}
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  345  
adabdd8f6acabc katrinzhou        2022-06-28  346  	rcu_read_lock();
ef9a9d1183b36f Eric Dumazet      2009-10-23  347  	for_each_prl_rcu(t->prl) {
298bf12ddb2584 Sascha Hlusiak    2009-09-29  348  		if (c >= cmax)
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  349  			break;
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  350  		if (kprl.addr != htonl(INADDR_ANY) && prl->addr != kprl.addr)
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  351  			continue;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  352  		kp[c].addr = prl->addr;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  353  		kp[c].flags = prl->flags;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  354  		c++;
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  355  		if (kprl.addr != htonl(INADDR_ANY))
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  356  			break;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  357  	}
adabdd8f6acabc katrinzhou        2022-06-28  358  
ef9a9d1183b36f Eric Dumazet      2009-10-23  359  	rcu_read_unlock();
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  360  
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  361  	len = sizeof(*kp) * c;
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16 @362  	if ((len && copy_to_user(a + 1, kp, len)) || put_user(len, &a->datalen))
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  363  		ret = -EFAULT;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  364  
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  365  	kfree(kp);
adabdd8f6acabc katrinzhou        2022-06-28  366  out:
2b4743bd6be9fe YOSHIFUJI Hideaki 2008-06-16  367  	return ret;
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  368  }
300aaeeaab5f44 YOSHIFUJI Hideaki 2008-03-24  369  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

