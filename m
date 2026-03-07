Return-Path: <netdev+bounces-265211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jXwFG+KsrGn8sgEAu9opvQ
	(envelope-from <netdev+bounces-265211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4E22DF04
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5244C301589C
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D32D7DF3;
	Sat,  7 Mar 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naCO/ixn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3D28850C;
	Sat,  7 Mar 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772924126; cv=none; b=M9ua1f5mlCIFWDW4TbzqGMBeXr1ZhMmErgC8iXTc9IXTFzosGeLX0cXT/xspVmnyjK1Pubv4QDCoU3rjf5pawnYrX63byXibY2AujpKhvOZ5K6KE8rVz4sLAh9oru2UKq+Q5kO9ICIRoDwY1tDcf+Gp8LP5JGRamtl6He80XCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772924126; c=relaxed/simple;
	bh=S6aJclqK+GWTZQHZVx1zYz2w7ZwWYx+BBc38YF5p2MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9yt5z/jTgmU3Q+OGVhK0yGcbuUEGrvEa2tsTT+mHxUUsgAWyPTuRjx5PJr0HBlr2TyoYqSmdjaGejf/yTCIe1Ldmk5QKVipZc5l6u8VzIRuJbqf27sysnoEr23jVRLWUB2Fbbn7o8ocObtYkAR72sa9JStrMnTCxG0zjRx6kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naCO/ixn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772924124; x=1804460124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6aJclqK+GWTZQHZVx1zYz2w7ZwWYx+BBc38YF5p2MA=;
  b=naCO/ixn8RoFTn+QyOb14j8ShE25EcrnP4+Uw+cIJvXG6YoIFXUG5S9r
   tHXe/HOIJcaNSmviE3Zn85ZqHEy27X4xDu1lCCod4Gzqi8EtENZYYeNX3
   O0UoO1jA7DP43g0DcIy6/uABmpH5f2+SZV/1UcOq1UvjshYSDE2feQqkS
   aRyptnt6zRBMHzMVR+DBHZx0sSl2eQKmnnajascobXuermbk/5Npd5/e7
   DcvK5/70gYiHtWYJQiwTKoyzeMLzlcpzqd/wzMohILVHCOV5n3HC8TCDO
   2ilC954HJMI9KKl9ALv+05nkbTZZ77lU5lMga/Al1PtR3NSS6VgCz2lho
   w==;
X-CSE-ConnectionGUID: o/Jte0ujQIyOXfqj7dT+UA==
X-CSE-MsgGUID: otUGgUrTTwaEk/nH3yxCHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="77598418"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="77598418"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 14:55:24 -0800
X-CSE-ConnectionGUID: htWg7lEFRlybX9uySWVXlQ==
X-CSE-MsgGUID: h8ouixoaT8+JuVm4+ZsPdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="223480544"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Mar 2026 14:55:21 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz0YH-000000002hF-3ZvM;
	Sat, 07 Mar 2026 22:55:17 +0000
Date: Sun, 8 Mar 2026 06:55:12 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: yt921x: Use u64_stats_t for
 MIB stats
Message-ID: <202603080637.k8pQfAUS-lkp@intel.com>
References: <20260306154637.3126497-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306154637.3126497-3-mmyangfl@gmail.com>
X-Rspamd-Queue-Id: CCB4E22DF04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,lunn.ch,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-yt921x-Return-early-for-failed-MIB-read/20260307-004743
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260306154637.3126497-3-mmyangfl%40gmail.com
patch subject: [PATCH net-next v4 2/2] net: dsa: yt921x: Use u64_stats_t for MIB stats
config: i386-buildonly-randconfig-003-20260307 (https://download.01.org/0day-ci/archive/20260308/202603080637.k8pQfAUS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080637.k8pQfAUS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080637.k8pQfAUS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/dsa/yt921x.c:29:
>> drivers/net/dsa/yt921x.h:588:29: error: flexible array member in union
     588 |                 u64_stats_t stats[];
         |                             ^~~~~


vim +588 drivers/net/dsa/yt921x.h

   533	
   534	struct yt921x_mib {
   535		union {
   536			struct {
   537				u64_stats_t rx_broadcast;
   538				u64_stats_t rx_pause;
   539				u64_stats_t rx_multicast;
   540				u64_stats_t rx_crc_errors;
   541	
   542				u64_stats_t rx_alignment_errors;
   543				u64_stats_t rx_undersize_errors;
   544				u64_stats_t rx_fragment_errors;
   545				u64_stats_t rx_64byte;
   546	
   547				u64_stats_t rx_65_127byte;
   548				u64_stats_t rx_128_255byte;
   549				u64_stats_t rx_256_511byte;
   550				u64_stats_t rx_512_1023byte;
   551	
   552				u64_stats_t rx_1024_1518byte;
   553				u64_stats_t rx_jumbo;
   554				u64_stats_t rx_good_bytes;
   555	
   556				u64_stats_t rx_bad_bytes;
   557				u64_stats_t rx_oversize_errors;
   558	
   559				u64_stats_t rx_dropped;
   560				u64_stats_t tx_broadcast;
   561				u64_stats_t tx_pause;
   562				u64_stats_t tx_multicast;
   563	
   564				u64_stats_t tx_undersize_errors;
   565				u64_stats_t tx_64byte;
   566				u64_stats_t tx_65_127byte;
   567				u64_stats_t tx_128_255byte;
   568	
   569				u64_stats_t tx_256_511byte;
   570				u64_stats_t tx_512_1023byte;
   571				u64_stats_t tx_1024_1518byte;
   572				u64_stats_t tx_jumbo;
   573	
   574				u64_stats_t tx_good_bytes;
   575				u64_stats_t tx_collisions;
   576	
   577				u64_stats_t tx_aborted_errors;
   578				u64_stats_t tx_multiple_collisions;
   579				u64_stats_t tx_single_collisions;
   580				u64_stats_t tx_good;
   581	
   582				u64_stats_t tx_deferred;
   583				u64_stats_t tx_late_collisions;
   584				u64_stats_t rx_oam;
   585				u64_stats_t tx_oam;
   586			};
   587	
 > 588			u64_stats_t stats[];
   589		};
   590	};
   591	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

