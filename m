Return-Path: <netdev+bounces-282631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PjEAerG8mmnuAEAu9opvQ
	(envelope-from <netdev+bounces-282631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:05:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E249CAB9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BB4F301A706
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6C331222;
	Thu, 30 Apr 2026 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVw263LQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE6301471
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518278; cv=none; b=n40cUCRoDAgn5UuiIzRfYGIQsvipwXyvpy3JD/7WXko7VG8Euy+Y0SYRWNlKw1J0Xt4FLiL6rPRQjTzOajWJNCmc2RSVNBPgzPHI440UanTWGE2g+gAP9nAU06pKr82aIdFJv+HTVL7DnejHbEPp9MfLSU3Wt1KMCmdvjB1xNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518278; c=relaxed/simple;
	bh=mxAeFa0zucritB95EEF1sgq4ftLNUflodECe6CLmwnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5BKHxyCtQobhCWe0j/intG5dnfjSEwGenSU+gmAqTwrI49DfyHvzGTVr4TyB1ERliX3VnXmrrId1ajbK2Rw4coOoJrV54Fn9Qj8NnsVu0eU4tFLlhCBSlAcpPDgiQaeIfbmGmWA2kpRZg3SBHxNu2+s9zvgWgVCUvTuRFFfOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVw263LQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777518277; x=1809054277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mxAeFa0zucritB95EEF1sgq4ftLNUflodECe6CLmwnE=;
  b=hVw263LQcp/BCvS4f3r1GPxaBnxFjdNhEmn/QElfbhgRYdGjpBexctob
   pynKACKiGYBaybbPFJYS1Ms8Tqjy59eTbRUITlCHFpprdW9BYsWlOwEp+
   hAPLsiMM/0/VOmuHimek9xBzN0hp94yAOjlNhym3cuyO+jBTK9YQz5fyN
   BGxR74G8GB7VlK/KG7Vf1XkU+8kJdofcsBsihvzCIrT/BxW9FMG3NcC5l
   RMTCZNBSclIGF797bnK+ELWIPlGk5hLAjiOukjwlFgoVIlU3rNpifgX1j
   plyR5izCx+fX0+0TDfuaTUZQ/JguMrwus+VKS6KEtS8I8AQ6Qjhbf2zDB
   g==;
X-CSE-ConnectionGUID: 4JfhTuwwRLyMuq3VhjSMMg==
X-CSE-MsgGUID: Us497ZZsRau4brAslbKcgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65991967"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="65991967"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 20:04:36 -0700
X-CSE-ConnectionGUID: bk16eBbRQOy1LcpnzG9kqg==
X-CSE-MsgGUID: 0A6sJFtkRC61WCvn12Vhew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234480184"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Apr 2026 20:04:34 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIHhX-00000000Brc-0OVn;
	Thu, 30 Apr 2026 03:04:31 +0000
Date: Thu, 30 Apr 2026 11:03:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Dudu Lu <phx0fer@gmail.com>
Subject: Re: [PATCH] nfc: nci: Add skb length validation in
 nci_core_init_rsp_packet
Message-ID: <202604301024.q9hVP893-lkp@intel.com>
References: <20260413090102.77980-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413090102.77980-1-phx0fer@gmail.com>
X-Rspamd-Queue-Id: 601E249CAB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282631-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

Hi Dudu,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master horms-ipvs/master v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dudu-Lu/nfc-nci-Add-skb-length-validation-in-nci_core_init_rsp_packet/20260423-210923
base:   net/main
patch link:    https://lore.kernel.org/r/20260413090102.77980-1-phx0fer%40gmail.com
patch subject: [PATCH] nfc: nci: Add skb length validation in nci_core_init_rsp_packet
config: arm64-randconfig-004-20260430 (https://download.01.org/0day-ci/archive/20260430/202604301024.q9hVP893-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604301024.q9hVP893-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604301024.q9hVP893-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/nfc/nci/rsp.c:1:2: error: expected identifier or '('
       1 |         if (skb->len < sizeof(*rsp)) {
         |         ^
   net/nfc/nci/rsp.c:5:2: error: expected identifier or '('
       5 |         if (skb->len < 6 + rsp_1->num_supported_rf_interfaces +
         |         ^
   net/nfc/nci/rsp.c:10:2: error: expected identifier or '('
      10 |         if (skb->len < sizeof(*rsp_1))
         |         ^
   In file included from net/nfc/nci/rsp.c:29:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:588:
   In file included from include/linux/irqdesc.h:5:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from net/nfc/nci/rsp.c:29:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:588:
   In file included from include/linux/irqdesc.h:5:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from net/nfc/nci/rsp.c:29:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:588:
   In file included from include/linux/irqdesc.h:5:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from net/nfc/nci/rsp.c:29:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:588:
   In file included from include/linux/irqdesc.h:5:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from net/nfc/nci/rsp.c:29:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:588:
   In file included from include/linux/irqdesc.h:5:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from net/nfc/nci/rsp.c:29:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:588:
   In file included from include/linux/irqdesc.h:5:
   In file included from include/linux/irq_work.h:6:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&


vim +1 net/nfc/nci/rsp.c

   > 1		if (skb->len < sizeof(*rsp)) {
     2			pr_err("short NCI_CORE_INIT_RSP v2 packet\n");
     3			return NCI_STATUS_SYNTAX_ERROR;
     4		}
     5		if (skb->len < 6 + rsp_1->num_supported_rf_interfaces +
     6				sizeof(*rsp_2)) {
     7			pr_err("short NCI_CORE_INIT_RSP v1 packet\n");
     8			return NCI_STATUS_SYNTAX_ERROR;
     9		}
    10		if (skb->len < sizeof(*rsp_1))
    11			return NCI_STATUS_SYNTAX_ERROR;
    12	// SPDX-License-Identifier: GPL-2.0-only
    13	/*
    14	 *  The NFC Controller Interface is the communication protocol between an
    15	 *  NFC Controller (NFCC) and a Device Host (DH).
    16	 *
    17	 *  Copyright (C) 2011 Texas Instruments, Inc.
    18	 *
    19	 *  Written by Ilan Elias <ilane@ti.com>
    20	 *
    21	 *  Acknowledgements:
    22	 *  This file is based on hci_event.c, which was written
    23	 *  by Maxim Krasnyansky.
    24	 */
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

