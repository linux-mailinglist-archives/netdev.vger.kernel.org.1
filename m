Return-Path: <netdev+bounces-38804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B362A7BC8BB
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7E4281E32
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719F2E648;
	Sat,  7 Oct 2023 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzRz0/36"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694B2E643
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:45:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067ECB9
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696693513; x=1728229513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oODtkSu+s8fEZoaJyy/fTQTT2/jBMIeX2muUWQXkWEI=;
  b=dzRz0/36hjkQ7/aA6rYhzY9BfIX/6k6sVGPrgK2v4Hh8a3VazUEXLpAx
   DJDd57YGF7AYbrA35OOfZSeJNwmZArgp+VuJCkj0A9svg4/NIamg9bS6B
   pMGIkhjEGXvfNeOqJzuJZtFqzUcBjpK3zUWux5UXDYpUhj6qJItn8fFuQ
   EixFcbpFNG+XkxZ+bhgFTID4cxMjFZubp+nNa3e47Hw6KvNlBPwErIFs1
   c/0CquTqLaUaU1F2Os0qgr/wKc7RKzBhfVV1BeFg4C7UqOhpyjAoO4T3A
   OJhWJ9M59jdoek8Rpag8ccXZybLGpxqpbQ6qUKwgjMXO/TRZEQ1MEuGi2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="414925645"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="414925645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 08:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="729198601"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="729198601"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2023 08:45:09 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qp9UI-0004VR-2G;
	Sat, 07 Oct 2023 15:45:06 +0000
Date: Sat, 7 Oct 2023 23:44:53 +0800
From: kernel test robot <lkp@intel.com>
To: Alce Lafranque <alce@lafranque.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Alce Lafranque <alce@lafranque.net>,
	Vincent Bernat <vincent@bernat.ch>
