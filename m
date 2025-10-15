Return-Path: <netdev+bounces-229698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A8BDFEA5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B573B86AA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26332F25E8;
	Wed, 15 Oct 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRccZDyT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B91DD0D4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550111; cv=none; b=ExZN3oX2udrhH/rqxQJlFpRF5V1vrtIL5W6mFUSHh8TX8YPGazg2hKlLaoFpbBDoVEh4b+TBBbjm9j+9qkHkS+OL0emdl1/I5eeuEKtITbglZoOoLmqUgML9F6tZrwVFFj1JOn2Pq0+HLKs8HP1eFmeRaHTO2gubS2rrKUDm+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550111; c=relaxed/simple;
	bh=dtLpUXk6B/DNsmiTHB0RXuoPe8qLrJTYYwE5bIHPGY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx+9aUKHtjzt8EeJ39zsodklmTSh2HhBklRmLTGOjpDjDUurlu/pls3sLyJDpbhZoR7u+ybRNGy4XIf5xvBPDignVS9WlDJCVjufVJi6QgolJtWH+fzEoGG1fTh3bWkRUNN652Ig6HZEV0XJSY+PZt+O9BJI8MBPOyYpXdkm4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRccZDyT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760550110; x=1792086110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dtLpUXk6B/DNsmiTHB0RXuoPe8qLrJTYYwE5bIHPGY4=;
  b=XRccZDyT1OUgYmE8GonDOFJVOkqgEcYrxgIAbTOpTGPnnTaFsJjYVzrg
   aomm0d/Iqcy5R77HGorneimQGOX+344Tli/cjcyY35Qmq1QNiqlD8BD1A
   faE5kCFAn1XHCpzv+i4cFtdP0Y/8OCjGbkagGkmu1zLqNGaEybyo7BCv7
   Icq5hfcn54HXf4eZU05fgZc16fmqOXvL/xvYqQFtGOUoaVtv8XIQNHGBc
   kG5JO4eTaBKvxDKdjJOSeo6W0xhlGdBUoWrBumBMC/kZ/Q3jMqkADStwA
   JNAUuW+9+mHIe8v2S4cV79bywWgwhVrcF6Z6p/pX3Nrz5SGULJtFa/oZ5
   Q==;
X-CSE-ConnectionGUID: M+FUkTtZRDmTsvm0Ruc7ng==
X-CSE-MsgGUID: JogMCfAWQJ2i49slxhGJ1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62634009"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62634009"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:41:50 -0700
X-CSE-ConnectionGUID: BptgaTwmTEiorr8Wda0uTw==
X-CSE-MsgGUID: EDNcAc4dR/GiGSJlZ1pLBA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2025 10:41:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v95VQ-00045H-29;
	Wed, 15 Oct 2025 17:41:44 +0000
Date: Thu, 16 Oct 2025 01:41:36 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	Shyam-sundar.S-k@amd.com, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH net-next 1/4] amd-xgbe: introduce support ethtool selftest
Message-ID: <202510160112.aE3SoRiU-lkp@intel.com>
References: <20251014181040.2551144-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014181040.2551144-2-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-introduce-support-ethtool-selftest/20251015-021414
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251014181040.2551144-2-Raju.Rangoju%40amd.com
patch subject: [PATCH net-next 1/4] amd-xgbe: introduce support ethtool selftest
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20251016/202510160112.aE3SoRiU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510160112.aE3SoRiU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510160112.aE3SoRiU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c: In function 'xgbe_selftest_get_strings':
>> drivers/net/ethernet/amd/xgbe/xgbe-selftest.c:387:52: warning: '%.27s' directive output may be truncated writing up to 27 bytes into a region of size between 19 and 28 [-Wformat-truncation=]
     387 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %.27s", i + 1,
         |                                                    ^~~~~
   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c:387:17: note: 'snprintf' output between 5 and 41 bytes into a destination of size 32
     387 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %.27s", i + 1,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     388 |                          xgbe_selftests[i].name);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~


vim +387 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

   380	
   381	void xgbe_selftest_get_strings(struct xgbe_prv_data *pdata, u8 *data)
   382	{
   383		u8 *p = data;
   384		int i;
   385	
   386		for (i = 0; i < xgbe_selftest_get_count(pdata); i++) {
 > 387			snprintf(p, ETH_GSTRING_LEN, "%2d. %.27s", i + 1,
   388				 xgbe_selftests[i].name);
   389			p += ETH_GSTRING_LEN;
   390		}
   391	}
   392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

