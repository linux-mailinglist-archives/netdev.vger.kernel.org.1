Return-Path: <netdev+bounces-155149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2013A0144B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3811D18845FF
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502251B6CFF;
	Sat,  4 Jan 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gP/z5HUM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD241865E9
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735993244; cv=none; b=oMbekF1YDuMkvIgalPrIlyq92L2YW/vTp9iRY1hxkqzfDN3pNbKvK2jgm6KsD7LE1+wVwmws6UpQRf+EzVrT+Tq+MDgyTL5fDfyzfWMDAJAxE+nKBdugd6Pe5uVgyGgeasCsL+XkPBnHVvQwUe7GXfDKM/jjq8duJXvd+6C/xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735993244; c=relaxed/simple;
	bh=SwkhW83SN+9B0/cCedUZg9e7m00QztMGxnZT4lZjad8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN7YTzXnCNVEmb0zWVktl+8CZNreddcIl8aEOEL0XRtvjB/3StmUNFh0f5Vwrw67wdMHZRAKF4qmsua270BdZg6oPXOPcanpSDzkUSF/uplKKK7GCGz7wgFys6/9owS0XVffDm7Jf0i8Neyds0XYqTFCnyXdQI9E1W41K1iWjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gP/z5HUM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735993242; x=1767529242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SwkhW83SN+9B0/cCedUZg9e7m00QztMGxnZT4lZjad8=;
  b=gP/z5HUMaQG8eOBxU5BZnOX2r40dKXfFLylqvrZeKagNd3GNWoHyEp8l
   DI+WPLQs/+fYjxn5sVJFcrsXmqjXweyp/l+de1zWri3iApAfBiJerjZfk
   Rdux820HYDfqQ4CLptH4pSfxPJFJkLex/SvzgaTaRViwJqDEKRSu6wbsV
   Jrm2J3Uo7HiEu5iKEp2VeGQ+Ui1Aw5FRxETVK1+TGgwq0J5g3rN1ChE3D
   ZubMebeyVvLZT+Bff+/1InWnyKegg68p/8gnlwxZubJJX4Kcd2ANNeGeB
   JJHwCWmE4yTnZSf5q2ygEMIo3j+DqPtd22AZtm/n3ZIiJm5MD4SJJRrF6
   g==;
X-CSE-ConnectionGUID: XeDEEfIrTz+ytjavStbOlw==
X-CSE-MsgGUID: Swf2mV+cSHq0HnCHUjqMVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="58676857"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="58676857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 04:20:42 -0800
X-CSE-ConnectionGUID: p0FvasuYSDyxzefyQE6o+Q==
X-CSE-MsgGUID: CHhcGX+YQvmLdp3QM8C65Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106047238"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Jan 2025 04:20:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tU38t-000Atn-0B;
	Sat, 04 Jan 2025 12:20:35 +0000
Date: Sat, 4 Jan 2025 20:20:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
	akpm@linux-foundation.org, Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next v3 1/6] net: move ARFS rmap management to core
Message-ID: <202501042007.PjCFMiMs-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-move-ARFS-rmap-management-to-core/20250104-084501
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250104004314.208259-2-ahmed.zaki%40intel.com
patch subject: [PATCH net-next v3 1/6] net: move ARFS rmap management to core
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250104/202501042007.PjCFMiMs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501042007.PjCFMiMs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501042007.PjCFMiMs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/amazon/ena/ena_netdev.c: In function 'ena_init_rx_cpu_rmap':
   drivers/net/ethernet/amazon/ena/ena_netdev.c:165:16: error: too few arguments to function 'netif_enable_cpu_rmap'
     165 |         return netif_enable_cpu_rmap(adapter->netdev);
         |                ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/net/inet_sock.h:19,
                    from include/net/ip.h:29,
                    from drivers/net/ethernet/amazon/ena/ena_netdev.c:16:
   include/linux/netdevice.h:2769:5: note: declared here
    2769 | int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs);
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/amazon/ena/ena_netdev.c:169:1: warning: control reaches end of non-void function [-Wreturn-type]
     169 | }
         | ^


vim +169 drivers/net/ethernet/amazon/ena/ena_netdev.c

548c4940b9f1f5 Sameeh Jubran    2019-12-10  161  
1738cd3ed34229 Netanel Belgazal 2016-08-10  162  static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)
1738cd3ed34229 Netanel Belgazal 2016-08-10  163  {
1738cd3ed34229 Netanel Belgazal 2016-08-10  164  #ifdef CONFIG_RFS_ACCEL
4f6e7588aa8a24 Ahmed Zaki       2025-01-03  165  	return netif_enable_cpu_rmap(adapter->netdev);
4f6e7588aa8a24 Ahmed Zaki       2025-01-03  166  #else
1738cd3ed34229 Netanel Belgazal 2016-08-10  167  	return 0;
4f6e7588aa8a24 Ahmed Zaki       2025-01-03  168  #endif /* CONFIG_RFS_ACCEL */
1738cd3ed34229 Netanel Belgazal 2016-08-10 @169  }
1738cd3ed34229 Netanel Belgazal 2016-08-10  170  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

