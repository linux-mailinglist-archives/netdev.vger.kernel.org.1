Return-Path: <netdev+bounces-288285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kILANtYHB2qcqwIAu9opvQ
	(envelope-from <netdev+bounces-288285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:47:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08D54EBCB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5872D30E4A04
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770747A0C7;
	Fri, 15 May 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hdmb6zRW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDE47277E
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844054; cv=none; b=Q+Q4kCiST4PHYis76JttypWojzLdSCUI3iywvMLlEbVbMZuzuj0co0pbZ7w6jzQQjYBWASJIIggnm/nMpx3aiwI1mdjUEDhZWMKwlfFfv2zjwIxLAzOBkYvi+VibkISWSdHwhFC4P57ZisrY0fJ9vtQMvFxIOYP5V9LijB2xeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844054; c=relaxed/simple;
	bh=PdBfLex/p6GR85RdIX0Kk1v4Aps5pHKRkxVT0I00xsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DE0cEuTI23XmG6t5WYsv1N5ijJPs7rJPYi4LY1HLWvFjbpT18UV5V0Ndei8naYWQp9pEZ6WtG73aJMNquHdfjQ6o9cXAde7n4t3sBnE14gcAbfh+bkNjTtMTP2/1epe/iszjXLYp6OL932iZHoeoxadSAENLZcnArYMoMFB5woY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hdmb6zRW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778844052; x=1810380052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PdBfLex/p6GR85RdIX0Kk1v4Aps5pHKRkxVT0I00xsc=;
  b=Hdmb6zRWNv73NsNBwlOYjzs53ADWyziaZtDkqCBzCqXeSo7kmGOz2bOA
   SX0SyPSbvU5b5zTrcBEd+xYcZQR6hvhD/4ij83RhvkPvXvJcJ81dvlRtJ
   9s8qfftw3ZQrkvn4uABB6wTYVWm23Z7GJL4J0iSVCt0WEFEMtDnra87pM
   eUsyLBZ+cnRFaNNSukqNgAz1p/xuR44W5S/+jJfOU9UDTf3WfTRnK5sRe
   ImUqu4KxaMSRRWa3RwXwkVi8+FfDkoS+o7rWe6ZaJkxWlQZkaUJ+g2RTG
   Tha31C9EuCMwWsaQUfrPfQNjEsrRWzwaWHYmhRVAyoTnufIEHm4KRwY1y
   w==;
X-CSE-ConnectionGUID: DA6Hi+vRQZmSRY5qSlrOQA==
X-CSE-MsgGUID: bt2dz3DKQk6CPHIdBWSeqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97372168"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97372168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:20:51 -0700
X-CSE-ConnectionGUID: ey/6TkJGS3iAzW1T7RhAsw==
X-CSE-MsgGUID: jEatSIenR8ekw3FrScC/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237808057"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 May 2026 04:20:49 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNqaz-000000001Rg-2Tf6;
	Fri, 15 May 2026 11:20:45 +0000
Date: Fri, 15 May 2026 19:20:03 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen"?= <toke@toke.dk>
Subject: [net-next:main 114/116]
 drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is
 negative
Message-ID: <202605151942.zKz99b9W-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Queue-Id: 1A08D54EBCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288285-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,intel.com:email,intel.com:mid,intel.com:dkim,solarflare.com:email]
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   822d4a8e390a08ccfaf2abb347ae670b230b196f
commit: f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a [114/116] net: make is_skb_wmem() available to modules
config: sparc64-randconfig-001-20260515 (https://download.01.org/0day-ci/archive/20260515/202605151942.zKz99b9W-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151942.zKz99b9W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151942.zKz99b9W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/sfc/falcon/falcon.c:18:
   In file included from drivers/net/ethernet/sfc/falcon/net_driver.h:29:
   In file included from include/net/busy_poll.h:18:
   In file included from include/net/ip.h:29:
   In file included from include/net/inet_sock.h:23:
   include/net/sock.h:1861:56: error: use of undeclared identifier '__sock_wfree'; did you mean 'sock_wfree'?
    1861 |                (IS_ENABLED(CONFIG_INET) && skb->destructor == __sock_wfree) ||
         |                                                               ^~~~~~~~~~~~
         |                                                               sock_wfree
   include/net/sock.h:1853:6: note: 'sock_wfree' declared here
    1853 | void sock_wfree(struct sk_buff *skb);
         |      ^
   include/net/sock.h:1862:56: error: use of undeclared identifier 'tcp_wfree'; did you mean 'sock_wfree'?
    1862 |                (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
         |                                                               ^~~~~~~~~
         |                                                               sock_wfree
   include/net/sock.h:1853:6: note: 'sock_wfree' declared here
    1853 | void sock_wfree(struct sk_buff *skb);
         |      ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/falcon/bitfield.h:246:21: note: expanded from macro 'EF4_INSERT_NATIVE64'
     246 |           (((u64) (value)) >> (min - low))))
         |                            ^
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:131:31: note: expanded from macro '__swab64'
     131 |         (__u64)(__builtin_constant_p(x) ?       \
         |                                      ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/falcon/bitfield.h:252:21: note: expanded from macro 'EF4_INSERT_NATIVE32'
     252 |           (((u32) (value)) >> (min - low))))
         |                            ^
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:131:31: note: expanded from macro '__swab64'
     131 |         (__u64)(__builtin_constant_p(x) ?       \
         |                                      ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:25:12: note: expanded from macro '___constant_swab64'
      25 |         (((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:25:12: note: expanded from macro '___constant_swab64'
      25 |         (((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:26:12: note: expanded from macro '___constant_swab64'
      26 |         (((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:26:12: note: expanded from macro '___constant_swab64'
      26 |         (((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:27:12: note: expanded from macro '___constant_swab64'
      27 |         (((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:27:12: note: expanded from macro '___constant_swab64'
      27 |         (((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:28:12: note: expanded from macro '___constant_swab64'
      28 |         (((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:28:12: note: expanded from macro '___constant_swab64'
      28 |         (((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:29:12: note: expanded from macro '___constant_swab64'
      29 |         (((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:29:12: note: expanded from macro '___constant_swab64'
      29 |         (((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:30:12: note: expanded from macro '___constant_swab64'
      30 |         (((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:30:12: note: expanded from macro '___constant_swab64'
      30 |         (((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:31:12: note: expanded from macro '___constant_swab64'
      31 |         (((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:31:12: note: expanded from macro '___constant_swab64'
      31 |         (((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |   \
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:32:12: note: expanded from macro '___constant_swab64'
      32 |         (((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:32:12: note: expanded from macro '___constant_swab64'
      32 |         (((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/falcon/bitfield.h:246:21: note: expanded from macro 'EF4_INSERT_NATIVE64'
     246 |           (((u64) (value)) >> (min - low))))
         |                            ^
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:133:12: note: expanded from macro '__swab64'
     133 |         __fswab64(x))
         |                   ^
>> drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:453:10: note: expanded from macro 'EF4_SET_OWORD64'
     453 |                            & ~EF4_INPLACE_MASK64(0,  63, low, high))    \
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/falcon/bitfield.h:252:21: note: expanded from macro 'EF4_INSERT_NATIVE32'
     252 |           (((u32) (value)) >> (min - low))))
         |                            ^
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:133:12: note: expanded from macro '__swab64'
     133 |         __fswab64(x))
         |                   ^
   drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:454:8: note: expanded from macro 'EF4_SET_OWORD64'
     454 |                           | EF4_INSERT64(0,  63, low, high, value));    \
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/falcon/bitfield.h:246:21: note: expanded from macro 'EF4_INSERT_NATIVE64'
     246 |           (((u64) (value)) >> (min - low))))
         |                            ^
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:131:31: note: expanded from macro '__swab64'
     131 |         (__u64)(__builtin_constant_p(x) ?       \
         |                                      ^
   drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:454:8: note: expanded from macro 'EF4_SET_OWORD64'
     454 |                           | EF4_INSERT64(0,  63, low, high, value));    \
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/falcon/bitfield.h:252:21: note: expanded from macro 'EF4_INSERT_NATIVE32'
     252 |           (((u32) (value)) >> (min - low))))
         |                            ^
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:131:31: note: expanded from macro '__swab64'
     131 |         (__u64)(__builtin_constant_p(x) ?       \
         |                                      ^
   drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
         |                             ^
   drivers/net/ethernet/sfc/falcon/bitfield.h:497:2: note: expanded from macro 'EF4_SET_OWORD_FIELD64'
     497 |         EF4_SET_OWORD64(oword, EF4_LOW_BIT(field),                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     498 |                          EF4_HIGH_BIT(field), value)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:454:8: note: expanded from macro 'EF4_SET_OWORD64'
     454 |                           | EF4_INSERT64(0,  63, low, high, value));    \
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/uapi/linux/byteorder/big_endian.h:32:53: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |         ~~~~~~~~~~~~~~~~~~~^~
   include/uapi/linux/swab.h:25:12: note: expanded from macro '___constant_swab64'
      25 |         (((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |   \
         |                   ^
   drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is negative [-Wshift-count-negative]
     332 |         EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/falcon/bitfield.h:519:29: note: expanded from macro 'EF4_SET_OWORD_FIELD'
     519 | #define EF4_SET_OWORD_FIELD EF4_SET_OWORD_FIELD64
..


vim +332 drivers/net/ethernet/sfc/falcon/falcon.c

d4f2cecce138c3 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-07-04  303  
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  304  static const unsigned int
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  305  /* "Large" EEPROM device: Atmel AT25640 or similar
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  306   * 8 KB, 16-bit address, 32 B write block */
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  307  large_eeprom_type = ((13 << SPI_DEV_TYPE_SIZE_LBN)
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  308  		     | (2 << SPI_DEV_TYPE_ADDR_LEN_LBN)
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  309  		     | (5 << SPI_DEV_TYPE_BLOCK_SIZE_LBN)),
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  310  /* Default flash device: Atmel AT25F1024
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  311   * 128 KB, 24-bit address, 32 KB erase block, 256 B write block */
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  312  default_flash_type = ((17 << SPI_DEV_TYPE_SIZE_LBN)
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  313  		      | (3 << SPI_DEV_TYPE_ADDR_LEN_LBN)
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  314  		      | (0x52 << SPI_DEV_TYPE_ERASE_CMD_LBN)
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  315  		      | (15 << SPI_DEV_TYPE_ERASE_SIZE_LBN)
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  316  		      | (8 << SPI_DEV_TYPE_BLOCK_SIZE_LBN));
2f7f5730951322 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-12-12  317  
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  318  /**************************************************************************
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  319   *
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  320   * I2C bus - this is a bit-bashing interface using GPIO pins
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  321   * Note that it uses the output enables to tristate the outputs
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  322   * SDA is the data pin and SCL is the clock
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  323   *
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  324   **************************************************************************
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  325   */
37b5a60335305e drivers/net/sfc/falcon.c                 Ben Hutchings 2008-05-30  326  static void falcon_setsda(void *data, int state)
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  327  {
5a6681e22c1409 drivers/net/ethernet/sfc/falcon/falcon.c Edward Cree   2016-11-28  328  	struct ef4_nic *efx = (struct ef4_nic *)data;
5a6681e22c1409 drivers/net/ethernet/sfc/falcon/falcon.c Edward Cree   2016-11-28  329  	ef4_oword_t reg;
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  330  
5a6681e22c1409 drivers/net/ethernet/sfc/falcon/falcon.c Edward Cree   2016-11-28  331  	ef4_reado(efx, &reg, FR_AB_GPIO_CTL);
5a6681e22c1409 drivers/net/ethernet/sfc/falcon/falcon.c Edward Cree   2016-11-28 @332  	EF4_SET_OWORD_FIELD(reg, FRF_AB_GPIO3_OEN, !state);
5a6681e22c1409 drivers/net/ethernet/sfc/falcon/falcon.c Edward Cree   2016-11-28  333  	ef4_writeo(efx, &reg, FR_AB_GPIO_CTL);
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  334  }
8ceee660aacb29 drivers/net/sfc/falcon.c                 Ben Hutchings 2008-04-27  335  

:::::: The code at line 332 was first introduced by commit
:::::: 5a6681e22c1409089132085811857d6da828761b sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver

:::::: TO: Edward Cree <ecree@solarflare.com>
:::::: CC: David S. Miller <davem@davemloft.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

