Return-Path: <netdev+bounces-132491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E31991E35
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B530EB2150D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA59174ED0;
	Sun,  6 Oct 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWxFksvX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174B16132F;
	Sun,  6 Oct 2024 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215658; cv=none; b=k6m9BAYT1KAPxE2ttfLE5gw/U9jXFSGv6MprBukgjEQdQBsZQpyMgUqLxf0s/e55+yDDaAWl6kJk5EJ2DvPecnpj8ELuIAiCoVCI1dKs2iHimf0qRLYiQdAF6l5tkESFMinWZnthAEc9Lu4xPKVqm5KPZiioTukrElh0Ce8ZN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215658; c=relaxed/simple;
	bh=z/BfKCqqFKKUKx3H9sa4pqq0VP9FwN33xQEVHakeldQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTA5ZH0OhIP/U/ml0hY5L4/LLlOmp4mXKoFLI/QNbyhVavdVzpFzA+lu+3XPtNNWDXaIelFeFwj2mvST1QN+ftyG9P1ERKvmXxMJczKZDQbHDyiFNVSy/s5yjIaFiXAkcRgSycEe7Q1VSCIVo5kQfhdKokWPAZAyE+VE1xiTK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWxFksvX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728215657; x=1759751657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z/BfKCqqFKKUKx3H9sa4pqq0VP9FwN33xQEVHakeldQ=;
  b=eWxFksvX7Q7kt+LqFsKI7Tc2ropYTza/WiLPZYVsKoDzN/aSzwLc4Fj5
   8KCl4TCXvF/ebHJiZ/c9YQvZR2+xakzva4AToAyRHVl2LKcOi9UFgenLO
   qmWZI8Suek20/T2rJtHbCR3ZbQOcqUgmA0oH2t5aAnn9Cas0a2kLyCXTt
   iNgaUH3+lpb5CBZ3iclDzz9tE005pAT4dC4awZjQAHSUUPlbUGMI3mlb1
   shOgTBtTinL1Dr3/wZWZsSX608aY3H65Hg6/hHKR+3QBxq9HEhd5ugO1w
   WHZgWtbmXcc3V4MAuGS6lgvhXvCR9DaGEGKpWP0ghSb0xVrYEt8ClHK0E
   A==;
X-CSE-ConnectionGUID: uWHQ+l3wSQCgfFU5+P9YGg==
X-CSE-MsgGUID: O2AIOXtWRNai+1kHhI7/KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27519579"
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="27519579"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 04:54:16 -0700
X-CSE-ConnectionGUID: 1oMIA2WEQg+j4BuVVUufXQ==
X-CSE-MsgGUID: +1pr7u79RwmzMlG+Wx9AIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="79167660"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Oct 2024 04:54:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxPpz-0003oy-0F;
	Sun, 06 Oct 2024 11:54:11 +0000
Date: Sun, 6 Oct 2024 19:53:54 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
	horms@kernel.org, sd@queasysnail.net, chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 03/17] net: ibm: emac: use
 module_platform_driver for modules
Message-ID: <202410061910.his99w1N-lkp@intel.com>
References: <20241003021135.1952928-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003021135.1952928-4-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-use-netif_receive_skb_list/20241003-101754
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241003021135.1952928-4-rosenp%40gmail.com
patch subject: [PATCH net-next v3 03/17] net: ibm: emac: use module_platform_driver for modules
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20241006/202410061910.his99w1N-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410061910.his99w1N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410061910.his99w1N-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/core.o: in function `emac_init':
>> core.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/core.o: in function `emac_exit':
>> core.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/zmii.o: in function `zmii_driver_init':
   zmii.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/zmii.o: in function `zmii_driver_exit':
   zmii.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/rgmii.o: in function `rgmii_driver_init':
   rgmii.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/rgmii.o: in function `rgmii_driver_exit':
   rgmii.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/tah.o: in function `tah_driver_init':
   tah.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/tah.o: in function `tah_driver_exit':
   tah.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

