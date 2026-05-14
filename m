Return-Path: <netdev+bounces-287862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC+UKMCMBWo5YQIAu9opvQ
	(envelope-from <netdev+bounces-287862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A5B53F7A7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2ADA3010DA8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682C3DC4C2;
	Thu, 14 May 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBpcPQWq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C03D8917
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748606; cv=none; b=bRAK9JYHOZfL7gSq8Dy2eQ1zxEzjOKHF9Bbh4XFewTjKwKDmWLDzJovu4G2yBfEKRRJSYlni1FtZoJmUHri86sFODZ9RnyfMJrvZny6KGYvsUS104gnbW7CEnHEAHaWl/KMNhwVNwrOjZH9G+uNIODHquTISaI3UXJ+0ev8aVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748606; c=relaxed/simple;
	bh=3rHo5cNyMQL5Uj5fPosd5stKXiXhdcMKRGLn9HNKQuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mquQCnAedEPbTCeaSEOWv3rvsJep9s4JaapsxVgkWeeYPaDdID6SThUcbP6Sz+du+EGmdIqtfnjg/21vwIv9QWNlyv3/kntc+sdJKxWaJQEyGdTFX/XKkuE0y3pxu+IT58uPFmhhHPkZ9JvER6v5xQ6//vGJfc/5jbyK2VqJWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBpcPQWq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778748605; x=1810284605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3rHo5cNyMQL5Uj5fPosd5stKXiXhdcMKRGLn9HNKQuk=;
  b=DBpcPQWq94l3MTHyjqqLGo4ffiLNMyhkU8lbThgkpoviDllQ/Ki0qpJw
   vQ8v/ly/elY8koZqRnlJ2ww0/UTd9lkzO0/8SlGQHp6us2XXgqgdDm+xA
   Ewn/I9gBOHp6Dn0OWDo0puG61lF6k4LzVd2+JdCXIJq30yWcWGg5Eqcqj
   niaXM9PEYvUKqe4ND7pY1AlxJrevLRutVgbiKO+Qdabq8Se/uQPSiEbHx
   4nadBHyYaesD7es02X6m6PMze4++UsAHGGvoVeY8ZbJP8NNwU+w0OONKu
   QNtC3ygAbuHmZ18IqxBRNq2Bq5i3MAWt74RWi2QMFyYH7Q9WxcGiYwFgM
   A==;
X-CSE-ConnectionGUID: kwrDkuwcRniVBfXRL25DsQ==
X-CSE-MsgGUID: dPDpWri5RHC5wnqaztlCMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102356861"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="102356861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:50:05 -0700
X-CSE-ConnectionGUID: 8HO3vyQtT96tisvOrxaPgw==
X-CSE-MsgGUID: JHQY9a0mQYCUq2qhEAjG9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="235273192"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 May 2026 01:50:02 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNRlX-000000006ER-2Y03;
	Thu, 14 May 2026 08:49:59 +0000
Date: Thu, 14 May 2026 16:49:23 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 "Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen"?= <toke@toke.dk>
Subject: [net-next:main 114/116] net/core/sock.c:2760:64: error:
 'tcp_wfree' undeclared; did you mean 'sock_wfree'?
Message-ID: <202605141607.mDXnYFKY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Queue-Id: 05A5B53F7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-287862-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   18dc8e6d15d7a30888beec46a1e01ca0f98508fa
commit: f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a [114/116] net: make is_skb_wmem() available to modules
config: parisc-randconfig-002-20260514 (https://download.01.org/0day-ci/archive/20260514/202605141607.mDXnYFKY-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141607.mDXnYFKY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141607.mDXnYFKY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/inet_sock.h:23,
                    from include/net/ip.h:29,
                    from include/linux/errqueue.h:6,
                    from net/core/sock.c:91:
   include/net/sock.h: In function 'is_skb_wmem':
   include/net/sock.h:1861:63: error: '__sock_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
    1861 |                (IS_ENABLED(CONFIG_INET) && skb->destructor == __sock_wfree) ||
         |                                                               ^~~~~~~~~~~~
         |                                                               sock_wfree
   include/net/sock.h:1861:63: note: each undeclared identifier is reported only once for each function it appears in
   include/net/sock.h:1862:63: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
    1862 |                (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
         |                                                               ^~~~~~~~~
         |                                                               sock_wfree
   net/core/sock.c: In function 'can_skb_orphan_partial':
>> net/core/sock.c:2760:64: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
    2760 |                 (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree));
         |                                                                ^~~~~~~~~
         |                                                                sock_wfree


vim +2760 net/core/sock.c

9e17f8a475fca81 Eric Dumazet   2015-11-01  2750  
414776621d1006e Jakub Kicinski 2019-08-07  2751  static bool can_skb_orphan_partial(const struct sk_buff *skb)
414776621d1006e Jakub Kicinski 2019-08-07  2752  {
414776621d1006e Jakub Kicinski 2019-08-07  2753  	/* Drivers depend on in-order delivery for crypto offload,
414776621d1006e Jakub Kicinski 2019-08-07  2754  	 * partial orphan breaks out-of-order-OK logic.
414776621d1006e Jakub Kicinski 2019-08-07  2755  	 */
9f06f87fef689d2 Jakub Kicinski 2024-04-03  2756  	if (skb_is_decrypted(skb))
414776621d1006e Jakub Kicinski 2019-08-07  2757  		return false;
9f06f87fef689d2 Jakub Kicinski 2024-04-03  2758  
414776621d1006e Jakub Kicinski 2019-08-07  2759  	return (skb->destructor == sock_wfree ||
414776621d1006e Jakub Kicinski 2019-08-07 @2760  		(IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree));
414776621d1006e Jakub Kicinski 2019-08-07  2761  }
414776621d1006e Jakub Kicinski 2019-08-07  2762  

:::::: The code at line 2760 was first introduced by commit
:::::: 414776621d1006e57e80e6db7fdc3837897aaa64 net/tls: prevent skb_orphan() from leaking TLS plain text with offload

:::::: TO: Jakub Kicinski <jakub.kicinski@netronome.com>
:::::: CC: David S. Miller <davem@davemloft.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

