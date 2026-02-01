Return-Path: <netdev+bounces-255553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FA9nM4uZfmmLbQIAu9opvQ
	(envelope-from <netdev+bounces-255553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:08:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9DC4728
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A030301545E
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC36FBF;
	Sun,  1 Feb 2026 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyB7Su4F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA44A21
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904520; cv=none; b=IfXdN7ysX0GqMZvGzXCeAp3aohRYVLcTzub2V1O9gfvClaSqU09/rrG3VtGSmgohq1LL2tZQelUO1G4DsKTgjI4yx2uUVh9cTk/LkkSeqc1PJGhdr4GSZlD+JnewssOiC7OQxCJt3iqyA/QhZTj0ddMBWa77ytGd7YIpoqCh46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904520; c=relaxed/simple;
	bh=mRsA3j8YVNMsaaJgfzACt644rPWJUKk9lEzc1YZy9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvTfM3Gl30i9FUkMiPnBPVoM2j8Ix1fJkjTjtp2OOnX905PAaZ2li/lM6xIlaI5LPyCSwYMEm0hMCQYd293i4njcTxbioO3mpI2LsR/F7kAwBJXs2DUdtj+mYccalv9H22xE3w82O0LCh/WM2EkR/KUtON+H9FWE3wlWzn+L9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyB7Su4F; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769904519; x=1801440519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mRsA3j8YVNMsaaJgfzACt644rPWJUKk9lEzc1YZy9+U=;
  b=cyB7Su4FfbXo1y90stKCy9utM1NBoX9cnPAZ+fOx1o4PxSQtac2Zvupg
   k3kJHLn8OE/ZpuJoJR4zJi+mZ7RLTwSiqASpHcUmmpXXrGHpmj8aSUxSK
   F0t5UzFuD+Sw4UQIHlKW4yZD00o7C7jawppx7bK4Nhi6wn7kkgS8YW1lx
   z3wslOyEThbwydnFR/9PdHxNjuHMNsQecJb3DbzasBXGWzX2bQ0tExfyo
   wCZAJD4tdr/MJJS/Hn+FOTyyhITI7tfKb63gGVwXPvl6JpVABGVChfLL6
   JEkf5z9VvbSoWzivS7mvs6TsKxSXDQW+nr83jRGo2TWgXd7KkzywxMKs4
   w==;
X-CSE-ConnectionGUID: +/dFMkD/SuufZA5pZS6wbw==
X-CSE-MsgGUID: E0ohzomITUytUhI3Ly+iaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="73713962"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="73713962"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 16:08:38 -0800
X-CSE-ConnectionGUID: d2OSUV0DRoadTCcPokRYDQ==
X-CSE-MsgGUID: WpPz4v0zQRyLAi/CTret+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="246763400"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Jan 2026 16:08:35 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmL0y-00000000eUC-3MMc;
	Sun, 01 Feb 2026 00:08:32 +0000
Date: Sun, 1 Feb 2026 08:07:44 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] tcp: move __reqsk_free() out of line
Message-ID: <202602010833.CfxLneEX-lkp@intel.com>
References: <20260131171627.1852894-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131171627.1852894-1-edumazet@google.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255553-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 26E9DC4728
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-move-__reqsk_free-out-of-line/20260201-011758
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260131171627.1852894-1-edumazet%40google.com
patch subject: [PATCH net-next] tcp: move __reqsk_free() out of line
config: x86_64-buildonly-randconfig-003-20260201 (https://download.01.org/0day-ci/archive/20260201/202602010833.CfxLneEX-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260201/202602010833.CfxLneEX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602010833.CfxLneEX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __reqsk_free
   >>> referenced by request_sock.h:137 (include/net/request_sock.h:137)
   >>>               net/core/request_sock.o:(reqsk_fastopen_remove) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

