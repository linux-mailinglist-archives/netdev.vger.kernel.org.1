Return-Path: <netdev+bounces-158065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76537A1053E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C861618C4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E530229623;
	Tue, 14 Jan 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agEV5Td9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151F20F972
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853821; cv=none; b=WKyLGZ9EOHHgPxgKfKIP2YrMV3CzonaiF6vR5IFui7PHFSXtBHTCdZA0aiJPEk8ho0OdKYe9mygzFJoo7PfpKVeIYT4rFVYxXfT5mpWm9OXdtNN2GcytWwfv+A4vU0POdwWr0uUeUN5CLZXhV9n7hb0/pC1NetHrDNzduoycla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853821; c=relaxed/simple;
	bh=AMgHmuYLU3sfm4NIVKVeA2B4Vt/7KevOgpIWmmuPztc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlbgA2Uc2UrGxBXmaZKDH93kNZ5lGiYp0NB90nuDN+6H/bO7euzFSqOr+hfo33Po+dfqwwVddTzpf7EgFKAP3/gTD1RmuY4O9pac3MiQnLep1aaHIhHLAKpE1w4dZZ6ly4odbmh3+61EcyjB5bOdUmUjREZt/72KxgwFpCarGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agEV5Td9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736853820; x=1768389820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMgHmuYLU3sfm4NIVKVeA2B4Vt/7KevOgpIWmmuPztc=;
  b=agEV5Td9kNKYBQPQnGQyPfPFcn/lgP86PIk6hHnqZksJGz6URg5HitF6
   EwvGnRFYEw5xKDyOIXkErVYWSIzZuo7bVK8zs4xTd6JrGzJdOQ6PX+7m6
   bWkEjW3MTLk+BlwLFwItGSWV1/gqbmqls7NiQtJRtJ8sFjMoYZ0stpb/O
   mW6ApndhoU36H5ZjvnqtP48ketnkfcGLGMNrwUYnA2jVkhUS/4214mO82
   ilPai2l+D0u6opcX9XWZn6XVIHBkkQW1Ig88ciGcBj84LtdJhOK7m0OKt
   n8DSTLWFlCEUEl0LJ/IxfJHW+FWIalqa+I6RRP7Wvj1XXkAC5PkC+9oRT
   A==;
X-CSE-ConnectionGUID: Fwr3NspbT4W85kCRg015gQ==
X-CSE-MsgGUID: PfHgbiFXQaKTQvOnRr01EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="62514159"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="62514159"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 03:23:39 -0800
X-CSE-ConnectionGUID: 5REfNi11RhagbA71HCmRew==
X-CSE-MsgGUID: VPw9X9xtQW6V2sZfI77D5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="109761414"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Jan 2025 03:23:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXf1B-000OSh-0t;
	Tue, 14 Jan 2025 11:23:33 +0000
Date: Tue, 14 Jan 2025 19:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx
 rings
Message-ID: <202501141828.3alxlzbA-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250114/202501141828.3alxlzbA-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250114/202501141828.3alxlzbA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501141828.3alxlzbA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt.c:11:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:15794:18: error: use of undeclared identifier 'cpr'
    15794 |         bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
          |                         ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:15794:30: error: use of undeclared identifier 'cpr'
    15794 |         bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
          |                                     ^
   3 warnings and 2 errors generated.


vim +/cpr +15794 drivers/net/ethernet/broadcom/bnxt/bnxt.c

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

