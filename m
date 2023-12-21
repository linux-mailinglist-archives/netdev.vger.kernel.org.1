Return-Path: <netdev+bounces-59822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C048E81C201
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BF0B21C15
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442979470;
	Thu, 21 Dec 2023 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRoJQcEA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4178E72
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703201800; x=1734737800;
  h=date:from:to:cc:subject:message-id;
  bh=QKRGEb6ntQbbWETEGc52fYWEw4HYQa9uwTHsTB26UVw=;
  b=XRoJQcEANWldpCWaKM5owFr/SLzWYAxYbB+E7c/JGWCuVYX2ZTIlfKUp
   Qr6msVtFwcXGWzjZljebUa+xgpVB1/CIITGCKHeQXru0qZ+1/bNc43mHR
   ioZJTA72nkU6f/dwEQUqfxoqHF6ZSNkKfWDPw1DdDf7l5Ostxze+AOB0x
   8m9vL/gsk0Yf29OjfLQ3Ix5Q6mXi6fCtCgbDU8+7s5sdORmtOX5n7D69e
   UTAnZj0C6hHHNnXGmT42cYoI6dXosBO17ghw+3jwSzW0Vlwd968UHSVzf
   QJ35jVLJ9YM4U8OHNiCxHY750e/szLT2zjjtaH2gV2bm5nqXiAGcKfG6z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3296493"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3296493"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 15:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895268140"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895268140"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2023 15:36:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGSaG-0008ro-0B;
	Thu, 21 Dec 2023 23:36:23 +0000
Date: Fri, 22 Dec 2023 07:35:36 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 alsa-devel@alsa-project.org, netdev@vger.kernel.org,
 patches@opensource.cirrus.com
Subject: [linux-next:pending-fixes] BUILD REGRESSION
 c6eb02b33bd24f8f4a60947b539db4871ef914cd
Message-ID: <202312220731.p0jrL7zG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: c6eb02b33bd24f8f4a60947b539db4871ef914cd  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312211413.1NkzZWqi-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

sound/pci/hda/cs35l41_hda_property.c:238: undefined reference to `spi_setup'

Unverified Error/Warning (likely false positive, please contact us if interested):

net/core/stream.c:82:13-14: WARNING opportunity for min()

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-051-20231010
    `-- sound-pci-hda-cs35l41_hda_property.c:undefined-reference-to-spi_setup
clang_recent_errors
`-- x86_64-randconfig-102-20231221
    `-- net-core-stream.c:WARNING-opportunity-for-min()

elapsed time: 1457m

configs tested: 2
configs skipped: 0

tested configs:
x86_64                            allnoconfig   gcc  
x86_64                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

