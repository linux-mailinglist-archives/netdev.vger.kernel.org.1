Return-Path: <netdev+bounces-154922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D81FA00595
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196D83A3752
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B131CC881;
	Fri,  3 Jan 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1yguwH1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E11C5F39
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892014; cv=none; b=MmMGLWWBVstbhguQ/m9+5PIfRtMe6NcF48zpQCbJ2gyOBH6qkTRr4Gy7RC10UB0MMi5jrC3HGkwza3tTQ9Q/t5R13vDTixJQ20oFbhORUCtz2VVgtOs5NipZ1+bFa/Jk4Fj6c/rGwvtkLEqGSam2GEbDnylK1sxIpHSyK0ClgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892014; c=relaxed/simple;
	bh=5hJfPnpODmQlvXxmTo2PZheL0x0e+Xckg2TBWGHXoBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6LZeNRDCrD3wp2dlRj4z0xXDvGOlAjzv1653XdFjd8rudd42T//GMXB1728u9lrlO4nGB0Hi9Yn1OL6JgILZJrBjVujkYeKZxJYomKNbOS1IoQwq8ZxqmLLxVoEkaWIJcVyexxBUNhlqd16xSlcNTmlxc41wEG2yddhbJAN9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1yguwH1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735892012; x=1767428012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5hJfPnpODmQlvXxmTo2PZheL0x0e+Xckg2TBWGHXoBk=;
  b=J1yguwH1JqXWlhVOedRA01/vRzsAZ0Ci3fMOY5d5JhYezV6opaSKnN7K
   M0f9FU1l3VYt7f3y7ClE2ln+lqVZfLBazI/sh8XkxijbaWxcYUojfdu/4
   7/h9AChTi2JSkK+GmXAAbY+N+I2yAYauMegXhf+kzphmUidHpVTpsLshj
   wgy4+u8f/iJZHtBtUuuI+1pxr8nF7qTxuV2tjnx/IcIZ7o34whc2rn5c9
   mC+3N7n/4y1yLTV4FJmRAGDSZ1quM5L40T1qaLWgAph9u0p7XLJeRlJQ1
   ubvhykMLPpmu/aJyn0FXqliBmVj5X+vT3sAWagvubhAqVoluWlC4GgxaI
   g==;
X-CSE-ConnectionGUID: SLzWIEvsTsieSked7x6k3A==
X-CSE-MsgGUID: p2NeERg7TRG924WcxXDYxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="46718937"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="46718937"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 00:13:32 -0800
X-CSE-ConnectionGUID: soultjswQEWROcWhgv6ZQg==
X-CSE-MsgGUID: cocgJy2ORii8mCGyU26ITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="106773471"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Jan 2025 00:13:31 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTcoB-0009RX-2f;
	Fri, 03 Jan 2025 08:13:27 +0000
Date: Fri, 3 Jan 2025 16:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	skhawaja@google.com
Subject: Re: [PATCH net-next 3/3] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <202501031530.ss0kvHke-lkp@intel.com>
References: <20250102191227.2084046-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102191227.2084046-4-skhawaja@google.com>

Hi Samiullah,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Samiullah-Khawaja/Add-support-to-set-napi-threaded-for-individual-napi/20250103-031428
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250102191227.2084046-4-skhawaja%40google.com
patch subject: [PATCH net-next 3/3] Extend napi threaded polling to allow kthread based busy polling
config: x86_64-randconfig-073-20250103 (https://download.01.org/0day-ci/archive/20250103/202501031530.ss0kvHke-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250103/202501031530.ss0kvHke-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501031530.ss0kvHke-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_napi_devs_init':
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:158:50: warning: implicit conversion from 'enum <anonymous>' to 'enum napi_threaded_state' [-Wenum-conversion]
     158 |         dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
         |                                                  ^~~~


vim +158 drivers/net/ethernet/mellanox/mlxsw/pci.c

eda6500a987a02 Jiri Pirko 2015-07-29  140  
5d01ed2e970812 Amit Cohen 2024-04-26  141  static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
5d01ed2e970812 Amit Cohen 2024-04-26  142  {
5d01ed2e970812 Amit Cohen 2024-04-26  143  	int err;
5d01ed2e970812 Amit Cohen 2024-04-26  144  
5d01ed2e970812 Amit Cohen 2024-04-26  145  	mlxsw_pci->napi_dev_tx = alloc_netdev_dummy(0);
5d01ed2e970812 Amit Cohen 2024-04-26  146  	if (!mlxsw_pci->napi_dev_tx)
5d01ed2e970812 Amit Cohen 2024-04-26  147  		return -ENOMEM;
5d01ed2e970812 Amit Cohen 2024-04-26  148  	strscpy(mlxsw_pci->napi_dev_tx->name, "mlxsw_tx",
5d01ed2e970812 Amit Cohen 2024-04-26  149  		sizeof(mlxsw_pci->napi_dev_tx->name));
5d01ed2e970812 Amit Cohen 2024-04-26  150  
5d01ed2e970812 Amit Cohen 2024-04-26  151  	mlxsw_pci->napi_dev_rx = alloc_netdev_dummy(0);
5d01ed2e970812 Amit Cohen 2024-04-26  152  	if (!mlxsw_pci->napi_dev_rx) {
5d01ed2e970812 Amit Cohen 2024-04-26  153  		err = -ENOMEM;
5d01ed2e970812 Amit Cohen 2024-04-26  154  		goto err_alloc_rx;
5d01ed2e970812 Amit Cohen 2024-04-26  155  	}
5d01ed2e970812 Amit Cohen 2024-04-26  156  	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
5d01ed2e970812 Amit Cohen 2024-04-26  157  		sizeof(mlxsw_pci->napi_dev_rx->name));
5d01ed2e970812 Amit Cohen 2024-04-26 @158  	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
5d01ed2e970812 Amit Cohen 2024-04-26  159  
5d01ed2e970812 Amit Cohen 2024-04-26  160  	return 0;
5d01ed2e970812 Amit Cohen 2024-04-26  161  
5d01ed2e970812 Amit Cohen 2024-04-26  162  err_alloc_rx:
5d01ed2e970812 Amit Cohen 2024-04-26  163  	free_netdev(mlxsw_pci->napi_dev_tx);
5d01ed2e970812 Amit Cohen 2024-04-26  164  	return err;
5d01ed2e970812 Amit Cohen 2024-04-26  165  }
5d01ed2e970812 Amit Cohen 2024-04-26  166  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

