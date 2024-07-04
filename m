Return-Path: <netdev+bounces-109109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DB926F6A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D302285581
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BC18734F;
	Thu,  4 Jul 2024 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hrm0GMwA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9D2F23
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073976; cv=none; b=sYcP29AEq9UftLNOkfSrTCMRge1wTjQdQyig0ew9e6yMnX4FRAYFpbWnSWK4mkMJ9T2MykBI81q12JnPgfkcj+dsVkZtLZpofiZ7I3tFifGstGtQ8IXBN1fu7MQAx90grIHnpmeWnh3I/TubsKZONXjG4SjoTnefDYu2zCVKyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073976; c=relaxed/simple;
	bh=n599YyiBzcuIVivX5G6Y1X7+Zo4TTWGDliVbSSYz4bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5SPQNiB8sP4z0tne9Kz4K/FLH2fns1pJ8O/bEnCNgcdka1uKWS5UOzpSq6OXt2OzLXbUF0dr4NefIeNmRv1M+EP/M6T329nK5IAIo7nSw6RbASMPVBuok3x+niPVxVwozuRKaXlVFyNTF9TIyITEt9X/bblQYZ8DqG80SZPQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hrm0GMwA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720073975; x=1751609975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n599YyiBzcuIVivX5G6Y1X7+Zo4TTWGDliVbSSYz4bQ=;
  b=Hrm0GMwAW90ioNAMQ0W/OJtboFpKIKxx0WLhh5IuElyvzDnew38cDHK8
   /QkEFej4Ox5A+30ToL/cWYSR992Ox7Ea4wvJZlVdBCSOtZKzUmvTPlGDB
   C8slxqVwEzYZZ9mALYAHNdhFgKAAVb9kfSDbfcfjZi5tl2wV95Mf+jbSK
   ZVar1frahHKmMIJJA9NnqlnCx2Khss1j3vjMU+Ilo8z6unv4bAmKWQn8C
   JMDm1bv2GRuKqje4muYeKu4Miy4/3cjtBkr4nmqL2ZL01KtwwbgjdKsTw
   l3HzYxHfJ3NGhxsf93J5pQ/tVTW4C6d3k1FTsp1f2ImGWJvlCQurMK56V
   g==;
X-CSE-ConnectionGUID: egh3vyC4SueJcRxtYIV39g==
X-CSE-MsgGUID: u3HeHncxRcOBE6PD41ob1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21141511"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21141511"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 23:19:34 -0700
X-CSE-ConnectionGUID: jBocotyIQDS4vQ3k6T6a7w==
X-CSE-MsgGUID: P+foD2HiQma0n36JDArkpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46380950"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Jul 2024 23:19:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPFoX-000Qe6-32;
	Thu, 04 Jul 2024 06:19:29 +0000
Date: Thu, 4 Jul 2024 14:19:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	ecree.xilinx@gmail.com, michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to
 .create_rxfh_context and friends
Message-ID: <202407041406.1dVK7Qf1-lkp@intel.com>
References: <20240702234757.4188344-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702234757.4188344-6-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/net-ethtool-let-drivers-remove-lost-RSS-contexts/20240703-163816
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240702234757.4188344-6-kuba%40kernel.org
patch subject: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
config: i386-randconfig-014-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041406.1dVK7Qf1-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041406.1dVK7Qf1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041406.1dVK7Qf1-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dynamic_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bitmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_uuid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_xarray.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_blackhole_dev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_meminit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_free_pages.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ts_kmp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ts_bm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ts_fsm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08_i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/rt4831-backlight.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/da9121-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/tps6286x-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_hdlc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_gsm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/ttynull.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/amd-k7-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/amd64-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/sis-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spmi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/brd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/rt4831.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_pmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_btt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/dax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/class/usbtmc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/isight_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/yurex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/matrix-keymap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ccgx-ucsi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ali1563.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-pxa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/i2c/uda1342.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/usb/dvb-usb/dvb-usb-dibusb-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/usb/dvb-usb/dvb-usb-dibusb-mc-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/usb/go7007/go7007.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/au8522_decoder.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/mb86a16.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/radio/si470x/radio-si470x-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/watchdog/simatic-ipc-wdt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/cpufreq-dt-platdev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds-rt4505.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds-gpio-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/coreboot_table.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole-coreboot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/vpd-sysfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/atmel-sha204a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-aureal.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cypress.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-elecom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-evision.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ezkey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gyration.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lenovo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-logitech-dj.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-magicmouse.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-megaworld.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ntrig.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-primax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-redragon.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-retrode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-samsung.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-topseed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-viewsonic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_cif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/yc/snd-soc-acp6x-mach.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/renoir/snd-acp3x-rn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mtty.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mdpy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/configfs/configfs_sample.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kprobes/kprobe_example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kprobes/kretprobe_example.o
>> ERROR: modpost: "ethtool_rxfh_context_lost" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

