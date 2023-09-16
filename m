Return-Path: <netdev+bounces-34281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBBA7A2FD0
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2051C20F5E
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA66820E4;
	Sat, 16 Sep 2023 12:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9113AC7
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 12:03:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9484CCD;
	Sat, 16 Sep 2023 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694865820; x=1726401820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0LjvPrP3FZDihyJh1AF+1Q4z1B9ca4sUEFNGNOglSc=;
  b=lwscX7esOrHs7bfXxgUBLxZ1jvopPNf8qnLdKnweoVEZ50MM7msV6elB
   jNXsdUzSnNKOwtYOfgnvVLc+A8j0xCAZ2A0OcrNSX96Ga6r/M4vUgCYub
   MS7/zZaxEOym2UUn7MlvxXs/+LAd0BQqphZaZVGoX5bG4kcrARuR0I6qN
   Yvp2Npbls8DqxaLVEVbsLIcpb0TirBCUSK0IbB8NOzqGMSbEikzk4LziY
   NPiu1r0Wqfj5qEHUawlRKt6YDRluhc73YMHUyYp1k3V8IeYbEHlEaFVXH
   CVZ6ChwMKUHZNU7lPy0gTDsL0PzJRO3Fb9NPFqk/96vjU0I1LXnd+uNrS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10835"; a="358821413"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="358821413"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 05:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774630319"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="774630319"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2023 05:03:36 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qhU1O-0004Ga-0p;
	Sat, 16 Sep 2023 12:03:34 +0000
Date: Sat, 16 Sep 2023 20:03:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: Re: [PATCH] net: sched: hfsc: dont intepret cls results when asked
 to drop
Message-ID: <202309161941.5lMYMKdM-lkp@intel.com>
References: <20230915134408.3410595-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915134408.3410595-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-sched-hfsc-dont-intepret-cls-results-when-asked-to-drop/20230915-214635
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230915134408.3410595-1-make_ruc2021%40163.com
patch subject: [PATCH] net: sched: hfsc: dont intepret cls results when asked to drop
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230916/202309161941.5lMYMKdM-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309161941.5lMYMKdM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309161941.5lMYMKdM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/sch_hfsc.c:1146:4: error: fallthrough annotation does not directly precede switch label
                           fallthrough;
                           ^
   include/linux/compiler_attributes.h:227:41: note: expanded from macro 'fallthrough'
   # define fallthrough                    __attribute__((__fallthrough__))
                                           ^
   1 error generated.


vim +1146 net/sched/sch_hfsc.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  1119  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1120  static struct hfsc_class *
^1da177e4c3f41 Linus Torvalds      2005-04-16  1121  hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1122  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1123  	struct hfsc_sched *q = qdisc_priv(sch);
a2f79227138c71 Patrick McHardy     2010-05-14  1124  	struct hfsc_class *head, *cl;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1125  	struct tcf_result res;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1126  	struct tcf_proto *tcf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1127  	int result;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1128  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1129  	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
^1da177e4c3f41 Linus Torvalds      2005-04-16  1130  	    (cl = hfsc_find_class(skb->priority, sch)) != NULL)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1131  		if (cl->level == 0)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1132  			return cl;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1133  
c27f339af90bb8 Jarek Poplawski     2008-08-04  1134  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
a2f79227138c71 Patrick McHardy     2010-05-14  1135  	head = &q->root;
25d8c0d55f241c John Fastabend      2014-09-12  1136  	tcf = rcu_dereference_bh(q->root.filter_list);
3aa2605594556c Davide Caratti      2021-07-28  1137  	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
b633b393d00632 Ma Ke               2023-09-15  1138  		if (result == TC_ACT_SHOT)
b633b393d00632 Ma Ke               2023-09-15  1139  			return NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1140  #ifdef CONFIG_NET_CLS_ACT
^1da177e4c3f41 Linus Torvalds      2005-04-16  1141  		switch (result) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1142  		case TC_ACT_QUEUED:
^1da177e4c3f41 Linus Torvalds      2005-04-16  1143  		case TC_ACT_STOLEN:
e25ea21ffa66a0 Jiri Pirko          2017-06-06  1144  		case TC_ACT_TRAP:
378a2f090f7a47 Jarek Poplawski     2008-08-04  1145  			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
964201de695b8a Gustavo A. R. Silva 2020-07-07 @1146  			fallthrough;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1147  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1148  #endif
cc7ec456f82da7 Eric Dumazet        2011-01-19  1149  		cl = (struct hfsc_class *)res.class;
cc7ec456f82da7 Eric Dumazet        2011-01-19  1150  		if (!cl) {
cc7ec456f82da7 Eric Dumazet        2011-01-19  1151  			cl = hfsc_find_class(res.classid, sch);
cc7ec456f82da7 Eric Dumazet        2011-01-19  1152  			if (!cl)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1153  				break; /* filter selected invalid classid */
a2f79227138c71 Patrick McHardy     2010-05-14  1154  			if (cl->level >= head->level)
a2f79227138c71 Patrick McHardy     2010-05-14  1155  				break; /* filter may only point downwards */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1156  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1157  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1158  		if (cl->level == 0)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1159  			return cl; /* hit leaf class */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1160  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1161  		/* apply inner filter chain */
25d8c0d55f241c John Fastabend      2014-09-12  1162  		tcf = rcu_dereference_bh(cl->filter_list);
a2f79227138c71 Patrick McHardy     2010-05-14  1163  		head = cl;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1164  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1165  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1166  	/* classification failed, try default class */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1167  	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle), q->defcls), sch);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1168  	if (cl == NULL || cl->level > 0)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1169  		return NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1170  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1171  	return cl;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1172  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  1173  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

