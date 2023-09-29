Return-Path: <netdev+bounces-36972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88BE7B2C1D
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 699CB281FD8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2E8BFC;
	Fri, 29 Sep 2023 05:57:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A978BE2
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 05:57:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7DB199
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 22:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695967044; x=1727503044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbYZU107SZDbwYM7mZDJ+TNGKOOBd48lBvz6MLLS1r8=;
  b=PJoIlC+Zi6dTx3/lO/Y2ObBWoW0//oI3DacROi201L9VsBAs9CZ56Te/
   DzupqCc/+11xcjhu3ZYARWuMZ1ua3/wFbvuxZHKsUSNVvLhTJXmLkqBMz
   I1ar6VuFWIrwnUEQFsZO947xuaD7uLf5Gfi9mMJ+Tz3I3xNfXXNxZkglP
   fAzLEUJCVzboClPmyXsj2DhRdsf+IDblCb07rFcYwhgVp0c8GKWVGzCOi
   lAlB7RLBVt19bJ+6vU1YXTR7X77zSeHkV7rZpsGInO1cVxxcuHXAklW+I
   hu5GOf2sJzSKv5J4LTATWq0PD6AQfFuJMKk3L49rqPz6A+HENJpSaeTao
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="844801"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="844801"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 22:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840178590"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="840178590"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2023 22:57:20 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qm6V4-0002X7-1C;
	Fri, 29 Sep 2023 05:57:18 +0000
Date: Fri, 29 Sep 2023 13:57:07 +0800
From: kernel test robot <lkp@intel.com>
To: David Morley <morleyd.kernel@gmail.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: Re: [PATCH net-next 1/2] tcp: record last received ipv6 flowlabel
Message-ID: <202309291312.vJyV8G9L-lkp@intel.com>
References: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Morley/tcp-change-data-receiver-flowlabel-after-one-dup/20230928-022955
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230927182747.2005960-1-morleyd.kernel%40gmail.com
patch subject: [PATCH net-next 1/2] tcp: record last received ipv6 flowlabel
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230929/202309291312.vJyV8G9L-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309291312.vJyV8G9L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291312.vJyV8G9L-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/dccp/timer.c:199:25: warning: comparison of distinct pointer types ('typeof (icsk->icsk_ack.ato << 1) *' (aka 'int *') and 'typeof (icsk->icsk_rto) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                           icsk->icsk_ack.ato = min(icsk->icsk_ack.ato << 1,
                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:68:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:37:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:27:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:21:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +199 net/dccp/timer.c

4ed800d02cfb63 Gerrit Renker 2006-11-13  168  
4ed800d02cfb63 Gerrit Renker 2006-11-13  169  /* This is the same as tcp_delack_timer, sans prequeue & mem_reclaim stuff */
59f379f9046a9e Kees Cook     2017-10-16  170  static void dccp_delack_timer(struct timer_list *t)
4ed800d02cfb63 Gerrit Renker 2006-11-13  171  {
59f379f9046a9e Kees Cook     2017-10-16  172  	struct inet_connection_sock *icsk =
59f379f9046a9e Kees Cook     2017-10-16  173  			from_timer(icsk, t, icsk_delack_timer);
59f379f9046a9e Kees Cook     2017-10-16  174  	struct sock *sk = &icsk->icsk_inet.sk;
4ed800d02cfb63 Gerrit Renker 2006-11-13  175  
4ed800d02cfb63 Gerrit Renker 2006-11-13  176  	bh_lock_sock(sk);
4ed800d02cfb63 Gerrit Renker 2006-11-13  177  	if (sock_owned_by_user(sk)) {
4ed800d02cfb63 Gerrit Renker 2006-11-13  178  		/* Try again later. */
02a1d6e7a6bb02 Eric Dumazet  2016-04-27  179  		__NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKLOCKED);
4ed800d02cfb63 Gerrit Renker 2006-11-13  180  		sk_reset_timer(sk, &icsk->icsk_delack_timer,
4ed800d02cfb63 Gerrit Renker 2006-11-13  181  			       jiffies + TCP_DELACK_MIN);
4ed800d02cfb63 Gerrit Renker 2006-11-13  182  		goto out;
4ed800d02cfb63 Gerrit Renker 2006-11-13  183  	}
4ed800d02cfb63 Gerrit Renker 2006-11-13  184  
4ed800d02cfb63 Gerrit Renker 2006-11-13  185  	if (sk->sk_state == DCCP_CLOSED ||
4ed800d02cfb63 Gerrit Renker 2006-11-13  186  	    !(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
4ed800d02cfb63 Gerrit Renker 2006-11-13  187  		goto out;
4ed800d02cfb63 Gerrit Renker 2006-11-13  188  	if (time_after(icsk->icsk_ack.timeout, jiffies)) {
4ed800d02cfb63 Gerrit Renker 2006-11-13  189  		sk_reset_timer(sk, &icsk->icsk_delack_timer,
4ed800d02cfb63 Gerrit Renker 2006-11-13  190  			       icsk->icsk_ack.timeout);
4ed800d02cfb63 Gerrit Renker 2006-11-13  191  		goto out;
4ed800d02cfb63 Gerrit Renker 2006-11-13  192  	}
4ed800d02cfb63 Gerrit Renker 2006-11-13  193  
4ed800d02cfb63 Gerrit Renker 2006-11-13  194  	icsk->icsk_ack.pending &= ~ICSK_ACK_TIMER;
4ed800d02cfb63 Gerrit Renker 2006-11-13  195  
4ed800d02cfb63 Gerrit Renker 2006-11-13  196  	if (inet_csk_ack_scheduled(sk)) {
31954cd8bb6670 Wei Wang      2019-01-25  197  		if (!inet_csk_in_pingpong_mode(sk)) {
4ed800d02cfb63 Gerrit Renker 2006-11-13  198  			/* Delayed ACK missed: inflate ATO. */
4ed800d02cfb63 Gerrit Renker 2006-11-13 @199  			icsk->icsk_ack.ato = min(icsk->icsk_ack.ato << 1,
4ed800d02cfb63 Gerrit Renker 2006-11-13  200  						 icsk->icsk_rto);
4ed800d02cfb63 Gerrit Renker 2006-11-13  201  		} else {
4ed800d02cfb63 Gerrit Renker 2006-11-13  202  			/* Delayed ACK missed: leave pingpong mode and
4ed800d02cfb63 Gerrit Renker 2006-11-13  203  			 * deflate ATO.
4ed800d02cfb63 Gerrit Renker 2006-11-13  204  			 */
31954cd8bb6670 Wei Wang      2019-01-25  205  			inet_csk_exit_pingpong_mode(sk);
4ed800d02cfb63 Gerrit Renker 2006-11-13  206  			icsk->icsk_ack.ato = TCP_ATO_MIN;
4ed800d02cfb63 Gerrit Renker 2006-11-13  207  		}
4ed800d02cfb63 Gerrit Renker 2006-11-13  208  		dccp_send_ack(sk);
02a1d6e7a6bb02 Eric Dumazet  2016-04-27  209  		__NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKS);
4ed800d02cfb63 Gerrit Renker 2006-11-13  210  	}
4ed800d02cfb63 Gerrit Renker 2006-11-13  211  out:
4ed800d02cfb63 Gerrit Renker 2006-11-13  212  	bh_unlock_sock(sk);
4ed800d02cfb63 Gerrit Renker 2006-11-13  213  	sock_put(sk);
4ed800d02cfb63 Gerrit Renker 2006-11-13  214  }
4ed800d02cfb63 Gerrit Renker 2006-11-13  215  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

