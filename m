Return-Path: <netdev+bounces-241400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A119C836D4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 06:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 203CB4E1CCD
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD39285CB6;
	Tue, 25 Nov 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBpSf57g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F91E505
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764050231; cv=none; b=GfL4+PCF1b6j1mixpAx3kcaKVTF8wMyRV2VT/4A7O1pQ4nZk5wmfR5TUEiJoL611zIVeInP5SA5/LFW6o0lpPrCfhT76QfPHcqXiWlDUGSq24IKFdqUNIFVAo3wAQiwVH4MtjpqpzyANwRB4e7hdJJTj5+ffXPNq32mHgNu3dLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764050231; c=relaxed/simple;
	bh=UW9Tqd2TDYRuqCCLTVTStq4/ICmNEU2x6zVex0AiG9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7Fg+vOFGYTdRKoVdwcIMovuOuR50ZWmAN1Pgmrk6m+pOVmmJrBvYz68B7yh3sT0Sewc0BhRp0VTvB9sWUnwacrBhPPlLGGR361YabiX27/s7KNVD/AS6T1ajA19VTGmcbjTlq4sMm2tW5Wt+GLD/HAALG+/WPg/wZsWVXocqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBpSf57g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764050230; x=1795586230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UW9Tqd2TDYRuqCCLTVTStq4/ICmNEU2x6zVex0AiG9g=;
  b=VBpSf57gdMmO/RnOwbKUpgWMaJR1C0kA1uC9UEQq2IZQQZVvb2g6pCxH
   aHAki6SpEGRfeMZxpK8Qu9I7KwE/mKb+FE9eKhROmztpN4vbzkQ9U974/
   rp8TWnJI//Epmj5cR0zSiVF5uQOg06/muErFQ77+JP6kv7BzKSp0lvu4k
   8OXWaJ+3iZy1WbAk38Ns/jX3WsRThny0ezoDr1R2zJp65CPNvdu7zRvTa
   pMpbaiuf0Ek41L8h222hS9LOFntMrnrxLBO3QUFGUBxx9P3neLWpLRntu
   /08GLNsCDC7LY+42sUBtiUHY1y5XjowAXI48NFhX6feaFyg3hGCLU/xlG
   A==;
X-CSE-ConnectionGUID: dGQkFbFQQfyF5rap+gBZnw==
X-CSE-MsgGUID: qqr5v38sRl28lNdQ8QfKWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66093480"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="66093480"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 21:57:10 -0800
X-CSE-ConnectionGUID: 3vakAxV7SYyTxpeQmJEdpQ==
X-CSE-MsgGUID: CZ9md+JrRfKv9IIhcP2rbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192353809"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Nov 2025 21:57:06 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNm2x-000000001Ph-45hl;
	Tue, 25 Nov 2025 05:57:03 +0000
Date: Tue, 25 Nov 2025 13:56:08 +0800
From: kernel test robot <lkp@intel.com>
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org,
	Liang Li <liali@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH net] net: vxlan: prevent NULL deref in vxlan_xmit_one
Message-ID: <202511251305.hL5BkEXK-lkp@intel.com>
References: <20251124163103.23131-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124163103.23131-1-atenart@kernel.org>

Hi Antoine,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoine-Tenart/net-vxlan-prevent-NULL-deref-in-vxlan_xmit_one/20251125-003536
base:   net/main
patch link:    https://lore.kernel.org/r/20251124163103.23131-1-atenart%40kernel.org
patch subject: [PATCH net] net: vxlan: prevent NULL deref in vxlan_xmit_one
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20251125/202511251305.hL5BkEXK-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251125/202511251305.hL5BkEXK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511251305.hL5BkEXK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/vxlan/vxlan_core.c:2548:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2548 |                 if (unlikely(!sock6)) {
         |                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/vxlan/vxlan_core.c:2631:6: note: uninitialized use occurs here
    2631 |         if (err == -ELOOP)
         |             ^~~
   drivers/net/vxlan/vxlan_core.c:2548:3: note: remove the 'if' if its condition is always false
    2548 |                 if (unlikely(!sock6)) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
    2549 |                         reason = SKB_DROP_REASON_DEV_READY;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2550 |                         goto tx_error;
         |                         ~~~~~~~~~~~~~~
    2551 |                 }
         |                 ~
   drivers/net/vxlan/vxlan_core.c:2464:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2464 |                 if (unlikely(!sock4)) {
         |                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/vxlan/vxlan_core.c:2631:6: note: uninitialized use occurs here
    2631 |         if (err == -ELOOP)
         |             ^~~
   drivers/net/vxlan/vxlan_core.c:2464:3: note: remove the 'if' if its condition is always false
    2464 |                 if (unlikely(!sock4)) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
    2465 |                         reason = SKB_DROP_REASON_DEV_READY;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2466 |                         goto tx_error;
         |                         ~~~~~~~~~~~~~~
    2467 |                 }
         |                 ~
   drivers/net/vxlan/vxlan_core.c:2352:9: note: initialize the variable 'err' to silence this warning
    2352 |         int err;
         |                ^
         |                 = 0
   2 warnings generated.


