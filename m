Return-Path: <netdev+bounces-252998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Qbe8JiYXdGmQ2AAAu9opvQ
	(envelope-from <netdev+bounces-252998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:49:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A664B7BCB0
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B883019BB8
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1B533D6;
	Sat, 24 Jan 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMIbepD6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0133985;
	Sat, 24 Jan 2026 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215778; cv=none; b=oJJeGeFyRz17y+hn/ECIZ+yW2bScHYLVVAN0kSNnaKvdSZUvRWLlwjfHlq51vnJP8ninaAlQP24uE2QwVoYKtZpHyfi1fP336zdKx/y/uM+x7Edi7sxNXwLjwLdprYAjWgvUDwrJ5wsen1qOtaedqp2Kbq5Eir5F6PosOg88hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215778; c=relaxed/simple;
	bh=fvpElUu6XDGBp0awRg+CEKX3ynOmniADUu3Ped643sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGj+XjvGCvGvr0qz0qfZW+IUoWAK5JYD0XwZgYH1UaJdq9/gGKPt/ZmsLuUwE56ZnTV+HLvtpo9lMb1yevGJ/1PF/K8LRRINwCyzyehjn6r1gzsWUYT0AbDO4qcb6ulEImjywSc/sWuKls1Kejf7ChjoJM7Xo4McJxVGVXXeQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMIbepD6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769215778; x=1800751778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvpElUu6XDGBp0awRg+CEKX3ynOmniADUu3Ped643sg=;
  b=MMIbepD6buOA7HO0BvZAEtFMjMjLJXhz+/rG6ewjXNJSZMyAHH2egzCN
   KBLgbKQ7dJqqeEfOpTEppREm+YL5VoU14TtmDJk+W+3h/H6z+c+B5O5/V
   3ott2y4e0RZ0+z9f9N1h3TmNabV96C5xWm5YaJdRlFqS+/HyDjoRrXQ1Y
   HILU8xnsyGupWGXyXWclt5nzu2SDmayUZ08iC/35fWKtxyy9QWKuxIbOm
   jYPKsKY6A1jTyxIMHZLRklUTrHthI7lf6ZWZpgC4ePMtMluelc7WQc/lR
   VF9ZiWzonBAJYGuQNVDeWCs4M/yO6Zjf2u1KpA8qEqo+xNpkDqbm7Bug6
   Q==;
X-CSE-ConnectionGUID: nOTrLTy2TAKypuAnEEkYOw==
X-CSE-MsgGUID: wSVasP/ES7e1rVYpTHoHig==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81911537"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81911537"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 16:49:37 -0800
X-CSE-ConnectionGUID: 4hSdrnMGTwirlIT2T20HRA==
X-CSE-MsgGUID: DKon93DATsmsaV9YLPTl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="244775633"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2026 16:49:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjRqF-00000000Ud4-0Lb3;
	Sat, 24 Jan 2026 00:49:31 +0000
Date: Sat, 24 Jan 2026 08:49:23 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with
 u64_stats
Message-ID: <202601240814.75efeFdo-lkp@intel.com>
References: <20260123162159.2877941-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123162159.2877941-5-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252998-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,redhat.com,ovn.org,google.com,kernel.org,openvswitch.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A664B7BCB0
X-Rspamd-Action: no action

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/u64_stats-Doc-incorrect-usage-with-plain-variables/20260124-012240
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260123162159.2877941-5-mmyangfl%40gmail.com
patch subject: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with u64_stats
config: m68k-randconfig-r073-20260124 (https://download.01.org/0day-ci/archive/20260124/202601240814.75efeFdo-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240814.75efeFdo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240814.75efeFdo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'u64_stats_reads.constprop',
       inlined from 'get_dp_stats' at net/openvswitch/datapath.c:773:4:
>> include/linux/compiler_types.h:631:38: error: call to '__compiletime_assert_333' declared with attribute error: BUILD_BUG_ON failed: len % sizeof(u64_stats_t)
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:612:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:631:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   include/linux/u64_stats_sync.h:157:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(len % sizeof(u64_stats_t));
     ^~~~~~~~~~~~


vim +/__compiletime_assert_333 +631 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  617  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  618  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  619  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  620  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  621  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  622   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  623   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  624   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  625   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  626   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  627   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  628   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  629   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  630  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @631  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  632  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

