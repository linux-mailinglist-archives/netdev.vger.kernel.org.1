Return-Path: <netdev+bounces-90329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF08ADC2B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E901C2145A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5581C290;
	Tue, 23 Apr 2024 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGtAHaPK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC328E11
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842279; cv=none; b=JydK7mOCP2Vbu/VPKgStndh66a3jQbj8zflfgHAyk+9Bw8EkO4/dKJ1Wuo4JtlrRexEqKniFzHt/KKDppwft1bfUo99kvLRqOArhn/8mvGSM9MR+WuiJw4/RmzDby+/vLV7zXP9uqJIIeTeymnw4nowzep/m5SP9gMmaW0VbMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842279; c=relaxed/simple;
	bh=5NyETiuUNiI5yBX+/T8bgRzkki8qG0vVBWbCeePh+K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD36xFCzHXcXLqICRbAfVM1GIBNiInBlxxqvkr4lXTJrrn1nOzKQZ05i80pPKiUF9Yd06WaeymX0l5ddwv6hIG60LyZafYP3XuO+1sW6futDZOobnLvlxZZ6iKU0FpegKhmBzNqfd6frSpXpoPWgtlG0X2SiywTEI8VX+pfPGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGtAHaPK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713842277; x=1745378277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NyETiuUNiI5yBX+/T8bgRzkki8qG0vVBWbCeePh+K4=;
  b=UGtAHaPK1yE5fMGBqksUY+LDNS4KH1wlU1/ViT3ArLbLH1df6osA+FDL
   7t2C9VUkWriPkpHclIrU17k++zPPY/Np1pbS1TLtIVPNKTM0YRG66QuDD
   RiJtoQB9basuHpE8nCKRHIjqcx9Hk7cDXktlzg14+tAvIYR4nX2+o9ANO
   nl9qQ+Rw8FE8u8mQG2gVOrBeNhW/hqsaEjAPlEIdYCguQvfzSfdgBc8T2
   xc0Ngf9GrSy/FsmXZqzr9hX0k5zxww5KWkT50dPx8bGQ4Vt+sb1YzeiYz
   xywu2dM5OvjVgSCshjz6XPY41TjSBkB9LHfjEe2LugXKy5jYL9On5frot
   A==;
X-CSE-ConnectionGUID: 2kgog7HhQMup2fTyCclecg==
X-CSE-MsgGUID: qzjf+epkSwiB24brEakwug==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9575190"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9575190"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:17:57 -0700
X-CSE-ConnectionGUID: sCyjL2OlSDeHYULpNBeV3g==
X-CSE-MsgGUID: PVNLxawFTXeQjD0vdQ+vnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24736410"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Apr 2024 20:17:53 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz6fG-0000Rg-32;
	Tue, 23 Apr 2024 03:17:50 +0000
