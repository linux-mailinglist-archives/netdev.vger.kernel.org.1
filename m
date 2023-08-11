Return-Path: <netdev+bounces-26815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28370779176
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AFF282320
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244029DF9;
	Fri, 11 Aug 2023 14:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0363B1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:10:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DFE65;
	Fri, 11 Aug 2023 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691763053; x=1723299053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=45vu1KVZaynLGE6xff8pnvoLx5zLr5L6i5XJfOncpok=;
  b=b+7nVCaTh8KDYiURxYgxKEKavZcL5BSEli5poPI1Y1e8CsrlskwFHjr4
   dlMThSyPS43KSrkZGRUeTg5djWFtWIOu4+rn9e4+fD6j7eb5uDJCeB2q1
   jAwRoaMBMXP9JQ6ukqqiJWcsMSW/H8mcAB15G6yaXlZfoZpaVa4ys8euK
   A3mzA53hdBqdP6PG9dic/u+qLu3JlMMmZPdYeL1jjjGLqNGzZFIzN7bEl
   m3IKSpZnwLkyN+rdmN4fITc4BgRDgEpW4RQhl5GFdzinTGefIW06ZtxZd
   ELEkAJ0A8rwvzY+Ce71842zTejN6Ix7XiiUtYoLvlTg5cOX4S8fHsqAxH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351285903"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351285903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="856316188"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="856316188"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2023 07:10:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qUSqg-0007pG-2f;
	Fri, 11 Aug 2023 14:10:42 +0000
Date: Fri, 11 Aug 2023 22:10:04 +0800
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308112122.OuF0YZqL-lkp@intel.com>
References: <20230811120814.169952-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811120814.169952-2-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Przemek,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6a1ed1430daa2ccf8ac457e0db93fb0925b801ca]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/overflow-add-DEFINE_FLEX-for-on-stack-allocs/20230811-201509
base:   6a1ed1430daa2ccf8ac457e0db93fb0925b801ca
patch link:    https://lore.kernel.org/r/20230811120814.169952-2-przemyslaw.kitszel%40intel.com
patch subject: [PATCH net-next v2 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
config: m68k-randconfig-r024-20230811 (https://download.01.org/0day-ci/archive/20230811/202308112122.OuF0YZqL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112122.OuF0YZqL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308112122.OuF0YZqL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/compiler.h:5,
                    from include/linux/export.h:5,
                    from include/asm-generic/export.h:9,
                    from ./arch/m68k/include/generated/asm/export.h:1,
                    from arch/m68k/lib/mulsi3.S:35:
>> include/linux/compiler_types.h:331:5: warning: "__has_builtin" is not defined, evaluates to 0 [-Wundef]
     331 | #if __has_builtin(__builtin_dynamic_object_size)
         |     ^~~~~~~~~~~~~
>> include/linux/compiler_types.h:331:18: error: missing binary operator before token "("
     331 | #if __has_builtin(__builtin_dynamic_object_size)
         |                  ^


vim +331 include/linux/compiler_types.h

   326	
   327	/*
   328	 * When the size of an allocated object is needed, use the best available
   329	 * mechanism to find it. (For cases where sizeof() cannot be used.)
   330	 */
 > 331	#if __has_builtin(__builtin_dynamic_object_size)
   332	#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
   333	#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
   334	#else
   335	#define __struct_size(p)	__builtin_object_size(p, 0)
   336	#define __member_size(p)	__builtin_object_size(p, 1)
   337	#endif
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

