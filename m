Return-Path: <netdev+bounces-204272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F4AF9D96
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 03:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41EB6E14B3
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FD1ACEDA;
	Sat,  5 Jul 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lE4Z47CJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864B13AF2;
	Sat,  5 Jul 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678406; cv=none; b=ogac5M04E1nwXjFPlK8wgbxwu/MFyyEYD8kR4FnsI6jyCELgAZkI4eQtEd5ZRbJ+r1WFQvVsgXba7wydd1r1piDMJekbf/McwNn/nNlRkym8wuJEYKwBLmdDF+n6mTR6GWY6+64L6H0R2fwuUSMjhc4AbCu67pkqhx5y2liJv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678406; c=relaxed/simple;
	bh=8Y8n8B3BoqNB1B8GJbvTAFfoTSxMib31OsR6t2OeupI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvYSvXf09Ji7fYOnrrVAank14Qe4r2wWSCjfUr4NiASw2umEqfbhYKwhOSFXUJmGBA7cVx07CVy7bEA2vtuPO9dlx/1K/hPLnH951I0/NbQ+GAZfQV2nTVdxN/WsgzYotILKhYWPyZDPK8NQ6XQkQ5r5yd93CNEr4tWov2EXm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lE4Z47CJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751678405; x=1783214405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Y8n8B3BoqNB1B8GJbvTAFfoTSxMib31OsR6t2OeupI=;
  b=lE4Z47CJQe4s3HHyCJm72xzk9k1KqGvIBOBsbv8Lo+fy+9oPfAsb/f4M
   HGj346/B55kHNnqk7kxhREoKlg+PuTOBDfi856R3DOCqhXAR26QLHTzzv
   r6fAjMS4ii8EgIt+RL1sbk5DuOp8Mkna7CfZaPMf/l3konCpRqhFkQ1Dy
   +u+S0ojxKoXPSfpByvuH8ghewiBKWqx0GrD4vgzTsXZgJblCKQf62YSvV
   W1CM9ns6b0UyVrsAfvy3mxV5YDRlJ13EKeTVSKlbijuOIfwvAxFNQoBRB
   XMZ51q2bvjW+E5BHk9EOXC5jVm8M844vVjM3S79TLz4b3EB7oYSyVENvZ
   Q==;
X-CSE-ConnectionGUID: JORpcVKcSmSOVOIG3KWzNA==
X-CSE-MsgGUID: RQjpQ4TbQni9nuipYUPytQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="79438591"
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="79438591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 18:20:05 -0700
X-CSE-ConnectionGUID: v5StXrznTzyJgs3Br5MgRQ==
X-CSE-MsgGUID: 9ffFj94CQOy4esuKkDDozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="159089068"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Jul 2025 18:20:01 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXrZP-0004BX-11;
	Sat, 05 Jul 2025 01:19:59 +0000
Date: Sat, 5 Jul 2025 09:19:17 +0800
From: kernel test robot <lkp@intel.com>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	mingo@kernel.org, tglx@linutronix.de, pwn9uin@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v3] net: atm: Fix incorrect net_device lec check
Message-ID: <202507050831.2GTrUnFN-lkp@intel.com>
References: <20250703052427.12626-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703052427.12626-1-linma@zju.edu.cn>

Hi Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Ma/net-atm-Fix-incorrect-net_device-lec-check/20250703-132727
base:   net/main
patch link:    https://lore.kernel.org/r/20250703052427.12626-1-linma%40zju.edu.cn
patch subject: [PATCH net v3] net: atm: Fix incorrect net_device lec check
config: x86_64-randconfig-078-20250705 (https://download.01.org/0day-ci/archive/20250705/202507050831.2GTrUnFN-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507050831.2GTrUnFN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507050831.2GTrUnFN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "is_netdev_lec" [net/atm/mpoa.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

