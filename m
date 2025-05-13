Return-Path: <netdev+bounces-189985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816ABAB4BBB
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5273ADACA
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D491E98EB;
	Tue, 13 May 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb7ReHc2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6371E8333;
	Tue, 13 May 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116624; cv=none; b=KfE29QciVSpSE5SeWodowFarIipTsdsfUddLHIsF1bdkEOdJ8nM7umPDwzShUkYQdZou3sAZV/7an6bKHV2ShJp3WA6m+Y1EhPUDYcyFKULkNwg95mmvZtDX4vmr9FUQFNOREEb/Hn/CNmz00aKMcES5sWaDEP1zb8RiDbguKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116624; c=relaxed/simple;
	bh=QF7NoVWs9s4mtxHSKnQEUbnugHIa6+FV/FaaMB1Fj+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLc87+sdNWqFq92CVk91Z+LqnRpQgIPX+OCZGZO5RJGrx0nNN50Rfs/CtAu6YkJflABry4eD/9DzJ4igILzkYrdzpeDmKSyKbJM83HB4IgkNErxQoWFEZB+JPIyljt75+5Dy5ZPaZUbVTJ61ggrwBBOd91NGQ9eHFzPgPmcIAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb7ReHc2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747116623; x=1778652623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QF7NoVWs9s4mtxHSKnQEUbnugHIa6+FV/FaaMB1Fj+4=;
  b=Tb7ReHc2J8PAVJsUHxiZEmNSSEqgVFQaCoHfpxEIo59dZOnd1HaY65af
   jF83G41yT4t9LPjYHtkidn5NAh3SmmXIGag6lqrLzcgUWySDGFszc2LR3
   Fy6ta6shhZOW/QBGryBcLu8CxclENyj3AeLlvO/A5Y735GXDnuNA1fo1D
   TkZe8NkxhLB8ybIAXlJKHIy//k6mBGbBa7nLALbjagv6z3BJdrGAO9hy7
   tbwgMd/Sk0XliCZlvAYjfsCjBi/7OhW0iDp88DBp4YangY2JR+N7yLI+c
   Y9oCQ2KqlWpRxSs3TvhnlPqqDTvIYEABc838aGTRYkB9VkgwE/8T0UmHM
   w==;
X-CSE-ConnectionGUID: Kg+vLpM9QeCtCG/fcfFE7w==
X-CSE-MsgGUID: zkb67/tYTuaMaWlFDp3bsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74342404"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="74342404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 23:10:22 -0700
X-CSE-ConnectionGUID: 2ZRKHzvuQjeytCkGuQE3/A==
X-CSE-MsgGUID: SHAHOI7TSbOnGic5LP4cKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137461582"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 May 2025 23:10:15 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEiqC-000FlR-1e;
	Tue, 13 May 2025 06:10:12 +0000
Date: Tue, 13 May 2025 14:09:12 +0800
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
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [net-next PATCH v9 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
Message-ID: <202505131337.ZjnU5fK1-lkp@intel.com>
References: <20250511183933.3749017-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511183933.3749017-2-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-pass-PHY-driver-to-match_phy_device-OP/20250512-024253
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250511183933.3749017-2-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v9 1/6] net: phy: pass PHY driver to .match_phy_device OP
config: x86_64-randconfig-r073-20250513 (https://download.01.org/0day-ci/archive/20250513/202505131337.ZjnU5fK1-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505131337.ZjnU5fK1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505131337.ZjnU5fK1-lkp@intel.com/

All errors (new ones prefixed by >>):

   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 20.1.2
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
>> error[E0308]: mismatched types
   --> rust/kernel/net/phy.rs:527:18
   |
   527 |             Some(Adapter::<T>::match_phy_device_callback)
   |             ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ incorrect number of function parameters
   |             |
   |             arguments to this enum variant are incorrect
   |
   = note: expected fn pointer `unsafe extern "C" fn(*mut bindings::phy_device, *const phy_driver) -> _`
   found fn item `unsafe extern "C" fn(*mut bindings::phy_device) -> _ {phy::Adapter::<T>::match_phy_device_callback}`
   help: the type constructed contains `unsafe extern "C" fn(*mut bindings::phy_device) -> i32 {phy::Adapter::<T>::match_phy_device_callback}` due to the type of the argument passed
   --> rust/kernel/net/phy.rs:527:13
   |
   527 |             Some(Adapter::<T>::match_phy_device_callback)
   |             ^^^^^---------------------------------------^
   |                  |
   |                  this argument influences the type of `Some`
   note: tuple variant defined here
   --> /opt/cross/rustc-1.78.0-bindgen-0.65.1/rustup/toolchains/1.78.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:580:5
   |
   580 |     Some(#[stable(feature = "rust1", since = "1.0.0")] T),
   |     ^^^^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

