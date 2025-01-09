Return-Path: <netdev+bounces-156735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA46A07B7E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278091692A3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9371222585;
	Thu,  9 Jan 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Spg9n0M/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D7222581
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435475; cv=none; b=q6VSFpBdb3DtJptxSyIhuOg4B+om4ln+3nJqBUL3Wjm08eObpwHKlxU2FJiK7oirSY7BPUDUq3yOiz10Jh/Rx1iNIHuU9YL/Ryj9oji4cTbJpKAL1BdFHbRMLVxGTauJbUjrc8NabWbCwJZBYsEKuZ0ZLAhJcQ1L9AUPgQCj1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435475; c=relaxed/simple;
	bh=HU7e7uZG07NJzXcYEdq4NsEIFIi1I9Em23297u6wM/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPHtQK2EyJi7/sMNYwx5QpYqaeTNBNZKkb+UC/SKCSQrtCm14LzEm+1OqII1jKNTNzAEtjYpS/S7B8otzuJNRmbx7kmfy+KEaIUkc9wRosk30fAPXZbP/QRL0fzwpML9UssewoGd2SzZerPXfy3A6LjdIK1ntxGWIjzYGGg2kic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Spg9n0M/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736435473; x=1767971473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HU7e7uZG07NJzXcYEdq4NsEIFIi1I9Em23297u6wM/I=;
  b=Spg9n0M/sSZnwQjXniQPmLi6WpHqwcYPvoFvS9AmDZkUpbFt9YmeXGEW
   ZFMx9Vo93qJPGVERZ9o9M+pGLs7KsQoWRm7lQNuaKKrsnz05xk4YbFeF/
   J5UHzJpVyxYhsMIdEEME+L4CRWXWQkIr1vY3EF3TI4EmnEO+Tx5qwSxvK
   cwGKq4zAlkYmzv6bcGdZZxZjDpRtiB2ZV2C+MvSH+rn26rJ495Qdd+PuA
   944a6N/qhEQUybCXwlZSq2aptXlcW/vWw5dYYSOsKSShSmeaCL7qVpjE+
   oOXkAzqo4deWg94w+5bOAzgTKgaQAcXZ2BvHtqlbFHB7Lz+dyFV+s3t0M
   w==;
X-CSE-ConnectionGUID: 2LUpUmQnRs2LTRUSAnX+3Q==
X-CSE-MsgGUID: iPfiosYZREGAU2qGh2Y9QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="39524071"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="39524071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 07:11:12 -0800
X-CSE-ConnectionGUID: glbjn9o9QvKvv8JH+mU0xA==
X-CSE-MsgGUID: pt7JtQGTSL6fomevKo5hxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126723153"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2025 07:11:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVuBf-000HiN-2A;
	Thu, 09 Jan 2025 15:11:07 +0000
Date: Thu, 9 Jan 2025 23:10:23 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 1/4] net: expedite synchronize_net() for
 cleanup_net()
Message-ID: <202501092222.Kn4MEI0i-lkp@intel.com>
References: <20250108162255.1306392-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108162255.1306392-2-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-expedite-synchronize_net-for-cleanup_net/20250109-002516
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250108162255.1306392-2-edumazet%40google.com
patch subject: [PATCH v2 net-next 1/4] net: expedite synchronize_net() for cleanup_net()
config: arm-sama5_defconfig (https://download.01.org/0day-ci/archive/20250109/202501092222.Kn4MEI0i-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501092222.Kn4MEI0i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092222.Kn4MEI0i-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: net/core/dev.o: in function `synchronize_net':
   dev.c:(.text+0x1484): undefined reference to `cleanup_net_task'
>> arm-linux-gnueabi-ld: dev.c:(.text+0x1488): undefined reference to `cleanup_net_task'
   arm-linux-gnueabi-ld: net/core/dev.o: in function `dev_remove_pack':
   dev.c:(.text+0x4fa8): undefined reference to `cleanup_net_task'
   arm-linux-gnueabi-ld: dev.c:(.text+0x4fac): undefined reference to `cleanup_net_task'
   arm-linux-gnueabi-ld: net/core/dev.o: in function `free_netdev':
   dev.c:(.text+0x5054): undefined reference to `cleanup_net_task'
   arm-linux-gnueabi-ld: net/core/dev.o:dev.c:(.text+0x5058): more undefined references to `cleanup_net_task' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

