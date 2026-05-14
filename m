Return-Path: <netdev+bounces-288038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGRlBfj6BWrMdwIAu9opvQ
	(envelope-from <netdev+bounces-288038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6BE544D60
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CD8D3022B9A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A9344D8C;
	Thu, 14 May 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyqqgTZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694C34214A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776812; cv=none; b=GVwCGpLtqf2YeQqPgt6oHQ6H++qVBItRwq2gEhKCtKseDSnuiZjA81/B94ZwzyGFwCvMbuSEbM41vs8yu/PHze9LxnzORnD1Cst/fO7lTSSYAGaxBPM1fI+0nA3NHGiiQ851jkloXI4vglLM6st65Nju0IcifsN79A+oh1H/BOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776812; c=relaxed/simple;
	bh=rJdgJ1OFCQpo/ushgHRlnzGxSRqr/Cop7cNY+Q930EE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tUqrIIPaMarjToQ0UAqEBFoZShkqUkJm46YGc0W4wkJ4j8QQjl/iVuazEyPpplnegmwezv02n5bMYPcS9rJzqqqsu/bp/yKRru1tlfkNczWja/iGCAUf+jUs8v8y/6tyL3d1YwOdfw4K2jWrZ+e92/UkbOXi/vpdfDDmnOk5ugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyqqgTZ5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778776811; x=1810312811;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rJdgJ1OFCQpo/ushgHRlnzGxSRqr/Cop7cNY+Q930EE=;
  b=TyqqgTZ5wiAsq88SLcSyMS5ab5DEUhAT0bRE1AXyDL/0/g5E/Xm2WOoI
   Ov9sjPkO+ZdHpYr9d4fOSgF6QQuV1Z5Kw9phtTFoll3QwTL4RKbOI/4g2
   kSDoepKGCE/OFdwsS+1KIofCdquf7c1RXS/8bg6HeK4O6GKr6YKvmYaD7
   KXoIQXKKGNlOtO2I7hG/YUMG1kbgqYy3idgLbQzJQlO9iypLigwerekPE
   yix0zEtzQAavTiSGDyDJsdSGEuIGWrEKcqwvaVU1khWO82UUTvWquI8Pa
   k3YBMIDykAFR6YRUe9hInu8owYIBTIjE6T1weVOaxRM5k1IYRV2fkwYuZ
   Q==;
X-CSE-ConnectionGUID: mu1IK2T/SqyKcYKovRLqDQ==
X-CSE-MsgGUID: TmOn1ooYSKmX/HL4NuZ5uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90417427"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="90417427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 09:40:08 -0700
X-CSE-ConnectionGUID: LRVKXak2SA6cvK/7udCKpA==
X-CSE-MsgGUID: 19PQgLzZQ8SMWEfvUwvFdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="238534961"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 May 2026 09:40:05 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNZ6Q-000000006mt-3yn8;
	Thu, 14 May 2026 16:40:02 +0000
Date: Fri, 15 May 2026 00:39:49 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 "Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen"?= <toke@toke.dk>
Subject: [net-next:main 114/116] net/core/sock.c:2761:1: warning:
 control reaches end of non-void function
Message-ID: <202605150027.0UCMop1l-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Queue-Id: CE6BE544D60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288038-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,davemloft.net:email]
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   f3f7760afe65292e83f182696130efb983278d04
commit: f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a [114/116] net: make is_skb_wmem() available to modules
config: powerpc64-randconfig-002-20260514 (https://download.01.org/0day-ci/archive/20260515/202605150027.0UCMop1l-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150027.0UCMop1l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150027.0UCMop1l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/inet_sock.h:23,
                    from include/net/ip.h:29,
                    from include/linux/errqueue.h:6,
                    from net/core/sock.c:91:
   include/net/sock.h: In function 'is_skb_wmem':
   include/net/sock.h:1861:56: error: '__sock_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
            (IS_ENABLED(CONFIG_INET) && skb->destructor == __sock_wfree) ||
                                                           ^~~~~~~~~~~~
                                                           sock_wfree
   include/net/sock.h:1861:56: note: each undeclared identifier is reported only once for each function it appears in
   include/net/sock.h:1862:56: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
            (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
                                                           ^~~~~~~~~
                                                           sock_wfree
   net/core/sock.c: In function 'can_skb_orphan_partial':
   net/core/sock.c:2760:50: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
      (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree));
                                                     ^~~~~~~~~
                                                     sock_wfree
>> net/core/sock.c:2761:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
--
   In file included from include/linux/tcp.h:19,
                    from net/core/skbuff.c:45:
   include/net/sock.h: In function 'is_skb_wmem':
   include/net/sock.h:1861:56: error: '__sock_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
            (IS_ENABLED(CONFIG_INET) && skb->destructor == __sock_wfree) ||
                                                           ^~~~~~~~~~~~
                                                           sock_wfree
   include/net/sock.h:1861:56: note: each undeclared identifier is reported only once for each function it appears in
   include/net/sock.h:1862:56: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
            (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
                                                           ^~~~~~~~~
                                                           sock_wfree
>> include/net/sock.h:1863:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^


vim +2761 net/core/sock.c

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
414776621d1006e Jakub Kicinski 2019-08-07 @2761  }
414776621d1006e Jakub Kicinski 2019-08-07  2762  

:::::: The code at line 2761 was first introduced by commit
:::::: 414776621d1006e57e80e6db7fdc3837897aaa64 net/tls: prevent skb_orphan() from leaking TLS plain text with offload

:::::: TO: Jakub Kicinski <jakub.kicinski@netronome.com>
:::::: CC: David S. Miller <davem@davemloft.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

