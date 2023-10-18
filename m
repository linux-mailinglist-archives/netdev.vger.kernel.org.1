Return-Path: <netdev+bounces-42095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B047CD1B1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A82B21003
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571AEC3;
	Wed, 18 Oct 2023 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOdu7bzm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC34EDE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:13:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA7FD
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 18:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697591578; x=1729127578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3y4VOaeb5VOWwjk004T1iDytBCrLOtFdXPCLmP84Imc=;
  b=fOdu7bzmPDPLUS32EBcJaItsXIsEivE4HUKZulfa6epzZHOarP1eZk3F
   VrjU/Hjw8ZZ8Cefd1jabavpbCiNkLXb8dcA89mDcsIMXZSE+cP/aVKrm1
   56HhDg9ahn8GZ19KZRXIeW8x/LAWckbAk+AMul5lXkTB8xTe4kv/a+fj+
   aYTiwW+c/tuRzDBsgcGjK42wjaaikZ2q4jeqZGmYiKAYcFVoupWJ5uwx+
   9VnncA9vym6f56iVBxBK/X3xRM5XLxgeCBZdqkoU1XAsQ+qAsQ7ScqB5g
   lvUTns+voo96DTfrAjL4fpKsUlscD/72XpTdSYYlqHFaIL24FaRM6+yME
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384792391"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384792391"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826667277"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826667277"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 18:12:57 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qsv7H-000AJX-1e;
	Wed, 18 Oct 2023 01:12:55 +0000
Date: Wed, 18 Oct 2023 09:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v5 1/2] net: dsa: Use conduit and user terms
Message-ID: <202310180907.RbYMqtyd-lkp@intel.com>
References: <20231017233536.426704-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017233536.426704-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-dsa-Use-conduit-and-user-terms/20231018-073644
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231017233536.426704-2-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next v5 1/2] net: dsa: Use conduit and user terms
reproduce: (https://download.01.org/0day-ci/archive/20231018/202310180907.RbYMqtyd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180907.RbYMqtyd-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPLIT_STRING: quoted string split across lines
#4682: FILE: net/dsa/tag_sja1105.c:399:
 					    "Expected meta frame, is %12llx "
+					    "in the DSA conduit multicast filter?\n",

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

