Return-Path: <netdev+bounces-159389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56850A15650
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978D5188DED9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A61A4F09;
	Fri, 17 Jan 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6Q2j37q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCD1A2642
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137305; cv=none; b=ScItX9jgbV6X/ewhJoQrcYgAISXDLiwxPEffY5pO+VG3MuBVyEiqlBvFiZpSGlB8N5kfsuelTfuT1LiyRYjvMDthS6UdUBHgCkzfI97HioUuOpIsxFWbbBJFiYlgs/uPNBqctBg+qGDDCsPCzaVjqVxbw/RCXfYn4v8AKAT6wWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137305; c=relaxed/simple;
	bh=Y4YWV1CT+hDz1TP5htXiTZnj5qNptC1nzOOJ5dGxE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTwnMB3UaBSKYYM8MoYHlj9vXtPxcTtvNd86OLQUP3cmiKgL78uZlq6p8R7kMT9K3wynIwPXagh9JI6qbvMtIkUpTiyIXnEOp5gALB7YiKczgoulK3bHNJDauy/radZ5qzUq/8qfV12TGi2GUI5mte7YQngmqtM6abALyeYw41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6Q2j37q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737137303; x=1768673303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4YWV1CT+hDz1TP5htXiTZnj5qNptC1nzOOJ5dGxE+I=;
  b=S6Q2j37qBefbmeyAfco7SEEwZ6ypD4+zK4LpFG1t8dz6tsxqWSD4EMUZ
   kNGq3Lh+R2l7qdJaPswu46RnfxF9dIhY1ZPwR6lXwMfQNIlqa1D7rNToo
   rwvxMC/MCEaZbPjJAd0qxVRMD/BJbqywhXw1jdjQEc9KN4LirF7069Sw/
   TKPuC7AigM5KzSgSHIsaefeGbbit+QqHSeSums0KOwG+UPlv9RWNyfGas
   SXFfJE7qhUiG2NaDRw3Uw2DsmmEGLVg1a/VeB/Ns0g9CgOBKEUK399D8q
   lmpF0TIzrXI3HcVrsF+9EU+Hky7ug5sKqvL63+0OIJz+Sj/YXLYqzQ2KL
   Q==;
X-CSE-ConnectionGUID: k99dTwGxRRmcP9ZLqZmf8w==
X-CSE-MsgGUID: JpfpQexRSLq4zOIAx+FA/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41344728"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="41344728"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:08:20 -0800
X-CSE-ConnectionGUID: VaL0eCJUSA+R5H2pzJFeSg==
X-CSE-MsgGUID: KROQNmgrRGalH8d9q2wacA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105710223"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Jan 2025 10:08:17 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYqlS-000TYJ-1n;
	Fri, 17 Jan 2025 18:08:14 +0000
Date: Sat, 18 Jan 2025 02:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org, Somnath Kotur <somnath.kotur@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for
 TX rings
