Return-Path: <netdev+bounces-271907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMZAN77lxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:52:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CD330A7B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B91303FFC7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB4391E4C;
	Thu, 26 Mar 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tx16o6FC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B230EF7F;
	Thu, 26 Mar 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511291; cv=none; b=ca1tZvgHOWuoiXRrT9LgOdHhS/dVT4hOtdYHlC0P1fMTXUTqbluUy3o1hXyWMnbM8463865VHUI/OKGs4ThFINjLME+MJSDsJYMu9YSgOCWd9AgSci5rBbTshfzRO72fqalX+0HZa22Ki4qN2u7RRS9SA+Rc/CcV69rhdDdPul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511291; c=relaxed/simple;
	bh=T0rnpOtBOtxwawzTr/v44+relMzfTJYdSkehmthMANA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX6uNacLKkbMRPBJQwNImVxIGbVtIjsB16ufWqr24qSIPZaAkFrNDzawAHXfYPZf6YI3XEwCPOTu9P6/SBJQa5j4Qn5oNJx2ed3zX0S97ob+diZ013t2Xug09umls2cI28ympFxs65cAQz1309jO+YeagpSXitHMngO5iVFbqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tx16o6FC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774511290; x=1806047290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0rnpOtBOtxwawzTr/v44+relMzfTJYdSkehmthMANA=;
  b=Tx16o6FC6jBZ+5NuIS5CHZMxHSKzC9wZKhCg//8+cwJuUU451iX+CYmI
   Bl7dhNp9y4TuanKeholCjKV6dkpckUBy11mGnyZKE1kjHTjSNGDWreOd1
   POYZ05bdaTtt/erRgb+S1DuMlKbkfo8ayYwxhTcZB8+gPEXa01qDjZiWf
   2J9UxWNT1exKq15Au8/EU3w/nTltiUEwK4YCqlKZImWsJVLaB1rD8RFs1
   SKGtynB5kOC7tDSIMK8sFRbOMDDHPFJZ7keSXOOPC/thVaJ6slaPZFaP8
   Sn1fK7rp01voTQv2QyiJIZUpwK4c4wBGK9zlm6aocgTBFnt0VaQUMZi4j
   A==;
X-CSE-ConnectionGUID: 49uDMmtFQdOkn49/KzNIMg==
X-CSE-MsgGUID: EfZJGvyhQBGY+3hCDU/cLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75628611"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75628611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:48:09 -0700
X-CSE-ConnectionGUID: S8BewAKMRXGvpOTCrVXQng==
X-CSE-MsgGUID: 6uj/xmAQTvuHErUgE0gB0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="225184394"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2026 00:48:03 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5fRg-000000008aX-2Uk5;
	Thu, 26 Mar 2026 07:48:00 +0000
Date: Thu, 26 Mar 2026 15:47:59 +0800
From: kernel test robot <lkp@intel.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, willemb@google.com,
	nktgrg@google.com, jfraker@google.com, ziweixiao@google.com,
	maolson@google.com, thostet@google.com, jordanrhee@google.com,
	jefrogers@google.com, alok.a.tiwari@oracle.com,
	linux-kernel@vger.kernel.org, Kevin Yang <yyd@google.com>,
	Naman Gulati <namangulati@google.com>
Subject: Re: [PATCH net-next 3/3] gve: implement PTP gettimex64
Message-ID: <202603261542.ki4x7Oq5-lkp@intel.com>
References: <20260323234829.3185051-4-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323234829.3185051-4-hramamurthy@google.com>
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
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271907-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 415CD330A7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Harshitha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5446b8691eb8278f10deca92048fad84ffd1e4d5]

url:    https://github.com/intel-lab-lkp/linux/commits/Harshitha-Ramamurthy/gve-skip-error-logging-for-retryable-AdminQ-commands/20260324-133808
base:   5446b8691eb8278f10deca92048fad84ffd1e4d5
patch link:    https://lore.kernel.org/r/20260323234829.3185051-4-hramamurthy%40google.com
patch subject: [PATCH net-next 3/3] gve: implement PTP gettimex64
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260326/202603261542.ki4x7Oq5-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261542.ki4x7Oq5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261542.ki4x7Oq5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/google/gve/gve_ptp.c:187:10: warning: format specifies type 'unsigned long long' but the argument has type 'cycles_t' (aka 'unsigned long') [-Wformat]
     186 |                                             "AdminQ system clock cycle counts out of order. Expecting %llu <= %llu <= %llu <= %llu\n",
         |                                                                                                       ~~~~
         |                                                                                                       %lu
     187 |                                             sysclock.host_pre_cycles,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:225:45: note: expanded from macro 'dev_err_ratelimited'
     225 |         dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
         |                                             ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:215:25: note: expanded from macro 'dev_level_ratelimited'
     215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ptp.c:190:10: warning: format specifies type 'unsigned long long' but the argument has type 'cycles_t' (aka 'unsigned long') [-Wformat]
     186 |                                             "AdminQ system clock cycle counts out of order. Expecting %llu <= %llu <= %llu <= %llu\n",
         |                                                                                                                               ~~~~
         |                                                                                                                               %lu
     187 |                                             sysclock.host_pre_cycles,
     188 |                                             sysclock.nic_pre_cycles,
     189 |                                             sysclock.nic_post_cycles,
     190 |                                             sysclock.host_post_cycles);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:225:45: note: expanded from macro 'dev_err_ratelimited'
     225 |         dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
         |                                             ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:215:25: note: expanded from macro 'dev_level_ratelimited'
     215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +187 drivers/net/ethernet/google/gve/gve_ptp.c

   160	
   161	static int gve_ptp_gettimex64(struct ptp_clock_info *info,
   162				      struct timespec64 *ts,
   163				      struct ptp_system_timestamp *sts)
   164	{
   165		struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
   166		struct gve_sysclock_sample sysclock = {0};
   167		struct gve_priv *priv = ptp->priv;
   168		struct system_time_snapshot snap;
   169		u64 nic_ts;
   170		int err;
   171	
   172		/* Take system clock snapshot before sampling cycle counters */
   173		if (sts)
   174			ktime_get_snapshot(&snap);
   175	
   176		err = gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
   177		if (err)
   178			return err;
   179	
   180		if (sts) {
   181			/* Reject samples with out of order system clock values */
   182			if (!(sysclock.host_pre_cycles <= sysclock.nic_pre_cycles &&
   183			      sysclock.nic_pre_cycles  <= sysclock.nic_post_cycles &&
   184			      sysclock.nic_post_cycles <= sysclock.host_post_cycles)) {
   185				dev_err_ratelimited(&priv->pdev->dev,
   186						    "AdminQ system clock cycle counts out of order. Expecting %llu <= %llu <= %llu <= %llu\n",
 > 187						    sysclock.host_pre_cycles,
   188						    sysclock.nic_pre_cycles,
   189						    sysclock.nic_post_cycles,
   190						    sysclock.host_post_cycles);
   191				return -EBADMSG;
   192			}
   193	
   194			err = gve_cycles_to_timespec64(priv, sts->clockid, &snap,
   195						       sysclock.nic_pre_cycles,
   196						       &sts->pre_ts);
   197			if (err)
   198				return err;
   199	
   200			err = gve_cycles_to_timespec64(priv, sts->clockid, &snap,
   201						       sysclock.nic_post_cycles,
   202						       &sts->post_ts);
   203			if (err)
   204				return err;
   205		}
   206	
   207		*ts = ns_to_timespec64(nic_ts);
   208	
   209		return 0;
   210	}
   211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

