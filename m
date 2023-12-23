Return-Path: <netdev+bounces-60060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889481D2AF
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 07:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182781F23289
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB753A6;
	Sat, 23 Dec 2023 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwIM5UA+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738556AB6
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703312624; x=1734848624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BmsPPm3X9FukrKuoK8rzzxZ/RObXZnA0uGPF96SNcDw=;
  b=GwIM5UA+yveVtXtxuJi0mmx7hllH0FIe9OaAyx1aAN5Lij89TuPFcrm0
   FAon2qZ4IWN7HWakm351TqpauCdzZ874pF610B7Z7jCe7uXeOrNaWApQo
   SZJxDI84WAz+YdJqIZWK84C9+RfANJEOitZwSxt2c1coQOzAOpTVDuQyQ
   Ztpbo5g6Y/KmtV0lmhsyJqJQgxP3vxja9oNEj6DDLBolJwosO6IlLHrmJ
   NRAtqdkPdgUXToHI+r56ZPIItbpNl1xhQzcrWbniuHO0GyDO8yK5CzdRK
   2Tex5qx10M0VHoJPC+VGzVlaaxk/AmkCCk+V2KqjfEfu8JrGJ2XBolGB0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="381166661"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="381166661"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 22:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="780808569"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="780808569"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2023 22:23:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGvQ3-000ANF-15;
	Sat, 23 Dec 2023 06:23:37 +0000
Date: Sat, 23 Dec 2023 14:22:58 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 04/13] bnxt_en: Refactor L2 filter alloc/free
 firmware commands.
Message-ID: <202312231448.DVjORC4c-lkp@intel.com>
References: <20231221220218.197386-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221220218.197386-5-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-Refactor-bnxt_ntuple_filter-structure/20231222-174043
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231221220218.197386-5-michael.chan%40broadcom.com
patch subject: [PATCH net-next 04/13] bnxt_en: Refactor L2 filter alloc/free firmware commands.
config: powerpc-randconfig-001-20231223 (https://download.01.org/0day-ci/archive/20231223/202312231448.DVjORC4c-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231448.DVjORC4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231448.DVjORC4c-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:5443:35: error: subscript of pointer to incomplete type 'struct bnxt_vf_info'
           struct bnxt_vf_info *vf = &pf->vf[vf_idx];
                                      ~~~~~~^
   drivers/net/ethernet/broadcom/bnxt/bnxt.h:1332:9: note: forward declaration of 'struct bnxt_vf_info'
           struct bnxt_vf_info     *vf;
                  ^
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:5445:11: error: incomplete definition of type 'struct bnxt_vf_info'
           return vf->fw_fid;
                  ~~^
   drivers/net/ethernet/broadcom/bnxt/bnxt.h:1332:9: note: forward declaration of 'struct bnxt_vf_info'
           struct bnxt_vf_info     *vf;
                  ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:13583:44: warning: shift count >= width of type [-Wshift-count-overflow]
           if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0 &&
                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 2 errors generated.


vim +5443 drivers/net/ethernet/broadcom/bnxt/bnxt.c

  5440	
  5441	static u16 bnxt_vf_target_id(struct bnxt_pf_info *pf, u16 vf_idx)
  5442	{
> 5443		struct bnxt_vf_info *vf = &pf->vf[vf_idx];
  5444	
> 5445		return vf->fw_fid;
  5446	}
  5447	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

