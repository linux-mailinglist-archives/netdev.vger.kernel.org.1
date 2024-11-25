Return-Path: <netdev+bounces-147169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD289D7C0F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E0BB22A47
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D07143722;
	Mon, 25 Nov 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbEjS7IQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177C13D26B
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520349; cv=none; b=tLfOpq2dzPbcYYJpjWMIhCN0rNr7PVPFoOIg7c+bxwz+TPDCUX28KimM0Grw1dXotSS6Iwj0asLBR3D5VovVW5a3xgO0FkuoasFqCor9uU0ko5dUoQaG6cilSnBC/WZcJqfNAmYVbKHFnCs9XVzb++ysvMBNmc6mKzc+5G7fXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520349; c=relaxed/simple;
	bh=dKpPJ+iCbP2kln5fssz9rUJcRvO/QQZCZX0DgTkrICI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggo7o6iHDAwqLwtI0xdmvfIQdlppxNgmRsY0rk2UOgvo5EbEFsnEMUgUwUatg1LXPmISXm2JaEXXV2V37QIPw27F91lK/jfZh5m6MwhJDxkc/ucvnndwBb5L5Mxi7T8hqHoB9d3uDW5tHgA9zgnb7L9Iv0wg7TW3NVvlLvI6lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbEjS7IQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732520348; x=1764056348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKpPJ+iCbP2kln5fssz9rUJcRvO/QQZCZX0DgTkrICI=;
  b=DbEjS7IQH4ytSEcPWKRBKqr6CmbHHIm1sP6asDP0ghQDIToHQMpOZfzh
   UeELLj7XGH0/u77Lmf7+a5rsbx25qyFLi2dqbzMF5coEiNMyOw+9Lw7Jf
   I2nGUKEcbM2jxxAE2K3XhRrhIyem6+eSHY0dOJC9ugIrXVCAU/OEXd9gi
   KQ49JWAG66ByXMQzS/bvK4sYBU6TRFG+vm8xPJROu4H+fVvR0RHRuFfXu
   bTNBs8YEpFuMCYIJ6xueSzNqGB54hmY2oJTuZREQ+9YFN2iLB9JXhJNU5
   6++O1KPKErnIt9TThgGU+ckZf9s1Hc95lU8iCiYq0MPEugodK3YlahrYn
   w==;
X-CSE-ConnectionGUID: Wz8eUvcHSqOinXpBLntbtA==
X-CSE-MsgGUID: 30TtJADuRBC5OnYe4o0YAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="50021745"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="50021745"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 23:39:07 -0800
X-CSE-ConnectionGUID: RrQ3XYm8RaKvOSeDrW/ZxQ==
X-CSE-MsgGUID: aMZRGFmHTLGfcs+3yviHqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91139460"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Nov 2024 23:39:06 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFTgV-00062X-2N;
	Mon, 25 Nov 2024 07:39:03 +0000
Date: Mon, 25 Nov 2024 15:38:47 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: Re: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
Message-ID: <202411251504.ZKzltGDp-lkp@intel.com>
References: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/ipmr-add-debug-check-for-mr-table-cleanup/20241125-104108
base:   net/main
patch link:    https://lore.kernel.org/r/23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni%40redhat.com
patch subject: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
config: sh-se7712_defconfig (https://download.01.org/0day-ci/archive/20241125/202411251504.ZKzltGDp-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251504.ZKzltGDp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251504.ZKzltGDp-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/ipmr.c: In function 'ipmr_can_free_table':
>> net/ipv4/ipmr.c:363:46: error: 'struct netns_ipv4' has no member named 'mr_rules_ops'; did you mean 'rules_ops'?
     363 |         return !check_net(net) || !net->ipv4.mr_rules_ops;
         |                                              ^~~~~~~~~~~~
         |                                              rules_ops


vim +363 net/ipv4/ipmr.c

   360	
   361	static bool ipmr_can_free_table(struct net *net)
   362	{
 > 363		return !check_net(net) || !net->ipv4.mr_rules_ops;
   364	}
   365	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

