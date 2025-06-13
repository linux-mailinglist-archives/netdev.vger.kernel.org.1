Return-Path: <netdev+bounces-197516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A4AD8FE8
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C532C178C0E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45BD1DFD86;
	Fri, 13 Jun 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mih7xaKA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A671D514E
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825824; cv=none; b=lFeyWC8diez7DZIu5QTC0HiMOa1ehKKj2Y5XXkyVIitX9twH1pbKd1xYcMyBLqr6UJbHVcO9edUPAf5a/wvjIsbonk5rI7eoUUYgXFos+qgLtKTx4mk2SHSDR26Ot9e4vikMYjnad+bi15TDM8hU7071pghuHXyVt0r7mGhMn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825824; c=relaxed/simple;
	bh=ZAoCOcNKYreSs5cMIZQgJWEEeyGQLKwj6gJFqdL1YD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMjw+cxC5luSm/hG5oOKs194emd5g/f2YpAh3Pp7QpB1uJMXML2nOC9hwqzMzFGLFiTGC1zhlkzJab9KEKHf3+XgxM64YfkepUoFk+F0uCk3ZhiMG3IXI9ScgX9k5mXMoYa0M/rTlJO7V9mxwqnKzzvBSBwbN/2ympZzx24gcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mih7xaKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3495FC4CEE3;
	Fri, 13 Jun 2025 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825824;
	bh=ZAoCOcNKYreSs5cMIZQgJWEEeyGQLKwj6gJFqdL1YD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mih7xaKAUvkOH3+CpsYWEQ4XFbHbPB+IcQD9Z04GKOhg11F1StGjusVO9iybbjz8S
	 lHWdvwHnBOtgWsKo4DdJ25G++y5UXJcY1KodifFm46cYEeW8vyrxJz3iVhcPlEdOo6
	 /dfZK/S4QPtNdh9F52pLvw3W1ysQuvRvpAYhsQNWgBU1ddpvY5k5hPUqhwN1lTLxO2
	 PZwEh/P1kZPJFD5H/ictzx8A+gDXpJwgibv8J5CU23YT9Tu8s5Z/QZoN634oYVrI2S
	 as5+rvZDr3hlbyQgAzs0tJlhFbH9wpa3uW1kjTEFfd6uRdruHr1vpNQ2FDcC4RxYmU
	 xHiR7b4Li6x0A==
Date: Fri, 13 Jun 2025 15:43:40 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v9 08/15] net: homa: create homa_pacer.h and
 homa_pacer.c
Message-ID: <20250613144340.GL414686@horms.kernel.org>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
 <20250609154051.1319-9-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154051.1319-9-ouster@cs.stanford.edu>

On Mon, Jun 09, 2025 at 08:40:41AM -0700, John Ousterhout wrote:
> These files provide facilities to pace packet output in order to prevent
> queue buildup in the NIC. This functionality is needed to implement SRPT
> on output, so short messages don't get stuck in long NIC queues. Note: the
> pacer eventually needs to be replaced with a Homa-specific qdisc, which can
> better manage simultaneous transmissions by Homa and TCP. The current
> implementation can coexist with TCP and doesn't harm TCP, but
> Homa's latency suffers when TCP runs concurrently.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> 
> ---
> Changes for v9:
> * Add support for homa_net objects
> * Use new homa_clock abstraction layer
> * Various name improvements (e.g. use "alloc" instead of "new" for functions
>   that allocate memory)
> 
> Changes for v8:
> * This file is new in v8 (functionality extracted from other files)
> ---
>  net/homa/homa_impl.h  |   1 +
>  net/homa/homa_pacer.c | 316 ++++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_pacer.h | 190 +++++++++++++++++++++++++
>  3 files changed, 507 insertions(+)
>  create mode 100644 net/homa/homa_pacer.c
>  create mode 100644 net/homa/homa_pacer.h
> 

> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h

...

> +/**
> + * homa_pacer_manage_rpc() - Arrange for the pacer to transmit packets
> + * from this RPC (make sure that an RPC is on the throttled list and wake up
> + * the pacer thread if necessary).
> + * @rpc:     RPC with outbound packets that have been granted but can't be
> + *           sent because of NIC queue restrictions. Must be locked by caller.
> + */
> +void homa_pacer_manage_rpc(struct homa_rpc *rpc)
> +	__must_hold(rpc_bucket_lock)
> +{
> +	struct homa_pacer *pacer = rpc->hsk->homa->pacer;
> +	struct homa_rpc *candidate;
> +	int bytes_left;
> +	int checks = 0;

Checks is set but otherwise unused in this function.
Probably it can be removed.

Flagged by Clang 20.1.4 as:

  .../homa_pacer.c:252:6: warning: variable 'checks' set but not used [-Wunused-but-set-variable]
    252 |         int checks = 0;
        |             ^
> +
> +	if (!list_empty(&rpc->throttled_links))
> +		return;
> +	bytes_left = rpc->msgout.length - rpc->msgout.next_xmit_offset;
> +	homa_pacer_throttle_lock(pacer);
> +	list_for_each_entry(candidate, &pacer->throttled_rpcs,
> +			    throttled_links) {
> +		int bytes_left_cand;
> +
> +		checks++;
> +
> +		/* Watch out: the pacer might have just transmitted the last
> +		 * packet from candidate.
> +		 */
> +		bytes_left_cand = candidate->msgout.length -
> +				candidate->msgout.next_xmit_offset;
> +		if (bytes_left_cand > bytes_left) {
> +			list_add_tail(&rpc->throttled_links,
> +				      &candidate->throttled_links);
> +			goto done;
> +		}
> +	}
> +	list_add_tail(&rpc->throttled_links, &pacer->throttled_rpcs);
> +done:
> +	homa_pacer_throttle_unlock(pacer);
> +	wake_up(&pacer->wait_queue);
> +}

...

