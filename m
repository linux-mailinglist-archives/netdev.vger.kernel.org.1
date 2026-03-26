Return-Path: <netdev+bounces-271897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDtcJ7/fxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:26:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E85330681
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA56D303AF31
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336EA34888F;
	Thu, 26 Mar 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HitjoGE4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340083195F9
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510000; cv=none; b=auGp2pYdqsvEotvKQdyd+obKhutbuZROPXfTYgySGl5cRVxREI1rbIKRKz0XbJq5lUtkxuZR1WRvPV6voHF18M5zEsfwENBRjkKYE+oGpqAdUre/5c7FTyyDsprorODcJDIun5rQOSwNhC1lDSH2M49Ng0ARUO2JqB/Oqf/G750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510000; c=relaxed/simple;
	bh=KvjjeP7vxfCyvkhTAquKJCHNA7x5tuh681xz3ZNh2Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE3qOi4vB/wUHw+G4L1mD5IKpsAWLu3x30xA5i1tDUXdDquaNbjujzGwqGHVGlrz7+zPk26WCKx4PxJpVGU92mGjQWTHaXQOizXrh7Pq46N9eLkTHx/I4Dkqxo90hwEq6R4O0E7QeG+4CV8YTfyMb3qkV67YsFs+Fb+1PA0XoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HitjoGE4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774509998; x=1806045998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvjjeP7vxfCyvkhTAquKJCHNA7x5tuh681xz3ZNh2Y4=;
  b=HitjoGE4+oOtlM8G5+w4bLfJ84MKSiw3UiB+QKw+LGqxVKl3V+XrPomB
   0jg5M6WRO2PAhbrPPl7054zX9fwbPRSQpdKQQlntwx3tTMBl0V5N8I1Q1
   WORv1UE2JBqjHY2nbgPcthnENoZU9dRIoXjSCdv0XxRerJIVHjoWAxfxP
   RDRTwSWfH8yKXlgEluxl2SdL7DVuWfh+jnF0D7ftffqRSD6BThWKFBRq3
   RKT/LaDlA20wlO9N9h4fPK8c8hJ1yO8dTdLF/vz5meVOTJ+on0XVfjROz
   AfhFAOpv7b4Ezi3MT2Cio6XGTyw3BBmKxbplwS4eOO8z5vhhMJ2bxOrBM
   w==;
X-CSE-ConnectionGUID: qLCurovnTr6R4C7fJNKgEw==
X-CSE-MsgGUID: brEP9caDRwW23dBsURgIdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75754534"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75754534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:26:37 -0700
X-CSE-ConnectionGUID: hb1Z39dNQlS0a4VpP4L+qw==
X-CSE-MsgGUID: XNdlPW3yTdaJCA0grVPtzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224949373"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Mar 2026 00:26:36 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5f6u-000000008YL-3AcY;
	Thu, 26 Mar 2026 07:26:32 +0000
Date: Thu, 26 Mar 2026 15:25:37 +0800
From: kernel test robot <lkp@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
	davem@davemloft.net, Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions
 on netlink updates
Message-ID: <202603261543.ZsP9A5JB-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-271897-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01E85330681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Fernando-Fernandez-Mancera/ipv4-ipv4-handle-devconf-post-set-actions-on-netlink-updates/20260326-020953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260325161020.3516-2-fmancera%40suse.de
patch subject: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions on netlink updates
config: um-randconfig-002-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261543.ZsP9A5JB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261543.ZsP9A5JB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261543.ZsP9A5JB-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: net/ipv4/devinet.o: in function `inet_set_link_af':
>> devinet.c:(.text+0x117d): undefined reference to `devinet_conf_post_set'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

