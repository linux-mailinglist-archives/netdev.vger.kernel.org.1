Return-Path: <netdev+bounces-205952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BDB00E31
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB371C83920
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3C28D83B;
	Thu, 10 Jul 2025 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK+ks/QZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DC28C2B1
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184325; cv=none; b=Y0IDvvg+3cp7/p6qQPnsUxQJCD+U3KnBmfv4rK+Q3nW/0QIUauAQ3Z4NkxMVcCSACYY5kWoU+8kz2Lfm9dG/Pc9THLiF9hVyOPSVjFxJJls1f8uiuXxUPXjH7c5RrWU1nbBFp3gGf7TTaG1NFkU8wM5fGsGoI0SH2hz2HIOkoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184325; c=relaxed/simple;
	bh=VxX8r4Kv4dnjWORbDr9JbxUX4wzH/Up1UeuuEiict/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be8JQR01rn7jy/MCS6uEh6YRhQlu46znT402j4NWEb3SNXA7N7YUSH8yFGvgra8opgc6L8AJEl4qFqN3AWuykq0Ph1xB815TLl6cz0IGBXiCRor4beNMaLNJqBhT9ErY+raxFINBryMQ4z8E7GpDpjPo3ldFFWJ0XXWagTOtnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK+ks/QZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752184323; x=1783720323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxX8r4Kv4dnjWORbDr9JbxUX4wzH/Up1UeuuEiict/I=;
  b=iK+ks/QZoOJpN4TQ7+hpWwduO/ZzV3ljo9sjVh0faJpiBJYkUbyfNzqu
   DyjrVGzATpliOXFCsKFCts+HlfWyZDHgJh1ZgG0OZ82TJPWQ9nizoX4e8
   vAhm/SkUR16G9Fzv6AA1U9kcaab6iOpLyCfypm5k2WNrGdJjh/s/gMSjV
   zn0jv7WP2N3/nZPExC4MGj2/p52kQe8Do1IvbxWEhQMxKAoZufSfTMXd0
   pI952+s4weaeJkfz0+xJFLlImftgv5FjT+2xlfLcW0s+TMsnHSkaI071X
   Xmrr8olwOYE+PRL+5vDBdfNhwbUWvtgC/nzHBvnDCXJ82VU62MWfey/j1
   A==;
X-CSE-ConnectionGUID: Wpto+CnsTD+PVLEl5iHz7Q==
X-CSE-MsgGUID: jb7MMKeCT6OUt0vEQeXAxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="72060512"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="72060512"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:52:02 -0700
X-CSE-ConnectionGUID: Q+2XRMZ7RL+GUZZv+FBCXA==
X-CSE-MsgGUID: 08DPUOqbTMSqS3oIhw2bsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156761974"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jul 2025 14:52:00 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZzBO-0005VP-0n;
	Thu, 10 Jul 2025 21:51:58 +0000
Date: Fri, 11 Jul 2025 05:51:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] dev: Pass netdevice_tracker to
 dev_get_by_flags_rcu().
Message-ID: <202507110521.NJvbOpJK-lkp@intel.com>
References: <20250709190144.659194-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709190144.659194-1-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/dev-Pass-netdevice_tracker-to-dev_get_by_flags_rcu/20250710-030425
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250709190144.659194-1-kuniyu%40google.com
patch subject: [PATCH v1 net-next] dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20250711/202507110521.NJvbOpJK-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110521.NJvbOpJK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110521.NJvbOpJK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/core/dev.c:1281 function parameter 'tracker' not described in 'netdev_get_by_flags_rcu'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

