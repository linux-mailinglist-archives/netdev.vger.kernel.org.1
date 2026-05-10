Return-Path: <netdev+bounces-286233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKkNMb31/2mNAwEAu9opvQ
	(envelope-from <netdev+bounces-286233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 05:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C81502585
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 05:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945C73021E6A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BE25A2C6;
	Sun, 10 May 2026 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bA4L0XuW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9507189F43;
	Sun, 10 May 2026 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382266; cv=none; b=TmvfIhpZRgS1cXnQH9JjSVR+J6XWwbx/EpYMZI5t4qaOx42XmLZIIKV3k68CXYq3vB1lsQmt62+d/QA8X+m9/gv6Jp3sDEuFPaRm0uy94bwHjFaa5cdqD3KdrBR7HuwN4WIs3KgD2lO7pwWEPZi9k8Xv7Ua1F/o9i6GQs8jj07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382266; c=relaxed/simple;
	bh=gP2ReFotz0bvoYxNyAC9vLzBHBTPlQZ/my1ahqKGcwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezRYdPUow4C2I4Afx838uO1bdpZLKRW2gqBkXIajotv7B647frRt2kG3TcUlSxWqqjsONT0nQMpGFg8YHXnrA96Nvxc7r+5PyKpZvWH39pTpgZeGuaJ7Tqg+6R51Hp1Fa0pWfFTUOXypo2/X2vzXcekDeNGyNnQZraPBVkXf/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bA4L0XuW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778382263; x=1809918263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gP2ReFotz0bvoYxNyAC9vLzBHBTPlQZ/my1ahqKGcwc=;
  b=bA4L0XuW7GCM3HnlyXAbRKTTT3WdgE3IMCWHdXn4294swMTEedvyMFpv
   wME7cg05Emf0Z97cxVfihrtUrZ4AiMaYNHLfXddQ7jmuVYBad2tdFpiWI
   prJn9/R6EoZWoPvOkLltg/GPkDlVoqbNX7OU8UwdtAvy9qwpuIhK2dvmQ
   0SZ84goX+jDycFlaeX0300XLnF0wvKgqgLlpulfg7N24LcbQTKxRYOM7f
   +SyWr3ojJeQfNtvrmVOuc0/5ljNbnbo0famOu2tvtBaZlHLaLI+38Bcwa
   nk929xDng1og/sKa3WrMqBblF1VMcjlzKhJw99L1OwohjzCR0fDi+oyGC
   A==;
X-CSE-ConnectionGUID: IO3l7Wf1TXCasRJ4r5/FSA==
X-CSE-MsgGUID: Z0PfefqCT5im8hUvQ0kB2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79033272"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79033272"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 20:04:23 -0700
X-CSE-ConnectionGUID: GxZ2mTjzS+qtvsEyDigPKw==
X-CSE-MsgGUID: hJB+5A8cQaG87/TZL0Ncow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="234470892"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 May 2026 20:04:21 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLuSo-000000001hB-16tL;
	Sun, 10 May 2026 03:04:18 +0000
Date: Sun, 10 May 2026 11:03:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: Re: [PATCH] netdevsim: Fix task hung by releasing bus lock before
 device ops
Message-ID: <202605101038.mxF4QH95-lkp@intel.com>
References: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
X-Rspamd-Queue-Id: 75C81502585
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-286233-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,git-scm.com:url]
X-Rspamd-Action: no action

Hi Jiakai,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc2 next-20260508]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiakai-Xu/netdevsim-Fix-task-hung-by-releasing-bus-lock-before-device-ops/20260510-070550
base:   linus/master
patch link:    https://lore.kernel.org/r/20260509092837.3432281-1-xujiakai24%40mails.ucas.ac.cn
patch subject: [PATCH] netdevsim: Fix task hung by releasing bus lock before device ops
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260510/202605101038.mxF4QH95-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101038.mxF4QH95-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101038.mxF4QH95-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/netdevsim/bus.c: In function 'new_device_store':
>> drivers/net/netdevsim/bus.c:192:17: error: implicit declaration of function 'nsim_bus_dev_del'; did you mean 'nsim_bus_dev_new'? [-Wimplicit-function-declaration]
     192 |                 nsim_bus_dev_del(nsim_bus_dev);
         |                 ^~~~~~~~~~~~~~~~
         |                 nsim_bus_dev_new
   drivers/net/netdevsim/bus.c: At top level:
>> drivers/net/netdevsim/bus.c:206:13: warning: conflicting types for 'nsim_bus_dev_del'; have 'void(struct nsim_bus_dev *)'
     206 | static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
         |             ^~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/bus.c:206:13: error: static declaration of 'nsim_bus_dev_del' follows non-static declaration
   drivers/net/netdevsim/bus.c:192:17: note: previous implicit declaration of 'nsim_bus_dev_del' with type 'void(struct nsim_bus_dev *)'
     192 |                 nsim_bus_dev_del(nsim_bus_dev);
         |                 ^~~~~~~~~~~~~~~~


vim +192 drivers/net/netdevsim/bus.c

   157	
   158	static ssize_t
   159	new_device_store(const struct bus_type *bus, const char *buf, size_t count)
   160	{
   161		unsigned int id, port_count, num_queues;
   162		struct nsim_bus_dev *nsim_bus_dev;
   163		int err;
   164	
   165		err = sscanf(buf, "%u %u %u", &id, &port_count, &num_queues);
   166		switch (err) {
   167		case 1:
   168			port_count = 1;
   169			fallthrough;
   170		case 2:
   171			num_queues = 1;
   172			fallthrough;
   173		case 3:
   174			if (id > INT_MAX) {
   175				pr_err("Value of \"id\" is too big.\n");
   176				return -EINVAL;
   177			}
   178			break;
   179		default:
   180			pr_err("Format for adding new device is \"id port_count num_queues\" (uint uint uint).\n");
   181			return -EINVAL;
   182		}
   183	
   184		nsim_bus_dev = nsim_bus_dev_new(id, port_count, num_queues);
   185		if (IS_ERR(nsim_bus_dev))
   186			return PTR_ERR(nsim_bus_dev);
   187	
   188		mutex_lock(&nsim_bus_dev_list_lock);
   189		/* Prevent to use resource before initialization. */
   190		if (!smp_load_acquire(&nsim_bus_enable)) {
   191			mutex_unlock(&nsim_bus_dev_list_lock);
 > 192			nsim_bus_dev_del(nsim_bus_dev);
   193			return -EBUSY;
   194		}
   195	
   196		/* Allow using nsim_bus_dev */
   197		smp_store_release(&nsim_bus_dev->init, true);
   198	
   199		list_add_tail(&nsim_bus_dev->list, &nsim_bus_dev_list);
   200		mutex_unlock(&nsim_bus_dev_list_lock);
   201	
   202		return count;
   203	}
   204	static BUS_ATTR_WO(new_device);
   205	
 > 206	static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

