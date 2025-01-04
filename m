Return-Path: <netdev+bounces-155124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994BA0127B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F8A7A13D5
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 05:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50F146A60;
	Sat,  4 Jan 2025 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmgoFT1p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C88467
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735967646; cv=none; b=SqbZvQZOFVjly89usPq9NiwJD+4hDXvxcITN7cN/NcAq0XxBH//pFuH74X/fRmO2REP8VJAKLqEMyw9qjdjvRM1cdu5xKdWt28Px9n1EUHCgrzw1a0Y87WGlw8E1Aqd0jdNxS9Wc4rifYgsp88B3/9yjvG8MZ99PsVaZ+Qs0Nlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735967646; c=relaxed/simple;
	bh=4KItOljKpS1HCczUbuBclQ7VtvYwtcxpc6b6O9c+Nzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPT+kLxRjIGZq4rC7pMLKpOyf8xeWEagqAEtj/qF5Zq9cccMRmjL5qdrBHoWAnPfpGuUxrg5lr/S8LO01s98Nz4d3RNLAW2PQtIZa2CNa3ftDoxlys2gf5+onTGoqSQnCglqaNndHx2fxJZ80dybIJ5cQ8bp+djo4F9zIlcKdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmgoFT1p; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735967644; x=1767503644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4KItOljKpS1HCczUbuBclQ7VtvYwtcxpc6b6O9c+Nzc=;
  b=MmgoFT1pDTWw2ejfR19QN1S3slq1+gbCMBbc6nTrvwbw1WQ4ogHSVYDN
   js4cwAPREE1XrhzU83PoYpdv64gdKE5IcYtxo0lLxIuiJOR/Ve0j+H1C9
   OAwC58m+4szYjw3BBDlrb+sK9D3bct0Y1R+E1IyLV+C9mF6EBfR0RS1JF
   /msEMqmAVKOz6XwVLz6UwGtDKQ410A2cbHIXncbLlwRZlBS6yvQVoZAUo
   YUtv+SFjdecD6OXw8rpbYT0vzY8eT/H3ExgL2jH2D+/HCz+e2YdvQ4RYw
   0qRh1yfBUiu/lYJo7BzkdATO9dEClu1r1r2+DPOPqOVUfXX7sINF7pGF9
   g==;
X-CSE-ConnectionGUID: O2PMd8UERt+FeoAdR1Fwuw==
X-CSE-MsgGUID: jjQiRXRLRQSFHUGrt3YDkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="36221279"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="36221279"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 21:14:04 -0800
X-CSE-ConnectionGUID: bQEAZzi7SMuAOqolOBbmtQ==
X-CSE-MsgGUID: FxwZw8j4TAqM9WQfMpA9LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107000651"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Jan 2025 21:14:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTwU1-000Adf-2L;
	Sat, 04 Jan 2025 05:13:57 +0000
Date: Sat, 4 Jan 2025 13:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	jdamato@fastly.com, shayd@nvidia.com, akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next v3 1/6] net: move ARFS rmap management to core
Message-ID: <202501041245.SDb1oN01-lkp@intel.com>
References: <20250104004314.208259-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104004314.208259-2-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-move-ARFS-rmap-management-to-core/20250104-084501
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250104004314.208259-2-ahmed.zaki%40intel.com
patch subject: [PATCH net-next v3 1/6] net: move ARFS rmap management to core
config: arm64-randconfig-002-20250104 (https://download.01.org/0day-ci/archive/20250104/202501041245.SDb1oN01-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501041245.SDb1oN01-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501041245.SDb1oN01-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/amazon/ena/ena_netdev.c:165:46: error: too few arguments to function call, expected 2, have 1
           return netif_enable_cpu_rmap(adapter->netdev);
                  ~~~~~~~~~~~~~~~~~~~~~                ^
   include/linux/netdevice.h:2769:5: note: 'netif_enable_cpu_rmap' declared here
   int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs);
       ^
   1 error generated.


vim +165 drivers/net/ethernet/amazon/ena/ena_netdev.c

   161	
   162	static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)
   163	{
   164	#ifdef CONFIG_RFS_ACCEL
 > 165		return netif_enable_cpu_rmap(adapter->netdev);
   166	#else
   167		return 0;
   168	#endif /* CONFIG_RFS_ACCEL */
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

