Return-Path: <netdev+bounces-254024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPZhEpo9eWkmwAEAu9opvQ
	(envelope-from <netdev+bounces-254024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799279B1DC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A90300A8C4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F12C08C0;
	Tue, 27 Jan 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0V+n1Ab"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3B262FD0;
	Tue, 27 Jan 2026 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553300; cv=none; b=pK7sw5kf02f6nwHPaIkwqB+Hz92987Kw5SGs6MIjsQ4ipC66gaFaz5023Xmsyv/Pd1aJENZdobyIt2W2f6Y+UUHTqDXSrc2YLkZ3p4BCcoAym42tQpsmRBVPYbpAbn/0cGDCm4pY41HvOrR6cx28BRPIVn9IQzJ1C6boRRFpaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553300; c=relaxed/simple;
	bh=lbmaunPmIAAKJYOSgR+oxjauOg0phHWiNKauNiahQms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M61r9TEu6fbwX47tWodP8E2javx6nP+UslWSZIQpN0CVjLizxmVhaGdqK7xAb1EpfKeEPCYeynSsrh+cDccTzSFfUbqkt3Th3RS2Z24oYrCCc6U0DdxFz2c/Lj1igu0rbpVxqDXi65b4DdA1BAAw6qUBRGFW/EMRI0EhPow41/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0V+n1Ab; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553299; x=1801089299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbmaunPmIAAKJYOSgR+oxjauOg0phHWiNKauNiahQms=;
  b=I0V+n1AbZtiEQYzlE3XW3eq5eOej7d4jjf3LpbZykSNq+DgAeOAoZ7mg
   2A783flYtdoEa7E+6bviXClotyqRLWShgEiBU1yrswBMFW1yxkPEixE6J
   v08yPalWJ+5swluiVV0vugE75GVWP3EKvyYxIF9/iWntk7a+7uFgxb4ou
   kB/P9QFGgQdWpl8yQWOtbSGxOJwGGvodPKmarC/bNM2dCyP352FuHzgBJ
   IYiMYVut1jIi5qmswPZ/a9MPxliLnwIr1a2X7XqgiQ2lcdDvwStgMNFcs
   Pf0QVyKHzSt3CuIY7PwLT6zeLSiMPrm6O5NlQclrxN38Rjvi4X4eqJSM1
   g==;
X-CSE-ConnectionGUID: FXPuizTVQqeyMWhKo2FTJw==
X-CSE-MsgGUID: 6sZh5E2JQpmdZHx62tOMAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70655677"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70655677"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:34:59 -0800
X-CSE-ConnectionGUID: 4Relj6VFS6S41SJxb85YOg==
X-CSE-MsgGUID: zter1/LURZ24bToYziIhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212201828"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Jan 2026 14:34:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkre9-00000000Yyo-2G8R;
	Tue, 27 Jan 2026 22:34:53 +0000
Date: Wed, 28 Jan 2026 06:33:57 +0800
From: kernel test robot <lkp@intel.com>
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Javen Xu <javen_xu@realsil.com.cn>
Subject: Re: [PATCH net-next v1 3/3] realtek: Update Makefile and Kconfig
Message-ID: <202601280610.ncyvilQz-lkp@intel.com>
References: <20260127113425.1989-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127113425.1989-4-javen_xu@realsil.com.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254024-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 799279B1DC
X-Rspamd-Action: no action

Hi javen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/javen/r816e-add-a-fake-driver-r816e-for-RTL8116af/20260127-193831
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260127113425.1989-4-javen_xu%40realsil.com.cn
patch subject: [PATCH net-next v1 3/3] realtek: Update Makefile and Kconfig
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20260128/202601280610.ncyvilQz-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280610.ncyvilQz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280610.ncyvilQz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/r816e/r816e.c:48:32: warning: 'rtl816e_pm_ops' defined but not used [-Wunused-const-variable=]
      48 | static const struct dev_pm_ops rtl816e_pm_ops = {
         |                                ^~~~~~~~~~~~~~


vim +/rtl816e_pm_ops +48 drivers/net/ethernet/realtek/r816e/r816e.c

638d27c0a2f682 Javen Xu 2026-01-27  47  
638d27c0a2f682 Javen Xu 2026-01-27 @48  static const struct dev_pm_ops rtl816e_pm_ops = {
638d27c0a2f682 Javen Xu 2026-01-27  49  	SYSTEM_SLEEP_PM_OPS(rtl816e_pm_suspend, rtl816e_pm_resume)
638d27c0a2f682 Javen Xu 2026-01-27  50  };
638d27c0a2f682 Javen Xu 2026-01-27  51  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

