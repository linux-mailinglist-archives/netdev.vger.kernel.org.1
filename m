Return-Path: <netdev+bounces-249706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64ED1C43B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98B88300FD7F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C81284896;
	Wed, 14 Jan 2026 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+l+odKp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67682E401
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361531; cv=none; b=PXUSXAECeE1cQeJr5V8210GQ3OrphL9y6HJ/HKOzPEduNC2e+TQB0HtKa+4u0jvVNU29gYjDhMYmcWIGhgMQRKYcUbD98bBhvcc4GsJnpLpUiu0jXo2Bps2FlGEZJf/qWJ+YyjCCe1C7wPge0hWihEpi/J07yb/as7mC57FicBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361531; c=relaxed/simple;
	bh=DgAhAdepUnjp+k3Df0WJMhod73fO0hqcJptvi1pvuuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmUZQPh5IL4e8aXxIQRyAAdXH8q+glOHFU45WtE0kF0TYm9yW9xbU8Ik9/AutfDai46Thbz6XXjIfsmQg8x0rOFSlL12/NVxoRlZC7zmzSmVVHQpCvK3+yzLxZ+WqnKwXirkIbUHJhqL3xKIcwzcLH3hX0yhx7NcimJnj5zQ7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+l+odKp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768361529; x=1799897529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DgAhAdepUnjp+k3Df0WJMhod73fO0hqcJptvi1pvuuA=;
  b=l+l+odKpq2dXv93RP/ReCV+txmUQrCC2hMM1qnIvQKUzMw+rUgdifbuV
   5Y8MePAnrX8RN8iyVm3QdK2AW78u0+I6BpyM9kXIFdtZPaCL40PX2kkiN
   3MmEPICeP8WucNZ4IG/gnl5CHtaaVZcf2z8LSDTHgDHEEfGb6fUyWgDoy
   BiIcipPIZ/6J+Ui92ZZXRzAZDEstFvdlpHLZwBlI9FFQ9ObaXq7zszge4
   20N8kSPj3gCHG21v8PXd2b1KG7DvQmaWxYt7NRdPCPUWkeafHjodiNGHf
   z1EFNqg+cVNftW6edk4aZ0h+M4O2Ih/0FTC4w+axj7WnUk4dP/q9oJqKK
   A==;
X-CSE-ConnectionGUID: bFabglaCTUiAmDGvfSnq8Q==
X-CSE-MsgGUID: QEjXjmriRxKEMBpZX+OEsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80306359"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="80306359"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:32:09 -0800
X-CSE-ConnectionGUID: lbfhpFDURfK7rW8hPfkrng==
X-CSE-MsgGUID: r0fEaz18RpyK09lrk5Ovlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="235281436"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Jan 2026 19:32:07 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfrc3-00000000FjQ-35Uq;
	Wed, 14 Jan 2026 03:32:03 +0000
Date: Wed, 14 Jan 2026 11:31:58 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dhowells@redhat.com,
	syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	stable@kernel.org, linux-kernel@kernel.org
Subject: Re: [PATCH] rxrpc: Fix data-race warning and potential load/store
 tearing
Message-ID: <202601141152.2TfkKMKv-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-006-20260114 (https://download.01.org/0day-ci/archive/20260114/202601141152.2TfkKMKv-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601141152.2TfkKMKv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601141152.2TfkKMKv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/rxrpc/proc.c:305:6: warning: format specifies type 'unsigned long long' but the argument has type 's32' (aka 'int') [-Wformat]
     299 |                    "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
         |                                                         ~~~~~
         |                                                         %6d
     300 |                    lbuff,
     301 |                    rbuff,
     302 |                    refcount_read(&peer->ref),
     303 |                    peer->cong_ssthresh,
     304 |                    peer->max_data,
     305 |                    (s32)now - (s32)peer->last_tx_at,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +305 net/rxrpc/proc.c

   274	
   275	/*
   276	 * generate a list of extant virtual peers in /proc/net/rxrpc/peers
   277	 */
   278	static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
   279	{
   280		struct rxrpc_peer *peer;
   281		time64_t now;
   282		char lbuff[50], rbuff[50];
   283	
   284		if (v == SEQ_START_TOKEN) {
   285			seq_puts(seq,
   286				 "Proto Local                                           Remote                                          Use SST   Maxd LastUse      RTT      RTO\n"
   287				 );
   288			return 0;
   289		}
   290	
   291		peer = list_entry(v, struct rxrpc_peer, hash_link);
   292	
   293		sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
   294	
   295		sprintf(rbuff, "%pISpc", &peer->srx.transport);
   296	
   297		now = ktime_get_seconds();
   298		seq_printf(seq,
   299			   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
   300			   lbuff,
   301			   rbuff,
   302			   refcount_read(&peer->ref),
   303			   peer->cong_ssthresh,
   304			   peer->max_data,
 > 305			   (s32)now - (s32)peer->last_tx_at,
   306			   READ_ONCE(peer->recent_srtt_us),
   307			   READ_ONCE(peer->recent_rto_us));
   308	
   309		return 0;
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

