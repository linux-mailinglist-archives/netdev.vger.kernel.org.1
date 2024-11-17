Return-Path: <netdev+bounces-145620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A29D0254
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 08:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9272B1F21BE8
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71873D551;
	Sun, 17 Nov 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftWKNMzF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7426ACD;
	Sun, 17 Nov 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731828256; cv=none; b=YqyisRiGk7CHmV0oOlWFUjk/Pxx1oBqEX9weiOvV7kf4iZMm9q/MgFybD+hdhvrM1eUkrbPBNPVd2HUgZEuNIfrR4kBEhlyzocaOR2hNt7jXz1p5JKFfzEiZgk/OifEZaGivsStc9p3bVsqvYhXbSF77sOmp0nVB4JjklPrMPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731828256; c=relaxed/simple;
	bh=PIpxrPsJhzncZLir5a0JaLLfnHxWYWwe2urMxNiGP8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbR4A/ZGrfCjaMZ1LodjnVKI1RmLB8FXGFI/+ik+Natr2hwSvrsJq27IoOySgVhS9XhmvzB9CZTS4uJ6eXHaFXx5HgmkD+bz55bWFh6VClXTHHsllpPqdxpZ8QUEXPix0BANY8wjLZI+khJML5FD8y62fqJAb6bhtKXtE6MVAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftWKNMzF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731828255; x=1763364255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PIpxrPsJhzncZLir5a0JaLLfnHxWYWwe2urMxNiGP8Q=;
  b=ftWKNMzFGee6zTPu1wDKYzIUw0V2qVkIyeGrp0txQVfRWwSnCbfugCzs
   llxSAXRPH+mIFMqAmrR2Qf4G7Ao47Gs5sW8DLtztDJHeKG0yY0QEinBKX
   0tRe/c8JwZs8HZK8aEtODDnuHuZdlWd/Nerp3LMpOb3pQ4FhYNCT3s9q/
   kBiGPpGF/bz3uX/K6lnwoYrAg4oyy37UVu+NRZrgqTclkMoefgDYaKV54
   tQWHTndMUnBXg+SROVHdk4uaOi1g0NZhKYSFY/Qef+i+DVaFHnQwF2Sr1
   88c9Eh+vvsU6saNiOT+zK3zVGa1QD16WAAvOgTkByxdsvLN91TUPNnLn+
   g==;
X-CSE-ConnectionGUID: aL+A60hkSfihFte19PENsw==
X-CSE-MsgGUID: Te/0ccHPSEmXQpA7lrnPuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="42321238"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="42321238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 23:24:13 -0800
X-CSE-ConnectionGUID: qYG51FVbSaKTOja1pCCeKw==
X-CSE-MsgGUID: 6bMcVYbNTWGGkV9IsAVA0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88834652"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Nov 2024 23:24:07 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCZdc-0001cn-1t;
	Sun, 17 Nov 2024 07:24:04 +0000
Date: Sun, 17 Nov 2024 15:23:42 +0800
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
Subject: Re: [PATCH net-next v8 2/2] binder: report txn errors via generic
 netlink
Message-ID: <202411171514.Vfp0RaLK-lkp@intel.com>
References: <20241113193239.2113577-3-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113193239.2113577-3-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 31a1f8752f7df7e3d8122054fbef02a9a8bff38f]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/tools-ynl-gen-allow-uapi-headers-in-sub-dirs/20241114-033521
base:   31a1f8752f7df7e3d8122054fbef02a9a8bff38f
patch link:    https://lore.kernel.org/r/20241113193239.2113577-3-dualli%40chromium.org
patch subject: [PATCH net-next v8 2/2] binder: report txn errors via generic netlink
config: arc-randconfig-001-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171514.Vfp0RaLK-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171514.Vfp0RaLK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171514.Vfp0RaLK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/android/binder.c:1977: warning: Function parameter or struct member 'file' not described in 'binder_task_work_cb'
   drivers/android/binder.c:1977: warning: Excess struct member 'fd' description in 'binder_task_work_cb'
   drivers/android/binder.c:2428: warning: Function parameter or struct member 'offset' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2428: warning: Function parameter or struct member 'skip_size' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2428: warning: Function parameter or struct member 'fixup_data' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2428: warning: Function parameter or struct member 'node' not described in 'binder_ptr_fixup'
   drivers/android/binder.c:2448: warning: Function parameter or struct member 'offset' not described in 'binder_sg_copy'
   drivers/android/binder.c:2448: warning: Function parameter or struct member 'sender_uaddr' not described in 'binder_sg_copy'
   drivers/android/binder.c:2448: warning: Function parameter or struct member 'length' not described in 'binder_sg_copy'
   drivers/android/binder.c:2448: warning: Function parameter or struct member 'node' not described in 'binder_sg_copy'
   drivers/android/binder.c:4180: warning: Function parameter or struct member 'thread' not described in 'binder_free_buf'
>> drivers/android/binder.c:7161: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Add a binder device to binder_devices


vim +7161 drivers/android/binder.c

  7159	
  7160	/**
> 7161	 * Add a binder device to binder_devices
  7162	 * @device: the new binder device to add to the global list
  7163	 *
  7164	 * Not reentrant as the list is not protected by any locks
  7165	 */
  7166	void binder_add_device(struct binder_device *device)
  7167	{
  7168		hlist_add_head(&device->hlist, &binder_devices);
  7169	}
  7170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

