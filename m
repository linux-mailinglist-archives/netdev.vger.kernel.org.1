Return-Path: <netdev+bounces-96662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B18C6FA4
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 02:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A91F21F42
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 00:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F83620;
	Thu, 16 May 2024 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oC3V21ik"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE064A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715820439; cv=none; b=ppBhjceU6YhoaA8nijjESHubtvXbeezPlmdr+0QE/bLv7hdsIvDUO3sgZBHdIsoUwZYIbBucfUCgQhjztB9xx1p0DiuSATybFiJpjnMEntF19yUiK+9f7gkJslgsxbDIpXuvX8UmmzTjdjaoRW9ex1cgDyY7CnViU4TIti38U7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715820439; c=relaxed/simple;
	bh=FAKesofL6Ngpdwwt4EsAfv183zLhqXsdZ3jpultxXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9r0GZ1lY7I7q0I88nLLU+u+Rnp7mhBy3zaqIdVS0IQ2+YrIcOu5x8CbICrq179a0mltzu0F8H4vA6HBv05V21M5bKBNJWXwK+RVTjmBNyWOCpc6q5lYOKEghsMuzovWLyNbo8ii9wUDKtf0ha4QeecDkCIOSflC6Xa6/fGGmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oC3V21ik; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715820437; x=1747356437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FAKesofL6Ngpdwwt4EsAfv183zLhqXsdZ3jpultxXCM=;
  b=oC3V21ik9HutTQJRqu6AxxooRUZ7xisMCuV49uuHD5S4FmNxc30NpqD4
   Q/y80x7DJrIv/OhIujBpSE8MSBuPSduoTIRSoW5B9Vt4CgdgTTnm2bjQ7
   wkiImn5KxONyY4YhIKeQIbJSzIVcHKzFNWcik4+UzN7afnBh0U4yOqH7D
   g9WRVxI4g/MPDK0vnnhFA0oXNvtfjAhELtHMjT1IF8H8Ae9t5aF+PrZ8I
   OWg5T8xnPW5Go8JzlTLWycqh/Qv9Qj12p1LRmhmX6uSyuPDAv+1bDnNxe
   f1T+0+QYaO1gTAKyEC30hmur7KqY5lHzsbCXeqo6TEgZ0yXGzY6Vf5SEL
   w==;
X-CSE-ConnectionGUID: xm9HOzIeSHKDnDpt0AU5Ug==
X-CSE-MsgGUID: ht6tSDtuTE2WZorEMQ33eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11738382"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11738382"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 17:47:16 -0700
X-CSE-ConnectionGUID: mDi6h4XjQ1aR3EM9g5x4Mw==
X-CSE-MsgGUID: KEHxCD0xRk6MAoxT9RVTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35691975"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 May 2024 17:47:14 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7PH6-000DPf-1k;
	Thu, 16 May 2024 00:47:12 +0000
Date: Thu, 16 May 2024 08:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jiawenwu@trustnetic.com, duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 5/6] net: ngbe: add sriov function support
Message-ID: <202405160844.t8jS88dy-lkp@intel.com>
References: <15515521993762EE+20240515100830.32920-6-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15515521993762EE+20240515100830.32920-6-mengyuanlou@net-swift.com>

Hi Mengyuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mengyuan-Lou/net-libwx-Add-sriov-api-for-wangxun-nics/20240515-185015
base:   net-next/main
patch link:    https://lore.kernel.org/r/15515521993762EE%2B20240515100830.32920-6-mengyuanlou%40net-swift.com
patch subject: [PATCH net-next v3 5/6] net: ngbe: add sriov function support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240516/202405160844.t8jS88dy-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240516/202405160844.t8jS88dy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405160844.t8jS88dy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/wangxun/libwx/wx_sriov.c:999:17: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
     999 |         if (wx->vfinfo[i].clear_to_send)
         |                        ^
   drivers/net/ethernet/wangxun/libwx/wx_sriov.c:992:7: note: initialize the variable 'i' to silence this warning
     992 |         u16 i;
         |              ^
         |               = 0
   drivers/net/ethernet/wangxun/libwx/wx_sriov.c:312:20: warning: unused function 'wx_ping_vf' [-Wunused-function]
     312 | static inline void wx_ping_vf(struct wx *wx, int vf)
         |                    ^~~~~~~~~~
   2 warnings generated.


vim +/i +999 drivers/net/ethernet/wangxun/libwx/wx_sriov.c

   988	
   989	void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
   990	{
   991		u32 msgbuf[2] = {0, 0};
   992		u16 i;
   993	
   994		if (!wx->num_vfs)
   995			return;
   996		msgbuf[0] = WX_PF_NOFITY_VF_LINK_STATUS | WX_PF_CONTROL_MSG;
   997		if (link_up)
   998			msgbuf[1] = (wx->speed << 1) | link_up;
 > 999		if (wx->vfinfo[i].clear_to_send)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

