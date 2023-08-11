Return-Path: <netdev+bounces-26817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3B77917A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DEA282346
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE7F29DFD;
	Fri, 11 Aug 2023 14:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313363B1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:11:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A5D7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691763066; x=1723299066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4JUY3giJXfjrwBofmYpvNTTsoVy5N5DNKsbuqWvnqYM=;
  b=RF5dFx1BBLqBZg/bMF7zEN/ZWNQBIT0haRK+MXUyqadZVI4u/ok9GREn
   a/hy7WYbizSgsDQlMSjZW2gIIC+AWp59YuETFOJ/fpW1amwT10g95IqCI
   8LwEeTFl8Qv/zkJ9Qv1ITTT0yshFvHD4w/zeBuIPTo3Xm1R6jBdLE7uZF
   voonifgn3YIyJ6eq86ehropvts+VuoqJEsadXXH0QPd0cB5EWOsSZ5W1V
   Ca1sIj8yGJf+wLpwwlV8sN+0mMsD8MWM2tYEfr6pRB1dLwNFie4GscuMB
   xYFt0GU02acy69DuAibrSFfxe2GXOoewFuicyMQhRk/Kn+VikgNh9k+TF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="369154126"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369154126"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="726274322"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="726274322"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2023 07:10:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qUSqg-0007pI-2j;
	Fri, 11 Aug 2023 14:10:42 +0000
Date: Fri, 11 Aug 2023 22:10:05 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <simon.horman@corigine.com>,
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 07/15] inet: move inet->mc_loop to
 inet->inet_frags
Message-ID: <202308112211.xpcXWwEP-lkp@intel.com>
References: <20230811073621.2874702-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811073621.2874702-8-edumazet@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inet-introduce-inet-inet_flags/20230811-154157
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230811073621.2874702-8-edumazet%40google.com
patch subject: [PATCH v2 net-next 07/15] inet: move inet->mc_loop to inet->inet_frags
config: nios2-randconfig-r001-20230811 (https://download.01.org/0day-ci/archive/20230811/202308112211.xpcXWwEP-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112211.xpcXWwEP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308112211.xpcXWwEP-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/netfilter/ipvs/ip_vs_sync.c: In function 'set_mcast_loop':
>> net/netfilter/ipvs/ip_vs_sync.c:1304:13: error: 'struct inet_sock' has no member named 'mc_loop'
    1304 |         inet->mc_loop = loop ? 1 : 0;
         |             ^~


vim +1304 net/netfilter/ipvs/ip_vs_sync.c

1c003b1580e20f net/netfilter/ipvs/ip_vs_sync.c Pablo Neira Ayuso 2012-05-08  1294  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1295  /*
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1296   *      Setup loopback of outgoing multicasts on a sending socket
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1297   */
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1298  static void set_mcast_loop(struct sock *sk, u_char loop)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1299  {
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1300  	struct inet_sock *inet = inet_sk(sk);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1301  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1302  	/* setsockopt(sock, SOL_IP, IP_MULTICAST_LOOP, &loop, sizeof(loop)); */
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1303  	lock_sock(sk);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16 @1304  	inet->mc_loop = loop ? 1 : 0;
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1305  #ifdef CONFIG_IP_VS_IPV6
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1306  	if (sk->sk_family == AF_INET6) {
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1307  		struct ipv6_pinfo *np = inet6_sk(sk);
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1308  
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1309  		/* IPV6_MULTICAST_LOOP */
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1310  		np->mc_loop = loop ? 1 : 0;
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1311  	}
d33288172e72c4 net/netfilter/ipvs/ip_vs_sync.c Julian Anastasov  2015-07-26  1312  #endif
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1313  	release_sock(sk);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1314  }
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_sync.c      Linus Torvalds    2005-04-16  1315  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

