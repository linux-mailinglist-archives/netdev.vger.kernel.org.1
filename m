Return-Path: <netdev+bounces-292655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i00jJmsgGGoAeAgAu9opvQ
	(envelope-from <netdev+bounces-292655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1585F0FF6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 733F0311D7D4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458923D45C1;
	Thu, 28 May 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSfpi6Qb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423163D3CF5;
	Thu, 28 May 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965723; cv=none; b=ogbyREs78CdFWJtEXDpY0YNtfgupSyHU335ZfRjcdbKlJ6/kwizHZfde7Uf8XzEMR2JH5l4wSRsCAbo5fJUYHQh1dNhy4RwaOcBTEXMoR19+v7mU8ZPpjG6ldFl8BBN8sn+XPuL17gigEFxL33r1QtyNJ5tvjhP0MxxtS8tp6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965723; c=relaxed/simple;
	bh=RQZfWunTveBGTrLi/8LjGUJqz5oKuLD/v0g5KNaOPIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQHaieJkhx2YUcctlykH4SVEwgU1zNIG6soBMSeSZwFzp1yhfk6gJc2mduNgdUbmWNFwEAN1zW60fO//o4D1xHwFxLHLh3XSDKJfLqAC7FtthlabgOM8FjP8EATbDgcQfyCfJN4/2cDaNE4EZSGWkYZfqQGiBpVdY1b/EmrgZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSfpi6Qb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779965721; x=1811501721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQZfWunTveBGTrLi/8LjGUJqz5oKuLD/v0g5KNaOPIw=;
  b=lSfpi6Qb+GTgR32j0jnCclNJqE+IdX9gm2NjkTOgW7qgXaDaLmuXI82x
   T2hqDShnBDvbGtF4j0/CjOQmXKQja9dU4CPYGD2WkQoxkG9QU1YmGO+dY
   x4FZ8VdXzU1ZRZvgjHj5+YmQxEN20did3umAnzrSKNFd9NG1TvMVgAjju
   VBUdwaWCh9MI8shpN6mVMAr0qMbPwIj++L0YXEbSv665lDTyyQLlHWtuq
   2hZ76VDvGWZDOmaHCd+jlsajWRpDpl0VzAdX8n3agz6P+8SwpyBpkEfDV
   eglLdsjY4gcSbZrHGhqH9Y3jk/TZ8c5XTddKpoTn9l9z2+3cyE6ICAsO7
   w==;
X-CSE-ConnectionGUID: FJmoocSrQcC4Mqj8oEaTRg==
X-CSE-MsgGUID: 9YAdbfGBTs+2VrJsqIrung==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80796634"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80796634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 03:55:20 -0700
X-CSE-ConnectionGUID: FJO8QiD2TSujPQRICqxUhQ==
X-CSE-MsgGUID: 3rCEFMJ8Q0Omu2SZ5cJmtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="266420616"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 May 2026 03:55:17 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSYOQ-000000005sk-03zS;
	Thu, 28 May 2026 10:55:14 +0000
Date: Thu, 28 May 2026 18:54:19 +0800
From: kernel test robot <lkp@intel.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Chuang Wang <nashuiliang@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <202605281822.xLK0Dj87-lkp@intel.com>
References: <20260525025854.13982-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525025854.13982-1-nashuiliang@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-292655-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 5A1585F0FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuang-Wang/net-reduce-RFS-ARFS-flow-updates-by-checking-LLC-affinity/20260525-110036
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260525025854.13982-1-nashuiliang%40gmail.com
patch subject: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by checking LLC affinity
config: sh-sh7763rdp_defconfig (https://download.01.org/0day-ci/archive/20260528/202605281822.xLK0Dj87-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281822.xLK0Dj87-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605281822.xLK0Dj87-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: net/ipv4/tcp.o: in function `tcp_splice_read':
>> tcp.c:(.text+0x3e90): undefined reference to `sock_rps_record_flow'
   sh4-linux-ld: net/ipv4/tcp.o: in function `tcp_zerocopy_receive':
   tcp.c:(.text+0x4cf4): undefined reference to `sock_rps_record_flow'
   sh4-linux-ld: net/ipv4/af_inet.o: in function `inet_send_prepare':
>> af_inet.c:(.text+0x538): undefined reference to `sock_rps_record_flow'
   sh4-linux-ld: net/ipv4/af_inet.o: in function `inet_recvmsg':
   af_inet.c:(.text+0x570): undefined reference to `sock_rps_record_flow'
   sh4-linux-ld: net/ipv4/af_inet.o: in function `__inet_accept':
   af_inet.c:(.text+0x644): undefined reference to `sock_rps_record_flow'
   sh4-linux-ld: net/ipv4/af_inet.o:af_inet.c:(.text+0x2048): more undefined references to `sock_rps_record_flow' follow

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

