Return-Path: <netdev+bounces-165839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0782A337ED
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8873A6C40
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5202207DE5;
	Thu, 13 Feb 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKnmBs4W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB1207A27;
	Thu, 13 Feb 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428012; cv=none; b=l0Invs58l0MMFRgZ1rObmDFAu8isPhdyw6pHyEdOdori8/AhkpvV0rzdIBnbDYaiEGbjwIkPPkwsZPh1x+J59VSgrquuDC+uNzAAED8hqs0UpmKRRFXCGDiZtCfO1j8rS5pu0OA/J4dNBeofaxTvu0FwA6PqkV9NfOSCfXFX6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428012; c=relaxed/simple;
	bh=mQm/3JCmAFSW/VKjAt7raIjpfolCLORdQ9Y3kbWdC00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb+5E+kHigeNGNxl6IkvgwNDbTeJqU0ea2kUqTJ5Txfp8a6BPXopYQ9sNhdtW7WKrUC19TcLgHFxGaZwc6DSKOy1eaip5zhyc2jOiWHh1vk0607NYCgJgjFkg0Q1fsz/+jN95a1dqzRTU4DmJkP5xmf9I3n/gwVBCa6bPCrPKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKnmBs4W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739428012; x=1770964012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQm/3JCmAFSW/VKjAt7raIjpfolCLORdQ9Y3kbWdC00=;
  b=gKnmBs4Wnhq5j1h23bfkRNynwQnIdaT30LZUbS3xYTZIY4Y7CWcK6Ffb
   Q4DFEzS5MgrJDB1oGJQFz7VeX1V5x2+9tWHx3rGFHv3IvL0mVZu1kpjdc
   GCk5L4fXYTogGgTzZ6ObP8EwxYVAKBJDKMgHcISTIi7TyKoy9nfJ/s8Iv
   zg+aOEsObYmgok78AXr3knKFE8hYj85En4FbBmqh1E/zVxyOsKE/ylGet
   f0Blu+xtxdvFXR5vmV+xZlU+iA8q5To1zR2yUF6B3BVhybvNkfa4C3QaB
   q0iXp4AUgWapCSVA2vOAY0IDOCmICHXgjB8I6WeTG60wrbVeA7ar///P7
   Q==;
X-CSE-ConnectionGUID: a6fCV4CaSFmC7M+srx9KzQ==
X-CSE-MsgGUID: xdDEFEkYQm2kkqYLUOwHMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62581479"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="62581479"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:26:51 -0800
X-CSE-ConnectionGUID: K+jPRXdLSNGIt2MHy6vbiQ==
X-CSE-MsgGUID: 2TpqkmqkQaetEU8VWMJi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143992863"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Feb 2025 22:26:45 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiSgN-0016dj-0c;
	Thu, 13 Feb 2025 06:26:43 +0000
Date: Thu, 13 Feb 2025 14:26:11 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <phasta@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	Philipp Stanner <pstanner@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: Replace deprecated PCI functions
Message-ID: <202502131415.1kfrLXGp-lkp@intel.com>
References: <20250212145831.101719-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212145831.101719-2-phasta@kernel.org>

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc2 next-20250212]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/stmmac-Replace-deprecated-PCI-functions/20250212-230254
base:   linus/master
patch link:    https://lore.kernel.org/r/20250212145831.101719-2-phasta%40kernel.org
patch subject: [PATCH] stmmac: Replace deprecated PCI functions
config: sparc64-randconfig-001-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131415.1kfrLXGp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131415.1kfrLXGp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131415.1kfrLXGp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: In function 'stmmac_pci_probe':
>> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:197:49: error: expected ';' before 'break'
     197 |                         return PTR_ERR(res.addr)
         |                                                 ^
         |                                                 ;
     198 |                 break;
         |                 ~~~~~                            


vim +197 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c

   140	
   141	/**
   142	 * stmmac_pci_probe
   143	 *
   144	 * @pdev: pci device pointer
   145	 * @id: pointer to table of device id/id's.
   146	 *
   147	 * Description: This probing function gets called for all PCI devices which
   148	 * match the ID table and are not "owned" by other driver yet. This function
   149	 * gets passed a "struct pci_dev *" for each device whose entry in the ID table
   150	 * matches the device. The probe functions returns zero when the driver choose
   151	 * to take "ownership" of the device or an error code(-ve no) otherwise.
   152	 */
   153	static int stmmac_pci_probe(struct pci_dev *pdev,
   154				    const struct pci_device_id *id)
   155	{
   156		struct stmmac_pci_info *info = (struct stmmac_pci_info *)id->driver_data;
   157		struct plat_stmmacenet_data *plat;
   158		struct stmmac_resources res = {};
   159		int i;
   160		int ret;
   161	
   162		plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
   163		if (!plat)
   164			return -ENOMEM;
   165	
   166		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
   167						   sizeof(*plat->mdio_bus_data),
   168						   GFP_KERNEL);
   169		if (!plat->mdio_bus_data)
   170			return -ENOMEM;
   171	
   172		plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
   173					     GFP_KERNEL);
   174		if (!plat->dma_cfg)
   175			return -ENOMEM;
   176	
   177		plat->safety_feat_cfg = devm_kzalloc(&pdev->dev,
   178						     sizeof(*plat->safety_feat_cfg),
   179						     GFP_KERNEL);
   180		if (!plat->safety_feat_cfg)
   181			return -ENOMEM;
   182	
   183		/* Enable pci device */
   184		ret = pcim_enable_device(pdev);
   185		if (ret) {
   186			dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
   187				__func__);
   188			return ret;
   189		}
   190	
   191		/* The first BAR > 0 is the base IO addr of our device. */
   192		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
   193			if (pci_resource_len(pdev, i) == 0)
   194				continue;
   195			res.addr = pcim_iomap_region(pdev, i, STMMAC_RESOURCE_NAME);
   196			if (IS_ERR(res.addr))
 > 197				return PTR_ERR(res.addr)
   198			break;
   199		}
   200	
   201		pci_set_master(pdev);
   202	
   203		ret = info->setup(pdev, plat);
   204		if (ret)
   205			return ret;
   206	
   207		res.wol_irq = pdev->irq;
   208		res.irq = pdev->irq;
   209	
   210		plat->safety_feat_cfg->tsoee = 1;
   211		plat->safety_feat_cfg->mrxpee = 1;
   212		plat->safety_feat_cfg->mestee = 1;
   213		plat->safety_feat_cfg->mrxee = 1;
   214		plat->safety_feat_cfg->mtxee = 1;
   215		plat->safety_feat_cfg->epsi = 1;
   216		plat->safety_feat_cfg->edpp = 1;
   217		plat->safety_feat_cfg->prtyen = 1;
   218		plat->safety_feat_cfg->tmouten = 1;
   219	
   220		return stmmac_dvr_probe(&pdev->dev, plat, &res);
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

