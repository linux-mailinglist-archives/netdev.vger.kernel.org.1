Return-Path: <netdev+bounces-44295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30F7D779C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2871C209E4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE037161;
	Wed, 25 Oct 2023 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVx8IqUz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4C35888
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:08:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12F137
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698271725; x=1729807725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Tt3J6JtFPyCHVZ0qWGspBMZCNoJx4XaiuK/ZuPKkwE=;
  b=cVx8IqUz3HEDBUbVbVpFtS/Qyn+szbKjoJTyaE6LzwicrIRfFZRDWjwN
   GMUk7kN+wvAWsH+ZjJWDhk73x01WilOCZAHAfFxbG4nLfVs8OdQQ8Ow8q
   LD5oHDIQLtVJ5OM2TvchcHILxhAk2S5RPJGIF9knxPWx9bTOF96/bOZBu
   jCSD5ZjKNfmGMTy+hZ8Mm682zWFHhG7nvfiw06tjzMQVssFm0wm66zXfL
   eaRpWiEsmZ7Do+SLFNUOX4+WDfhsaY3E49JjJTm3XuhwEZ9u5Ygb9yU1Q
   v7qR3jyglikBwc1nyCu2542A65VMLQDLcwLehB500PDcxzY+uU3lxL0JR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="191198"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="191198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 15:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875670592"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="875670592"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2023 15:08:42 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qvm3M-0009EM-1L;
	Wed, 25 Oct 2023 22:08:40 +0000
Date: Thu, 26 Oct 2023 06:08:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, almasrymina@google.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 09/15] net: page_pool: implement GET in the
 netlink API
Message-ID: <202310260559.9QsjadJ3-lkp@intel.com>
References: <20231024160220.3973311-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024160220.3973311-10-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/net-page_pool-split-the-page_pool_params-into-fast-and-slow/20231025-023128
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231024160220.3973311-10-kuba%40kernel.org
patch subject: [PATCH net-next 09/15] net: page_pool: implement GET in the netlink API
config: csky-defconfig (https://download.01.org/0day-ci/archive/20231026/202310260559.9QsjadJ3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260559.9QsjadJ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260559.9QsjadJ3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> csky-linux-ld: net/core/netdev-genl-gen.o:(.rodata+0x48): undefined reference to `netdev_nl_page_pool_get_doit'
>> csky-linux-ld: net/core/netdev-genl-gen.o:(.rodata+0x60): undefined reference to `netdev_nl_page_pool_get_dumpit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

