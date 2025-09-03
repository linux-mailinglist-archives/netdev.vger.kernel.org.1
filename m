Return-Path: <netdev+bounces-219529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF756B41C60
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADF23B5E11
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB702F39A2;
	Wed,  3 Sep 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtZFcIYS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64B2F39D3;
	Wed,  3 Sep 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896773; cv=none; b=aGzSTAvIEMPvYOZP9cQSrehD02QRm3dcvltJGtCIfr2X0djneKmuwzl6j9AC1Kw8EZORx9MTlfUqsWXibAaHLBrfKqtPt4KKOzv30m9hjku0isudwekdie73aupNWvDCnfhhBrogfeVvT4QgQqXQTTVOfQTD6lZ2D4UByCT6XKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896773; c=relaxed/simple;
	bh=HGjnf8eVllcIUSL3TnUPNDJIjvbpjCLHddwGD9q4Uzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8/uetctbpRNy4ad3AnpUJIsmVN4cRwKLn/WpYhv+INDa7vztk1VqHK20VR/9IDcabDLHaCfkxlsthvzn3hZf2+beqyORNLRJDOJy++9va2L2MK6Ly74jBY0+KkpdWmmckY+U3N9+R4Y4E4lWlbp/x/xvT4+XaYL0kN8Uwi8nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtZFcIYS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756896772; x=1788432772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HGjnf8eVllcIUSL3TnUPNDJIjvbpjCLHddwGD9q4Uzc=;
  b=ZtZFcIYSzR0CYRBkd2HnSV3xsBMJdqPobDNlDNrT1NM+2wccwMd1R3bZ
   UlBtac5/g8jRYZ56I86pu5Yy3V7h54GCfXm+Ryvt7mG9ShhjukL5/6YLG
   Vqx/3FVXXtDM8A8Iqq5yvz6cNPL99G9iDnh5bQ63UL7mWhjdi0tVWCFGk
   ZcqIQde/c+kY5oY1aYuVznYCcgJJjdkYehVjSkhO+qwZT9H6LLj8eRvTY
   /X/WgX3LW03pRcYJW0yU4lpa9mLBiLLPzNoZ+TDGMA3NxIXai0it/xnWk
   9utHHGujBT30G65cftQyMRM/x9LPYg/RayjCR+5OH6VFH44hTAwhju5oD
   A==;
X-CSE-ConnectionGUID: NuQ5+UKtSi6n13m4Za9MNg==
X-CSE-MsgGUID: Bw48pVLWRNmMv4kqEPrwnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76806445"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="76806445"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:52:31 -0700
X-CSE-ConnectionGUID: 8GSnf1gKQ16GwFnFpq3bKQ==
X-CSE-MsgGUID: 2dz0rNFeQAuUw/Pkn4bkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171701529"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Sep 2025 03:51:34 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utl4b-0003l5-10;
	Wed, 03 Sep 2025 10:51:04 +0000
Date: Wed, 3 Sep 2025 18:50:32 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/2] net: devmem: use niov array for token
 management
Message-ID: <202509031855.54vuvsX1-lkp@intel.com>
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>

Hi Bobby,

kernel test robot noticed the following build errors:

[auto build test ERROR on cd8a4cfa6bb43a441901e82f5c222dddc75a18a3]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/net-devmem-rename-tx_vec-to-vec-in-dmabuf-binding/20250903-054553
base:   cd8a4cfa6bb43a441901e82f5c222dddc75a18a3
patch link:    https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550%40meta.com
patch subject: [PATCH net-next 2/2] net: devmem: use niov array for token management
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250903/202509031855.54vuvsX1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031855.54vuvsX1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031855.54vuvsX1-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_recvmsg_dmabuf':
>> net/ipv4/tcp.c:2502:41: error: implicit declaration of function 'net_devmem_dmabuf_binding_get'; did you mean 'net_devmem_dmabuf_binding_put'? [-Werror=implicit-function-declaration]
    2502 |                                         net_devmem_dmabuf_binding_get(binding);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                         net_devmem_dmabuf_binding_put
   cc1: some warnings being treated as errors


