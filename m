Return-Path: <netdev+bounces-109108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B4926F55
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43017281EBF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 06:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B451A071F;
	Thu,  4 Jul 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaDOtX6S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27E13DDD3;
	Thu,  4 Jul 2024 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073358; cv=none; b=PxhyOu6FHQmQ3Vg0I6QD0zQwsBYzFB0y4KJJKiei+cr8E1ADbx1UpPLy4txnrbFX5f83yXzBQMgVbs9PjYq8VVOtFqL5DcbfpeNIHaen/NHMr1SrUVvdGjrW4ZgK/dxcJpYQJgNMFdewz84pNpCFuXO6f5hjYXima8IKsOs9yLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073358; c=relaxed/simple;
	bh=NAEfW1Rm4pXh5jwCrw8zGZXy9DqVW2BjlR6Z5pMqLvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrpSaPvSrx0mE3vNflmk1HD18UclgI+D6B4LmidV6WQkRjl1X/RvfF0+5F42EN5v2tsppgCH6j67OS8bXYt2nRtXkCV5x6vky8d0/NuJ8gkxmiKiHisGq9PeVhrTHlnPL6aPm//epktHKyTqFG7U5tzGqrOczTeyQ9VrB4m33fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaDOtX6S; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720073356; x=1751609356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NAEfW1Rm4pXh5jwCrw8zGZXy9DqVW2BjlR6Z5pMqLvU=;
  b=YaDOtX6SLMoBqJ3GPCC037u8VFFnxmBH3eHZRHar/laM57HKYBvYnols
   H7WuSOwAbGeqAg74C6qQuy3HhP1xCBpfQnWvUwU2auBRo95YSAk3SMNLj
   3AvQFPuSSZXixJ6/eZXlM9a50h0vR+wEtppm9f0BJg4xGd81WjcA8MBWq
   Yn9pylZCgxopPfxAU8bDYVnVkSK1TDZuZYETA8Jm8ODnE1c2SlPTVx1kL
   kF6E21BcKQKpwXAMDOp5boHlH18BYCI+5nqg2tOxMPE7tKDquNEq3Tzqr
   CV6ySJcL81mYXz5JHIbUt6QdguRnnYvoB1s8+Ux20B6nvFb/7CgdwjfiC
   w==;
X-CSE-ConnectionGUID: Wm5OpH8PTXG5BdHU/wm4UA==
X-CSE-MsgGUID: cBu1RaGkRtayI/QEb6d3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27948465"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27948465"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 23:09:15 -0700
X-CSE-ConnectionGUID: 6SBds+EjSXOqnpNUb1rF6g==
X-CSE-MsgGUID: UrqdOjPiSqmnOb6m2wEKfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47233541"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Jul 2024 23:09:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPFeW-000QdO-0n;
	Thu, 04 Jul 2024 06:09:08 +0000
Date: Thu, 4 Jul 2024 14:08:11 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202407041340.ve4NQPsF-lkp@intel.com>
References: <20240702225845.322234-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702225845.322234-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc6 next-20240703]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240703-163558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240702225845.322234-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v4 3/3] mctp pcc: Implement MCTP over PCC Transport
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240704/202407041340.ve4NQPsF-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041340.ve4NQPsF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041340.ve4NQPsF-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                                   ^
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
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
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
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
   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: declaration of 'struct acpi_pci_root' will not be visible outside of this function [-Wvisibility]
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^
   drivers/net/mctp/mctp-pcc.c:207:19: error: incomplete definition of type 'struct acpi_device'
     207 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |                  ~~~~~~~~^
   include/linux/dev_printk.h:165:18: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                         ^~~
   include/linux/dynamic_debug.h:274:7: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                            ^~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/acpi.h:793:8: note: forward declaration of 'struct acpi_device'
     793 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:208:3: error: call to undeclared function 'acpi_device_hid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     208 |                 acpi_device_hid(acpi_dev));
         |                 ^
   drivers/net/mctp/mctp-pcc.c:208:3: note: did you mean 'acpi_device_dep'?
   include/acpi/acpi_bus.h:41:6: note: 'acpi_device_dep' declared here
      41 | bool acpi_device_dep(acpi_handle target, acpi_handle match);
         |      ^
   drivers/net/mctp/mctp-pcc.c:209:15: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     209 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^
   drivers/net/mctp/mctp-pcc.c:209:13: error: incompatible integer to pointer conversion assigning to 'acpi_handle' (aka 'void *') from 'int' [-Wint-conversion]
     209 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:213:20: error: incomplete definition of type 'struct acpi_device'
     213 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                          ~~~~~~~~^
   include/linux/dev_printk.h:154:44: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/acpi.h:793:8: note: forward declaration of 'struct acpi_device'
     793 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:218:17: error: incomplete definition of type 'struct acpi_device'
     218 |         dev = &acpi_dev->dev;
         |                ~~~~~~~~^
   include/linux/acpi.h:793:8: note: forward declaration of 'struct acpi_device'
     793 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:264:10: error: incomplete definition of type 'struct acpi_device'
     264 |         acpi_dev->driver_data = mctp_pcc_dev;
         |         ~~~~~~~~^
   include/linux/acpi.h:793:8: note: forward declaration of 'struct acpi_device'
     793 | struct acpi_device;
         |        ^
>> drivers/net/mctp/mctp-pcc.c:293:40: error: call to undeclared function 'acpi_driver_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     293 |         struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
         |                                               ^
>> drivers/net/mctp/mctp-pcc.c:293:24: error: incompatible integer to pointer conversion initializing 'struct mctp_pcc_ndev *' with an expression of type 'int' [-Wint-conversion]
     293 |         struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
         |                               ^               ~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:305:27: error: variable has incomplete type 'struct acpi_driver'
     305 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^
   drivers/net/mctp/mctp-pcc.c:305:15: note: forward declaration of 'struct acpi_driver'
     305 | static struct acpi_driver mctp_pcc_driver = {
         |               ^
   drivers/net/mctp/mctp-pcc.c:316:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     316 | module_acpi_driver(mctp_pcc_driver);
         | ^
         | int
   drivers/net/mctp/mctp-pcc.c:316:20: error: a parameter list without types is only allowed in a function definition
     316 | module_acpi_driver(mctp_pcc_driver);
         |                    ^
   8 warnings and 12 errors generated.


vim +/acpi_driver_data +293 drivers/net/mctp/mctp-pcc.c

   290	
   291	static void mctp_pcc_driver_remove(struct acpi_device *adev)
   292	{
 > 293		struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
   294	
   295		pcc_mbox_free_channel(mctp_pcc_ndev->out_chan);
   296		pcc_mbox_free_channel(mctp_pcc_ndev->in_chan);
   297		mctp_unregister_netdev(mctp_pcc_ndev->mdev.dev);
   298	}
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

