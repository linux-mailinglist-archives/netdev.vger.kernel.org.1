Return-Path: <netdev+bounces-236191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C762FC39ADF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 764B64E5E97
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F73090D4;
	Thu,  6 Nov 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7KnJiWX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14702305044
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419415; cv=none; b=NfVJnw3zy+tup6vkm8NfymkK0Ww0jM0ZiG+saocN5e6c9t/DFO4mh5uyM5tFp0AaCKy3LNrBvV68v/jx3vUb79Ea2ym3fprgDhXYQZm0NMJthcx86RcorcFF9w7dPqKg5SfQZ1MdyY7NLD4Npj7rJJdSrYfESXACNLeJ5/9GMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419415; c=relaxed/simple;
	bh=sXiCrdjbMV4e2P7fyxw7Yhakha2+YKj2DrUmvYVWG4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj0e7WvwJ0NqQXQwKD/MBqD84tX12mMmcYmjQrTFACKVdITXhdkJ8Aa74Fjrat4MdpiZW4QJ7qFWCrg7DFUy0W8F6+EHGiz8FoPcaAdHu4uj6dEcS2eJD0mSUruxrGu2xoJeg1ym0XqTD3GN4YNt5LdGHZYwCik96w+twnTZsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7KnJiWX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762419414; x=1793955414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sXiCrdjbMV4e2P7fyxw7Yhakha2+YKj2DrUmvYVWG4A=;
  b=g7KnJiWXg3P8nXEz6Phz+7meT2LqxCzO1AdfYNC4suF1dtvL5eN8UrCl
   2n6DBZ0r9kufk7YKpFChru5yOpwc18Ko2SLoCgyOL45/6dxLZMRLm7yt/
   cuvB2gUluBtpvsE35K1rPUJXdZxuKdfPfSau01+aPnCWojRI7SLuxTaZG
   DsIQY+KcvCq7a8BBmPnHQAPZeL+kALZBWL6Xhw+U+cGgFu/6Cnr82zkvv
   TkS1bw9/CP9eN3ZVHpdHf4qzxXGJNa0aaYV2vkia8Tssv+XHnoX/ViVHC
   qwcIG2fZZuyXj77lehNkZ8MIurmsCeGLCoJojm56Cm0I1rpMD/QMA//eZ
   A==;
X-CSE-ConnectionGUID: GAzc2h48T2qVrbGreQmSvw==
X-CSE-MsgGUID: 36RCVOsLTeiIE04ZKb9p+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64458128"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64458128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:56:54 -0800
X-CSE-ConnectionGUID: jC7sJMaMRtejB4uXJhgqmg==
X-CSE-MsgGUID: g3/099PpRiWWzaltGU0bZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187649491"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Nov 2025 00:56:50 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGvnN-000TgC-0C;
	Thu, 06 Nov 2025 08:56:41 +0000
Date: Thu, 6 Nov 2025 16:56:11 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 2/2] qede: convert to use ndo_hwtstamp callbacks
Message-ID: <202511061627.LB8wUSOs-lkp@intel.com>
References: <20251105185133.3542054-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105185133.3542054-3-vadim.fedorenko@linux.dev>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bnx2x-convert-to-use-ndo_hwtstamp-callbacks/20251106-030837
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251105185133.3542054-3-vadim.fedorenko%40linux.dev
patch subject: [PATCH net-next 2/2] qede: convert to use ndo_hwtstamp callbacks
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251106/202511061627.LB8wUSOs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061627.LB8wUSOs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061627.LB8wUSOs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/qlogic/qede/qede_ptp.c: In function 'qede_hwtstamp_set':
>> drivers/net/ethernet/qlogic/qede/qede_ptp.c:289:13: warning: unused variable 'rc' [-Wunused-variable]
     289 |         int rc;
         |             ^~


vim +/rc +289 drivers/net/ethernet/qlogic/qede/qede_ptp.c

4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  282  
c704f693a6ea05 Vadim Fedorenko         2025-11-05  283  int qede_hwtstamp_set(struct net_device *netdev,
c704f693a6ea05 Vadim Fedorenko         2025-11-05  284  		      struct kernel_hwtstamp_config *config,
c704f693a6ea05 Vadim Fedorenko         2025-11-05  285  		      struct netlink_ext_ack *extack)
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  286  {
c704f693a6ea05 Vadim Fedorenko         2025-11-05  287  	struct qede_dev *edev = netdev_priv(netdev);
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  288  	struct qede_ptp *ptp;
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15 @289  	int rc;
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  290  
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  291  	ptp = edev->ptp;
c704f693a6ea05 Vadim Fedorenko         2025-11-05  292  	if (!ptp) {
c704f693a6ea05 Vadim Fedorenko         2025-11-05  293  		NL_SET_ERR_MSG_MOD(extack, "HW timestamping is not supported");
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  294  		return -EIO;
c704f693a6ea05 Vadim Fedorenko         2025-11-05  295  	}
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  296  
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  297  	DP_VERBOSE(edev, QED_MSG_DEBUG,
c704f693a6ea05 Vadim Fedorenko         2025-11-05  298  		   "HWTSTAMP SET: Requested tx_type = %d, requested rx_filters = %d\n",
c704f693a6ea05 Vadim Fedorenko         2025-11-05  299  		   config->tx_type, config->rx_filter);
c704f693a6ea05 Vadim Fedorenko         2025-11-05  300  
c704f693a6ea05 Vadim Fedorenko         2025-11-05  301  	switch (config->tx_type) {
c704f693a6ea05 Vadim Fedorenko         2025-11-05  302  	case HWTSTAMP_TX_ONESTEP_SYNC:
c704f693a6ea05 Vadim Fedorenko         2025-11-05  303  	case HWTSTAMP_TX_ONESTEP_P2P:
c704f693a6ea05 Vadim Fedorenko         2025-11-05  304  		NL_SET_ERR_MSG_MOD(extack,
c704f693a6ea05 Vadim Fedorenko         2025-11-05  305  				   "One-step timestamping is not supported");
c704f693a6ea05 Vadim Fedorenko         2025-11-05  306  		return -ERANGE;
c704f693a6ea05 Vadim Fedorenko         2025-11-05  307  	}
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  308  
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  309  	ptp->hw_ts_ioctl_called = 1;
c704f693a6ea05 Vadim Fedorenko         2025-11-05  310  	ptp->tx_type = config->tx_type;
c704f693a6ea05 Vadim Fedorenko         2025-11-05  311  	ptp->rx_filter = config->rx_filter;
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  312  
c704f693a6ea05 Vadim Fedorenko         2025-11-05  313  	qede_ptp_cfg_filters(edev);
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  314  
c704f693a6ea05 Vadim Fedorenko         2025-11-05  315  	config->rx_filter = ptp->rx_filter;
4c55215c05d252 Sudarsana Reddy Kalluru 2017-02-15  316  
c704f693a6ea05 Vadim Fedorenko         2025-11-05  317  	return 0;
c704f693a6ea05 Vadim Fedorenko         2025-11-05  318  }
c704f693a6ea05 Vadim Fedorenko         2025-11-05  319  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

