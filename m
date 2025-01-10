Return-Path: <netdev+bounces-157020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87127A08BF1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3DD188281C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8120A5C6;
	Fri, 10 Jan 2025 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ytFdGu7Z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108ED209F5B
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501147; cv=none; b=myRVqksof28p504uqkuDuXXXGfBt3bYzvHbP1ymDO+2se94hJ2F3nDnsMPkLKd8Utc1e85sMqVYi2lcNddSHs4itHi6fsfeM9WS8qw3dGgvPO5bJKodhdfAWhTl/ATEG36YY6OkW2rK+/Ya6tc74VzQ2SRarja1PkXlAHse6mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501147; c=relaxed/simple;
	bh=sJSCeD9ZJLdywJ2XH4gsW9T0C6p6RBrBl4564eOaqeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMWhf7kRjIOI3507AENKqEqQ7uxWfk54Yp//iWweRtgkoiVdaijxTBVfxwB2WWQG9caqX5XgDImecHZcqfaK+0zkzLSwo3r5Ve4h0tvusSHo40yxPTbzTbjx3RuOs9vpcD9LtufU1VUqWfNRCjpL6niTOR9I8mCYcNpJc2ZCfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ytFdGu7Z; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736501139; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Z56uFpttG0yM0sOaWplMv/n//evZ5Sf9x1uWoF6Ckgg=;
	b=ytFdGu7Zmw0/95bz3fOPVoytJSq0AaHsIzzmNj23Np2lki++IaKohdpJGthCcFajkskJLUhMZaVB16lZBjgxC3GYzV9CRPh7y4hreYQPQIRsHD/irSFQyTE5JaIgIYqQKKlBfZyuSBGyZkw0s16tgbfsnPIWdPeRjhImRJFT2Q4=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNKeu-Z_1736501137 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 17:25:38 +0800
Date: Fri, 10 Jan 2025 17:25:37 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and
 homa_sock.c
Message-ID: <20250110092537.GA66547@j66a10360.sqa.eu95>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
 <20250106181219.1075-8-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106181219.1075-8-ouster@cs.stanford.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 06, 2025 at 10:12:13AM -0800, John Ousterhout wrote:
> These files provide functions for managing the state that Homa keeps
> for each open Homa socket.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/homa/homa_sock.c | 382 ++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_sock.h | 406 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 788 insertions(+)
>  create mode 100644 net/homa/homa_sock.c
>  create mode 100644 net/homa/homa_sock.h
> 
> diff --git a/net/homa/homa_sock.c b/net/homa/homa_sock.c
> new file mode 100644
> index 000000000000..723752c6d055
> --- /dev/null
> +++ b/net/homa/homa_sock.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file manages homa_sock and homa_socktab objects. */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_pool.h"
> +
> +/*
> + * homa_sock_unlink() - Unlinks a socket from its socktab and does
> + * related cleanups. Once this method returns, the socket will not be
> + * discoverable through the socktab.
> + */
> +void homa_sock_unlink(struct homa_sock *hsk)
> +{
> +	struct homa_socktab *socktab = hsk->homa->port_map;
> +	struct homa_socktab_scan *scan;
> +
> +	/* If any scans refer to this socket, advance them to refer to
> +	 * the next socket instead.
> +	 */
> +	spin_lock_bh(&socktab->write_lock);
> +	list_for_each_entry(scan, &socktab->active_scans, scan_links) {
> +		if (!scan->next || scan->next->sock != hsk)
> +			continue;
> +		scan->next = (struct homa_socktab_links *)
> +				rcu_dereference(hlist_next_rcu(&scan->next->hash_links));
> +	}

I can't get it.. Why not just mark this sock as unavailable and skip it
when the iterator accesses it ?

The iterator was used under rcu and given that your sock has the
SOCK_RCU_FREE flag set, it appears that there should be no concerns
regarding dangling pointers.

> +	hlist_del_rcu(&hsk->socktab_links.hash_links);
> +	spin_unlock_bh(&socktab->write_lock);
> +}
> +
> +/**
> + * homa_sock_shutdown() - Disable a socket so that it can no longer
> + * be used for either sending or receiving messages. Any system calls
> + * currently waiting to send or receive messages will be aborted.
> + * @hsk:       Socket to shut down.
> + */
> +void homa_sock_shutdown(struct homa_sock *hsk)
> +	__acquires(&hsk->lock)
> +	__releases(&hsk->lock)
> +{
> +	struct homa_interest *interest;
> +	struct homa_rpc *rpc;
> +
> +	homa_sock_lock(hsk, "homa_socket_shutdown");
> +	if (hsk->shutdown) {
> +		homa_sock_unlock(hsk);
> +		return;
> +	}
> +
> +	/* The order of cleanup is very important, because there could be
> +	 * active operations that hold RPC locks but not the socket lock.
> +	 * 1. Set @shutdown; this ensures that no new RPCs will be created for
> +	 *    this socket (though some creations might already be in progress).
> +	 * 2. Remove the socket from its socktab: this ensures that
> +	 *    incoming packets for the socket will be dropped.
> +	 * 3. Go through all of the RPCs and delete them; this will
> +	 *    synchronize with any operations in progress.
> +	 * 4. Perform other socket cleanup: at this point we know that
> +	 *    there will be no concurrent activities on individual RPCs.
> +	 * 5. Don't delete the buffer pool until after all of the RPCs
> +	 *    have been reaped.
> +	 * See sync.txt for additional information about locking.
> +	 */
> +	hsk->shutdown = true;

From the actual usage of the shutdown member, I think you should use
sock_set_flag(SOCK_DEAD), and to check it with sock_flag(SOCK_DEAD).

> +	homa_sock_unlink(hsk);
> +	homa_sock_unlock(hsk);
> +
> +	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
> +		homa_rpc_lock(rpc, "homa_sock_shutdown");
> +		homa_rpc_free(rpc);
> +		homa_rpc_unlock(rpc);
> +	}
> +
> +	homa_sock_lock(hsk, "homa_socket_shutdown #2");
> +	list_for_each_entry(interest, &hsk->request_interests, request_links)
> +		wake_up_process(interest->thread);
> +	list_for_each_entry(interest, &hsk->response_interests, response_links)
> +		wake_up_process(interest->thread);
> +	homa_sock_unlock(hsk);
> +
> +	while (!list_empty(&hsk->dead_rpcs))
> +		homa_rpc_reap(hsk, 1000);

