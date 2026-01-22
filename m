Return-Path: <netdev+bounces-252228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPvtGp3QcWnSMQAAu9opvQ
	(envelope-from <netdev+bounces-252228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:24:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 104CE627C0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4904A562866
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479E47A0A8;
	Thu, 22 Jan 2026 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGKfybKF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F921D59B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066453; cv=none; b=RolXrrvOCf93KAmnQogJxPOigLb+35P968pJ5z7GGtP3QVSJv7zYmw2SByin2RZl3BZIfmB/mG+JzNdPqyLhm3i/kCCCmk9spY3zm8zvpke5h9tT0t+V2nq8cxKFxlHIqAyxzFiKAlJd9x1C31Mb3S3Jv3PlhT1W7zcG2f6cqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066453; c=relaxed/simple;
	bh=2Hl3exPjVeP4c232MZoQ+6EGCzhzQcq0Xxs4TDi0GGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRHxYekjvwzg4nXRXpYwUI/mhn85AEKxBXqGeo5rqQ4AZVLv3y87V/Ju0ziZomzEl4WVdfFPVJx/zS3LwWf0zIT8PKzZ7sDyEzQ9K0HJc50p29vFiUVjSwrdQ/OlI1lWoOChgnhTetMLUaPnf7sSQSJ1PIrGsAk1MNOh4N+wX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGKfybKF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769066450; x=1800602450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Hl3exPjVeP4c232MZoQ+6EGCzhzQcq0Xxs4TDi0GGg=;
  b=QGKfybKFZDtYfgSxQERmT7fzTx14l6pKpjvao2oN2p8tzQ/MJHWqmdLc
   668jSWS0GVDn66JW3jXPsa48k/nq3UcL/55C6yrZ2dMdxUdyWNFG18fKX
   SCR4eQu7/cVRFZ4ZsnwvfaJz1IMAjR2yoOP+YjfuZr/h1KtToWa0CvuBZ
   wCOCzgcUtu2SqRQkaSMeMCEyUKKPtsBkrilkfh1zsgpzu4bAOL11qbE7V
   ul5hfwT08rAk4PQDcL6eB1GpQi4FYuPTQDMFx6AZtZTqTWw8CUkvYGkMn
   sk/qKbKsFFLSnumhgr3C3UDwMSBkRmYXiiikSW8wJQe/c0qr2vcUGKBV3
   g==;
X-CSE-ConnectionGUID: 6WezpDPXQBuRb3ZHAD3W4w==
X-CSE-MsgGUID: rPkhNvGPSl6KfbdxWFxR0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69318732"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="69318732"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:20:38 -0800
X-CSE-ConnectionGUID: /RkWqjGvSc6OJFZWoZDZKw==
X-CSE-MsgGUID: MSBdt+YLQA+qFl1CNGxBcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="205910422"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 21 Jan 2026 23:20:34 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viozW-000000000S1-3U2W;
	Thu, 22 Jan 2026 07:20:30 +0000
Date: Thu, 22 Jan 2026 08:19:40 +0100
From: kernel test robot <lkp@intel.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH v4 2/3] tls: add hardware offload key update support
Message-ID: <202601220850.8AbmdIiS-lkp@intel.com>
References: <20260121215727.3994324-3-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121215727.3994324-3-rjethwani@purestorage.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252228-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 104CE627C0
X-Rspamd-Action: no action

Hi Rishikesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc6 next-20260121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rishikesh-Jethwani/tls-add-TLS-1-3-hardware-offload-support/20260122-060724
base:   linus/master
patch link:    https://lore.kernel.org/r/20260121215727.3994324-3-rjethwani%40purestorage.com
patch subject: [PATCH v4 2/3] tls: add hardware offload key update support
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260122/202601220850.8AbmdIiS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220850.8AbmdIiS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601220850.8AbmdIiS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:380,
                    from arch/x86/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/crypto/aead.h:11,
                    from net/tls/tls_device.c:32:
   net/tls/tls_device.c: In function 'tls_set_device_offload':
>> include/asm-generic/rwonce.h:55:37: error: lvalue required as left operand of assignment
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                     ^
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:63:9: note: in expansion of macro 'WRITE_ONCE'
      63 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   net/tls/tls_device.c:1249:25: note: in expansion of macro 'smp_store_release'
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~
--
   In file included from arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:380,
                    from arch/x86/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/crypto/aead.h:11,
                    from tls_device.c:32:
   tls_device.c: In function 'tls_set_device_offload':
>> include/asm-generic/rwonce.h:55:37: error: lvalue required as left operand of assignment
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                     ^
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:63:9: note: in expansion of macro 'WRITE_ONCE'
      63 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   tls_device.c:1249:25: note: in expansion of macro 'smp_store_release'
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~


vim +55 include/asm-generic/rwonce.h

e506ea451254ab Will Deacon 2019-10-15  52  
e506ea451254ab Will Deacon 2019-10-15  53  #define __WRITE_ONCE(x, val)						\
e506ea451254ab Will Deacon 2019-10-15  54  do {									\
e506ea451254ab Will Deacon 2019-10-15 @55  	*(volatile typeof(x) *)&(x) = (val);				\
e506ea451254ab Will Deacon 2019-10-15  56  } while (0)
e506ea451254ab Will Deacon 2019-10-15  57  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

