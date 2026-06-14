Return-Path: <netdev+bounces-299280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gpEkB2ooL2qB8QQAu9opvQ
	(envelope-from <netdev+bounces-299280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EEA682653
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:17:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KEJMuPWi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299280-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2935E3004C70
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A930F816;
	Sun, 14 Jun 2026 22:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190D3128AB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 22:17:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475423; cv=none; b=laEr/sL3NdEW36DwwyRKe7XTzjoF+gXtHslbkfcUxJyZoll5OPJX4N87r39/ZB/fiyVjowMDCY9OlYM2CKLeJVMcYAAZ+FuQqRaxBPB57qPWUwJzK+254EirzfXB+/p+qc4kAcEtNjmrNjdSht6LzY8fV88YLi+jGLNxi9lp44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475423; c=relaxed/simple;
	bh=9FeLquSok60GIBpvMZRRZhF3VTDUhDH+zQUmkf3tCLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2/srD/M2PsWCtgtBVCJgmlprNpAQ2cNZljJ28OfFjtKiHFvw6dLt02VzQVLIvv7bWOYyZE9OmRqLq460gwM1FaXdWALaHzCWD0Ujux77hhGUgVdUqOJXQkD1gGOq5A3gfzpS+iO5P9pkFMGvToSAdR9zoWl4hLhsrcoaaTF2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEJMuPWi; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781475421; x=1813011421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FeLquSok60GIBpvMZRRZhF3VTDUhDH+zQUmkf3tCLs=;
  b=KEJMuPWiktcbocA79qap2uai+yTkJFpRB8nuPPpiTPxpoW9qXTsAsxeO
   nDjcQACuf//ssq5x1LD1AX2h0b8TSyoKKyph5uL7jIQfC9ott23VxJRhT
   28QzHYOMeqX8DyslbZSPeM7KQUFO1zVWof6DITVwYl9v5V0nxJxFBHX0R
   KPJPQllDF4Ik8oGH6RAMBwN/G+IHhvuYLeQeOI7upwvc0FKZt+AGNC0C5
   6sGqYLXe/fLbsVEsR8SukZ2uj0mib1n7Ke7H5WUTa0L5EiidEo64G38Ad
   LK7d+bDLUCFjaj7UyjkcZyp8MKppgKgd67wl4PXfax+Wf3bYQzjGLJbPb
   A==;
X-CSE-ConnectionGUID: kck2DO6XSXqH5TVvdAJ8Gw==
X-CSE-MsgGUID: WzwcC1cyTGKCMmqaQRjsfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81233835"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="81233835"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 15:16:57 -0700
X-CSE-ConnectionGUID: wcEiiaJgQyyJ4vPcoPRKJA==
X-CSE-MsgGUID: xu7UUsyDSYm3KfiziiGqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="244906693"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Jun 2026 15:16:53 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYt8M-00000000REk-1U95;
	Sun, 14 Jun 2026 22:16:50 +0000
Date: Mon, 15 Jun 2026 06:16:33 +0800
From: kernel test robot <lkp@intel.com>
To: mheib@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, Mohammad Heib <mheib@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: add devlink parameter
 for Flow Director ATR sample rate
Message-ID: <202606150639.gh5uBfAP-lkp@intel.com>
References: <20260614161131.192068-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614161131.192068-1-mheib@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299280-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mheib@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97EEA682653

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/mheib-redhat-com/i40e-add-devlink-parameter-for-Flow-Director-ATR-sample-rate/20260615-001257
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260614161131.192068-1-mheib%40redhat.com
patch subject: [Intel-wired-lan] [PATCH net-next] i40e: add devlink parameter for Flow Director ATR sample rate
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20260615/202606150639.gh5uBfAP-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260615/202606150639.gh5uBfAP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606150639.gh5uBfAP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/i40e/i40e_devlink.c:4:
>> drivers/net/ethernet/intel/i40e/i40e_devlink.c:106:30: error: initialization of 'int (*)(struct devlink *, u32,  union devlink_param_value *, struct netlink_ext_ack *)' {aka 'int (*)(struct devlink *, unsigned int,  union devlink_param_value *, struct netlink_ext_ack *)'} from incompatible pointer type 'int (*)(struct devlink *, u32,  union devlink_param_value,  struct netlink_ext_ack *)' {aka 'int (*)(struct devlink *, unsigned int,  union devlink_param_value,  struct netlink_ext_ack *)'} [-Wincompatible-pointer-types]
     106 |                              i40e_atr_sample_rate_validate),
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/devlink.h:650:21: note: in definition of macro 'DEVLINK_PARAM_DRIVER'
     650 |         .validate = _validate,                                          \
         |                     ^~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_devlink.c:106:30: note: (near initialization for 'i40e_dl_params[1].validate')
   include/net/devlink.h:650:21: note: in definition of macro 'DEVLINK_PARAM_DRIVER'
     650 |         .validate = _validate,                                          \
         |                     ^~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_devlink.c:77:12: note: 'i40e_atr_sample_rate_validate' declared here
      77 | static int i40e_atr_sample_rate_validate(struct devlink *devlink, u32 id,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +106 drivers/net/ethernet/intel/i40e/i40e_devlink.c

    93	
    94	static const struct devlink_param i40e_dl_params[] = {
    95		DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
    96				      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
    97				      i40e_max_mac_per_vf_get,
    98				      i40e_max_mac_per_vf_set,
    99				      NULL),
   100		DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
   101				     "atr_sample_rate",
   102				     DEVLINK_PARAM_TYPE_U32,
   103				     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
   104				     i40e_atr_sample_rate_get,
   105				     i40e_atr_sample_rate_set,
 > 106				     i40e_atr_sample_rate_validate),
   107	};
   108	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

