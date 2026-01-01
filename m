Return-Path: <netdev+bounces-246498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3FCED5B8
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF0C93005BAD
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1767223705;
	Thu,  1 Jan 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvd/kz4L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B1125A0
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767302766; cv=none; b=OTxsnplAVPxVMznlUbZenipRMa4vYpP9uKB/OuwNSYO/VfRR9VO/JUWVarB5rYY6XuHNNT+aaXWAyuEOEx7ed6xlewXXH53whc7klPBN2+6xa3BgHrgBVBS/vhpzmZtesz/ZjT9CbHSBMq/yeZBr+nP74VIE1xcvkoWcG4B8+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767302766; c=relaxed/simple;
	bh=uIsqF7GrK45tixVm3vpwn9SNL9fMP4yR243+FKmFqWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr7p4aGvvbrWUnuvDE1aKTo74/ph4g5HKAFbRS5KredO1fWEPNnpLcpqGL7yHU+R0XeDqy+QSJ7yZHnvmv+v9lCedcWo/BzdFy5EA9d219jvLVcT/3p3lZsk+4N2RkKdHEMkcopFWKn8JAbAZF2avrLrVz0eg4Kw9hyG5qdAv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvd/kz4L; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767302764; x=1798838764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uIsqF7GrK45tixVm3vpwn9SNL9fMP4yR243+FKmFqWU=;
  b=kvd/kz4LOhrjLdwAIvd19cWxfp9GSUUjlRiughwJ8ph6UPdhz3qGzHpF
   nFEQjVtvfcc6sY/BqPuqKJPpTgg6eiJGqDA+RIU+NFVWVjfDoiRUPhr15
   hF/X+JXtKhB/8phLN/ogFSkO4QXRBSEWdVjQZb7+I/fDlqVPzPlzK9mFi
   ch61nPPlP0Vjnr+6SWFV5aA98J79+6FZqq324QjxyGrNenPouBT0mTeNN
   uuW9kq0kyi8iOmJGewINt6Fsv4fpnQLA2a3g+/DYtLTtRORDVQQRoYOWs
   Ga0Lo46sFB9+sq+FZNvQCkvHsFAbv40mqyzUV8MFS8hwxC5Kan6icFHM0
   g==;
X-CSE-ConnectionGUID: OSIhZFTMSRGExErCnEK5xQ==
X-CSE-MsgGUID: ZS3+CDr5Qq+7/zFtURzkFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="80194441"
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="80194441"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2026 13:26:03 -0800
X-CSE-ConnectionGUID: HpXC2jVHQFqJPKt90/TRow==
X-CSE-MsgGUID: HFqIauY6T3Gt59Mi1T2bzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="239134592"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 01 Jan 2026 13:26:01 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbQBC-000000000Jd-2em9;
	Thu, 01 Jan 2026 21:25:58 +0000
Date: Thu, 1 Jan 2026 22:24:58 +0100
From: kernel test robot <lkp@intel.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redirecting
 to self on egress
Message-ID: <202601012235.hi5VYzYy-lkp@intel.com>
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
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260101/202601012235.hi5VYzYy-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260101/202601012235.hi5VYzYy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601012235.hi5VYzYy-lkp@intel.com/

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

