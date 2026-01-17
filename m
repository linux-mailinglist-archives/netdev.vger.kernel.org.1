Return-Path: <netdev+bounces-250682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19918D38B67
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 03:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 338E83029572
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948B30DEC0;
	Sat, 17 Jan 2026 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiM/VdNv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF92FB962
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615538; cv=none; b=lDznCTIUj7KmxAhsyD6leE1eJEUM/TyX9Lu65k9wfJOmFq+Di2X+NpEq5J1P75vO6oWpU7itmqfTSRq06TSKzh4ufFSRVHp4hsbMqe9FQmHrtnMUFdAxEXLld2dQoTs8z+bCBhoQ4P20ad1J9ovP0C85klh1Otq9MHMJhBXI6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615538; c=relaxed/simple;
	bh=2msC8SoYlE3PKWOFmWXI1lZceOxR178GiEfNfpM/x1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYM1K8133WQpS9TiUnhyyy1qF9V8scXZQmFIvTU5Pd54uiOfwmd9EPpn372ghHEUFoL3Cndpyr4mS+Nym122dqOFHLDS7WdCBVEysSLdLU8QCcS497W+awjt70b7uLzwkW9FpyhhUe17KGwuP2rA4NLrTlYr/KnJ1C3Yl83bMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiM/VdNv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768615537; x=1800151537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2msC8SoYlE3PKWOFmWXI1lZceOxR178GiEfNfpM/x1U=;
  b=KiM/VdNv9nTyenlnPqevKNh2QcWZJ7ElYoug153AhYXlzYpatUdsQHG2
   zp9hA2/Ygk2vVkVnfXD6nwtGIXCZ6Re132L4lFig/NBBOaZ9auSxL0CQc
   QWP0ICNS2yMOYq47QpQFsrY9HbpbGlmRplKYb6jbCzFCNrJ7872IUMR0T
   og6pqaadvbSSYz2GfIQnCDv4f7X1LoxyK9S5v8AQfArDKrEjTj4oZOesY
   FgNltOYuP3y/+zNRhfbKlLFJuQBuBF0Kk2/yjw/S2IlymVq5D3uNMh/JB
   LYbMrn+mgq7GshxjSraV0G+tG4y7NBIjLwtBdA6auQ6Hyj+znLTHcqMAF
   A==;
X-CSE-ConnectionGUID: TGGDTB7nQl2YA7BovV1IYg==
X-CSE-MsgGUID: aN3U9Sq3RlqNLxEyXRfyMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69844275"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="69844275"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 18:05:36 -0800
X-CSE-ConnectionGUID: 42RyuxD8SceD1XrJIO8nJw==
X-CSE-MsgGUID: qDdxQFdDTCOI3lpiw6OmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="205285566"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jan 2026 18:05:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgvgw-00000000LS6-3MBk;
	Sat, 17 Jan 2026 02:05:30 +0000
