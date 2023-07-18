Return-Path: <netdev+bounces-18629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515497580DF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831611C20ABF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE25101FA;
	Tue, 18 Jul 2023 15:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348CD518
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:29:24 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C1F4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689694159; x=1721230159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zy/H3JZMwzAUiHQgKlq/umt/vbRR4DWIK5EHCg8XUmU=;
  b=b2//RAh5CwpnkMA6JxAJxw/ludYXUWe8xBg7wJywILQn+0r+j8jenLWX
   1eXmdZF4sIL5wgnJy19tPQbCjWRdcs588SDXpumEJzoW2rYjOxBb5Z4Pk
   ZGrpp7eq1PhPbnd7ZVAQjORanDEGhRZqLWaOsZ/YKbxGC21aYCqzy+YbN
   7popCzgmkZmPcgTPc13+teHvtwJgnRtElVG4jd8JdsnBI2U398l4sR3SW
   i5LMXLRYEK3Ija66/mUyjyoXjaz8eeMNgMteWcYAwbiriNMR7oNKdzc4e
   m3z0UC/h3X24A9hr0iTih2aw8yYtWTiBMcHGihx236BNu2KLMvN3ShCFn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366278786"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366278786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 08:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753362455"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753362455"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 08:29:15 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qLmdW-0000gB-31;
	Tue, 18 Jul 2023 15:29:14 +0000
Date: Tue, 18 Jul 2023 23:28:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] net:openvswitch: check return value of pskb_trim()
Message-ID: <202307182349.2ivzwQk9-lkp@intel.com>
References: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yuanjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanjun-Gong/net-openvswitch-check-return-value-of-pskb_trim/20230718-190417
base:   linus/master
patch link:    https://lore.kernel.org/r/20230717145024.27274-1-ruc_gongyuanjun%40163.com
patch subject: [PATCH 1/1] net:openvswitch: check return value of pskb_trim()
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230718/202307182349.2ivzwQk9-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230718/202307182349.2ivzwQk9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307182349.2ivzwQk9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/openvswitch/actions.c: In function 'do_output':
>> net/openvswitch/actions.c:922:28: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     922 |                         if (skb->len - cutlen > ovs_mac_header_len(key))
         |                            ^


vim +/else +922 net/openvswitch/actions.c

7f8a436eaa2c3d Joe Stringer      2015-08-26  911  
7f8a436eaa2c3d Joe Stringer      2015-08-26  912  static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
7f8a436eaa2c3d Joe Stringer      2015-08-26  913  		      struct sw_flow_key *key)
ccb1352e76cff0 Jesse Gross       2011-10-25  914  {
738967b8bf57e5 Andy Zhou         2014-09-08  915  	struct vport *vport = ovs_vport_rcu(dp, out_port);
ccb1352e76cff0 Jesse Gross       2011-10-25  916  
066b86787fa3d9 Felix Huettner    2023-04-05  917  	if (likely(vport && netif_carrier_ok(vport->dev))) {
7f8a436eaa2c3d Joe Stringer      2015-08-26  918  		u16 mru = OVS_CB(skb)->mru;
f2a4d086ed4c58 William Tu        2016-06-10  919  		u32 cutlen = OVS_CB(skb)->cutlen;
f2a4d086ed4c58 William Tu        2016-06-10  920  
f2a4d086ed4c58 William Tu        2016-06-10  921  		if (unlikely(cutlen > 0)) {
e2d9d8358cb961 Jiri Benc         2016-11-10 @922  			if (skb->len - cutlen > ovs_mac_header_len(key))
ec8358d8ed17bf Yuanjun Gong      2023-07-17  923  				if (pskb_trim(skb, skb->len - cutlen))
ec8358d8ed17bf Yuanjun Gong      2023-07-17  924  					kfree_skb(skb);
f2a4d086ed4c58 William Tu        2016-06-10  925  			else
ec8358d8ed17bf Yuanjun Gong      2023-07-17  926  				if (pskb_trim(skb, ovs_mac_header_len(key)))
ec8358d8ed17bf Yuanjun Gong      2023-07-17  927  					kfree_skb(skb);
f2a4d086ed4c58 William Tu        2016-06-10  928  		}
7f8a436eaa2c3d Joe Stringer      2015-08-26  929  
738314a084aae5 Jiri Benc         2016-11-10  930  		if (likely(!mru ||
738314a084aae5 Jiri Benc         2016-11-10  931  		           (skb->len <= mru + vport->dev->hard_header_len))) {
e2d9d8358cb961 Jiri Benc         2016-11-10  932  			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
7f8a436eaa2c3d Joe Stringer      2015-08-26  933  		} else if (mru <= vport->dev->mtu) {
c559cd3ad32ba7 Eric W. Biederman 2015-09-14  934  			struct net *net = read_pnet(&dp->net);
7f8a436eaa2c3d Joe Stringer      2015-08-26  935  
e2d9d8358cb961 Jiri Benc         2016-11-10  936  			ovs_fragment(net, vport, skb, mru, key);
7f8a436eaa2c3d Joe Stringer      2015-08-26  937  		} else {
7f8a436eaa2c3d Joe Stringer      2015-08-26  938  			kfree_skb(skb);
7f8a436eaa2c3d Joe Stringer      2015-08-26  939  		}
7f8a436eaa2c3d Joe Stringer      2015-08-26  940  	} else {
738967b8bf57e5 Andy Zhou         2014-09-08  941  		kfree_skb(skb);
ccb1352e76cff0 Jesse Gross       2011-10-25  942  	}
7f8a436eaa2c3d Joe Stringer      2015-08-26  943  }
ccb1352e76cff0 Jesse Gross       2011-10-25  944  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

