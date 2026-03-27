Return-Path: <netdev+bounces-272501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O8COuBexmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:41:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E01C342BB1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABED3033FB8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C034E769;
	Fri, 27 Mar 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm7BpwL1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2533C5DAB;
	Fri, 27 Mar 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608093; cv=none; b=Dc0GLWUDjlvRWqCZ2QENrJ5MYyLrYZ1ctw2dEHlJSRDc+6xUMnnd5m8Htc6Xh2r7Vjgr5kJHbSiCQ0bpEDTkSxrhjfgKexkaKteu1CJO37U2bQkWWUVKlXYKXZctwqwp2we3q1F9PYK7SNwKydPdjngXzDn5wwhZBCUuu8W4mns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608093; c=relaxed/simple;
	bh=jWe6OEhA34gE7fEyHsXA6R0diYZ11O4QgBijUwIUAVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puptnprdzY7Yp07MSyRQQluzlk5BMzn9AkctjYpUh12kQeWmTaYWuQgG+hSU4+/TyrCs3jYe01YYoTVXA6BK5ONVnlaYspMuK/Pt1X0venT/ZedkavVR+HZmgk2T/Nns7mrRdFR0U7ICzkMPJ/OwfHWHsleARjsL7osNzkuM0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm7BpwL1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774608092; x=1806144092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jWe6OEhA34gE7fEyHsXA6R0diYZ11O4QgBijUwIUAVI=;
  b=Bm7BpwL1tUU/sKnQ/sdScO1csjB7tM8DAoyRVa41XERmkQwAA2PvYv9/
   GSHq3JNJ7H+5J/KjZvDnY7mN5WbS8l3LTLZdbmJGivhjwaSKB+scnmOgd
   KlwUTjeGRXCfXxRFXD3ai5VLuD1wjV9BTS0oN1xhNxKmoAymRYW0MXCxH
   czMUVkFVSzljmkDxeTS/+lRmF7Iq3S7UsxSm+OXRWY3JmF4ZSS148NnaB
   rqMYlMzZhR7EapB+Zpp7dZpE/BjdnMeOsngclxZjB+A6WU7+5hZAAGuoi
   Z09GOgOJmD5Orx6gw7M5mKv4W+ydrj5lOhfXla9b9TD9HyMjGN/Y/QyuB
   w==;
X-CSE-ConnectionGUID: E3UtSoSgTt6S3o5nopMxJw==
X-CSE-MsgGUID: AJFEhCJmSrC8+lR5vFtaWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="85986959"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="85986959"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:41:31 -0700
X-CSE-ConnectionGUID: 5kkWXhs2TKi8vmT27S42Lg==
X-CSE-MsgGUID: UZ64OI1qT/qx1vNhpOuskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="225202172"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2026 03:41:25 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w64cz-00000000AAp-16RM;
	Fri, 27 Mar 2026 10:41:21 +0000
Date: Fri, 27 Mar 2026 18:40:37 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org, netdev@vger.kernel.org,
	syzbot+7b4f368d3955d2c9950e@syzkaller.appspotmail.com
Subject: Re: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and
 shutdown().
Message-ID: <202603271810.hoQGfrEp-lkp@intel.com>
References: <20260325063843.1790782-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063843.1790782-6-kuniyu@google.com>
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
	TAGGED_FROM(0.00)[bounces-272501-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,7b4f368d3955d2c9950e];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 4E01C342BB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.0-rc5]
[cannot apply to next-20260326]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/nbd-Remove-redundant-sock-ops-shutdown-check-in-nbd_get_socket/20260325-175457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260325063843.1790782-6-kuniyu%40google.com
patch subject: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and shutdown().
config: arm64-randconfig-003-20260326 (https://download.01.org/0day-ci/archive/20260327/202603271810.hoQGfrEp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271810.hoQGfrEp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271810.hoQGfrEp-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/block/nbd.o: in function `nbd_mark_nsock_dead':
>> nbd.c:(.text+0x1238): undefined reference to `inet_shutdown_locked'
   aarch64-linux-ld: drivers/block/nbd.o: in function `__sock_xmit':
>> nbd.c:(.text+0x4fbc): undefined reference to `tcp_sendmsg_locked'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

