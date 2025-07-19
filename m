Return-Path: <netdev+bounces-208308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF2B0AE1B
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 07:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39224AA7FC3
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFCF221F04;
	Sat, 19 Jul 2025 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePvz9Fsz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920DA920;
	Sat, 19 Jul 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752903462; cv=none; b=DjFHVJare2Jk44t1CdY3BufP5VvHlmurTYBoPcglvT4wGPkGk+KD+iEadqhXSMn5cHWzIqPc42olP9eNO20j4mga+z1MoFO7cmXT/tQk5aJ1d5armsz0gdDgMysF1Fs+kOKLdkPK84rbm9iYVlJLzmvOOJn2esudUU5INBhcXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752903462; c=relaxed/simple;
	bh=MJon/TZYWADZmZDD9hceG9yEzZZXNwLvFdal03egBqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhE+UIAG0+d27FuEUcK65w3QhE6CJJ/8jDYaRg59MvatrmXxzy455K7dm95spnWQX0gfnd82UMU/Jdy2nWvy2XzbFUCGf7xeoUbSnWpQHzw822xkOOsUmMfOY236f1cywsGFlqXcn5+IGizchxM1/W/dCso4qq/7OSHk1yp4CzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePvz9Fsz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752903460; x=1784439460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MJon/TZYWADZmZDD9hceG9yEzZZXNwLvFdal03egBqE=;
  b=ePvz9FszYccziLjvBka58iTlF6iZpZbaxGFfWNAdJZd2prBnV06J6dXR
   VS9ZSflmKv0zozcTkSwJZ+8nZw2X5/YF4F4PlwlqyY41DRncKXlrXuFlP
   ThpDSYJNHpbDA81/x9Bp4fZBmuZignL/5srGWfq4giQZ0phPhYTwPnTy3
   TQ4+/zrOUU3UHYE8qzO1hdR96QUoGg3A+TFqR14J8BTMLdtgxUsTG3xDn
   RD7UzOnkfEWCx1pWkpS3eX03oNVH0vQhze8qkrYuTlnmSYJ+A+vMdohXV
   TbIFX3DTLJEU8UhpLQ2oWr+ooosRLfeSIpdTljCvZTtnZ0K5pxDlUgKrL
   g==;
X-CSE-ConnectionGUID: nh1gCXudRZuig76fITt5VQ==
X-CSE-MsgGUID: oI1eZtQFTb27Z/NdsGWe3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="66544341"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="66544341"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 22:37:40 -0700
X-CSE-ConnectionGUID: tGCe+fNpRMSY7yrO8L13EA==
X-CSE-MsgGUID: NyrmdtgnTS2lacFieNxAJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="189375078"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Jul 2025 22:37:36 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud0GM-000FGd-1D;
	Sat, 19 Jul 2025 05:37:34 +0000
Date: Sat, 19 Jul 2025 13:37:05 +0800
From: kernel test robot <lkp@intel.com>
To: Abid Ali <dev.nuvorolabs@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abid Ali <dev.nuvorolabs@gmail.com>
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Message-ID: <202507191322.YG6cNwF6-lkp@intel.com>
References: <20250718-phy_resume-v1-1-9c6b59580bee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-phy_resume-v1-1-9c6b59580bee@gmail.com>

Hi Abid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 347e9f5043c89695b01e66b3ed111755afcf1911]

url:    https://github.com/intel-lab-lkp/linux/commits/Abid-Ali/net-phy-Fix-premature-resume-by-a-PHY-driver/20250718-234858
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250718-phy_resume-v1-1-9c6b59580bee%40gmail.com
patch subject: [PATCH] net: phy: Fix premature resume by a PHY driver
config: i386-buildonly-randconfig-004-20250719 (https://download.01.org/0day-ci/archive/20250719/202507191322.YG6cNwF6-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507191322.YG6cNwF6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507191322.YG6cNwF6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy_device.c:1849:33: warning: '&&' within '||' [-Wlogical-op-parentheses]
    1849 |         if (!phydrv || !phydrv->resume && phydev->suspended)
         |                     ~~ ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/phy_device.c:1849:33: note: place parentheses around the '&&' expression to silence this warning
    1849 |         if (!phydrv || !phydrv->resume && phydev->suspended)
         |                                        ^                   
         |                        (                                   )
   1 warning generated.


vim +1849 drivers/net/phy/phy_device.c

  1841	
  1842	int __phy_resume(struct phy_device *phydev)
  1843	{
  1844		const struct phy_driver *phydrv = phydev->drv;
  1845		int ret;
  1846	
  1847		lockdep_assert_held(&phydev->lock);
  1848	
> 1849		if (!phydrv || !phydrv->resume && phydev->suspended)
  1850			return 0;
  1851	
  1852		ret = phydrv->resume(phydev);
  1853		if (!ret)
  1854			phydev->suspended = false;
  1855	
  1856		return ret;
  1857	}
  1858	EXPORT_SYMBOL(__phy_resume);
  1859	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

