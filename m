Return-Path: <netdev+bounces-272074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P1DE8A5xWkP8gQAu9opvQ
	(envelope-from <netdev+bounces-272074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:50:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A8336480
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C4F3019118
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC72ED866;
	Thu, 26 Mar 2026 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zu5I8w1G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBB2D6E4B;
	Thu, 26 Mar 2026 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532087; cv=none; b=sCizm98MRb1ODrya8XGhy+UJeIXMwZ1C2kg2H7UDPWNDK6wwEne5Y2szxHPHOLHa1WxBIdLfdljU4f6OQysYKJ8Luw9mR/RZrYuEHS1ufoWCUe3bGJY2vfFzo/YqceNQuZcfpktFfZWxsEAavGqRXTZGG3mhBN2wx2dh0t2DkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532087; c=relaxed/simple;
	bh=xDZ1CjxoZ5zBmIzZlqeQykozanYIzdFzhbBR3Uo2eaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY2wMFCTPrPvl4c//BJTLFbirphT71M1UWDaMsA2PkGIlnOdaGBeHTWpwRUtw5ZfKUxufrI88+KScIaxuqsgAFc+IvJCxpoUO5JZG6j0h3J3PskpV0IsR6BTTztCXH5JG06wZ6hiBDMc7+Hxc9TePeuV9brV0mG7oT9p6F6Id3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zu5I8w1G; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774532086; x=1806068086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDZ1CjxoZ5zBmIzZlqeQykozanYIzdFzhbBR3Uo2eaM=;
  b=Zu5I8w1Gdi+SHb4/ZHGWbXRJdSkXeMQ5hrUllMUrNQs3eHBzAC20/U8r
   I6ouFEd860UtE9M+gySVZU9J56ix2ozkE0BDtL7EUghd4RfvmRRagchcE
   wYHsnPb0/Fn5IuYtlmn8yRHL/KGza6ngwlZgC2nj9L+Sz+GkxeyK58fB3
   kTA4Ifko4okqibMq9N6dcMf743AEzv+B4KWSZxA4oTvMxD+/GQGBH7eCy
   4g9HUSJB7gssVr5JLMwRAUFE6agy4CH6i0Fxxcyf14ms8rLfEslMjQkK5
   89QdkbqOsUUIUCT25KyUR6Ak/g3bKZsKhNM/lVbHR7SI8kx1poyNHWNFC
   w==;
X-CSE-ConnectionGUID: ZcoYdkVYSIyD46qtZUBKwA==
X-CSE-MsgGUID: BzC8tDoNSGaJ5xCbr3zHcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="92972324"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="92972324"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 06:34:45 -0700
X-CSE-ConnectionGUID: fiPqK9WNRcWjDK98eh0YuQ==
X-CSE-MsgGUID: uKtM6VLiQ+qLvqcKajbvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248050858"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 06:34:41 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5kr9-000000007Hd-2s1L;
	Thu, 26 Mar 2026 13:34:39 +0000
Date: Thu, 26 Mar 2026 14:34:20 +0100
From: kernel test robot <lkp@intel.com>
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, fmaurer@redhat.com,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments
 with fallthrough macro
Message-ID: <202603261419.jqhvfAVi-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272074-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gnu.org:url,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: BC7A8336480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/luka-gejak-linux-dev/net-hsr-constify-hsr_ops-and-prp_ops-protocol-operation-structures/20260326-143638
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260324144630.189094-3-luka.gejak%40linux.dev
patch subject: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments with fallthrough macro
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260326/202603261419.jqhvfAVi-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261419.jqhvfAVi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261419.jqhvfAVi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:88,
                    from <command-line>:
   net/hsr/hsr_netlink.c: In function 'hsr_get_node_status':
>> include/linux/compiler_attributes.h:214:41: error: invalid use of attribute 'fallthrough'
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                         ^~~~~~~~~~~~~
   net/hsr/hsr_netlink.c:436:9: note: in expansion of macro 'fallthrough'
     436 |         fallthrough;
         |         ^~~~~~~~~~~
   net/hsr/hsr_netlink.c: In function 'hsr_get_node_list':
>> include/linux/compiler_attributes.h:214:41: error: invalid use of attribute 'fallthrough'
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                         ^~~~~~~~~~~~~
   net/hsr/hsr_netlink.c:527:9: note: in expansion of macro 'fallthrough'
     527 |         fallthrough;
         |         ^~~~~~~~~~~
--
   In file included from include/linux/compiler_types.h:88,
                    from <command-line>:
   hsr_netlink.c: In function 'hsr_get_node_status':
>> include/linux/compiler_attributes.h:214:41: error: invalid use of attribute 'fallthrough'
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                         ^~~~~~~~~~~~~
   hsr_netlink.c:436:9: note: in expansion of macro 'fallthrough'
     436 |         fallthrough;
         |         ^~~~~~~~~~~
   hsr_netlink.c: In function 'hsr_get_node_list':
>> include/linux/compiler_attributes.h:214:41: error: invalid use of attribute 'fallthrough'
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                         ^~~~~~~~~~~~~
   hsr_netlink.c:527:9: note: in expansion of macro 'fallthrough'
     527 |         fallthrough;
         |         ^~~~~~~~~~~


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

