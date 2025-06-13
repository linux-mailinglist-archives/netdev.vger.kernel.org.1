Return-Path: <netdev+bounces-197511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2DAD8FBF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C87AD1F3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5E6195811;
	Fri, 13 Jun 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggCwZnhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AA194A6C
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825601; cv=none; b=M5OJ/9Z2Hg24ehGIvPbTcuv84PhNHFclim/PUdSKCFejP2aFkKgqrYLrHZvYjx1opmyujTw2A9C0HChoqZLmCaxboUSyoGfIbdK8lWFtgmqNbtcxaQ3rHoAc9LkI6S/S1OKAR5N7tPRZp0/9H5jnFnf21F4TTuM7gzAKC6jLoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825601; c=relaxed/simple;
	bh=HGYF7bvV6YeuPDGcYOna21wOVKPKdJAUVdyz1NsuPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmlpe0n1OTMvEJQ2AqnWyCenYjPPRJA6qPH9tePYNb02dsK2QHNwXh2v/HGRbOk2HFI2buJ+upAAbHQDfRyOXtS1NEVX60hCzttmhudx9LBGpgUh2ML9LJEKOh9KGt8nxqChp7hrA8InBtFMTn2vEwu+lKFkOGATC3A7VUWccKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggCwZnhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47027C4CEE3;
	Fri, 13 Jun 2025 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825601;
	bh=HGYF7bvV6YeuPDGcYOna21wOVKPKdJAUVdyz1NsuPxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggCwZnhi2FKkC44BuaTnvbJ1YXmFg8YZWl//GoHyOM6vPdxGuOPy5LZAbgue4zFn7
	 DRC6SE9ayeaoG2QP7ANr0gm2jp4e+vS7IKTm8r/AX2EnP/Li+FFLgsvb1v3laLcYSm
	 ahMdHayGet/Qw2JIs4Njedd3a0sZLsHPYOCQKvg8E6eodYHcpZw+DPL/vZj5guP9yz
	 kG7YqFroieCR6O/HGaeCPttBQ0aQhbYKPT2ah/NFCY0EKLaty/pUZzERFGKPgbewzd
	 i4lQbdku1FTM2OlCVTfkzSAeyW5au/4SfyamB+Jt3EVn77LXt18dB71dP9TC0vz+oR
	 2MaZiLuYIXVRA==
Date: Fri, 13 Jun 2025 15:39:58 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v9 05/15] net: homa: create homa_peer.h and
 homa_peer.c
Message-ID: <20250613143958.GH414686@horms.kernel.org>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
 <20250609154051.1319-6-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154051.1319-6-ouster@cs.stanford.edu>

On Mon, Jun 09, 2025 at 08:40:38AM -0700, John Ousterhout wrote:
> Homa needs to keep a small amount of information for each peer that
> it has communicated with. These files define that state and provide
> functions for storing and accessing it.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

...

> diff --git a/net/homa/homa_peer.c b/net/homa/homa_peer.c

...

