Return-Path: <netdev+bounces-149742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C339E7190
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1093F1625A1
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3E21FA279;
	Fri,  6 Dec 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do6T4CVe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662131FCCE5;
	Fri,  6 Dec 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497052; cv=none; b=dgjkmMZT44k4u+0AL4GNg1R1x8DvNH8y3jvWHVGZ3yaFBZiEfg+crJKS4K/9bIZWRilH5eWO8v0aCM2QprYfywFy/GeW2XlCgwSi6PSuPfZsaiAaglUfFvbdqmPBlMKsLYDMIjZTa069sfdAzBwCWZtvd2jsYrX6blne/NtVF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497052; c=relaxed/simple;
	bh=rIiclzYWsy2EpIFwkYbIy1wPtiPdlIKiO08nnrnWi6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXKWYpPRegBU2ORLVudyTKUS8KDMwCZ4ET4yW2URDNnXwSak/NGo93DeP83qFNwsoVzJhWo48OsRPBXaE4KChkHZL+Z4XqXDMbiZg7gW3oNn6qOc4ZbFeKxURTr3M+OZqvi9WoPeTM5yY75r7JHjWEOfSCo6CgfD/63/0diafyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do6T4CVe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733497051; x=1765033051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rIiclzYWsy2EpIFwkYbIy1wPtiPdlIKiO08nnrnWi6s=;
  b=Do6T4CVeJfbooKyxg+tcczoDFu3nlTCKls9svSsEOqIZqmNIPEy4RveJ
   1Crz4VX0E4WbMokVhE7DS6NEE3Z1FgdEEVIw4teT775GgOFowxagLwYiB
   jVp5kOSVRzIAbZ4PWTyKmV44qJp4n/F+Vf7mKxiuuMiOTcylVI8zWFhnP
   1OlLv7l6tsCmCnp/rsICMBCcs6pQEyMIHUnyY1XXvbBW7sJV7/90uN3lq
   klZqV6ifySLkE8bJyos58NWquqJwM+rXMDSHBGMTZMIVnMg4JdbQf69Mb
   sU8csAk6nQPukRIf9q8y3zuvlmUFZGmlBkE7LivgIsE+3bvcLcWGyt7yu
   g==;
X-CSE-ConnectionGUID: N+1Ny9V6RKaZV3yUO7tdHw==
X-CSE-MsgGUID: Hiw5ZeZYS3CIELWEJcPQuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37636532"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37636532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 06:57:30 -0800
X-CSE-ConnectionGUID: RLR5WN/rQMK7fcC/pevK1g==
X-CSE-MsgGUID: y291u3VkSESRjnUcBPPRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="98490816"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Dec 2024 06:57:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJZlh-0001Sp-38;
	Fri, 06 Dec 2024 14:57:21 +0000
Date: Fri, 6 Dec 2024 22:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaojijie@huawei.com,
	hkelam@marvell.com
Subject: Re: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir()
 helper
Message-ID: <202412062221.GPVtNG5v-lkp@intel.com>
References: <20241206111629.3521865-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206111629.3521865-2-shaojijie@huawei.com>

Hi Jijie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jijie-Shao/debugfs-Add-debugfs_create_devm_dir-helper/20241206-192734
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241206111629.3521865-2-shaojijie%40huawei.com
patch subject: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir() helper
config: powerpc-ebony_defconfig (https://download.01.org/0day-ci/archive/20241206/202412062221.GPVtNG5v-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412062221.GPVtNG5v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412062221.GPVtNG5v-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/debugfs/inode.c:643:3: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     643 |                 ERR_PTR(ret);
         |                 ^~~~~~~ ~~~
   1 warning generated.


vim +/warn_unused_result +643 fs/debugfs/inode.c

   619	
   620	/**
   621	 * debugfs_create_devm_dir - Managed debugfs_create_dir()
   622	 * @dev: Device that owns the action
   623	 * @name: a pointer to a string containing the name of the directory to
   624	 *        create.
   625	 * @parent: a pointer to the parent dentry for this file.  This should be a
   626	 *          directory dentry if set.  If this parameter is NULL, then the
   627	 *          directory will be created in the root of the debugfs filesystem.
   628	 * Managed debugfs_create_dir(). dentry will automatically be remove on
   629	 * driver detach.
   630	 */
   631	struct dentry *debugfs_create_devm_dir(struct device *dev, const char *name,
   632					       struct dentry *parent)
   633	{
   634		struct dentry *dentry;
   635		int ret;
   636	
   637		dentry = debugfs_create_dir(name, parent);
   638		if (IS_ERR(dentry))
   639			return dentry;
   640	
   641		ret = devm_add_action_or_reset(dev, debugfs_remove_devm, dentry);
   642		if (ret)
 > 643			ERR_PTR(ret);
   644	
   645		return dentry;
   646	}
   647	EXPORT_SYMBOL_GPL(debugfs_create_devm_dir);
   648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

