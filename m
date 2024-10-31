Return-Path: <netdev+bounces-140685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B169B79A3
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915AF285915
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC819AD48;
	Thu, 31 Oct 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiUgBhw3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7419ABD1;
	Thu, 31 Oct 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373979; cv=none; b=qavmd/O1lg/6/uWWBYPETBuFDGBE49DMgwcQqSCyRezt1BF9oktTYbfMkuuYKk7MLCDNhOuwjXqJXo/MgZ0HH8cvfkleLnxnGq1LxZpbe4ZV7BSFSyOZgjHiQnJ4dPbqOh6HkDe844ov6hOXXIH08TOooWl7bwBGpMC+KSd0YbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373979; c=relaxed/simple;
	bh=FZaF07BqbUXFKIQWzJ0TU3EcSeo0yKzBzuIl6EKAvrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fooar5s1d0VNYZODf2vAAoQtt7N+zgCq6G2xmEK5BSYQ/DS0IzJknXbXtSRSZGBmQOiS5Dlm4CKgs+m+XZfOwN5FWnJhbzsyn6k30jfkozxhbsvrsuXS3/bWxvMbGElDObZygLB5CGxH9R4P471uEc88sw7A/3N4QNytoNgjw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiUgBhw3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730373975; x=1761909975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZaF07BqbUXFKIQWzJ0TU3EcSeo0yKzBzuIl6EKAvrQ=;
  b=BiUgBhw39cN1rh71Fn8BRyCzTJ1o9rA2Pyp4C6wJfPyHtHX7iszjqjCz
   N7sWFCMUw6xyJUdP6NpELvFKR7wTKT4wBrKsPHSjBOCc8NvR8XI0Qb+LH
   ThpgmIWLmAMhZgxXWFc1cwGhKBQuiP8dHn7IKYsRXHScyoAjKGWe8vrGv
   TKB/0NeJ5Lcn/22ucjxJ2ZV1QSg/Gu9qIa4fxt/eatatTN71IBWiYLUDe
   6VxAmbIHuinVAVUq0RQcAPG/xzTZ25HWAkavRMMTkpkv1ajwHZ3xxkHoV
   B6yb4skYkH3Wt/JyBVhpVE7BI6Nzy73qcourX7akgWcXcjuOviDkiJe+O
   Q==;
X-CSE-ConnectionGUID: xUqYToaGRYuwRaFa2MUaQw==
X-CSE-MsgGUID: FzUNkefNS9ekeqeNF1nDwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="34036214"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="34036214"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 04:26:14 -0700
X-CSE-ConnectionGUID: fw2R9d8gRBO3LJO2GacbxA==
X-CSE-MsgGUID: GgIiFhr4SeKC1qpk8kHmIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87742985"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Oct 2024 04:26:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6TJY-000g2a-1m;
	Thu, 31 Oct 2024 11:26:08 +0000
Date: Thu, 31 Oct 2024 19:26:01 +0800
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
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202410311922.C37GzI3p-lkp@intel.com>
References: <20241029165414.58746-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029165414.58746-3-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.12-rc5 next-20241031]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241030-005644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241029165414.58746-3-admiyo%40os.amperecomputing.com
patch subject: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241031/202410311922.C37GzI3p-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311922.C37GzI3p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311922.C37GzI3p-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:21:
>> include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
>> drivers/net/mctp/mctp-pcc.c:237:39: error: invalid use of undefined type 'struct acpi_device'
     237 |         struct device *dev = &acpi_dev->dev;
         |                                       ^~
   In file included from include/linux/printk.h:599,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/net/mctp/mctp-pcc.c:11:
>> drivers/net/mctp/mctp-pcc.c:246:17: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Wimplicit-function-declaration]
     246 |                 acpi_device_hid(acpi_dev));
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
   drivers/net/mctp/mctp-pcc.c:245:9: note: in expansion of macro 'dev_dbg'
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
>> drivers/net/mctp/mctp-pcc.c:245:22: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'int' [-Wformat=]
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:245:9: note: in expansion of macro 'dev_dbg'
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:245:56: note: format string is defined here
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |                                                       ~^
         |                                                        |
         |                                                        char *
         |                                                       %d
>> drivers/net/mctp/mctp-pcc.c:247:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Wimplicit-function-declaration]
     247 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
>> drivers/net/mctp/mctp-pcc.c:247:20: error: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     247 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^
   drivers/net/mctp/mctp-pcc.c:290:17: error: invalid use of undefined type 'struct acpi_device'
     290 |         acpi_dev->driver_data = mctp_pcc_ndev;
         |                 ^~
   drivers/net/mctp/mctp-pcc.c: At top level:
>> drivers/net/mctp/mctp-pcc.c:317:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     317 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:318:10: error: 'struct acpi_driver' has no member named 'name'
     318 |         .name = "mctp_pcc",
         |          ^~~~