Date: Tue, 23 Apr 2024 11:16:58 +0800
From: kernel test robot <lkp@intel.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, cong.wang@bytedance.com, xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v2 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Message-ID: <202404231145.7NfmE7Hn-lkp@intel.com>
References: <20240419214819.671536-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419214819.671536-3-zijianzhang@bytedance.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/zijianzhang-bytedance-com/selftests-fix-OOM-problem-in-msg_zerocopy-selftest/20240420-055035
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240419214819.671536-3-zijianzhang%40bytedance.com
patch subject: [PATCH net-next v2 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
config: i386-randconfig-061-20240423 (https://download.01.org/0day-ci/archive/20240423/202404231145.7NfmE7Hn-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240423/202404231145.7NfmE7Hn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404231145.7NfmE7Hn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/sock.c:2864:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *usr_addr @@     got void * @@
   net/core/sock.c:2864:26: sparse:     expected void [noderef] __user *usr_addr
   net/core/sock.c:2864:26: sparse:     got void *
   net/core/sock.c:2393:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2397:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:4103:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:4115:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit

vim +2864 net/core/sock.c

  2807	
  2808	int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
  2809			     struct sockcm_cookie *sockc)
  2810	{
  2811		u32 tsflags;
  2812		int ret, zc_info_size, i = 0;
  2813		unsigned long flags;
  2814		struct sk_buff_head *q, local_q;
  2815		struct sk_buff *skb, *tmp;
  2816		struct sock_exterr_skb *serr;
  2817		struct zc_info_usr *zc_info_usr_p, *zc_info_kern_p;
  2818		void __user	*usr_addr;
  2819	
  2820		switch (cmsg->cmsg_type) {
  2821		case SO_MARK:
  2822			if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
  2823			    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
  2824				return -EPERM;
  2825			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2826				return -EINVAL;
  2827			sockc->mark = *(u32 *)CMSG_DATA(cmsg);
  2828			break;
  2829		case SO_TIMESTAMPING_OLD:
  2830		case SO_TIMESTAMPING_NEW:
  2831			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2832				return -EINVAL;
  2833	
  2834			tsflags = *(u32 *)CMSG_DATA(cmsg);
  2835			if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
  2836				return -EINVAL;
  2837	
  2838			sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
  2839			sockc->tsflags |= tsflags;
  2840			break;
  2841		case SCM_TXTIME:
  2842			if (!sock_flag(sk, SOCK_TXTIME))
  2843				return -EINVAL;
  2844			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
  2845				return -EINVAL;
  2846			sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
  2847			break;
  2848		/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
  2849		case SCM_RIGHTS:
  2850		case SCM_CREDENTIALS:
  2851			break;
  2852		case SO_ZC_NOTIFICATION:
  2853			if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
  2854				return -EINVAL;
  2855	
  2856			zc_info_usr_p = (struct zc_info_usr *)CMSG_DATA(cmsg);
  2857			if (zc_info_usr_p->length <= 0 || zc_info_usr_p->length > SOCK_ZC_INFO_MAX)
  2858				return -EINVAL;
  2859	
  2860			zc_info_size = struct_size(zc_info_usr_p, info, zc_info_usr_p->length);
  2861			if (cmsg->cmsg_len != CMSG_LEN(zc_info_size))
  2862				return -EINVAL;
  2863	
> 2864			usr_addr = (void *)(uintptr_t)(zc_info_usr_p->usr_addr);
  2865			if (!access_ok(usr_addr, zc_info_size))
  2866				return -EFAULT;
  2867	
  2868			zc_info_kern_p = kmalloc(zc_info_size, GFP_KERNEL);
  2869			if (!zc_info_kern_p)
  2870				return -ENOMEM;
  2871	
  2872			q = &sk->sk_error_queue;
  2873			skb_queue_head_init(&local_q);
  2874			spin_lock_irqsave(&q->lock, flags);
  2875			skb = skb_peek(q);
  2876			while (skb && i < zc_info_usr_p->length) {
  2877				struct sk_buff *skb_next = skb_peek_next(skb, q);
  2878	
  2879				serr = SKB_EXT_ERR(skb);
  2880				if (serr->ee.ee_errno == 0 &&
  2881				    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
  2882					zc_info_kern_p->info[i].hi = serr->ee.ee_data;
  2883					zc_info_kern_p->info[i].lo = serr->ee.ee_info;
  2884					zc_info_kern_p->info[i].zerocopy = !(serr->ee.ee_code
  2885									& SO_EE_CODE_ZEROCOPY_COPIED);
  2886					__skb_unlink(skb, q);
  2887					__skb_queue_tail(&local_q, skb);
  2888					i++;
  2889				}
  2890				skb = skb_next;
  2891			}
  2892			spin_unlock_irqrestore(&q->lock, flags);
  2893	
  2894			zc_info_kern_p->usr_addr = zc_info_usr_p->usr_addr;
  2895			zc_info_kern_p->length = i;
  2896	
  2897			ret = copy_to_user(usr_addr,
  2898					   zc_info_kern_p,
  2899						struct_size(zc_info_kern_p, info, i));
  2900			kfree(zc_info_kern_p);
  2901	
  2902			if (unlikely(ret)) {
  2903				spin_lock_irqsave(&q->lock, flags);
  2904				skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
  2905					__skb_unlink(skb, &local_q);
  2906					__skb_queue_head(q, skb);
  2907				}
  2908				spin_unlock_irqrestore(&q->lock, flags);
  2909				return -EFAULT;
  2910			}
  2911	
  2912			while ((skb = __skb_dequeue(&local_q)))
  2913				consume_skb(skb);
  2914			break;
  2915		default:
  2916			return -EINVAL;
  2917		}
  2918		return 0;
  2919	}
  2920	EXPORT_SYMBOL(__sock_cmsg_send);
  2921	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

