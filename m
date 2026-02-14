Return-Path: <netdev+bounces-258748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YvAtF0/5kGl4eAEAu9opvQ
	(envelope-from <netdev+bounces-258748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:38:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540D13DB97
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ECA7301918A
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 22:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FEC3195FD;
	Sat, 14 Feb 2026 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5d2CgS/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E5318EF8;
	Sat, 14 Feb 2026 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108682; cv=none; b=fwUS4g8pbBqg802pgIpxqJXxjR1VqRzYz80XvOE+D6psCMWIMZXm23jVKlxBO2RGnfLxE8IyNcUilN51Vf8Um4GutjAXdCmZ5xhzl2ARJYorcykxI0w12U4uUGvNseyoFRC518w8/IKFRS/oEZfxdYavE+Ch5apPmKDQeJqBOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108682; c=relaxed/simple;
	bh=sfeKRemoRP6AGEZUVLY7EUXiLIlvcJ1lUcv39EjqSMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8BEyoWsA13bnEYSv9Fan3oe1R8aj7AZcGE0X6VKbzjX/vgxwHtbR+tB2qMugmUOjg9AVNFAH9KWtJTopcP01K+Tay/HOVIQVSntz4vwWoN5XQKZxxtnQhh2teo93/reebE/uaXZ1RFiU7FmWJiGSWGqboN8ugW0Yp7rEu4382k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5d2CgS/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771108681; x=1802644681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfeKRemoRP6AGEZUVLY7EUXiLIlvcJ1lUcv39EjqSMc=;
  b=c5d2CgS/eXcKQNk+TdEDdTId9wOk6sKwIkKfGvidSRnXUxfb7ljvb9je
   UJ1xwvmZQX3bjhAuZDhoy7eO0B/ggEfstu3c/KVzd97kMy6of71SrcCbv
   FhlCydBdWozrZhc9aAm+5re3bRnFpfDUyM+jS8waXz5WQIFuwXd8zbsbM
   9aYT0G1Zi/Zy2jEt3V3GbjEapH4U3+lHTAKPFfsY6C+/cCLDIbCAWXpGx
   cC62yxPxkkh4ys54JLtzoykeGgQc/Pk6zYAs5sjIMgJfQ3KEya9mPqUVp
   jhY1nMHEYGTHi1OIkdYtV/0V2lINCG5qoeM7x64DUbNmi4mL4Po1JM2uQ
   Q==;
X-CSE-ConnectionGUID: 4NsjmrPYTOybQ7ZABGo4lA==
X-CSE-MsgGUID: mgVXMR+iTK6ZF745tLaB6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83354015"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="83354015"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 14:38:01 -0800
X-CSE-ConnectionGUID: oYm+91+EQvy97mKuuZOM8g==
X-CSE-MsgGUID: Si/FvinmTdWUIhox4TQ8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="217787009"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Feb 2026 14:37:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrOGw-00000000x32-0UiW;
	Sat, 14 Feb 2026 22:37:54 +0000
Date: Sun, 15 Feb 2026 06:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, hawk@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	kernel-team@cloudflare.com, jbrandeburg@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] bnxt_en: Implement XDP RSS hash metadata extraction
Message-ID: <202602150651.wYfne7oq-lkp@intel.com>
References: <20260213192449.1294830-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213192449.1294830-3-carges@cloudflare.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258748-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[cloudflare.com,broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9540D13DB97
X-Rspamd-Action: no action

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.19]
[cannot apply to linus/master next-20260213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-J-Arges/bnxt_en-use-bnxt_xdp_buff-for-xdp-context/20260214-032849
base:   v6.19
patch link:    https://lore.kernel.org/r/20260213192449.1294830-3-carges%40cloudflare.com
patch subject: [PATCH 2/2] bnxt_en: Implement XDP RSS hash metadata extraction
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20260215/202602150651.wYfne7oq-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260215/202602150651.wYfne7oq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602150651.wYfne7oq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:476:12: error: static declaration of 'bnxt_xdp_rx_hash' follows non-static declaration
     476 | static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
         |            ^~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:22:
   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h:44:5: note: previous declaration of 'bnxt_xdp_rx_hash' with type 'int(const struct xdp_md *, u32 *, enum xdp_rss_hash_type *)' {aka 'int(const struct xdp_md *, unsigned int *, enum xdp_rss_hash_type *)'}
      44 | int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
         |     ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:476:12: warning: 'bnxt_xdp_rx_hash' defined but not used [-Wunused-function]
     476 | static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
         |            ^~~~~~~~~~~~~~~~


vim +/bnxt_xdp_rx_hash +476 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c

   475	
 > 476	static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

