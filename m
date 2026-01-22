Return-Path: <netdev+bounces-252184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBovKtmgcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF76618D8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75B0A4E1DF0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105A413251;
	Thu, 22 Jan 2026 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGiwOOtS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C141B37A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054382; cv=none; b=rLng1KcTUrc64Vjwqso2rh2hPY0HuoMlMSqyeWzyQiqcx69G9V283kuW+xdO5Ivk3MWZlFSVfrPWw/W7k1H644aq4A9UpzRf+L2piz6C+HbyI3/PnlSLNst4KUmHbKC9wveuu4+BzjBIgGMhwCGEl7raB7c/J6rqQ3S8ssoakIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054382; c=relaxed/simple;
	bh=ZrKaM4w+RnW6vXbe3nP8Jqgd1KOR07macYV9pIm7AlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKGEcDOGZ37LvDMMmYfVi83RUfamy74KW4QFhptHwbDWfgEtDuAhlmDg9TMgAQvJizFLI7rZZmwfPNOJhSeARVowzTsWpkZ4ctnU0qY2cSrQuuExwo6+IIdZzm3+lvOARxYlTEApJhhzV5YCT+A5lH9ze+tBfXJ4f/KteJRSufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGiwOOtS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769054379; x=1800590379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZrKaM4w+RnW6vXbe3nP8Jqgd1KOR07macYV9pIm7AlA=;
  b=gGiwOOtSYbrq/lsgqrPywcX0/zf34+OQ0ibzBNyyEucJnIx1IVNFy4fH
   kPNb4+HhGPdLszwzPPEp4EfEcUlJ5miTgYvULIw3jFbnXStFZ0PXCu4Xl
   0i12RUpFJgeWKQQy0F3jGTi/wgjbKTA5IWMPv6sNh4fUESNtG+QqPRtpN
   cxvMEU15t1cyy4EFtwEWsUQeHreljae2LFQUVTMCj45iN0I16Kw/JnucG
   wgThfnlh0PP9v/UZhFhAL44iGG4F2YFACXORag8QpRJORlvmyjkjseboN
   XPwgr3OosH3fKh/n9NUvr9VdROgt9n2AayaOWALpqFjNAq/nuiMsl7xmf
   w==;
X-CSE-ConnectionGUID: XpTJ6NEGSn+9ZAO/h3PD4A==
X-CSE-MsgGUID: Y8EXXfHPSGy5o+E3w6Pzew==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80914634"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="80914634"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:59:36 -0800
X-CSE-ConnectionGUID: utggy15IQAOMjNM4+petNw==
X-CSE-MsgGUID: 8p8arBDTRvCdeTW3J+GgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206227433"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Jan 2026 19:59:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vilr1-00000000SPF-23bZ;
	Thu, 22 Jan 2026 03:59:31 +0000
Date: Thu, 22 Jan 2026 11:58:52 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Mahesh Bandewar <maheshb@google.com>
Subject: Re: [PATCH net-next] ipvlan: remove ipvlan_ht_addr_lookup()
Message-ID: <202601221121.jJSK4gxB-lkp@intel.com>
References: <20260121215728.560645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121215728.560645-1-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,vger.kernel.org,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252184-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1DF76618D8
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/ipvlan-remove-ipvlan_ht_addr_lookup/20260122-060038
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260121215728.560645-1-edumazet%40google.com
patch subject: [PATCH net-next] ipvlan: remove ipvlan_ht_addr_lookup()
config: i386-randconfig-054-20260122 (https://download.01.org/0day-ci/archive/20260122/202601221121.jJSK4gxB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221121.jJSK4gxB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601221121.jJSK4gxB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ipvlan/ipvlan_core.c:74:26: warning: 'ipvlan_ht_addr_lookup6' defined but not used [-Wunused-function]
      74 | static struct ipvl_addr *ipvlan_ht_addr_lookup6(const struct ipvl_port *port,
         |                          ^~~~~~~~~~~~~~~~~~~~~~


vim +/ipvlan_ht_addr_lookup6 +74 drivers/net/ipvlan/ipvlan_core.c

    73	
  > 74	static struct ipvl_addr *ipvlan_ht_addr_lookup6(const struct ipvl_port *port,
    75							const void *iaddr)
    76	{
    77		struct ipvl_addr *addr;
    78		u8 hash;
    79	
    80		hash = ipvlan_get_v6_hash(iaddr);
    81		hlist_for_each_entry_rcu(addr, &port->hlhead[hash], hlnode)
    82			if (addr_equal(true, addr, iaddr))
    83				return addr;
    84		return NULL;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

