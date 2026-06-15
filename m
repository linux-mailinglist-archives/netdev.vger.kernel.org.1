Return-Path: <netdev+bounces-299283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DFsVJ51KL2qZ+AQAu9opvQ
	(envelope-from <netdev+bounces-299283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E51682A89
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:43:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=L817aBrg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299283-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299283-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51D943001475
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F401C861D;
	Mon, 15 Jun 2026 00:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA91C2AA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484185; cv=none; b=tByPw8cR/e1lVKEmVeQpNSbRWKNfC4YB3aAzLCGmAD7ehuV2H5leelER03oiqfX1t1tHuRtDyT8PwvvnhRnyiRdSsJdHMWU9HjWNMmOrMclK5qdki3O9gtkY1gpikIl0BaqnUCcc32pY1r1otPOckJ+nJqC3+tKRmWVo+qAKWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484185; c=relaxed/simple;
	bh=AvZdXTNtSkDZo5aV+FuouBwHA4hBOPkcsNaFuzZuWL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/+i7XNpnjMAMQQMADOzJQ6TD8RLKGeCa5yh9yCRhuAfF8oCPcPCJNGN5S8hoNqom0Y4HcKBYY6zk1x0VJo2t5IU3fhxxy/sV6nHTuCmMfNFAuvtwbTa/zRx/OFy7huIXbL8qaVwjvsDksl9XdnPbihsWECp9O5BC15/OHV0VVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L817aBrg; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781484183; x=1813020183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvZdXTNtSkDZo5aV+FuouBwHA4hBOPkcsNaFuzZuWL4=;
  b=L817aBrgm+DoF7Qh1P1TcQWMqOoj5xBsRviTyB0j6uO1xYfC4p8w0lum
   DKerxU3vfXATutA/T6m/NxQCj6pM7Kx+sTuuTfyVRbGyEvAp9bAPyxbtr
   9NbUrSKlE0UljCQe6Hi2bIeThuznTgXpDMrnTBU2z5bAh1gHrnhx7F965
   h6OYZRMPlNSbHktVv90Dx8wYVC5kdp5TizEGwsa4AHgyF9Ajs7KoZ8jrr
   Ork/AHshnVGxTqP+0eNSsKhJk6RgLnbXAeXCe2cmYac/+pgwGgEacwtcD
   lQoYKIh8d4PQMKKwS5NBh3IxPpSNH38C+pqSnu3zpd1O2ijj/umEQmXE2
   g==;
X-CSE-ConnectionGUID: EtvdzxOgTSeKdlGjfs/bfw==
X-CSE-MsgGUID: cyu4AyjKTsWUv6Fvx+8DZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82233292"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82233292"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 17:43:03 -0700
X-CSE-ConnectionGUID: qoqDpLDbTSWJblD78y8e5g==
X-CSE-MsgGUID: C8Pxmp9mSZ2qIN7l1XsRHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271003255"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jun 2026 17:42:58 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYvPj-00000000RKs-3KLk;
	Mon, 15 Jun 2026 00:42:55 +0000
Date: Mon, 15 Jun 2026 08:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: mheib@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	Mohammad Heib <mheib@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: add devlink parameter
 for Flow Director ATR sample rate
Message-ID: <202606150807.u6hUM8VJ-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299283-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mheib@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38E51682A89

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/mheib-redhat-com/i40e-add-devlink-parameter-for-Flow-Director-ATR-sample-rate/20260615-001257
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260614161131.192068-1-mheib%40redhat.com
patch subject: [Intel-wired-lan] [PATCH net-next] i40e: add devlink parameter for Flow Director ATR sample rate
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260615/202606150807.u6hUM8VJ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260615/202606150807.u6hUM8VJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606150807.u6hUM8VJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_devlink.c:106:9: error: incompatible function pointer types initializing 'int (*)(struct devlink *, u32, union devlink_param_value *, struct netlink_ext_ack *)' (aka 'int (*)(struct devlink *, unsigned int, union devlink_param_value *, struct netlink_ext_ack *)') with an expression of type 'int (struct devlink *, u32, union devlink_param_value, struct netlink_ext_ack *)' (aka 'int (struct devlink *, unsigned int, union devlink_param_value, struct netlink_ext_ack *)') [-Wincompatible-function-pointer-types]
     106 |                              i40e_atr_sample_rate_validate),
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/devlink.h:650:14: note: expanded from macro 'DEVLINK_PARAM_DRIVER'
     650 |         .validate = _validate,                                          \
         |                     ^~~~~~~~~
   1 error generated.


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

