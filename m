Return-Path: <netdev+bounces-37137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4E7B3CAC
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 00:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9A7C92820EF
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6947369;
	Fri, 29 Sep 2023 22:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350A347C1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 22:42:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36F1A5
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696027327; x=1727563327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yCO9B4x1qSKO2Q7AZ3NMfs8WIIV0g+qBgfK+N0yohhU=;
  b=Fo6ynzbRtT+xHS/h2M40sZp5/a/7iFJhVdAumOxtoI3Sbq8DG7SfzJMK
   O0/rzMYBLuiqYqoUSpRFrc+u4VGeTu2dxK4GWUYC2jY2qvOMt1ykcJBUR
   OJgrSyLNvZGvIi+8JOLp0idAO8J9bFCl9B9RW7I1/B/8NpvJJ7mzBW/rJ
   a0snI9qU3uQJ+W0Q1LPV9yQWV6Ntc+kipMBtagNPEuGfDLeWH0PNqJKbs
   GUC82IDa/3fQWce1C5WXYn3qNl9VyUzeMKl8bwj3hvCa4oWflakrF4js6
   vgz2DVcEoMA65TYyfbscuOZzgo/CgWsSCBx8BweDDr5/ZVOEupmuzq/UP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="372753065"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="372753065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 15:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="750056537"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="750056537"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Sep 2023 15:42:04 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmMBO-0003NJ-1r;
	Fri, 29 Sep 2023 22:42:02 +0000
Date: Sat, 30 Sep 2023 06:42:01 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, Florian Westphal <fw@strlen.de>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH ipsec-next v2 1/3] xfrm: pass struct net to
 xfrm_decode_session wrappers
