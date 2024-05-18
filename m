Return-Path: <netdev+bounces-97113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D28C9208
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698ABB21C27
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF04C481BD;
	Sat, 18 May 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrDDLqr3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A71D6A5;
	Sat, 18 May 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716059017; cv=none; b=u5MoDb9nfFq3tTxhHlQWzp5KYvjxB293G7Dba6ygeYfiQYN63kSqZ3LKy7+cyc3cOD6Oc7QnHbsQuy9pMhyCsTbUQfkFa8GTNPQVSfIz3hhisQXNfyaQED94qoUtckJsZJYVHoIRw92CQ+EKF8k0U/jHQmBzjLiGs3Gt03n00Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716059017; c=relaxed/simple;
	bh=7rmGpkOatz4do+81lJEjQWDYuejNH0Ay1bs4H11lIbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbkIBkEsfhz5pQ/znB+p0su7bjLjhIstPyI+QEokDLjej2J53F7j/+YME1EYC7XVf3mBI2VPa7r3Oh9HdLoE7ZW47Ak2PlgreYgKK9Q+fxAkRmy2sUzi21DhH27+K22Ke0Qx8CcGWrjYqPtJBLuyc04ga6gDkXXQxS6XwB96jr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrDDLqr3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716059016; x=1747595016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7rmGpkOatz4do+81lJEjQWDYuejNH0Ay1bs4H11lIbo=;
  b=OrDDLqr3JAjJLDw76kjDEM5NvydPMk3Us0Utr2XUOSD02lQDOrQUjtS1
   qyCEzNUWftvld7/DMb8QGqPrPQB61fKHvEsKo9mLU+6XMEPzVJNdO9SgG
   tWhno7GUKNNf6fkLmTuU6pX47mt9pmnMggnGVzn0c7fuMG894Br/MONZX
   6prNopQ7AP9yCBl6dY/mh542MgIJ3EB0z2AGaqnUsP/PcJfbps9yPNSnA
   vQldzI9A+YyUBxMv0MDwHK+s5i4XIpk7SPgBv7E3BMAWGBcUAoFx46W3g
   ca5255hG8w5f4TqhKKJIYC0tVPanmiSgbArnIE7iH/FpZHQBdnZG22xPZ
   A==;
X-CSE-ConnectionGUID: jJ8bpRuzTm+uDWogYloKHw==
X-CSE-MsgGUID: OUVNK0U6Q7OkWAlykVfF2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12075602"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="12075602"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 12:03:35 -0700
X-CSE-ConnectionGUID: LUvghvNBQFec0W5tb3HKuw==
X-CSE-MsgGUID: 1q2z18JQSV6KxmPSeW8J6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="32533127"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 18 May 2024 12:03:29 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8PL5-0002YC-1M;
	Sat, 18 May 2024 19:03:27 +0000
