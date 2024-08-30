Return-Path: <netdev+bounces-123704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6EA9663A0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF7B1F23815
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728A1A2857;
	Fri, 30 Aug 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ND2xRNv8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A81A4AB5;
	Fri, 30 Aug 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026659; cv=none; b=nGdjx/FuBKLfrkjHYtWBP2yhumqHCzJ5C19z6EVf6mK8rc8/DhFX5yiRtKTy88gmxsSklKSn4TFc6FhkSS0Nj5MqoDXR9LcS/C9Xx0fuPjqSMGXO5VBpn1ptnrhcMoxUxfayd/e8aPtRD87mSgX2QTYERPiWtD7NNaHweAjum6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026659; c=relaxed/simple;
	bh=5teBPgWMQMFVr/5PiCwOa6ly1sGzvaFc/kjjEHBv/Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkGEO96koCUIDcLmz8yQU6rUthY+nCJISbn6v1nsf/wOHQIa9xcuWs49x6vyYZ/OoL7JPjBXEiJ1h67IgCrd9YCQOYxQKLv5b8tNd5YqPkBtIpil0EvWuDm7M3Ss9I0SxvKEGwXTzL/taMou9bi77P9g4r2S8XT0/7JHnQpzSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ND2xRNv8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725026657; x=1756562657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5teBPgWMQMFVr/5PiCwOa6ly1sGzvaFc/kjjEHBv/Y8=;
  b=ND2xRNv83oEAtdfPkbTuN7ON5FolOFp3jnHRL3H/WMbPSgDIohMCsUQY
   ZBZ5FDIrylnZL8GhTiLTcH91eYbUyWDrT53ZaZ1Xtf89YWFN9jXRPAaTX
   4CQYJxRXa83PUPGTWiH5lADyFzDLh12wgSEblfbjUDilEKbQ52jbFz6tn
   PfTjLwNoBDtlXPn0Q5U0X1nF7n4C2CFYvn9rGIQRxNYrXcsHhUyhT7eSR
   X7STFd5f36rmVzJhOtFkb8zt5ExG8+cvV615sBwJ+pDTcksj8oBiOBAF3
   9waLk4d523F9kgJ8wQ2f1ZFUMAOoVwBpX+KVN/Ce3V92bujUZ5zno241n
   A==;
X-CSE-ConnectionGUID: wPuhxycRSJexmzPhpUTuyA==
X-CSE-MsgGUID: VyL0EhLURxmPOFqFC5qV3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23549747"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23549747"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:04:16 -0700
X-CSE-ConnectionGUID: rnADDRIVR9SQ6y3xpFkmxw==
X-CSE-MsgGUID: jpMlKVNFQcOXdF1O6ybyPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68722895"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Aug 2024 07:04:12 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk2ET-0001WY-1D;
	Fri, 30 Aug 2024 14:04:09 +0000
Date: Fri, 30 Aug 2024 22:03:18 +0800
From: kernel test robot <lkp@intel.com>
To: Ayush Singh <ayush@beagleboard.org>, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH v3 3/3] greybus: gb-beagleplay: Add firmware upload API
Message-ID: <202408302019.XfDrLOk7-lkp@intel.com>
References: <20240825-beagleplay_fw_upgrade-v3-3-8f424a9de9f6@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825-beagleplay_fw_upgrade-v3-3-8f424a9de9f6@beagleboard.org>

Hi Ayush,

kernel test robot noticed the following build errors:

[auto build test ERROR on f76698bd9a8ca01d3581236082d786e9a6b72bb7]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/dt-bindings-net-ti-cc1352p7-Add-bootloader-backdoor-gpios/20240826-165903
base:   f76698bd9a8ca01d3581236082d786e9a6b72bb7
patch link:    https://lore.kernel.org/r/20240825-beagleplay_fw_upgrade-v3-3-8f424a9de9f6%40beagleboard.org
patch subject: [PATCH v3 3/3] greybus: gb-beagleplay: Add firmware upload API
config: sh-randconfig-001-20240830 (https://download.01.org/0day-ci/archive/20240830/202408302019.XfDrLOk7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302019.XfDrLOk7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408302019.XfDrLOk7-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/greybus/gb-beagleplay.o: in function `gb_beagleplay_remove':
>> gb-beagleplay.c:(.text+0xec8): undefined reference to `firmware_upload_unregister'
   sh4-linux-ld: drivers/greybus/gb-beagleplay.o: in function `gb_beagleplay_probe':
>> gb-beagleplay.c:(.text+0x1128): undefined reference to `firmware_upload_register'
>> sh4-linux-ld: gb-beagleplay.c:(.text+0x1138): undefined reference to `firmware_upload_unregister'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FW_UPLOAD
   Depends on [n]: FW_LOADER [=n]
   Selected by [y]:
   - GREYBUS_BEAGLEPLAY [=y] && GREYBUS [=y] && SERIAL_DEV_BUS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

