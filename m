Return-Path: <netdev+bounces-60070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247381D425
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C5BFB215BC
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40AD2F2;
	Sat, 23 Dec 2023 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsOfF3qK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D7D2E4
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703336898; x=1734872898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MpQqVfyCGYPIBmeczRWmjfwjXI8tjDbCoscWLJwemlo=;
  b=nsOfF3qKkjUoo/ANKL+imw4TB8MqFKv+tqeMAK2cgh9QOGdqguUxICB5
   VBGJvv7KvRQZBVBM6VyoG0WKf8jLa3golX7w7fJQPDcs95c6xuZmALkSG
   Ehfz3Eo8yGc+X3Hy8O4XqYEi2hMEYCbibKKJrmP1eW8MHIWKEXtrmi9sW
   qQpKa02NAAeWo2jPmxT9gmhEpCBxJTDqvsN7OsaEtr4yvOtOf3ADCUTms
   5n8dRz6Ss3CcaZbzvfZHVQpV3PDdsHfZqxEkUDd+FsCLW+Ya+/ccYcT0g
   52TYNHOYCv5WUrX9ZdIwNZ37EHohVgRTf1flDc3eVCJI4DQe5uIkoGLdz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="427360766"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="427360766"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 05:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="867979835"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="867979835"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2023 05:08:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH1it-000B3h-1s;
	Sat, 23 Dec 2023 13:07:37 +0000
Date: Sat, 23 Dec 2023 21:07:20 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 08/13] bnxt_en: Refactor filter insertion logic
 in bnxt_rx_flow_steer().