Message-ID: <202309300634.DBomJJ9W-lkp@intel.com>
References: <20230929125848.5445-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929125848.5445-2-fw@strlen.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on klassert-ipsec/master netfilter-nf/main linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/xfrm-pass-struct-net-to-xfrm_decode_session-wrappers/20230929-210047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20230929125848.5445-2-fw%40strlen.de
patch subject: [PATCH ipsec-next v2 1/3] xfrm: pass struct net to xfrm_decode_session wrappers
config: microblaze-defconfig (https://download.01.org/0day-ci/archive/20230930/202309300634.DBomJJ9W-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300634.DBomJJ9W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300634.DBomJJ9W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/icmp.c: In function 'icmp_route_lookup':
   net/ipv4/icmp.c:520:43: error: passing argument 1 of 'xfrm_decode_session_reverse' from incompatible pointer type [-Werror=incompatible-pointer-types]
     520 |         err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
         |                                           ^~~
         |                                           |
         |                                           struct net *
   In file included from net/ipv4/icmp.c:91:
   include/net/xfrm.h:1299:63: note: expected 'struct sk_buff *' but argument is of type 'struct net *'
    1299 | static inline int xfrm_decode_session_reverse(struct sk_buff *skb,
         |                                               ~~~~~~~~~~~~~~~~^~~
   net/ipv4/icmp.c:520:48: error: passing argument 2 of 'xfrm_decode_session_reverse' from incompatible pointer type [-Werror=incompatible-pointer-types]
     520 |         err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
         |                                                ^~~~~~
         |                                                |
         |                                                struct sk_buff *
   include/net/xfrm.h:1300:61: note: expected 'struct flowi *' but argument is of type 'struct sk_buff *'
    1300 |                                               struct flowi *fl,
         |                                               ~~~~~~~~~~~~~~^~
>> net/ipv4/icmp.c:520:56: warning: passing argument 3 of 'xfrm_decode_session_reverse' makes integer from pointer without a cast [-Wint-conversion]
     520 |         err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                        |
         |                                                        struct flowi *
   include/net/xfrm.h:1301:60: note: expected 'unsigned int' but argument is of type 'struct flowi *'
    1301 |                                               unsigned int family)
         |                                               ~~~~~~~~~~~~~^~~~~~
   net/ipv4/icmp.c:520:15: error: too many arguments to function 'xfrm_decode_session_reverse'
     520 |         err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/xfrm.h:1299:19: note: declared here
    1299 | static inline int xfrm_decode_session_reverse(struct sk_buff *skb,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/xfrm_decode_session_reverse +520 net/ipv4/icmp.c

   475	
   476	static struct rtable *icmp_route_lookup(struct net *net,
   477						struct flowi4 *fl4,
   478						struct sk_buff *skb_in,
   479						const struct iphdr *iph,
   480						__be32 saddr, u8 tos, u32 mark,
   481						int type, int code,
   482						struct icmp_bxm *param)
   483	{
   484		struct net_device *route_lookup_dev;
   485		struct rtable *rt, *rt2;
   486		struct flowi4 fl4_dec;
   487		int err;
   488	
   489		memset(fl4, 0, sizeof(*fl4));
   490		fl4->daddr = (param->replyopts.opt.opt.srr ?
   491			      param->replyopts.opt.opt.faddr : iph->saddr);
   492		fl4->saddr = saddr;
   493		fl4->flowi4_mark = mark;
   494		fl4->flowi4_uid = sock_net_uid(net, NULL);
   495		fl4->flowi4_tos = RT_TOS(tos);
   496		fl4->flowi4_proto = IPPROTO_ICMP;
   497		fl4->fl4_icmp_type = type;
   498		fl4->fl4_icmp_code = code;
   499		route_lookup_dev = icmp_get_route_lookup_dev(skb_in);
   500		fl4->flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);
   501	
   502		security_skb_classify_flow(skb_in, flowi4_to_flowi_common(fl4));
   503		rt = ip_route_output_key_hash(net, fl4, skb_in);
   504		if (IS_ERR(rt))
   505			return rt;
   506	
   507		/* No need to clone since we're just using its address. */
   508		rt2 = rt;
   509	
   510		rt = (struct rtable *) xfrm_lookup(net, &rt->dst,
   511						   flowi4_to_flowi(fl4), NULL, 0);
   512		if (!IS_ERR(rt)) {
   513			if (rt != rt2)
   514				return rt;
   515		} else if (PTR_ERR(rt) == -EPERM) {
   516			rt = NULL;
   517		} else
   518			return rt;
   519	
 > 520		err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
   521		if (err)
   522			goto relookup_failed;
   523	
   524		if (inet_addr_type_dev_table(net, route_lookup_dev,
   525					     fl4_dec.saddr) == RTN_LOCAL) {
   526			rt2 = __ip_route_output_key(net, &fl4_dec);
   527			if (IS_ERR(rt2))
   528				err = PTR_ERR(rt2);
   529		} else {
   530			struct flowi4 fl4_2 = {};
   531			unsigned long orefdst;
   532	
   533			fl4_2.daddr = fl4_dec.saddr;
   534			rt2 = ip_route_output_key(net, &fl4_2);
   535			if (IS_ERR(rt2)) {
   536				err = PTR_ERR(rt2);
   537				goto relookup_failed;
   538			}
   539			/* Ugh! */
   540			orefdst = skb_in->_skb_refdst; /* save old refdst */
   541			skb_dst_set(skb_in, NULL);
   542			err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
   543					     RT_TOS(tos), rt2->dst.dev);
   544	
   545			dst_release(&rt2->dst);
   546			rt2 = skb_rtable(skb_in);
   547			skb_in->_skb_refdst = orefdst; /* restore old refdst */
   548		}
   549	
   550		if (err)
   551			goto relookup_failed;
   552	
   553		rt2 = (struct rtable *) xfrm_lookup(net, &rt2->dst,
   554						    flowi4_to_flowi(&fl4_dec), NULL,
   555						    XFRM_LOOKUP_ICMP);
   556		if (!IS_ERR(rt2)) {
   557			dst_release(&rt->dst);
   558			memcpy(fl4, &fl4_dec, sizeof(*fl4));
   559			rt = rt2;
   560		} else if (PTR_ERR(rt2) == -EPERM) {
   561			if (rt)
   562				dst_release(&rt->dst);
   563			return rt2;
   564		} else {
   565			err = PTR_ERR(rt2);
   566			goto relookup_failed;
   567		}
   568		return rt;
   569	
   570	relookup_failed:
   571		if (rt)
   572			return rt;
   573		return ERR_PTR(err);
   574	}
   575	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

