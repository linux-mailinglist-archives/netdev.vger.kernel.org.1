Return-Path: <netdev+bounces-285107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIinFR7y+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6B4E2240
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6B933004D27
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD8277C9E;
	Thu,  7 May 2026 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktSvH82k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89EF1EB5F8
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119192; cv=none; b=XNt1zk/RhOoYfquR7tgFlQ4tB4iOfV7fPDHpB0y1FRBBmAE1JowOsaY/edbODMaskjkQCTVFKkXVu9PgbBrTw3GXicucy0c/e0Cdf+ZszOuVDWftQEsgw3sj4Wr8jXmn9SJEJ4qQYaxTng4z2I5J4jBV2zfIhEX82x30fWBlYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119192; c=relaxed/simple;
	bh=9R6Ye33gcR0zMH4A+14HWASjDLlNvZMHPP16kmr7eCs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KP8TJHD7/axPpCBc/69uIX/Stb1+fCD9OfhCOeaaFaHRXHqSQt9ugSlcEElY+/TYde8Ftn9Y7H0xMypANTFwRbDhx1tlTAVGZG7r8FwJ+Ha9YVXb0+uNodRpf/pOR6sruZle7BhpdVtIBq9eIrisKpOSlGFXXGGqfethxaaR5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktSvH82k; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778119190; x=1809655190;
  h=date:from:to:cc:subject:message-id;
  bh=9R6Ye33gcR0zMH4A+14HWASjDLlNvZMHPP16kmr7eCs=;
  b=ktSvH82kgepkOufMmBQfbxwViLufaYAgGvSCmNXohcInC2X58lEZS3fu
   pLQl6LJAjnfc44vNLttjDuGcmn3+0L6hzcawdCT3D5ecNTzpMoKzq40fU
   1b0HoOiXypwCkXmJJ72AO2kBwWwpqgtPVoWI6Z4PJ43ZnVMudAHIHrCUp
   pwxQmCygNvrKAfYJ4beXUjvpxuXGmiTeVbsShcW7pc7EsVxWhhYZPFZKB
   woG5MOXX4yhSGOgmIHBhmR04zSK0LpPC/ry6GjVnjitwA/zYHocaAPk5I
   IW3QKXznL/wqDZDNpNzv6c3TuHGuqG4vPgkK53Yk4fh/XxSdVbFXOi3GV
   A==;
X-CSE-ConnectionGUID: E9vAR3qbSIy+ed76lUy7Ag==
X-CSE-MsgGUID: 3ohr5GtjTveqaaIztP3auw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78911845"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78911845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 18:59:49 -0700
X-CSE-ConnectionGUID: hIr+1srqSjautPAY5PNVVA==
X-CSE-MsgGUID: 4XgNQ47cQ7u9KOmHqDYP2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="236432447"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 May 2026 18:59:47 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKo1g-000000001QD-0CGB;
	Thu, 07 May 2026 01:59:44 +0000
Date: Thu, 07 May 2026 09:59:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 netdev@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [linux-next:master] BUILD REGRESSION
 735d2f48cadaa9a87e7c7601667878de70c771c5
Message-ID: <202605070954.rAfjsCoD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BEA6B4E2240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285107-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 735d2f48cadaa9a87e7c7601667878de70c771c5  Add linux-next specific files for 20260506

Unverified Error/Warning (likely false positive, kindly check if interested):

    ERROR: modpost: "__aarch64_ldadd8_relax" [kernel/trace/preemptirq_delay_test.ko] undefined!
    ERROR: modpost: "__aarch64_ldadd8_relax" [kernel/trace/synth_event_gen_test.ko] undefined!
    ERROR: modpost: "__sync_fetch_and_add_8" [io_uring/mock_file.ko] undefined!

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-r121-20260505
|   |-- ERROR:__aarch64_ldadd8_relax-kernel-trace-preemptirq_delay_test.ko-undefined
|   `-- ERROR:__aarch64_ldadd8_relax-kernel-trace-synth_event_gen_test.ko-undefined
|-- hexagon-randconfig-r131-20260506
|   `-- drivers-net-bareudp.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-sock-sk-got-struct-sock-noderef-__rcu-sk
`-- parisc-randconfig-002-20260506
    `-- ERROR:__sync_fetch_and_add_8-io_uring-mock_file.ko-undefined

elapsed time: 725m

