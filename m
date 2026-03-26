Return-Path: <netdev+bounces-272260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEnyHt6mxWlUAQUAu9opvQ
	(envelope-from <netdev+bounces-272260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:36:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2C33BFBC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E357E3074115
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C23A782E;
	Thu, 26 Mar 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbCNAt9e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA72F39C7;
	Thu, 26 Mar 2026 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560738; cv=none; b=nmeOio4B0zAEqRYHTJu+Z0UnV4tiYEsvsrOAUjncxuKbBe4XZeqw5Lf65zGKY+lXw/WM9+0z6UoIofuzsC0Ox1Rkmk1V+K+khkfZQu7WsA+5yxnFce7+6jOYWmDPbqbjRu/PRXEu1HYvuE83Sx5SmV3CVze4CybrNczter+Nt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560738; c=relaxed/simple;
	bh=bX5g7DDn7F8faaR5o91dGJpAln6MtJLyD9kEnxKSA1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okbJ+FHl/sLElkxUxzkF5vhP9zYTgH8Be83ieChGip93zDaXSOalWOeMj8DixJ5pP+FF2C65S6Ep2jYLboxxIO+FsuIyawf5AFU7IyZR4U4Q7LesCLCjQqH4KA0nBDXirY3x9TWmvAtuUX4fC2WD0yrssr6j1kg5xhJvGtkD9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbCNAt9e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774560735; x=1806096735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bX5g7DDn7F8faaR5o91dGJpAln6MtJLyD9kEnxKSA1s=;
  b=SbCNAt9etwTbca0XgasLMsUNVl8DkcGwK0FKsbjYMg4asOUNGtskJkXq
   fcs/OhaoA/I/OwvgwTZ5gvlbrbT9W7cKf0gIEaGWYvv2GQDTiu6/1rRBh
   oaHO5WifoNloA6mJuZkXQ8HJIbwp43VYFNeeZFb95I4tpHaFgq8Nuq0Ea
   QNgYUNVFNMI63MJX5d/3ouAHr+CQ1FQ/XpgnGS0M59UyydbTGipYi6Rc6
   vPKwWI9JMP+p4a5yKAxm2jevGAkbFL9lR095Sid3fnGMaoe75sjJOJ2jN
   KuRnTaxvkyqMLqCA2Zoa6DvVxUcXGADQfaU6ICngnOrsezQLOR+xAC+u/
   A==;
X-CSE-ConnectionGUID: OhDksrIdTOmNBoPzxoBbVw==
X-CSE-MsgGUID: 8Bgiw84tSZuvEOi8AHQaIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93215282"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="93215282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:32:14 -0700
X-CSE-ConnectionGUID: s/y8W1YJSlaPevsDde3ncw==
X-CSE-MsgGUID: zqdMf4JTQS+S+7KiNNN2cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="225059468"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Mar 2026 14:32:11 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5sJE-000000009Ob-1O3K;
	Thu, 26 Mar 2026 21:32:08 +0000
Date: Fri, 27 Mar 2026 05:31:19 +0800
From: kernel test robot <lkp@intel.com>
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, fmaurer@redhat.com,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments
 with fallthrough macro
Message-ID: <202603270549.2hiC5jsf-lkp@intel.com>
References: <20260324144630.189094-3-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324144630.189094-3-luka.gejak@linux.dev>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272260-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,gnu.org:url,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CB2C33BFBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/luka-gejak-linux-dev/net-hsr-constify-hsr_ops-and-prp_ops-protocol-operation-structures/20260326-143638
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260324144630.189094-3-luka.gejak%40linux.dev
patch subject: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments with fallthrough macro
config: parisc-randconfig-002-20260327 (https://download.01.org/0day-ci/archive/20260327/202603270549.2hiC5jsf-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603270549.2hiC5jsf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603270549.2hiC5jsf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:88,
                    from <command-line>:
   net/hsr/hsr_netlink.c: In function 'hsr_get_node_list':
>> include/linux/compiler_attributes.h:214:41: error: invalid use of attribute 'fallthrough'
    # define fallthrough                    __attribute__((__fallthrough__))
                                            ^~~~~~~~~~~~~
   net/hsr/hsr_netlink.c:527:2: note: in expansion of macro 'fallthrough'
     fallthrough;
     ^~~~~~~~~~~
   net/hsr/hsr_netlink.c: In function 'hsr_get_node_status':
>> include/linux/compiler_attributes.h:214:41: error: invalid use of attribute 'fallthrough'
    # define fallthrough                    __attribute__((__fallthrough__))
                                            ^~~~~~~~~~~~~
   net/hsr/hsr_netlink.c:436:2: note: in expansion of macro 'fallthrough'
     fallthrough;
     ^~~~~~~~~~~


vim +/fallthrough +214 include/linux/compiler_attributes.h

294f69e662d157 Joe Perches   2019-10-05  201  
294f69e662d157 Joe Perches   2019-10-05  202  /*
294f69e662d157 Joe Perches   2019-10-05  203   * Add the pseudo keyword 'fallthrough' so case statement blocks
294f69e662d157 Joe Perches   2019-10-05  204   * must end with any of these keywords:
294f69e662d157 Joe Perches   2019-10-05  205   *   break;
294f69e662d157 Joe Perches   2019-10-05  206   *   fallthrough;
ca0760e7d79e2b Wei Ming Chen 2021-05-06  207   *   continue;
294f69e662d157 Joe Perches   2019-10-05  208   *   goto <label>;
294f69e662d157 Joe Perches   2019-10-05  209   *   return [expression];
294f69e662d157 Joe Perches   2019-10-05  210   *
294f69e662d157 Joe Perches   2019-10-05  211   *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
294f69e662d157 Joe Perches   2019-10-05  212   */
294f69e662d157 Joe Perches   2019-10-05  213  #if __has_attribute(__fallthrough__)
294f69e662d157 Joe Perches   2019-10-05 @214  # define fallthrough                    __attribute__((__fallthrough__))
294f69e662d157 Joe Perches   2019-10-05  215  #else
294f69e662d157 Joe Perches   2019-10-05  216  # define fallthrough                    do {} while (0)  /* fallthrough */
a3f8a30f3f0079 Miguel Ojeda  2018-08-30  217  #endif
a3f8a30f3f0079 Miguel Ojeda  2018-08-30  218  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