Message-ID: <202312232032.AGxw3c0P-lkp@intel.com>
References: <20231221220218.197386-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221220218.197386-9-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-Refactor-bnxt_ntuple_filter-structure/20231222-174043
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231221220218.197386-9-michael.chan%40broadcom.com
patch subject: [PATCH net-next 08/13] bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().
config: powerpc-randconfig-001-20231223 (https://download.01.org/0day-ci/archive/20231223/202312232032.AGxw3c0P-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312232032.AGxw3c0P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312232032.AGxw3c0P-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5524:35: error: subscript of pointer to incomplete type 'struct bnxt_vf_info'
           struct bnxt_vf_info *vf = &pf->vf[vf_idx];
                                      ~~~~~~^
   drivers/net/ethernet/broadcom/bnxt/bnxt.h:1332:9: note: forward declaration of 'struct bnxt_vf_info'
           struct bnxt_vf_info     *vf;
                  ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5526:11: error: incomplete definition of type 'struct bnxt_vf_info'
           return vf->fw_fid;
                  ~~^
   drivers/net/ethernet/broadcom/bnxt/bnxt.h:1332:9: note: forward declaration of 'struct bnxt_vf_info'
           struct bnxt_vf_info     *vf;
                  ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:13652:44: warning: shift count >= width of type [-Wshift-count-overflow]
           if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0 &&
                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:14024:9: error: implicit declaration of function 'rps_may_expire_flow' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                   if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
                                       ^
   1 warning and 3 errors generated.


vim +/rps_may_expire_flow +14024 drivers/net/ethernet/broadcom/bnxt/bnxt.c

c0c050c58d8409 Michael Chan   2015-10-22  14008  
c0c050c58d8409 Michael Chan   2015-10-22  14009  static void bnxt_cfg_ntp_filters(struct bnxt *bp)
c0c050c58d8409 Michael Chan   2015-10-22  14010  {
c0c050c58d8409 Michael Chan   2015-10-22  14011  	int i;
c0c050c58d8409 Michael Chan   2015-10-22  14012  
c0c050c58d8409 Michael Chan   2015-10-22  14013  	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++) {
c0c050c58d8409 Michael Chan   2015-10-22  14014  		struct hlist_head *head;
c0c050c58d8409 Michael Chan   2015-10-22  14015  		struct hlist_node *tmp;
c0c050c58d8409 Michael Chan   2015-10-22  14016  		struct bnxt_ntuple_filter *fltr;
c0c050c58d8409 Michael Chan   2015-10-22  14017  		int rc;
c0c050c58d8409 Michael Chan   2015-10-22  14018  
c0c050c58d8409 Michael Chan   2015-10-22  14019  		head = &bp->ntp_fltr_hash_tbl[i];
25f995fba56014 Michael Chan   2023-12-21  14020  		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
c0c050c58d8409 Michael Chan   2015-10-22  14021  			bool del = false;
c0c050c58d8409 Michael Chan   2015-10-22  14022  
25f995fba56014 Michael Chan   2023-12-21  14023  			if (test_bit(BNXT_FLTR_VALID, &fltr->base.state)) {
25f995fba56014 Michael Chan   2023-12-21 @14024  				if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
c0c050c58d8409 Michael Chan   2015-10-22  14025  							fltr->flow_id,
25f995fba56014 Michael Chan   2023-12-21  14026  							fltr->base.sw_id)) {
c0c050c58d8409 Michael Chan   2015-10-22  14027  					bnxt_hwrm_cfa_ntuple_filter_free(bp,
c0c050c58d8409 Michael Chan   2015-10-22  14028  									 fltr);
c0c050c58d8409 Michael Chan   2015-10-22  14029  					del = true;
c0c050c58d8409 Michael Chan   2015-10-22  14030  				}
c0c050c58d8409 Michael Chan   2015-10-22  14031  			} else {
c0c050c58d8409 Michael Chan   2015-10-22  14032  				rc = bnxt_hwrm_cfa_ntuple_filter_alloc(bp,
c0c050c58d8409 Michael Chan   2015-10-22  14033  								       fltr);
c0c050c58d8409 Michael Chan   2015-10-22  14034  				if (rc)
c0c050c58d8409 Michael Chan   2015-10-22  14035  					del = true;
c0c050c58d8409 Michael Chan   2015-10-22  14036  				else
25f995fba56014 Michael Chan   2023-12-21  14037  					set_bit(BNXT_FLTR_VALID, &fltr->base.state);
c0c050c58d8409 Michael Chan   2015-10-22  14038  			}
c0c050c58d8409 Michael Chan   2015-10-22  14039  
c0c050c58d8409 Michael Chan   2015-10-22  14040  			if (del) {
c0c050c58d8409 Michael Chan   2015-10-22  14041  				spin_lock_bh(&bp->ntp_fltr_lock);
86982cc60c9a86 Michael Chan   2023-12-21  14042  				if (!test_and_clear_bit(BNXT_FLTR_INSERTED, &fltr->base.state)) {
86982cc60c9a86 Michael Chan   2023-12-21  14043  					spin_unlock_bh(&bp->ntp_fltr_lock);
86982cc60c9a86 Michael Chan   2023-12-21  14044  					continue;
86982cc60c9a86 Michael Chan   2023-12-21  14045  				}
25f995fba56014 Michael Chan   2023-12-21  14046  				hlist_del_rcu(&fltr->base.hash);
c0c050c58d8409 Michael Chan   2015-10-22  14047  				bp->ntp_fltr_count--;
c0c050c58d8409 Michael Chan   2015-10-22  14048  				spin_unlock_bh(&bp->ntp_fltr_lock);
9fa270ccc095df Michael Chan   2023-12-21  14049  				bnxt_del_l2_filter(bp, fltr->l2_fltr);
c0c050c58d8409 Michael Chan   2015-10-22  14050  				synchronize_rcu();
25f995fba56014 Michael Chan   2023-12-21  14051  				clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
c0c050c58d8409 Michael Chan   2015-10-22  14052  				kfree(fltr);
c0c050c58d8409 Michael Chan   2015-10-22  14053  			}
c0c050c58d8409 Michael Chan   2015-10-22  14054  		}
c0c050c58d8409 Michael Chan   2015-10-22  14055  	}
19241368443ff9 Jeffrey Huang  2016-02-26  14056  	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
9a005c3898aa07 Jonathan Lemon 2020-02-24  14057  		netdev_info(bp->dev, "Receive PF driver unload event!\n");
c0c050c58d8409 Michael Chan   2015-10-22  14058  }
c0c050c58d8409 Michael Chan   2015-10-22  14059  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

