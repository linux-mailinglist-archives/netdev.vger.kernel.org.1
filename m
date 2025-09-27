Return-Path: <netdev+bounces-226874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264EABA5C07
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9824C53ED
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC72D5A07;
	Sat, 27 Sep 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Exow2PEa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC01C84A1;
	Sat, 27 Sep 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964177; cv=none; b=iT5NCxqK4wTaxy/PgWVGfjoaZVDcjsqfTqKZf3M32IkXFRlqY5CHG7UfQaJkUe6IrYbB1Ci5GWjSt7ew2ZuLFpWWvvVYB4SLRYa/4KisjFpq+UgdU2d0vd0Ef6YJnhvaFZ1mXAWRb1AXiIPY71L08cSucxEuDOLJ7qr4QWmWGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964177; c=relaxed/simple;
	bh=bgLz2Q8IGkVURM2vwwZtTD+xMEuboxjsSTJPJ8/YM4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOc1fogRgHHFvE3tikyjLfRJAdCx8VNpLm4dxLd97T/qQXlH2dGhzI/VDD8fk2KkDq43J+mpFWz5mchVe4qHc6JTthfVAoM0IlPBU12OYbA6fuTFcRy8HL6kA+LuMtwLy4ReMlXbcP7yI6cYSa6gXu4AtPpFUH2I2+2B20+jNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Exow2PEa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758964176; x=1790500176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bgLz2Q8IGkVURM2vwwZtTD+xMEuboxjsSTJPJ8/YM4g=;
  b=Exow2PEaH940A2X3q5FoW1pg4WceuRK1O5mMIO7gaNV/e5TQ84HM2FlD
   qhGEdU7HfnZau7+AsvEJKWAFY6maqi3jmaFi8O3Bekna1Fd1iaeEdZhCN
   N2dohdOtxkjWKSbi0C2sH//lX/qtsSNJKGC2WAbLdBu/n2Vn1NKUbC9lZ
   JfC6FhJbbwNxmIrUgNcmE15+iE6rZ1duo/nLuufC33lDHGTSav23Uigqf
   MdduEp2zmhoCCvWOfe0khRf4n8kTSbzeMz9THSQ2eJBYl0kw3MVkYcOOS
   wpaLul5nO2TtSX0CRNMVgBz1QZ4C2InNs5ZTm3e/iyIUMdyrZJ2/59T/M
   g==;
X-CSE-ConnectionGUID: jBckMAU2T+qIrI8N0NNuHg==
X-CSE-MsgGUID: w7kZdrf5T2epVwAwnDKJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="71899159"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="71899159"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 02:09:35 -0700
X-CSE-ConnectionGUID: hI3lECv0SUqeS40yeKe0wA==
X-CSE-MsgGUID: Dtir0f5uQOyOo9i6GgzZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="182100562"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 27 Sep 2025 02:09:31 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2Qvp-0006wB-0G;
	Sat, 27 Sep 2025 09:09:29 +0000
Date: Sat, 27 Sep 2025 17:08:33 +0800
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
Subject: Re: [PATCH net-next v4 2/2] net: devmem: use niov array for token
 management
Message-ID: <202509271623.I36w4Uqo-lkp@intel.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>

Hi Bobby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 203e3beb73e53584ca90bc2a6d8240b9b12b9bcf]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/net-devmem-rename-tx_vec-to-vec-in-dmabuf-binding/20250927-003521
base:   203e3beb73e53584ca90bc2a6d8240b9b12b9bcf
patch link:    https://lore.kernel.org/r/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea%40meta.com
patch subject: [PATCH net-next v4 2/2] net: devmem: use niov array for token management
config: x86_64-buildonly-randconfig-005-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271623.I36w4Uqo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271623.I36w4Uqo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271623.I36w4Uqo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_recvmsg_dmabuf':
>> net/ipv4/tcp.c:2473:32: warning: unused variable 'len' [-Wunused-variable]
    2473 |                         size_t len;
         |                                ^~~
>> net/ipv4/tcp.c:2472:32: warning: unused variable 'size' [-Wunused-variable]
    2472 |                         size_t size;
         |                                ^~~~


