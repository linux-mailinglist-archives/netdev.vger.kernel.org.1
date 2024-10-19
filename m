Return-Path: <netdev+bounces-137223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC59A4EE2
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D851C23E9A
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32814D71E;
	Sat, 19 Oct 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+1FPevQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DF148301;
	Sat, 19 Oct 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349744; cv=none; b=KizxYkN9KJ7w/hJkKp0mWZwDgmlYK3Al0IlxoPqQEkrCghC/B732zhfL2peXKCOa4evCi921zkX6ocHKHBaRATr5TldLz8wQ6UUD1pqsMEWClNEukeDTf64tqYWlcS1jWWdgzCUuzndPFvsDhUTFbRmMzPUHvwsAL4c+nxkRoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349744; c=relaxed/simple;
	bh=xLGc/fkE70XqNDOSKMtczAKjs2MSYYL8whgVc/JqJSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP00JXEYoMou8q7hSJyv/1tIE/93FIDZKy+BAGB3vgt6nBkZxWx1/ExElDgTIQJOcrWrCDYHtonHDLkwEQkrNfa0K/yqyjw7W9sPGHKhuXfaoCoXGqu1VBY2nzX3X1TLK+YJXen8Ft65H4dIANyWz/7AFcCYKkhrHl2lztpcUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+1FPevQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729349742; x=1760885742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xLGc/fkE70XqNDOSKMtczAKjs2MSYYL8whgVc/JqJSY=;
  b=X+1FPevQuefMM3I5xUf9am9hCfof/dN76iH5q/xTPm9zVdS9ns4BO76q
   Bg+sqQz4zj5iTx51KxQQ+GfeGH9Ic4+/OzSnEkV5MU2QGZ/RL7AIKFr3D
   YuYtrPK/d3eFZxZv9phqliO0QnSzwk1h5eM89/1UJ62qprhJZmvweTYT2
   iksyqmEjcUEVfa/rHG2qG0ipp3PrHfFhxc4iiH5S0ylz3t/O3bcGdYt5n
   aDdXUj4wdZQPuRF7xb32BHPMSl0Old507TupXaVUPLF0J52YJu/gQbPhZ
   lo36+EkOV9GqokTt35zpq5JawLpqDsBm7Xk0X+HJ8/6Fy9T5UKg49rcN4
   A==;
X-CSE-ConnectionGUID: nLnZzuUfSLKq2tCYTvfLWQ==
X-CSE-MsgGUID: hleZ16COSMeYuwroX4oOMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="32790397"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="32790397"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 07:55:41 -0700
X-CSE-ConnectionGUID: 6uBQQkNuRlm0VF+g8SreCg==
X-CSE-MsgGUID: uulSNiABQ7uT9RqAe/UI2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="79046680"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Oct 2024 07:55:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Are-000P5z-0k;
	Sat, 19 Oct 2024 14:55:34 +0000
Date: Sat, 19 Oct 2024 22:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rosen Penev <rosenp@gmail.com>, Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 net-next 2/6] net: ibm: emac: remove custom init/exit
 functions
Message-ID: <202410192213.VVMV5TxH-lkp@intel.com>
References: <20241015200222.12452-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015200222.12452-4-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-use-netif_receive_skb_list/20241016-040516
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241015200222.12452-4-rosenp%40gmail.com
patch subject: [PATCHv7 net-next 2/6] net: ibm: emac: remove custom init/exit functions
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20241019/202410192213.VVMV5TxH-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410192213.VVMV5TxH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410192213.VVMV5TxH-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/core.o: in function `emac_init':
>> core.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/core.o: in function `emac_exit':
   core.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/zmii.o: in function `zmii_driver_init':
   zmii.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/zmii.o: in function `zmii_driver_exit':
   zmii.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/rgmii.o: in function `rgmii_driver_init':
   rgmii.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/rgmii.o: in function `rgmii_driver_exit':
   rgmii.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/tah.o: in function `tah_driver_init':
   tah.c:(.init.text+0x8): multiple definition of `init_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.init.text+0x8): first defined here
   powerpc64-linux-ld: drivers/net/ethernet/ibm/emac/tah.o: in function `tah_driver_exit':
   tah.c:(.exit.text+0x8): multiple definition of `cleanup_module'; drivers/net/ethernet/ibm/emac/mal.o:mal.c:(.exit.text+0x8): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

