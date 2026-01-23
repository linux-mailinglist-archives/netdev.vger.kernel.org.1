Return-Path: <netdev+bounces-252985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHDkE2b7c2mf0gAAu9opvQ
	(envelope-from <netdev+bounces-252985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:51:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF77B436
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C385D3016933
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F12BE03B;
	Fri, 23 Jan 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkA5SWOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A979221FA0;
	Fri, 23 Jan 2026 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208637; cv=none; b=lc6BYtCElYHi2UIeCP3J+HTK59bVjBhfriNa825F3Gok3+MCsaaHeHq758js/qtVRROE7geBo/GSZOk79LE49mNUAtu+PhOiU8wUebE68HQkc/6pLnPu2IuHShyWOa82PXukyzl44Cfsq+UXkOe26RYccwucl5XXtiMcHDhqk08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208637; c=relaxed/simple;
	bh=cE/ifPyGb0uJSZu6c77p/l+R3iUkMviEt2g3Hy6PAdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqc4qqxpTjno7rP3M0edQrg7JXCaNG2Q3LKw2So8A/GXuBVEuPGshmVFLBEaKaiiN9fMcBb16YZghIyaSeI4mF3okzbxyLLSUCEK8dFd3uJhZ/rb+D5bQWXBVxwISUv8die5vG89k+Zk2SiMTf0Hy1u86tGLGcWPYXG5zf6bads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkA5SWOJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769208635; x=1800744635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cE/ifPyGb0uJSZu6c77p/l+R3iUkMviEt2g3Hy6PAdM=;
  b=kkA5SWOJUvNaPBVkKWP8hgf215owFJn1eCQq1+zxYI9JaZ7E7hFtrM5z
   L+aUasBzVmtqoW5YGzrrSqTyv/aYNNOFhEOQOWgaIGE3u5+ktOONiv9EC
   XnA2AQPkdOs6Lf9WyiZiAqqZMpe82VLCTaASlVReOpoF+KTRhVdS6d4Om
   8KHIqni2bnJsSyMU464xiPK6XP08Oz6nKCUyclB3SMTIfxsCgV9VN8VZE
   w7fBVmDpBvCpCxGnqxaLX39kev26pzwt1Ncy2q4s5KWiVtF1Tpja4k9f5
   GswuhWmM9enrjp/w7za2ocy9SIS+XbFxN3NknqsE85gB4lp6bUpmejazx
   g==;
X-CSE-ConnectionGUID: MTeo1qaNQeG9jqM/Ia40gg==
X-CSE-MsgGUID: NMp38vCmSW66Dyo9b1RSGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70515838"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="70515838"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:50:35 -0800
X-CSE-ConnectionGUID: 42sUTua/SDGbTI7keqKF5w==
X-CSE-MsgGUID: g5pysrIvQSKbBXsaPDQoIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="211996523"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2026 14:50:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjPz1-00000000UYI-1pDn;
	Fri, 23 Jan 2026 22:50:27 +0000
Date: Sat, 24 Jan 2026 06:50:03 +0800
From: kernel test robot <lkp@intel.com>
To: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
	pmohan@couthit.com, basharath@couthit.com, afd@ti.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	alok.a.tiwari@oracle.com, horms@kernel.org, pratheesh@ti.com,
	j-rameshbabu@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
	rogerq@ti.com, krishna@couthit.com
Subject: Re: [PATCH net-next v12 1/3] net: ti: icssm-prueth: Add helper
 functions to configure and maintain FDB
Message-ID: <202601240612.E2dA0Rll-lkp@intel.com>
References: <20260123135932.535735-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123135932.535735-2-parvathi@couthit.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252985-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A6CF77B436
X-Rspamd-Action: no action

Hi Parvathi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Parvathi-Pudi/net-ti-icssm-prueth-Add-helper-functions-to-configure-and-maintain-FDB/20260123-220750
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260123135932.535735-2-parvathi%40couthit.com
patch subject: [PATCH net-next v12 1/3] net: ti: icssm-prueth: Add helper functions to configure and maintain FDB
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260124/202601240612.E2dA0Rll-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240612.E2dA0Rll-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240612.E2dA0Rll-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c: In function 'icssm_prueth_sw_init_fdb_table':
>> drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c:570:27: error: implicit declaration of function 'kmalloc_obj'; did you mean 'kmalloc_node'? [-Wimplicit-function-declaration]
     570 |         prueth->fdb_tbl = kmalloc_obj(*prueth->fdb_tbl, GFP_KERNEL);
         |                           ^~~~~~~~~~~
         |                           kmalloc_node
>> drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c:570:25: error: assignment to 'struct fdb_tbl *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     570 |         prueth->fdb_tbl = kmalloc_obj(*prueth->fdb_tbl, GFP_KERNEL);
         |                         ^


vim +570 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c

   564	
   565	int icssm_prueth_sw_init_fdb_table(struct prueth *prueth)
   566	{
   567		if (prueth->emac_configured)
   568			return 0;
   569	
 > 570		prueth->fdb_tbl = kmalloc_obj(*prueth->fdb_tbl, GFP_KERNEL);
   571		if (!prueth->fdb_tbl)
   572			return -ENOMEM;
   573	
   574		icssm_prueth_sw_fdb_tbl_init(prueth);
   575	
   576		return 0;
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