>> drivers/net/mctp/mctp-pcc.c:318:17: warning: excess elements in struct initializer
     318 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:318:17: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:319:10: error: 'struct acpi_driver' has no member named 'class'
     319 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:319:18: warning: excess elements in struct initializer
     319 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:319:18: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:320:10: error: 'struct acpi_driver' has no member named 'ids'
     320 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:320:16: warning: excess elements in struct initializer
     320 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:320:16: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:321:10: error: 'struct acpi_driver' has no member named 'ops'
     321 |         .ops = {
         |          ^~~
>> drivers/net/mctp/mctp-pcc.c:321:16: error: extra brace group at end of initializer
     321 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:321:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:321:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:321:16: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:326:1: warning: data definition has no type or storage class
     326 | module_acpi_driver(mctp_pcc_driver);
         | ^~~~~~~~~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:326:1: error: type defaults to 'int' in declaration of 'module_acpi_driver' [-Wimplicit-int]
>> drivers/net/mctp/mctp-pcc.c:326:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>> drivers/net/mctp/mctp-pcc.c:317:27: error: storage size of 'mctp_pcc_driver' isn't known
     317 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:317:27: warning: 'mctp_pcc_driver' defined but not used [-Wunused-variable]

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +237 drivers/net/mctp/mctp-pcc.c

   231	
   232	static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
   233	{
   234		struct mctp_pcc_lookup_context context = {0, 0, 0};
   235		struct mctp_pcc_hw_addr mctp_pcc_hw_addr;
   236		struct mctp_pcc_ndev *mctp_pcc_ndev;
 > 237		struct device *dev = &acpi_dev->dev;
   238		struct net_device *ndev;
   239		acpi_handle dev_handle;
   240		acpi_status status;
   241		int mctp_pcc_mtu;
   242		char name[32];
   243		int rc;
   244	
 > 245		dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
 > 246			acpi_device_hid(acpi_dev));
 > 247		dev_handle = acpi_device_handle(acpi_dev);
   248		status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
   249					     &context);
   250		if (!ACPI_SUCCESS(status)) {
   251			dev_err(dev, "FAILURE to lookup PCC indexes from CRS");
   252			return -EINVAL;
   253		}
   254	
   255		//inbox initialization
   256		snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
   257		ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
   258				    mctp_pcc_setup);
   259		if (!ndev)
   260			return -ENOMEM;
   261	
   262		mctp_pcc_ndev = netdev_priv(ndev);
   263		rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
   264		if (rc)
   265			goto cleanup_netdev;
   266		spin_lock_init(&mctp_pcc_ndev->lock);
   267	
   268		rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
   269						 context.inbox_index);
   270		if (rc)
   271			goto cleanup_netdev;
   272		mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
   273	
   274		//outbox initialization
   275		rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
   276						 context.outbox_index);
   277		if (rc)
   278			goto cleanup_netdev;
   279	
   280		mctp_pcc_hw_addr.parent_id = cpu_to_be32(0);
   281		mctp_pcc_hw_addr.inbox_id = cpu_to_be16(context.inbox_index);
   282		mctp_pcc_hw_addr.outbox_id = cpu_to_be16(context.outbox_index);
   283		ndev->addr_len = sizeof(mctp_pcc_hw_addr);
   284		dev_addr_set(ndev, (const u8 *)&mctp_pcc_hw_addr);
   285	
   286		mctp_pcc_ndev->acpi_device = acpi_dev;
   287		mctp_pcc_ndev->inbox.client.dev = dev;
   288		mctp_pcc_ndev->outbox.client.dev = dev;
   289		mctp_pcc_ndev->mdev.dev = ndev;
 > 290		acpi_dev->driver_data = mctp_pcc_ndev;
   291	
   292		/* There is no clean way to pass the MTU to the callback function
   293		 * used for registration, so set the values ahead of time.
   294		 */
   295		mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
   296			sizeof(struct mctp_pcc_hdr);
   297		ndev->mtu = MCTP_MIN_MTU;
   298		ndev->max_mtu = mctp_pcc_mtu;
   299		ndev->min_mtu = MCTP_MIN_MTU;
   300	
   301		/* ndev needs to be freed before the iomemory (mapped above) gets
   302		 * unmapped,  devm resources get freed in reverse to the order they
   303		 * are added.
   304		 */
   305		rc = register_netdev(ndev);
   306		return rc;
   307	cleanup_netdev:
   308		free_netdev(ndev);
   309		return rc;
   310	}
   311	
   312	static const struct acpi_device_id mctp_pcc_device_ids[] = {
   313		{ "DMT0001"},
   314		{}
   315	};
   316	
 > 317	static struct acpi_driver mctp_pcc_driver = {
 > 318		.name = "mctp_pcc",
 > 319		.class = "Unknown",
 > 320		.ids = mctp_pcc_device_ids,
 > 321		.ops = {
   322			.add = mctp_pcc_driver_add,
   323		},
   324	};
   325	
 > 326	module_acpi_driver(mctp_pcc_driver);
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

