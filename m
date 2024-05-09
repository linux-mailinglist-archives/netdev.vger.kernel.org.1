Return-Path: <netdev+bounces-94805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E68C0B46
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B722283650
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3651494BD;
	Thu,  9 May 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY/Sw4rk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109691494B8
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715234478; cv=none; b=N6BJnhwj+Xi5b3lLk9vBFJ7N4akKHxxnRF//0m9ECT7bNyYeMogzglnj6t/Mq6n8yK8Ieg35M8ijAiDjsKnb67fT76MwHwL0xpPTloS0yLbRi1q/MRedztL/ni5vUiNSiYfa82n+c8mjpH/hsSLN/z34IfQx/xL6nQJuXLnSW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715234478; c=relaxed/simple;
	bh=S/MVZRULVDyrUtXP/nK9eDK3Jsi7ratojp8mojszynM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX2bH6hKKsLVW21YUYAr6oLrLmWr4bsSUpOYlUlErxBQcoMXQ4sBXuUgD7ejq5mdN8wdZNHw2oMnAvzb4GRdbMxP9WLSBN2xGAK/+zoWk181NUPWvSt18YJmZdLDJsGixAE6cUlmZdxLI9zh3BqCDTma71UJAgcfelnsoIXlHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY/Sw4rk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715234476; x=1746770476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/MVZRULVDyrUtXP/nK9eDK3Jsi7ratojp8mojszynM=;
  b=EY/Sw4rkebEj/sgnRIiHkjXTnZsDsuk5t+7IhuU5hdQhkA0nuokxEqOG
   SWnhw/bN2xrnuey92eSM23H5bazj6Vp9RkxgIUE2clvqsuyzFFJ01gzp+
   3rtxvwpCXk/ta8jiBmZJfPqTnDwuRoDacjti4tfyaQPHUGoELY+EYOfUw
   EfCyfGQRvJRqAxmZelHEI7TF6eh7LDvVDOP/W+aL2Engh2525szQfHzf0
   Svnhd4q/AnDEJxgHGi5N0eZAtg5aIWZVwTLfMg7FVx3+/oDVR4z0CeuU5
   aAUX8MWNLOJGvWKkUGTEP0UFTIq+uVCfjP8nprK4VDxAfE1LiXcXmH8kd
   A==;
X-CSE-ConnectionGUID: AO3WkSLCSF6LYyxuMDg8mA==
X-CSE-MsgGUID: xcygRezOSVa5/mUpfUTe4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22537627"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="22537627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 23:01:07 -0700
X-CSE-ConnectionGUID: mu4NNIakSeCSwqzvSQ/Dyw==
X-CSE-MsgGUID: mhd8fBbrRF+nHHsS/1XTdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="33607618"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2024 23:01:02 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4wpw-0004Vg-1B;
	Thu, 09 May 2024 06:01:00 +0000
Date: Thu, 9 May 2024 14:00:26 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 net-next] net: usb: smsc95xx: stop lying about
 skb->truesize
Message-ID: <202405091310.KvncIecx-lkp@intel.com>
References: <20240508075159.1646031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508075159.1646031-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-usb-smsc95xx-stop-lying-about-skb-truesize/20240508-155316
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240508075159.1646031-1-edumazet%40google.com
patch subject: [PATCH v2 net-next] net: usb: smsc95xx: stop lying about skb->truesize
config: arc-randconfig-r132-20240509 (https://download.01.org/0day-ci/archive/20240509/202405091310.KvncIecx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240509/202405091310.KvncIecx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405091310.KvncIecx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/usb/smsc95xx.c:1815:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned short x @@
   drivers/net/usb/smsc95xx.c:1815:19: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/usb/smsc95xx.c:1815:19: sparse:     got unsigned short x
   drivers/net/usb/smsc95xx.c: note: in included file (through include/net/checksum.h, include/linux/skbuff.h, include/net/net_namespace.h, ...):
   arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment (-=) to restricted __wsum
   arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __sum16 @@     got unsigned int @@
   arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted __sum16
   arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int

vim +1815 drivers/net/usb/smsc95xx.c

  1810	
  1811	static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
  1812	{
  1813		u16 *csum_ptr = (u16 *)(skb_tail_pointer(skb) - 2);
  1814	
> 1815		skb->csum = get_unaligned(csum_ptr);
  1816		skb->ip_summed = CHECKSUM_COMPLETE;
  1817		skb_trim(skb, skb->len - 2); /* remove csum */
  1818	}
  1819	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

