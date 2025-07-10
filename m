Return-Path: <netdev+bounces-205681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC77AFFADC
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A953A64213E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93146288C8D;
	Thu, 10 Jul 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1fIFzEa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88C2882B4;
	Thu, 10 Jul 2025 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132515; cv=none; b=C68iA16//NElLPPGBWPPxwtWHa69cYLmhsHW2NNVGR3/juMNHHiOaVYdZJtYeWyvh/Wr5BF0Z8sj5AKuxD7QNRj13ShJj7dsotWh0f2mEPzXoJ+lxMn8f4eSBpsPmtVE1DE51B+8Io5SXKolWPZXO8L+D8/ZFoxwCOwZO/xbp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132515; c=relaxed/simple;
	bh=q8aajeMJr0YFcHtfckwDFxnJGjYHirD2U5daz/hfiyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTKRghdElSMq6VqoTYYUhqK0rWwgwZMTNTqS+WOrKBUmN6Y82CSZGwlKhwIoD1SVCrTv/DxJU47ztTeemTBbYRZ5u/2SrpBMSpeMdNyBrIIH3PZdvQNL6Mcgun6h9V9hORxuIX0sF/aUWX+0/wsk7pNPzcC3UEc86xg+KyoF9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1fIFzEa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752132514; x=1783668514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8aajeMJr0YFcHtfckwDFxnJGjYHirD2U5daz/hfiyw=;
  b=e1fIFzEagPwKaSBa5yDs5L7R7JI7yIXyWYWikwfaKIcuS327mnWHNodT
   FdPuZ8MjXJp4+q/tBSnoacvdiI8d4QfsYSnIHmWVlgFdX6dX++S2z90lA
   pMsmacedLDlyIyL8rcXaRKNc42/yPrIxbZe0v0KOVdksLw7L+Mn5WmLoI
   /lNb7pzzYUznAfEDfVgXQ+IXfRadO8xDdwedW7kPxfcBleJHc5wbvuZ1Z
   d1LGHDhoAgsbMHGEaBfuXD93eIfedSAdfkzyc7poTqiyucAxmyBz8J+Pm
   UrTtlk+F+9mms377UXHHvyjQWn9uWdVVkSq2HbWqcjfhLUhwGN7BnYi6X
   A==;
X-CSE-ConnectionGUID: I+cDDrd9TxSPGWQ4xVPaOA==
X-CSE-MsgGUID: wcLRnfeaSiy0hbqNyTUr3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54531569"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54531569"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:28:33 -0700
X-CSE-ConnectionGUID: vr85dqWcS/S3xtlKLeUf7g==
X-CSE-MsgGUID: wCqDWvxSSMuPwoC2T8lxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186970578"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jul 2025 00:28:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZlhk-0004gJ-1w;
	Thu, 10 Jul 2025 07:28:28 +0000
Date: Thu, 10 Jul 2025 15:27:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yun Lu <luyun_611@163.com>, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
Message-ID: <202507101547.Li8m6iCU-lkp@intel.com>
References: <20250709095653.62469-3-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709095653.62469-3-luyun_611@163.com>

Hi Yun,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.16-rc5 next-20250709]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yun-Lu/af_packet-fix-the-SO_SNDTIMEO-constraint-not-effective-on-tpacked_snd/20250709-175915
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250709095653.62469-3-luyun_611%40163.com
patch subject: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by tpacket_snd()
config: i386-buildonly-randconfig-001-20250710 (https://download.01.org/0day-ci/archive/20250710/202507101547.Li8m6iCU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250710/202507101547.Li8m6iCU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507101547.Li8m6iCU-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/packet/af_packet.c: In function 'tpacket_snd':
>> net/packet/af_packet.c:2956:37: error: expected ';' before 'err'
    2956 |         } while (likely(ph != NULL))
         |                                     ^
         |                                     ;
    2957 | 
    2958 |         err = len_sum;
         |         ~~~                          


