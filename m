Return-Path: <netdev+bounces-191026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AAAB9B8E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DFF17074E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B723909F;
	Fri, 16 May 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnlGIgMI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3212376EB
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396666; cv=none; b=Tmt8KEk89iCltzfeRB0mB4Bc+xCQiv17Knt9DAq4sWSdqqaSrKB/cCHvzKMS3Ofs7mndIwegY6IyqDfQJkIJo+sf8pahcjo5151v96KPRsZl4ae3l5egOiktlqYgvkuQjcgCm/vr3wHAem3l1lg/10VSp5/vRNbwfRqsxzMO8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396666; c=relaxed/simple;
	bh=zas5qRvLzeVSRNH8Gf3aeHid+8WKUrrNydSDBKWaLx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd80yJXYhcwcS4NHUojdPahQ43+Ln+W1cP7PtNf/GsNUjttPFx5TcVC47yYWXyZXgnf2MoiuBHfGAkIRXAUBm+6fsK+RorMxh+IQnUWuvVFIG6N86VmQGZ0/4pg6lw5if+xddaKzoKYF5ExLaN858AxOZr927WllmUuVUaIAxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnlGIgMI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747396666; x=1778932666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zas5qRvLzeVSRNH8Gf3aeHid+8WKUrrNydSDBKWaLx8=;
  b=CnlGIgMIvKZv+IrJeev1Z0yJ06d9toUzUevqQvDYyYwz1XyzUiYK/LK5
   6HU4KJUx0RMrQq7dWygTQJnNr1QofmhITLlrQ3fVsSSe0NYrWEAmH2Cdj
   HRKOaSAH/3AOHAPcEzcH6EpWtlUZXfH10XbknmxzNGCkAtWtt2ZWbHA2n
   1yQKibGqqFuUsgqgSMl7uMJQgvdA7yBYDcIJ9y8vOAKX4o/o5us93Z9Os
   NpcqMMutV/p0RuohU4GEnMOI5JlaGjyyIcx+idE7fU8x+LsFbhX0RGVii
   dTqQ7HQA0nndId612klhWv6tGwfyC6XL56i+GC+yV6WnMSGGUCrHFMT28
   w==;
X-CSE-ConnectionGUID: TabgDcVFR3OSvaDsF2c0NA==
X-CSE-MsgGUID: wsAXeaU0TbmJLeUNsuQyYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53038199"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53038199"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 04:57:45 -0700
X-CSE-ConnectionGUID: psRhwjvHQoO3hIq4z3kOiw==
X-CSE-MsgGUID: bzsxGEAzSnO4N/caoHzEyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143563541"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 May 2025 04:57:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFth1-000JJX-26;
	Fri, 16 May 2025 11:57:35 +0000
Date: Fri, 16 May 2025 19:56:59 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
Message-ID: <202505161944.2x21wbM5-lkp@intel.com>
References: <20250515112721.19323-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515112721.19323-8-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-pass-PHY-driver-to-match_phy_device-OP/20250515-193151
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250515112721.19323-8-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v10 7/7] rust: net::phy sync with match_phy_device C changes
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250516/202505161944.2x21wbM5-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250516/202505161944.2x21wbM5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505161944.2x21wbM5-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS= -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/net/phy.rs at line 422:
        //  `phy_driver`.
        unsafe extern "C" fn match_phy_device_callback(
            phydev: *mut bindings::phy_device,
   -        phydrv: *const bindings::phy_driver
   +        phydrv: *const bindings::phy_driver,
        ) -> crate::ffi::c_int {
            // SAFETY: This callback is called only in contexts
            // where we hold `phy_device->lock`, so the accessors on
>> Diff in rust/kernel/net/phy.rs at line 422:
        //  `phy_driver`.
        unsafe extern "C" fn match_phy_device_callback(
            phydev: *mut bindings::phy_device,
   -        phydrv: *const bindings::phy_driver
   +        phydrv: *const bindings::phy_driver,
        ) -> crate::ffi::c_int {
            // SAFETY: This callback is called only in contexts
            // where we hold `phy_device->lock`, so the accessors on
>> Diff in rust/kernel/net/phy.rs at line 422:
        //  `phy_driver`.
        unsafe extern "C" fn match_phy_device_callback(
            phydev: *mut bindings::phy_device,
   -        phydrv: *const bindings::phy_driver
   +        phydrv: *const bindings::phy_driver,
        ) -> crate::ffi::c_int {
            // SAFETY: This callback is called only in contexts
            // where we hold `phy_device->lock`, so the accessors on
   make[2]: *** [Makefile:1826: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