> +/**
> + * homa_peer_alloc_peertab() - Allocate and initialize a homa_peertab.
> + *
> + * Return:    A pointer to the new homa_peertab, or ERR_PTR(-errno) if there
> + *            was a problem.
> + */
> +struct homa_peertab *homa_peer_alloc_peertab(void)
> +{
> +	struct homa_peertab *peertab;
> +	int err;
> +
> +	peertab = kmalloc(sizeof(*peertab), GFP_KERNEL | __GFP_ZERO);

nit: I think you can use kzalloc() here.
     Likewise elsewhere in this patchset.

> +	if (!peertab) {
> +		pr_err("%s couldn't create peertab: kmalloc failure", __func__);

The mm subsystem should log on allocation failure.
So this is a duplicate and should probably be removed.
Likewise elsewhere in this patchset.

Flagged by checkpatch.pl

> +		return ERR_PTR(-ENOMEM);
> +	}

...

> diff --git a/net/homa/homa_peer.h b/net/homa/homa_peer.h
> new file mode 100644
> index 000000000000..3b3f7cccee9f
> --- /dev/null
> +++ b/net/homa/homa_peer.h
> @@ -0,0 +1,373 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +
> +/* This file contains definitions related to managing peers (homa_peer
> + * and homa_peertab).
> + */
> +
> +#ifndef _HOMA_PEER_H
> +#define _HOMA_PEER_H
> +
> +#include "homa_wire.h"
> +#include "homa_sock.h"
> +
> +#include <linux/rhashtable.h>
> +
> +struct homa_rpc;
> +
> +/**
> + * struct homa_peertab - Stores homa_peer objects, indexed by IPv6
> + * address.
> + */
> +struct homa_peertab {
> +	/**
> +	 * @lock: Used to synchronize updates to @ht as well as other
> +	 * operations on this object.
> +	 */
> +	spinlock_t lock;
> +
> +	/** @ht: Hash table that stores all struct peers. */
> +	struct rhashtable ht;
> +
> +	/** @ht_iter: Used to scan ht to find peers to garbage collect. */
> +	struct rhashtable_iter ht_iter;
> +
> +	/** @num_peers: Total number of peers currently in @ht. */
> +	int num_peers;
> +
> +	/**
> +	 * @ht_valid: True means ht and ht_iter have been initialized and must
> +	 * eventually be destroyed.
> +	 */
> +	bool ht_valid;
> +
> +	/**
> +	 * @dead_peers: List of peers that have been removed from ht
> +	 * but can't yet be freed (because they have nonzero reference
> +	 * counts or an rcu sync point hasn't been reached).
> +	 */
> +	struct list_head dead_peers;
> +
> +	/** @rcu_head: Holds state of a pending call_rcu invocation. */
> +	struct rcu_head rcu_head;
> +
> +	/**
> +	 * @call_rcu_pending: Nonzero means that call_rcu has been
> +	 * invoked but it has not invoked the callback function; until the
> +	 * callback has been invoked we can't free peers on dead_peers or
> +	 * invoke call_rcu again (which means we can't add more peers to
> +	 * dead_peers).
> +	 */
> +	atomic_t call_rcu_pending;
> +
> +	/**
> +	 * @gc_stop_count: Nonzero means that peer garbage collection
> +	 * should not be performed (conflicting state changes are underway).
> +	 */
> +	int gc_stop_count;
> +
> +	/**
> +	 * @gc_threshold: If @num_peers is less than this, don't bother
> +	 * doing any peer garbage collection. Set externally via sysctl.
> +	 */
> +	int gc_threshold;
> +
> +	/**
> +	 * @net_max: If the number of peers for a homa_net exceeds this number,
> +	 * work aggressivley to reclaim peers for that homa_net. Set

nit: aggressively

     Flagged by checkpatch.pl --codespell

> +	 * externally via sysctl.
> +	 */
> +	int net_max;
> +
> +	/**
> +	 * @idle_secs_min: A peer will not be considered for garbage collection
> +	 * under any circumstances if it has been idle less than this many
> +	 * seconds. Set externally via sysctl.
> +	 */
> +	int idle_secs_min;
> +
> +	/**
> +	 * @idle_jiffies_min: Same as idle_secs_min except in units
> +	 * of jiffies.
> +	 */
> +	unsigned long idle_jiffies_min;
> +
> +	/**
> +	 * @idle_secs_max: A peer that has been idle for less than
> +	 * this many seconds will not be considered for garbage collection
> +	 * unless its homa_net has more than @net_threshold peers. Set
> +	 * externally via sysctl.
> +	 */
> +	int idle_secs_max;
> +
> +	/**
> +	 * @idle_jiffies_max: Same as idle_secs_max except in units
> +	 * of jiffies.
> +	 */
> +	unsigned long idle_jiffies_max;
> +
> +};

...

> +/**
> + * homa_peer_hash() - Hash function used for @peertab->ht.
> + * @data:    Pointer to key for which a hash is desired. Must actually
> + *           be a struct homa_peer_key.
> + * @dummy:   Not used
> + * @seed:    Seed for the hash.
> + * Return:   A 32-bit hash value for the given key.
> + */
> +static inline u32 homa_peer_hash(const void *data, u32 dummy, u32 seed)

Sorry if this has already been asked but can homa reuse the code in
drivers/md/dm-vdo/murmurhash3.c:murmurhash3_128() (after moving it
somewhere else).

> +{
> +	/* This is MurmurHash3, used instead of the jhash default because it
> +	 * is faster (25 ns vs. 40 ns as of May 2025).
> +	 */
> +	BUILD_BUG_ON(sizeof(struct homa_peer_key) & 0x3);
> +	const u32 len = sizeof(struct homa_peer_key) >> 2;
> +	const u32 c1 = 0xcc9e2d51;
> +	const u32 c2 = 0x1b873593;
> +	const u32 *key = data;
> +	u32 h = seed;
> +
> +	for (size_t i = 0; i < len; i++) {
> +		u32 k = key[i];
> +
> +		k *= c1;
> +		k = (k << 15) | (k >> (32 - 15));
> +		k *= c2;
> +
> +		h ^= k;
> +		h = (h << 13) | (h >> (32 - 13));
> +		h = h * 5 + 0xe6546b64;
> +	}
> +
> +	h ^= len * 4;  // Total number of input bytes
> +
> +	h ^= h >> 16;
> +	h *= 0x85ebca6b;
> +	h ^= h >> 13;
> +	h *= 0xc2b2ae35;
> +	h ^= h >> 16;
> +	return h;
> +}
> +/**
> + * homa_peer_compare() - Comparison function for entries in @peertab->ht.
> + * @arg:   Contains one of the keys to compare.
> + * @obj:   homa_peer object containing the other key to compare.
> + * Return: 0 means the keys match, 1 means mismatch.
> + */
> +static inline int homa_peer_compare(struct rhashtable_compare_arg *arg,
> +				    const void *obj)
> +{
> +	const struct homa_peer *peer = obj;
> +	const struct homa_peer_key *key = arg->key;

nit: Reverse xmas tree here please.
     Likewise elsewhere in this patchset.

     This tool can he useful here
     https://github.com/ecree-solarflare/xmastree/commits/master/

> +
> +	return !(ipv6_addr_equal(&key->addr, &peer->ht_key.addr) &&
> +		 peer->ht_key.hnet == key->hnet);
> +}
> +
> +#endif /* _HOMA_PEER_H */
> -- 
> 2.43.0
> 