configs tested: 270
configs skipped: 7

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260507    gcc-10.5.0
arc                   randconfig-001-20260507    gcc-14.3.0
arc                   randconfig-002-20260507    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260507    clang-23
arm                   randconfig-002-20260507    gcc-10.5.0
arm                   randconfig-002-20260507    gcc-14.3.0
arm                   randconfig-003-20260507    clang-23
arm                   randconfig-004-20260507    gcc-13.4.0
arm                   randconfig-004-20260507    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260506    gcc-8.5.0
arm64                 randconfig-001-20260507    gcc-15.2.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260506    gcc-8.5.0
arm64                 randconfig-002-20260507    gcc-15.2.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260506    gcc-11.5.0
arm64                 randconfig-003-20260507    gcc-15.2.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260506    clang-23
arm64                 randconfig-004-20260507    gcc-15.2.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260506    gcc-15.2.0
csky                  randconfig-001-20260507    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260506    gcc-15.2.0
csky                  randconfig-002-20260507    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260506    clang-23
hexagon               randconfig-002-20260506    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260506    gcc-14
i386        buildonly-randconfig-001-20260507    clang-20
i386        buildonly-randconfig-001-20260507    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260506    gcc-14
i386        buildonly-randconfig-002-20260507    clang-20
i386        buildonly-randconfig-002-20260507    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260506    clang-20
i386        buildonly-randconfig-003-20260507    clang-20
i386        buildonly-randconfig-003-20260507    gcc-14
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260506    clang-20
i386        buildonly-randconfig-004-20260507    clang-20
i386        buildonly-randconfig-004-20260507    gcc-14
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260506    clang-20
i386        buildonly-randconfig-005-20260507    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260506    gcc-14
i386        buildonly-randconfig-006-20260507    clang-20
i386        buildonly-randconfig-006-20260507    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260506    gcc-14
i386                  randconfig-002-20260506    gcc-14
i386                  randconfig-003-20260506    gcc-14
i386                  randconfig-004-20260506    clang-20
i386                  randconfig-005-20260506    gcc-14
i386                  randconfig-006-20260506    gcc-14
i386                  randconfig-007-20260506    clang-20
i386                  randconfig-011-20260507    clang-20
i386                  randconfig-011-20260507    gcc-14
i386                  randconfig-012-20260507    clang-20
i386                  randconfig-013-20260507    clang-20
i386                  randconfig-013-20260507    gcc-14
i386                  randconfig-014-20260507    clang-20
i386                  randconfig-014-20260507    gcc-14
i386                  randconfig-015-20260506    gcc-14
i386                  randconfig-015-20260507    clang-20
i386                  randconfig-016-20260507    clang-20
i386                  randconfig-016-20260507    gcc-14
i386                  randconfig-017-20260507    clang-20
i386                  randconfig-017-20260507    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260506    clang-18
loongarch             randconfig-002-20260506    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          hp300_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260506    gcc-8.5.0
nios2                 randconfig-002-20260506    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260506    gcc-13.4.0
parisc                randconfig-002-20260506    gcc-10.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260506    gcc-10.5.0
powerpc               randconfig-002-20260506    gcc-8.5.0
powerpc64             randconfig-001-20260506    gcc-8.5.0
powerpc64             randconfig-002-20260506    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260507    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260507    gcc-13.4.0
s390                  randconfig-002-20260507    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260507    gcc-10.5.0
sh                    randconfig-002-20260507    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260506    gcc-15.2.0
sparc                 randconfig-002-20260506    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260506    clang-23
sparc64               randconfig-002-20260506    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260506    gcc-14
um                    randconfig-002-20260506    clang-23
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260506    clang-20
x86_64      buildonly-randconfig-001-20260507    clang-20
x86_64      buildonly-randconfig-002-20260506    gcc-14
x86_64      buildonly-randconfig-002-20260507    clang-20
x86_64      buildonly-randconfig-003-20260506    clang-20
x86_64      buildonly-randconfig-003-20260507    clang-20
x86_64      buildonly-randconfig-004-20260506    clang-20
x86_64      buildonly-randconfig-004-20260507    clang-20
x86_64      buildonly-randconfig-005-20260506    gcc-12
x86_64      buildonly-randconfig-005-20260507    clang-20
x86_64      buildonly-randconfig-006-20260506    clang-20
x86_64      buildonly-randconfig-006-20260507    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260506    gcc-13
x86_64                randconfig-002-20260506    clang-20
x86_64                randconfig-003-20260506    clang-20
x86_64                randconfig-004-20260506    clang-20
x86_64                randconfig-005-20260506    gcc-14
x86_64                randconfig-006-20260506    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260506    clang-20
x86_64                randconfig-011-20260507    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260506    clang-20
x86_64                randconfig-012-20260507    gcc-14
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260506    clang-20
x86_64                randconfig-013-20260507    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260506    clang-20
x86_64                randconfig-014-20260507    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260506    gcc-12
x86_64                randconfig-015-20260507    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260506    gcc-14
x86_64                randconfig-016-20260507    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260506    gcc-14
x86_64                randconfig-071-20260507    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260506    gcc-14
x86_64                randconfig-072-20260507    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260506    gcc-14
x86_64                randconfig-073-20260507    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260506    clang-20
x86_64                randconfig-074-20260507    clang-20
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260506    gcc-14
x86_64                randconfig-075-20260507    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260506    clang-20
x86_64                randconfig-076-20260507    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260506    gcc-15.2.0
xtensa                randconfig-002-20260506    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

