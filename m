Return-Path: <netdev+bounces-226188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE49B9DB91
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25D52E35DC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74C51E2614;
	Thu, 25 Sep 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGYesiqm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D46182B4
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782909; cv=none; b=SosTtOyj4V/7Vf666SC94hakSekesliFEtTTITdnPbdFrftG6t3f/SauVbijZdkd/lMpJuhtYpZFpAfMpJefqGK8WyxIaiFLa7QIA5ApY5jWqJUXDFAFMW8k3qSz8SkPYlTHEfIVsJWFg1MGieA0Wschtzvg/wmd+mykRpjItCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782909; c=relaxed/simple;
	bh=/Jh9narK//Vdct6harcwA5oRwFRD6C/h9Pvtm7ja7UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7++DlRgpUFGz3sxDHeh8MVNoXZF9ozMYRHi12Ff1YxisqleGB8org4SZNNlAA0KSdqY86KM9nHASE/ASic1QbkyAEJhm7iR2F7gWM5yVZbDl/wXk5blNpvCeBIeWp2g/QBCj5xeNd9lz71NgB1U1JfAov7UC6/4CNCkb/hHZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGYesiqm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758782908; x=1790318908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Jh9narK//Vdct6harcwA5oRwFRD6C/h9Pvtm7ja7UI=;
  b=TGYesiqmEDGqbMtrh3rI5tjrJQStiy+LXm73ZrUkZTP4anpSk3quje81
   QOPgDBSHa/SJJ4FsjTOhK6jligCWT1zF+zppHus24ijadCJwKm1tsK4d4
   PngO6HrWyDV/4h/AwfcAdHk7zs4VR0DBPoZdl/EcHjVwIo/uKUoK3JGCB
   PwMMO3I6jd3Iy+scliDOI2gPh0r2oibLvEtov+lMZT11PLNNn/NWVh47d
   eNR1kX6IJjFLykw/1XjSHt5Qr8X4sV4Kjrj6ELu5U/gCtE86rrlfrrvLQ
   eX85/0qQ5CIyyjWxeIq4NsJCUQbm3Z8FkrZ2V4d+UMrIUTodY/wq8wgxo
   Q==;
X-CSE-ConnectionGUID: 22fAunL4RB2Yk5657G5/Jg==
X-CSE-MsgGUID: 8JDbO5iJRxaVX4dcPMdP4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72520225"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="72520225"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:48:27 -0700
X-CSE-ConnectionGUID: 0laVTdjgR/O9U2gJbq7RfA==
X-CSE-MsgGUID: 6hCP+bN0SLe9K0FCbDqTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="208185905"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2025 23:48:23 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1fm8-0004zj-31;
	Thu, 25 Sep 2025 06:48:20 +0000
Date: Thu, 25 Sep 2025 14:48:16 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>, Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH net-next 1/9] netdevsim: a basic test PSP implementation
Message-ID: <202509251404.crckqEdD-lkp@intel.com>
References: <20250924194959.2845473-2-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924194959.2845473-2-daniel.zahka@gmail.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Zahka/netdevsim-a-basic-test-PSP-implementation/20250925-035305
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250924194959.2845473-2-daniel.zahka%40gmail.com
patch subject: [PATCH net-next 1/9] netdevsim: a basic test PSP implementation
config: i386-buildonly-randconfig-003-20250925 (https://download.01.org/0day-ci/archive/20250925/202509251404.crckqEdD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509251404.crckqEdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509251404.crckqEdD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/netdevsim/netdev.c: In function 'nsim_forward_skb':
>> drivers/net/netdevsim/netdev.c:116:36: error: 'SKB_EXT_PSP' undeclared (first use in this function); did you mean 'SKB_EXT_NUM'?
     116 |                 __skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
         |                                    ^~~~~~~~~~~
         |                                    SKB_EXT_NUM
   drivers/net/netdevsim/netdev.c:116:36: note: each undeclared identifier is reported only once for each function it appears in


vim +116 drivers/net/netdevsim/netdev.c

   102	
   103	static int nsim_forward_skb(struct net_device *tx_dev,
   104				    struct net_device *rx_dev,
   105				    struct sk_buff *skb,
   106				    struct nsim_rq *rq,
   107				    struct skb_ext *psp_ext)
   108	{
   109		int ret;
   110	
   111		ret = __dev_forward_skb(rx_dev, skb);
   112		if (ret)
   113			return ret;
   114	
   115		if (psp_ext)
 > 116			__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
   117	
   118		return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
   119	}
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

