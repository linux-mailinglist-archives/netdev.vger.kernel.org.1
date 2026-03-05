Return-Path: <netdev+bounces-264258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCvjAV1TqWkj4wAAu9opvQ
	(envelope-from <netdev+bounces-264258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:56:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECA20F1DF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ABD43099836
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974F37B417;
	Thu,  5 Mar 2026 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYOLDkHf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FC37999D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704254; cv=none; b=QUsD2A1mEKoJG18kwoLC/W+l/uvZo/AvfSdAFVc/I/4ygdocVa06Tx9aI3kbFYVJErGLWoy2E/6l4x7XmHwR3jR1fgV+4cdP8PrVACOvBdOjLInZV7vFpakLWFGgpLyPTFPepDV5sVBvst5DvHzOW4jYWhaLf2FpMVhtJ/KOi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704254; c=relaxed/simple;
	bh=loarNLtT4VCaLQk1B9B1QzIFq8ttTnJYOAjEkPYNMg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvPVC0sD+mUf8gtxnntrrgUPsVhZuAP7E03rZfQtEjgsV1QrVDZTzYpLoDLico8kCIUnchp0Y+/TWHWJLM3/TNsvbYsJrwvms7CWaKmyMLjtvv8paqrAQnTwrppCrm+yk1lIxy0vm2Xfrk0aFSaVGI2DDpZ/8Nj5PzissRTyEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYOLDkHf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772704252; x=1804240252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=loarNLtT4VCaLQk1B9B1QzIFq8ttTnJYOAjEkPYNMg4=;
  b=aYOLDkHf83INxJE1HLS+crDNYeWgup34lnSfRH5YrjZzFVT201X1jlcn
   SLP1weu/9GrYjxL0O1wohytElFZoYhgG4y/12ts78ctTBzRM5ajSFuOir
   H3QtXjZMzRiReZHXyom9CCy5FrifVtKfhekjO/yt70eg7qvBHO59gf7hj
   KPfnl/dpwumvPaV8zIyTkj+jwrklWiWKKZ4I2OeAcOLH9ei8iy0hfL7KB
   3g1pRqbou+YqGjOFqEREkD6jMr4x4v4ubpSjvzA9XT6aEEO90sEdk2xiN
   jatsLc8aJ4WGJMOCI0CvETqV+7cVBy5eiDA8Klh2ldtTUWQLSLnmGUsaL
   Q==;
X-CSE-ConnectionGUID: 7oJh+VBIRqyXi8AwTX976w==
X-CSE-MsgGUID: VpGee59DTeCxuILManuexw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73656601"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="73656601"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 01:50:51 -0800
X-CSE-ConnectionGUID: ZWHJkIw+RwCGc8NxHZfNyg==
X-CSE-MsgGUID: qVRzyqLcRL2FZBk8g08Ayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="249093266"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 01:50:45 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy5Lu-000000000Qs-13af;
	Thu, 05 Mar 2026 09:50:42 +0000
Date: Thu, 5 Mar 2026 17:50:16 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Use also port
 number to identify timestamps
Message-ID: <202603051716.XWkBTVcW-lkp@intel.com>
References: <20260304080318.FyNGmyyP@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080318.FyNGmyyP@linutronix.de>
X-Rspamd-Queue-Id: 61ECA20F1DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264258-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Action: no action

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/net-ethernet-ti-am65-cpsw-Use-also-port-number-to-identify-timestamps/20260304-161208
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260304080318.FyNGmyyP%40linutronix.de
patch subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260305/202603051716.XWkBTVcW-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051716.XWkBTVcW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051716.XWkBTVcW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/ti/am65-cpts.c:1011 function parameter 'port_id' not described in 'am65_cpts_prep_tx_timestamp'
>> Warning: drivers/net/ethernet/ti/am65-cpts.c:1011 function parameter 'port_id' not described in 'am65_cpts_prep_tx_timestamp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

