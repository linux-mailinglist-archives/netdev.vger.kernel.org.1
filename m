Return-Path: <netdev+bounces-299776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xF6FFw4MMWo5awUAu9opvQ
	(envelope-from <netdev+bounces-299776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC068D3CC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:40:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tdwwc878;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299776-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24583311AFF0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21A4192EC;
	Tue, 16 Jun 2026 08:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EEB29346F;
	Tue, 16 Jun 2026 08:36:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598987; cv=none; b=eL+vCGgKPxc7ZnzapBmF4Wq7DPGeD/hxTTziF6ioDUH50WyRyHCyrGWuaBDnjZMkog8CrSeQ3zblqMc3FKm1yjowAZKratViEDJDWh0jsP6/dGeFKzx2mXlJtWRZJUiS6B4CZ2EIadBckDP9WLGIKMSyzkT6WDNd27KxRBpSbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598987; c=relaxed/simple;
	bh=SLZZQmz+y+z3sYw9KTsj1HA/XfSmlCJneuqma7S6TtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJyTPR6NpY33lG8xwEuAAy2cMckzNb04KVsjqxrVdbKhEb/iyRR/Q3kR5HKlGl+02RxtTX1JiZYjUvjRIX4UvpY5MnW8AEmbgOC07obg2oD4ZCutmJZT2QHOlzV/ootcEo6Kdza4LN4OI5BuK2ngDSzRJiVRjVOYpMxEcLBqhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdwwc878; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CAA1F00A3A;
	Tue, 16 Jun 2026 08:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598985;
	bh=ojmesv8lh21yy6WM9TyVNXKriBJJCfHR3EPDi/IwAI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tdwwc878P51RzhXH6f9nmTRJPp9QhlIAlm+CQ6bs+vX7UR3nE3+4EZu1MTTjaCWoa
	 KgQfnqB+zZNLayNZI9SwHPunPm52PYfm0kJ1Nd0vFHqB9IE1ZjlMemgkuD4ZTOfTsX
	 f/MXFIOuHOTowUgOX7MkkKXxfNfKeIfLT2ZsQxhB8s4xhCVQSv6Lzbr3mKTlVr6gFg
	 hXk9nUCRgRTNIyYHKarfevvhrIwWwOi1NN1TMlaWEpyx3Fa5BFoxTM/HTTXhImqCPF
	 FrbqHXEMXiYhET4wMNJDw42/uB2jJS47YYwyO2HZSExT4xTaQ2FJNloXZlUw6C+SSR
	 IWfvC/lZpXhLQ==
Message-ID: <1879b506-64cb-495b-8857-6f40b411f209@kernel.org>
Date: Tue, 16 Jun 2026 10:36:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Luigi Rizzo <lrizzo@google.com>, rizzo.unipi@gmail.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
 kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260615234220.3946885-1-lrizzo@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[david@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[google.com,gmail.com,samsung.com,arm.com,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299776-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABEC068D3CC

On 6/16/26 01:42, Luigi Rizzo wrote:
> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> especially with greedy senders, this has a high chance of happening in
> the softirq handler for tx network interrupts, creating a significant
> performance bottleneck.
> 
> Allow tx sockets to allocate socket buffers directly from the bounce
> buffers. This avoids the second copy and removes the above bottleneck.
> The fraction of swiotlb buffers allowed for this feature is set with
>    /sys/module/swiotlb/parameters/zerocopy_tx_percent
> (0 means disabled, 90 is the maximum, to avoid persistent I/O failures).
> 
> Implementation:
> - define a new page type to unambiguously identify bounce buffers used
>   as backing storage for socket buffers
> - modify skb_page_frag_refill to perform the modified allocation
> - modify the destructors __free_frozen_pages(), free_unref_folio() to
>   handle those pages and return them to the pool.
> 
> The savings are especially visible with fewer queues. In synthetic
> benchmarks, senders with 1-2 queues would cap around 50Gbps with
> conventional swiotlb, and reach over 170Gbps with the feature enabled.
> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  drivers/base/core.c        |   1 +
>  include/linux/netdevice.h  |  22 ++++
>  include/linux/page-flags.h |   4 +
>  include/linux/skbuff.h     |   7 +-
>  include/linux/swiotlb.h    |  74 ++++++++++++
>  include/net/sock.h         |  29 +++++
>  kernel/dma/swiotlb.c       | 227 +++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c            |  32 ++++++
>  net/core/sock.c            |  98 ++++++++++++++--
>  9 files changed, 485 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index bd2ddf2aab505..e1257dea37ba0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3855,6 +3855,7 @@ void device_del(struct device *dev)
>  	unsigned int noio_flag;
>  
>  	device_lock(dev);
> +	swiotlb_device_deleted();
>  	kill_device(dev);
>  	device_unlock(dev);
>  
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0e1e581efc5ac..d7e5929e73c92 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5368,13 +5368,35 @@ static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
>  	return ops->ndo_start_xmit(skb, dev);
>  }
>  
> +struct sock;
> +
> +#ifdef CONFIG_SWIOTLB
> +/* Per-CPU pointer to the socket currently performing transmission.
> + * Used to bridge the networking and DMA layers, allowing the dma_map_page()
> + * path to identify the socket originating the packet and apply SWIOTLB optimizations.
> + */
> +DECLARE_PER_CPU(struct sock *, current_tx_socket);
> +static inline struct sock *__set_current_tx_socket(struct sock *sk)
> +{
> +	struct sock *old_sk = this_cpu_read(current_tx_socket);
> +
> +	this_cpu_write(current_tx_socket, sk);
> +	return old_sk;
> +}
> +#else
> +static inline struct sock *__set_current_tx_socket(struct sock *sk) { return NULL; }
> +#endif
> +
>  static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct net_device *dev,
>  					    struct netdev_queue *txq, bool more)
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
> +	struct sock *old_sk;
>  	netdev_tx_t rc;
>  
> +	old_sk = __set_current_tx_socket(skb->sk);
>  	rc = __netdev_start_xmit(ops, skb, dev, more);
> +	__set_current_tx_socket(old_sk);
>  	if (rc == NETDEV_TX_OK)
>  		txq_trans_update(dev, txq);
>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7223f6f4e2b40..0ecbb404038a0 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -923,6 +923,7 @@ enum pagetype {
>  	PGTY_zsmalloc		= 0xf6,
>  	PGTY_unaccepted		= 0xf7,
>  	PGTY_large_kmalloc	= 0xf8,
> +	PGTY_zcswiotlb		= 0xf9,
>  
>  	PGTY_mapcount_underflow = 0xff
>  };
> @@ -1055,6 +1056,9 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
>  
> +/* Pages in socket buffers from the swiotlb pool. */
> +PAGE_TYPE_OPS(ZCSwiotlb, zcswiotlb, zcswiotlb)
> +
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 3f06254ab1b72..62340909409e5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3787,7 +3787,12 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
>  	fragto->netmem = fragfrom->netmem;
>  }
>  
> -bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
> +/* zerocopy swiotlb uses an additional non-null struct sock pointer. */
> +bool __skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio, struct sock *sk);
> +static inline bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio)
> +{
> +	return __skb_page_frag_refill(sz, pfrag, prio, NULL);
> +}
>  
>  /**
>   * __skb_frag_dma_map - maps a paged fragment via the DMA API
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063e..bd2d0e160a9d8 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -7,8 +7,10 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/limits.h>
> +#include <linux/percpu.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
> +#include <linux/atomic.h>
>  
>  struct device;
>  struct page;
> @@ -122,6 +124,9 @@ struct io_tlb_mem {
>  	atomic_long_t total_used;
>  	atomic_long_t used_hiwater;
>  	atomic_long_t transient_nslabs;
> +#else
> +	unsigned long last_used_slots;
> +	unsigned long last_used_jiffies;
>  #endif
>  };
>  
> @@ -185,6 +190,69 @@ bool is_swiotlb_active(struct device *dev);
>  void __init swiotlb_adjust_size(unsigned long size);
>  phys_addr_t default_swiotlb_base(void);
>  phys_addr_t default_swiotlb_limit(void);
> +
> +/* Helpers for zerocopy swiotlb. */
> +/* Control allocation fraction. */
> +extern unsigned int swiotlb_zc_tx_percent;
> +
> +/* Track freshness of the leaf device info. */
> +extern atomic_t global_device_serial;
> +
> +static inline u32 swiotlb_get_device_serial(void)
> +{
> +	return atomic_read(&global_device_serial);
> +}
> +
> +static inline void swiotlb_device_deleted(void)
> +{
> +	atomic_inc(&global_device_serial);
> +}
> +
> +struct page *swiotlb_alloc_pages(struct device *dev, unsigned int order);
> +bool swiotlb_free_pages(struct page *page, bool where_debug_only);
> +void swiotlb_safe_put_device(struct device *dev);
> +
> +static inline void swiotlb_set_page_dev(struct page *page, struct device *dev)
> +{
> +	page->private = (unsigned long)dev;
> +}
> +
> +static inline struct device *swiotlb_page_to_dev(struct page *page)
> +{
> +	return (struct device *)compound_head(page)->private;
> +}
> +
> +static inline bool is_zerocopy_swiotlb_folio(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	return folio_test_zcswiotlb(folio) && folio->private != 0;
> +}
> +
> +/* These two are in mm/page_alloc.c */
> +void swiotlb_prep_compound_page(struct page *page, unsigned int order);
> +void swiotlb_destroy_compound_page(struct page *page, unsigned int order);
> +
> +#if defined(CONFIG_NET)
> +/*
> + * Track the socket for the currently transmitted packet, so the dma mapping
> + * function can record there the leaf device if it needs bounce buffers.
> + */
> +struct sock;
> +DECLARE_PER_CPU(struct sock *, current_tx_socket);
> +void sk_set_bounce_device(struct sock *sk, struct device *dev);
> +static inline void dma_learn_bounce_device(struct device *dev)
> +{
> +	struct sock *sk = this_cpu_read(current_tx_socket);
> +
> +	if (sk)
> +		sk_set_bounce_device(sk, dev);
> +}
> +#else
> +static inline void dma_learn_bounce_device(struct device *dev) {}
> +#endif
> +/* End helpers for zerocopy swiotlb. */
> +
>  #else
>  static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
>  {
> @@ -234,6 +302,12 @@ static inline phys_addr_t default_swiotlb_limit(void)
>  {
>  	return 0;
>  }
> +
> +/* zerocopy swiotlb stubs */
> +static inline bool swiotlb_free_pages(struct page *page, int reason) { return false; }
> +static inline u32 swiotlb_get_device_serial(void) { return 0; }
> +static inline void swiotlb_device_deleted(void) {}
> +
>  #endif /* CONFIG_SWIOTLB */
>  
>  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index dccd3738c3687..1e6caf4bd1366 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -47,6 +47,7 @@
>  #include <linux/skbuff.h>	/* struct sk_buff */
>  #include <linux/mm.h>
>  #include <linux/security.h>
> +#include <linux/swiotlb.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/page_counter.h>
> @@ -70,6 +71,14 @@
>  #include <net/l3mdev.h>
>  #include <uapi/linux/socket.h>
>  
> +#ifdef CONFIG_SWIOTLB
> +struct sk_swiotlb_info {
> +	struct device		*dev;
> +	u32			serial;
> +	unsigned long		jiffies;
> +};
> +#endif
> +
>  /*
>   * This structure really needs to be cleaned up.
>   * Most of it is for TCP, and not used by any of
> @@ -602,8 +611,28 @@ struct sock {
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>  	struct module		*sk_owner;
>  #endif
> +#ifdef CONFIG_SWIOTLB
> +	struct sk_swiotlb_info	sk_swiotlb;
> +#endif
>  };
>  
> +#ifdef CONFIG_SWIOTLB
> +static inline void sk_init_bounce_device(struct sock *sk)
> +{
> +	sk->sk_swiotlb.dev = NULL;
> +}
> +static inline void sk_cleanup_bounce_device(struct sock *sk)
> +{
> +	if (sk->sk_swiotlb.dev) {
> +		swiotlb_safe_put_device(sk->sk_swiotlb.dev);
> +		sk->sk_swiotlb.dev = NULL;
> +	}
> +}
> +#else
> +static inline void sk_init_bounce_device(struct sock *sk) {}
> +static inline void sk_cleanup_bounce_device(struct sock *sk) {}
> +#endif
> +
>  struct sock_bh_locked {
>  	struct sock *sock;
>  	local_lock_t bh_lock;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f45..e27f23d03c482 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -37,12 +37,16 @@
>  #include <linux/mm.h>
>  #include <linux/pfn.h>
>  #include <linux/rculist.h>
> +#include <linux/refcount.h>
>  #include <linux/scatterlist.h>
>  #include <linux/set_memory.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/swiotlb.h>
> +#include <linux/moduleparam.h>
> +#include <linux/percpu.h>
>  #include <linux/types.h>
> +#include <linux/atomic.h>
>  #ifdef CONFIG_DMA_RESTRICTED_POOL
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> @@ -81,6 +85,17 @@ struct io_tlb_slot {
>  static bool swiotlb_force_bounce;
>  static bool swiotlb_force_disable;
>  
> +/**
> + * global_device_serial - Global sequence number for device deletions
> + *
> + * Incremented every time a device is unregistered (in device_del()).
> + * Used by subsystems (like SWIOTLB zero-copy sockets) as a fast, lockless
> + * O(1) cache invalidation serial to detect when a cached device pointer
> + * might have been deleted and needs to be expired to prevent Use-After-Free.
> + */
> +atomic_t global_device_serial = ATOMIC_INIT(0);
> +EXPORT_SYMBOL(global_device_serial);
> +
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  
>  static void swiotlb_dyn_alloc(struct work_struct *work);
> @@ -1442,6 +1457,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	offset &= (IO_TLB_SIZE - 1);
>  	index += pad_slots;
>  	pool->slots[index].pad_slots = pad_slots;
> +	/* Fix an upstream bug with alloc_align_mask = 0xffff */
> +	pool->slots[index].alloc_size = mapping_size;
>  	for (i = 0; i < (nr_slots(size) - pad_slots); i++)
>  		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
>  	tlb_addr = slot_addr(pool->start, index) + offset;
> @@ -1554,6 +1571,13 @@ void __swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
>  		size_t mapping_size, enum dma_data_direction dir,
>  		unsigned long attrs, struct io_tlb_pool *pool)
>  {
> +	/*
> +	 * Recognize and avoid unmapping pages allocated for Zero-Copy SWIOTLB Page Bypass.
> +	 * They will be eventually released when the page reference count drops to 0.
> +	 */
> +	if (is_zerocopy_swiotlb_folio(pfn_to_page(PHYS_PFN(tlb_addr))))
> +		return;
> +
>  	/*
>  	 * First, sync the memory before unmapping the entry
>  	 */
> @@ -1597,6 +1621,21 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  	phys_addr_t swiotlb_addr;
>  	dma_addr_t dma_addr;
>  
> +	dma_learn_bounce_device(dev);
> +
> +	/*
> +	 * If the page was allocated via Zero-Copy SWIOTLB Page Bypass, it is likely
> +	 * already good for DMA so we can return its dma address.
> +	 */
> +	if (is_zerocopy_swiotlb_folio(pfn_to_page(PHYS_PFN(paddr)))) {
> +		dma_addr = phys_to_dma_unencrypted(dev, paddr);
> +		if (likely(dma_capable(dev, dma_addr, size, true))) {
> +			if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +				arch_sync_dma_for_device(paddr, size, dir);
> +			return dma_addr;
> +		}
> +	}
> +
>  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
>  
>  	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
> @@ -1899,3 +1938,191 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
>  
>  RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", &rmem_swiotlb_ops);
>  #endif /* CONFIG_DMA_RESTRICTED_POOL */
> +
> +/*
> + * Asynchronous/Deferred Device Release.
> + * put_device() can trigger the final release path of a device which may sleep.
> + * Since SWIOTLB pages can be freed in atomic or interrupt context (e.g. TX completion),
> + * we must defer the put_device() call to task context using a workqueue.
> + */
> +struct swiotlb_deferred_put {
> +	struct work_struct work;
> +	struct device *dev;
> +};
> +
> +static void swiotlb_deferred_put_work(struct work_struct *work)
> +{
> +	struct swiotlb_deferred_put *dp = container_of(work, struct swiotlb_deferred_put, work);
> +
> +	put_device(dp->dev);
> +	kfree(dp);
> +}
> +
> +/**
> + * swiotlb_safe_put_device() - Safely release device reference from atomic/interrupt context
> + * @dev: The device structure to release.
> + *
> + * Enqueues a deferred put_device() call on a workqueue using GFP_ATOMIC.
> + * If memory allocation fails, the reference is leaked to avoid an immediate crash.
> + */
> +void swiotlb_safe_put_device(struct device *dev)
> +{
> +	struct swiotlb_deferred_put *dp;
> +
> +	if (!dev)
> +		return;
> +
> +	/*
> +	 * FAST PATH (O(1) lockless): If this is not the last reference,
> +	 * we can decrement it atomically and safely in any context
> +	 * without allocating memory or scheduling work!
> +	 */
> +	if (refcount_dec_not_one(&dev->kobj.kref.refcount))
> +		return;
> +
> +	/*
> +	 * SLOW PATH: It is the last reference (refcount == 1). We must
> +	 * defer the final put_device() to task context because it will
> +	 * trigger device_release() which can sleep.
> +	 */
> +	dp = kmalloc_obj(*dp, GFP_ATOMIC);
> +	if (dp) {
> +		INIT_WORK(&dp->work, swiotlb_deferred_put_work);
> +		dp->dev = dev;
> +		schedule_work(&dp->work);
> +	} else {
> +		pr_warn_ratelimited("swiotlb: failed to allocate deferred put, leaking device ref\n");
> +	}
> +}
> +EXPORT_SYMBOL_GPL(swiotlb_safe_put_device);
> +
> +unsigned int swiotlb_zc_tx_percent;
> +module_param_named(zerocopy_tx_percent, swiotlb_zc_tx_percent, uint, 0644);
> +
> +static unsigned long fast_mem_used(struct io_tlb_mem *mem)
> +{
> +#ifdef CONFIG_DEBUG_FS
> +	return mem_used(mem);
> +#else
> +	unsigned long last_j = READ_ONCE(mem->last_used_jiffies);
> +	unsigned long now = jiffies;
> +
> +	if (time_after(now, last_j + HZ / 100) &&
> +	    try_cmpxchg(&mem->last_used_jiffies, &last_j, now)) {
> +		WRITE_ONCE(mem->last_used_slots, mem_used(mem));
> +	}
> +	return READ_ONCE(mem->last_used_slots);
> +#endif
> +}
> +
> +/**
> + * swiotlb_alloc_pages() - Allocate long-lived contiguous pages from SWIOTLB pool
> + * @dev: Device which requires the SWIOTLB bounce buffers.
> + * @order: Allocation order (log2 of number of pages).
> + */
> +struct page *swiotlb_alloc_pages(struct device *dev, unsigned int order)
> +{
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_pool *pool;
> +	int npages = 1 << order;
> +	unsigned int max_pct;
> +	phys_addr_t tlb_addr;
> +	struct page *page;
> +	int index;
> +
> +	if (!mem || !mem->nslabs)
> +		return NULL;
> +
> +	max_pct = clamp(READ_ONCE(swiotlb_zc_tx_percent), 0u, 90u);
> +	if (max_pct == 0 || max_pct * mem->nslabs <= fast_mem_used(mem) * 100)
> +		return NULL;
> +
> +	/*
> +	 * Enforce natural alignment for compound pages. The mask-based
> +	 * compound_head() optimization (used when HVO is enabled and struct page
> +	 * size is a power of 2) assumes that compound pages are naturally aligned
> +	 * to their size. Without this, compound_head() on tail pages can return
> +	 * a wrong head page pointer, leading to refcount corruption.
> +	 */
> +	index = swiotlb_find_slots(dev, 0, PAGE_SIZE * npages, ~(PAGE_MASK << order), &pool);
> +	if (index == -1)
> +		return NULL;
> +
> +	tlb_addr = slot_addr(pool->start, index);
> +
> +	pool->slots[index].pad_slots = 0;
> +	pool->slots[index].alloc_size = PAGE_SIZE * npages;
> +
> +	page = pfn_to_page(PHYS_PFN(tlb_addr));
> +
> +	set_page_count(page, 1);
> +
> +	/* Strictly tag page[0] to prevent clobbering folio tail overlays */
> +	__SetPageZCSwiotlb(page);
> +
> +	swiotlb_set_page_dev(page, dev);
> +	get_device(dev);
> +	swiotlb_prep_compound_page(page, order);
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(swiotlb_alloc_pages);
> +
> +/*
> + * Debugging to track how swiotlb_free_pages() was called.
> + * b2: 0 from __free_frozen_pages(), 1 from free_unref_folios()
> + * b1: pool found b0: dev present,
> + */
> +static unsigned long zc_debug[8];
> +static int ctrs_num = 8;
> +module_param_array(zc_debug, ulong, &ctrs_num, 0644);
> +static void __zc_debug_stats(bool where, bool has_dev, bool has_pool)
> +{
> +	zc_debug[has_dev + has_pool * 2 + where * 4]++;
> +}
> +
> +/**
> + * swiotlb_free_pages() - Free pages allocated via swiotlb_alloc_pages()
> + * @page: The starting struct page to release.
> + */
> +bool swiotlb_free_pages(struct page *page, bool where_debug_only)
> +{
> +	struct page *head = compound_head(page);
> +	struct device *dev = swiotlb_page_to_dev(head);
> +	phys_addr_t head_tlb_addr = page_to_phys(head);
> +	struct io_tlb_pool *pool;
> +	int index, npages, i;
> +
> +	if (!folio_test_zcswiotlb(page_folio(head)))
> +		return false;
> +
> +	pool = dev ? swiotlb_find_pool(dev, head_tlb_addr) : NULL;
> +	__zc_debug_stats(where_debug_only, !!dev, !!pool);
> +
> +	/* Check for any false positives. */
> +	if (!pool)
> +		return false;
> +
> +	/* Read alloc_size first, it is reset by swiotlb_release_slots(). */
> +	index = (head_tlb_addr - pool->start) >> IO_TLB_SHIFT;
> +	npages = pool->slots[index].alloc_size >> PAGE_SHIFT;
> +
> +	WARN_ON_ONCE(!is_power_of_2(npages));
> +
> +	/* Step 1: Sever compound links (clobbers compound_info / lru.next) */
> +	swiotlb_destroy_compound_page(head, ilog2(npages));
> +
> +	/* Step 2: Re-init LRU, drop refcounts, and strip flag across all constituent pages */
> +	for (i = 0; i < npages; i++) {
> +		INIT_LIST_HEAD(&head[i].lru);
> +		set_page_count(&head[i], 0);
> +		head[i].private = 0;
> +		__ClearPageZCSwiotlb(&head[i]);
> +	}
> +
> +	/* Step 3: Safely release slots back to the pool */
> +	swiotlb_release_slots(dev, head_tlb_addr, pool);
> +	swiotlb_del_transient(dev, head_tlb_addr, pool);
> +	swiotlb_safe_put_device(dev);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(swiotlb_free_pages);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d49c254174da7..eaba683b5b2a8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/stddef.h>
>  #include <linux/mm.h>
> +#include <linux/swiotlb.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
> @@ -705,6 +706,31 @@ void prep_compound_page(struct page *page, unsigned int order)
>  	prep_compound_head(page, order);
>  }
>  
> +#ifdef CONFIG_SWIOTLB
> +void swiotlb_prep_compound_page(struct page *page, unsigned int order)
> +{
> +	if (order > 0)
> +		prep_compound_page(page, order);
> +}

Gah.

> +
> +void swiotlb_destroy_compound_page(struct page *page, unsigned int order)
> +{
> +	if (order > 0) {
> +		struct folio *folio = (struct folio *)page;
> +
> +		__ClearPageHead(page);
> +		page[1].flags.f &= ~PAGE_FLAGS_SECOND;
> +#ifdef NR_PAGES_IN_LARGE_FOLIO
> +		folio->_nr_pages = 0;
> +#endif
> +		for (int i = 1; i < (1 << order); i++) {
> +			page[i].mapping = NULL;
> +			clear_compound_head(&page[i]);
> +		}
> +	}
> +}

Gah.

> +#endif /* CONFIG_SWIOTLB */
> +
>  static inline void set_buddy_order(struct page *page, unsigned int order)
>  {
>  	set_page_private(page, order);
> @@ -2930,6 +2956,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
>  	unsigned long pfn = page_to_pfn(page);
>  	int migratetype;
>  
> +	if (unlikely(swiotlb_free_pages(page, false)))
> +		return;
> +

Oh my.

We shouldn't be handling randomg swiotlb stuff in the page allocator like that.

IIUC, you are writing your own pool+allocator and roughly mimic what hugetlb +
ZONE_DEVICE does.

The creation+destruction of compound pages should very likely be factored out
from other code in a type-unspecific fashion, if really required.

You should probably look into

https://lore.kernel.org/all/20250318161823.4005529-2-tabba@google.com/

to see how to possibly hook into the page freeing path in a cleaner way.

-- 
Cheers,

David

