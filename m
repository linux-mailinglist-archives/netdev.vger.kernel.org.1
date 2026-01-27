Return-Path: <netdev+bounces-253952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQ9F9bxeGmGuAEAu9opvQ
	(envelope-from <netdev+bounces-253952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:11:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B41CD98452
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4501300915F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B0361669;
	Tue, 27 Jan 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+hnPVbI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960333B6CD;
	Tue, 27 Jan 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533903; cv=none; b=ilZIGthdrvZE/NYFtrM1yQxGzE5NxB7RDjdXbxMr8Bt5WQkEV1ZRRQnXtAF3wNszR110WWslEdy9fByidb5SX+ErRzeLNTHU/hd0pU4/nA1scfd8zc0jv3kq76IcivBMuTaZpqnLmhl5iQhiv7bT8TWeCXIaRaS80+o/8LiW4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533903; c=relaxed/simple;
	bh=wle2j4G2/GZkdPRtHbPu9Syfd49kiJrlmMqENn4R26Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg1yz6+C1EM5Tm+gBq8K3hbzK+Pe0xeOxxqrCD+NhOBCss1aWk+qCe34IIMTMF84wXnSDahDRtPAhDZQha7cioLAIEcQpTvCsYRjoMumDsiqnZmvWUjDqjrOge0BXE3nUec1ITWEbxmiVslawKjrzeVWUGgk/gWAk7BMRPG1A84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+hnPVbI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769533901; x=1801069901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wle2j4G2/GZkdPRtHbPu9Syfd49kiJrlmMqENn4R26Y=;
  b=j+hnPVbIG3pWTh/H+0yw9QvlQgX/ci4QbLZDxfRnH/SGauSY8cJWP5Nj
   iVpujpZ3onvAKq9BkkhBzB07FpmQRvPX9H0EYHukAjvgoDMap/lvS9rA4
   GhJLMK0lEl8mXazIUnbVVBBzbMtiOd+JW6LrkoeXrQyeGQ1jAG4zRwg6V
   4stf1T59evG8iLDduHENBy5akMu53B6n3NZ3elRNrs75EarbxUjB5ouZp
   d8fSKqQ5W7aiCqfUQN6mgDJfg5lNUKfKzstR+tWvHGCF24NtFHHqYB25W
   BXUaNFWBMbzwYr/NfX4EZbSnZVrcBzFUzQ+mqWo6q5+U8w+e46i6ERNlP
   Q==;
X-CSE-ConnectionGUID: OxEXaSQ8T6+jVKyYN49X+w==
X-CSE-MsgGUID: XPN/cr94QUmJAKKU3WvGPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="88314583"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="88314583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 09:11:41 -0800
X-CSE-ConnectionGUID: xOAwb+gFQ92y3ZmIJZwR4g==
X-CSE-MsgGUID: iHE/Gy3rReqSVEHrEWeqjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="230977348"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jan 2026 09:11:38 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkmbI-000000001uH-07rO;
	Tue, 27 Jan 2026 17:11:36 +0000
Date: Tue, 27 Jan 2026 18:10:52 +0100
From: kernel test robot <lkp@intel.com>
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Javen Xu <javen_xu@realsil.com.cn>
Subject: Re: [PATCH net-next v1 1/3] r816e: add a fake driver r816e for
 RTL8116af
Message-ID: <202601271822.HvRlrxlv-lkp@intel.com>
References: <20260127113425.1989-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127113425.1989-2-javen_xu@realsil.com.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253952-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: B41CD98452
X-Rspamd-Action: no action

Hi javen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/javen/r816e-add-a-fake-driver-r816e-for-RTL8116af/20260127-193831
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260127113425.1989-2-javen_xu%40realsil.com.cn
patch subject: [PATCH net-next v1 1/3] r816e: add a fake driver r816e for RTL8116af
reproduce: (https://download.01.org/0day-ci/archive/20260127/202601271822.HvRlrxlv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271822.HvRlrxlv-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -fno-crash-diagnostics -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef -falign-functions=64 W=1 --keep-going LLVM=1 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
>> ./drivers/net/ethernet/realtek/r816e/r816e.c: 10 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 449: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

