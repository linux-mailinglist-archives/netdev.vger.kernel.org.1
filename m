Return-Path: <netdev+bounces-251959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCeMMoYOcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-251959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:36:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6B5AA00
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF89AFD58
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FEF481FAE;
	Wed, 21 Jan 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUkHvPWy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71709421F05;
	Wed, 21 Jan 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009628; cv=none; b=IPKUSYsK8RJGLHPTyLAgbH14tf3n9btzwSdix2Y/ItX5GTtKWhpcBCRG6yBomCKtbEMiT5ZXEKs6yBbjz6rY6Hgc3JTQJ45aUNMkjWnugOLrPnnsr6EmKUXcUNAw2LE+d3m3K+e+3V+tZVVoR3gk+yUBOCUlPR4lvqE/t7bLW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009628; c=relaxed/simple;
	bh=ActRY6ccNAJGp7Z1DF66+N/QLwqyaNsIMzLbkZkJCKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCKKtPqAGwpCpgFR44leo0dcZ9SanCbQdx40lQiySTMIiXkKat5xjFa0sXhjoCrsa3BnIFaJjLPUGN+mxa0k7Ac3XNgxzB6Q19VrVTzy+zy4JlTGvaTrfdG1hjvCZfcf2lsixUr+jUo7TdzHLB8I2gUlJ3hd35TKPXbHVu6LYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUkHvPWy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769009627; x=1800545627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ActRY6ccNAJGp7Z1DF66+N/QLwqyaNsIMzLbkZkJCKU=;
  b=mUkHvPWy1B0b/+LqwhwCajWQa4D32yw4+mz2lZ25ORLOQUcJvZyrArbC
   OhTwgm18CdWMibXI/aWGqoyaNrjvV2951Q1BVsESn6JwntdiUvuRAhU5z
   2M841JOFtc4RGV9KHpHhGiM9+o8Dn/cooMo+EonsX1N0ExSKnT9nXbhZq
   Y1j4LXyAUdENvHRHj6F+FJIrB457cdtJcmQOjbUEdeoR16eQmkjrcx6LY
   +2kDV1ev6RN6zi4eag5dQ2Oo5qhLxm9V343vm2dY7DcNUaRpzm+jEGeXN
   RD+TZt/2mbx1uH6xgnucVhqhCOaANo38uGSgUnxgiBkyQCjjAElFg/o5A
   w==;
X-CSE-ConnectionGUID: nPC4Ry0pS7KqyWRcMUd9iQ==
X-CSE-MsgGUID: KfL0iJPPQ0e8R7/usCb1/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="95717865"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="95717865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:33:46 -0800
X-CSE-ConnectionGUID: 42re4ESAS7iG7qWNlIeoTQ==
X-CSE-MsgGUID: igiMfa5HR/CgXmZYy9uPvQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jan 2026 07:33:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viaDE-00000000RLV-1IhP;
	Wed, 21 Jan 2026 15:33:40 +0000
Date: Wed, 21 Jan 2026 23:33:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/3] ipvlan: Common code from v6/v4 validator_event
Message-ID: <202601220042.cudmSYUb-lkp@intel.com>
References: <20260120161852.639238-3-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120161852.639238-3-skorodumov.dmitry@huawei.com>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251959-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,huawei.com,google.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 69B6B5AA00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-const-specifier-for-functions-that-use-iaddr/20260121-021651
base:   net/main
patch link:    https://lore.kernel.org/r/20260120161852.639238-3-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net 2/3] ipvlan: Common code from v6/v4 validator_event
config: csky-randconfig-r073-20260121 (https://download.01.org/0day-ci/archive/20260122/202601220042.cudmSYUb-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220042.cudmSYUb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601220042.cudmSYUb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ipvlan/ipvlan_main.c:1023:30: warning: 'ipvlan_addr6_vtor_notifier_block' defined but not used [-Wunused-variable]
    1023 | static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mostly = {
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ipvlan_addr6_vtor_notifier_block +1023 drivers/net/ipvlan/ipvlan_main.c

8c54904ac0f545 Dmitry Skorodumov 2026-01-20  1022  
3ad7d2468f79fc Krister Johansen  2017-06-08 @1023  static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mostly = {
8c54904ac0f545 Dmitry Skorodumov 2026-01-20  1024  	.notifier_call = ipvlan_addr_validator_event_cb,
3ad7d2468f79fc Krister Johansen  2017-06-08  1025  };
8c54904ac0f545 Dmitry Skorodumov 2026-01-20  1026  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

