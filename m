Return-Path: <netdev+bounces-236924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DAC423C9
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 02:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B48F3B35E2
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A7291C1F;
	Sat,  8 Nov 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyWSjfEg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF12877CD;
	Sat,  8 Nov 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762565277; cv=none; b=K0LzUjEeDpmM2lSbELCYt+Rv8J9b1FIG73EYowXbE/ZpT/iohdJGJC3rPZ1lV9gPo87oamPeB9JZTRsApIbRD10A+LMjF0zCrR2Gu8kTp6Btt9o1Fau2ULniAVktvdBefHbwWJnHiN3xXz5PkPdMb0P3uo+HgcXUeb1z6+bnlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762565277; c=relaxed/simple;
	bh=zi+gWCq7LPw7fACbKThyVaX0lK2sJtmDbDaQh/MqCgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBcPFlT0vDLeOt66DTSPd5D+RCqs7vhwm3UT+8j5lik7O6I+biQ0slEZtVbTnaaz2Ks4K0qdFugVt88IKmVZ+UZqlI1b44R3MDLxYPWXzsmJNY91ha5NjaDpak2su6wrMa6ykswfHchoMZ3KM9yM+Shg3bLh8ToqaPb8EI+a4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyWSjfEg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762565276; x=1794101276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zi+gWCq7LPw7fACbKThyVaX0lK2sJtmDbDaQh/MqCgI=;
  b=cyWSjfEguqBOYGHsVdtQoHH9qiMNwk2E1qkyaT3Cx5gGDy7LSz4t0wqk
   ymyseW73iYsbOWrL/g6xXA+UrMacyiLr4BPc4I+XlZG8YRtO29d7LsNrc
   MZDTs/6+QmjTf/jfyum5Xxj0EymaE0q/K6F4a9U0qRUjX5gltNcz2zwjz
   U0A5HwbYxklv86IMytmovzb8FIt8BTKAGFiTSgd1Hb0enw1Kki+pPszLS
   CAPRk0qaCrI7NsdFHYSrRdFzMiUarligA8RXlhBaKncetmH50Z7GEgFEi
   0eBLI21QtrmzD4k6p6MsfoNl/bIj3cXs7Qt8bLA/IODCCBiLNy7193G+0
   w==;
X-CSE-ConnectionGUID: tnwn0BPSSq+xk1IX3PE3uQ==
X-CSE-MsgGUID: /0Vde9/nTU2USmHOrWD73g==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="87348469"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="87348469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:27:55 -0800
X-CSE-ConnectionGUID: g6UuUPTHRG6E/PTGaKesyQ==
X-CSE-MsgGUID: eJDos0MuR3Se7vqFdF02OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="188442130"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Nov 2025 17:27:51 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHXk5-0000a1-11;
	Sat, 08 Nov 2025 01:27:49 +0000
Date: Sat, 8 Nov 2025 09:26:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ranganath V N <vnranganath.20@gmail.com>, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, jhs@mojatatu.com,
	jiri@resnulli.us, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, vnranganath.20@gmail.com,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 2/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Message-ID: <202511080909.0OWvBSbY-lkp@intel.com>
References: <20251106195635.2438-3-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106195635.2438-3-vnranganath.20@gmail.com>

Hi Ranganath,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.18-rc4 next-20251107]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ranganath-V-N/net-sched-act_connmark-initialize-struct-tc_ife-to-fix-kernel-leak/20251107-035911
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251106195635.2438-3-vnranganath.20%40gmail.com
patch subject: [PATCH v3 2/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
config: i386-buildonly-randconfig-003-20251108 (https://download.01.org/0day-ci/archive/20251108/202511080909.0OWvBSbY-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251108/202511080909.0OWvBSbY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511080909.0OWvBSbY-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/sched/act_ife.c: In function 'tcf_ife_dump':
>> net/sched/act_ife.c:652:9: error: 'index' undeclared (first use in this function)
     652 |         index = ife->tcf_index;
         |         ^~~~~
   net/sched/act_ife.c:652:9: note: each undeclared identifier is reported only once for each function it appears in
>> net/sched/act_ife.c:653:9: error: 'refcnt' undeclared (first use in this function)
     653 |         refcnt = refcount_read(&ife->tcf_refcnt) - ref;
         |         ^~~~~~
>> net/sched/act_ife.c:654:9: error: 'bindcnt' undeclared (first use in this function); did you mean 'bind'?
     654 |         bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
         |         ^~~~~~~
         |         bind


vim +/index +652 net/sched/act_ife.c

   640	
   641	static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
   642				int ref)
   643	{
   644		unsigned char *b = skb_tail_pointer(skb);
   645		struct tcf_ife_info *ife = to_ife(a);
   646		struct tcf_ife_params *p;
   647		struct tc_ife opt;
   648		struct tcf_t t;
   649	
   650		memset(&opt, 0, sizeof(opt));
   651	
 > 652		index = ife->tcf_index;
 > 653		refcnt = refcount_read(&ife->tcf_refcnt) - ref;
 > 654		bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
   655	
   656		spin_lock_bh(&ife->tcf_lock);
   657		opt.action = ife->tcf_action;
   658		p = rcu_dereference_protected(ife->params,
   659					      lockdep_is_held(&ife->tcf_lock));
   660		opt.flags = p->flags;
   661	
   662		if (nla_put(skb, TCA_IFE_PARMS, sizeof(opt), &opt))
   663			goto nla_put_failure;
   664	
   665		tcf_tm_dump(&t, &ife->tcf_tm);
   666		if (nla_put_64bit(skb, TCA_IFE_TM, sizeof(t), &t, TCA_IFE_PAD))
   667			goto nla_put_failure;
   668	
   669		if (!is_zero_ether_addr(p->eth_dst)) {
   670			if (nla_put(skb, TCA_IFE_DMAC, ETH_ALEN, p->eth_dst))
   671				goto nla_put_failure;
   672		}
   673	
   674		if (!is_zero_ether_addr(p->eth_src)) {
   675			if (nla_put(skb, TCA_IFE_SMAC, ETH_ALEN, p->eth_src))
   676				goto nla_put_failure;
   677		}
   678	
   679		if (nla_put(skb, TCA_IFE_TYPE, 2, &p->eth_type))
   680			goto nla_put_failure;
   681	
   682		if (dump_metalist(skb, ife)) {
   683			/*ignore failure to dump metalist */
   684			pr_info("Failed to dump metalist\n");
   685		}
   686	
   687		spin_unlock_bh(&ife->tcf_lock);
   688		return skb->len;
   689	
   690	nla_put_failure:
   691		spin_unlock_bh(&ife->tcf_lock);
   692		nlmsg_trim(skb, b);
   693		return -1;
   694	}
   695	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

