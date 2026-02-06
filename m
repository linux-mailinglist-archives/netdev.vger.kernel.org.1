Return-Path: <netdev+bounces-257461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGM9DZNphWlqBQQAu9opvQ
	(envelope-from <netdev+bounces-257461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:09:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B82F9E7A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 470C2300E3E5
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 04:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706E3375CD;
	Fri,  6 Feb 2026 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLrxy8jp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AF2F5A05;
	Fri,  6 Feb 2026 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770350988; cv=none; b=UXjcKzGC8Vtpb5S7GxHbw9XUna22j0Qk0RkjXBsrtvyct6oTz6b10t8PEAYBk2u/t2wzKK3AWEljcLEHJAo8i9gs3y0VGfGlDNe75MYJfBNcPU3SdR/AK0t2ONbtE5yQGDvlUSsEL0eHbcIZYgOzggwNd0oECLouqiPPr1K7F3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770350988; c=relaxed/simple;
	bh=J8L/b8TMYhvTEWSBIUFeJXDhGvdbUplKd53H1uafSz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT1Z22aeae75Y1JbuUdGqqIyXDsYAwzu5Fb+q3vt9avS/PbfSKvZldBYAq5GiPKTxexX7YsuihPPMHW/ZhsXBlJHuBMnWkMhDoN8iVlbScE/eW/vQtXY3pYhTEjBIM0VUsFMdQIhZ/3Cqq2gNnPJRk9Ij1Oz2/P5BpQgpedNLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLrxy8jp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770350988; x=1801886988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8L/b8TMYhvTEWSBIUFeJXDhGvdbUplKd53H1uafSz8=;
  b=RLrxy8jp2olkKefOvS1HtRexoiuuMF/hOtjEQ+HNfCnybdO8c8GCCHU/
   hYOTifzUkdM1stHf/Oa6qpaecN5EE8NMXlWpzMFdVk9rvAmpNfnzUuAaE
   iTCN3HYUneuz5F0F6mcGqcRNoAUx5BnKyCAiDiZtyC7gyUWI7nWUa4DL3
   I2nnX1g/+lUhhexO/MeUfNRhBlPU7vxwwNmkSLZeHop0XIfKmjKG19sLL
   qGojlA0ifocpBxw2huosKLRwnXPq0zMT2+8EG5sOi3MqoTLutucHvOHUQ
   SuBtxQ0RDtCAJqTlPP1SuXlFu8nzus3h07CJtjO5xw5mZE8McLSHuQ5V1
   A==;
X-CSE-ConnectionGUID: NrFm1PPLSX+ItaLQygwqcA==
X-CSE-MsgGUID: XTOPLw/9SmKM3lXwmebk4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71285592"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71285592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 20:09:47 -0800
X-CSE-ConnectionGUID: +BBJ6HEaR8Sosr7FcUegLg==
X-CSE-MsgGUID: I8eIMSSQTCe51s3RbJRHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="210061179"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Feb 2026 20:09:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voDA4-00000000kQ4-2o8p;
	Fri, 06 Feb 2026 04:09:40 +0000
Date: Fri, 6 Feb 2026 12:09:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
	jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
	jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2 6/6] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
Message-ID: <202602061240.CRDtcOeX-lkp@intel.com>
References: <177032652354.1975497.2269771162710918590.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177032652354.1975497.2269771162710918590.stgit@firesoul>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-257461-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30B82F9E7A
X-Rspamd-Action: no action

Hi Jesper,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/net-sched-introduce-qdisc-specific-drop-reason-tracing/20260206-052816
base:   net-next/main
patch link:    https://lore.kernel.org/r/177032652354.1975497.2269771162710918590.stgit%40firesoul
patch subject: [PATCH net-next v2 6/6] net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops
config: sparc64-randconfig-002-20260206 (https://download.01.org/0day-ci/archive/20260206/202602061240.CRDtcOeX-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602061240.CRDtcOeX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602061240.CRDtcOeX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/sch_dualpi2.c:600:32: error: use of undeclared identifier 'QDISC_DROP_STEP_DROP'; did you mean 'QDISC_DROP_GENERIC'?
     600 |                         drop_and_retry(q, skb, sch, QDISC_DROP_STEP_DROP);
         |                                                     ^~~~~~~~~~~~~~~~~~~~
         |                                                     QDISC_DROP_GENERIC
   include/net/dropreason-qdisc.h:48:2: note: 'QDISC_DROP_GENERIC' declared here
      48 |         QDISC_DROP_GENERIC,
         |         ^
   1 error generated.


vim +600 net/sched/sch_dualpi2.c

   581	
   582	static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
   583	{
   584		struct dualpi2_sched_data *q = qdisc_priv(sch);
   585		struct sk_buff *skb;
   586		int credit_change;
   587		u64 now;
   588	
   589		now = ktime_get_ns();
   590	
   591		while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
   592			if (!q->drop_early && must_drop(sch, q, skb)) {
   593				drop_and_retry(q, skb, sch,
   594					       QDISC_DROP_CONGESTED);
   595				continue;
   596			}
   597	
   598			if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
   599				qdisc_qstats_drop(q->l_queue);
 > 600				drop_and_retry(q, skb, sch, QDISC_DROP_STEP_DROP);
   601				continue;
   602			}
   603	
   604			q->c_protection_credit += credit_change;
   605			qdisc_bstats_update(sch, skb);
   606			break;
   607		}
   608	
   609		if (q->deferred_drops_cnt) {
   610			qdisc_tree_reduce_backlog(sch, q->deferred_drops_cnt,
   611						  q->deferred_drops_len);
   612			q->deferred_drops_cnt = 0;
   613			q->deferred_drops_len = 0;
   614		}
   615		return skb;
   616	}
   617	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

