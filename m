Return-Path: <netdev+bounces-271144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC9pMX/EwmlflgQAu9opvQ
	(envelope-from <netdev+bounces-271144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:06:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 405AA319ACA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF7C330BC207
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43B388397;
	Tue, 24 Mar 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdI6f/H9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F537F733;
	Tue, 24 Mar 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367546; cv=none; b=Wp1/VoCAORFveY7MN5ks2VteAtgbCPtRRJnP9rBpkxY5QgNcRuURz/ywWb7DkazmlYo4vkDibpN+GbEt4mccPAGVFfS42ah8nn26Egq3KB06Ug42wzYoM7xnCiD7h1jAMpK6twlvvqSv+bmiKtFVW0QobZjdqjBgzc7E4bxW5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367546; c=relaxed/simple;
	bh=HyEhqdBvfa3r9tYRrYSgodtwHMxVIZ/6Kc/3pc0VDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8czaNRNYq8PnkP5LBz1/K4CSQw9ZgBBUXqH8/lyioimSvBkCZ3lJkSTW5ZmG5c+aMwQyD2ZOyHyKmc6McDIRAf1xZ4XXIs+9RoUNJCqsIY+0HY1xuX1sZlWchfxw97dZLJNXqVjSjq1rO3Pe/A84e8ZRLcusvSjmYHEJEpdoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdI6f/H9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774367545; x=1805903545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyEhqdBvfa3r9tYRrYSgodtwHMxVIZ/6Kc/3pc0VDK0=;
  b=OdI6f/H9jEZOExpcH8b4S/+/sG/tPTHIABSWoDwNbWXMiT5Rh/0v6X6Y
   LnQOc3zA0sRIs0rJpVq87QRr4C4J4aFAmuqkyVreEvUKtVFBbnaxgAXMb
   bMU4Z2BpBunhLm3W0YCl6FMoZ5n2MdoQeB70Y1uXTCFAsKxKyD86AYqAO
   8G6zeJ2Tp+IfksZprMNmxNLCLOLYSldVPCkHDDM+adATcNzJp6NNGfmBB
   41Z4ClekuH/BKcumdW+X55ITawvi1BNASD5iwZobPWKNGPOPWU4YJsXPK
   v2+PsnZnkAPlNoyc0WwNG3tX+qOip+s0kY0nv0RKnNHgGdxF3XMMahqVS
   w==;
X-CSE-ConnectionGUID: LtxnCQX+TgWaPlmjTKljQQ==
X-CSE-MsgGUID: ULvY6SqTSIWJYuNFyctQmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="77989926"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="77989926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 08:52:24 -0700
X-CSE-ConnectionGUID: ktOYh7fOQeW8ut6uCDpn3g==
X-CSE-MsgGUID: 4HzScUrOR0qbSB6nEheW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223462626"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 24 Mar 2026 08:52:22 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w543H-000000006vF-1GXR;
	Tue, 24 Mar 2026 15:52:19 +0000
Date: Tue, 24 Mar 2026 16:51:45 +0100
From: kernel test robot <lkp@intel.com>
To: Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, fujita.tomonori@gmail.com,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, dakr@kernel.org
Subject: Re: [PATCH 4/4] rust: phy: add interrupt support
Message-ID: <202603241610.omlicT8x-lkp@intel.com>
References: <20260323201925.8405-4-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201925.8405-4-iprintercanon@gmail.com>
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,lunn.ch,umich.edu,kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.694];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rust-lang.github.io:url,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 405AA319ACA
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi Artem,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on linus/master v7.0-rc5 next-20260323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artem-Lytkin/rust-phy-add-paged-register-access-and-bit-manipulation-helpers/20260324-155532
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20260323201925.8405-4-iprintercanon%40gmail.com
patch subject: [PATCH 4/4] rust: phy: add interrupt support
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260324/202603241610.omlicT8x-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260324/202603241610.omlicT8x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603241610.omlicT8x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unsafe function's docs are missing a `# Safety` section
   --> rust/kernel/net/phy.rs:564:5
   |
   564 |     unsafe extern "C" fn config_aneg_callback(phydev: *mut bindings::phy_device) -> c_int {
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#missing_safety_doc
   = note: `-W clippy::missing-safety-doc` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::missing_safety_doc)]`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

