Return-Path: <netdev+bounces-267895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI0IAusqtmkG+QAAu9opvQ
	(envelope-from <netdev+bounces-267895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 04:43:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF9328FDA8
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 04:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B27D30387E2
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE66D2236FA;
	Sun, 15 Mar 2026 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuFwe3F2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556D849C
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773546214; cv=none; b=VkphE6K04bI65uKXM85jtBqYZpQxesOxdARestLsvj395cDVjCaa7iz4nHtzJ6sgQOCujJOcDjfp1ehp/gmKWe/0ki1g2sQ8zeR8LaIy50uMKbmQdxzPMfESqDih6b1gqhnVRx1EbeT+uUbW722IYZF3hXUXItk7wSXfLf25eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773546214; c=relaxed/simple;
	bh=ApwIQ8mOebtZU98sLSXw62ssgbaO+JCrIqcvOkxLo18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCnMcmvl3pRArRn4OSSW7K07hgx4bnNDpoUbsbiI4P4HWGpwiGrMgplwf8/3+tkZe8MuBeXL2Uvc/9CTj7TVAR1GbYYbzLs+7QGq7rloK2J/KaEui8ihDXq9ve/hEJTb5TDvdnmaOioHh9jG9dU1hgS1eyu5qeA1LYtR3H170JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuFwe3F2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773546212; x=1805082212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApwIQ8mOebtZU98sLSXw62ssgbaO+JCrIqcvOkxLo18=;
  b=TuFwe3F23fbbnvGXG9UV9leP8QVjK8oS9D3SWAmEeBsFrx+e9QfPUmPF
   5ZwEJv4dWq8j37rGZlDSaoNsjkSSX/WnW4rADPleNoyQ/7IcGQqnbIswk
   +/8f7CXJVvQqiwCnkXevmOxpdJaFWDUlSR0/YPbJrjEDHm7NrslMBzZRN
   G1FsQn8SKaF3BbveN28KJqKrNyG9QJhSmxEdbjtHTMhVUTF2NRl4ZNKuy
   EfmF5hKj0Gbh9PDbOFPLwhsgL+7dLO3wuuWafYVeXMcWaApURWki6iLSS
   eTTJyEdourBPl6w4Iiu3SxDwViw6H5F2GeirCaQACmx4IuOYhthJmidgz
   Q==;
X-CSE-ConnectionGUID: sG/0U9CTSv2tRDI7zG0phQ==
X-CSE-MsgGUID: npX3pPVgTFubyj0n4gTgyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74637763"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="74637763"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 20:43:32 -0700
X-CSE-ConnectionGUID: eUyWCbTMRkePCViBbtB+Zg==
X-CSE-MsgGUID: Vifn+p1LRiS8nunKtT5fCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="218830928"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 14 Mar 2026 20:43:29 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1cNz-000000003x3-14gZ;
	Sun, 15 Mar 2026 03:43:27 +0000
Date: Sun, 15 Mar 2026 04:42:39 +0100
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] bonding: prevent potential infinite loop in
 bond_header_parse()
Message-ID: <202603150436.yxfJziep-lkp@intel.com>
References: <20260314115650.3646361-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314115650.3646361-1-edumazet@google.com>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,vger.kernel.org,gmail.com,google.com,shopee.com,jvosburgh.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-267895-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 3BF9328FDA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/bonding-prevent-potential-infinite-loop-in-bond_header_parse/20260315-010404
base:   net/main
patch link:    https://lore.kernel.org/r/20260314115650.3646361-1-edumazet%40google.com
patch subject: [PATCH net] bonding: prevent potential infinite loop in bond_header_parse()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260315/202603150436.yxfJziep-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150436.yxfJziep-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150436.yxfJziep-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/ethernet/eth.c:202 function parameter 'dev' not described in 'eth_header_parse'
>> Warning: net/ethernet/eth.c:202 function parameter 'dev' not described in 'eth_header_parse'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

