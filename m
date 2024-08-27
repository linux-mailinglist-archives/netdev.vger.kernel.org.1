Return-Path: <netdev+bounces-122148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA39601CC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B2B1F22256
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3B5476B;
	Tue, 27 Aug 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI1KMHo0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2325570;
	Tue, 27 Aug 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740443; cv=none; b=k5wcbajOWOYAcgP1fWVIi29mURllkC4+Xb1VvcRoDHRRuWM3EKEYnZCs5I2fY8kEa1vPsD3jqdL9lgHj1WQ2m9PS28V0vNNxW4MP0x+7Upsg4DKds7479trmDQzHbmvv7q+L7Iu2vdfUW+GszzQOoShoKyZV67wMpNJk7XX4pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740443; c=relaxed/simple;
	bh=P9zOrCau2M2SHj2r5Dp5xZiqEpHI+waUUi/eT5wM3ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSri264RXUEtqgeQKVb0EBLfg3ObdAU5WK7Nut2KecNXfpee1BYUVqauXNlDyGNZq834mzkfDJIWDFOvC+7ZYzvBVeGACImG59kL87iFCkV8T8TXZEbDoRao83uxpKROGhw2N9nqUEFVgbWk4PXFbQW6RkQBSSM7jMppxFwdaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI1KMHo0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724740442; x=1756276442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9zOrCau2M2SHj2r5Dp5xZiqEpHI+waUUi/eT5wM3ec=;
  b=KI1KMHo0/kxkI1qrFB5BSieF5zSjqGZjG7YSoMG6eYlMnwbLvlkO60AP
   bqVfstvE7DLDRzJH04sphi3FIAMULDfRGBEry4cGVSLjk08pbmxzEtADw
   km6XZ0qx2ZrjKVsy6Vz+Go+QujbEzjVyKuPu0aP5g7n3Cl2Z2GiHqvm4s
   wDpPh5I2S7FtkBwIBYmoL7lKSJpDg8G0B9yMa5HytI7TjMfFh9zVChbgb
   fFENCRgks+V0ctFHYaEAoEg0f8nsHHzyPrV15xgdBODgqSMjFL+uOiNYA
   89TobmPW9zMR1F7qwARutTHFiz/AFnVcRxbq+idfQMM8rKLPTdIqNyKc1
   w==;
X-CSE-ConnectionGUID: mHUAMulTQLyp9xWOC2Jm6g==
X-CSE-MsgGUID: 0Ra6QN8hQQaZZPsplA1rQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34606220"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="34606220"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:34:01 -0700
X-CSE-ConnectionGUID: FG++n/t7TZmX7tyo1f58fw==
X-CSE-MsgGUID: zUpZghT4SdS8EMlyUKnNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62722566"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 23:33:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sipm8-000I9S-0k;
	Tue, 27 Aug 2024 06:33:56 +0000
Date: Tue, 27 Aug 2024 14:32:59 +0800
From: kernel test robot <lkp@intel.com>
To: Maksym Kutsevol <max@kutsevol.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Message-ID: <202408271419.3JJwwxE7-lkp@intel.com>
References: <20240824215130.2134153-2-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824215130.2134153-2-max@kutsevol.com>

Hi Maksym,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8af174ea863c72f25ce31cee3baad8a301c0cf0f]

url:    https://github.com/intel-lab-lkp/linux/commits/Maksym-Kutsevol/netcons-Add-udp-send-fail-statistics-to-netconsole/20240826-163850
base:   8af174ea863c72f25ce31cee3baad8a301c0cf0f
patch link:    https://lore.kernel.org/r/20240824215130.2134153-2-max%40kutsevol.com
patch subject: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408271419.3JJwwxE7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271419.3JJwwxE7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271419.3JJwwxE7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/netconsole.c:27:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/netconsole.c:35:
   In file included from include/linux/netpoll.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/netconsole.c:35:
   In file included from include/linux/netpoll.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/netconsole.c:35:
   In file included from include/linux/netpoll.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/net/netconsole.c:341:3: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     340 |         return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
         |                                            ~~~
         |                                            %zu
     341 |                 nt->stats.xmit_drop_count, nt->stats.enomem_count);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netconsole.c:341:30: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     340 |         return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
         |                                                        ~~~
         |                                                        %zu
     341 |                 nt->stats.xmit_drop_count, nt->stats.enomem_count);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~
   9 warnings generated.


vim +341 drivers/net/netconsole.c

   335	
   336	static ssize_t stats_show(struct config_item *item, char *buf)
   337	{
   338		struct netconsole_target *nt = to_target(item);
   339	
   340		return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
 > 341			nt->stats.xmit_drop_count, nt->stats.enomem_count);
   342	}
   343	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

