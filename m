Return-Path: <netdev+bounces-119896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A0C957664
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED54C1C21481
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D1158D8B;
	Mon, 19 Aug 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fo2pji4f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2983A18
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102289; cv=none; b=oWCC4uLMGiiD2fRJ6PlzoisOj2UxjXnMq0DeRVPn+frY1pd5QiA6z75r8zu1PlBmTkJe2XTMQYfCtta3CwO/+pSHpEEUgvgVt76UndBcWYJMcrrDSWsrAWnGRwE9FoEhCv4xfFh4gU52OTbhJ77rg2B8Sq4w1XQdLCDcNNxYofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102289; c=relaxed/simple;
	bh=x73kZuGeZPO/zMICJM5bFMWIWhQjMQY30f8YDgfQWSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si5cq7hr8TM1MkSp5aDzZztmmd2i+Ed6I6XCtgWbWSXQZW0hRAbxuY1BnKwxgoRDxo/Jh7DO2h+ebs8wGOIa9lKM39ooWTsTSQHzEbneKuLhcMZ3n2YoGJ2wT72fOY8qrLMRFlb21S4Sf7UkWTL64SqfEWZMpOEY98h92uQYWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fo2pji4f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724102288; x=1755638288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x73kZuGeZPO/zMICJM5bFMWIWhQjMQY30f8YDgfQWSc=;
  b=fo2pji4ffV1esgvhPWba8+REJWrUKcGOh3ok7cO+rLfobw/NrzVwmOrk
   vlq0vUGe++ZVTqc6YWLjVc5jbIE8IuG4fx5SER9w0Si3WW52+W0Q9okVO
   bU2so9s+NwiTC25xXr68Qhh/8mtd53d7JfwWpgU4/3Sx53eFjHojfcg+k
   Y+0vXQ9sX0HTCxW2OFsfl9TF0q8Z3Gts7+8LNgL+2SAFDh4kSV4g8IJVh
   E/hCkTYaB+9XE/idu3tzu18r0eOuwI2W7hSYOJYmn6zSDaW1ewsRZ1NsX
   KWpa624UW6TIHHkN6OuE/DlKrXsHdkdhVe7H4Yo+BTqLVpjiug+IxA+z6
   w==;
X-CSE-ConnectionGUID: TD/Xy5rxSdCUJO/R6cmpGQ==
X-CSE-MsgGUID: BgFUHK/VS5SWuOLyT5eQMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22343201"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22343201"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 14:18:07 -0700
X-CSE-ConnectionGUID: 1ejfIbMFTVadCQuYlqne2Q==
X-CSE-MsgGUID: DBGYolQdTuG4lV4wBH7/+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60463425"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2024 14:18:04 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg9lJ-0009Re-2N;
	Mon, 19 Aug 2024 21:18:01 +0000
Date: Tue, 20 Aug 2024 05:17:52 +0800
From: kernel test robot <lkp@intel.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCHv2 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <202408200431.wjjkEZ2m-lkp@intel.com>
References: <20240819075334.236334-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819075334.236334-3-liuhangbin@gmail.com>

Hi Hangbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangbin-Liu/bonding-add-common-function-to-check-ipsec-device/20240819-195504
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240819075334.236334-3-liuhangbin%40gmail.com
patch subject: [PATCHv2 net-next 2/3] bonding: Add ESN support to IPSec HW offload
config: x86_64-buildonly-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240820/202408200431.wjjkEZ2m-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408200431.wjjkEZ2m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200431.wjjkEZ2m-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/bonding/bond_main.c:434:10: error: returning 'void *' from a function with incompatible result type 'struct net_device'
     434 |                 return NULL;
         |                        ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
   drivers/net/bonding/bond_main.c:442:10: error: returning 'void *' from a function with incompatible result type 'struct net_device'
     442 |                 return NULL;
         |                        ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
   drivers/net/bonding/bond_main.c:446:9: error: returning 'struct net_device *' from a function with incompatible result type 'struct net_device'; dereference with *
     446 |         return real_dev;
         |                ^~~~~~~~
         |                *
   drivers/net/bonding/bond_main.c:630:11: error: assigning to 'struct net_device *' from incompatible type 'struct net_device'
     630 |         real_dev = bond_ipsec_dev(xs);
         |                  ^ ~~~~~~~~~~~~~~~~~~
   drivers/net/bonding/bond_main.c:658:11: error: assigning to 'struct net_device *' from incompatible type 'struct net_device'
     658 |         real_dev = bond_ipsec_dev(xs);
         |                  ^ ~~~~~~~~~~~~~~~~~~
>> drivers/net/bonding/bond_main.c:668:2: error: use of undeclared identifier 'rhel_dev'; did you mean 'real_dev'?
     668 |         rhel_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
         |         ^~~~~~~~
         |         real_dev
   drivers/net/bonding/bond_main.c:655:21: note: 'real_dev' declared here
     655 |         struct net_device *real_dev;
         |                            ^
   6 errors generated.


vim +668 drivers/net/bonding/bond_main.c

   648	
   649	/**
   650	 * bond_advance_esn_state - ESN support for IPSec HW offload
   651	 * @xs: pointer to transformer state struct
   652	 **/
   653	static void bond_advance_esn_state(struct xfrm_state *xs)
   654	{
   655		struct net_device *real_dev;
   656	
   657		rcu_read_lock();
   658		real_dev = bond_ipsec_dev(xs);
   659		if (!real_dev)
   660			goto out;
   661	
   662		if (!real_dev->xfrmdev_ops ||
   663		    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
   664			pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
   665			goto out;
   666		}
   667	
 > 668		rhel_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
   669	out:
   670		rcu_read_unlock();
   671	}
   672	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

