Return-Path: <netdev+bounces-57589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440C5813874
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD44B20DDD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3565ED6;
	Thu, 14 Dec 2023 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On1rQijo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10468A7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702574738; x=1734110738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jMw7RRpHVs9kaxegVgNIhrUhV/V/APavpUBnfUCm8/0=;
  b=On1rQijo+NhTEjRmCrfROI26ehRH07MKW5hWx8atNsPoLFuzMttNJeqm
   7zeGKXSOSKvLt18zhxnGQB5DHdObJX+2r52Pan39tCh/bn/tdnCD0HREq
   266Ol7Vxoh7nW2wg+LS1Y4Ea+MZPA3OQkfQ589N2s+DmjZjvPnZni53jo
   tZ7SqRz7A7fc+expfpyL92sL7jES/BY9z+H+XXT95X1/KO9yugbAUDrGK
   q8EUydyvp/7UFk9gHcNJ26Q6FXImrSkUD+0dxoavAZofmCUkZtP3bkMZd
   NVFmKMtmXUVeDR+qcyWwq/iNptp+UR7brLQOphUJ4tgPgt2QHsOUgpoRU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="481345178"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="481345178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803361479"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="803361479"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2023 09:25:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDpSg-000MOA-1z;
	Thu, 14 Dec 2023 17:25:31 +0000
Date: Fri, 15 Dec 2023 01:24:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>, matttbe@kernel.org,
	martineau@kernel.org, dcaratti@redhat.com, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] netlink: specs: mptcp: rename the MPTCP
 path management(?) spec
Message-ID: <202312150140.ST22T64E-lkp@intel.com>
References: <20231213232822.2950853-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213232822.2950853-4-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/netlink-specs-ovs-remove-fixed-header-fields-from-attrs/20231214-073118
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231213232822.2950853-4-kuba%40kernel.org
patch subject: [PATCH net-next 3/3] netlink: specs: mptcp: rename the MPTCP path management(?) spec
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312150140.ST22T64E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150140.ST22T64E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/netlink/specs/mptcp.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

