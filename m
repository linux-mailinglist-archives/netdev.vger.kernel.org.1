Return-Path: <netdev+bounces-246731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D71DACF0B3B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 08:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDE0302E72F
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819B2EAB72;
	Sun,  4 Jan 2026 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOXi/RyL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729D2E3387
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767510608; cv=none; b=FEXQjaPQp9vLwUV+URh9I9R4R+3t4gRyZXS1p51IxBN/0VvM995sHRvy4t/UYbRIPr0uKaejEO4mNUHJLnPPxe5yMt2VwwL5z1R2Xuq8hPFdvzcszBe6nHfKCGKcZ/GODWEfj4Ok+x9oqGKN4E144J1bW10gZmOM8FdIfMT4pY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767510608; c=relaxed/simple;
	bh=igyM/8qIW3+Hq3eZX0VZjcZW40iUc/SMwNFaDv5FwdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4x+wCyMAB2auymIRqKEJBGJYGmDJVgVbXoqCd5cYr0jqpByMggiKYaKFY1D8Ajl78ua9XSJD1c1BrfAUpBPdgOA9L7ABPDHEKpXdJs2sCQZPS6YixlJuEQkFmeiDKkAvwVmc0nkEjEm3A/VVdDek/MZhM4caBZhZ829ID6LOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOXi/RyL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767510607; x=1799046607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igyM/8qIW3+Hq3eZX0VZjcZW40iUc/SMwNFaDv5FwdM=;
  b=OOXi/RyLbVvTOy4wLUxUxZtV31vADEdDH9oBjAHWyxllvrS4rDQgPLxH
   6ioL5AYeDtWHucfq7e3nH6gziseZuyr1G/wkg7+aaKZx0cYUN4DtVRAIK
   QhdcAcuSOPBU1vL88czG3+PhCy8kCnLynnqw2dcjPVp5P31CDk4s+Hb/C
   dDGbCjoYsIYr9MZ6ZWTceLjHr/AkOZWmB4ZE3bbzCk9rtPLTlgSBnsCpx
   s+ZSjiDdGKKTzcBws2ZFBqguUGPOkqaPm4tLctoRIgw3gBOlLj2bPp2UV
   GADZXq/dgSKPSCKMgEf5zj9+D355HyfTkj79LJlu7FW2jPnB/r5AQIru9
   g==;
X-CSE-ConnectionGUID: XiK99WvKRXqfUgXLps2jdA==
X-CSE-MsgGUID: EMH2A1XuQn+KCbXKqYdNEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68853834"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68853834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 23:10:07 -0800
X-CSE-ConnectionGUID: i3pqvFJTQzCM3MdVGH7Vkw==
X-CSE-MsgGUID: lnJpXq3hQIu53ez2vE1xYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="206649339"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Jan 2026 23:10:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vcIFU-000000000Q9-1G01;
	Sun, 04 Jan 2026 07:10:00 +0000
Date: Sun, 4 Jan 2026 15:09:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	victor@mojatatu.com, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redirecting
 to self on egress
Message-ID: <202601041445.FfX5dT9n-lkp@intel.com>
References: <20251230191814.213789-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230191814.213789-1-jhs@mojatatu.com>

Hi Jamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jamal-Hadi-Salim/selftests-tc-testing-Add-test-case-redirecting-to-self-on-egress/20251231-031934
base:   net/main
patch link:    https://lore.kernel.org/r/20251230191814.213789-1-jhs%40mojatatu.com
patch subject: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redirecting to self on egress
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260104/202601041445.FfX5dT9n-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260104/202601041445.FfX5dT9n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601041445.FfX5dT9n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/sched/act_mirred.c:271:41: warning: variable 'at_ingress' is uninitialized when used here [-Wuninitialized]
     271 |         if (dev == skb->dev && want_ingress == at_ingress) {
         |                                                ^~~~~~~~~~
   net/sched/act_mirred.c:256:17: note: initialize the variable 'at_ingress' to silence this warning
     256 |         bool at_ingress;
         |                        ^
         |                         = 0
   1 warning generated.


vim +/at_ingress +271 net/sched/act_mirred.c

   246	
   247	static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
   248				     struct net_device *dev,
   249				     const bool m_mac_header_xmit, int m_eaction,
   250				     int retval)
   251	{
   252		struct sk_buff *skb_to_send = skb;
   253		bool want_ingress;
   254		bool is_redirect;
   255		bool expects_nh;
   256		bool at_ingress;
   257		bool dont_clone;
   258		int mac_len;
   259		bool at_nh;
   260		int err;
   261	
   262		is_redirect = tcf_mirred_is_act_redirect(m_eaction);
   263		if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
   264			net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
   265					       dev->name);
   266			goto err_cant_do;
   267		}
   268	
   269		want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
   270	
 > 271		if (dev == skb->dev && want_ingress == at_ingress) {
   272			pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
   273				       netdev_name(skb->dev),
   274				       at_ingress ? "ingress" : "egress",
   275				       netdev_name(dev),
   276				       want_ingress ? "ingress" : "egress");
   277			goto err_cant_do;
   278		}
   279	
   280		/* we could easily avoid the clone only if called by ingress and clsact;
   281		 * since we can't easily detect the clsact caller, skip clone only for
   282		 * ingress - that covers the TC S/W datapath.
   283		 */
   284		at_ingress = skb_at_tc_ingress(skb);
   285		dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
   286			tcf_mirred_can_reinsert(retval);
   287		if (!dont_clone) {
   288			skb_to_send = skb_clone(skb, GFP_ATOMIC);
   289			if (!skb_to_send)
   290				goto err_cant_do;
   291		}
   292	
   293		/* All mirred/redirected skbs should clear previous ct info */
   294		nf_reset_ct(skb_to_send);
   295		if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
   296			skb_dst_drop(skb_to_send);
   297	
   298		expects_nh = want_ingress || !m_mac_header_xmit;
   299		at_nh = skb->data == skb_network_header(skb);
   300		if (at_nh != expects_nh) {
   301			mac_len = at_ingress ? skb->mac_len :
   302				  skb_network_offset(skb);
   303			if (expects_nh) {
   304				/* target device/action expect data at nh */
   305				skb_pull_rcsum(skb_to_send, mac_len);
   306			} else {
   307				/* target device/action expect data at mac */
   308				skb_push_rcsum(skb_to_send, mac_len);
   309			}
   310		}
   311	
   312		skb_to_send->skb_iif = skb->dev->ifindex;
   313		skb_to_send->dev = dev;
   314	
   315		if (is_redirect) {
   316			if (skb == skb_to_send)
   317				retval = TC_ACT_CONSUMED;
   318	
   319			skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
   320	
   321			err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
   322		} else {
   323			err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
   324		}
   325		if (err)
   326			tcf_action_inc_overlimit_qstats(&m->common);
   327	
   328		return retval;
   329	
   330	err_cant_do:
   331		if (is_redirect)
   332			retval = TC_ACT_SHOT;
   333		tcf_action_inc_overlimit_qstats(&m->common);
   334		return retval;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

