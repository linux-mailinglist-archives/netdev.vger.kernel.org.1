Return-Path: <netdev+bounces-236057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69058C381B4
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6D73AF835
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D12701CC;
	Wed,  5 Nov 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhcXv6+U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81D1FDA89;
	Wed,  5 Nov 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379268; cv=none; b=kFbApWZ4WvMtXQ06G+ZTlEUTsJAgV9Pl+HX3ZQ6dg3uTZ3ClGTUH4WnXg9S3kKldn3iBPaTgEZJKq9PLaCgHqRAUFBy0y+W9s6hlTlWSYRqeGOoE8Qpn1OvOlkgsxxFoB7K6vHHNS0chzIzEw1bcF0TGk+kGKMmQ5n9gyWuaLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379268; c=relaxed/simple;
	bh=5xzsc/7T1gL0sCj7nOJv8DaIl+OnW9UaT5raFEotIik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9K0yNVyzugA/ZHWjm7dsy6UhmfEsyGWfJ8gAdsbHJcjxFCuUwavL/tZAZJzScCeUbGjFlkSlXRuIdJ/pvQ/vYmtExNWQ555qUasgdgGOFrjjotvkjleRhXtGJG1QL+BXJ+RM6lvnSJFYBcWdEeIeLqKLPirAnBnFILriSwm1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhcXv6+U; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762379266; x=1793915266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xzsc/7T1gL0sCj7nOJv8DaIl+OnW9UaT5raFEotIik=;
  b=JhcXv6+UssnO/P8ehWbJ3Xmof2zpuyaxXJOHMs2NVRWjT2ocCtKAErp+
   8Lk5rx6GnPSFhLu5sFhOoRC27fZcvkOi3R7y94vJEsnhAhd/PjhkRjl+x
   dWDc7CV0LCIED+ENdBb96mvUbm4hb+BGb6nFkFIeb+VHKXIt3UMWOrrsb
   XfPUIli5FJlWejvsREptMCYNg/V7FrGDcABjHahG1CYMDqu1IOTpAqnDm
   Qi3rRwFT8rmE2ViYTlv1X4jyab33LsZjegj0e8iex4jfjNBViUfqHCFPP
   +WXwifhZp2ajnJAS8qi47ycRGUqpeL/Inubr2Wd4bHI/W8YkqsJSDBIvE
   g==;
X-CSE-ConnectionGUID: mnj/kTeaSjibFHm/P8dmwA==
X-CSE-MsgGUID: Xezk5A2sR7mO0eOqmWKo1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75956035"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75956035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:47:46 -0800
X-CSE-ConnectionGUID: 7giLDUKZQjShi4WYLTI2Tw==
X-CSE-MsgGUID: lJP7Z8i6Qzydv1uaesmqjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="191859112"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 05 Nov 2025 13:47:38 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGlLX-000TA8-1m;
	Wed, 05 Nov 2025 21:47:20 +0000
Date: Thu, 6 Nov 2025 05:47:03 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <acourbot@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 1/3] firmware_loader: make RUST_FW_LOADER_ABSTRACTIONS
 select FW_LOADER
Message-ID: <202511060527.knZk5HZP-lkp@intel.com>
References: <20251105-b4-select-rust-fw-v2-1-156d9014ed3b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-b4-select-rust-fw-v2-1-156d9014ed3b@nvidia.com>

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6553a8f168fb7941ae73d39eccac64f3a2b9b399]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Courbot/firmware_loader-make-RUST_FW_LOADER_ABSTRACTIONS-select-FW_LOADER/20251105-160437
base:   6553a8f168fb7941ae73d39eccac64f3a2b9b399
patch link:    https://lore.kernel.org/r/20251105-b4-select-rust-fw-v2-1-156d9014ed3b%40nvidia.com
patch subject: [PATCH v2 1/3] firmware_loader: make RUST_FW_LOADER_ABSTRACTIONS select FW_LOADER
config: x86_64-kexec (attached as .config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511060527.knZk5HZP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511060527.knZk5HZP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/base/firmware_loader/Kconfig:41: syntax error
   drivers/base/firmware_loader/Kconfig:41: invalid statement
   drivers/base/firmware_loader/Kconfig:42: invalid statement
   drivers/base/firmware_loader/Kconfig:43:warning: ignoring unsupported character '.'
   drivers/base/firmware_loader/Kconfig:43: unknown statement "This"
   make[3]: *** [scripts/kconfig/Makefile:85: oldconfig] Error 1
   make[2]: *** [Makefile:742: oldconfig] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> drivers/base/firmware_loader/Kconfig:41: syntax error
   drivers/base/firmware_loader/Kconfig:41: invalid statement
   drivers/base/firmware_loader/Kconfig:42: invalid statement
   drivers/base/firmware_loader/Kconfig:43:warning: ignoring unsupported character '.'
   drivers/base/firmware_loader/Kconfig:43: unknown statement "This"
   make[3]: *** [scripts/kconfig/Makefile:85: olddefconfig] Error 1
   make[2]: *** [Makefile:742: olddefconfig] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +41 drivers/base/firmware_loader/Kconfig

     3	
     4	config FW_LOADER
     5		tristate "Firmware loading facility" if EXPERT
     6		select CRYPTO_LIB_SHA256 if FW_LOADER_DEBUG
     7		default y
     8		help
     9		  This enables the firmware loading facility in the kernel. The kernel
    10		  will first look for built-in firmware, if it has any. Next, it will
    11		  look for the requested firmware in a series of filesystem paths:
    12	
    13			o firmware_class path module parameter or kernel boot param
    14			o /lib/firmware/updates/UTS_RELEASE
    15			o /lib/firmware/updates
    16			o /lib/firmware/UTS_RELEASE
    17			o /lib/firmware
    18	
    19		  Enabling this feature only increases your kernel image by about
    20		  828 bytes, enable this option unless you are certain you don't
    21		  need firmware.
    22	
    23		  You typically want this built-in (=y) but you can also enable this
    24		  as a module, in which case the firmware_class module will be built.
    25		  You also want to be sure to enable this built-in if you are going to
    26		  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
    27	
    28	config FW_LOADER_DEBUG
    29		bool "Log filenames and checksums for loaded firmware"
    30		depends on DYNAMIC_DEBUG
    31		depends on FW_LOADER
    32		default FW_LOADER
    33		help
    34		  Select this option to use dynamic debug to log firmware filenames and
    35		  SHA256 checksums to the kernel log for each firmware file that is
    36		  loaded.
    37	
    38	config RUST_FW_LOADER_ABSTRACTIONS
    39		bool "Rust Firmware Loader abstractions"
    40		depends on RUST
  > 41		select FW_LOADER=y
    42		help
    43		  This enables the Rust abstractions for the firmware loader API.
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

