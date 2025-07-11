Return-Path: <netdev+bounces-206118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92AB01A43
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480687B816D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C612882B6;
	Fri, 11 Jul 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C91tenZg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F92836B5;
	Fri, 11 Jul 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231873; cv=none; b=YGk/RsGaUtNSYLxhVfNvtVjHYnYOYH1zIMDsDH9PLV+/MGgP3FwGxR8yNOyBWbq0oWAucdSBAU4BGOsYkMzvUd+gzpPR2sgD0vyDMb/605QClMIGube1VbcCxldHXQ61A2Cplkkyg4PDfM642KQSl01/eaV2NHi2kk0FJ4U4guY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231873; c=relaxed/simple;
	bh=nFLgi7//BECQmXxDWxXRsQ3oWB5Qx+laxM0VeYpYygc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1hRm3bIuhOsCOolrp1/+QicSJqzlv/az9SIhkCB5vvw5zUa8bT3Rh322a02v9Kbn9e+ws9LVsRjRcdY3hrCSIkqJnyHZ3+GJ3/1veDXqYa9lFaprhkNr+uXQJK7a7HSKqXR2si0cKXkeK1YFsfD/SpqHGTajpiaW9SCbStNbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C91tenZg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752231872; x=1783767872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nFLgi7//BECQmXxDWxXRsQ3oWB5Qx+laxM0VeYpYygc=;
  b=C91tenZgC6MpStFkIdbr9DFp5o7iu9gVCRl1XaEejv+jHwvHDpmh2A/t
   7iILBiW537X9MsYavYjVlCRYK41O0Rz4fdibQuJRGRlYLPFeGxKYt5DJd
   aZrRZoqCjS8WKL4iwp/bTFE/xFyC94dUkhSS/N1y3OvIL6iFFK6LUYWAl
   kSyiNlRZ62OC12JvqdG2L7YjJyp4P262HuzCm+hsb5HPeJHFMg+YaPNcb
   iFVHjCdh1uDbihsq0ZmswzKQB7J11wYBKauWKmHuZLo5SYE5LABH08/I9
   8In8PNFyoxCmXyE4PxjztG1mFne1sMNEgqAu02IX4s2xTsjMYDYC1pEgQ
   A==;
X-CSE-ConnectionGUID: TKurDnhsShCsoUpUY+lNvA==
X-CSE-MsgGUID: Qw7531H0RRy7u4v53Es6NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58291536"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58291536"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 04:03:23 -0700
X-CSE-ConnectionGUID: k8Eh6q1JQ1KZfBO6cJAURA==
X-CSE-MsgGUID: xfwK3S46RCGxcTshm6tHJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156837141"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Jul 2025 04:03:20 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaBXB-0006Hf-1v;
	Fri, 11 Jul 2025 11:03:17 +0000
Date: Fri, 11 Jul 2025 19:02:47 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v22 2/2] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <202507111843.OV6uA3Jr-lkp@intel.com>
References: <20250710191209.737167-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710191209.737167-3-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mailbox-pcc-support-mailbox-management-of-the-shared-buffer/20250711-031525
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250710191209.737167-3-admiyo%40os.amperecomputing.com
patch subject: [PATCH net-next v22 2/2] mctp pcc: Implement MCTP over PCC Transport
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250711/202507111843.OV6uA3Jr-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507111843.OV6uA3Jr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507111843.OV6uA3Jr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/mctp/mctp-pcc.c:71:8: warning: variable 'skb_buf' set but not used [-Wunused-but-set-variable]
      71 |         void *skb_buf;
         |               ^
   1 warning generated.


vim +/skb_buf +71 drivers/net/mctp/mctp-pcc.c

    65	
    66	static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
    67	{
    68		struct mctp_pcc_mailbox *box;
    69		struct mctp_pcc_ndev *mctp_pcc_ndev;
    70		struct sk_buff *skb;
  > 71		void *skb_buf;
    72	
    73		box = container_of(c, struct mctp_pcc_mailbox, client);
    74		mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
    75		if (size > mctp_pcc_ndev->mdev.dev->mtu)
    76			return NULL;
    77		mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
    78		skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, size);
    79		if (!skb)
    80			return NULL;
    81		skb_buf = skb_put(skb, size);
    82		skb->protocol = htons(ETH_P_MCTP);
    83	
    84		skb_queue_head(&box->packets, skb);
    85	
    86		return skb->data;
    87	}
    88	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

