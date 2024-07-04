Return-Path: <netdev+bounces-109106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A3926EFC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB823284E0C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 05:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61131A01B6;
	Thu,  4 Jul 2024 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTdhMVPx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88635FBF6;
	Thu,  4 Jul 2024 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071892; cv=none; b=lA2f/XnCfJAqRJWUDd8kxsWFN9gFmk4l0xGiKGJYh2NqdhtvOjxvA9fYxQILkDnKCsGBCxOzy+Jsen4YBgrWyI/V+/ru0pspVpf9ycI8fjULx0GBhRfgcTQWrtpcZolUAFsdRQdNgF3akvlTIyoi3+jBl5OWx6kxa3J9u/VEwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071892; c=relaxed/simple;
	bh=G1WNzHX80B6ZKYD01BL36u/3JzQG51AN0hYgbjiRbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IohU1kxkaFYq/d0y6vMAJo1icyhB19q04b5QWIfAMf1LvHJ3yXNuGZxcXb2dRx1WaGaPkEopzDpIH+xDw3A46SHwdxEmDFGJyoB3x+1OaoohsvH7YvIG9cjjYMtiDx05K706/qUFnZev98a8UvkRCXi09b/g2sYidJB7hD/pXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTdhMVPx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720071891; x=1751607891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1WNzHX80B6ZKYD01BL36u/3JzQG51AN0hYgbjiRbeU=;
  b=VTdhMVPxNRkD+vvWuHuu1+p4coRRu4XOip0nlkGXftWyxwkkWltcVQjm
   qXWta/h4WcnMgYTxyYkbrw7vzDeLZ+ZskSyDTgRS4Hh5ryNhE8EOeW87p
   q43pMAXAiiYhyuRO+DqJN2TDNFGKLF9tzAXT5F+rKRfNppiMSy5c3mzgc
   5/PtNXT++h2GgeeHvHX6qABfTN0G18iLzEjNXDN5gan5giO3PsekwGMH0
   6lM8/4+sfGjZdFPP6iJD2ndC8tpxlV/LedizMnqShy9cmRRm0jRUjEYVm
   +NG9/vgXpVIUFepkmGoabjcIKB653VX5tN6vGr1pLfP2uYKWaAci86UzS
   A==;
X-CSE-ConnectionGUID: IESK8mlJT2yq0qvCN9qtSA==
X-CSE-MsgGUID: 1oHcNQwWQGK/QjCIlfNlYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17197686"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17197686"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 22:44:50 -0700
X-CSE-ConnectionGUID: xRx0A1yvSUeQRVUQ+7BoRA==
X-CSE-MsgGUID: mZdgxAyuScCYaSFoH81emw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46628159"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Jul 2024 22:44:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPFGt-000QcD-27;
	Thu, 04 Jul 2024 05:44:43 +0000
Date: Thu, 4 Jul 2024 13:43:50 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202407041311.rvCLf6kZ-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240704/202407041311.rvCLf6kZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041311.rvCLf6kZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041311.rvCLf6kZ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   In file included from include/linux/printk.h:570,
                    from include/asm-generic/bug.h:22,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sh/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/net/mctp/mctp-pcc.c:7:
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
   drivers/net/mctp/mctp-pcc.c:207:26: error: invalid use of undefined type 'struct acpi_device'
     207 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |                          ^~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:207:9: note: in expansion of macro 'dev_dbg'
     207 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:208:17: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     208 |                 acpi_device_hid(acpi_dev));
         |                 ^~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:207:9: note: in expansion of macro 'dev_dbg'
     207 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:209:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     209 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
   drivers/net/mctp/mctp-pcc.c:209:20: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     209 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14:
   drivers/net/mctp/mctp-pcc.c:213:34: error: invalid use of undefined type 'struct acpi_device'
     213 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                                  ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:213:17: note: in expansion of macro 'dev_err'
     213 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                 ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:218:24: error: invalid use of undefined type 'struct acpi_device'
     218 |         dev = &acpi_dev->dev;
         |                        ^~
   drivers/net/mctp/mctp-pcc.c:264:17: error: invalid use of undefined type 'struct acpi_device'
     264 |         acpi_dev->driver_data = mctp_pcc_dev;
         |                 ^~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_remove':
>> drivers/net/mctp/mctp-pcc.c:293:47: error: implicit declaration of function 'acpi_driver_data'; did you mean 'acpi_get_data'? [-Werror=implicit-function-declaration]
     293 |         struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
         |                                               ^~~~~~~~~~~~~~~~
         |                                               acpi_get_data
>> drivers/net/mctp/mctp-pcc.c:293:47: warning: initialization of 'struct mctp_pcc_ndev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:305:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     305 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:306:10: error: 'struct acpi_driver' has no member named 'name'
     306 |         .name = "mctp_pcc",
         |          ^~~~
   drivers/net/mctp/mctp-pcc.c:306:17: warning: excess elements in struct initializer
     306 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:306:17: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:307:10: error: 'struct acpi_driver' has no member named 'class'
     307 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:307:18: warning: excess elements in struct initializer
     307 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:307:18: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:308:10: error: 'struct acpi_driver' has no member named 'ids'
     308 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:308:16: warning: excess elements in struct initializer
     308 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:308:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:309:10: error: 'struct acpi_driver' has no member named 'ops'
     309 |         .ops = {
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:309:16: error: extra brace group at end of initializer
     309 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:309:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:309:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:309:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:313:10: error: 'struct acpi_driver' has no member named 'owner'
     313 |         .owner = THIS_MODULE,
         |          ^~~~~
   In file included from arch/sh/include/asm/cache.h:12,
                    from include/linux/cache.h:6,
                    from include/linux/slab.h:15:
   include/linux/init.h:180:21: warning: excess elements in struct initializer
     180 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:313:18: note: in expansion of macro 'THIS_MODULE'
     313 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:180:21: note: (near initialization for 'mctp_pcc_driver')
     180 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:313:18: note: in expansion of macro 'THIS_MODULE'
     313 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:316:1: warning: data definition has no type or storage class
     316 | module_acpi_driver(mctp_pcc_driver);
         | ^~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:316:1: error: type defaults to 'int' in declaration of 'module_acpi_driver' [-Werror=implicit-int]
   drivers/net/mctp/mctp-pcc.c:316:1: warning: parameter names (without types) in function declaration
   drivers/net/mctp/mctp-pcc.c:305:27: error: storage size of 'mctp_pcc_driver' isn't known
     305 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:305:27: warning: 'mctp_pcc_driver' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +293 drivers/net/mctp/mctp-pcc.c

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

