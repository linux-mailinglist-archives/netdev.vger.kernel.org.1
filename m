Return-Path: <netdev+bounces-268531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DKHGjYquWkAtAEAu9opvQ
	(envelope-from <netdev+bounces-268531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:17:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32B2A7B27
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBEF030B2225
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81A3A3E73;
	Tue, 17 Mar 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6n1QXn7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4303A168C
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742263; cv=none; b=LorbPNFyTKV5NO1oE6nQIoxOXWQuxbTjBSd7UWkACgSLXR9XlJZV18KDuC8lZeFpK+adgLJP6xYnXo8p3CdJdyxCdipuKQ21C6O5H/hSKp1LxJ13q/ynegtq1n7DR6P+wo/MBalFdgAl4F12g55h4XEMn86G2mA9jT7q1EzeqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742263; c=relaxed/simple;
	bh=G8XoS1TYQKC+tZYU4Ara5WZJMLSwIp9nwLYY9towWNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Aa2kIbntTHEx0ijrrIGedCKVXsBreC8fmjLX094LpjusiyuWu8AW949WD/WjZp94F5MqwbBm08u/KI6Jhms1h//Pge3sXCivekXZ1/AnVKaUFbsk02rkMyJF38F5B/oDih4j70zfWy1IVAi/8X7nTueSDiuWM1RInps76FjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6n1QXn7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773742258; x=1805278258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G8XoS1TYQKC+tZYU4Ara5WZJMLSwIp9nwLYY9towWNI=;
  b=j6n1QXn78KXxB6gcAdEbhuPGwPnAuAybiJI4M4kR+8iSne4fDi1Gs0y6
   yOTT/h2bHSZms7F1UKGDt3LAevvADMZSDIByPzE/JhMFV3wkgl7jWSK7h
   fPO+TmuFpllLdmsih9gZZ36u5ZE2+ocvUTQmOxZwPUSZ2L+PhJQ4RUeSf
   BmvXKeI8nv/bDF4hD6BWUrVc1z7tfES2LtZbeAcowSPOkjvI/1+zlei+G
   UMSKSEEaj1BTqLLSSJ/goQl3imxutI3htl2qZo70RR5el2H28xCW6dtVM
   GBSUsdTwOJD2SZngn2Zh5MimygLw1FskAQianGtHVQm/JXIponKQ6aHSv
   A==;
X-CSE-ConnectionGUID: W3p/lPIzQkWahDDJcpYVcg==
X-CSE-MsgGUID: kxrQArquQY6W/LxblJCMFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74887361"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74887361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:10:58 -0700
X-CSE-ConnectionGUID: Rxzhb+4DRZ+CCr2qhhaX3g==
X-CSE-MsgGUID: 6LgERUjXRAKl9RGMGj261Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222448493"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2026 03:10:56 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2RO1-000000004Pz-3AVE;
	Tue, 17 Mar 2026 10:10:53 +0000
Date: Tue, 17 Mar 2026 11:10:28 +0100
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v17 01/14] net: homa: define user-visible API
 for Homa
Message-ID: <202603171139.hOLQ0YKl-lkp@intel.com>
References: <20260316223228.2611-2-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316223228.2611-2-ouster@cs.stanford.edu>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-268531-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: CD32B2A7B27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20260317-070659
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260316223228.2611-2-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v17 01/14] net: homa: define user-visible API for Homa
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260317/202603171139.hOLQ0YKl-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603171139.hOLQ0YKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603171139.hOLQ0YKl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/homa.h:11:10: fatal error: netinet/in.h: No such file or directory
      11 | #include <netinet/in.h>
         |          ^~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

