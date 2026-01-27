Return-Path: <netdev+bounces-253840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NGGNVyxeGkksQEAu9opvQ
	(envelope-from <netdev+bounces-253840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:36:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 401DE94615
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B6F73017BD6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F42354AE9;
	Tue, 27 Jan 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbBF4jEc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CC349B11
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517402; cv=none; b=T2ZkBrfFzKi+6YNl2Z3zxranRcDJP1fUuex/1uNSzSRC3RG4f/qLmdHlLKsHWDnIiCakncQHnhiApK3UYfswZGi6azLIZr+Hc/QlK15q1wl8oJnxGVhgJoJiTv++bBYiGz/Shg5ybkuPQ/ktw2GZNK5DwLI66f3iQF2UDRcSgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517402; c=relaxed/simple;
	bh=NiccIC3UYlpAj+il+3Um9wT8ZxVn3k6TWjSM6jD5nmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcjJNDTZb5XOMNE9MZ5v35XDWO3H9xxbMtzy7/SrWmbHsb0oOwE7PLwIDjXgM24ZpTqR1Jmal6w3wiom5Adqmc4d/bJTK6NRcGRJ9/FSpnBpP6TURAJyQ6MzBReqEQPfiletkftmdH8A9Xj2Ea0iX8LRCOwu49X25dYI3ZWVmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbBF4jEc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769517400; x=1801053400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NiccIC3UYlpAj+il+3Um9wT8ZxVn3k6TWjSM6jD5nmw=;
  b=SbBF4jEc5OgLsaMGCWZP5K6JWLBBLtFZcCUi2SgJRcR5wOIKT0ddbsNM
   wjCBTRELB8MW5LPIyjabnEN1NfC3WjJ5LKh/UZKcojlcV3zZUyjXIhb68
   J1BcDIb3BUxI68qBufE7rRbLRkProXEr8V05OMd+1z8rV8b7Vr1IPDyDv
   4Soxn3nzJCbXmYREb5weUMi4aG3uNScLCjEDEVk6CS3ay/i4QfvmlrjCe
   pC1iN5fs1btj3EuiUT73mfBxVxse6Cls0/NTPUmK+jyrKSzueUQdCf2Lk
   dQ7bkXFIVjfiESel9nhwrdoC1AsKGIA0lBvkfNA6rxpritmdlPBDWDCUm
   w==;
X-CSE-ConnectionGUID: Z181XXxRRb2eti/1G81vmw==
X-CSE-MsgGUID: 7Dv7J8zhTHScJDfKhrxzQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70800366"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70800366"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:36:39 -0800
X-CSE-ConnectionGUID: T6nrqDsATMuLBYdLCF2UqQ==
X-CSE-MsgGUID: 7Lh6JxY6RwGAz2rCugoMYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208019349"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 27 Jan 2026 04:36:36 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkiJ8-000000001sL-2WHO;
	Tue, 27 Jan 2026 12:36:34 +0000
Date: Tue, 27 Jan 2026 13:36:24 +0100
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Cc: oe-kbuild-all@lists.linux.dev, Breno Leitao <leitao@debian.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering
 slave
Message-ID: <202601271353.GO9xxwpb-lkp@intel.com>
References: <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-253840-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 401DE94615
X-Rspamd-Action: no action

Hi Tetsuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20260126]
[cannot apply to v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/team-avoid-NETDEV_CHANGEMTU-event-when-unregistering-slave/20260125-223816
base:   linus/master
patch link:    https://lore.kernel.org/r/ece4365f-906c-44e2-80c9-ab73f91f7fb5%40I-love.SAKURA.ne.jp
patch subject: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering slave
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260127/202601271353.GO9xxwpb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271353.GO9xxwpb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271353.GO9xxwpb-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module team uses symbol __netif_set_mtu from namespace NETDEV_INTERNAL, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