Date: Sat, 17 Jan 2026 10:05:15 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 2/3] gro: inline tcp6_gro_receive()
Message-ID: <202601170903.keV6lwyg-lkp@intel.com>
References: <20260116152957.1825626-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116152957.1825626-3-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-always-inline-__skb_incr_checksum_unnecessary/20260116-233745
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260116152957.1825626-3-edumazet%40google.com
patch subject: [PATCH net-next 2/3] gro: inline tcp6_gro_receive()
config: i386-randconfig-015-20260117 (https://download.01.org/0day-ci/archive/20260117/202601170903.keV6lwyg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170903.keV6lwyg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170903.keV6lwyg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/ip6_offload.c: In function 'ipv6_gro_receive':
   net/ipv6/ip6_offload.c:304:22: error: implicit declaration of function 'udp6_gro_receive'; did you mean 'udp_gro_receive'? [-Werror=implicit-function-declaration]
     304 |                 pp = udp6_gro_receive(head, skb);
         |                      ^~~~~~~~~~~~~~~~
         |                      udp_gro_receive
>> net/ipv6/ip6_offload.c:304:20: warning: assignment to 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     304 |                 pp = udp6_gro_receive(head, skb);
         |                    ^
   cc1: some warnings being treated as errors


vim +304 net/ipv6/ip6_offload.c

   215	
   216	INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
   217								 struct sk_buff *skb)
   218	{
   219		const struct net_offload *ops;
   220		struct sk_buff *pp = NULL;
   221		struct sk_buff *p;
   222		struct ipv6hdr *iph;
   223		unsigned int nlen;
   224		unsigned int hlen;
   225		unsigned int off;
   226		u16 flush = 1;
   227		int proto;
   228	
   229		off = skb_gro_offset(skb);
   230		hlen = off + sizeof(*iph);
   231		iph = skb_gro_header(skb, hlen, off);
   232		if (unlikely(!iph))
   233			goto out;
   234	
   235		NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
   236	
   237		flush += ntohs(iph->payload_len) != skb->len - hlen;
   238	
   239		proto = iph->nexthdr;
   240		ops = rcu_dereference(inet6_offloads[proto]);
   241		if (!ops || !ops->callbacks.gro_receive) {
   242			proto = ipv6_gro_pull_exthdrs(skb, hlen, proto);
   243	
   244			ops = rcu_dereference(inet6_offloads[proto]);
   245			if (!ops || !ops->callbacks.gro_receive)
   246				goto out;
   247	
   248			iph = skb_gro_network_header(skb);
   249		} else {
   250			skb_gro_pull(skb, sizeof(*iph));
   251		}
   252	
   253		skb_set_transport_header(skb, skb_gro_offset(skb));
   254	
   255		NAPI_GRO_CB(skb)->proto = proto;
   256	
   257		flush--;
   258		nlen = skb_gro_offset(skb) - off;
   259	
   260		list_for_each_entry(p, head, list) {
   261			const struct ipv6hdr *iph2;
   262			__be32 first_word; /* <Version:4><Traffic_Class:8><Flow_Label:20> */
   263	
   264			if (!NAPI_GRO_CB(p)->same_flow)
   265				continue;
   266	
   267			iph2 = (struct ipv6hdr *)(p->data + off);
   268			first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
   269	
   270			/* All fields must match except length and Traffic Class.
   271			 * XXX skbs on the gro_list have all been parsed and pulled
   272			 * already so we don't need to compare nlen
   273			 * (nlen != (sizeof(*iph2) + ipv6_exthdrs_len(iph2, &ops)))
   274			 * memcmp() alone below is sufficient, right?
   275			 */
   276			 if ((first_word & htonl(0xF00FFFFF)) ||
   277			     !ipv6_addr_equal(&iph->saddr, &iph2->saddr) ||
   278			     !ipv6_addr_equal(&iph->daddr, &iph2->daddr) ||
   279			     iph->nexthdr != iph2->nexthdr) {
   280	not_same_flow:
   281				NAPI_GRO_CB(p)->same_flow = 0;
   282				continue;
   283			}
   284			if (unlikely(nlen > sizeof(struct ipv6hdr))) {
   285				if (memcmp(iph + 1, iph2 + 1,
   286					   nlen - sizeof(struct ipv6hdr)))
   287					goto not_same_flow;
   288			}
   289		}
   290	
   291		NAPI_GRO_CB(skb)->flush |= flush;
   292	
   293		skb_gro_postpull_rcsum(skb, iph, nlen);
   294	
   295		if (unlikely(gro_recursion_inc_test(skb))) {
   296			flush = 1;
   297			goto out;
   298		}
   299	
   300		if (likely(proto == IPPROTO_TCP))
   301			pp = tcp6_gro_receive(head, skb);
   302	#if IS_BUILTIN(CONFIG_IPV6)
   303		else if (likely(proto == IPPROTO_UDP))
 > 304			pp = udp6_gro_receive(head, skb);
   305	#endif
   306		else
   307			pp = ops->callbacks.gro_receive(head, skb);
   308	out:
   309		skb_gro_flush_final(skb, pp, flush);
   310	
   311		return pp;
   312	}
   313	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

