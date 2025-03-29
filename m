Return-Path: <netdev+bounces-178210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEAEA757E9
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 22:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7D93AD156
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB21ACEAC;
	Sat, 29 Mar 2025 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+20sniR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AA1F956
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743283104; cv=none; b=DzqdcWfgXumaFsM1db52OCckCeCYl5jgS95idgFmVYx5CwT2p0fIC85MsU/9WZGAsRXFx0XuRg6pwG1MaGXgXKrdlhwDp/+mLB9hSIdqZcSMbA+MEp700NBfV+ANxIx80df44TYEcsAxdjOVnXZW0O4LnUMzUsn6lYF6Ew/+rAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743283104; c=relaxed/simple;
	bh=LaK1nWX1mHWHVT7PGXWOLxdhzERpRL0pz6vlZ3x5QKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alPjtIwSgGtnQfICj7caLgHwlNEtFKxhOnFjMIUIvZkqZIlsO+gUeFodsOythpES49hUy1F41DnCopptxGXgKxlkKEAEQs5Xdbl9D/I8mikdqyQphjFEejIjZhE22NC0yB3kutM9Zfqk+y5co/xe5FXVtLSUed1DQ4WNH+dp8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+20sniR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743283102; x=1774819102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LaK1nWX1mHWHVT7PGXWOLxdhzERpRL0pz6vlZ3x5QKQ=;
  b=R+20sniRGDu2mgszWpFCDy5Ijw0Hk5sZDFDO10r3W9JkMLtE1D6fUHxY
   52HLFiISyZEtAho9MS+LBuN+ONAgbYGFCtCOc3PlEqN7xaAsvp60zOx27
   v4Qwg1ZSQtAlpUW0Rk/NaAtts9nDdY/jRDaymid9OHLOp6WJ7UvgbqKYA
   iwQqDSEF5HNy0PTYBGKnTkoZTA5dF2nPZdfYUW9RsqQ3Jxdjh0y929stz
   P9iFpqGC1+PDGiYyaCNBE8rAMRWqpCoc+GYLLp5JZkaBAnxPJdok3iqJy
   lnFkC/hIlVYf+wozpJN1hT5qRxz2LGd2DD8PZWUSHrvXa6o4eXvTgX29U
   g==;
X-CSE-ConnectionGUID: 8MAn7mvkTvuYMpfN1p1sug==
X-CSE-MsgGUID: Wsj1n20rRgOMAJhmpGzZ9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="55987928"
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="55987928"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 14:18:22 -0700
X-CSE-ConnectionGUID: ZLaW9X9kSb2IGp6WUcPrKQ==
X-CSE-MsgGUID: tT6KxDqNSs+yPTCog9w51A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="129868718"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2025 14:18:19 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tydZJ-0008N8-1C;
	Sat, 29 Mar 2025 21:18:17 +0000
Date: Sun, 30 Mar 2025 05:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v3 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <202503300541.24wTsWWQ-lkp@intel.com>
References: <20250329185704.676589-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329185704.676589-2-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-switch-to-netif_disable_lro-in-inetdev_init/20250330-030132
base:   net/main
patch link:    https://lore.kernel.org/r/20250329185704.676589-2-sdf%40fomichev.me
patch subject: [PATCH net v3 01/11] net: switch to netif_disable_lro in inetdev_init
config: i386-buildonly-randconfig-002-20250330 (https://download.01.org/0day-ci/archive/20250330/202503300541.24wTsWWQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250330/202503300541.24wTsWWQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503300541.24wTsWWQ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/core/dev.c:1774:1: warning: data definition has no type or storage class
    1774 | EXPORT_IPV6_MOD(netif_disable_lro);
         | ^~~~~~~~~~~~~~~
>> net/core/dev.c:1774:1: error: type defaults to 'int' in declaration of 'EXPORT_IPV6_MOD' [-Werror=implicit-int]
>> net/core/dev.c:1774:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors


vim +1774 net/core/dev.c

  1756	
  1757	void netif_disable_lro(struct net_device *dev)
  1758	{
  1759		struct net_device *lower_dev;
  1760		struct list_head *iter;
  1761	
  1762		dev->wanted_features &= ~NETIF_F_LRO;
  1763		netdev_update_features(dev);
  1764	
  1765		if (unlikely(dev->features & NETIF_F_LRO))
  1766			netdev_WARN(dev, "failed to disable LRO!\n");
  1767	
  1768		netdev_for_each_lower_dev(dev, lower_dev, iter) {
  1769			netdev_lock_ops(lower_dev);
  1770			netif_disable_lro(lower_dev);
  1771			netdev_unlock_ops(lower_dev);
  1772		}
  1773	}
> 1774	EXPORT_IPV6_MOD(netif_disable_lro);
  1775	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

