Return-Path: <netdev+bounces-109093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EC926D94
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E701C20D7C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C8171A7;
	Thu,  4 Jul 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6H6387p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A4FC02;
	Thu,  4 Jul 2024 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061187; cv=none; b=pbGHffycHXBj0fG7t9X/60kdH+oOBCfz06ekbklSPWK3hGfIyLdP5hEON3SjgLB0Xwuw/PRmStwbh/k/D+9VYFkR11LTAuLFJ2ZSwgKGcYDbl+peT6cGESB08zH4WMrD2fc9HnxVbCEhTpG4KQZEne1TKwq5+3pomt8nX1PWTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061187; c=relaxed/simple;
	bh=t8qE3We53Na00zt5abu3IlQE7nzPjYeoyhAYo9iwov0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OStW0Gvc7jvUhCVu1NQncowwUK6wVR9e8N4ImQo9M20bdKo21hh687eJo31e00zxIwHQpt9PEy+SzR7ZiFPH9OJCODsDGSvBLyzIpMp+psdVDBZy8b7x7toM4OO6Q87f0KVaAd5Mhph9amwU8QS7KDV+e1d32C763qS3AhKpI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6H6387p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720061185; x=1751597185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8qE3We53Na00zt5abu3IlQE7nzPjYeoyhAYo9iwov0=;
  b=G6H6387pEM42lJSii35XR7dQGyHFMqywD4vMsl+wQR55UXt59XxlBboo
   zlTE9hmqtt9dUYB/nEvvQiauPTs2YVO85NOguR0ZpuwrrXKGfZ7Pqu88Z
   6FUZ1nVdh+FtrmOJPKe6ruWBokJYcecxDniXq3+WBpQz8wNn3/WNrTauc
   Z9+RRSnc+3whTWLUMWAFr7yj7C/3rvFg+4ADWWhK2+ucvsv+IVTQt4ImQ
   6B4axH9OI3iZVgAzrWPfqgS2+JfDi3F6cO3EyGXh2Sjqd1d7RJQTNflcP
   SqFYeZsIEhnBcaMnpgPQWc52IxXYT2q9CZB8GEnUKB3IoRR1s+EI++4JK
   A==;
X-CSE-ConnectionGUID: kQSkRInBQz6aUma761caUg==
X-CSE-MsgGUID: jXRBYofyRkesNGkuS0DBeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="16973327"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="16973327"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 19:46:24 -0700
X-CSE-ConnectionGUID: Gde1qrjUQNK5XjNOTOZTeg==
X-CSE-MsgGUID: setmmUkuTcWqN3a6OUy9bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="69650378"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jul 2024 19:46:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPCUE-000QSY-0D;
	Thu, 04 Jul 2024 02:46:18 +0000
Date: Thu, 4 Jul 2024 10:44:58 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <202407041052.926ISbwR-lkp@intel.com>
References: <20240702225845.322234-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702225845.322234-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc6 next-20240703]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240703-163558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240702225845.322234-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response ACK
config: i386-buildonly-randconfig-004-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041052.926ISbwR-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041052.926ISbwR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041052.926ISbwR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mailbox/pcc.c:115: warning: Function parameter or struct member 'shmem_base_addr' not described in 'pcc_chan_info'


vim +115 drivers/mailbox/pcc.c

800cda7b63f22b Sudeep Holla 2021-09-17   82  
80b2bdde002c52 Sudeep Holla 2021-09-17   83  /**
80b2bdde002c52 Sudeep Holla 2021-09-17   84   * struct pcc_chan_info - PCC channel specific information
80b2bdde002c52 Sudeep Holla 2021-09-17   85   *
0f2591e21b2e85 Sudeep Holla 2021-09-17   86   * @chan: PCC channel information with Shared Memory Region info
bf18123e78f4d1 Sudeep Holla 2021-09-17   87   * @db: PCC register bundle for the doorbell register
bf18123e78f4d1 Sudeep Holla 2021-09-17   88   * @plat_irq_ack: PCC register bundle for the platform interrupt acknowledge
bf18123e78f4d1 Sudeep Holla 2021-09-17   89   *	register
c45ded7e11352d Sudeep Holla 2021-09-17   90   * @cmd_complete: PCC register bundle for the command complete check register
c45ded7e11352d Sudeep Holla 2021-09-17   91   * @cmd_update: PCC register bundle for the command complete update register
c45ded7e11352d Sudeep Holla 2021-09-17   92   * @error: PCC register bundle for the error status register
f92ae90e52bb09 Sudeep Holla 2021-09-17   93   * @plat_irq: platform interrupt
60c40b06fa6869 Huisong Li   2023-08-01   94   * @type: PCC subspace type
3db174e478cb0b Huisong Li   2023-08-01   95   * @plat_irq_flags: platform interrupt flags
3db174e478cb0b Huisong Li   2023-08-01   96   * @chan_in_use: this flag is used just to check if the interrupt needs
3db174e478cb0b Huisong Li   2023-08-01   97   *		handling when it is shared. Since only one transfer can occur
3db174e478cb0b Huisong Li   2023-08-01   98   *		at a time and mailbox takes care of locking, this flag can be
3db174e478cb0b Huisong Li   2023-08-01   99   *		accessed without a lock. Note: the type only support the
3db174e478cb0b Huisong Li   2023-08-01  100   *		communication from OSPM to Platform, like type3, use it, and
3db174e478cb0b Huisong Li   2023-08-01  101   *		other types completely ignore it.
80b2bdde002c52 Sudeep Holla 2021-09-17  102   */
80b2bdde002c52 Sudeep Holla 2021-09-17  103  struct pcc_chan_info {
0f2591e21b2e85 Sudeep Holla 2021-09-17  104  	struct pcc_mbox_chan chan;
bf18123e78f4d1 Sudeep Holla 2021-09-17  105  	struct pcc_chan_reg db;
bf18123e78f4d1 Sudeep Holla 2021-09-17  106  	struct pcc_chan_reg plat_irq_ack;
c45ded7e11352d Sudeep Holla 2021-09-17  107  	struct pcc_chan_reg cmd_complete;
c45ded7e11352d Sudeep Holla 2021-09-17  108  	struct pcc_chan_reg cmd_update;
c45ded7e11352d Sudeep Holla 2021-09-17  109  	struct pcc_chan_reg error;
ddd70a454be0e5 Adam Young   2024-07-02  110  	void __iomem *shmem_base_addr;
f92ae90e52bb09 Sudeep Holla 2021-09-17  111  	int plat_irq;
60c40b06fa6869 Huisong Li   2023-08-01  112  	u8 type;
3db174e478cb0b Huisong Li   2023-08-01  113  	unsigned int plat_irq_flags;
3db174e478cb0b Huisong Li   2023-08-01  114  	bool chan_in_use;
80b2bdde002c52 Sudeep Holla 2021-09-17 @115  };
80b2bdde002c52 Sudeep Holla 2021-09-17  116  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

