Return-Path: <netdev+bounces-173353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D844A58667
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8551881181
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530C1DF256;
	Sun,  9 Mar 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPdbdrRL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3371CAA76
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542259; cv=none; b=jA2WKmo2Wk0SQ4LjkhUcX8g3SwEO/BPMCiwTMiIj1fNORwsyanf+Y1Mmo5woIaYy8gjnImzhS4Dfy5DHQH0ALxlDAYdLQQenJJN2/4Kop1RLi+gSbAoAJefyP6gjSU86sd3+i7ECCGrFBnwptEf2drM86An7iNk5yI3IsjlYHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542259; c=relaxed/simple;
	bh=MZFrbPDZGE4WNjB0lXEiGCpTm6y6Xwi3WYpwVwOprME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfNI/GggzXr5MkapLCaPgJ4xq+mXTV2TQ+5GexNS1uyPivoG5N2MDiY2rPzmgfyvHQ5wzE7lPjwxCOiKkl+9JAo4auynrP+DMwDUjrwXdWL32EqKZf3bSvWt4wJGvIbwbpaQUrEvrFRSWO3tDaTVJrm1ClJHIFy92ZHJEEwdx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPdbdrRL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741542258; x=1773078258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MZFrbPDZGE4WNjB0lXEiGCpTm6y6Xwi3WYpwVwOprME=;
  b=iPdbdrRLjNh0AiJxdY+J+Og6waJmxizesYfbznREOs3e5ygLXvpd9oFh
   AHpsKT2dgbIKCaRS58JZedPwstt17O0RRK+owFUF+U7a+rvsKFxH+OMhQ
   fJK9N2pK/rxrQ8nt4TQii8uezXm1LNSZDKhEl+Xu2j4djqdoP13UPAEb+
   dTbT3zHFG71bpE+E83qrJ2Qn57pzVxDFSBn2yXlO3b2R1MuSfYZaEYpLE
   9ZYsu0e6PE51anvWTTwRYhfZj0utRHnsXuknn9XP16alry5m5YESzT8Tk
   IXauq+es3oK6kq8oR4neJ9NuyiAXcRSFEgciMqLYgkOi0uxfM4ey0Rxuy
   Q==;
X-CSE-ConnectionGUID: lhDK8CnJTgWYDYUXLsiHjg==
X-CSE-MsgGUID: Fs0OUDH1TLuiX8BPPwYQzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="45332792"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="45332792"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 10:44:17 -0700
X-CSE-ConnectionGUID: LnNh3bERT0qEUK+qPgGTCg==
X-CSE-MsgGUID: HKWD8dl0Simz2qNe1UR2bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124708920"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 09 Mar 2025 10:44:14 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trKh9-0003L6-27;
	Sun, 09 Mar 2025 17:44:11 +0000
Date: Mon, 10 Mar 2025 01:43:30 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>,
	syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: lapbether: use netdev_lockdep_set_classes()
 helper
Message-ID: <202503100139.oHyPmygJ-lkp@intel.com>
References: <20250309093930.1359048-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309093930.1359048-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-lapbether-use-netdev_lockdep_set_classes-helper/20250309-174127
base:   net/main
patch link:    https://lore.kernel.org/r/20250309093930.1359048-1-edumazet%40google.com
patch subject: [PATCH net] net: lapbether: use netdev_lockdep_set_classes() helper
config: i386-buildonly-randconfig-004-20250309 (https://download.01.org/0day-ci/archive/20250310/202503100139.oHyPmygJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503100139.oHyPmygJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503100139.oHyPmygJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wan/lapbether.c:42:10: fatal error: net/netdev_lock.h: No such file or directory
      42 | #include <net/netdev_lock.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +42 drivers/net/wan/lapbether.c

    41	
  > 42	#include <net/netdev_lock.h>
    43	#include <net/x25device.h>
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

