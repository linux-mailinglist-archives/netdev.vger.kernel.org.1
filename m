Return-Path: <netdev+bounces-29517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B8783899
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D33280F9E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08E53BD;
	Tue, 22 Aug 2023 03:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE81FA7
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:36:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B4187
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692675367; x=1724211367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vDOfv2h0LTJaP31se8wIJ4d6GV6zSZegpnQjsZ0ON28=;
  b=m+CH5v6NFfxM4vwe+9+ERfL3rbe3GQhIL6Xvlx4B8wOEut274La4wvvR
   BvKYKZXVzn1T5ochKFiXPSSyqHQc5o5XXZgkMeytdWA3HhTfKpnB2DP/X
   WJ5B0CztSG1UNYzbIzAu24HE5Qiq6PE/DH/9NVMgJ8Zsk1nT5EWtmvFD0
   g/zCeNdgpsmbwkq11/DujajONwQ9wO+ooBy0Sdsjjt6V+mCH+rUvqF9JJ
   E2rUH+/ODcoB9D2zmTjKwgVR4jKX8VNc8MSCxmcXIIIMe5Q7sw9rS6kGh
   CIq8xR5hxtQmHKgleFFutACSvDYw5EYC94JfrEha4fsV64lYvNP+NKlN8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437681751"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="437681751"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 20:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850436375"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="850436375"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2023 20:35:59 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qYIBS-0001Iw-0e;
	Tue, 22 Aug 2023 03:35:58 +0000
Date: Tue, 22 Aug 2023 11:35:40 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/3] net: l2tp_eth: use generic dev->stats fields
Message-ID: <202308221115.YXoSl0BK-lkp@intel.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20230822/202308221115.YXoSl0BK-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221115.YXoSl0BK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221115.YXoSl0BK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/l2tp/l2tp_eth.c: In function 'l2tp_eth_dev_recv':
>> net/l2tp/l2tp_eth.c:121:26: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     121 |         struct l2tp_eth *priv;
         |                          ^~~~


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

