Return-Path: <netdev+bounces-29504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAE78385B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D73280FBF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB2139B;
	Tue, 22 Aug 2023 03:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BD1365
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:13:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83379138
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692674017; x=1724210017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMhOPpln6PZIB0MFQoFjB/JJWAZsbI5O+vFGGPRmOJo=;
  b=X7ezVimv67n4AUXjJf0G/48UeO/nUtpSsXZa9s/Q3gEwop7FxpcanK37
   86GMzKXgN1rqLWR2POFgx+r1jWv24TEFZNs6NOryUpsN50cvjFXb7jrcg
   pX9JloB1t3QS58pGBaah7bVb0MDy/ws+ec46P9GGjpJRbLI3zAE2KcukB
   YEPAajBm1aAn7XlYCOIlqj5a218URWRe31viZrMshkytuzjK2wR4tmn0w
   +0+ZVrTo2QQMMxZCCnsf0dcKNVxDKOLwwHL+LPYpxWWOgswSlgV2arQLr
   RcAcAcNGN2ekJC/4CLj/yuhfJQHwMGdgSMKZklKcYJJLgD6TCuKs6xxZY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363932363"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="363932363"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 20:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="806129175"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="806129175"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 20:13:33 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qYHpk-0001Hc-1B;
	Tue, 22 Aug 2023 03:13:32 +0000
Date: Tue, 22 Aug 2023 11:12:41 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/3] net: l2tp_eth: use generic dev->stats fields
Message-ID: <202308221125.rGMwm9uv-lkp@intel.com>
References: <20230819044059.833749-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819044059.833749-4-edumazet@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-add-DEV_STATS_READ-helper/20230821-110051
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230819044059.833749-4-edumazet%40google.com
patch subject: [PATCH net-next 3/3] net: l2tp_eth: use generic dev->stats fields
config: i386-randconfig-015-20230822 (https://download.01.org/0day-ci/archive/20230822/202308221125.rGMwm9uv-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221125.rGMwm9uv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221125.rGMwm9uv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/l2tp/l2tp_eth.c:121:19: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
           struct l2tp_eth *priv;
                            ^
   1 warning generated.


vim +/priv +121 net/l2tp/l2tp_eth.c

d9e31d17ceba5f James Chapman    2010-04-02  116  
d9e31d17ceba5f James Chapman    2010-04-02  117  static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
d9e31d17ceba5f James Chapman    2010-04-02  118  {
d9e31d17ceba5f James Chapman    2010-04-02  119  	struct l2tp_eth_sess *spriv = l2tp_session_priv(session);
ee28de6bbd78c2 Guillaume Nault  2017-10-27  120  	struct net_device *dev;
ee28de6bbd78c2 Guillaume Nault  2017-10-27 @121  	struct l2tp_eth *priv;
d9e31d17ceba5f James Chapman    2010-04-02  122  
c0cc88a7627c33 Eric Dumazet     2012-09-04  123  	if (!pskb_may_pull(skb, ETH_HLEN))
d9e31d17ceba5f James Chapman    2010-04-02  124  		goto error;
d9e31d17ceba5f James Chapman    2010-04-02  125  
d9e31d17ceba5f James Chapman    2010-04-02  126  	secpath_reset(skb);
d9e31d17ceba5f James Chapman    2010-04-02  127  
d9e31d17ceba5f James Chapman    2010-04-02  128  	/* checksums verified by L2TP */
d9e31d17ceba5f James Chapman    2010-04-02  129  	skb->ip_summed = CHECKSUM_NONE;
d9e31d17ceba5f James Chapman    2010-04-02  130  
d9e31d17ceba5f James Chapman    2010-04-02  131  	skb_dst_drop(skb);
895b5c9f206eb7 Florian Westphal 2019-09-29  132  	nf_reset_ct(skb);
d9e31d17ceba5f James Chapman    2010-04-02  133  
ee28de6bbd78c2 Guillaume Nault  2017-10-27  134  	rcu_read_lock();
ee28de6bbd78c2 Guillaume Nault  2017-10-27  135  	dev = rcu_dereference(spriv->dev);
ee28de6bbd78c2 Guillaume Nault  2017-10-27  136  	if (!dev)
ee28de6bbd78c2 Guillaume Nault  2017-10-27  137  		goto error_rcu;
ee28de6bbd78c2 Guillaume Nault  2017-10-27  138  
ee28de6bbd78c2 Guillaume Nault  2017-10-27  139  	priv = netdev_priv(dev);
d9e31d17ceba5f James Chapman    2010-04-02  140  	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS) {
b9494cd37a920d Eric Dumazet     2023-08-19  141  		DEV_STATS_INC(dev, rx_packets);
b9494cd37a920d Eric Dumazet     2023-08-19  142  		DEV_STATS_ADD(dev, rx_bytes, data_len);
a2842a1e663297 Eric Dumazet     2012-06-25  143  	} else {
b9494cd37a920d Eric Dumazet     2023-08-19  144  		DEV_STATS_INC(dev, rx_errors);
a2842a1e663297 Eric Dumazet     2012-06-25  145  	}
ee28de6bbd78c2 Guillaume Nault  2017-10-27  146  	rcu_read_unlock();
ee28de6bbd78c2 Guillaume Nault  2017-10-27  147  
d9e31d17ceba5f James Chapman    2010-04-02  148  	return;
d9e31d17ceba5f James Chapman    2010-04-02  149  
ee28de6bbd78c2 Guillaume Nault  2017-10-27  150  error_rcu:
ee28de6bbd78c2 Guillaume Nault  2017-10-27  151  	rcu_read_unlock();
d9e31d17ceba5f James Chapman    2010-04-02  152  error:
d9e31d17ceba5f James Chapman    2010-04-02  153  	kfree_skb(skb);
d9e31d17ceba5f James Chapman    2010-04-02  154  }
d9e31d17ceba5f James Chapman    2010-04-02  155  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

