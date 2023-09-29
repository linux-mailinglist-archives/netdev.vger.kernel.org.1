Return-Path: <netdev+bounces-37138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4347B3CC7
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 00:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5875F1C20869
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988606589E;
	Fri, 29 Sep 2023 22:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BC516CC
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 22:53:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B69DD
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696027988; x=1727563988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UWpW4f6M5lGsdXQ4SGf5piIdx/q+WL7NVfd8n+JyAQQ=;
  b=DlqhTASsSWvzkyT5rmcMNjTEM7OJwNIPiUzqmw3NLUfQgKWT37bnnANa
   BhvXK1XKBT55SZSS6K/7A5Cpsp7gp38ADqHhHgra+Y1qnQio8DH+eOash
   1dCWXMDay6duq2KJ/eHtXd4prmydA/2Wzo/kNDaURlvaMZaPjwtbJOqZW
   dStg/rAXNEfYRFY4WtvrCyM88+8vH/Qkqw6eFrgUprD6Zrj7Th6VKBzsk
   dsQrLV8aVSgZp1eseoIl9VUVvE+Yus5M2i0GclzuJL29AaXDXeZNAgtMz
   WpnCxxHUGgGchmFYEL6RHRe9tB7x4gbLeJVqrzF1ZI9Q96hmsLMv1Mv+w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386262907"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="386262907"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 15:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="865867958"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="865867958"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2023 15:53:05 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmMM3-0003O4-0l;
	Fri, 29 Sep 2023 22:53:03 +0000
Date: Sat, 30 Sep 2023 06:52:32 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH ipsec-next v2 1/3] xfrm: pass struct net to
 xfrm_decode_session wrappers
Message-ID: <202309300637.sTEZ8Sa9-lkp@intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on klassert-ipsec/master netfilter-nf/main linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/xfrm-pass-struct-net-to-xfrm_decode_session-wrappers/20230929-210047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20230929125848.5445-2-fw%40strlen.de
patch subject: [PATCH ipsec-next v2 1/3] xfrm: pass struct net to xfrm_decode_session wrappers
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230930/202309300637.sTEZ8Sa9-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300637.sTEZ8Sa9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300637.sTEZ8Sa9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/ipv4/icmp.c:69:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/ipv4/icmp.c:69:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/ipv4/icmp.c:69:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> net/ipv4/icmp.c:520:76: error: too many arguments to function call, expected 3, have 4
     520 |         err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~                                         ^~~~~~~
   include/linux/socket.h:192:18: note: expanded from macro 'AF_INET'
     192 | #define AF_INET         2       /* Internet IP Protocol         */
         |                         ^
   include/net/xfrm.h:1299:19: note: 'xfrm_decode_session_reverse' declared here
    1299 | static inline int xfrm_decode_session_reverse(struct sk_buff *skb,
         |                   ^
   12 warnings and 1 error generated.


vim +520 net/ipv4/icmp.c

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

