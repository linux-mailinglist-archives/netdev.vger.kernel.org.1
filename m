Return-Path: <netdev+bounces-286236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 68CJJGkVAGqPCwEAu9opvQ
	(envelope-from <netdev+bounces-286236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 07:19:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79409502A1D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 07:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96AF3014651
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 05:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F07312832;
	Sun, 10 May 2026 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfgI33Nm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33520301472;
	Sun, 10 May 2026 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778390374; cv=none; b=UwY54dN70xQLuM6evb88qKzVAai8x65XXVYpSjja1W8YK3QhnzUuB2u7uKOrVBTZIKvT/RijtQ0NOi+kj6iuNCmkuKHFJWn1yUVSHLNI2obtqHcVsVfQNPiPm4CkAUe2Uemi0KtABlGmGj1TDsfiucCyZU3rTbEQgT+RmCPWipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778390374; c=relaxed/simple;
	bh=Tb2Fcl07lDQV2lJ3devouZ78CtC47C98TLMHnEnOots=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1halQ7hQUt8bCFZGf/QQOkTKnKFIk4ix91qgO/RL44hTPbeG7tsMWcGfaqQp8acB8pwrj/NCo2t6Ibr3izIkN618uwiMrecjaK26iacwIfVsTAJkdTrs1ehu6HVmGGS2NbCmDUb6NkU9ApN6SrUtfYLWHbPgghJov6v8a9mZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfgI33Nm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778390372; x=1809926372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tb2Fcl07lDQV2lJ3devouZ78CtC47C98TLMHnEnOots=;
  b=QfgI33NmWMWF4sl3wz1EIbU9areyzcxDRp5+Iy+NCJtqepoRzExy9fpM
   rKF4bATd7xY7eJdzRmrzeRwm8lcCBiUYMg/PdQjnLlJ/mKQ0kObb53y4W
   6GR3P3ifDDThEvj2+p+a1UHxdw/BAXTpyvZKShwqhoeg1cQiD+/mmpE92
   A3/a6DT5ay0oTimQzITWNso1HIaRBX1O2mLyiYzHspN+gZJhfQoxFA0BD
   ecjPOH0/7JeTF+nJdX3QKXRB0KcdZ4vpcsJXoLJINlJKnwDaKfLMlQRjB
   GzHnh5dU0dyWoDFwrThBwO66kJSSM1l5uw+xwoszfjRHBoYlbaAoF55u4
   w==;
X-CSE-ConnectionGUID: URwRUrPDQFG+nPvahXLDhQ==
X-CSE-MsgGUID: ned/CTmGTXe8SNg1mhcfOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="89901691"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="89901691"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 22:19:31 -0700
X-CSE-ConnectionGUID: WbuzXBsTQSGONjZWXM1spQ==
X-CSE-MsgGUID: MrIXDTyNTtO4bnYNKCVZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237083204"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 May 2026 22:19:30 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLwZa-000000001mL-1pCr;
	Sun, 10 May 2026 05:19:26 +0000
Date: Sun, 10 May 2026 13:18:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: Re: [PATCH] netdevsim: Fix task hung by releasing bus lock before
 device ops
Message-ID: <202605101358.RCmpCsFR-lkp@intel.com>
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
X-Rspamd-Queue-Id: 79409502A1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-286236-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260510/202605101358.RCmpCsFR-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101358.RCmpCsFR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101358.RCmpCsFR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/netdevsim/bus.c:192:3: error: call to undeclared function 'nsim_bus_dev_del'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     192 |                 nsim_bus_dev_del(nsim_bus_dev);
         |                 ^
   drivers/net/netdevsim/bus.c:192:3: note: did you mean 'nsim_bus_dev_new'?
   drivers/net/netdevsim/bus.c:156:1: note: 'nsim_bus_dev_new' declared here
     156 | nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queues);
         | ^
>> drivers/net/netdevsim/bus.c:206:13: error: conflicting types for 'nsim_bus_dev_del'
     206 | static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
         |             ^
   drivers/net/netdevsim/bus.c:192:3: note: previous implicit declaration is here
     192 |                 nsim_bus_dev_del(nsim_bus_dev);
         |                 ^
   2 errors generated.


vim +/nsim_bus_dev_del +192 drivers/net/netdevsim/bus.c

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