vim +/len +2473 net/ipv4/tcp.c

  2409	
  2410	/* On error, returns the -errno. On success, returns number of bytes sent to the
  2411	 * user. May not consume all of @remaining_len.
  2412	 */
  2413	static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
  2414				      unsigned int offset, struct msghdr *msg,
  2415				      int remaining_len)
  2416	{
  2417		struct dmabuf_cmsg dmabuf_cmsg = { 0 };
  2418		unsigned int start;
  2419		int i, copy, n;
  2420		int sent = 0;
  2421		int err = 0;
  2422	
  2423		do {
  2424			start = skb_headlen(skb);
  2425	
  2426			if (skb_frags_readable(skb)) {
  2427				err = -ENODEV;
  2428				goto out;
  2429			}
  2430	
  2431			/* Copy header. */
  2432			copy = start - offset;
  2433			if (copy > 0) {
  2434				copy = min(copy, remaining_len);
  2435	
  2436				n = copy_to_iter(skb->data + offset, copy,
  2437						 &msg->msg_iter);
  2438				if (n != copy) {
  2439					err = -EFAULT;
  2440					goto out;
  2441				}
  2442	
  2443				offset += copy;
  2444				remaining_len -= copy;
  2445	
  2446				/* First a dmabuf_cmsg for # bytes copied to user
  2447				 * buffer.
  2448				 */
  2449				memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
  2450				dmabuf_cmsg.frag_size = copy;
  2451				err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2452						       SO_DEVMEM_LINEAR,
  2453						       sizeof(dmabuf_cmsg),
  2454						       &dmabuf_cmsg);
  2455				if (err)
  2456					goto out;
  2457	
  2458				sent += copy;
  2459	
  2460				if (remaining_len == 0)
  2461					goto out;
  2462			}
  2463	
  2464			/* after that, send information of dmabuf pages through a
  2465			 * sequence of cmsg
  2466			 */
  2467			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
  2468				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
  2469				struct net_devmem_dmabuf_binding *binding;
  2470				struct net_iov *niov;
  2471				u64 frag_offset;
> 2472				size_t size;
> 2473				size_t len;
  2474				u32 token;
  2475				int end;
  2476	
  2477				/* !skb_frags_readable() should indicate that ALL the
  2478				 * frags in this skb are dmabuf net_iovs. We're checking
  2479				 * for that flag above, but also check individual frags
  2480				 * here. If the tcp stack is not setting
  2481				 * skb_frags_readable() correctly, we still don't want
  2482				 * to crash here.
  2483				 */
  2484				if (!skb_frag_net_iov(frag)) {
  2485					net_err_ratelimited("Found non-dmabuf skb with net_iov");
  2486					err = -ENODEV;
  2487					goto out;
  2488				}
  2489	
  2490				niov = skb_frag_net_iov(frag);
  2491				if (!net_is_devmem_iov(niov)) {
  2492					err = -ENODEV;
  2493					goto out;
  2494				}
  2495	
  2496				end = start + skb_frag_size(frag);
  2497				copy = end - offset;
  2498	
  2499				if (copy > 0) {
  2500					copy = min(copy, remaining_len);
  2501	
  2502					frag_offset = net_iov_virtual_addr(niov) +
  2503						      skb_frag_off(frag) + offset -
  2504						      start;
  2505					dmabuf_cmsg.frag_offset = frag_offset;
  2506					dmabuf_cmsg.frag_size = copy;
  2507	
  2508					binding = net_devmem_iov_binding(niov);
  2509	
  2510					if (!sk->sk_devmem_binding)
  2511						sk->sk_devmem_binding = binding;
  2512	
  2513					if (sk->sk_devmem_binding != binding) {
  2514						err = -EFAULT;
  2515						goto out;
  2516					}
  2517	
  2518					token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
  2519					dmabuf_cmsg.frag_token = token;
  2520	
  2521					/* Will perform the exchange later */
  2522					dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
  2523	
  2524					offset += copy;
  2525					remaining_len -= copy;
  2526	
  2527					err = put_cmsg_notrunc(msg, SOL_SOCKET,
  2528							       SO_DEVMEM_DMABUF,
  2529							       sizeof(dmabuf_cmsg),
  2530							       &dmabuf_cmsg);
  2531					if (err)
  2532						goto out;
  2533	
  2534					if (atomic_inc_return(&niov->uref) == 1)
  2535						atomic_long_inc(&niov->pp_ref_count);
  2536	
  2537					sent += copy;
  2538	
  2539					if (remaining_len == 0)
  2540						goto out;
  2541				}
  2542				start = end;
  2543			}
  2544	
  2545			if (!remaining_len)
  2546				goto out;
  2547	
  2548			/* if remaining_len is not satisfied yet, we need to go to the
  2549			 * next frag in the frag_list to satisfy remaining_len.
  2550			 */
  2551			skb = skb_shinfo(skb)->frag_list ?: skb->next;
  2552	
  2553			offset = offset - start;
  2554		} while (skb);
  2555	
  2556		if (remaining_len) {
  2557			err = -EFAULT;
  2558			goto out;
  2559		}
  2560	
  2561	out:
  2562		if (!sent)
  2563			sent = err;
  2564	
  2565		return sent;
  2566	}
  2567	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

