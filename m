Return-Path: <netdev+bounces-158032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3AA10259
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BF718875F2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7146B230998;
	Tue, 14 Jan 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWsp+ADl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A771D5AB2
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844576; cv=none; b=fMmreZ8P6ZoDkhYv/QvMimw9vdJw5cdbzk/bRWoqi3pTow/ovoNKPSWVsNuk81jHwl20kc7DD7c2l7hKQcFNolCB//TjUF7whQbihdi7Lr4O++AQSVFduA9kDMFgyP1Sad9HM9CaejSSP/95NhsMLtgkO7VNCbBtsFT5jn/VPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844576; c=relaxed/simple;
	bh=GNDNG4LZGXG2F7SXMLZAkIUmNzhwX+JXB3xvJNf9DAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0TAZkm45cFoZ1F8YldvQzV6PMU00cbCSzZLXOMRIU/DZY0wbERgeo1b+Q4MvDeayp/Mnif0eWTi4sVrfzthJi7wbACgiuZ8VFPkWqAXOQhvjNdhbSnH/DQbDvP6XL2BJTJoWYs0wSqlcZ1x8yv0u4XjhiNym9Ud9PHl1yPhBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWsp+ADl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736844574; x=1768380574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNDNG4LZGXG2F7SXMLZAkIUmNzhwX+JXB3xvJNf9DAA=;
  b=BWsp+ADl2cXv7yLbVcuhWGnfTpk8fIq7xtaP+lBWY4TCc4ttd663GIU1
   Vf77OAszyOvYT48h/frZ0Z02zufWxFJUZ9B2KgaxeMKyuSSJfzgAhCVHd
   6tG0pvgRViRYLu6QgTrjVGGWJNbtI1zgjjTxk4IZtnhLli1/1CiubIvYa
   WdUdepHeoBP0zGKL8lyPjqlS+KNcqX9PAIh8Eb1ms8Aa+8leS/EldC442
   G0XsukVamJZRS5esTLGjxWPz6QkG7ENahpwEMRFsUN/y1pT2bzcPlijKu
   74CYjqb7fDoQmlkr6Z3zaeGcdc2BCtesj8b/wAyHqH6G7kb3eWYwYx5vN
   g==;
X-CSE-ConnectionGUID: 1c388YAqTzuJLawnqJfGUA==
X-CSE-MsgGUID: TX65MBdgQ5qusUp499uiyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37045331"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="37045331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:49:33 -0800
X-CSE-ConnectionGUID: RjpOrQrsTuKQgGDloNcbDw==
X-CSE-MsgGUID: OPtIqzqNQj2HwbjYUPVFfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127982337"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 00:49:30 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXcc4-000OI7-0s;
	Tue, 14 Jan 2025 08:49:28 +0000
Date: Tue, 14 Jan 2025 16:48:50 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx
 rings
Message-ID: <202501141605.iErAEuFQ-lkp@intel.com>
References: <20250113063927.4017173-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-10-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-Set-NAPR-1-2-support-when-registering-with-firmware/20250113-144205
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250113063927.4017173-10-michael.chan%40broadcom.com
patch subject: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx rings
config: csky-randconfig-001-20250114 (https://download.01.org/0day-ci/archive/20250114/202501141605.iErAEuFQ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250114/202501141605.iErAEuFQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501141605.iErAEuFQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request_irq':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:11360:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
   11360 |         int i, j, rc = 0;
         |                ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_queue_stop':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:15794:25: error: 'cpr' undeclared (first use in this function); did you mean 'cpu'?
   15794 |         bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
         |                         ^~~
         |                         cpu
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15794:25: note: each undeclared identifier is reported only once for each function it appears in


vim +15794 drivers/net/ethernet/broadcom/bnxt/bnxt.c

 15761	
 15762	static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 15763	{
 15764		struct bnxt *bp = netdev_priv(dev);
 15765		struct bnxt_rx_ring_info *rxr;
 15766		struct bnxt_vnic_info *vnic;
 15767		struct bnxt_napi *bnapi;
 15768		int i;
 15769	
 15770		for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
 15771			vnic = &bp->vnic_info[i];
 15772			vnic->mru = 0;
 15773			bnxt_hwrm_vnic_update(bp, vnic,
 15774					      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
 15775		}
 15776		/* Make sure NAPI sees that the VNIC is disabled */
 15777		synchronize_net();
 15778		rxr = &bp->rx_ring[idx];
 15779		bnapi = rxr->bnapi;
 15780		cancel_work_sync(&bnapi->cp_ring.dim.work);
 15781		bnxt_hwrm_rx_ring_free(bp, rxr, false);
 15782		bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 15783		page_pool_disable_direct_recycling(rxr->page_pool);
 15784		if (bnxt_separate_head_pool())
 15785			page_pool_disable_direct_recycling(rxr->head_pool);
 15786	
 15787		if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 15788			bnxt_tx_queue_stop(bp, idx);
 15789	
 15790		napi_disable(&bnapi->napi);
 15791	
 15792		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 15793		bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
 15794		bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 15795	
 15796		memcpy(qmem, rxr, sizeof(*rxr));
 15797		bnxt_init_rx_ring_struct(bp, qmem);
 15798	
 15799		return 0;
 15800	}
 15801	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

