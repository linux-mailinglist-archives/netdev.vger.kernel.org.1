Return-Path: <netdev+bounces-55004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C480925F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9BA1F21244
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83554F99;
	Thu,  7 Dec 2023 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXQu7Z5d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99675171B
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701981236; x=1733517236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qeIs2qDeHg1aj22+/59U1MW6QQTz1D5Le0uCHUaQkgk=;
  b=RXQu7Z5dpN4bibQD8aa96hHG5Ezc60mOBcFaMrUtCXO/+2KRerwGxIEw
   BfYCpi/v9jtrnzvJc/8Y5WobzDPTlQDyLBkasoL6z2SmByfsbVBsCCQYL
   FPcnyqxHIVwNhOt8E/1h0G1V4YQWrVFEw9knxzB2R5JNlWjwreeUMBsnM
   iPNOoRDJvj82mBxguRcKkdjt4KjK1OjXlmE9p2qIKTXpzyebP0mZBw25L
   MrtImk7Nah94WK3SWt7j6+vMrSnpVpo+O/rAsCe8cNjyCkdtj6XLIBFsl
   ndlGViiRniQ+oUUhtaWpsf2yoyl7Dj/3SP33UnoO9syX1Aeb8+rbClu4l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1410460"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1410460"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 12:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="771876786"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="771876786"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2023 12:33:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBL4B-000CnZ-1O;
	Thu, 07 Dec 2023 20:33:51 +0000
Date: Fri, 8 Dec 2023 04:33:31 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Staikov <andrii.staikov@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev,
	Drewek Wojciech <wojciech.drewek@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>, netdev@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Kitszel Przemyslaw <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] i40e: Restore VF MSI-X
 state during PCI reset
Message-ID: <202312080413.jtUlijX8-lkp@intel.com>
References: <20231206125127.218350-1-andrii.staikov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206125127.218350-1-andrii.staikov@intel.com>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Staikov/i40e-Restore-VF-MSI-X-state-during-PCI-reset/20231206-205526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20231206125127.218350-1-andrii.staikov%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-net v3] i40e: Restore VF MSI-X state during PCI reset
config: powerpc-ppc64_defconfig (https://download.01.org/0day-ci/archive/20231208/202312080413.jtUlijX8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080413.jtUlijX8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080413.jtUlijX8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_restore_all_vfs_msi_state':
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:175:58: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
     175 |                         if (vf_dev->is_virtfn && vf_dev->physfn == pdev)
         |                                                          ^~~~~~
         |                                                          is_physfn


vim +175 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

   156	
   157	void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
   158	{
   159		u16 vf_id;
   160		u16 pos;
   161	
   162		/* Continue only if this is a PF */
   163		if (!pdev->is_physfn)
   164			return;
   165	
   166		if (!pci_num_vf(pdev))
   167			return;
   168	
   169		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
   170		if (pos) {
   171			struct pci_dev *vf_dev = NULL;
   172	
   173			pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
   174			while ((vf_dev = pci_get_device(pdev->vendor, vf_id, vf_dev))) {
 > 175				if (vf_dev->is_virtfn && vf_dev->physfn == pdev)
   176					pci_restore_msi_state(vf_dev);
   177			}
   178		}
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

