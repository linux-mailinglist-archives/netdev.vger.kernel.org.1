Return-Path: <netdev+bounces-134378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A4998FCD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A02F1C222F5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66F1A303E;
	Thu, 10 Oct 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGrvRxjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B91D0417
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584553; cv=none; b=tSydgrs/nlIT/GtdLdLFbqs0NKeXKiQ4HTaHx8CEJI5S/5B9rLCrhPJMMRrT7+VAy4OmceU+oEiklpB0sDr0qsiYOxRxH+y6JE+OgbM1iNLcKe/KoFQUr5CIonDIHluNPXzQuYaPxWH80PC8gWOlQYutqgZKseu3jankq3RRhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584553; c=relaxed/simple;
	bh=fBWSaHAwy0c8+s1RC5BEEg2yHijr1g1W9VYR5EiA8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwYkfnnzv9koGGA+SkiAJMnMBvZ5xGO7QAZVK2mwRvRQiK3b8lB4T15TDCsue1r6YvPm4wK+4CY9LEu3z1YclSSig9qN+V/8clK6duLmR3ZqH4vyuX0esZr+4yYW6tTrEuNYo0YqEgwlH7c8KGKmq3EId1fW5xzms2wade/4AkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGrvRxjQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728584551; x=1760120551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fBWSaHAwy0c8+s1RC5BEEg2yHijr1g1W9VYR5EiA8ko=;
  b=QGrvRxjQm4dlb9qV5+YiY29tTi19VhXh0GC9Q4SXe/lq1bZw9CA2QflK
   OkEqXIKgm3iAGVvPbNUrXY2IR9aKDCbBjFR+cqXlHsNXjSP8Fdx4yILdc
   sMV1iFj5duSC+2goaS372aezB/F3NFQhoQSnhx0C4WwvdvH6Bsyh14nJ/
   yp/74DPtBPuh7npwN7imnNs09TVYfObyU5JsbZqI/XC8ZvneZWgpskuyY
   VVR6NSZ6BojGFeC5rvaVvMhO0bmIGh15V8AcirzX1jHZYUZaz0DfbCxmp
   817cwg0B5pnJzEKZVWhfsvfPm0PeuUX3DEr/NSF7Bj1tGBLabIj2pp6/r
   g==;
X-CSE-ConnectionGUID: nUydPTcXRy6SZ6joI6+Uag==
X-CSE-MsgGUID: +v55NnyFTHiyVoUTD34Z4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28096768"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28096768"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:22:30 -0700
X-CSE-ConnectionGUID: 13xjUrSbQbWwxBQmUvsOnA==
X-CSE-MsgGUID: hqwes9KeQMqKVo3KCNhM1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="107537109"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Oct 2024 11:22:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syxnt-000B7x-1w;
	Thu, 10 Oct 2024 18:22:25 +0000
Date: Fri, 11 Oct 2024 02:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>,
	Antony Antony <antony.antony@secunet.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters <paul@nohats.ca>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	devel@linux-ipsec.org
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
Message-ID: <202410110224.x8I8OGK4-lkp@intel.com>
References: <20241007064453.2171933-2-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007064453.2171933-2-steffen.klassert@secunet.com>

Hi Steffen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on klassert-ipsec/master net/main net-next/main linus/master v6.12-rc2 next-20241010]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steffen-Klassert/xfrm-Add-support-for-per-cpu-xfrm-state-handling/20241007-145514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20241007064453.2171933-2-steffen.klassert%40secunet.com
patch subject: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
config: x86_64-randconfig-161-20241010 (https://download.01.org/0day-ci/archive/20241011/202410110224.x8I8OGK4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410110224.x8I8OGK4-lkp@intel.com/

New smatch warnings:
net/xfrm/xfrm_user.c:2550 xfrm_aevent_msgsize() warn: inconsistent indenting

Old smatch warnings:
net/xfrm/xfrm_user.c:912 xfrm_add_sa() warn: missing error code? 'err'
net/xfrm/xfrm_user.c:2128 xfrm_add_policy() warn: missing error code? 'err'
net/xfrm/xfrm_user.c:2895 xfrm_add_acquire() warn: missing error code 'err'

vim +2550 net/xfrm/xfrm_user.c

  2536	
  2537	static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
  2538	{
  2539		unsigned int replay_size = x->replay_esn ?
  2540				      xfrm_replay_state_esn_len(x->replay_esn) :
  2541				      sizeof(struct xfrm_replay_state);
  2542	
  2543		return NLMSG_ALIGN(sizeof(struct xfrm_aevent_id))
  2544		       + nla_total_size(replay_size)
  2545		       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
  2546		       + nla_total_size(sizeof(struct xfrm_mark))
  2547		       + nla_total_size(4) /* XFRM_AE_RTHR */
  2548		       + nla_total_size(4) /* XFRM_AE_ETHR */
  2549		       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
> 2550		       + nla_total_size(4); /* XFRMA_SA_PCPU */
  2551	}
  2552	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

