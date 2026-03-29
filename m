Return-Path: <netdev+bounces-272874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Jf6IcQIyWl2tgUAu9opvQ
	(envelope-from <netdev+bounces-272874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E0351BF2
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53EF130179FC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99C3451B3;
	Sun, 29 Mar 2026 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WU859tyo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0A3446CE
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774782648; cv=none; b=dfq6m40mVfRMSJU/gv/nFKCapbJZZPDBrdRoJyKK3FZorFJcWXpbEdqQac08UNVgkYmTTNWwD52Lc6GGE8f4p3zpjt9Wg+CpzIq57cg4FRVc7tAmXuzzeF8iSSbdgJz2lIvqzH6e9ljQSTIJGWxYLyilJNFbeOi+MjWfR3PDjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774782648; c=relaxed/simple;
	bh=g2CTlm/4BOAAf+kUViN/ibgUNHCsThNxTS+MoqudMlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMceXsxI/GVull90mplnI2YDkHXfympubinDybLW7DgRAF06ELQFEiQkoqNMR7Le7OYL3tnGAEVB18wGbf8iRDWfIQ0WkoPoxXHjApS7h2Xy0TDYAI+zvjin5D/8/p2UMxM4NKgPbtjYkrn+fLGh7IdjOB2mk+Zjaoes8rsSU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WU859tyo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774782647; x=1806318647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2CTlm/4BOAAf+kUViN/ibgUNHCsThNxTS+MoqudMlU=;
  b=WU859tyoF0kVP6ITUWJnNnvXOXhraTY3BWWIknCTT2fdtVfz0Ua1LR/u
   yxKLis5/gtiHeRC9BLxI0kQgnVx1WwkDNp8jt440fFbLAZcCfEXzR/Vxc
   8l8RNBmTu1rLmSurzqxIzI2gStDoL1avVIX4c48zNZf9xkrCmrs0/uYjZ
   cF3w62sQw/RrWcth5ksL3SO41KSgDCq3o7syU9v91DTfiISschHGx+COA
   N30YSm2R+PbAqUjIha6l63+QSmi+ODIYD5DvT3WSXV3AGnb2SKURLtoEB
   zbpQqU9P0n0Z9KezbTgk3iQfCCJOWcWFNoTx/rmKt7sTBlDIAzSsX3mlW
   w==;
X-CSE-ConnectionGUID: IiAjivkjQc6Ay8UlpgZ+xQ==
X-CSE-MsgGUID: aJ0quetYRGe/MheCASxPgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75504059"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75504059"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 04:10:46 -0700
X-CSE-ConnectionGUID: zckU4j3RQ/qXJvBeSKaRtw==
X-CSE-MsgGUID: NMbtkP5lS6+/CVMAN6483g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="230570832"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2026 04:10:44 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6o2T-00000000CJ3-1Gh7;
	Sun, 29 Mar 2026 11:10:41 +0000
Date: Sun, 29 Mar 2026 19:10:19 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
Message-ID: <202603291907.vWkbcfS4-lkp@intel.com>
References: <20260327213441.3781433-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327213441.3781433-1-kuniyu@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272874-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: DB1E0351BF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tun-Ignore-tun-in-netdev_lock_pos/20260328-220059
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260327213441.3781433-1-kuniyu%40google.com
patch subject: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
config: x86_64-rhel-9.4-kselftests (https://download.01.org/0day-ci/archive/20260329/202603291907.vWkbcfS4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603291907.vWkbcfS4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603291907.vWkbcfS4-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `netdev_lock_pos':
>> net/core/dev.c:540:(.text+0x24fe910): undefined reference to `tun_link_ops'
>> ld: net/core/dev.c:540:(.text+0x254084c): undefined reference to `tun_link_ops'


vim +540 net/core/dev.c

   529	
   530	static inline unsigned short netdev_lock_pos(const struct net_device *dev)
   531	{
   532		unsigned short dev_type = dev->type;
   533		int i;
   534	
   535		for (i = 0; i < ARRAY_SIZE(netdev_lock_type); i++)
   536			if (netdev_lock_type[i] == dev_type)
   537				return i;
   538	
   539		/* the last key is used by default */
 > 540		WARN_ONCE(!netdev_is_tun(dev),
   541			  "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
   542		return ARRAY_SIZE(netdev_lock_type) - 1;
   543	}
   544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