Subject: Re: [PATCH net-next v2] vxlan: add support for flowlabel inherit
Message-ID: <202310072308.H5ORfHTn-lkp@intel.com>
References: <20231007142624.739192-1-alce@lafranque.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007142624.739192-1-alce@lafranque.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alce,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Alce-Lafranque/vxlan-add-support-for-flowlabel-inherit/20231007-222907
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231007142624.739192-1-alce%40lafranque.net
patch subject: [PATCH net-next v2] vxlan: add support for flowlabel inherit
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310072308.H5ORfHTn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310072308.H5ORfHTn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310072308.H5ORfHTn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/vxlan/vxlan_core.c: In function 'vxlan_xmit_one':
>> drivers/net/vxlan/vxlan_core.c:2478:17: warning: enumeration value '__VXLAN_LABEL_END' not handled in switch [-Wswitch]
    2478 |                 switch (vxlan->cfg.label_behavior) {
         |                 ^~~~~~


vim +/__VXLAN_LABEL_END +2478 drivers/net/vxlan/vxlan_core.c

  2440	
  2441		info = skb_tunnel_info(skb);
  2442	
  2443		if (rdst) {
  2444			dst = &rdst->remote_ip;
  2445			if (vxlan_addr_any(dst)) {
  2446				if (did_rsc) {
  2447					/* short-circuited back to local bridge */
  2448					vxlan_encap_bypass(skb, vxlan, vxlan,
  2449							   default_vni, true);
  2450					return;
  2451				}
  2452				goto drop;
  2453			}
  2454	
  2455			dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
  2456			vni = (rdst->remote_vni) ? : default_vni;
  2457			ifindex = rdst->remote_ifindex;
  2458			local_ip = vxlan->cfg.saddr;
  2459			dst_cache = &rdst->dst_cache;
  2460			md->gbp = skb->mark;
  2461			if (flags & VXLAN_F_TTL_INHERIT) {
  2462				ttl = ip_tunnel_get_ttl(old_iph, skb);
  2463			} else {
  2464				ttl = vxlan->cfg.ttl;
  2465				if (!ttl && vxlan_addr_multicast(dst))
  2466					ttl = 1;
  2467			}
  2468	
  2469			tos = vxlan->cfg.tos;
  2470			if (tos == 1)
  2471				tos = ip_tunnel_get_dsfield(old_iph, skb);
  2472	
  2473			if (dst->sa.sa_family == AF_INET)
  2474				udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
  2475			else
  2476				udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
  2477	#if IS_ENABLED(CONFIG_IPV6)
> 2478			switch (vxlan->cfg.label_behavior) {
  2479			case VXLAN_LABEL_FIXED:
  2480				label = vxlan->cfg.label;
  2481				break;
  2482			case VXLAN_LABEL_INHERIT:
  2483				label = ip_tunnel_get_flowlabel(old_iph, skb);
  2484				break;
  2485			}
  2486	#endif
  2487		} else {
  2488			if (!info) {
  2489				WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
  2490					  dev->name);
  2491				goto drop;
  2492			}
  2493			remote_ip.sa.sa_family = ip_tunnel_info_af(info);
  2494			if (remote_ip.sa.sa_family == AF_INET) {
  2495				remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
  2496				local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
  2497			} else {
  2498				remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
  2499				local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
  2500			}
  2501			dst = &remote_ip;
  2502			dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
  2503			flow_flags = info->key.flow_flags;
  2504			vni = tunnel_id_to_key32(info->key.tun_id);
  2505			ifindex = 0;
  2506			dst_cache = &info->dst_cache;
  2507			if (info->key.tun_flags & TUNNEL_VXLAN_OPT) {
  2508				if (info->options_len < sizeof(*md))
  2509					goto drop;
  2510				md = ip_tunnel_info_opts(info);
  2511			}
  2512			ttl = info->key.ttl;
  2513			tos = info->key.tos;
  2514	#if IS_ENABLED(CONFIG_IPV6)
  2515			label = info->key.label;
  2516	#endif
  2517			udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
  2518		}
  2519		src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
  2520					     vxlan->cfg.port_max, true);
  2521	
  2522		rcu_read_lock();
  2523		if (dst->sa.sa_family == AF_INET) {
  2524			struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
  2525			struct rtable *rt;
  2526			__be16 df = 0;
  2527	
  2528			if (!ifindex)
  2529				ifindex = sock4->sock->sk->sk_bound_dev_if;
  2530	
  2531			rt = vxlan_get_route(vxlan, dev, sock4, skb, ifindex, tos,
  2532					     dst->sin.sin_addr.s_addr,
  2533					     &local_ip.sin.sin_addr.s_addr,
  2534					     dst_port, src_port, flow_flags,
  2535					     dst_cache, info);
  2536			if (IS_ERR(rt)) {
  2537				err = PTR_ERR(rt);
  2538				goto tx_error;
  2539			}
  2540	
  2541			if (!info) {
  2542				/* Bypass encapsulation if the destination is local */
  2543				err = encap_bypass_if_local(skb, dev, vxlan, dst,
  2544							    dst_port, ifindex, vni,
  2545							    &rt->dst, rt->rt_flags);
  2546				if (err)
  2547					goto out_unlock;
  2548	
  2549				if (vxlan->cfg.df == VXLAN_DF_SET) {
  2550					df = htons(IP_DF);
  2551				} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
  2552					struct ethhdr *eth = eth_hdr(skb);
  2553	
  2554					if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
  2555					    (ntohs(eth->h_proto) == ETH_P_IP &&
  2556					     old_iph->frag_off & htons(IP_DF)))
  2557						df = htons(IP_DF);
  2558				}
  2559			} else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT) {
  2560				df = htons(IP_DF);
  2561			}
  2562	
  2563			ndst = &rt->dst;
  2564			err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
  2565						    netif_is_any_bridge_port(dev));
  2566			if (err < 0) {
  2567				goto tx_error;
  2568			} else if (err) {
  2569				if (info) {
  2570					struct ip_tunnel_info *unclone;
  2571					struct in_addr src, dst;
  2572	
  2573					unclone = skb_tunnel_info_unclone(skb);
  2574					if (unlikely(!unclone))
  2575						goto tx_error;
  2576	
  2577					src = remote_ip.sin.sin_addr;
  2578					dst = local_ip.sin.sin_addr;
  2579					unclone->key.u.ipv4.src = src.s_addr;
  2580					unclone->key.u.ipv4.dst = dst.s_addr;
  2581				}
  2582				vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
  2583				dst_release(ndst);
  2584				goto out_unlock;
  2585			}
  2586	
  2587			tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
  2588			ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
  2589			err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
  2590					      vni, md, flags, udp_sum);
  2591			if (err < 0)
  2592				goto tx_error;
  2593	
  2594			udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
  2595					    dst->sin.sin_addr.s_addr, tos, ttl, df,
  2596					    src_port, dst_port, xnet, !udp_sum);
  2597	#if IS_ENABLED(CONFIG_IPV6)
  2598		} else {
  2599			struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
  2600	
  2601			if (!ifindex)
  2602				ifindex = sock6->sock->sk->sk_bound_dev_if;
  2603	
  2604			ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
  2605						label, &dst->sin6.sin6_addr,
  2606						&local_ip.sin6.sin6_addr,
  2607						dst_port, src_port,
  2608						dst_cache, info);
  2609			if (IS_ERR(ndst)) {
  2610				err = PTR_ERR(ndst);
  2611				ndst = NULL;
  2612				goto tx_error;
  2613			}
  2614	
  2615			if (!info) {
  2616				u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
  2617	
  2618				err = encap_bypass_if_local(skb, dev, vxlan, dst,
  2619							    dst_port, ifindex, vni,
  2620							    ndst, rt6i_flags);
  2621				if (err)
  2622					goto out_unlock;
  2623			}
  2624	
  2625			err = skb_tunnel_check_pmtu(skb, ndst,
  2626						    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
  2627						    netif_is_any_bridge_port(dev));
  2628			if (err < 0) {
  2629				goto tx_error;
  2630			} else if (err) {
  2631				if (info) {
  2632					struct ip_tunnel_info *unclone;
  2633					struct in6_addr src, dst;
  2634	
  2635					unclone = skb_tunnel_info_unclone(skb);
  2636					if (unlikely(!unclone))
  2637						goto tx_error;
  2638	
  2639					src = remote_ip.sin6.sin6_addr;
  2640					dst = local_ip.sin6.sin6_addr;
  2641					unclone->key.u.ipv6.src = src;
  2642					unclone->key.u.ipv6.dst = dst;
  2643				}
  2644	
  2645				vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
  2646				dst_release(ndst);
  2647				goto out_unlock;
  2648			}
  2649	
  2650			tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
  2651			ttl = ttl ? : ip6_dst_hoplimit(ndst);
  2652			skb_scrub_packet(skb, xnet);
  2653			err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
  2654					      vni, md, flags, udp_sum);
  2655			if (err < 0)
  2656				goto tx_error;
  2657	
  2658			udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
  2659					     &local_ip.sin6.sin6_addr,
  2660					     &dst->sin6.sin6_addr, tos, ttl,
  2661					     label, src_port, dst_port, !udp_sum);
  2662	#endif
  2663		}
  2664		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
  2665	out_unlock:
  2666		rcu_read_unlock();
  2667		return;
  2668	
  2669	drop:
  2670		dev->stats.tx_dropped++;
  2671		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
  2672		dev_kfree_skb(skb);
  2673		return;
  2674	
  2675	tx_error:
  2676		rcu_read_unlock();
  2677		if (err == -ELOOP)
  2678			dev->stats.collisions++;
  2679		else if (err == -ENETUNREACH)
  2680			dev->stats.tx_carrier_errors++;
  2681		dst_release(ndst);
  2682		dev->stats.tx_errors++;
  2683		vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
  2684		kfree_skb(skb);
  2685	}
  2686	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

