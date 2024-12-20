Return-Path: <netdev+bounces-153764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E39F9A8C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E3E188B360
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B52210F0;
	Fri, 20 Dec 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITl20kCr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FD219A8A;
	Fri, 20 Dec 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723087; cv=none; b=qKV5tDomwSzIjfvKk2hi9X8g/cYhC+8dVobq97jjAG0QfYiwest1+M+wZI6XDTTLzzED5sarQ1/VG6q4TjF+72CMxk9NtYhocHigc+AyCBgfPO86Ok/Z9cc/NUP9StQtyOoK2zIOkY+VwbogkQoSxP60ksHLixpg0Q4SaAZcCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723087; c=relaxed/simple;
	bh=gE5B/harMQOgrohpMM0tjbu+TwLh/J6VRdbbGp8Y0Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+SHR0VDvBr7ytlOwVc99GyhtaYCAUoWgIjnZ4qmK9yQBs1zuejSuXnpxGq/iuQSeYPqYp9ti3QwA9AwfkKo6PmcJ53aMCJ9MBQ3tJe/yZt7j9sgXdFsK6VgXoqJJLwM3GMroMQNPp+PgmPmm9WzzaV0GEdpm7QAK50PbG+nNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITl20kCr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734723085; x=1766259085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gE5B/harMQOgrohpMM0tjbu+TwLh/J6VRdbbGp8Y0Q4=;
  b=ITl20kCrkL9BGrQy04/UGDJ0KtAgqNcSvkxY3lqx0UxrTg1W3MuZUvmw
   ormnEZbSRHADeEHrKiOnMmY+js6SHVVOr5rNybexZMHe6cH7beMrPSTbO
   3fFHpfQ35qWNUgSuri6c1e1UrZO24yNbeK8Pjj/IteIu48lbf3EDcCBcw
   4K1JcyMiaVSpiVjDwGVtlc5uOWSvIlNaQltQOgYzpiBxtakn7OklcopLS
   UA/P8AGB3fGyZQaztPpgfBS2SsrEtLZlxOAg9qGBM8RLVilvW2LziC0Qh
   JMukctWITzWhAmVH3b8jSpNrT//T4bjpuhSRv13Q0Mc2wOXhX6bypmu4n
   A==;
X-CSE-ConnectionGUID: Ebf1tThMT2m68gNffk+BqA==
X-CSE-MsgGUID: hnYdn4i5R7e9ljbHQnEjXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="45773430"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="45773430"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 11:31:15 -0800
X-CSE-ConnectionGUID: Im4d5srGTq6qkVGqKay+qA==
X-CSE-MsgGUID: ZEwlx298SN2ELracm5cmMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="103568129"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Dec 2024 11:31:08 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOiiH-0001dL-1p;
	Fri, 20 Dec 2024 19:31:05 +0000
Date: Sat, 21 Dec 2024 03:30:14 +0800
From: kernel test robot <lkp@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>, aleksander.lobakin@intel.com,
	lukma@denx.de, m-malladi@ti.com, diogo.ivo@siemens.com,
	rdunlap@infradead.org, schnelle@linux.ibm.com,
	vladimir.oltean@nxp.com, horms@kernel.org, rogerq@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG
 Driver
Message-ID: <202412210336.BmgcX3Td-lkp@intel.com>
References: <20241216100044.577489-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216100044.577489-2-danishanwar@ti.com>

Hi MD,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 92c932b9946c1e082406aa0515916adb3e662e24]

url:    https://github.com/intel-lab-lkp/linux/commits/MD-Danish-Anwar/net-ti-Kconfig-Select-HSR-for-ICSSG-Driver/20241216-180412
base:   92c932b9946c1e082406aa0515916adb3e662e24
patch link:    https://lore.kernel.org/r/20241216100044.577489-2-danishanwar%40ti.com
patch subject: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG Driver
config: arm64-kismet-CONFIG_NET_SWITCHDEV-CONFIG_TI_ICSSG_PRUETH-0-0 (https://download.01.org/0day-ci/archive/20241221/202412210336.BmgcX3Td-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241221/202412210336.BmgcX3Td-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210336.BmgcX3Td-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NET_SWITCHDEV when selected by TI_ICSSG_PRUETH
   WARNING: unmet direct dependencies detected for NET_SWITCHDEV
     Depends on [n]: NET [=y] && INET [=n]
     Selected by [y]:
     - TI_ICSSG_PRUETH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PRU_REMOTEPROC [=y] && ARCH_K3 [=y] && OF [=y] && TI_K3_UDMA_GLUE_LAYER [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

