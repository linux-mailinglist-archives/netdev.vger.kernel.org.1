Return-Path: <netdev+bounces-197513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E026AD8FCF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5021892FC1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864B1993B9;
	Fri, 13 Jun 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW1PPjVJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9C195811
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825697; cv=none; b=ZPSM+pdIJNCJm84/qir/YOA3Fc31n3mh9/tuDiEEdBO9PlYDkzV3bska7yZGrVthlWjNDshB3vaoGJmA2iAKVR/AcgGhvgJt8OUX3PM5t3KApOCBMF8Q4BZUgW8wsWxzm4OXIwG99hT0SXVtrF4vSRNJ8omzpdj9XMnH2zorvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825697; c=relaxed/simple;
	bh=39pyphlFFWkkvSkufeLVeIcTkES26vfA7Sl9AvE8q0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgjYBAbMW8ZIoNzy/Ez5eH4p2jANakmgN2sW3Td2GqarZyKYsOcyprl0aUuoD4t9zg+Rxb7ksZTC1EXiFhmpYQ+MFmi0SUKxIlBx3mR+asW6ZevC0gyV7+uVcVx2GPM8JkFvr/FW8NIc6+yiqxjdKzcc+/PgXGFXqCqM3UomQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW1PPjVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4E0C4CEE3;
	Fri, 13 Jun 2025 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825697;
	bh=39pyphlFFWkkvSkufeLVeIcTkES26vfA7Sl9AvE8q0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW1PPjVJrSVph1HS+gmqKT+QXbRyTRK3mCCbBoShp9W2MrIcAvh7T0fRtuq+zR9Fs
	 EU3k+nKdhSrP2tKGgfToBB0gJiwWAssq7T8c1YnLaauCWg0KJrGdHdEN8/ncTOLzAA
	 Q/cVlOHo4BoujaQr1Xj2gf+c4PC71WLmnrpyknoD/i7uzWutGhx8dICv68PqAwZjuq
	 k0+9dF44aLtT7XeI10Lb2rUdHJgDKrXLSquYlLaIqBHRimCRoZ9bL/poZaxpj30vwx
	 /jIXUcn+EzyHhiEY2omZgseO6T2NYuJM4hGdKMw6D+dGyhUR+UTSDptnbGtDwPL92u
	 86e0NCCeG2P+g==
Date: Fri, 13 Jun 2025 15:41:33 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v9 13/15] net: homa: create homa_timer.c
Message-ID: <20250613144133.GJ414686@horms.kernel.org>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
 <20250609154051.1319-14-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154051.1319-14-ouster@cs.stanford.edu>

On Mon, Jun 09, 2025 at 08:40:46AM -0700, John Ousterhout wrote:
> This file contains code that wakes up periodically to check for
> missing data, initiate retransmissions, and declare peer nodes
> "dead".
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

...

> diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c

...

> +/**
> + * homa_timer() - This function is invoked at regular intervals ("ticks")
> + * to implement retries and aborts for Homa.
> + * @homa:    Overall data about the Homa protocol implementation.
> + */
> +void homa_timer(struct homa *homa)
> +{
> +	struct homa_socktab_scan scan;
> +	struct homa_sock *hsk;
> +	struct homa_rpc *rpc;
> +	int total_rpcs = 0;

total_rpcs is set but otherwise unused in this function.
It looks like it can be removed.

Flagged by clang 20.1.4 as:

  net/homa/homa_timer.c:107:6: warning: variable 'total_rpcs' set but not used [-Wunused-but-set-variable]
    107 |         int total_rpcs = 0;
        |             ^

> +	int rpc_count = 0;
> +
> +	homa->timer_ticks++;
> +
> +	/* Scan all existing RPCs in all sockets. */
> +	for (hsk = homa_socktab_start_scan(homa->socktab, &scan);
> +			hsk; hsk = homa_socktab_next(&scan)) {
> +		while (hsk->dead_skbs >= homa->dead_buffs_limit)
> +			/* If we get here, it means that Homa isn't keeping
> +			 * up with RPC reaping, so we'll help out.  See
> +			 * "RPC Reaping Strategy" in homa_rpc_reap code for
> +			 * details.
> +			 */
> +			if (homa_rpc_reap(hsk, false) == 0)
> +				break;
> +
> +		if (list_empty(&hsk->active_rpcs) || hsk->shutdown)
> +			continue;
> +
> +		if (!homa_protect_rpcs(hsk))
> +			continue;
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
> +			total_rpcs++;
> +			homa_rpc_lock(rpc);
> +			if (rpc->state == RPC_IN_SERVICE) {
> +				rpc->silent_ticks = 0;
> +				homa_rpc_unlock(rpc);
> +				continue;
> +			}
> +			rpc->silent_ticks++;
> +			homa_timer_check_rpc(rpc);
> +			homa_rpc_unlock(rpc);
> +			rpc_count++;
> +			if (rpc_count >= 10) {
> +				/* Give other kernel threads a chance to run
> +				 * on this core.
> +				 */
> +				rcu_read_unlock();
> +				schedule();
> +				rcu_read_lock();
> +				rpc_count = 0;
> +			}
> +		}
> +		rcu_read_unlock();
> +		homa_unprotect_rpcs(hsk);
> +	}
> +	homa_socktab_end_scan(&scan);
> +	homa_skb_release_pages(homa);
> +	homa_peer_gc(homa->peertab);
> +}
> -- 
> 2.43.0
> 

