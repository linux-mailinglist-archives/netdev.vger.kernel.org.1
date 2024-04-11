Return-Path: <netdev+bounces-86806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15F8A05A3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0BF1C219EB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77505612EB;
	Thu, 11 Apr 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcrGoD7T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B360DD3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799784; cv=none; b=hwr40XaYWkp0yQMpQnPHQJHqV3b+c9MwnbEVzJfYOUGAtibo713WdrHhZLA+BjGcaqzvGOhR8oF2PL5G7kqn5sRg3x9sUBKohv9aO7JuyvaxM2S38SfEEkpN+unYuDK6qGQlPF+1LPReTWtQJ3sRWxp5yi64J9+rST1vCckJ9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799784; c=relaxed/simple;
	bh=hoJ/Pv0YyXpskXC5/6lL/iLRY/OyR9NkXVb3BMeV11c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PzDcrSKZVF7RzV9AbmGowZtuVfO//NR78AZ6XfwLjPTmXs3lCN1KWp2yo9R7CKQui8UIRGSc0kqP4nJiT37YZvxZnWusiC3A8kpiQq7SxxeVo5v2mrpvppf4SzKslNjypNiGl9EIGF21GtZuOjfxRN89zl/0HSMRdEFCw688egM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcrGoD7T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712799783; x=1744335783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hoJ/Pv0YyXpskXC5/6lL/iLRY/OyR9NkXVb3BMeV11c=;
  b=KcrGoD7TfeXNLGFundb9bNBIjWOq28xF1mjNKQevLIrStlWi1Qfd1w5t
   WpJLKSYZXg3rmiyr5jWYJ8khW8XEtuPkAWLP2j2O8huf6aQTTIPmVfLoY
   MrKyIiF435VXqDLqIfiVr758SjwtQzv/6SLHxu/x5s9wFT60hhYVL8kOI
   yEVjB3XxSb1VMCVvM0jjcuQEH3eU4VxP1xz7YrKa4Eh7u4Z42jTjIi2HO
   g2NzzJP1554dVS/4X54JgqtP+zmsKuXRAW5xaH4g3yc3GMXVvEYytow3K
   FmpHiustCVLQNGPgi24Cw8Y68FZhuzYgmtMtDw2iCncVumTwherFR/SnX
   Q==;
X-CSE-ConnectionGUID: Pyl0cJ6aQvCcTss5RqXVSA==
X-CSE-MsgGUID: XJWz2vOBQ5ygV7cYXRowZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11972396"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="11972396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 18:43:02 -0700
X-CSE-ConnectionGUID: 4RxbIvMmTEu4dWWn3DeP6A==
X-CSE-MsgGUID: 8N1fNzEjRa+AhaqMtWQBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25405138"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Apr 2024 18:43:00 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rujSs-00085y-00;
	Thu, 11 Apr 2024 01:42:58 +0000
Date: Thu, 11 Apr 2024 09:42:53 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [net:main 2/2] ld.lld: error: undefined symbol: r8169_remove_leds
Message-ID: <202404110940.nOM9bJvF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git main
head:   19fa4f2a85d777a8052e869c1b892a2f7556569d
commit: 19fa4f2a85d777a8052e869c1b892a2f7556569d [2/2] r8169: fix LED-related deadlock on module removal
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240411/202404110940.nOM9bJvF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240411/202404110940.nOM9bJvF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404110940.nOM9bJvF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: r8169_remove_leds
   >>> referenced by r8169_main.c
   >>>               drivers/net/ethernet/realtek/r8169_main.o:(rtl_remove_one) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

