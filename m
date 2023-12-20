Return-Path: <netdev+bounces-59227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C5819F6B
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CB8286A6B
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977025544;
	Wed, 20 Dec 2023 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l69cNsEB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295822305
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703077217; x=1734613217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VzRm9tZ3Z5NmLWaanU6i/NBFQIKSzDR0QuhRMFq5TbM=;
  b=l69cNsEBOKahqDAJDdaGnIymRZIU7minWysXG+onAfx0+yy4qHaf2zlA
   JVmxuqUugMVH1S7/vRYD9h87y3EzvYBLbcodIlYfYoBcFlbTbNCEIhCvj
   PkDpPJHOC+Hm8jOErmw5NLswKYXwcvs9SmA2LIBEuKuB0Y0XJGre2CGur
   Jk1bN4/KFxRDKnL3X5u13llb/PyST4TAYkBxcpHOUqtBGLaP1cQdeBSOz
   EGsJDkBkJEPpTAvktBeCoVObAZbT1FuBg/lBh/ZS/Otm9Ks2pVsyqsyM3
   3HcPPdmrPuLFvwmyDmHoAk1ZB88J6d+2TLJSDHpwhnC8b9KuQTD9gGPTV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375297938"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="375297938"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 05:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="842266959"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="842266959"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2023 05:00:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFwAm-0006sj-1t;
	Wed, 20 Dec 2023 13:00:03 +0000
Date: Wed, 20 Dec 2023 20:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <202312202036.QxZ1fdee-lkp@intel.com>
References: <20231220014747.1508581-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220014747.1508581-3-dw@davidwei.uk>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wei/netdevsim-maintain-a-list-of-probed-netdevsims/20231220-095238
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231220014747.1508581-3-dw%40davidwei.uk
patch subject: [PATCH net-next v4 2/5] netdevsim: allow two netdevsim ports to be connected
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231220/202312202036.QxZ1fdee-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 10056c821a56a19cef732129e4e0c5883ae1ee49)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312202036.QxZ1fdee-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312202036.QxZ1fdee-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/netdevsim/dev.c:431:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     431 |         if (!peer)
         |             ^~~~~
   drivers/net/netdevsim/dev.c:443:9: note: uninitialized use occurs here
     443 |         return ret;
         |                ^~~
   drivers/net/netdevsim/dev.c:431:2: note: remove the 'if' if its condition is always false
     431 |         if (!peer)
         |         ^~~~~~~~~~
     432 |                 goto out;
         |                 ~~~~~~~~
   drivers/net/netdevsim/dev.c:425:13: note: initialize the variable 'ret' to silence this warning
     425 |         ssize_t ret;
         |                    ^
         |                     = 0
   1 warning generated.


vim +431 drivers/net/netdevsim/dev.c

   417	
   418	static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
   419					  size_t count, loff_t *ppos)
   420	{
   421		struct nsim_dev_port *nsim_dev_port;
   422		struct netdevsim *peer;
   423		unsigned int id, port;
   424		char buf[23];
   425		ssize_t ret;
   426	
   427		mutex_lock(&nsim_dev_list_lock);
   428		rtnl_lock();
   429		nsim_dev_port = file->private_data;
   430		peer = rtnl_dereference(nsim_dev_port->ns->peer);
 > 431		if (!peer)
   432			goto out;
   433	
   434		id = peer->nsim_bus_dev->dev.id;
   435		port = peer->nsim_dev_port->port_index;
   436		ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
   437		ret = simple_read_from_buffer(data, count, ppos, buf, ret);
   438	
   439	out:
   440		rtnl_unlock();
   441		mutex_unlock(&nsim_dev_list_lock);
   442	
   443		return ret;
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