vim +2956 net/packet/af_packet.c

  2769	
  2770	static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
  2771	{
  2772		struct sk_buff *skb = NULL;
  2773		struct net_device *dev;
  2774		struct virtio_net_hdr *vnet_hdr = NULL;
  2775		struct sockcm_cookie sockc;
  2776		__be16 proto;
  2777		int err, reserve = 0;
  2778		void *ph;
  2779		DECLARE_SOCKADDR(struct sockaddr_ll *, saddr, msg->msg_name);
  2780		bool need_wait = !(msg->msg_flags & MSG_DONTWAIT);
  2781		int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
  2782		unsigned char *addr = NULL;
  2783		int tp_len, size_max;
  2784		void *data;
  2785		int len_sum = 0;
  2786		int status = TP_STATUS_AVAILABLE;
  2787		int hlen, tlen, copylen = 0;
  2788		long timeo;
  2789	
  2790		mutex_lock(&po->pg_vec_lock);
  2791	
  2792		/* packet_sendmsg() check on tx_ring.pg_vec was lockless,
  2793		 * we need to confirm it under protection of pg_vec_lock.
  2794		 */
  2795		if (unlikely(!po->tx_ring.pg_vec)) {
  2796			err = -EBUSY;
  2797			goto out;
  2798		}
  2799		if (likely(saddr == NULL)) {
  2800			dev	= packet_cached_dev_get(po);
  2801			proto	= READ_ONCE(po->num);
  2802		} else {
  2803			err = -EINVAL;
  2804			if (msg->msg_namelen < sizeof(struct sockaddr_ll))
  2805				goto out;
  2806			if (msg->msg_namelen < (saddr->sll_halen
  2807						+ offsetof(struct sockaddr_ll,
  2808							sll_addr)))
  2809				goto out;
  2810			proto	= saddr->sll_protocol;
  2811			dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
  2812			if (po->sk.sk_socket->type == SOCK_DGRAM) {
  2813				if (dev && msg->msg_namelen < dev->addr_len +
  2814					   offsetof(struct sockaddr_ll, sll_addr))
  2815					goto out_put;
  2816				addr = saddr->sll_addr;
  2817			}
  2818		}
  2819	
  2820		err = -ENXIO;
  2821		if (unlikely(dev == NULL))
  2822			goto out;
  2823		err = -ENETDOWN;
  2824		if (unlikely(!(dev->flags & IFF_UP)))
  2825			goto out_put;
  2826	
  2827		sockcm_init(&sockc, &po->sk);
  2828		if (msg->msg_controllen) {
  2829			err = sock_cmsg_send(&po->sk, msg, &sockc);
  2830			if (unlikely(err))
  2831				goto out_put;
  2832		}
  2833	
  2834		if (po->sk.sk_socket->type == SOCK_RAW)
  2835			reserve = dev->hard_header_len;
  2836		size_max = po->tx_ring.frame_size
  2837			- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
  2838	
  2839		if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
  2840			size_max = dev->mtu + reserve + VLAN_HLEN;
  2841	
  2842		timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
  2843		reinit_completion(&po->skb_completion);
  2844	
  2845		do {
  2846			ph = packet_current_frame(po, &po->tx_ring,
  2847						  TP_STATUS_SEND_REQUEST);
  2848			if (unlikely(ph == NULL)) {
  2849				/* Note: packet_read_pending() might be slow if we
  2850				 * have to call it as it's per_cpu variable, but in
  2851				 * fast-path we don't have to call it, only when ph
  2852				 * is NULL, we need to check pending_refcnt.
  2853				 */
  2854				if (need_wait && packet_read_pending(&po->tx_ring)) {
  2855					timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
  2856					if (timeo <= 0) {
  2857						err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
  2858						goto out_put;
  2859					} else {
  2860						/* Just reuse ph to continue for the next iteration, and
  2861						 * ph will be reassigned at the start of the next iteration.
  2862						 */
  2863						ph = (void *)1;
  2864					}
  2865				}
  2866				/* check for additional frames */
  2867				continue;
  2868			}
  2869	
  2870			skb = NULL;
  2871			tp_len = tpacket_parse_header(po, ph, size_max, &data);
  2872			if (tp_len < 0)
  2873				goto tpacket_error;
  2874	
  2875			status = TP_STATUS_SEND_REQUEST;
  2876			hlen = LL_RESERVED_SPACE(dev);
  2877			tlen = dev->needed_tailroom;
  2878			if (vnet_hdr_sz) {
  2879				vnet_hdr = data;
  2880				data += vnet_hdr_sz;
  2881				tp_len -= vnet_hdr_sz;
  2882				if (tp_len < 0 ||
  2883				    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
  2884					tp_len = -EINVAL;
  2885					goto tpacket_error;
  2886				}
  2887				copylen = __virtio16_to_cpu(vio_le(),
  2888							    vnet_hdr->hdr_len);
  2889			}
  2890			copylen = max_t(int, copylen, dev->hard_header_len);
  2891			skb = sock_alloc_send_skb(&po->sk,
  2892					hlen + tlen + sizeof(struct sockaddr_ll) +
  2893					(copylen - dev->hard_header_len),
  2894					!need_wait, &err);
  2895	
  2896			if (unlikely(skb == NULL)) {
  2897				/* we assume the socket was initially writeable ... */
  2898				if (likely(len_sum > 0))
  2899					err = len_sum;
  2900				goto out_status;
  2901			}
  2902			tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
  2903						  addr, hlen, copylen, &sockc);
  2904			if (likely(tp_len >= 0) &&
  2905			    tp_len > dev->mtu + reserve &&
  2906			    !vnet_hdr_sz &&
  2907			    !packet_extra_vlan_len_allowed(dev, skb))
  2908				tp_len = -EMSGSIZE;
  2909	
  2910			if (unlikely(tp_len < 0)) {
  2911	tpacket_error:
  2912				if (packet_sock_flag(po, PACKET_SOCK_TP_LOSS)) {
  2913					__packet_set_status(po, ph,
  2914							TP_STATUS_AVAILABLE);
  2915					packet_increment_head(&po->tx_ring);
  2916					kfree_skb(skb);
  2917					continue;
  2918				} else {
  2919					status = TP_STATUS_WRONG_FORMAT;
  2920					err = tp_len;
  2921					goto out_status;
  2922				}
  2923			}
  2924	
  2925			if (vnet_hdr_sz) {
  2926				if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
  2927					tp_len = -EINVAL;
  2928					goto tpacket_error;
  2929				}
  2930				virtio_net_hdr_set_proto(skb, vnet_hdr);
  2931			}
  2932	
  2933			skb->destructor = tpacket_destruct_skb;
  2934			__packet_set_status(po, ph, TP_STATUS_SENDING);
  2935			packet_inc_pending(&po->tx_ring);
  2936	
  2937			status = TP_STATUS_SEND_REQUEST;
  2938			err = packet_xmit(po, skb);
  2939			if (unlikely(err != 0)) {
  2940				if (err > 0)
  2941					err = net_xmit_errno(err);
  2942				if (err && __packet_get_status(po, ph) ==
  2943					   TP_STATUS_AVAILABLE) {
  2944					/* skb was destructed already */
  2945					skb = NULL;
  2946					goto out_status;
  2947				}
  2948				/*
  2949				 * skb was dropped but not destructed yet;
  2950				 * let's treat it like congestion or err < 0
  2951				 */
  2952				err = 0;
  2953			}
  2954			packet_increment_head(&po->tx_ring);
  2955			len_sum += tp_len;
> 2956		} while (likely(ph != NULL))
  2957	
  2958		err = len_sum;
  2959		goto out_put;
  2960	
  2961	out_status:
  2962		__packet_set_status(po, ph, status);
  2963		kfree_skb(skb);
  2964	out_put:
  2965		dev_put(dev);
  2966	out:
  2967		mutex_unlock(&po->pg_vec_lock);
  2968		return err;
  2969	}
  2970	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

