Return-Path: <netdev+bounces-287426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGADGgz3A2pnBQIAu9opvQ
	(envelope-from <netdev+bounces-287426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:59:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34F52D116
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4C77305634D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273263921DE;
	Wed, 13 May 2026 03:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyGGDJRc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1C39734B;
	Wed, 13 May 2026 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644727; cv=none; b=HzBHgfTdcpnH6ntXFqf9QE7GUCJ5Vup9x30Ety5hX1+AIarSQSUxuZTYEDnWDWEV1HLrv4Dsg3ef17Yav7eyRQHoMZkmZbCdL724xnRNFnboqAD43BS3f+17ZqgpWdpWOshHOit+2hZRI0YmmqW0M+fcY3aLg7sUmSA2lptj1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644727; c=relaxed/simple;
	bh=Sg1TFdXwRIEWTY6N6UuksjFgzho6T51tj2JYtw4tSy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3S81uSV/+gwWwSWeDILiChGaNdIiGpXW0PZTdbH1rWNdDS740zzq2cMjSM1jLZEhoKod2PJYxeceMeg+uV6lTYNTptyQWu1eOtPyTk7YqHlkycp0+Cw4zkVVM36oPw2QZc8arPRPBTJeKQOojw5gV+xRTysh8xYJ8a3slaAt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyGGDJRc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778644725; x=1810180725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sg1TFdXwRIEWTY6N6UuksjFgzho6T51tj2JYtw4tSy4=;
  b=QyGGDJRcKJ0CPl3o/+xbM9vt4c7c5D6/PXRj30Zm98OpDDg8tlcIGFDr
   HrdGzVpBx6pKw8R5XvXuZfsv/CrqZ0+FxHwWvyT9x5KsUMzbN+N/hyO0Z
   DM939zKHc7zhA6n1GR5jz1jX7g2/dLQYGyd6+L09PvJoYzB3JQzagAZ3d
   pVi3snil8I4kVjtQMCiqegnKRHdpXj8VeHX/ozoui59PSVmuH7L7YRyPG
   z+3MVm9tNzR+qFO64/755c6ZBbanZtfs+jyUiDt7c/ZDqhomWMUavfPtu
   7w/pGUcdSLwWHSg4PxlkyQWHBVEoSlGkB8anYbnWVMJr2oAQiVwBCvoSm
   Q==;
X-CSE-ConnectionGUID: iNzj+emFSPKVx4kokF46Ew==
X-CSE-MsgGUID: ZQwcgLUuRpSP8Oqz7klLZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90664886"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90664886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 20:58:44 -0700
X-CSE-ConnectionGUID: 9F+8rHa4TJaLsM39ZtJX2w==
X-CSE-MsgGUID: 6LCMDD50SsuxC21y8dISpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="276085245"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 20:58:41 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN0k1-000000003O7-3JQ0;
	Wed, 13 May 2026 03:58:37 +0000
Date: Wed, 13 May 2026 11:58:27 +0800
From: kernel test robot <lkp@intel.com>
To: faicker.mo@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: net_failover: Fix the deadlock in slave register
Message-ID: <202605131116.TbbaiahQ-lkp@intel.com>
References: <20260507074332.2543229-1-faicker.mo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507074332.2543229-1-faicker.mo@gmail.com>
X-Rspamd-Queue-Id: CF34F52D116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287426-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,git-scm.com:url]
X-Rspamd-Action: no action

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/faicker-mo-gmail-com/net-net_failover-Fix-the-deadlock-in-slave-register/20260513-045805
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260507074332.2543229-1-faicker.mo%40gmail.com
patch subject: [PATCH v3] net: net_failover: Fix the deadlock in slave register
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20260513/202605131116.TbbaiahQ-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131116.TbbaiahQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131116.TbbaiahQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/failover.c:225:4: error: call to undeclared function 'netdev_lock_ops'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     225 |                         netdev_lock_ops(dev);
         |                         ^
   net/core/failover.c:225:4: note: did you mean 'netdev_lock'?
   include/linux/netdevice.h:2822:20: note: 'netdev_lock' declared here
    2822 | static inline void netdev_lock(struct net_device *dev)
         |                    ^
>> net/core/failover.c:227:4: error: call to undeclared function 'netdev_unlock_ops'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     227 |                         netdev_unlock_ops(dev);
         |                         ^
   2 errors generated.


vim +/netdev_lock_ops +225 net/core/failover.c

   213	
   214	static void
   215	failover_existing_slave_register(struct net_device *failover_dev)
   216	{
   217		struct net *net = dev_net(failover_dev);
   218		struct net_device *dev;
   219	
   220		rtnl_lock();
   221		for_each_netdev(net, dev) {
   222			if (netif_is_failover(dev))
   223				continue;
   224			if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr)) {
 > 225				netdev_lock_ops(dev);
   226				failover_slave_register(dev);
 > 227				netdev_unlock_ops(dev);
   228			}
   229		}
   230		rtnl_unlock();
   231	}
   232	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

