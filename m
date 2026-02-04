Return-Path: <netdev+bounces-256505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAPgM0qigmlpXAMAu9opvQ
	(envelope-from <netdev+bounces-256505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A53E077A
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC4630166CD
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC927A133;
	Wed,  4 Feb 2026 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNhfXzVU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA71274FDF
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168904; cv=none; b=UGIAQG2kijZ4lZw3X/Cw1/z3hzIxas0s7UIKYQGYU8kW8jhxwjXIggsO/ktXZRb6jDU/Xc5vu4EpF7hDtuZ9bmui15FMJ1LAa02bvPoW6eJU7qvsxRGk/Qa1rd+b/A15cbVYMAUW8ZFxxXA4MJmRIFQSP22B2mQ055mBjQ/SnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168904; c=relaxed/simple;
	bh=XfDSA7ng4gefVzIjNPb0N3L0Mpadew0WbaCjjHTqRc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh6gJEuxiJJGkH6aSv6vyjYHbjDnKSMmJyYO2VKIVqAvs2jdqsgom3NK6rblVF9PPmyAOYphH5D55qH8By/yETGoNnmuHRF7r81SZzoJypGIYNemzMDamLn4yPc1ahwcO6mb50r5L6QofeuLhcvhzxRp3PEzttscmE2rMZxKY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNhfXzVU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770168903; x=1801704903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfDSA7ng4gefVzIjNPb0N3L0Mpadew0WbaCjjHTqRc0=;
  b=DNhfXzVUe0OmR5dnPa5KyGSv3u9DWHtkGBnCCij0AejjNZ6ZCX2haLPQ
   GGDw4lc3rIptQtBmIV3WwXM4NZmAFgtAcVuB2y+I386V3k8j0OZ6abWz1
   +cBGWAyaGEw2VWDEr2CYHQFDgf/LHk1+6nQt7RO3LHYQRbhNf/x/vMUy5
   itZJ1uUSwGoKQn7jOxpRWpVgMeuiyX3HS9StKh/XWRvgsE9L4o6wnDgAl
   YJXmsJZmwRgl8ZrYGFeIepeC0Y8qeu123AN6JihoEqfmmn+NzbeES5KCO
   oNXks3PoeP7mEUCQVg2ebF8Sz0aYbVlfBm9Fzbz/QU7TQex2i7ih3MesX
   w==;
X-CSE-ConnectionGUID: y94Jgv42R+Wnik/sieQu2A==
X-CSE-MsgGUID: pc5szQs/QQugkGxUUVnvCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88927884"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="88927884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:35:02 -0800
X-CSE-ConnectionGUID: LdsauzWkQAiBfdHRfpxv9g==
X-CSE-MsgGUID: lH8GZpWpQtC8n9cuhnpqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214735234"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 17:35:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnRnG-00000000hM8-0OsY;
	Wed, 04 Feb 2026 01:34:58 +0000
Date: Wed, 4 Feb 2026 09:34:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH net-next v1 7/7] net: wangxun: add pcie error handler
Message-ID: <202602040920.UKsVMKFG-lkp@intel.com>
References: <20260203075759.5852-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203075759.5852-8-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256505-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 38A53E077A
X-Rspamd-Action: no action

Hi Jiawen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiawen-Wu/net-ngbe-move-the-WOL-functions-to-libwx/20260203-160343
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260203075759.5852-8-jiawenwu%40trustnetic.com
patch subject: [PATCH net-next v1 7/7] net: wangxun: add pcie error handler
config: sparc64-randconfig-r051-20260204 (https://download.01.org/0day-ci/archive/20260204/202602040920.UKsVMKFG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040920.UKsVMKFG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040920.UKsVMKFG-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_err.o: in function `wx_handle_errors_subtask':
>> wx_err.c:(.text+0x4a0): undefined reference to `aer_recover_queue'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

