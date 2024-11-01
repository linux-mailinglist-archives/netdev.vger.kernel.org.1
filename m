Return-Path: <netdev+bounces-141050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748419B9420
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208B51F210EF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069F1B5EBC;
	Fri,  1 Nov 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgoRyI01"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95031AE01B;
	Fri,  1 Nov 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474091; cv=none; b=OWHhVdysYOwrkWhom/kpo/pRzoReT5QaSgzH2HgwqNNX/o0NpzVyXTMUV8TYwgBy46XF51f/NyvcdB2RI2H48hFWuYMaDD3B4KhMrcGqBJrSL/W5r86M7/Z6GwAccJ9G9bEybUndVeCpmXGQKK9IkVKcJs9NwmD9Ei5rFvESlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474091; c=relaxed/simple;
	bh=HDf6jYleLt1dL9i7iCeHfUfUY0TTmgcO8vabuye36qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkSVlYlII6luZ8LiAwRvqP2wKrkk++o5vetVL/kavcL9AEYLHlZShlc49XlQa/nJ2Gew4uplRPpPQTGSXPqRg2QlXwy2yRtc4bRHK0QE1omJ2TLUCXX/MU2luVuU/HDuKdZ83nC9dU1Z2RVu8Rj8MPCZ9msbtyZsSKc7SM0ktwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgoRyI01; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730474090; x=1762010090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HDf6jYleLt1dL9i7iCeHfUfUY0TTmgcO8vabuye36qY=;
  b=FgoRyI015GFNoF88T+leUYIcNrjnErjS3mVKnZ42hqQtpLV3/efQE7Jn
   1b1sJ7oxQnHyH35ZC8l19YN5nBoAAh32kra2HmsXt2BsiwLLzaxm2nSO1
   P9ufgZFbILYieix152EPbbRzez+qQoOm1x9JpnFEeZ3SnpONK0a9G7sEU
   h7wVOoxZJV9624nwLO/tk3Tr0jKkglrpGt3ozPg1odrO4SGNVLCoG4QBD
   OnwalF4CCmlxhLWIxyrKhiAoF1Gd8pwFJjMNZXrMlwRsAyI5AVa7pFBym
   oUkFvU2wNDqXvQBGRQ8Wl8Yc35ph1qM8tgzKq+AZWkfQVPkFVW5I/MSQH
   g==;
X-CSE-ConnectionGUID: SyetON0kTH6kqmzddxVciQ==
X-CSE-MsgGUID: 8/Bsvg+jQu+U5Am/pOBNkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30454123"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="30454123"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:14:49 -0700
X-CSE-ConnectionGUID: UBQEuVPYQoW0mbS4mKno7w==
X-CSE-MsgGUID: 6Ri9NZEUQHKCbwSfXmY+PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82914858"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 01 Nov 2024 08:14:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6tMI-000hgx-0S;
	Fri, 01 Nov 2024 15:14:42 +0000
Date: Fri, 1 Nov 2024 23:14:20 +0800
From: kernel test robot <lkp@intel.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH net-next 4/5] net: phy: mediatek: Integrate read/write
 page helper functions
Message-ID: <202411012322.1xALQkaN-lkp@intel.com>
References: <20241030103554.29218-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030103554.29218-5-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20241030-184043
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241030103554.29218-5-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next 4/5] net: phy: mediatek: Integrate read/write page helper functions
config: s390-randconfig-002-20241101 (https://download.01.org/0day-ci/archive/20241101/202411012322.1xALQkaN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411012322.1xALQkaN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012322.1xALQkaN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kasan/kasan_test.o
>> ERROR: modpost: "mtk_phy_read_page" [drivers/net/phy/mediatek/mtk-ge.ko] undefined!
>> ERROR: modpost: "mtk_phy_write_page" [drivers/net/phy/mediatek/mtk-ge.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