Date: Sun, 19 May 2024 03:02:40 +0800
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH net-next v2 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <202405190214.zVx19jfL-lkp@intel.com>
References: <20240517102908.12079-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517102908.12079-2-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240517]
[cannot apply to net-next/main net/main linus/master v6.9 v6.9-rc7 v6.9-rc6 v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20240517-184536
base:   next-20240517
patch link:    https://lore.kernel.org/r/20240517102908.12079-2-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next v2 1/5] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20240519/202405190214.zVx19jfL-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240519/202405190214.zVx19jfL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405190214.zVx19jfL-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mtk_socphy_write_page':
   mtk-ge-soc.c:(.text+0x70): undefined reference to `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x70): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mtk_socphy_read_page':
   mtk-ge-soc.c:(.text+0xa4): undefined reference to `__mdiobus_read'
   mtk-ge-soc.c:(.text+0xa4): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_read'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7981_phy_finetune':
   mtk-ge-soc.c:(.text+0x150): undefined reference to `phy_write_mmd'
>> mtk-ge-soc.c:(.text+0x150): relocation truncated to fit: R_NIOS2_CALL26 against `phy_write_mmd'
>> nios2-linux-ld: mtk-ge-soc.c:(.text+0x16c): undefined reference to `phy_select_page'
>> mtk-ge-soc.c:(.text+0x16c): relocation truncated to fit: R_NIOS2_CALL26 against `phy_select_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x180): undefined reference to `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x180): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x194): undefined reference to `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x194): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x1a8): undefined reference to `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x1a8): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x1bc): undefined reference to `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x1bc): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x1d0): undefined reference to `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x1d0): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0x1e4): more undefined references to `__mdiobus_write' follow
   drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7981_phy_finetune':
   mtk-ge-soc.c:(.text+0x1e4): relocation truncated to fit: R_NIOS2_CALL26 against `__mdiobus_write'
   mtk-ge-soc.c:(.text+0x1f8): additional relocation overflows omitted from the output
>> nios2-linux-ld: mtk-ge-soc.c:(.text+0x26c): undefined reference to `phy_restore_page'
>> nios2-linux-ld: mtk-ge-soc.c:(.text+0x288): undefined reference to `phy_modify_mmd'
>> nios2-linux-ld: mtk-ge-soc.c:(.text+0x29c): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x2b0): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x2c4): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x2d8): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x2ec): undefined reference to `phy_write_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0x300): more undefined references to `phy_write_mmd' follow
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7981_phy_finetune':
   mtk-ge-soc.c:(.text+0x380): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x39c): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x3b0): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x3c4): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x3d8): undefined reference to `phy_write_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_finetune':
   mtk-ge-soc.c:(.text+0x48c): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x4b0): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x4bc): undefined reference to `phy_select_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x4d0): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x4e4): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x4f8): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x50c): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x520): undefined reference to `__mdiobus_write'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0x534): more undefined references to `__mdiobus_write' follow
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_finetune':
   mtk-ge-soc.c:(.text+0x580): undefined reference to `phy_restore_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x59c): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x5b0): undefined reference to `phy_write_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_common_finetune':
   mtk-ge-soc.c:(.text+0x5fc): undefined reference to `phy_select_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x610): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x624): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x638): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x64c): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x660): undefined reference to `__mdiobus_write'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0x674): more undefined references to `__mdiobus_write' follow
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_common_finetune':
   mtk-ge-soc.c:(.text+0x774): undefined reference to `phy_restore_page'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
   mtk-ge-soc.c:(.text+0x7c8): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x7e0): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x7f8): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x814): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x82c): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0x848): more undefined references to `phy_modify_mmd' follow
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
   mtk-ge-soc.c:(.text+0x8f8): undefined reference to `phy_select_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x90c): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x920): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x934): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x948): undefined reference to `__mdiobus_write'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x95c): undefined reference to `__mdiobus_write'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0x970): more undefined references to `__mdiobus_write' follow
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
   mtk-ge-soc.c:(.text+0xae8): undefined reference to `phy_restore_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xaf4): undefined reference to `phy_select_page'
>> nios2-linux-ld: mtk-ge-soc.c:(.text+0xb08): undefined reference to `__phy_modify'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xb1c): undefined reference to `__phy_modify'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xb2c): undefined reference to `phy_restore_page'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xb44): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `cal_cycle.constprop.0':
   mtk-ge-soc.c:(.text+0xba0): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xbbc): undefined reference to `phy_modify_mmd'
>> nios2-linux-ld: mtk-ge-soc.c:(.text+0xbec): undefined reference to `phy_read_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xc24): undefined reference to `phy_read_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xc54): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xc64): undefined reference to `phy_read_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `tx_vcm_cal_sw':
   mtk-ge-soc.c:(.text+0xd4c): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xd64): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xd80): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xdcc): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0xde4): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:mtk-ge-soc.c:(.text+0xdfc): more undefined references to `phy_modify_mmd' follow
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `cal_efuse':
   mtk-ge-soc.c:(.text+0x1710): undefined reference to `phy_write_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_hw_led_on_set':
   mtk-ge-soc.c:(.text+0x1b4c): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_hw_led_blink_set':
   mtk-ge-soc.c:(.text+0x1ca8): undefined reference to `phy_write_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_control_set':
   mtk-ge-soc.c:(.text+0x1fa4): undefined reference to `phy_write_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x1fc8): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x1fec): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_control_get':
   mtk-ge-soc.c:(.text+0x2070): undefined reference to `phy_read_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x20a8): undefined reference to `phy_read_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x22b8): undefined reference to `phy_read_mmd'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_probe':
   mtk-ge-soc.c:(.text+0x2344): undefined reference to `devm_phy_package_join'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x2468): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x248c): undefined reference to `phy_modify_mmd'
   nios2-linux-ld: mtk-ge-soc.c:(.text+0x24f4): undefined reference to `phy_modify_mmd'
>> nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x7c): undefined reference to `genphy_suspend'
>> nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x80): undefined reference to `genphy_resume'
>> nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x94): undefined reference to `genphy_handle_interrupt_no_ack'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x190): undefined reference to `genphy_suspend'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x194): undefined reference to `genphy_resume'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x1a8): undefined reference to `genphy_handle_interrupt_no_ack'
   nios2-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `phy_module_init':
   mtk-ge-soc.c:(.init.text+0x18): undefined reference to `phy_drivers_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