vim +2548 drivers/net/vxlan/vxlan_core.c

  2334	
  2335	void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
  2336			    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc)
  2337	{
  2338		struct dst_cache *dst_cache;
  2339		struct ip_tunnel_info *info;
  2340		struct ip_tunnel_key *pkey;
  2341		struct ip_tunnel_key key;
  2342		struct vxlan_dev *vxlan = netdev_priv(dev);
  2343		const struct iphdr *old_iph;
  2344		struct vxlan_metadata _md;
  2345		struct vxlan_metadata *md = &_md;
  2346		unsigned int pkt_len = skb->len;
  2347		__be16 src_port = 0, dst_port;
  2348		struct dst_entry *ndst = NULL;
  2349		int addr_family;
  2350		__u8 tos, ttl;
  2351		int ifindex;
  2352		int err;
  2353		u32 flags = vxlan->cfg.flags;
  2354		bool use_cache;
  2355		bool udp_sum = false;
  2356		bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
  2357		enum skb_drop_reason reason;
  2358		bool no_eth_encap;
  2359		__be32 vni = 0;
  2360	
  2361		no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
  2362		reason = skb_vlan_inet_prepare(skb, no_eth_encap);
  2363		if (reason)
  2364			goto drop;
  2365	
  2366		reason = SKB_DROP_REASON_NOT_SPECIFIED;
  2367		old_iph = ip_hdr(skb);
  2368	
  2369		info = skb_tunnel_info(skb);
  2370		use_cache = ip_tunnel_dst_cache_usable(skb, info);
  2371	
  2372		if (rdst) {
  2373			memset(&key, 0, sizeof(key));
  2374			pkey = &key;
  2375	
  2376			if (vxlan_addr_any(&rdst->remote_ip)) {
  2377				if (did_rsc) {
  2378					/* short-circuited back to local bridge */
  2379					vxlan_encap_bypass(skb, vxlan, vxlan,
  2380							   default_vni, true);
  2381					return;
  2382				}
  2383				goto drop;
  2384			}
  2385	
  2386			addr_family = vxlan->cfg.saddr.sa.sa_family;
  2387			dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
  2388			vni = (rdst->remote_vni) ? : default_vni;
  2389			ifindex = rdst->remote_ifindex;
  2390	
  2391			if (addr_family == AF_INET) {
  2392				key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
  2393				key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
  2394			} else {
  2395				key.u.ipv6.src = vxlan->cfg.saddr.sin6.sin6_addr;
  2396				key.u.ipv6.dst = rdst->remote_ip.sin6.sin6_addr;
  2397			}
  2398	
  2399			dst_cache = &rdst->dst_cache;
  2400			md->gbp = skb->mark;
  2401			if (flags & VXLAN_F_TTL_INHERIT) {
  2402				ttl = ip_tunnel_get_ttl(old_iph, skb);
  2403			} else {
  2404				ttl = vxlan->cfg.ttl;
  2405				if (!ttl && vxlan_addr_multicast(&rdst->remote_ip))
  2406					ttl = 1;
  2407			}
  2408			tos = vxlan->cfg.tos;
  2409			if (tos == 1)
  2410				tos = ip_tunnel_get_dsfield(old_iph, skb);
  2411			if (tos && !info)
  2412				use_cache = false;
  2413	
  2414			if (addr_family == AF_INET)
  2415				udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
  2416			else
  2417				udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
  2418	#if IS_ENABLED(CONFIG_IPV6)
  2419			switch (vxlan->cfg.label_policy) {
  2420			case VXLAN_LABEL_FIXED:
  2421				key.label = vxlan->cfg.label;
  2422				break;
  2423			case VXLAN_LABEL_INHERIT:
  2424				key.label = ip_tunnel_get_flowlabel(old_iph, skb);
  2425				break;
  2426			default:
  2427				DEBUG_NET_WARN_ON_ONCE(1);
  2428				goto drop;
  2429			}
  2430	#endif
  2431		} else {
  2432			if (!info) {
  2433				WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
  2434					  dev->name);
  2435				goto drop;
  2436			}
  2437			pkey = &info->key;
  2438			addr_family = ip_tunnel_info_af(info);
  2439			dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
  2440			vni = tunnel_id_to_key32(info->key.tun_id);
  2441			ifindex = 0;
  2442			dst_cache = &info->dst_cache;
  2443			if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags)) {
  2444				if (info->options_len < sizeof(*md))
  2445					goto drop;
  2446				md = ip_tunnel_info_opts(info);
  2447			}
  2448			ttl = info->key.ttl;
  2449			tos = info->key.tos;
  2450			udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
  2451		}
  2452		src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
  2453					     vxlan->cfg.port_max, true);
  2454	
  2455		rcu_read_lock();
  2456		if (addr_family == AF_INET) {
  2457			struct vxlan_sock *sock4;
  2458			u16 ipcb_flags = 0;
  2459			struct rtable *rt;
  2460			__be16 df = 0;
  2461			__be32 saddr;
  2462	
  2463			sock4 = rcu_dereference(vxlan->vn4_sock);
  2464			if (unlikely(!sock4)) {
  2465				reason = SKB_DROP_REASON_DEV_READY;
  2466				goto tx_error;
  2467			}
  2468	
  2469			if (!ifindex)
  2470				ifindex = sock4->sock->sk->sk_bound_dev_if;
  2471	
  2472			rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
  2473						   &saddr, pkey, src_port, dst_port,
  2474						   tos, use_cache ? dst_cache : NULL);
  2475			if (IS_ERR(rt)) {
  2476				err = PTR_ERR(rt);
  2477				reason = SKB_DROP_REASON_IP_OUTNOROUTES;
  2478				goto tx_error;
  2479			}
  2480	
  2481			if (flags & VXLAN_F_MC_ROUTE)
  2482				ipcb_flags |= IPSKB_MCROUTE;
  2483	
  2484			if (!info) {
  2485				/* Bypass encapsulation if the destination is local */
  2486				err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
  2487							    dst_port, ifindex, vni,
  2488							    &rt->dst, rt->rt_flags);
  2489				if (err)
  2490					goto out_unlock;
  2491	
  2492				if (vxlan->cfg.df == VXLAN_DF_SET) {
  2493					df = htons(IP_DF);
  2494				} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
  2495					struct ethhdr *eth = eth_hdr(skb);
  2496	
  2497					if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
  2498					    (ntohs(eth->h_proto) == ETH_P_IP &&
  2499					     old_iph->frag_off & htons(IP_DF)))
  2500						df = htons(IP_DF);
  2501				}
  2502			} else if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
  2503					    info->key.tun_flags)) {
  2504				df = htons(IP_DF);
  2505			}
  2506	
  2507			ndst = &rt->dst;
  2508			err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
  2509						    netif_is_any_bridge_port(dev));
  2510			if (err < 0) {
  2511				goto tx_error;
  2512			} else if (err) {
  2513				if (info) {
  2514					struct ip_tunnel_info *unclone;
  2515	
  2516					unclone = skb_tunnel_info_unclone(skb);
  2517					if (unlikely(!unclone))
  2518						goto tx_error;
  2519	
  2520					unclone->key.u.ipv4.src = pkey->u.ipv4.dst;
  2521					unclone->key.u.ipv4.dst = saddr;
  2522				}
  2523				vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
  2524				dst_release(ndst);
  2525				goto out_unlock;
  2526			}
  2527	
  2528			tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
  2529			ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
  2530			err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
  2531					      vni, md, flags, udp_sum);
  2532			if (err < 0) {
  2533				reason = SKB_DROP_REASON_NOMEM;
  2534				goto tx_error;
  2535			}
  2536	
  2537			udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
  2538					    pkey->u.ipv4.dst, tos, ttl, df,
  2539					    src_port, dst_port, xnet, !udp_sum,
  2540					    ipcb_flags);
  2541	#if IS_ENABLED(CONFIG_IPV6)
  2542		} else {
  2543			struct vxlan_sock *sock6;
  2544			struct in6_addr saddr;
  2545			u16 ip6cb_flags = 0;
  2546	
  2547			sock6 = rcu_dereference(vxlan->vn6_sock);
> 2548			if (unlikely(!sock6)) {
  2549				reason = SKB_DROP_REASON_DEV_READY;
  2550				goto tx_error;
  2551			}
  2552	
  2553			if (!ifindex)
  2554				ifindex = sock6->sock->sk->sk_bound_dev_if;
  2555	
  2556			ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
  2557						      ifindex, &saddr, pkey,
  2558						      src_port, dst_port, tos,
  2559						      use_cache ? dst_cache : NULL);
  2560			if (IS_ERR(ndst)) {
  2561				err = PTR_ERR(ndst);
  2562				ndst = NULL;
  2563				reason = SKB_DROP_REASON_IP_OUTNOROUTES;
  2564				goto tx_error;
  2565			}
  2566	
  2567			if (flags & VXLAN_F_MC_ROUTE)
  2568				ip6cb_flags |= IP6SKB_MCROUTE;
  2569	
  2570			if (!info) {
  2571				u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
  2572	
  2573				err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
  2574							    dst_port, ifindex, vni,
  2575							    ndst, rt6i_flags);
  2576				if (err)
  2577					goto out_unlock;
  2578			}
  2579	
  2580			err = skb_tunnel_check_pmtu(skb, ndst,
  2581						    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
  2582						    netif_is_any_bridge_port(dev));
  2583			if (err < 0) {
  2584				goto tx_error;
  2585			} else if (err) {
  2586				if (info) {
  2587					struct ip_tunnel_info *unclone;
  2588	
  2589					unclone = skb_tunnel_info_unclone(skb);
  2590					if (unlikely(!unclone))
  2591						goto tx_error;
  2592	
  2593					unclone->key.u.ipv6.src = pkey->u.ipv6.dst;
  2594					unclone->key.u.ipv6.dst = saddr;
  2595				}
  2596	
  2597				vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
  2598				dst_release(ndst);
  2599				goto out_unlock;
  2600			}
  2601	
  2602			tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
  2603			ttl = ttl ? : ip6_dst_hoplimit(ndst);
  2604			skb_scrub_packet(skb, xnet);
  2605			err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
  2606					      vni, md, flags, udp_sum);
  2607			if (err < 0) {
  2608				reason = SKB_DROP_REASON_NOMEM;
  2609				goto tx_error;
  2610			}
  2611	
  2612			udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
  2613					     &saddr, &pkey->u.ipv6.dst, tos, ttl,
  2614					     pkey->label, src_port, dst_port, !udp_sum,
  2615					     ip6cb_flags);
  2616	#endif
  2617		}
  2618		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
  2619	out_unlock:
  2620		rcu_read_unlock();
  2621		return;
  2622	
  2623	drop:
  2624		dev_dstats_tx_dropped(dev);
  2625		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
  2626		kfree_skb_reason(skb, reason);
  2627		return;
  2628	
  2629	tx_error:
  2630		rcu_read_unlock();
  2631		if (err == -ELOOP)
  2632			DEV_STATS_INC(dev, collisions);
  2633		else if (err == -ENETUNREACH)
  2634			DEV_STATS_INC(dev, tx_carrier_errors);
  2635		dst_release(ndst);
  2636		DEV_STATS_INC(dev, tx_errors);
  2637		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
  2638		kfree_skb_reason(skb, reason);
  2639	}
  2640	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

