Return-Path: <netdev+bounces-292093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BnJA5h+FmqfmwcAu9opvQ
	(envelope-from <netdev+bounces-292093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:18:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC445DF60F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00CE303661F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6625B30D;
	Wed, 27 May 2026 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNjCwaEl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E224B05
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859043; cv=none; b=bFC0tDGJYA0U41FdOtw/JGyEnPiDR4xBbNMkgKXZMcfGcgWDof6GwDDI1FmQWcYjukkPMtpIXDmoaQv808VRdBVdNHGp4+pC0E9SnYDtUYwWZv30Qx3HFn5+sCs8NMgpbkAeLw2BlLV2+BdIqs23MTpt2Q2EQwEWljLRGzDjxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859043; c=relaxed/simple;
	bh=sIUJVM/Tyo5UiOhBXkpeSg0qA95TSz00hm7dg81oVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qsah3aB9EmUbnBg9U7xYU7lm/MkEE6Uio4RPnPoiNeHVcJAImrFAN0c23FRHo82dzhRfC170jbqgTjf05SVf9tL31qqAf8FuuaSbd70W9pYGueZOfxWMS6HrPf8lByTOqaiQTLGnG1zfYo5e1Fs4wpiejVDQCjLVxDvgrb5Eu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNjCwaEl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779859041; x=1811395041;
  h=date:from:to:cc:subject:message-id;
  bh=sIUJVM/Tyo5UiOhBXkpeSg0qA95TSz00hm7dg81oVLQ=;
  b=jNjCwaElt5hezlOaypWbOd1s/5eq6kS0Kw2GrdmCcpDh6eXXDaUnq8LZ
   c20kJuTwX1LPiSrOrhhjyzOSBE7v0VfYh7Zzce04cbfmUc/1vgc3GFCsi
   FE+IDtjkFtwRn0000eYG+vd886f2sgxqwv0GqXx4ZPn3MCnPKLmBgRogp
   LBgY0IyeMyWS9eM0yhvkPzRNsRaiPyX/+r8NWwvxHr0dttJUZ2KG5s90h
   zso/MHqBcCF3Gr+4k593D2zLHngYA7gxMDq/4UmcR76p/Rei5Lf0CYd16
   NSH3Nthbty+Ino98eFYXVMXgPO7uxet7SR8ERWdGkfSVsBaJuxsZHX6I5
   g==;
X-CSE-ConnectionGUID: BsfAxokpQOCu257f3skdiw==
X-CSE-MsgGUID: 1o/NCgEmRu+4jF7tPzogQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80792637"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80792637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:17:20 -0700
X-CSE-ConnectionGUID: m5AdRqiiSUKWV4yruMaPgw==
X-CSE-MsgGUID: bYqPCZsCQcmj8U8VD4bNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246386595"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 May 2026 22:17:19 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wS6dn-000000003Qa-3eXx;
	Wed, 27 May 2026 05:17:15 +0000
Date: Wed, 27 May 2026 13:16:24 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, netdev@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 e7e28506af98ce4e1059e5ec59334b335c00a246
Message-ID: <202605271309.olwSbM8A-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292093-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 5CC445DF60F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e7e28506af98ce4e1059e5ec59334b335c00a246  Add linux-next specific files for 20260526

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202605270101.2FFpzoFg-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605270411.oPtYP6rg-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605271203.r58wncYu-lkp@intel.com

    Warning: sound/soc/codecs/max98090.c:2353 function parameter 'data' not described in 'max98090_set_jack'
    alpha-linux-ld: sound/soc/codecs/es9356.o:(.data.rel.ro+0xd0): undefined reference to `sdca_asoc_q78_get_volsw'
    alpha-linux-ld: sound/soc/codecs/es9356.o:(.data.rel.ro+0xd8): undefined reference to `sdca_asoc_q78_put_volsw'
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2357:1: warning: control reaches end of non-void function [-Wreturn-type]
    ld: se_ctrl.c:(.text+0x34b): undefined reference to `mbox_free_channel'
    powerpc64-linux-ld: sound/soc/codecs/es9356.o:(.data.rel.ro+0xd0): undefined reference to `sdca_asoc_q78_get_volsw'
    powerpc64-linux-ld: sound/soc/codecs/es9356.o:(.data.rel.ro+0xd8): undefined reference to `sdca_asoc_q78_put_volsw'
    sparc-linux-ld: sound/soc/codecs/es9356.o:(.rodata+0x18a0): undefined reference to `sdca_asoc_q78_get_volsw'
    sparc-linux-ld: sound/soc/codecs/es9356.o:(.rodata+0x18a4): undefined reference to `sdca_asoc_q78_put_volsw'

Unverified Error/Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202605271103.Ty43jmZr-lkp@intel.com

    drivers/android/binder.c:5306:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/auxdisplay/line-display.c:417:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/base/core.c:3306:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/block/aoe/aoedev.c:507:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/block/drbd/drbd_main.c:2798:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/block/nbd.c:1541:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/block/rbd.c:6678:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/dpll/zl3073x/fw.c:274:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/drm_gem_atomic_helper.c:176:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/drm_prime.c:806:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/tests/drm_gem_shmem_test.c:126:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/media/i2c/cs3308.c:97:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/mmc/host/ushc.c:528:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/most/configfs.c:618:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/rpmsg/qcom_glink_native.c:1014:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/scsi/sd.c:3893:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/tty/serial/max3100.c:742:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/usb/gadget/legacy/inode.c:1637:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/squashfs/decompressor_multi.c:179:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/squashfs/file.c:749:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/ubifs/super.c:261:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    kernel/bpf/verifier.c:1629:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    kernel/trace/trace_events_user.c:863:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    lib/kunit/static_stub.c:122:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    net/ceph/osdmap.c:406:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    net/kcm/kcmsock.c:945 kcm_sendmsg() error: we previously assumed 'head' could be null (see line 787)

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- alpha-linux-ld:sound-soc-codecs-es9356.o:(.data.rel.ro):undefined-reference-to-sdca_asoc_q78_get_volsw
|   `-- alpha-linux-ld:sound-soc-codecs-es9356.o:(.data.rel.ro):undefined-reference-to-sdca_asoc_q78_put_volsw
|-- csky-randconfig-001-20260527
|   |-- drivers-android-binder.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-auxdisplay-line-display.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-base-core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-block-aoe-aoedev.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-block-drbd-drbd_main.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-block-nbd.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-block-rbd.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-dpll-zl3073x-fw.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-drm_gem_atomic_helper.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-drm_prime.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-tests-drm_gem_shmem_test.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-media-i2c-cs3308.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-mmc-host-ushc.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-most-configfs.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-rpmsg-qcom_glink_native.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-scsi-sd.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-tty-serial-max3100.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-usb-gadget-legacy-inode.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-squashfs-decompressor_multi.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-squashfs-file.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-ubifs-super.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- kernel-bpf-verifier.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- kernel-trace-trace_events_user.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- lib-kunit-static_stub.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- net-ceph-osdmap.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- i386-buildonly-randconfig-006-20260526
|   `-- ld:se_ctrl.c:(.text):undefined-reference-to-mbox_free_channel
|-- nios2-allmodconfig
|   `-- Warning:sound-soc-codecs-max98090.c-function-parameter-data-not-described-in-max98090_set_jack
|-- powerpc64-randconfig-r063-20260526
|   |-- powerpc64-linux-ld:sound-soc-codecs-es9356.o:(.data.rel.ro):undefined-reference-to-sdca_asoc_q78_get_volsw
|   `-- powerpc64-linux-ld:sound-soc-codecs-es9356.o:(.data.rel.ro):undefined-reference-to-sdca_asoc_q78_put_volsw
|-- s390-randconfig-r073-20260526
|   `-- net-kcm-kcmsock.c-kcm_sendmsg()-error:we-previously-assumed-head-could-be-null-(see-line-)
|-- sparc-randconfig-002-20260527
|   |-- sparc-linux-ld:sound-soc-codecs-es9356.o:(.rodata):undefined-reference-to-sdca_asoc_q78_get_volsw
|   `-- sparc-linux-ld:sound-soc-codecs-es9356.o:(.rodata):undefined-reference-to-sdca_asoc_q78_put_volsw
`-- um-allyesconfig
    `-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_topology.c:warning:control-reaches-end-of-non-void-function

elapsed time: 772m

configs tested: 207
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260527    gcc-9.5.0
arc                   randconfig-002-20260527    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260527    clang-23
arm                   randconfig-002-20260527    clang-23
arm                   randconfig-003-20260527    gcc-10.5.0
arm                   randconfig-004-20260527    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260527    gcc-8.5.0
arm64                 randconfig-002-20260527    gcc-8.5.0
arm64                 randconfig-003-20260527    clang-23
arm64                 randconfig-004-20260527    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260527    gcc-15.2.0
csky                  randconfig-002-20260527    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260527    clang-23
hexagon               randconfig-002-20260527    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260527    clang-20
i386        buildonly-randconfig-002-20260527    clang-20
i386        buildonly-randconfig-002-20260527    gcc-14
i386        buildonly-randconfig-003-20260527    clang-20
i386        buildonly-randconfig-004-20260527    clang-20
i386        buildonly-randconfig-004-20260527    gcc-14
i386        buildonly-randconfig-005-20260527    clang-20
i386        buildonly-randconfig-005-20260527    gcc-14
i386        buildonly-randconfig-006-20260527    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260527    clang-20
i386                  randconfig-002-20260527    gcc-14
i386                  randconfig-003-20260527    gcc-14
i386                  randconfig-004-20260527    clang-20
i386                  randconfig-005-20260527    clang-20
i386                  randconfig-006-20260527    gcc-12
i386                  randconfig-007-20260527    clang-20
i386                  randconfig-011-20260527    gcc-14
i386                  randconfig-012-20260527    clang-20
i386                  randconfig-013-20260527    clang-20
i386                  randconfig-014-20260527    clang-20
i386                  randconfig-015-20260527    clang-20
i386                  randconfig-016-20260527    gcc-14
i386                  randconfig-017-20260527    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260527    clang-19
loongarch             randconfig-002-20260527    gcc-13.4.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260527    gcc-11.5.0
nios2                 randconfig-002-20260527    gcc-10.5.0
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
parisc                randconfig-001-20260527    gcc-8.5.0
parisc                randconfig-002-20260527    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260527    gcc-8.5.0
powerpc               randconfig-002-20260527    clang-18
powerpc64             randconfig-001-20260527    gcc-8.5.0
powerpc64             randconfig-002-20260527    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260527    gcc-9.5.0
riscv                 randconfig-002-20260527    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260527    gcc-12.5.0
s390                  randconfig-002-20260527    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260527    gcc-14.3.0
sh                    randconfig-002-20260527    gcc-11.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260527    gcc-14.3.0
sparc                 randconfig-002-20260527    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260527    clang-20
sparc64               randconfig-002-20260527    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260527    gcc-14
um                    randconfig-002-20260527    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260527    clang-20
x86_64      buildonly-randconfig-001-20260527    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260527    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260527    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260527    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260527    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260527    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260527    gcc-14
x86_64                randconfig-002-20260527    clang-20
x86_64                randconfig-003-20260527    clang-20
x86_64                randconfig-004-20260527    clang-20
x86_64                randconfig-005-20260527    clang-20
x86_64                randconfig-006-20260527    gcc-14
x86_64                randconfig-011-20260527    gcc-14
x86_64                randconfig-012-20260527    gcc-14
x86_64                randconfig-013-20260527    gcc-14
x86_64                randconfig-014-20260527    clang-20
x86_64                randconfig-015-20260527    gcc-14
x86_64                randconfig-016-20260527    clang-20
x86_64                randconfig-071-20260527    gcc-14
x86_64                randconfig-072-20260527    clang-20
x86_64                randconfig-073-20260527    clang-20
x86_64                randconfig-074-20260527    gcc-14
x86_64                randconfig-075-20260527    clang-20
x86_64                randconfig-076-20260527    clang-20
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260527    gcc-8.5.0
xtensa                randconfig-002-20260527    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

