Return-Path: <netdev+bounces-271104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMBdMi2kwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:48:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C02F30A70A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA791302B3AF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569243264EF;
	Tue, 24 Mar 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDzgYb8p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D01FCF41;
	Tue, 24 Mar 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363286; cv=none; b=OET0s85WQejM2LpaCt1fjaqJ4+DFWrBKdgE/UHZN1XbjJfGKG+At68rI29UI0Q4fU66Ct6nB1e3ipmf+Fjkg1dkNeQ84qVjOuALPvSbLCD842hbN7Z14zEOCedJxV84dmJEq0cjCgDB4hQDm99JOkIBUpae3YzXR21pgHWCWzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363286; c=relaxed/simple;
	bh=l75KZj5b4rmbm/g0eeywloWjYWlOWs5V8/y0ZPlQ6kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXHLGLcYh7XL+B1Vu2IwIoa8NYSLdq9cgeeAVlu+w/FWzttLxrLO1BaZC0fxLaoTn+TMXdoRKURux5AjriWKuvEvISj0qAQQmbb91OirR5TIPhAOlqjDMvU92ilmCnOL/GtdO3lyJN0rxQNIwrZR4Fcv+WYdDcIt32ua0B5qFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDzgYb8p; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774363283; x=1805899283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l75KZj5b4rmbm/g0eeywloWjYWlOWs5V8/y0ZPlQ6kk=;
  b=LDzgYb8paZkzlG0pDQPCWNMyL2tqGYdI0MkoG2eFf6aL7lbUVeaBm6s3
   Wju33f+6WWURC6XNfpMJyYP4s6ji6AZn80Kf42BnkX0M7oxhgl9kvsmo0
   hBzaK/QI9vnmTnmvu5BhF5LDHgvFTSA4T5jFoJr6f/iagkVVgT11TN6Fo
   r0e2cItVczkw+0NEZLKfxbRg6hsnROmu56ftC3cVozbbBIH+xLm8yI5E0
   X0R9Fmr7dFJAnLVSXeLwFckJqPcY62n1C+BM1+Pasv2LXalXzmF8p62gn
   02Suphg5vKYJVFrcHHHDlJSluGkdWxgwPzCQUWUqFXv+xkFP4x1mwIY88
   Q==;
X-CSE-ConnectionGUID: kFzSSyyMT5igSyKRg3Uvig==
X-CSE-MsgGUID: +Z31O5FkQwWJATTxp6t4KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75450918"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75450918"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 07:41:22 -0700
X-CSE-ConnectionGUID: vibDIaYYTHemfPPXCqM2YA==
X-CSE-MsgGUID: 75cU/oM9QDeLAERDEQykqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247437068"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 24 Mar 2026 07:41:20 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w52wY-000000006u9-1PeW;
	Tue, 24 Mar 2026 14:41:18 +0000
Date: Tue, 24 Mar 2026 15:40:22 +0100
From: kernel test robot <lkp@intel.com>
To: Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, fujita.tomonori@gmail.com,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, dakr@kernel.org
Subject: Re: [PATCH 2/4] rust: phy: add paged register access and bit
 manipulation helpers
Message-ID: <202603241502.8mYbVohd-lkp@intel.com>
References: <20260323201925.8405-2-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201925.8405-2-iprintercanon@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,lunn.ch,umich.edu,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271104-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 4C02F30A70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Artem,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on linus/master v7.0-rc5 next-20260323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artem-Lytkin/rust-phy-add-paged-register-access-and-bit-manipulation-helpers/20260324-155532
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20260323201925.8405-2-iprintercanon%40gmail.com
patch subject: [PATCH 2/4] rust: phy: add paged register access and bit manipulation helpers
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260324/202603241502.8mYbVohd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260324/202603241502.8mYbVohd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603241502.8mYbVohd-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/net/phy.rs:246:
            let phydev = self.0.get();
            // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
            // So it's just an FFI call.
   -        let ret =
   -            unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
   +        let ret = unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
    
            to_result(ret)
        }
>> Diff in rust/kernel/net/phy.rs:246:
            let phydev = self.0.get();
            // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
            // So it's just an FFI call.
   -        let ret =
   -            unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
   +        let ret = unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
    
            to_result(ret)
        }
>> Diff in rust/kernel/net/phy.rs:246:
            let phydev = self.0.get();
            // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
            // So it's just an FFI call.
   -        let ret =
   -            unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
   +        let ret = unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
    
            to_result(ret)
        }
   make[2]: *** [Makefile:1912: rustfmt] Error 123
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

