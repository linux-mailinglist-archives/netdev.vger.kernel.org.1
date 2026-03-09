Return-Path: <netdev+bounces-265625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBOaFR/xrmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:11:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C423C7EB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5955B303E392
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5B3B531D;
	Mon,  9 Mar 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQcqdfb3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD82236EB;
	Mon,  9 Mar 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072410; cv=none; b=PwGdsfjwHXiv0ltogfvPbg0h5++99cW+5yeg7MfqoBL1eQdgmCkEzdA4edeYZl4B2M88aCcIPiD845k+xV9ctzBURfwLqozfZuGI2/TjztUVQbraZjXN9gx3bm2ioMbX9ywXZLseNyQe2MKru2q5PGzfZlQdnFJF8ECmId0j3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072410; c=relaxed/simple;
	bh=Nrs4LfI0MkcALVaXmDTIrClgexDio6vlH3HqaNPh4MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krRk0hcx85YeZeJMjIHZ7yrGaPYLheqDT8GTgpvUfSja33UgAENMYrDFTfIW2e9uWwJ8d5pKT05KLf+aCbie+Zh8/UG6gM5Mb4LHgKLRb7A1syPI3ZyjV3XuX7Wemdcke6L7naBa5vA1UeAys1I+0+tfd1z228/8/eQT5HJO0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQcqdfb3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773072409; x=1804608409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nrs4LfI0MkcALVaXmDTIrClgexDio6vlH3HqaNPh4MU=;
  b=kQcqdfb3d+JQXm/agQXhqSDm97tR8s7VXzaBR3HGj9zjUhBwtZ3V+43Y
   h4S1D9TFckDl6eRazq9jXFuotFYOJMeRGHQfIHpjp1VLCejpfEXSLQgeK
   3ccq1oX31X/27S0Fua2zAEEvuhq9Ox/zoZyff1opNoRLw2cI2xoSEIMLl
   M0O1n9gKo8VfIFg8+b5ihZhuGFx+zP1AMovwMf+suQkq22FT2kb4Z5ztG
   bB0R7HoXMYSeZd7W5xHdc764xLnXp25v/0HnerF41iUusrsj3fdlKfX0N
   1eoDVzC1bw6Vw4XClqShBkg4Oc1NtSLZxaWNWVG8d2TucqeDmT0EfrLwB
   Q==;
X-CSE-ConnectionGUID: BO/aP5oKT1q24Wc2Hz8mWQ==
X-CSE-MsgGUID: 0jn0BvxvQxCBvXyuraxEvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="96719260"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="96719260"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:06:45 -0700
X-CSE-ConnectionGUID: hw1L35B7TIyOZphvn6wKCQ==
X-CSE-MsgGUID: OGQZLM0ORGWW8SB/mTnf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219009509"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Mar 2026 09:06:41 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzd7u-000000000Uu-2bLU;
	Mon, 09 Mar 2026 16:06:38 +0000
Date: Tue, 10 Mar 2026 00:05:42 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH v2] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
Message-ID: <202603100054.UoKwTVMf-lkp@intel.com>
References: <20260308080944.5200-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308080944.5200-1-maimon.sagi@gmail.com>
X-Rspamd-Queue-Id: C05C423C7EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-265625-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url]
X-Rspamd-Action: no action

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v7.0-rc3 next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/ptp-ocp-Add-support-for-Xilinx-based-Adva-TimeCard-variant/20260308-161130
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260308080944.5200-1-maimon.sagi%40gmail.com
patch subject: [PATCH v2] ptp: ocp: Add support for Xilinx-based Adva TimeCard variant
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260310/202603100054.UoKwTVMf-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260310/202603100054.UoKwTVMf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603100054.UoKwTVMf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_ocp.c:438:32: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct ocp_sma_op' [-Wtentative-definition-incomplete-type]
     438 | static const struct ocp_sma_op ocp_adva_sma_op;
         |                                ^
   drivers/ptp/ptp_ocp.c:84:15: note: forward declaration of 'struct ocp_sma_op'
      84 |         const struct ocp_sma_op         *sma_op;
         |                      ^
   drivers/ptp/ptp_ocp.c:439:32: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct ocp_sma_op' [-Wtentative-definition-incomplete-type]
     439 | static const struct ocp_sma_op ocp_adva_x1_sma_op;
         |                                ^
   drivers/ptp/ptp_ocp.c:84:15: note: forward declaration of 'struct ocp_sma_op'
      84 |         const struct ocp_sma_op         *sma_op;
         |                      ^
   2 warnings generated.


vim +438 drivers/ptp/ptp_ocp.c

   437	
 > 438	static const struct ocp_sma_op ocp_adva_sma_op;
   439	static const struct ocp_sma_op ocp_adva_x1_sma_op;
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

