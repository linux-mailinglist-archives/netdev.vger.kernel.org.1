Return-Path: <netdev+bounces-200049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD6AE2E68
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 07:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E83AAE24
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D2187554;
	Sun, 22 Jun 2025 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9xjJ8yS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E835977;
	Sun, 22 Jun 2025 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750569733; cv=none; b=DEm/lk5/YI1TP9wecbjg+cPTV24EitR4cL47hy3WDEMe9mQ8aSOd8W9dlgIooH4cQneYcBdF4pK/G830aN/kYK+roAxAO9a+HPIqtqW5gqacv1cdRmic4dNF/ar3TQF5RHKR+a4ru26vMD7Z+vL2sthi5lPTeRzqmct2KRgUX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750569733; c=relaxed/simple;
	bh=UBLrFt7v6rwi8efRCPk1D6EtbCWUH8sLO9gY/AVK1Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOLpFE/c+TNGV35XMX2qavJCGaFvIN9ki8KiVRxG+Nf3BGRbLv6AaKZjPvvgeAoizPeji7yiu6p13edpoNzvsCL+ZbwNtWlwPjh8sHm7u6EKoejEbZiVw1H0ligHIhXntNH+bDvt9fJwLzhlEUxsg3z/A3QXxB+7TK2CYd8+X9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9xjJ8yS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750569731; x=1782105731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBLrFt7v6rwi8efRCPk1D6EtbCWUH8sLO9gY/AVK1Eg=;
  b=B9xjJ8ySofsWBj7DHQC7G8ILGwdweoyusHcZcjelKWcOoxWIEeLVBAkw
   cYeX3naPZRHpQNlbHyN30cY6oKbDFwO1OoRkebMeWd8D7WSEoatSi23Ts
   si5e1CICbI3lXZjF2y3rtaNtu6VgD/RKGusbwYijpaK7vXI6VVQyS6euI
   Ck03oNnUMljceqvjuGR4WN+EFHx83kwzhcsxbnu0f63F5f7wr3skJdnFu
   KOnuaiHJYVG0x/i8gSyiHveyN7TUSVkIOSx7ekEp8HGe0L3xc656cDKNu
   803+3fjQJ2bdi6J/1tYKwukt7sbtT262Tz3Qv8J3OHJeDvee9Mi3iydrK
   g==;
X-CSE-ConnectionGUID: EOOXUidtTfOFgm1+MPQMaA==
X-CSE-MsgGUID: +ejr6KS4Qt6MSgOGVBRYxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="56594005"
X-IronPort-AV: E=Sophos;i="6.16,255,1744095600"; 
   d="scan'208";a="56594005"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 22:22:10 -0700
X-CSE-ConnectionGUID: h6O+MLvKRnKLdddP+O4p0g==
X-CSE-MsgGUID: uZbDNinNQZ641LBmvKwqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,255,1744095600"; 
   d="scan'208";a="155291212"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jun 2025 22:22:07 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTD9Z-000N4Y-0s;
	Sun, 22 Jun 2025 05:22:05 +0000
Date: Sun, 22 Jun 2025 13:21:07 +0800
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
Message-ID: <202506221311.dmMiJyFp-lkp@intel.com>
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
[also build test WARNING on v6.16-rc2 next-20250620]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-9-vikas.gupta%40broadcom.com
patch subject: [net-next, 08/10] bng_en: Add irq allocation support
config: parisc-randconfig-r073-20250619 (https://download.01.org/0day-ci/archive/20250622/202506221311.dmMiJyFp-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506221311.dmMiJyFp-lkp@intel.com/

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

