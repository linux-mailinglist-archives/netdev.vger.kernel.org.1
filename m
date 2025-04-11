Return-Path: <netdev+bounces-181480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1DA851F8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BD77AA2DB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA427CCC0;
	Fri, 11 Apr 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mze1Vpmg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661527CB27
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341441; cv=none; b=opxpIRRPMt2ii5IzGmJTS1uBRd0rKK6rVtTd50s4LCz0EP4+F67BVPWn1Sa+0ufRkvuDrv69I1CJZxItvN8Il3VwGc5ky2iUd0d/QYSN6q6BqkQcDiTgxjpUz7RE9krRE2ClupOGfROswNysUfSArBqFvsBatSjkJ93zp88jw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341441; c=relaxed/simple;
	bh=kCIruLXaKMtpMhZ7JiuxlHXSK3V+URt3EV5UGRk9+p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXQgQouSs5E5UnmS2Icn4LapP/k2DhRqSFucOgLFHV/81FI1Bpn+B04gbYHcXSf9y97PNc9PGFnD7xMkHixtt8NfYqfInNyCfErQBJCfcys85L6ookNV9ZnYhFWfdjyIX3HaGD9t6PAPZLpfGTOi2cSfGuUD/rFEgbVXa4yrbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mze1Vpmg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744341439; x=1775877439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kCIruLXaKMtpMhZ7JiuxlHXSK3V+URt3EV5UGRk9+p4=;
  b=Mze1Vpmg0YqYMQY/kKmLS6B2rVOW4fsw7GqZLID2MTnsYSSiHUBWLnpm
   3NrYdZzIaDLhXQBWXVAf5jDRiTTR5skvSxgVtKelj8qGlWlMfR+Ox9ep+
   gs4StYpINZaQvFw11cw6A6nuJKz62gCqYoqtIM3almcNjb7tm/pefOBOI
   wxRCSIQt9I46H3fR/r5/2XFUKAaNx73mHVanw1Rfgg7OoQ2tkAd6dsFEc
   Xyyh6RRRQ2SBR+3v/S3y91E1hNc+bGc0NolZk6PFrd8bbjSQxlmpyYkuL
   vPSTkS2jc3JoUNYHwg3BS67zxjumIJpv1D/XjgFl47btBT/y/7si9gty9
   A==;
X-CSE-ConnectionGUID: mtEfQDW2TcKE2VeZV3hrxA==
X-CSE-MsgGUID: tPia9KRKSui4ZNaVJMvnKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45896652"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45896652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 20:17:19 -0700
X-CSE-ConnectionGUID: d+m2knmATXq0imrg7brrIw==
X-CSE-MsgGUID: 9gu07PUPQA+SmlIBc8DI2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129409282"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Apr 2025 20:17:16 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u34tG-000Al1-0T;
	Fri, 11 Apr 2025 03:17:14 +0000
Date: Fri, 11 Apr 2025 11:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 02/14] net: Add ops_undo_single for module
 load/unload.
Message-ID: <202504111024.Qc5fW99d-lkp@intel.com>
References: <20250410022004.8668-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410022004.8668-3-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/net-Factorise-setup_net-and-cleanup_net/20250410-102752
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250410022004.8668-3-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 02/14] net: Add ops_undo_single for module load/unload.
config: loongarch-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111024.Qc5fW99d-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111024.Qc5fW99d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111024.Qc5fW99d-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/core/net_namespace.c: In function '__unregister_pernet_operations':
>> net/core/net_namespace.c:1311:17: error: implicit declaration of function 'free_exit_list'; did you mean 'ops_exit_list'? [-Wimplicit-function-declaration]
    1311 |                 free_exit_list(ops, &net_exit_list);
         |                 ^~~~~~~~~~~~~~
         |                 ops_exit_list
   net/core/net_namespace.c: At top level:
>> net/core/net_namespace.c:238:13: warning: 'ops_undo_single' defined but not used [-Wunused-function]
     238 | static void ops_undo_single(struct pernet_operations *ops,
         |             ^~~~~~~~~~~~~~~


vim +1311 net/core/net_namespace.c

ed160e839d2e11 Denis V. Lunev    2007-11-13  1303  
f875bae0653349 Eric W. Biederman 2009-11-29  1304  static void __unregister_pernet_operations(struct pernet_operations *ops)
ed160e839d2e11 Denis V. Lunev    2007-11-13  1305  {
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1306  	if (!init_net_initialized) {
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1307  		list_del(&ops->list);
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1308  	} else {
72ad937abd0a43 Eric W. Biederman 2009-12-03  1309  		LIST_HEAD(net_exit_list);
72ad937abd0a43 Eric W. Biederman 2009-12-03  1310  		list_add(&init_net.exit_list, &net_exit_list);
41467d2ff4dfe1 Yajun Deng        2021-08-17 @1311  		free_exit_list(ops, &net_exit_list);
ed160e839d2e11 Denis V. Lunev    2007-11-13  1312  	}
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1313  }
f875bae0653349 Eric W. Biederman 2009-11-29  1314  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

