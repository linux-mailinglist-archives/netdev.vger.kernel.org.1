Return-Path: <netdev+bounces-258459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGU1AwLejWnE8AAAu9opvQ
	(envelope-from <netdev+bounces-258459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:04:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB2F12E189
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A816E3016B0B
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787F34AAF9;
	Thu, 12 Feb 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H875DtkW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBED3EBF1F;
	Thu, 12 Feb 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905082; cv=none; b=ec5vpY1ZNF2J9EosEK+tOCrYZAK7lMMEnxJN3Hjx4fUglCHvlmCaGA93ArH/zPxGNA4zTwVCWwG61Kkm7Iozcp4m3/brDen/sWkwEI5TYFuX5tYq9eZ5aisSbFzPzrZ2amJzwUyaQwHHhbhyHmjMYCr4gSvWsLV0llW0dJQisD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905082; c=relaxed/simple;
	bh=hC83cy9I+QvOHq44fYtXM6qMN9P2fhKYqhqqNyaPhiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K58bpyruzJn9Tn9LvpAh4GH6XeWcWHN+c5/q6l2I1coG+hinchjqKqtN7BtuCwJeHQQt0XwgALMnHRZ37384Vv2XQThQszIkVmKlnJqSpLhjgJ9uY5pLMGueaXuLmn45MZAXwvvZ9whIK56twgAJl1WUvM6bUSC0hjAxkwSM0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H875DtkW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770905081; x=1802441081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hC83cy9I+QvOHq44fYtXM6qMN9P2fhKYqhqqNyaPhiw=;
  b=H875DtkWh14TREt23k2pHr07w47fT2Ogo2t7wYbDR8sPJakkcCHKjNya
   NrICzc+PmZ+7g4ebZoIXcgHhe0gCZvInBylRHNrGk8c+2DygZKwpV3jRe
   SJkma2Er7XgXmoYXCSniKLPPKEfdGL8094UnmJHUMBf8DdXdWO19SoFQ+
   WsZyA5FO94XJCEBV8nFNt2CPD7ES1+FWtwMMbPnNGQxwEuFV0REUBhGoa
   mpmEzggQN/L/5wE7MFRxtk20tZhUIxzAGaMnWu4PjPIsPlkpIsJVZP1dH
   RxFbRalow9rgrhep9rdVPBFKNZUZdroMKVGN8+Hzuod8ftzIKLPGJWDIG
   w==;
X-CSE-ConnectionGUID: K84Hpl30TbqtfoAfq7p0CQ==
X-CSE-MsgGUID: STnqKISCSeurDd22wuNqjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83443600"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="83443600"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:04:40 -0800
X-CSE-ConnectionGUID: TUgDl26jTP25Gm4vGa+Q2g==
X-CSE-MsgGUID: TXT8PHAFRqu/SXTEK+WepQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="216763664"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 12 Feb 2026 06:04:37 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqXJ4-000000001Kr-2rHR;
	Thu, 12 Feb 2026 14:04:34 +0000
Date: Thu, 12 Feb 2026 15:04:02 +0100
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	xen-devel@lists.xenproject.org,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH 1/2] xenbus: add xenbus_device parameter to
 xenbus_read_driver_state()
Message-ID: <202602121525.xsMivuEv-lkp@intel.com>
References: <20260212083826.136221-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212083826.136221-2-jgross@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258459-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 5AB2F12E189
X-Rspamd-Action: no action

Hi Juergen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xen-tip/linux-next]
[also build test WARNING on linus/master v6.19 next-20260211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/xenbus-add-xenbus_device-parameter-to-xenbus_read_driver_state/20260212-164134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20260212083826.136221-2-jgross%40suse.com
patch subject: [PATCH 1/2] xenbus: add xenbus_device parameter to xenbus_read_driver_state()
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260212/202602121525.xsMivuEv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260212/202602121525.xsMivuEv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602121525.xsMivuEv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/xen/xenbus/xenbus_client.c:940 function parameter 'dev' not described in 'xenbus_read_driver_state'
>> Warning: drivers/xen/xenbus/xenbus_client.c:940 function parameter 'dev' not described in 'xenbus_read_driver_state'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

