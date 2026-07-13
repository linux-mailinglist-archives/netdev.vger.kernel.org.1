Return-Path: <netdev+bounces-307197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l1TqD8nzVGqOhwAAu9opvQ
	(envelope-from <netdev+bounces-307197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:18:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913DD74C478
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:18:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=eSkZAhzI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307197-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307197-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 800223035ABF
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582842DA52;
	Mon, 13 Jul 2026 14:18:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C140BCDF
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:18:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952307; cv=none; b=UYmCaLeNXq4jCBOfOIOtcQrmWsJd8cq0HcnfQbiGcnZXDOJdMp+0i8YWJCIDSJwIRybLZer350IwWpw1DcU0PZFmbr6Re9ncka25qshbPRu2nsglN7aWoT184XZBWc/tYeqgIxN20B2JpIZLZsXXoa1akg3ZevdRU5t6A9TfxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952307; c=relaxed/simple;
	bh=KtZnuIUCXP/uiTmx6iNInDp+FPnUT5DTzRUdx1Xqw94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9aIiRFo9+QrgXlvznuWxPlk94YjokpqD4uZHGNoXon9sMB0bwt9+ed23b0KcodKCzcrgaZJoZyMEiq5EarBCzQz/NRd8zxU+BZuHHJe7gCz9jEqVZJ+7BDQFFPQjdAALNcZBiKtkX3ffcpTdsNRf5PtR2XLRthjqqu3gYM3s4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSkZAhzI; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783952305; x=1815488305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtZnuIUCXP/uiTmx6iNInDp+FPnUT5DTzRUdx1Xqw94=;
  b=eSkZAhzIeRN9WcXgNpvh4LYf6BWUbMpwfPQLCNvABSHNt7wrB7aG50DL
   +pL3/h/92GyPR8akQKg/vbrOhXASsQtx+NUgdRZAoZsNWISQHE1+kBgWA
   TZP1/DRIm7YN2AmZEjYx7SJR22RBJgmw6Cgkk7FLujIEikBY2qVh9QHzR
   WKzNzg8R7Rcer3dOCySFQBIZRSG3gh+KNoxThofzz6JMV8wV3IItI5yys
   Wo0HF58KB6KJSJ1yvN5O3G0UpXFCVKXT6FAUsKa1I2p84Oxgid+h53qhc
   D/WAPE4zIuSsPWQUlOZ0b0reeW3GalK1NhFjGzErEpxPNgC8ALm//BhTu
   Q==;
X-CSE-ConnectionGUID: tiKh3fFbR1a638Yt2SVVUQ==
X-CSE-MsgGUID: 8IMsL1bwSIywIhwZcHAaOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84526258"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84526258"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 07:18:25 -0700
X-CSE-ConnectionGUID: KT0+kf7sTKyGHvnbnre84w==
X-CSE-MsgGUID: rdgSVN8rRiCn9TVPnBmq4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259425405"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 13 Jul 2026 07:18:23 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjHUC-000000003kr-3hCT;
	Mon, 13 Jul 2026 14:18:20 +0000
Date: Mon, 13 Jul 2026 16:17:24 +0200
From: kernel test robot <lkp@intel.com>
To: David 'equinox' Lamparter <equinox@diac24.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: Re: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <202607131605.i02odG4b-lkp@intel.com>
References: <20260713080634.296011-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713080634.296011-1-equinox@diac24.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:equinox@diac24.net,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 913DD74C478

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-equinox-Lamparter/mptcp-sockopt-implement-IPV6_TCLASS/20260713-162825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260713080634.296011-1-equinox%40diac24.net
patch subject: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260713/202607131605.i02odG4b-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260713/202607131605.i02odG4b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607131605.i02odG4b-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ipv6_setsockopt
   >>> referenced by sockopt.c:404 (net/mptcp/sockopt.c:404)
   >>>               vmlinux.o:(mptcp_setsockopt)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