I take a quick look at homa_rpc_reap, although there is no possibility
of an infinite loop founded currently, it still raises concerns.

It might be better to let homa_rpc_reap() handle this kind of actions by itself.
For example, code like that:

homa_rpc_reap(hsk, 0, flags=RPC_FORCE_REAP|RPC_REAP_ALL);

In this way, anyone making modifications to homa_rpc_reap() in the future will
at least be aware that there is such a case that needs to be handled well.

> +	if (hsk->buffer_pool) {
> +		homa_pool_destroy(hsk->buffer_pool);
> +		kfree(hsk->buffer_pool);
> +		hsk->buffer_pool = NULL;
> +	}
> +}
> +
> +/**
> + * homa_sock_destroy() - Destructor for homa_sock objects. This function
> + * only cleans up the parts of the object that are owned by Homa.
> + * @hsk:       Socket to destroy.
> + */
> +void homa_sock_destroy(struct homa_sock *hsk)
> +{
> +	homa_sock_shutdown(hsk);
> +	sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);
> +}
> +
> +/**
> + * homa_sock_bind() - Associates a server port with a socket; if there
> + * was a previous server port assignment for @hsk, it is abandoned.
> + * @socktab:   Hash table in which the binding will be recorded.
> + * @hsk:       Homa socket.
> + * @port:      Desired server port for @hsk. If 0, then this call
> + *             becomes a no-op: the socket will continue to use
> + *             its randomly assigned client port.
> + *
> + * Return:  0 for success, otherwise a negative errno.
> + */
> +int homa_sock_bind(struct homa_socktab *socktab, struct homa_sock *hsk,
> +		   __u16 port)
> +{
> +	struct homa_sock *owner;
> +	int result = 0;
> +
> +	if (port == 0)
> +		return result;
> +	if (port >= HOMA_MIN_DEFAULT_PORT)
> +		return -EINVAL;
> +	homa_sock_lock(hsk, "homa_sock_bind");
> +	spin_lock_bh(&socktab->write_lock);
> +	if (hsk->shutdown) {
> +		result = -ESHUTDOWN;
> +		goto done;
> +	}
> +
> +	owner = homa_sock_find(socktab, port);
> +	if (owner) {
> +		if (owner != hsk)
> +			result = -EADDRINUSE;
> +		goto done;
> +	}
> +	hlist_del_rcu(&hsk->socktab_links.hash_links);
> +	hsk->port = port;
> +	hsk->inet.inet_num = port;
> +	hsk->inet.inet_sport = htons(hsk->port);
> +	hlist_add_head_rcu(&hsk->socktab_links.hash_links,
> +			   &socktab->buckets[homa_port_hash(port)]);
> +done:
> +	spin_unlock_bh(&socktab->write_lock);
> +	homa_sock_unlock(hsk);
> +	return result;
> +}
> +
> +/**
> + * homa_sock_find() - Returns the socket associated with a given port.
> + * @socktab:    Hash table in which to perform lookup.
> + * @port:       The port of interest.
> + * Return:      The socket that owns @port, or NULL if none.
> + *
> + * Note: this function uses RCU list-searching facilities, but it doesn't
> + * call rcu_read_lock. The caller should do that, if the caller cares (this
> + * way, the caller's use of the socket will also be protected).
> + */
> +struct homa_sock *homa_sock_find(struct homa_socktab *socktab,  __u16 port)
> +{
> +	struct homa_socktab_links *link;
> +	struct homa_sock *result = NULL;
> +
> +	hlist_for_each_entry_rcu(link, &socktab->buckets[homa_port_hash(port)],
> +				 hash_links) {
> +		struct homa_sock *hsk = link->sock;
> +
> +		if (hsk->port == port) {
> +			result = hsk;
> +			break;
> +		}
> +	}
> +	return result;
> +}
> +
> +/**
> + * homa_sock_lock_slow() - This function implements the slow path for
> + * acquiring a socketC lock. It is invoked when a socket lock isn't immediately
> + * available. It waits for the lock, but also records statistics about
> + * the waiting time.
> + * @hsk:    socket to  lock.
> + */
> +void homa_sock_lock_slow(struct homa_sock *hsk)
> +	__acquires(&hsk->lock)
> +{
> +	spin_lock_bh(&hsk->lock);
> +}
> +
> +/**
> + * homa_bucket_lock_slow() - This function implements the slow path for
> + * locking a bucket in one of the hash tables of RPCs. It is invoked when a
> + * lock isn't immediately available. It waits for the lock, but also records
> + * statistics about the waiting time.
> + * @bucket:    The hash table bucket to lock.
> + * @id:        ID of the particular RPC being locked (multiple RPCs may
> + *             share a single bucket lock).
> + */
> +void homa_bucket_lock_slow(struct homa_rpc_bucket *bucket, __u64 id)
> +	__acquires(&bucket->lock)
> +{
> +	spin_lock_bh(&bucket->lock);
> +}
> diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h
> new file mode 100644
> index 000000000000..635cbf54176e
> --- /dev/null
> +++ b/net/homa/homa_sock.h
> @@ -0,0 +1,406 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +
> +/* This file defines structs and other things related to Homa sockets.  */
> +
> +#ifndef _HOMA_SOCK_H
> +#define _HOMA_SOCK_H
> +
> +/* Forward declarations. */
> +struct homa;
> +struct homa_pool;
> +
> +void     homa_sock_lock_slow(struct homa_sock *hsk);
> +
> +/**
> + * define HOMA_SOCKTAB_BUCKETS - Number of hash buckets in a homa_socktab.
> + * Must be a power of 2.
> + */
> +#define HOMA_SOCKTAB_BUCKETS 1024
> +
> +/**
> + * struct homa_socktab - A hash table that maps from port numbers (either
> + * client or server) to homa_sock objects.
> + *
> + * This table is managed exclusively by homa_socktab.c, using RCU to
> + * minimize synchronization during lookups.
> + */
> +struct homa_socktab {
> +	/**
> +	 * @write_lock: Controls all modifications to this object; not needed
> +	 * for socket lookups (RCU is used instead). Also used to
> +	 * synchronize port allocation.
> +	 */
> +	spinlock_t write_lock;
> +
> +	/**
> +	 * @buckets: Heads of chains for hash table buckets. Chains
> +	 * consist of homa_socktab_link objects.
> +	 */
> +	struct hlist_head buckets[HOMA_SOCKTAB_BUCKETS];
> +
> +	/**
> +	 * @active_scans: List of homa_socktab_scan structs for all scans
> +	 * currently underway on this homa_socktab.
> +	 */
> +	struct list_head active_scans;
> +};
> +
> +/**
> + * struct homa_socktab_links - Used to link homa_socks into the hash chains
> + * of a homa_socktab.
> + */
> +struct homa_socktab_links {
> +	/** @hash_links: links this element into the hash chain. */
> +	struct hlist_node hash_links;
> +
> +	/** @sock: Homa socket structure. */
> +	struct homa_sock *sock;
> +};
> +
> +/**
> + * struct homa_socktab_scan - Records the state of an iteration over all
> + * the entries in a homa_socktab, in a way that permits RCU-safe deletion
> + * of entries.
> + */
> +struct homa_socktab_scan {
> +	/** @socktab: The table that is being scanned. */
> +	struct homa_socktab *socktab;
> +
> +	/**
> +	 * @current_bucket: the index of the bucket in socktab->buckets
> +	 * currently being scanned. If >= HOMA_SOCKTAB_BUCKETS, the scan
> +	 * is complete.
> +	 */
> +	int current_bucket;
> +
> +	/**
> +	 * @next: the next socket to return from homa_socktab_next (this
> +	 * socket has not yet been returned). NULL means there are no
> +	 * more sockets in the current bucket.
> +	 */
> +	struct homa_socktab_links *next;
> +
> +	/**
> +	 * @scan_links: Used to link this scan into @socktab->scans.
> +	 */
> +	struct list_head scan_links;
> +};
> +
> +/**
> + * struct homa_rpc_bucket - One bucket in a hash table of RPCs.
> + */
> +
> +struct homa_rpc_bucket {
> +	/**
> +	 * @lock: serves as a lock both for this bucket (e.g., when
> +	 * adding and removing RPCs) and also for all of the RPCs in
> +	 * the bucket. Must be held whenever manipulating an RPC in
> +	 * this bucket. This dual purpose permits clean and safe
> +	 * deletion and garbage collection of RPCs.
> +	 */
> +	spinlock_t lock;
> +
> +	/** @rpcs: list of RPCs that hash to this bucket. */
> +	struct hlist_head rpcs;
> +
> +	/**
> +	 * @id: identifier for this bucket, used in error messages etc.
> +	 * It's the index of the bucket within its hash table bucket
> +	 * array, with an additional offset to separate server and
> +	 * client RPCs.
> +	 */
> +	int id;
> +};
> +
> +/**
> + * define HOMA_CLIENT_RPC_BUCKETS - Number of buckets in hash tables for
> + * client RPCs. Must be a power of 2.
> + */
> +#define HOMA_CLIENT_RPC_BUCKETS 1024
> +
> +/**
> + * define HOMA_SERVER_RPC_BUCKETS - Number of buckets in hash tables for
> + * server RPCs. Must be a power of 2.
> + */
> +#define HOMA_SERVER_RPC_BUCKETS 1024
> +
> +/**
> + * struct homa_sock - Information about an open socket.
> + */
> +struct homa_sock {
> +	/* Info for other network layers. Note: IPv6 info (struct ipv6_pinfo
> +	 * comes at the very end of the struct, *after* Homa's data, if this
> +	 * socket uses IPv6).
> +	 */
> +	union {
> +		/** @sock: generic socket data; must be the first field. */
> +		struct sock sock;
> +
> +		/**
> +		 * @inet: generic Internet socket data; must also be the
> +		 first field (contains sock as its first member).
> +		 */
> +		struct inet_sock inet;
> +	};
> +
> +	/**
> +	 * @lock: Must be held when modifying fields such as interests
> +	 * and lists of RPCs. This lock is used in place of sk->sk_lock
> +	 * because it's used differently (it's always used as a simple
> +	 * spin lock).  See sync.txt for more on Homa's synchronization
> +	 * strategy.
> +	 */
> +	spinlock_t lock;
> +
> +	/**
> +	 * @last_locker: identifies the code that most recently acquired
> +	 * @lock successfully. Occasionally used for debugging.
> +	 */
> +	char *last_locker;
> +
> +	/**
> +	 * @protect_count: counts the number of calls to homa_protect_rpcs
> +	 * for which there have not yet been calls to homa_unprotect_rpcs.
> +	 * See sync.txt for more info.
> +	 */
> +	atomic_t protect_count;
> +
> +	/**
> +	 * @homa: Overall state about the Homa implementation. NULL
> +	 * means this socket has been deleted.
> +	 */
> +	struct homa *homa;
> +
> +	/** @shutdown: True means the socket is no longer usable. */
> +	bool shutdown;
> +
> +	/**
> +	 * @port: Port number: identifies this socket uniquely among all
> +	 * those on this node.
> +	 */
> +	__u16 port;
> +
> +	/**
> +	 * @ip_header_length: Length of IP headers for this socket (depends
> +	 * on IPv4 vs. IPv6).
> +	 */
> +	int ip_header_length;
> +
> +	/**
> +	 * @socktab_links: Links this socket into the homa_socktab
> +	 * based on @port.
> +	 */
> +	struct homa_socktab_links socktab_links;
> +
> +	/**
> +	 * @active_rpcs: List of all existing RPCs related to this socket,
> +	 * including both client and server RPCs. This list isn't strictly
> +	 * needed, since RPCs are already in one of the hash tables below,
> +	 * but it's more efficient for homa_timer to have this list
> +	 * (so it doesn't have to scan large numbers of hash buckets).
> +	 * The list is sorted, with the oldest RPC first. Manipulate with
> +	 * RCU so timer can access without locking.
> +	 */
> +	struct list_head active_rpcs;
> +
> +	/**
> +	 * @dead_rpcs: Contains RPCs for which homa_rpc_free has been
> +	 * called, but their packet buffers haven't yet been freed.
> +	 */
> +	struct list_head dead_rpcs;
> +
> +	/** @dead_skbs: Total number of socket buffers in RPCs on dead_rpcs. */
> +	int dead_skbs;
> +
> +	/**
> +	 * @waiting_for_bufs: Contains RPCs that are blocked because there
> +	 * wasn't enough space in the buffer pool region for their incoming
> +	 * messages. Sorted in increasing order of message length.
> +	 */
> +	struct list_head waiting_for_bufs;
> +
> +	/**
> +	 * @ready_requests: Contains server RPCs whose request message is
> +	 * in a state requiring attention from  a user process. The head is
> +	 * oldest, i.e. next to return.
> +	 */
> +	struct list_head ready_requests;
> +
> +	/**
> +	 * @ready_responses: Contains client RPCs whose response message is
> +	 * in a state requiring attention from a user process. The head is
> +	 * oldest, i.e. next to return.
> +	 */
> +	struct list_head ready_responses;
> +
> +	/**
> +	 * @request_interests: List of threads that want to receive incoming
> +	 * request messages.
> +	 */
> +	struct list_head request_interests;
> +
> +	/**
> +	 * @response_interests: List of threads that want to receive incoming
> +	 * response messages.
> +	 */
> +	struct list_head response_interests;
> +
> +	/**
> +	 * @client_rpc_buckets: Hash table for fast lookup of client RPCs.
> +	 * Modifications are synchronized with bucket locks, not
> +	 * the socket lock.
> +	 */
> +	struct homa_rpc_bucket client_rpc_buckets[HOMA_CLIENT_RPC_BUCKETS];
> +
> +	/**
> +	 * @server_rpc_buckets: Hash table for fast lookup of server RPCs.
> +	 * Modifications are synchronized with bucket locks, not
> +	 * the socket lock.
> +	 */
> +	struct homa_rpc_bucket server_rpc_buckets[HOMA_SERVER_RPC_BUCKETS];
> +
> +	/**
> +	 * @buffer_pool: used to allocate buffer space for incoming messages.
> +	 * Storage is dynamically allocated.
> +	 */
> +	struct homa_pool *buffer_pool;
> +};
> +
> +/**
> + * struct homa_v6_sock - For IPv6, additional IPv6-specific information
> + * is present in the socket struct after Homa-specific information.
> + */
> +struct homa_v6_sock {
> +	/** @homa: All socket info except for IPv6-specific stuff. */
> +	struct homa_sock homa;
> +
> +	/** @inet6: Socket info specific to IPv6. */
> +	struct ipv6_pinfo inet6;
> +};
> +
> +void               homa_bucket_lock_slow(struct homa_rpc_bucket *bucket,
> +					 __u64 id);
> +int                homa_sock_bind(struct homa_socktab *socktab,
> +				  struct homa_sock *hsk, __u16 port);
> +void               homa_sock_destroy(struct homa_sock *hsk);
> +struct homa_sock  *homa_sock_find(struct homa_socktab *socktab, __u16 port);
> +int                homa_sock_init(struct homa_sock *hsk, struct homa *homa);
> +void               homa_sock_shutdown(struct homa_sock *hsk);
> +void               homa_sock_unlink(struct homa_sock *hsk);
> +int                homa_socket(struct sock *sk);
> +void               homa_socktab_destroy(struct homa_socktab *socktab);
> +void               homa_socktab_end_scan(struct homa_socktab_scan *scan);
> +void               homa_socktab_init(struct homa_socktab *socktab);
> +struct homa_sock  *homa_socktab_next(struct homa_socktab_scan *scan);
> +struct homa_sock  *homa_socktab_start_scan(struct homa_socktab *socktab,
> +					   struct homa_socktab_scan *scan);
> +
> +/**
> + * homa_sock_lock() - Acquire the lock for a socket. If the socket
> + * isn't immediately available, record stats on the waiting time.
> + * @hsk:     Socket to lock.
> + * @locker:  Static string identifying where the socket was locked;
> + *           used to track down deadlocks.
> + */
> +static inline void homa_sock_lock(struct homa_sock *hsk, const char *locker)
> +	__acquires(&hsk->lock)
> +{
> +	if (!spin_trylock_bh(&hsk->lock))
> +		homa_sock_lock_slow(hsk);
> +}
> +
> +/**
> + * homa_sock_unlock() - Release the lock for a socket.
> + * @hsk:   Socket to lock.
> + */
> +static inline void homa_sock_unlock(struct homa_sock *hsk)
> +	__releases(&hsk->lock)
> +{
> +	spin_unlock_bh(&hsk->lock);
> +}
> +
> +/**
> + * homa_port_hash() - Hash function for port numbers.
> + * @port:   Port number being looked up.
> + *
> + * Return:  The index of the bucket in which this port will be found (if
> + *          it exists.
> + */
> +static inline int homa_port_hash(__u16 port)
> +{
> +	/* We can use a really simple hash function here because client
> +	 * port numbers are allocated sequentially and server port numbers
> +	 * are unpredictable.
> +	 */
> +	return port & (HOMA_SOCKTAB_BUCKETS - 1);
> +}
> +
> +/**
> + * homa_client_rpc_bucket() - Find the bucket containing a given
> + * client RPC.
> + * @hsk:      Socket associated with the RPC.
> + * @id:       Id of the desired RPC.
> + *
> + * Return:    The bucket in which this RPC will appear, if the RPC exists.
> + */
> +static inline struct homa_rpc_bucket *homa_client_rpc_bucket(struct homa_sock *hsk,
> +							     __u64 id)
> +{
> +	/* We can use a really simple hash function here because RPC ids
> +	 * are allocated sequentially.
> +	 */
> +	return &hsk->client_rpc_buckets[(id >> 1)
> +			& (HOMA_CLIENT_RPC_BUCKETS - 1)];
> +}
> +
> +/**
> + * homa_server_rpc_bucket() - Find the bucket containing a given
> + * server RPC.
> + * @hsk:         Socket associated with the RPC.
> + * @id:          Id of the desired RPC.
> + *
> + * Return:    The bucket in which this RPC will appear, if the RPC exists.
> + */
> +static inline struct homa_rpc_bucket *homa_server_rpc_bucket(struct homa_sock *hsk,
> +							     __u64 id)
> +{
> +	/* Each client allocates RPC ids sequentially, so they will
> +	 * naturally distribute themselves across the hash space.
> +	 * Thus we can use the id directly as hash.
> +	 */
> +	return &hsk->server_rpc_buckets[(id >> 1)
> +			& (HOMA_SERVER_RPC_BUCKETS - 1)];
> +}
> +
> +/**
> + * homa_bucket_lock() - Acquire the lock for an RPC hash table bucket.
> + * @bucket:    Bucket to lock
> + * @id:        ID of the RPC that is requesting the lock. Normally ignored,
> + *             but used occasionally for diagnostics and debugging.
> + * @locker:    Static string identifying the locking code. Normally ignored,
> + *             but used occasionally for diagnostics and debugging.
> + */
> +static inline void homa_bucket_lock(struct homa_rpc_bucket *bucket,
> +				    __u64 id, const char *locker)
> +{
> +	if (!spin_trylock_bh(&bucket->lock))
> +		homa_bucket_lock_slow(bucket, id);
> +}
> +
> +/**
> + * homa_bucket_unlock() - Release the lock for an RPC hash table bucket.
> + * @bucket:   Bucket to unlock.
> + * @id:       ID of the RPC that was using the lock.
> + */
> +static inline void homa_bucket_unlock(struct homa_rpc_bucket *bucket, __u64 id)
> +	__releases(&bucket->lock)
> +{
> +	spin_unlock_bh(&bucket->lock);
> +}
> +
> +static inline struct homa_sock *homa_sk(const struct sock *sk)
> +{
> +	return (struct homa_sock *)sk;
> +}
> +
> +#endif /* _HOMA_SOCK_H */
> -- 
> 2.34.1
> 

