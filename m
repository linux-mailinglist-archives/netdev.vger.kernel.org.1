Return-Path: <netdev+bounces-236545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE6C3DDA9
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5722D18855E7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079DA2EC080;
	Thu,  6 Nov 2025 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA+kvPud"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699B26E165;
	Thu,  6 Nov 2025 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471899; cv=none; b=js3DjtMm0/0KrGfy5dMGi2dG+LaMIlzlWe6lt915emK6CvnApk6pN0B04TJMyYrHdn6ZjhiLXgV82kg/yOe1V8BC07pnGfYxujzJueJp8x7Ne3LR9tMERMT7tD6ET6GX6DiD89HWWILmNYKKqhwAJs6wgpIdMOzSKMUQyAbmYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471899; c=relaxed/simple;
	bh=F9GO8azXA57dIQquZPaj6gtGUM3ly39/H+3TEWZLYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T14Ga3LRgtsZrwVcO7akEgbF9uEE3bZBgsOeuf0YFIrNjapkYanWBGSZyEXl3WSVda12aD7e5fHbsI+cLLDYB2JLlQE7m7S6syN75SSiJDwnGXh8+sbQQ9DOUkJcXv2aQQpmYTjtsuFZQpjsg4R9IfhoScVr+nYDlfRfsTppxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA+kvPud; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762471898; x=1794007898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F9GO8azXA57dIQquZPaj6gtGUM3ly39/H+3TEWZLYeE=;
  b=UA+kvPudVi628/MWK5tYcKa6lU55HWTX5pMoXro1Y0f9hvJWt90w3dUf
   RUTg8QWJDomjXY9tpbcVp9xiFr0pfqeNlqHJcrG3y6Jb4cevjPzzN18qO
   mU0Qf6VJTLRuBUndN/FvXVetK9eupPbVetqioGB0mZdLhZyFuuMEyzmKB
   yVEHOj1jEfxaRkXvpEjtZk0cjG1/5EgXdkVX0eZc6JuktD5ozWlZ8yoVg
   E0lAeW2M8cH/d/RXXuxPhj4gQXQP36TbDSsGWlJtiHd3QpmiqVBB2TyC7
   5hmR8Gpj0NFFx45fGLu1hdJlJ42ArQGkxoxNjuZNs+CjJJs0aHBkwYI1M
   Q==;
X-CSE-ConnectionGUID: vDBNkef1SfaPuhY+7zP9AA==
X-CSE-MsgGUID: QZoX6vDIRJufFz8NBSTvdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75974733"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="75974733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 15:31:37 -0800
X-CSE-ConnectionGUID: 9TGc01+iRH6niSHIUYy1KA==
X-CSE-MsgGUID: txS4mdTKTgCnMJwdJYHyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188054199"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 15:31:33 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH9Rv-000USS-2y;
	Thu, 06 Nov 2025 23:31:29 +0000
Date: Fri, 7 Nov 2025 07:30:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrey.bokhanko@huawei.com,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 01/14] ipvlan: Preparation to support mac-nat
Message-ID: <202511070917.SA9qQyy5-lkp@intel.com>
References: <20251105161450.1730216-2-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105161450.1730216-2-skorodumov.dmitry@huawei.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-Preparation-to-support-mac-nat/20251106-004449
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251105161450.1730216-2-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net-next 01/14] ipvlan: Preparation to support mac-nat
config: s390-randconfig-001-20251107 (https://download.01.org/0day-ci/archive/20251107/202511070917.SA9qQyy5-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511070917.SA9qQyy5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511070917.SA9qQyy5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ipvlan/ipvlan_core.c:435:13: warning: 'is_ipv6_usable' defined but not used [-Wunused-function]
    static bool is_ipv6_usable(const struct in6_addr *addr)
                ^~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
   Selected by [m]:
   - REGULATOR_RT5133 [=m] && REGULATOR [=y] && I2C [=m] && GPIOLIB [=y] && OF [=y]


vim +/is_ipv6_usable +435 drivers/net/ipvlan/ipvlan_core.c

   434	
 > 435	static bool is_ipv6_usable(const struct in6_addr *addr)
   436	{
   437		return !ipv6_addr_is_multicast(addr) && !ipv6_addr_loopback(addr) &&
   438		       !ipv6_addr_any(addr);
   439	}
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

