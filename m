Return-Path: <netdev+bounces-130726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44398B59A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9447A1C20FD2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DC1BCA04;
	Tue,  1 Oct 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWDxGsPM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9021373
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767986; cv=none; b=o8BdGa11/kH0iD5TNaCvq+lk8aKAa8wR6U3sxLD5c5Mc2d3rTP6JnEDksPE3OCvcnpCs7hiyNzbce+JfhudXwGfvUGVJr4iW9/WZZHjKaKrfs//MgmBHjxRzg8+xkOTqgr3CnV6rp5fRChTW5xxiWo9iJP1B4t6w++mNcrVEJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767986; c=relaxed/simple;
	bh=fYbxgACuXAEFXQ+rxLZEIFoazF8bn+NDqFhesc8AUdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D39t3p3W3/zngUkelmBz5twHYyY6IG74ZSXiM06K1n9F3xD+nBIfauBfZGWttPleJosoo12xKShGKRnATDcdsYydM5IVoY2leSKufbMkLsTjgQLAFWAcUqGEIuYd2ejpcWrXHC+j9wQIMgNLebmO1E5SoxBEuZ0d77eBMwuNw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWDxGsPM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727767984; x=1759303984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fYbxgACuXAEFXQ+rxLZEIFoazF8bn+NDqFhesc8AUdo=;
  b=bWDxGsPMFA6MkUwIRdVK37ADcu2a6UPdKgpNW8JEnNw0yRmrufFO62HG
   OUSRFpLijX+uQz62s4mNGnn89T4AobnYz9TtuWu93b29WQiMX+/YyL2oC
   Mj6w2GYyRrl9K/35Is40ddLBRGRCd4uef8osEEyHGy0D65d4QauusjNFw
   TFLsDbSvOjU3VEyULtM5M4fCi4FQ0V5qNtNownNe3mvDGPRQto2Fk+st6
   iJLKOYYHhc21tKzwzKUQ+15YNDNmGLRwdjM0S3/lm/6Ac2zl+ypqxHLyC
   nlZCCatEZjVb9hD1fuCjbEtfVNOyXO7E+4oucX5JUigc3qwZE1GOcdIY7
   g==;
X-CSE-ConnectionGUID: OsyV8MwHQfykfccnt2ChuQ==
X-CSE-MsgGUID: dmmm4tbPQ7asWZXITof6sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30768083"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30768083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 00:33:02 -0700
X-CSE-ConnectionGUID: Nilq79CUTb2P3yLmUPgKBA==
X-CSE-MsgGUID: gKg+GbkUTMSdC0kWiGpaag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73700728"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 01 Oct 2024 00:33:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svXNR-000QNf-35;
	Tue, 01 Oct 2024 07:32:57 +0000
Date: Tue, 1 Oct 2024 15:32:54 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Yang <me@shenghaoyang.info>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com, olteanv@gmail.com, pavana.sharma@digi.com,
	ashkan.boldaji@digi.com, kabel@kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net 3/3] net: dsa: mv88e6xxx: support 4000ps cycle
 counter period
Message-ID: <202410011454.X1kiOgOz-lkp@intel.com>
References: <20240929101949.723658-5-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929101949.723658-5-me@shenghaoyang.info>

Hi Shenghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Yang/net-dsa-mv88e6xxx-group-cycle-counter-coefficients/20240929-182245
base:   net/main
patch link:    https://lore.kernel.org/r/20240929101949.723658-5-me%40shenghaoyang.info
patch subject: [PATCH net 3/3] net: dsa: mv88e6xxx: support 4000ps cycle counter period
config: sparc64-randconfig-r133-20240930 (https://download.01.org/0day-ci/archive/20241001/202410011454.X1kiOgOz-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241001/202410011454.X1kiOgOz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011454.X1kiOgOz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/dsa/mv88e6xxx/ptp.c:35:34: sparse: sparse: symbol 'mv88e6xxx_cc_10ns_coeffs' was not declared. Should it be static?
   drivers/net/dsa/mv88e6xxx/ptp.c:49:34: sparse: sparse: symbol 'mv88e6xxx_cc_8ns_coeffs' was not declared. Should it be static?
>> drivers/net/dsa/mv88e6xxx/ptp.c:63:34: sparse: sparse: symbol 'mv88e6xxx_cc_4ns_coeffs' was not declared. Should it be static?

vim +/mv88e6xxx_cc_4ns_coeffs +63 drivers/net/dsa/mv88e6xxx/ptp.c

    55	
    56	/* Family MV88E6393X using internal clock:
    57	 * Raw timestamps are in units of 4-ns clock periods.
    58	 *
    59	 * clkadj = scaled_ppm * 4*2^28 / (10^6 * 2^16)
    60	 * simplifies to
    61	 * clkadj = scaled_ppm * 2^8 / 5^6
    62	 */
  > 63	const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_4ns_coeffs = {
    64		.cc_shift = 28,
    65		.cc_mult = 4 << 28,
    66		.cc_mult_num = 1 << 8,
    67		.cc_mult_dem = 15625ULL
    68	};
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

