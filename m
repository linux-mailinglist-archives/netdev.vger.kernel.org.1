Return-Path: <netdev+bounces-252986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INvqHkL7c2mf0gAAu9opvQ
	(envelope-from <netdev+bounces-252986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:50:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C57B420
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B4C23006B7C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEAC2D7DC1;
	Fri, 23 Jan 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQOlM4Sw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461E2206AC;
	Fri, 23 Jan 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208639; cv=none; b=DmDuTeztgPXD8HqRXvi7DXaYsbvvIVXgQvDxdttiGuWMomI+ViBs8shASzolri4ZC4OnTv/EQC5l6TSml/iLeMM0P/cMk8cQULJ955+0EWs5ephnk8R+sR+leXfSbBC1qLgqnyJRx7U2s+6MNSOh0riU8mcIGkOu/nvcFQYPnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208639; c=relaxed/simple;
	bh=z+l/Iumm08O54OJsNbQka8X+9Q72qsZNUebKuOgH+/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlyEG7/zggAgvSvKt40StqbXCgNG8dGnFS5ueM3ExBD8G2K6unyWLEO962o+cAfflwI30VStKe9LC/a4wNGAWLDPLy72NERu8Ne63sD3vNg9VHsJU7SI2xzI5Ep2LiY3sSnE1FBfnJLJ0K8l8+TqjJpHusRY3d5O3CQB6XHATq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQOlM4Sw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769208637; x=1800744637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+l/Iumm08O54OJsNbQka8X+9Q72qsZNUebKuOgH+/4=;
  b=FQOlM4Swp35XoXeLSY/QsHBp2xikbc94/Za0498A4P5KfDGEBEg1Hwov
   L3zZhYz5LFi0OT6wi+QBeH18MQul62ZpGycbbtqowTXKBFJwi5I3yFZaA
   2dKnPkC0wYRik6I7gV8jvsb+pSus5Q6Ybw7nTqn9gyRm9gdss5/X09SoF
   LkQU9OPLz1qQTf0dw0P1HLV1dhOPk5TEYs9QDOgbDvhB8AWDlyt+XlIPL
   ahzu3WgUjME/0b2DCNC0p7sIdfbOwqEqOsyRZM03Ti4bgThxfJjijzscy
   28ocPspfy0Qgn0ghZfJ+B0DMJzBXnW+BuCJ4qWmuRp3rxWszdipgcNEKb
   Q==;
X-CSE-ConnectionGUID: 0+E2H/S/Tw67PSU9fI3VtQ==
X-CSE-MsgGUID: +QJ8/M25RHqnPybq4GiALw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70515852"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="70515852"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:50:35 -0800
X-CSE-ConnectionGUID: 1tqy6JmdQH6dK7zPWXXK8A==
X-CSE-MsgGUID: TK0Z7lPeR1ypTpwa1GDYeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="211996524"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2026 14:50:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjPz1-00000000UYK-1voE;
	Fri, 23 Jan 2026 22:50:27 +0000
Date: Sat, 24 Jan 2026 06:50:04 +0800
From: kernel test robot <lkp@intel.com>
To: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
	pmohan@couthit.com, basharath@couthit.com, afd@ti.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
	horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com,
	vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
	krishna@couthit.com
Subject: Re: [PATCH net-next v12 1/3] net: ti: icssm-prueth: Add helper
 functions to configure and maintain FDB
Message-ID: <202601240625.YSMR8XyP-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252986-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 236C57B420
X-Rspamd-Action: no action

Hi Parvathi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Parvathi-Pudi/net-ti-icssm-prueth-Add-helper-functions-to-configure-and-maintain-FDB/20260123-220750
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260123135932.535735-2-parvathi%40couthit.com
patch subject: [PATCH net-next v12 1/3] net: ti: icssm-prueth: Add helper functions to configure and maintain FDB
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260124/202601240625.YSMR8XyP-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240625.YSMR8XyP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240625.YSMR8XyP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c:570:20: error: call to undeclared function 'kmalloc_obj'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     570 |         prueth->fdb_tbl = kmalloc_obj(*prueth->fdb_tbl, GFP_KERNEL);
         |                           ^
>> drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c:570:18: error: incompatible integer to pointer conversion assigning to 'struct fdb_tbl *' from 'int' [-Wint-conversion]
     570 |         prueth->fdb_tbl = kmalloc_obj(*prueth->fdb_tbl, GFP_KERNEL);
         |                         ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/kmalloc_obj +570 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c

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

