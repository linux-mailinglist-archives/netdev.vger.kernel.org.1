Return-Path: <netdev+bounces-165205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FCCA30F3C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF83A843B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FF24F5AA;
	Tue, 11 Feb 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRBoTkIK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DB26BD8C
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286448; cv=none; b=fBzumosyDO6LrpwLGCh52m1aTLn+FX2cuZiAnxzn7ORCA/5mtRWwNtLUxPyizjUtxSA5JHY29UUxZuA+Iz3Vdy+AyAW3PCLOgXqLqrIy7ddVR5Zp76RYQncuvPSc/1tn8IUpYtIQL3qcstLUDlXihfGRHNhVy0gPkYqt89rEOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286448; c=relaxed/simple;
	bh=63VFTzhlfsv+FsZFWjumFpyRmumdLMBYpTENKjOczHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtajRQzxY4BXBXKT+ic0gB5GJhiSF1isTqDCRF7N8N1Wa1yV3BG59AVysDnL7/I9BY6CDnXLdyiDxg0DCKHjsrfJsq+QueV3K3v+NY20WgNtjiQaEceZrqLtH9WZnnGSiFPU5TVfTpfhGkJb58SpYTs/LoASDhgaQVERwKFWRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRBoTkIK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739286447; x=1770822447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63VFTzhlfsv+FsZFWjumFpyRmumdLMBYpTENKjOczHc=;
  b=HRBoTkIKPK8tvvGbipPB2Vlr2tkxNVKf7TWi4uiRh+yEz5BpDJPd4Eiy
   hWCfJE+N6iTj1DpGpCUzH8crHzsKoc4x7bFzjd1oM54U0VYzR5BwJnktS
   0Bjh5dZkLG2b4hFg1RFZNTz99NQEN8+rN1oht5RAn3AK8gR4J7LVLf211
   xHVMqB9Q9rxWSz1KpGlJX/O9mEEgWzVQvAWorixRLPcQuIT0HUUZLoF5Y
   Zvrhi59Lv6IiLj5OGD4IbONb1Dup9n9MaXyjlKp3bdPtg+AHHr7Nq1TTE
   aziwae+GjAFiCQ4eWIG6T9pcWMEHduVMBPJAtrfASg55c+6OcazUUyXVV
   w==;
X-CSE-ConnectionGUID: A89MC3oUQvuhwa/xt62fug==
X-CSE-MsgGUID: 1s3HUMTwQuy2BTZMmczW4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="65265096"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="65265096"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:07:26 -0800
X-CSE-ConnectionGUID: NNsH8mroR9G95lu4V/QFpA==
X-CSE-MsgGUID: PMIuv5/aQt6Jwd2faijUjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149723779"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Feb 2025 07:07:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thrr7-0014Kt-1S;
	Tue, 11 Feb 2025 15:07:21 +0000
Date: Tue, 11 Feb 2025 23:06:52 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 04/11] net: hold netdev instance lock during
 rtnetlink operations
Message-ID: <202502112254.DdkYlmMx-lkp@intel.com>
References: <20250210192043.439074-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210192043.439074-5-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-hold-netdev-instance-lock-during-ndo_open-ndo_stop/20250211-032336
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250210192043.439074-5-sdf%40fomichev.me
patch subject: [PATCH net-next 04/11] net: hold netdev instance lock during rtnetlink operations
config: arc-randconfig-001-20250211 (https://download.01.org/0day-ci/archive/20250211/202502112254.DdkYlmMx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250211/202502112254.DdkYlmMx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502112254.DdkYlmMx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/dev.c: In function 'dev_set_mtu':
   net/core/dev.c:9320:15: error: implicit declaration of function 'netdev_set_mtu_ext_locked'; did you mean 'netdev_ops_assert_locked'? [-Werror=implicit-function-declaration]
    9320 |         err = netdev_set_mtu_ext_locked(dev, new_mtu, &extack);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |               netdev_ops_assert_locked
   net/core/dev.c: At top level:
>> net/core/dev.c:11390:12: warning: 'netdev_lock_cmp_fn' defined but not used [-Wunused-function]
   11390 | static int netdev_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b)
         |            ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> net/core/dev_api.c:109: warning: Excess function parameter 'new_ifindex' description in 'dev_change_net_namespace'


vim +/netdev_lock_cmp_fn +11390 net/core/dev.c

 11389	
 11390	static int netdev_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b)
 11391	{
 11392		/* Only lower devices currently grab the instance lock, so no
 11393		 * real ordering issues can occur. In the near future, only
 11394		 * hardware devices will grab instance lock which also does not
 11395		 * involve any ordering. Suppress lockdep ordering warnings
 11396		 * until (if) we start grabbing instance lock on pure SW
 11397		 * devices (bond/team/etc).
 11398		 */
 11399		return -1;
 11400	}
 11401	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

