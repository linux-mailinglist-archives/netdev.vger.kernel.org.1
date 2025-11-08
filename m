Return-Path: <netdev+bounces-236922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F409C423BA
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 02:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45BDA4E070C
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2523EA88;
	Sat,  8 Nov 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEwT8CNP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1891A9FBD;
	Sat,  8 Nov 2025 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762564778; cv=none; b=HptWcZH+gu7H0y3vmXSJmJzoWG2DmaBgK4meN8m/QuD72geuGLUpz7qv0HH/s1GuRK481AZyjv9jrP3gWMqY0acJ5OIvxfVWMgYsgVXmbEZR7VEZT2CjsHH/kD01VAm0dx6bg+gqw5Qr0XrbOZcxfdM3pWo66tGdTuwmyEZIUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762564778; c=relaxed/simple;
	bh=6LwQWMQZIwOVuvJvbaUG+uSWupdTacys+le/kOEXWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJmp/Y7fysvC/UepOf1AX9loXjGen7tkMUt7ehnm2+BNvDupZM2regfIQ521Ogmn4tyldbYHXoJKNZJEpz6P1CT77f1WbRsC8ZfC/9QPZ41u5zs7fNU4H344bNYy2Tf5N9QdB7THgHd2glUYXLhRpRi1mMCFKNY+RofpdDLI0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEwT8CNP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762564776; x=1794100776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6LwQWMQZIwOVuvJvbaUG+uSWupdTacys+le/kOEXWKQ=;
  b=UEwT8CNP43YlXXlpaVxTUarhH77/MTH9I0ZOGTDHkyRSIrR8o2M1lNwv
   vkEQLS3DXrycR26rvdYNbN7/RGiL/gsfFq4UqbqMWIduFCd4zNzJdnACq
   gYgPXveYu9v7Wl5vpvtUSJusu+59HHd7W2kk5+ll52/PDolJa6EztfmIS
   WvI82TtEvLLYYhjkAPZFvbu8ZFlGMljiDJQcyaQ5kd+izs79/7WX9OLwC
   +noImj973PJFW/2azTkuD54y0B2gMvGXbUxwbJm2MTLp4aFs1OyLNgAPV
   M7PHwoo3s6rFNjK/g/7IHlTuaN2M7jnK4uw+VeFg9isvmYTQ0aRa464ok
   w==;
X-CSE-ConnectionGUID: W95oxQEIQEClBmsLLFVuAA==
X-CSE-MsgGUID: AjdlQJRcQsWH3SQv2jaa3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64753542"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="64753542"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:16:54 -0800
X-CSE-ConnectionGUID: qjG+nvmtSKmIHJh9Y3cBpQ==
X-CSE-MsgGUID: NoUEZRdtQD2Taho7s98w1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="218836106"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Nov 2025 17:16:51 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHXZQ-0000ZN-1a;
	Sat, 08 Nov 2025 01:16:48 +0000
Date: Sat, 8 Nov 2025 09:15:59 +0800
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
Message-ID: <202511080954.ZMCEd0sG-lkp@intel.com>
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
config: s390-randconfig-r073-20251108 (https://download.01.org/0day-ci/archive/20251108/202511080954.ZMCEd0sG-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d78e0ded5215824a63ac04fb87effd9eacf875eb)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251108/202511080954.ZMCEd0sG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511080954.ZMCEd0sG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/act_ife.c:652:2: error: call to undeclared library function 'index' with type 'char *(const char *, int)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     652 |         index = ife->tcf_index;
         |         ^
   net/sched/act_ife.c:652:2: note: include the header <strings.h> or explicitly provide a declaration for 'index'
>> net/sched/act_ife.c:652:8: error: non-object type 'char *(const char *, int)' is not assignable
     652 |         index = ife->tcf_index;
         |         ~~~~~ ^
>> net/sched/act_ife.c:653:2: error: use of undeclared identifier 'refcnt'
     653 |         refcnt = refcount_read(&ife->tcf_refcnt) - ref;
         |         ^~~~~~
>> net/sched/act_ife.c:654:2: error: use of undeclared identifier 'bindcnt'
     654 |         bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
         |         ^~~~~~~
   4 errors generated.


vim +652 net/sched/act_ife.c

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

