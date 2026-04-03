Return-Path: <netdev+bounces-274946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN1iEvl+z2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:48:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65179392516
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45E5D3023F71
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4212B3845AC;
	Fri,  3 Apr 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfNYGMCa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66612D94BA
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206085; cv=none; b=BMMmK2kqA14Bwz2pe0tJZg++N1nCZwy5YeHWYcAfuliEFvYf9LJs2cXpx7CNRr4gcLESQpeGgBrIRDyEsite5LFaWbwCoSb4B2yV6fHISol4ADl46HWFMcdTNskkae9LUAmu6B3NqBzB+Bu+XbnUcrfFDuB/s5uLBAUWg7EsNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206085; c=relaxed/simple;
	bh=ZJrOlxB9ODhunm/KFNry2MOW4qy/eC1bLxczndnaFMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3yD+Ee5YxLZOAPhLuUXX3m7xDBp0z0FplEY1RanpUPqwF3LFsguvZucMagAdq8TN111MM+mnE3+WMTSTMOwxuYPNPGm2iI0OVnmDoflM/WhHsEDSFWJ6VIhgV+FKiVMjHVvkoMvPwHSMslX22fIutXLhZVFBQR496ZluMV3vNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfNYGMCa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775206084; x=1806742084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZJrOlxB9ODhunm/KFNry2MOW4qy/eC1bLxczndnaFMQ=;
  b=PfNYGMCa78Zh+aKq2qT6Sqb905U+SiMTEayxAfTCMlvjIJyoAQrFCIQg
   Dr+ASwfdpqctNkfowEcGWLaCI58I4/3/OAK1hfYAkAWLBwqqePXfLbgWX
   FFnyrfiFhDpbQB6JFe1V2dU/8HJY31nFz0u0PskEvHGzvfJTARUXAg14T
   7fV2H31NBBAGu8b1QHOOlqQ26Gfm21FjXIC0anCQQ68276dowtmMG4SDP
   i+JHR4CiQ5ijzVh757JryFBwlkNRPeEqKwRVXWnRrjdU7m5QgC/qVFuCl
   FJpGLpcLl9+V0Gg3HwQ7o1vtjvVQmggXXZI+/H5Tzh/HSy6+8eMlZJ4yJ
   Q==;
X-CSE-ConnectionGUID: LdczyCBYSEazS4ZpvD0bdg==
X-CSE-MsgGUID: 772jZ6u+QG2SrpzHvEH9CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76239390"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76239390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:48:02 -0700
X-CSE-ConnectionGUID: Powiq4beT56r4yUrcq0G+Q==
X-CSE-MsgGUID: NtlhvnCVSOKHAd8aQncblA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="222355504"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Apr 2026 01:47:59 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8aC5-0000000017P-0UZK;
	Fri, 03 Apr 2026 08:47:57 +0000
Date: Fri, 3 Apr 2026 16:47:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH v3 net-next] net: advance skb_defer_disable_key check in
 napi_consume_skb
Message-ID: <202604031607.o753ScQ1-lkp@intel.com>
References: <20260401033211.44463-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401033211.44463-1-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274946-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 65179392516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-advance-skb_defer_disable_key-check-in-napi_consume_skb/20260403-115110
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260401033211.44463-1-kerneljasonxing%40gmail.com
patch subject: [PATCH v3 net-next] net: advance skb_defer_disable_key check in napi_consume_skb
config: x86_64-buildonly-randconfig-005-20260403 (https://download.01.org/0day-ci/archive/20260403/202604031607.o753ScQ1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604031607.o753ScQ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604031607.o753ScQ1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/skbuff.c:1522:31: error: use of undeclared identifier 'skb_defer_disable_key'
    1522 |         if (!static_branch_unlikely(&skb_defer_disable_key) &&
         |                                      ^
>> net/core/skbuff.c:1522:31: error: use of undeclared identifier 'skb_defer_disable_key'
>> net/core/skbuff.c:1522:31: error: use of undeclared identifier 'skb_defer_disable_key'
>> net/core/skbuff.c:1522:31: error: use of undeclared identifier 'skb_defer_disable_key'
   4 errors generated.


vim +/skb_defer_disable_key +1522 net/core/skbuff.c

  1500	
  1501	/**
  1502	 * napi_consume_skb() - consume skb in NAPI context, try to feed skb cache
  1503	 * @skb: buffer to free
  1504	 * @budget: NAPI budget
  1505	 *
  1506	 * Non-zero @budget must come from the @budget argument passed by the core
  1507	 * to a NAPI poll function. Note that core may pass budget of 0 to NAPI poll
  1508	 * for example when polling for netpoll / netconsole.
  1509	 *
  1510	 * Passing @budget of 0 is safe from any context, it turns this function
  1511	 * into dev_consume_skb_any().
  1512	 */
  1513	void napi_consume_skb(struct sk_buff *skb, int budget)
  1514	{
  1515		if (unlikely(!budget || !skb)) {
  1516			dev_consume_skb_any(skb);
  1517			return;
  1518		}
  1519	
  1520		DEBUG_NET_WARN_ON_ONCE(!in_softirq());
  1521	
> 1522		if (!static_branch_unlikely(&skb_defer_disable_key) &&
  1523		    skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
  1524			skb_release_head_state(skb);
  1525			return skb_attempt_defer_free(skb);
  1526		}
  1527	
  1528		if (!skb_unref(skb))
  1529			return;
  1530	
  1531		/* if reaching here SKB is ready to free */
  1532		trace_consume_skb(skb, __builtin_return_address(0));
  1533	
  1534		/* if SKB is a clone, don't handle this case */
  1535		if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
  1536			__kfree_skb(skb);
  1537			return;
  1538		}
  1539	
  1540		skb_release_all(skb, SKB_CONSUMED);
  1541		napi_skb_cache_put(skb);
  1542	}
  1543	EXPORT_SYMBOL(napi_consume_skb);
  1544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