vim +2502 net/ipv4/tcp.c

  2390	
  2391	/* On error, returns the -errno. On success, returns number of bytes sent to the
  2392	 * user. May not consume all of @remaining_len.
  2393	 */
  2394	static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
  2395				      unsigned int offset, struct msghdr *msg,
  2396				      int remaining_len)
  2397	{
  2398		struct dmabuf_cmsg dmabuf_cmsg = { 0 };
  2399		unsigned int start;
  2400		int i, copy, n;
  2401		int sent = 0;
  2402		int err = 0;
  2403	
  2404		do {
  2405			start = skb_headlen(skb);
  2406	
  2407			if (skb_frags_readable(skb)) {
  2408				err = -ENODEV;
  2409				goto out;
  2410			}
  2411	
  2412			/* Copy header. */
  2413			copy = start - offset;
  2414			if (copy > 0) {
  2415				copy = min(copy, remaining_len);
  2416	
  2417				n = copy_to_iter(skb->data + offset, copy,
  2418						 &msg->msg_iter);
  2419				if (n != copy) {
  2420					err = -EFAULT;
  2421					goto out;
  2422				}
  2423	
  2424				offset += copy;
  2425				remaining_len -= copy;
  2426	
  2427				/* First a dmabuf_cmsg for # bytes copied to user
  2428				 * buffer.
  2429				 */
  2430				memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
  2431				dmabuf_cmsg.frag_size = copy;
  2432				err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2433						       SO_DEVMEM_LINEAR,
  2434						       sizeof(dmabuf_cmsg),
  2435						       &dmabuf_cmsg);
  2436				if (err)
  2437					goto out;
  2438	
  2439				sent += copy;
  2440	
  2441				if (remaining_len == 0)
  2442					goto out;
  2443			}
  2444	
  2445			/* after that, send information of dmabuf pages through a
  2446			 * sequence of cmsg
  2447			 */
  2448			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
  2449				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
  2450				struct net_devmem_dmabuf_binding *binding;
  2451				struct net_iov *niov;
  2452				u64 frag_offset;
  2453				size_t size;
  2454				u32 token;
  2455				int end;
  2456	
  2457				/* !skb_frags_readable() should indicate that ALL the
  2458				 * frags in this skb are dmabuf net_iovs. We're checking
  2459				 * for that flag above, but also check individual frags
  2460				 * here. If the tcp stack is not setting
  2461				 * skb_frags_readable() correctly, we still don't want
  2462				 * to crash here.
  2463				 */
  2464				if (!skb_frag_net_iov(frag)) {
  2465					net_err_ratelimited("Found non-dmabuf skb with net_iov");
  2466					err = -ENODEV;
  2467					goto out;
  2468				}
  2469	
  2470				niov = skb_frag_net_iov(frag);
  2471				if (!net_is_devmem_iov(niov)) {
  2472					err = -ENODEV;
  2473					goto out;
  2474				}
  2475	
  2476				end = start + skb_frag_size(frag);
  2477				copy = end - offset;
  2478	
  2479				if (copy > 0) {
  2480					copy = min(copy, remaining_len);
  2481	
  2482					frag_offset = net_iov_virtual_addr(niov) +
  2483						      skb_frag_off(frag) + offset -
  2484						      start;
  2485					dmabuf_cmsg.frag_offset = frag_offset;
  2486					dmabuf_cmsg.frag_size = copy;
  2487	
  2488					binding = net_devmem_iov_binding(niov);
  2489	
  2490					if (!sk->sk_user_frags.binding) {
  2491						sk->sk_user_frags.binding = binding;
  2492	
  2493						size = binding->dmabuf->size / PAGE_SIZE;
  2494						sk->sk_user_frags.urefs = kzalloc(size,
  2495										  GFP_KERNEL);
  2496						if (!sk->sk_user_frags.urefs) {
  2497							sk->sk_user_frags.binding = NULL;
  2498							err = -ENOMEM;
  2499							goto out;
  2500						}
  2501	
> 2502						net_devmem_dmabuf_binding_get(binding);
  2503					}
  2504	
  2505					if (WARN_ONCE(sk->sk_user_frags.binding != binding,
  2506						      "binding changed for devmem socket")) {
  2507						err = -EFAULT;
  2508						goto out;
  2509					}
  2510	
  2511					token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
  2512					binding->vec[token] = niov;
  2513					dmabuf_cmsg.frag_token = token;
  2514	
  2515					/* Will perform the exchange later */
  2516					dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
  2517	
  2518					offset += copy;
  2519					remaining_len -= copy;
  2520	
  2521					err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2522							       SO_DEVMEM_DMABUF,
  2523							       sizeof(dmabuf_cmsg),
  2524							       &dmabuf_cmsg);
  2525					if (err)
  2526						goto out;
  2527	
  2528					atomic_inc(&sk->sk_user_frags.urefs[token]);
  2529	
  2530					atomic_long_inc(&niov->pp_ref_count);
  2531	
  2532					sent += copy;
  2533	
  2534					if (remaining_len == 0)
  2535						goto out;
  2536				}
  2537				start = end;
  2538			}
  2539	
  2540			if (!remaining_len)
  2541				goto out;
  2542	
  2543			/* if remaining_len is not satisfied yet, we need to go to the
  2544			 * next frag in the frag_list to satisfy remaining_len.
  2545			 */
  2546			skb = skb_shinfo(skb)->frag_list ?: skb->next;
  2547	
  2548			offset = offset - start;
  2549		} while (skb);
  2550	
  2551		if (remaining_len) {
  2552			err = -EFAULT;
  2553			goto out;
  2554		}
  2555	
  2556	out:
  2557		if (!sent)
  2558			sent = err;
  2559	
  2560		return sent;
  2561	}
  2562	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