Message-ID: <202501180109.z7pduJQw-lkp@intel.com>
References: <20250116192343.34535-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116192343.34535-10-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-Set-NAPR-1-2-support-when-registering-with-firmware/20250117-032822
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250116192343.34535-10-michael.chan%40broadcom.com
patch subject: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for TX rings
config: i386-randconfig-012-20250117 (https://download.01.org/0day-ci/archive/20250118/202501180109.z7pduJQw-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501180109.z7pduJQw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501180109.z7pduJQw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:15725:2: warning: variable 'cpr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    15725 |         if (rc)
          |         ^~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15769:22: note: uninitialized use occurs here
    15769 |         bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
          |                             ^~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15725:2: note: remove the 'if' if its condition is always false
    15725 |         if (rc)
          |         ^~~~~~~
    15726 |                 goto err_reset_rx;
          |                 ~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15721:2: warning: variable 'cpr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    15721 |         if (rc)
          |         ^~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15769:22: note: uninitialized use occurs here
    15769 |         bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
          |                             ^~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15721:2: note: remove the 'if' if its condition is always false
    15721 |         if (rc)
          |         ^~~~~~~
    15722 |                 goto err_reset_rx;
          |                 ~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15717:2: warning: variable 'cpr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    15717 |         if (rc)
          |         ^~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15769:22: note: uninitialized use occurs here
    15769 |         bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
          |                             ^~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15717:2: note: remove the 'if' if its condition is always false
    15717 |         if (rc)
          |         ^~~~~~~
    15718 |                 goto err_reset_rx;
          |                 ~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15695:31: note: initialize the variable 'cpr' to silence this warning
    15695 |         struct bnxt_cp_ring_info *cpr;
          |                                      ^
          |                                       = NULL
   3 warnings generated.


vim +15725 drivers/net/ethernet/broadcom/bnxt/bnxt.c

2d694c27d32efc David Wei     2024-06-18  15690  
2d694c27d32efc David Wei     2024-06-18  15691  static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
2d694c27d32efc David Wei     2024-06-18  15692  {
2d694c27d32efc David Wei     2024-06-18  15693  	struct bnxt *bp = netdev_priv(dev);
2d694c27d32efc David Wei     2024-06-18  15694  	struct bnxt_rx_ring_info *rxr, *clone;
2d694c27d32efc David Wei     2024-06-18  15695  	struct bnxt_cp_ring_info *cpr;
b9d2956e869c78 David Wei     2024-08-07  15696  	struct bnxt_vnic_info *vnic;
5d2310614bc883 Somnath Kotur 2025-01-16  15697  	struct bnxt_napi *bnapi;
b9d2956e869c78 David Wei     2024-08-07  15698  	int i, rc;
2d694c27d32efc David Wei     2024-06-18  15699  
2d694c27d32efc David Wei     2024-06-18  15700  	rxr = &bp->rx_ring[idx];
2d694c27d32efc David Wei     2024-06-18  15701  	clone = qmem;
2d694c27d32efc David Wei     2024-06-18  15702  
2d694c27d32efc David Wei     2024-06-18  15703  	rxr->rx_prod = clone->rx_prod;
2d694c27d32efc David Wei     2024-06-18  15704  	rxr->rx_agg_prod = clone->rx_agg_prod;
2d694c27d32efc David Wei     2024-06-18  15705  	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
2d694c27d32efc David Wei     2024-06-18  15706  	rxr->rx_next_cons = clone->rx_next_cons;
bd649c5cc95816 David Wei     2024-12-03  15707  	rxr->rx_tpa = clone->rx_tpa;
bd649c5cc95816 David Wei     2024-12-03  15708  	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;
2d694c27d32efc David Wei     2024-06-18  15709  	rxr->page_pool = clone->page_pool;
bd649c5cc95816 David Wei     2024-12-03  15710  	rxr->head_pool = clone->head_pool;
b537633ce57b29 Taehee Yoo    2024-07-21  15711  	rxr->xdp_rxq = clone->xdp_rxq;
2d694c27d32efc David Wei     2024-06-18  15712  
2d694c27d32efc David Wei     2024-06-18  15713  	bnxt_copy_rx_ring(bp, rxr, clone);
2d694c27d32efc David Wei     2024-06-18  15714  
5d2310614bc883 Somnath Kotur 2025-01-16  15715  	bnapi = rxr->bnapi;
2d694c27d32efc David Wei     2024-06-18  15716  	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
2d694c27d32efc David Wei     2024-06-18  15717  	if (rc)
5d2310614bc883 Somnath Kotur 2025-01-16  15718  		goto err_reset_rx;
377e78a9e08ce5 Somnath Kotur 2025-01-16  15719  
377e78a9e08ce5 Somnath Kotur 2025-01-16  15720  	rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
2d694c27d32efc David Wei     2024-06-18  15721  	if (rc)
5d2310614bc883 Somnath Kotur 2025-01-16  15722  		goto err_reset_rx;
2d694c27d32efc David Wei     2024-06-18  15723  
377e78a9e08ce5 Somnath Kotur 2025-01-16  15724  	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
377e78a9e08ce5 Somnath Kotur 2025-01-16 @15725  	if (rc)
5d2310614bc883 Somnath Kotur 2025-01-16  15726  		goto err_reset_rx;
377e78a9e08ce5 Somnath Kotur 2025-01-16  15727  
2d694c27d32efc David Wei     2024-06-18  15728  	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
2d694c27d32efc David Wei     2024-06-18  15729  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
2d694c27d32efc David Wei     2024-06-18  15730  		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
2d694c27d32efc David Wei     2024-06-18  15731  
5d2310614bc883 Somnath Kotur 2025-01-16  15732  	cpr = &bnapi->cp_ring;
2d694c27d32efc David Wei     2024-06-18  15733  	cpr->sw_stats->rx.rx_resets++;
2d694c27d32efc David Wei     2024-06-18  15734  
5d2310614bc883 Somnath Kotur 2025-01-16  15735  	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
5d2310614bc883 Somnath Kotur 2025-01-16  15736  		cpr->sw_stats->tx.tx_resets++;
5d2310614bc883 Somnath Kotur 2025-01-16  15737  		rc = bnxt_tx_queue_start(bp, idx);
5d2310614bc883 Somnath Kotur 2025-01-16  15738  		if (rc) {
5d2310614bc883 Somnath Kotur 2025-01-16  15739  			netdev_warn(bp->dev,
5d2310614bc883 Somnath Kotur 2025-01-16  15740  				    "tx queue restart failed: rc=%d\n", rc);
5d2310614bc883 Somnath Kotur 2025-01-16  15741  			bnapi->tx_fault = 1;
5d2310614bc883 Somnath Kotur 2025-01-16  15742  			goto err_reset;
5d2310614bc883 Somnath Kotur 2025-01-16  15743  		}
5d2310614bc883 Somnath Kotur 2025-01-16  15744  	}
5d2310614bc883 Somnath Kotur 2025-01-16  15745  
5d2310614bc883 Somnath Kotur 2025-01-16  15746  	napi_enable(&bnapi->napi);
5d2310614bc883 Somnath Kotur 2025-01-16  15747  	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
5d2310614bc883 Somnath Kotur 2025-01-16  15748  
b9d2956e869c78 David Wei     2024-08-07  15749  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
b9d2956e869c78 David Wei     2024-08-07  15750  		vnic = &bp->vnic_info[i];
5ac066b7b062ee Somnath Kotur 2024-11-22  15751  
5ac066b7b062ee Somnath Kotur 2024-11-22  15752  		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
5ac066b7b062ee Somnath Kotur 2024-11-22  15753  		if (rc) {
5ac066b7b062ee Somnath Kotur 2024-11-22  15754  			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
5ac066b7b062ee Somnath Kotur 2024-11-22  15755  				   vnic->vnic_id, rc);
5ac066b7b062ee Somnath Kotur 2024-11-22  15756  			return rc;
5ac066b7b062ee Somnath Kotur 2024-11-22  15757  		}
b9d2956e869c78 David Wei     2024-08-07  15758  		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
b9d2956e869c78 David Wei     2024-08-07  15759  		bnxt_hwrm_vnic_update(bp, vnic,
b9d2956e869c78 David Wei     2024-08-07  15760  				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
b9d2956e869c78 David Wei     2024-08-07  15761  	}
b9d2956e869c78 David Wei     2024-08-07  15762  
2d694c27d32efc David Wei     2024-06-18  15763  	return 0;
2d694c27d32efc David Wei     2024-06-18  15764  
5d2310614bc883 Somnath Kotur 2025-01-16  15765  err_reset_rx:
5d2310614bc883 Somnath Kotur 2025-01-16  15766  	rxr->bnapi->in_reset = true;
5d2310614bc883 Somnath Kotur 2025-01-16  15767  err_reset:
5d2310614bc883 Somnath Kotur 2025-01-16  15768  	napi_enable(&bnapi->napi);
5d2310614bc883 Somnath Kotur 2025-01-16  15769  	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
5d2310614bc883 Somnath Kotur 2025-01-16  15770  	bnxt_reset_task(bp, true);
2d694c27d32efc David Wei     2024-06-18  15771  	return rc;
2d694c27d32efc David Wei     2024-06-18  15772  }
2d694c27d32efc David Wei     2024-06-18  15773  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

