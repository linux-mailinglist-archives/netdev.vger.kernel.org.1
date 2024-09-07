Return-Path: <netdev+bounces-126260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137F97040D
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5461B23666
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4C166F37;
	Sat,  7 Sep 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Roh6+gcA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509A166317;
	Sat,  7 Sep 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725740800; cv=none; b=R4za7xATeCS+TahsuMKuXCQoxR3653TzV4L+97knvzw2nlEOkPUUWtxxC3JTX7Umi25gejNBuz6N2AiN40Q4cbK2zSHConw02SV5c3MHtxAUUX5IDA9BawqxqwHxpxpkZEanrHhsE5o/BLqyfTwH8JjW0dnRG/e35gDbB/3Lle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725740800; c=relaxed/simple;
	bh=fMa7zk8F941GU/2okPN/spWK9VAcgdf8B/UpfGouItk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejFqNw0oX/IXyg3dCKw3uhJnqECv5ZGUv5LBhMY3a2y9y8kxa45F1OmPJmfuIpITT3EBIPTSxyVswrqnAI5FWRSj0KaUeSheRPosP0097I+ZAq7YzIwmvW7PN0TWiNWdr01Se5l2/djTgj4osCBRmwBJX1eQebuQJ0fCJR2IDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Roh6+gcA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725740798; x=1757276798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fMa7zk8F941GU/2okPN/spWK9VAcgdf8B/UpfGouItk=;
  b=Roh6+gcAn+cttmAmtFWt14htw4me8UNGXsJTfR2waIGCEhJcu0rxYHKL
   ol9Pb25xsYRQZN8hkHlkfsZkG1gqlWZAI/bSEmhWZDE3Ed+AsXD/6O/d+
   X+9A/twjUHEzR7A1RoHezDejB/P1C71OLT208FMhGNYIGfAxLLrul5ow9
   IQ3dWk6oUqPSGqF959Mc4+2J47TESMGSdf36R3aC02IRvS8EZ5hbGHNho
   30uzwfcVfZlomSEWEZMvR1vLQlRgt6mkVQoVrXQwlydULOR86RqritqDv
   h0ASj4vh0HK6D21eH98m0L9dkN7yDOR7kOkHeol8isVxBXhL8SuDP6w1T
   A==;
X-CSE-ConnectionGUID: aF0fpPoSTPSAWN/SGvAEPQ==
X-CSE-MsgGUID: To1cfAG5T5G2KHVsE/jjEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24668280"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24668280"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 13:26:37 -0700
X-CSE-ConnectionGUID: u/Fz9l78RMS/Sjhs9hFhKw==
X-CSE-MsgGUID: ShqGrfHxRx6e2fErV5C5Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70677102"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2024 13:26:35 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn20u-000Cyl-1E;
	Sat, 07 Sep 2024 20:26:32 +0000
Date: Sun, 8 Sep 2024 04:26:30 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Message-ID: <202409080455.S5Uvi35I-lkp@intel.com>
References: <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907081836.5801-2-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v6.11-rc6 next-20240906]
[cannot apply to cxl/pending horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20240907-162231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240907081836.5801-2-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v3 01/20] cxl: add type2 device basic support
config: mips-ip27_defconfig (https://download.01.org/0day-ci/archive/20240908/202409080455.S5Uvi35I-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080455.S5Uvi35I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080455.S5Uvi35I-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/cast_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libarc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_deflate/zlib_deflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/mfd-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_aec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ali1563.o
>> ERROR: modpost: "cxl_accel_state_create" [drivers/net/ethernet/sfc/sfc.ko] undefined!
>> ERROR: modpost: "cxl_set_serial" [drivers/net/ethernet/sfc/sfc.ko] undefined!
ERROR: modpost: "cxl_set_resource" [drivers/net/ethernet/sfc/sfc.ko] undefined!
ERROR: modpost: "cxl_set_dvsec" [drivers/net/ethernet/sfc/sfc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

