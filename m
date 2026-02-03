Return-Path: <netdev+bounces-256144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFv8DNGMgWl/HAMAu9opvQ
	(envelope-from <netdev+bounces-256144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:51:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C446D4CF6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE8E303FFDE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8CD2777FC;
	Tue,  3 Feb 2026 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cV5Pa8eQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6C226CEB
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097856; cv=none; b=HZgQ/OWwm9owbJRt8CF/eQOYkikNl/4I9eNwsJJ3/35Djrd6mOOs9WqAOHkHLZ/mUykbdCsCdY+IhFh1twxSTuD/Hwqgf+hxLpALAvvRz7Z+iUdgZeNqATMkjCGauM377uDI8TstPMvadvP73TKlbom2Al+YkY9/QBVGok0Us08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097856; c=relaxed/simple;
	bh=Zp/I4tq7PmVu8AEefnGEYnwMC+UxpEbspw5PwEbwvBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSwbY0CCSmX5n/IP34E9iiDZdh+AbHd+i/u51eS9L2/gR1Nya4Gb9qzMqOuqFzwqrNkPhGX2eHntf3sxj7wcOIGzetxmMbzWdAAaPZMLoMMlUiTrCW2rQtGkqqILBq1OpifjhfNaWKl/tt7y97L6LA6gVPfmAO54f5RB/n5NrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cV5Pa8eQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770097853; x=1801633853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zp/I4tq7PmVu8AEefnGEYnwMC+UxpEbspw5PwEbwvBQ=;
  b=cV5Pa8eQzvrXf3Za20rOaumRJ8w/u29yVpwue1iq3B1sBuoaU+Ej5PfV
   mrQf0o6EgaobVufh/WF2XqomnblAWu1CBIYlJB/hge7jjZgJsjGGRu2En
   HpbyMzqJdy6ZUXMUUTTE0qI5vfkPdFsHLR8M77GUUwgK5mLc8LFG3TGU9
   f7lNhVvOyZnXM64iPdc43Tye/rg2fA8cMH4cqplkxheaxvcyolU+2ZwRk
   uRtjsiGrdKD/yYJoesEeDxgFt/nL0nkhHa1/XsHeL7MvoCatG3wDmqfvK
   QH8g9fExrVG0SOT2hdVuRfWm9fEcp6DnwOolYnEqalrctlRF3BMUuDfzG
   Q==;
X-CSE-ConnectionGUID: eb7JmpFESf+YfHiWMgzqlw==
X-CSE-MsgGUID: 9OTE4XehQIWqGT965TUmMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71169009"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71169009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 21:50:51 -0800
X-CSE-ConnectionGUID: fsiNm8pNQf+nPhe0uZZHfg==
X-CSE-MsgGUID: ULtznsatRl+eC8T2cDHcig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="208840768"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Feb 2026 21:50:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn9JG-00000000gIm-0Kpt;
	Tue, 03 Feb 2026 05:50:46 +0000
Date: Tue, 3 Feb 2026 13:50:05 +0800
From: kernel test robot <lkp@intel.com>
To: Murari Prasad Samal <murariprasadsamal57@gmail.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Murari Prasad Samal <murariprasadsamal57@gmail.com>
Subject: Re: [PATCH] net: ifb: record drop reason when redirect device is
 missing
Message-ID: <202602031317.D3Pw6418-lkp@intel.com>
References: <20260202191135.7668-1-murariprasadsamal57@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202191135.7668-1-murariprasadsamal57@gmail.com>
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256144-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: 2C446D4CF6
X-Rspamd-Action: no action

Hi Murari,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master horms-ipvs/master v6.19-rc8 next-20260202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Murari-Prasad-Samal/net-ifb-record-drop-reason-when-redirect-device-is-missing/20260203-031526
base:   net/main
patch link:    https://lore.kernel.org/r/20260202191135.7668-1-murariprasadsamal57%40gmail.com
patch subject: [PATCH] net: ifb: record drop reason when redirect device is missing
config: i386-randconfig-012-20260203 (https://download.01.org/0day-ci/archive/20260203/202602031317.D3Pw6418-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602031317.D3Pw6418-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602031317.D3Pw6418-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ifb.c:118:26: error: use of undeclared identifier 'SKB_DROP_REASON_NO_DEV'; did you mean 'SKB_DROP_REASON_NOMEM'?
     118 |                         kfree_skb_reason(skb, SKB_DROP_REASON_NO_DEV);
         |                                               ^~~~~~~~~~~~~~~~~~~~~~
         |                                               SKB_DROP_REASON_NOMEM
   include/net/dropreason-core.h:446:2: note: 'SKB_DROP_REASON_NOMEM' declared here
     446 |         SKB_DROP_REASON_NOMEM,
         |         ^
   1 error generated.


vim +118 drivers/net/ifb.c

    88	
    89	static void ifb_ri_tasklet(struct tasklet_struct *t)
    90	{
    91		struct ifb_q_private *txp = from_tasklet(txp, t, ifb_tasklet);
    92		struct netdev_queue *txq;
    93		struct sk_buff *skb;
    94	
    95		txq = netdev_get_tx_queue(txp->dev, txp->txqnum);
    96		skb = skb_peek(&txp->tq);
    97		if (!skb) {
    98			if (!__netif_tx_trylock(txq))
    99				goto resched;
   100			skb_queue_splice_tail_init(&txp->rq, &txp->tq);
   101			__netif_tx_unlock(txq);
   102		}
   103	
   104		while ((skb = __skb_dequeue(&txp->tq)) != NULL) {
   105			/* Skip tc and netfilter to prevent redirection loop. */
   106			skb->redirected = 0;
   107	#ifdef CONFIG_NET_CLS_ACT
   108			skb->tc_skip_classify = 1;
   109	#endif
   110			nf_skip_egress(skb, true);
   111	
   112			ifb_update_q_stats(&txp->tx_stats, skb->len);
   113	
   114			rcu_read_lock();
   115			skb->dev = dev_get_by_index_rcu(dev_net(txp->dev), skb->skb_iif);
   116			if (!skb->dev) {
   117				rcu_read_unlock();
 > 118				kfree_skb_reason(skb, SKB_DROP_REASON_NO_DEV);
   119				txp->dev->stats.tx_dropped++;
   120				if (skb_queue_len(&txp->tq) != 0)
   121					goto resched;
   122				break;
   123			}
   124			rcu_read_unlock();
   125			skb->skb_iif = txp->dev->ifindex;
   126	
   127			if (!skb->from_ingress) {
   128				dev_queue_xmit(skb);
   129			} else {
   130				skb_pull_rcsum(skb, skb->mac_len);
   131				netif_receive_skb(skb);
   132			}
   133		}
   134	
   135		if (__netif_tx_trylock(txq)) {
   136			skb = skb_peek(&txp->rq);
   137			if (!skb) {
   138				txp->tasklet_pending = 0;
   139				if (netif_tx_queue_stopped(txq))
   140					netif_tx_wake_queue(txq);
   141			} else {
   142				__netif_tx_unlock(txq);
   143				goto resched;
   144			}
   145			__netif_tx_unlock(txq);
   146		} else {
   147	resched:
   148			txp->tasklet_pending = 1;
   149			tasklet_schedule(&txp->ifb_tasklet);
   150		}
   151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

