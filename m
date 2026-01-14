Return-Path: <netdev+bounces-249689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72953D1C2AB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8447530184FA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E615320385;
	Wed, 14 Jan 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKr37H0P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7B2F39B9
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359009; cv=none; b=NODc6fhkPyS5FdaC+cmfyVVjJfxZ1p2RoiUb9ZxlaPDRWkhKkLoLx5ow/0wmNx8dXKVyf7kzxjI9i1sSAICi7hZy0zn37U4dfH0E0y5VMRC04DL0SprYaPCtEm2MGejtD9cHxmj4ZmBwuGs4LP2vMMD8RO4peJ8fYGWpL9iJMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359009; c=relaxed/simple;
	bh=ZrFe6uXmQcPC+JJlxS1CWKdjiXJZxckY7JJ6Uf8jH6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkSq/rFYzi6qwvvlKSzJJ7OvS015bR5BWi9obXXd411pSdw6E7SG7cmoPMFct7RFmOeIQQjImISfHWvehPvthkkU4fw+VEtEgJ/3SBJt6vMFajhw4Y1OXr+6M+cgUDUxQ7llEBnODL3mtPv/oTu5/37Nl22EWBES0MoaInaJmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKr37H0P; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768359007; x=1799895007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZrFe6uXmQcPC+JJlxS1CWKdjiXJZxckY7JJ6Uf8jH6Y=;
  b=IKr37H0PLdwrtMUa6keFFaYB8XXglegz6z7R6SKZM00ijZZkFUpU34rL
   GCLVRnYCTNmSs+oyniapJNPCF2peIT9mSUhyq3Oa1MOTqmoICRGXJ2OE5
   p2GmEM7MMOMx0hcHdGMkqi6G5M7lHMpFfMwe3Yb4O4Di0TVjQV03GsuDN
   bAf1uTrS+vwuP7tZlkQs4B1c9I3bPwpmSroQLI4wpzvW4YGcofgGMCORg
   xJs1x9W/pLQap8nc1zSTAfwsK9e+9ZAe3/rc3vMvVibAByt6RhLho+yVs
   2NL/E7vHuIZbAmZF3jgxURnsSOabZUfQiyw8oNammmpGMlzcFS2an237x
   g==;
X-CSE-ConnectionGUID: 7pApioBxTvap6r7Lt+3kgA==
X-CSE-MsgGUID: w8KkFUlzQ2aXOt7TmeSOEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80764843"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="80764843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 18:50:07 -0800
X-CSE-ConnectionGUID: 2gripGHuSTi7kGQO4oNtgw==
X-CSE-MsgGUID: DWe3/k0jTRaVTJooD1F0Ow==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Jan 2026 18:50:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfqxN-00000000Fgy-2oWo;
	Wed, 14 Jan 2026 02:50:01 +0000
Date: Wed, 14 Jan 2026 10:49:43 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dhowells@redhat.com,
	syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	stable@kernel.org, linux-kernel@kernel.org
Subject: Re: [PATCH] rxrpc: Fix data-race warning and potential load/store
 tearing
Message-ID: <202601141005.joqBs0CU-lkp@intel.com>
References: <3535584.1768322992@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3535584.1768322992@warthog.procyon.org.uk>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.19-rc5 next-20260113]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Howells/rxrpc-Fix-data-race-warning-and-potential-load-store-tearing/20260114-005726
base:   net/main
patch link:    https://lore.kernel.org/r/3535584.1768322992%40warthog.procyon.org.uk
patch subject: [PATCH] rxrpc: Fix data-race warning and potential load/store tearing
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260114/202601141005.joqBs0CU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601141005.joqBs0CU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601141005.joqBs0CU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/rxrpc/proc.c: In function 'rxrpc_peer_seq_show':
>> net/rxrpc/proc.c:299:61: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 8 has type 'int' [-Wformat=]
     299 |                    "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
         |                                                         ~~~~^
         |                                                             |
         |                                                             long long unsigned int
         |                                                         %6u
   ......
     305 |                    (s32)now - (s32)peer->last_tx_at,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~          
         |                             |
         |                             int


vim +299 net/rxrpc/proc.c

d2ce4a84c21f803 David Howells 2023-10-26  274  
bc0e7cf43370a8e David Howells 2018-10-15  275  /*
bc0e7cf43370a8e David Howells 2018-10-15  276   * generate a list of extant virtual peers in /proc/net/rxrpc/peers
bc0e7cf43370a8e David Howells 2018-10-15  277   */
bc0e7cf43370a8e David Howells 2018-10-15  278  static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
bc0e7cf43370a8e David Howells 2018-10-15  279  {
bc0e7cf43370a8e David Howells 2018-10-15  280  	struct rxrpc_peer *peer;
bc0e7cf43370a8e David Howells 2018-10-15  281  	time64_t now;
bc0e7cf43370a8e David Howells 2018-10-15  282  	char lbuff[50], rbuff[50];
bc0e7cf43370a8e David Howells 2018-10-15  283  
bc0e7cf43370a8e David Howells 2018-10-15  284  	if (v == SEQ_START_TOKEN) {
bc0e7cf43370a8e David Howells 2018-10-15  285  		seq_puts(seq,
eeaedc5449d9fcc David Howells 2024-12-04  286  			 "Proto Local                                           Remote                                          Use SST   Maxd LastUse      RTT      RTO\n"
bc0e7cf43370a8e David Howells 2018-10-15  287  			 );
bc0e7cf43370a8e David Howells 2018-10-15  288  		return 0;
bc0e7cf43370a8e David Howells 2018-10-15  289  	}
bc0e7cf43370a8e David Howells 2018-10-15  290  
bc0e7cf43370a8e David Howells 2018-10-15  291  	peer = list_entry(v, struct rxrpc_peer, hash_link);
bc0e7cf43370a8e David Howells 2018-10-15  292  
bc0e7cf43370a8e David Howells 2018-10-15  293  	sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
bc0e7cf43370a8e David Howells 2018-10-15  294  
bc0e7cf43370a8e David Howells 2018-10-15  295  	sprintf(rbuff, "%pISpc", &peer->srx.transport);
bc0e7cf43370a8e David Howells 2018-10-15  296  
bc0e7cf43370a8e David Howells 2018-10-15  297  	now = ktime_get_seconds();
bc0e7cf43370a8e David Howells 2018-10-15  298  	seq_printf(seq,
b40ef2b85a7d117 David Howells 2024-12-04 @299  		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
bc0e7cf43370a8e David Howells 2018-10-15  300  		   lbuff,
bc0e7cf43370a8e David Howells 2018-10-15  301  		   rbuff,
a05754295e01f00 David Howells 2022-05-21  302  		   refcount_read(&peer->ref),
1fc4fa2ac93dcf3 David Howells 2022-10-03  303  		   peer->cong_ssthresh,
eeaedc5449d9fcc David Howells 2024-12-04  304  		   peer->max_data,
db6f1fa7f67e415 David Howells 2026-01-13  305  		   (s32)now - (s32)peer->last_tx_at,
b40ef2b85a7d117 David Howells 2024-12-04  306  		   READ_ONCE(peer->recent_srtt_us),
b40ef2b85a7d117 David Howells 2024-12-04  307  		   READ_ONCE(peer->recent_rto_us));
bc0e7cf43370a8e David Howells 2018-10-15  308  
bc0e7cf43370a8e David Howells 2018-10-15  309  	return 0;
bc0e7cf43370a8e David Howells 2018-10-15  310  }
bc0e7cf43370a8e David Howells 2018-10-15  311  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

