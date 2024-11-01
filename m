Return-Path: <netdev+bounces-140845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3B9B87A0
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E3CB21F28
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8C125D5;
	Fri,  1 Nov 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAEYMZpI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856E1D555;
	Fri,  1 Nov 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420703; cv=none; b=kM/bMieBk1U0gIYfti+iJhRdK1BMSb+JaipJveymT+D8S6IfjtGO2N9SlGdBej+hPzIWWuueK/Zyt8gFz6u5BeqVvwzfB2IhV9qGjlv3RqlV2+5zh2Q9Lm6nLNObQN14v+5BJsv+vGOtYJO7ufzI4Mc+sHU4lqxzsgBZZ93if5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420703; c=relaxed/simple;
	bh=HgGI0MztuDXM0kkbhNu/WK25UzLMgeMemdDEF+M6Yis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPn2yrqF6piEyhVtJ0Q6bhqKZTabPSDsTLXeRUGSONUik5H2gf4DkoKKp5x5u4Tx9ZNGh/T6kLyO8b3GCmrJfNZZpUZ+V6xtvmQRGz/sGQoQ2LIutHc0oa4pOxKg6Pl1PFIwJvFtstERR+hjOeEEXN6MYrvbAjdKveC59K54PK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAEYMZpI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730420697; x=1761956697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HgGI0MztuDXM0kkbhNu/WK25UzLMgeMemdDEF+M6Yis=;
  b=EAEYMZpIRLkbQHl2E2EvHVsmKvU1E5th+hnA0XA+QNP7UjTPRMtF43zI
   76wt6RppZxBLuqKJnZqIjXRXIkrEvE5i/F4N9vpm1k7gcugd33O7awZ/G
   E4Nk8THqasZ1YcnBRjLL6e6YWs+mek23mWnK2sY5UrkUXGflvd6r2ulCh
   raMVw7MkE+39Qf/BSe3NaHebDWOgIthpdEL2EtQtszB2ESO152sZqp2Ku
   xaUUDkpPRqJnTKrN3h5og8Qi7vq4kdZ6/Pu0+FqQvUS8RKLt6UUfmDT/D
   UAXIdZQG2E5BvbcSl5fWQNNqb0P8JmxOj0ut6hmdQseBk66B2qCWuseHG
   w==;
X-CSE-ConnectionGUID: 5LXjEgUXSdC3YNDqNV0Cpg==
X-CSE-MsgGUID: WQRq/YLGSTiFbikQHJxjdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="33988273"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="33988273"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 17:24:56 -0700
X-CSE-ConnectionGUID: RzYv7uP7THeQKpbmmHYBZA==
X-CSE-MsgGUID: 96x6eHVSQbyORU8dcMijjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="82323066"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Oct 2024 17:24:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6fT7-000gsN-2M;
	Fri, 01 Nov 2024 00:24:49 +0000
Date: Fri, 1 Nov 2024 08:24:12 +0800
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
Message-ID: <202411010814.EOjx8juJ-lkp@intel.com>
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
config: i386-randconfig-004-20241101 (https://download.01.org/0day-ci/archive/20241101/202411010814.EOjx8juJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010814.EOjx8juJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411010814.EOjx8juJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: drivers/net/phy/mediatek/mtk-ge.o:(.data+0xb4): undefined reference to `mtk_phy_read_page'
>> ld: drivers/net/phy/mediatek/mtk-ge.o:(.data+0xb8): undefined reference to `mtk_phy_write_page'
   ld: drivers/net/phy/mediatek/mtk-ge.o:(.data+0x1c8): undefined reference to `mtk_phy_read_page'
   ld: drivers/net/phy/mediatek/mtk-ge.o:(.data+0x1cc): undefined reference to `mtk_phy_write_page'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

