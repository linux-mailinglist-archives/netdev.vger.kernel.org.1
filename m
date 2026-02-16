Return-Path: <netdev+bounces-258827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5qWeBCuGkmlWugEAu9opvQ
	(envelope-from <netdev+bounces-258827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 03:51:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90728140AF4
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 03:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 864373002329
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362D287506;
	Mon, 16 Feb 2026 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elXhlZWI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949871FE45A;
	Mon, 16 Feb 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771210280; cv=none; b=i9cbj9KO2sRQKfvz0EA9M+c2+spdrFyRRHN0EKJqW1LaFH2LqBqrRPjva+MlqmZskM9od1+0lHVJGcEReAe2M0Y5udwR0EM/uYmQXBhM2O1rTfH/4RVRM4IhYO7qOG9MK6qYXHc/N8tooUwhd9Yqy4TFjgV8WkEHn2YJJuCDR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771210280; c=relaxed/simple;
	bh=BtfTy6wRVU5oGY/Ndnmcii+F9Cr6tuNhG9rNllvi4qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyYD5DAR7qe2TW7NM40AWXQ3xzdwQMpMTihrf0d4fZBNaF8/EybEvkpma7mZCzp9MPAoVReN2LYANqIGWcFwMp514GNyqrJxdmkPeQB/5a9jp5lhYnkTQJpMBH+dGFHrwXDW3Be/nhIksfodNNJkc13rOhxYF2nRfsWeRj7W/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elXhlZWI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771210278; x=1802746278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtfTy6wRVU5oGY/Ndnmcii+F9Cr6tuNhG9rNllvi4qc=;
  b=elXhlZWIqGZdVYezHJlXyGQP/fLW6CBS//3d3N657xryz0jBaC6KyaQE
   hnoDaw5wBijYWYFJ5rw6bNSHszqcp/tJNjumYDk9L97JawGG/ZRFnVKHo
   EmMqKEauxRWTyLiRr2+0K7Ld1ZAqBnlrcF/e2WeC8cw/XyIUUvSp5kCo4
   eVyv1wbbRkwWVejWkHbXb2ZgBsxc3LqT+R8YJPF2wyYWKWq8yL/xIUn+Z
   U3Dm69BGRGUHH5TLm86f4Uh6jDm57FD5LxBbFYM3zWl7xBBEJLItucuZE
   Pe1XlcNHQwwyswP4Z15yRDEsQ6XY9GT+82yFKPVId2ittjItAuNfO4aho
   Q==;
X-CSE-ConnectionGUID: kkDbzrYHT62WaR1SqdF+QA==
X-CSE-MsgGUID: hsYGbQNGQf21eeAOQUhWOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="83017453"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="83017453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 18:51:17 -0800
X-CSE-ConnectionGUID: GznNaG7zRl6//c+ESuiY3A==
X-CSE-MsgGUID: vto2SdazRru5aXc1oO9+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="236487695"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Feb 2026 18:51:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrohd-00000000zL4-3S9V;
	Mon, 16 Feb 2026 02:51:13 +0000
Date: Mon, 16 Feb 2026 10:50:32 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for
 UDP.
Message-ID: <202602161010.ohfwdwoo-lkp@intel.com>
References: <20260215204353.3645744-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215204353.3645744-7-kuniyu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,bytedance.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-258827-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:mid,intel.com:dkim,intel.com:email,git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90728140AF4
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20260213]
[cannot apply to horms-ipvs/master v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/sockmap-Annotate-sk-sk_data_ready-for-UDP/20260216-044819
base:   linus/master
patch link:    https://lore.kernel.org/r/20260215204353.3645744-7-kuniyu%40google.com
patch subject: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
config: x86_64-buildonly-randconfig-002-20260216 (https://download.01.org/0day-ci/archive/20260216/202602161010.ohfwdwoo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260216/202602161010.ohfwdwoo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602161010.ohfwdwoo-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `sk_psock_skb_ingress':
>> skmsg.c:(.text+0x8fc777): undefined reference to `udp_sock_rfree'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

