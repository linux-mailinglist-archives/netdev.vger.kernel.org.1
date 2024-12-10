Return-Path: <netdev+bounces-150622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425949EB002
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3376F162963
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4172153C0;
	Tue, 10 Dec 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On7zv4yE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067D215773;
	Tue, 10 Dec 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830606; cv=none; b=LA7z+Ypn8XD2vYVggRaLF9Lf7aqT2m69DHzp/GR9hAZ+ulNb8Vr3IskY9jfJSPgKxk17HpNYN37/ZBzn6lpd19SMZ8gCfdemX8t58jg6tC3cZ+cLzfi57La+3++eiedXL7fm90naExh1B+37x4ZB7ZiiwxVYFNFWiWiKz536FV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830606; c=relaxed/simple;
	bh=tFukGSdVcRfo7BjKJxP9JFbwgrH3R5mr2GurHftOwVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD/JMduhiZzqyhrkjFK/vVM82DTnI30OHBwCn12GQ1s5QenOkFCUk2kFFKpLPGPKoyrU3TuVfOEy9fUx2T5k97zds1iyq2QRlIKzrr1UnguDVf2KeiMtMmSr+O9o6lrqhLHcbleG3w2xrCIm3rTjl34XCtdwSUhSuTZqxnwAeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On7zv4yE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733830605; x=1765366605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFukGSdVcRfo7BjKJxP9JFbwgrH3R5mr2GurHftOwVo=;
  b=On7zv4yEudpywQ4+rG5TDu9P1jlHeoqBpgbXw0fxmFBy2ZRersLbolpW
   kUhdOpX9JfO310kjw+cw5AmjEoCj8JJ7MTI4oSIgTPYNJDXBRRsS3Fude
   7pS9BrKdEAva5YlWg/f5BaiwRw9irxswZj60DflBP/IEoOCx2+ncQOWLo
   J6YRKhFiZiFBCwlsXV9SmyDuPEHyIZWjeGgKUmb8xCXnxhHin0QF8y6rU
   9IPdUd8ay62qVUkVUoVZ1pAae/7xwciIT0/c9cYh46ye9SK4ux2ZxhXNq
   GR0MarBTf3ZrsYnnbvhBzTlldpYqva9S2nHjw7T9sJcR3l3+erDsYkkfq
   Q==;
X-CSE-ConnectionGUID: 7N/lEQmTTCiPiH2Ek6Ed5Q==
X-CSE-MsgGUID: P2BFhxh1SOKMl2tnTNro3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33498300"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="33498300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 03:36:43 -0800
X-CSE-ConnectionGUID: G5xZz9cUTXiym/xnzjxrog==
X-CSE-MsgGUID: 8fj7j00/QQOeNX34eSSlaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100428898"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Dec 2024 03:36:37 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKyXa-0005TZ-1x;
	Tue, 10 Dec 2024 11:36:34 +0000
Date: Tue, 10 Dec 2024 19:35:59 +0800
From: kernel test robot <lkp@intel.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@android.com
Subject: Re: [PATCH net-next v9 1/1] binder: report txn errors via generic
 netlink
Message-ID: <202412101942.kbghVu3V-lkp@intel.com>
References: <20241209192247.3371436-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209192247.3371436-2-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6145fefc1e42c1895c0c1c2c8593de2c085d8c56]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/binder-report-txn-errors-via-generic-netlink/20241210-032559
base:   6145fefc1e42c1895c0c1c2c8593de2c085d8c56
patch link:    https://lore.kernel.org/r/20241209192247.3371436-2-dualli%40chromium.org
patch subject: [PATCH net-next v9 1/1] binder: report txn errors via generic netlink
config: s390-randconfig-002-20241210 (https://download.01.org/0day-ci/archive/20241210/202412101942.kbghVu3V-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241210/202412101942.kbghVu3V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412101942.kbghVu3V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/android/binder.c:1983: warning: Function parameter or struct member 'file' not described in 'binder_task_work_cb'
   drivers/android/binder.c:1983: warning: Excess struct member 'fd' description in 'binder_task_work_cb'
   drivers/android/binder.c:2434: warning: Function parameter or struct member 'offset' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2434: warning: Function parameter or struct member 'skip_size' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2434: warning: Function parameter or struct member 'fixup_data' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2434: warning: Function parameter or struct member 'node' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2454: warning: Function parameter or struct member 'offset' not described in 'binder_sg_copy'
   drivers/android/binder.c:2454: warning: Function parameter or struct member 'sender_uaddr' not described in 'binder_sg_copy'
   drivers/android/binder.c:2454: warning: Function parameter or struct member 'length' not described in 'binder_sg_copy'
   drivers/android/binder.c:2454: warning: Function parameter or struct member 'node' not described in 'binder_sg_copy'
   drivers/android/binder.c:4181: warning: Function parameter or struct member 'thread' not described in 'binder_free_buf'
>> drivers/android/binder.c:7185: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Add a binder device to binder_devices


vim +7185 drivers/android/binder.c

  7183	
  7184	/**
> 7185	 * Add a binder device to binder_devices
  7186	 * @device: the new binder device to add to the global list
  7187	 *
  7188	 * Not reentrant as the list is not protected by any locks
  7189	 */
  7190	void binder_add_device(struct binder_device *device)
  7191	{
  7192		hlist_add_head(&device->hlist, &binder_devices);
  7193	}
  7194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

