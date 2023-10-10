Return-Path: <netdev+bounces-39754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59C7C4524
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BE8281D48
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A85321AE;
	Tue, 10 Oct 2023 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHyDBXBv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96109354E8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:59:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE3598
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696978768; x=1728514768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=io+qkP4byi1tMSpyOvowi8R/D43wwiucaIMaALBCJp8=;
  b=dHyDBXBvYU+HTtJbyHhwdObAQ1axyUObTyAR2CwwpFS97mhLXfx3t+XG
   ab6uhtguwvCHmnXRuHM4XcTzzh81rK9j6H4rciY7129HYNHH5GY7mIcrE
   bQuHCdh5svlwjmRoRPLPXwcgK07sJoLQSDSSusxajdB8uCIGlXDvsBsL9
   vqEiwKgBC23kzfxcDACGD93IT5MFJ95TaIZv+CSPY/5Hgdl8v675hF86y
   J+f+NMGXixNgJpo08oQhXTwCDw/fiQbUie06PfW6bMRTI/hKGU+cgHjQ8
   w/soF3hqZeXZuiZhrjv9rQP3CrZzikTlb3talUGipD0Di5Xdf18LFsbxd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384387119"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="384387119"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 15:58:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823936522"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="823936522"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 15:58:51 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqLgd-0001LI-0n;
	Tue, 10 Oct 2023 22:58:47 +0000
Date: Wed, 11 Oct 2023 06:58:16 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] net: dsa: Use conduit and user terms
Message-ID: <202310110657.lN3YiHKv-lkp@intel.com>
References: <20231010213942.3633407-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010213942.3633407-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-dsa-Use-conduit-and-user-terms/20231011-054044
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231010213942.3633407-2-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next 1/2] net: dsa: Use conduit and user terms
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310110657.lN3YiHKv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110657.lN3YiHKv-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:CODE_INDENT: code indent should use tabs where possible
#2091: FILE: include/net/dsa.h:1239:
+^I^I^I^I        const struct net_device *conduit,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#2092: FILE: include/net/dsa.h:1240:
+^I^I^I^I        bool operational);$

WARNING:SPLIT_STRING: quoted string split across lines
#4535: FILE: net/dsa/tag_sja1105.c:399:
 					    "Expected meta frame, is %12llx "
+					    "in the DSA conduit multicast filter?\n",

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#6525: FILE: net/dsa/user.c:2433:
+^I.ndo_open^I ^I= dsa_user_open,$

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

