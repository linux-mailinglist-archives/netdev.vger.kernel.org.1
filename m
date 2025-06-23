Return-Path: <netdev+bounces-200141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B689AE3578
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CDA3B1B00
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23361DED69;
	Mon, 23 Jun 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKFA4cH3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580E1DDA34;
	Mon, 23 Jun 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659150; cv=none; b=hFTkBXQwZ82kKS96gbDdg91tS/00Jc55huCkC107lwGCVlA9yHP5A/84niXBNfrNHLsCh1mDQdmtLgvKbZzvmHXkLomgXvezpv0Ut3rRqhb0m2E+qBD64US8M0QxL/l6SFCFP1b2KXIkiSA1LW+rNN+c+vvUWGTBy4b624zGZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659150; c=relaxed/simple;
	bh=+iqwTycSqAFYopUgmCTHfc/8F5IbMLjMRL9eqYGCO84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOOm3QvgoJsKmoqwzPPfWhat/x2pwb9edEMEOSCQYJmduLIyRzoZGPPD7G+IoIOsm37/NoJpBZPtVvFDy7PZWtL77Xb/51R9bhjTMx+d5qw6pA/v28Sj/O3lTtbgeFfhbywoie2isofKVGP0floHQUHsecKNWHdcgWffvUJoTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKFA4cH3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750659149; x=1782195149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+iqwTycSqAFYopUgmCTHfc/8F5IbMLjMRL9eqYGCO84=;
  b=GKFA4cH37104mrVc+MTkpD1pCSAsUV2U9xCgwFilNMqYoNHgmHS1TuhT
   cVH5ANV/k+a374OmXjvZcWdrJ6UHik6E4wndQb0fxtNvk6UlCTuXoR0u9
   hpR2jabtage9vAxl99HEv5wb5irHIZI1GUXVfhRS9DuvQP9j5MlZZJrKN
   2/F/vFy73YyhY7YG5ys/eXU1gkPwYzoI6M+0nV3hn1CqGY0phCeQTQK8j
   YUuIpA3xb0Gg3E7sUoRGok5xWYJRaCutXGY/TEZ+ouqWx8aHrLMHBQ5br
   bsCidDk5xWAkjg63TNoTUA4jYaBaASctxjoJAEfgS+7ZDCiwu3mCOiom+
   g==;
X-CSE-ConnectionGUID: rwvyTWovRdGim8vhMkGR4Q==
X-CSE-MsgGUID: UEQ0SaHSTxy44IIZMoVwXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="64283198"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="64283198"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:12:29 -0700
X-CSE-ConnectionGUID: tvFJcUvcTcCYz1YO8usSmg==
X-CSE-MsgGUID: 58XWfdwjQd+hHWq0/m6CSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155806121"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jun 2025 23:12:24 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTaPm-000NkE-0E;
	Mon, 23 Jun 2025 06:12:22 +0000
Date: Mon, 23 Jun 2025 14:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next, 08/10] bng_en: Add irq allocation support
Message-ID: <202506231320.YMpashmK-lkp@intel.com>
References: <20250618144743.843815-9-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618144743.843815-9-vikas.gupta@broadcom.com>

Hi Vikas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250620]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-9-vikas.gupta%40broadcom.com
patch subject: [net-next, 08/10] bng_en: Add irq allocation support
config: parisc-randconfig-r073-20250619 (https://download.01.org/0day-ci/archive/20250623/202506231320.YMpashmK-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506231320.YMpashmK-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/broadcom/bnge/bnge_resc.c:347 bnge_alloc_irqs() warn: unsigned 'irqs_demand' is never less than zero.

vim +/irqs_demand +347 drivers/net/ethernet/broadcom/bnge/bnge_resc.c

   329	
   330	int bnge_alloc_irqs(struct bnge_dev *bd)
   331	{
   332		u16 aux_msix, tx_cp, num_entries;
   333		u16 irqs_demand, max, min = 1;
   334		int i, rc = 0;
   335	
   336		irqs_demand = bnge_nqs_demand(bd);
   337		max = bnge_get_max_func_irqs(bd);
   338		if (irqs_demand > max)
   339			irqs_demand = max;
   340	
   341		if (!(bd->flags & BNGE_EN_SHARED_CHNL))
   342			min = 2;
   343	
   344		irqs_demand = pci_alloc_irq_vectors(bd->pdev, min, irqs_demand,
   345						    PCI_IRQ_MSIX);
   346		aux_msix = bnge_aux_get_msix(bd);
 > 347		if (irqs_demand < 0 || irqs_demand < aux_msix) {
   348			rc = -ENODEV;
   349			goto err_free_irqs;
   350		}
   351	
   352		num_entries = irqs_demand;
   353		if (pci_msix_can_alloc_dyn(bd->pdev))
   354			num_entries = max;
   355		bd->irq_tbl = kcalloc(num_entries, sizeof(*bd->irq_tbl), GFP_KERNEL);
   356		if (!bd->irq_tbl) {
   357			rc = -ENOMEM;
   358			goto err_free_irqs;
   359		}
   360	
   361		for (i = 0; i < irqs_demand; i++)
   362			bd->irq_tbl[i].vector = pci_irq_vector(bd->pdev, i);
   363	
   364		bd->irqs_acquired = irqs_demand;
   365		/* Reduce rings based upon num of vectors allocated.
   366		 * We dont need to consider NQs as they have been calculated
   367		 * and must be more than irqs_demand.
   368		 */
   369		rc = bnge_adjust_rings(bd, &bd->rx_nr_rings,
   370				       &bd->tx_nr_rings,
   371				       irqs_demand - aux_msix, min == 1);
   372		if (rc)
   373			goto err_free_irqs;
   374	
   375		tx_cp = bnge_num_tx_to_cp(bd, bd->tx_nr_rings);
   376		bd->nq_nr_rings = (min == 1) ?
   377			max_t(u16, tx_cp, bd->rx_nr_rings) :
   378			tx_cp + bd->rx_nr_rings;
   379	
   380		/* Readjust tx_nr_rings_per_tc */
   381		if (!bd->num_tc)
   382			bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
   383	
   384		return 0;
   385	
   386	err_free_irqs:
   387		dev_err(bd->dev, "Failed to allocate IRQs err = %d\n", rc);
   388		bnge_free_irqs(bd);
   389		return rc;
   390	}
   391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

