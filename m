Return-Path: <netdev+bounces-271821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEPqJ/mqxGmD2AQAu9opvQ
	(envelope-from <netdev+bounces-271821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:41:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB61032EE0F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 967663034B0B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52CD342CB4;
	Thu, 26 Mar 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPrJSbVp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455B3191D0
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496401; cv=none; b=Wwr5oO/mdL1S271HhjMZLBD3caWKCrRUwjHiiFHUoL3LjBPvtkh4utlOcoOi3gSOrpJeEWVGPhRAYLx+ukIPLI9v4SAxdPE6HRPo0uPHYBBzl9NHTa3M+t/W5E/9+vPSbfhJ8XzBNH+qFygi5df29T4VQ00IR9zwjsGMSFjHoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496401; c=relaxed/simple;
	bh=TMDivWj59GFG2B2x38eU+oY0bhgN3gKPnQXW3F47Hlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJZxyMoWuONBizD3MbM6pKT7uijbSWq8uMzKNfi+U6CL+qsvcpmICZzXZqVvlI72YeHivLmGH9gUDw2+acDWI1ng+ilJsRjMSwAaNN+cbOEtIROfks7HKDEtb/iC9L+hMVrP9OqOre3yEiDRlPmlX8R0UpwFgRq2HIzhPisjrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPrJSbVp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774496400; x=1806032400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMDivWj59GFG2B2x38eU+oY0bhgN3gKPnQXW3F47Hlc=;
  b=iPrJSbVptU0qvlt0tPrH+d+AuZwSzlcpkzU68jm/RUeWBchHVGO+79vT
   0W13zym3+9Q5PJhqznIJCYKNFIcwAnI1sjZQiwYxt7AhXGaEUr0oywK0s
   EQPP4KA7JJm7/VEztEolzxXCd+vRKBKrl4hBokDkSTYdd9u2RAffj3Djs
   FF60iXnvnd8PUZlL/2Q9/Py34k0TabCivGaQs6bkORZaCUcFPU/bcW9mr
   aYmb76ozWouKzt/zLINBRT8+q6cRtOmc8gzunv4zESXiI7S6ByDxtz06S
   qm2LU3/ekPzWDuwwx1Kfstn2Ykw/1z8pmjUxu6+RFWrH7jUHz+RQXHfrS
   A==;
X-CSE-ConnectionGUID: fuNxSPNfT06JViZQ04c8NA==
X-CSE-MsgGUID: pWqguhxiSpC7FIzz/iGqPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86922264"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86922264"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 20:40:00 -0700
X-CSE-ConnectionGUID: 1y65ayX4QM2CZYguO3k8Ug==
X-CSE-MsgGUID: HDBiyDr/TvS5rAAGUti7Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="218284113"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Mar 2026 20:39:58 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5bZb-0000000086D-0XDC;
	Thu, 26 Mar 2026 03:39:55 +0000
Date: Thu, 26 Mar 2026 11:39:43 +0800
From: kernel test robot <lkp@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
	davem@davemloft.net, Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions
 on netlink updates
Message-ID: <202603261127.QrC9E9f0-lkp@intel.com>
References: <20260325161020.3516-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325161020.3516-2-fmancera@suse.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-271821-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: EB61032EE0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Fernando-Fernandez-Mancera/ipv4-ipv4-handle-devconf-post-set-actions-on-netlink-updates/20260326-020953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260325161020.3516-2-fmancera%40suse.de
patch subject: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions on netlink updates
config: arm-randconfig-002-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261127.QrC9E9f0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261127.QrC9E9f0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261127.QrC9E9f0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/devinet.c:2131:13: warning: 'devinet_conf_post_set' used but never defined
    2131 | static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/devinet_conf_post_set +2131 net/ipv4/devinet.c

  2130	
> 2131	static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
  2132					  int attr, int new, int old, int index);
  2133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

