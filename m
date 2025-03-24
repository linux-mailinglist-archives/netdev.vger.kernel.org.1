Return-Path: <netdev+bounces-177083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51940A6DCB7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D223B12A9
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBFC25F995;
	Mon, 24 Mar 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Bz+J2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8625F988
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825784; cv=none; b=omyQGlzXv79xnooAPZJY6EE27SNM0BE4fKzX5b9cqS9kej3G6uzr/8jUD2LVHWu/hAsNEgFNejtYHcu/IRtBPozadEaj5LJ7cdUk7r4klr/Yt6PJhC//cRw2TnKPnULBx+GPW40mp+505mGl7U6qDXL3rdXrePKr1Yh8Eq/6LIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825784; c=relaxed/simple;
	bh=SDy+xAScuDPanV/Ei4cGrSeN2jvSJjen3Flv0enuu5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKfgVY3q5B+ZN7taEOzAoWPT3tUlEYZCwhOIWNfTZsFS9DKiWIC2OxU4tLkynE7frjcGaA5eULFEdlbZyz7zOWRow6KxnQWsYtaZamxhtd7NigQ7TjGhk5HBb+sClZIb4q6Jab2YE6SIEqcwxdSjsEG19IBCXofAJPR1cnX6Gfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Bz+J2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17E8C4CEDD;
	Mon, 24 Mar 2025 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742825783;
	bh=SDy+xAScuDPanV/Ei4cGrSeN2jvSJjen3Flv0enuu5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1Bz+J2USgAWvrPIWodT1WNIRBHETF0IGwqLlSRID3e1jc0mMntx7W7+2raglxwWS
	 GQSoPToo0Nf72gS1gyjIDOARW3jsfZQzz0/u7avAHuV9O5gWkvA1lcRqGJpY89lT/+
	 q/gEYsSoSNmZIyRSi+r27R+CuPXmBT+nFktQrbkJYVHgvECmpIH3EGA4RzrDxIty6i
	 pdkYdh95dVqyK+1e/APvHlZmJFtfx/xAFe5rlI702waefKa2tFwlrSo86vHkzm5j4c
	 41Vr8VK9ue7WP76PgkUSuLYPQiy+KQdPJ5r4ygD2raKn8ZgBYtANi4rZUuGv17HXtv
	 2IjagOZr5518w==
Date: Mon, 24 Mar 2025 14:16:19 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net-next] net: rfs: hash function change
Message-ID: <20250324141619.GE892515@horms.kernel.org>
References: <20250321171309.634100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321171309.634100-1-edumazet@google.com>

On Fri, Mar 21, 2025 at 05:13:09PM +0000, Eric Dumazet wrote:
> RFS is using two kinds of hash tables.
> 
> First one is controled by /proc/sys/net/core/rps_sock_flow_entries = 2^N
> and using the N low order bits of the l4 hash is good enough.
> 
> Then each RX queue has its own hash table, controled by
> /sys/class/net/eth1/queues/rx-$q/rps_flow_cnt = 2^X
> 
> Current hash function, using the X low order bits is suboptimal,
> because RSS is usually using Func(hash) = (hash % power_of_two);
> 
> For example, with 32 RX queues, 6 low order bits have no entropy
> for a given queue.
> 
> Switch this hash function to hash_32(hash, log) to increase
> chances to use all possible slots and reduce collisions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Tom Herbert <tom@herbertland.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -4903,13 +4908,13 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
>  
>  	rcu_read_lock();
>  	flow_table = rcu_dereference(rxqueue->rps_flow_table);
> -	if (flow_table && flow_id <= flow_table->mask) {
> +	if (flow_table && flow_id < (1UL << flow_table->log)) {
>  		rflow = &flow_table->flows[flow_id];
>  		cpu = READ_ONCE(rflow->cpu);
>  		if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
>  		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
>  			   READ_ONCE(rflow->last_qtail)) <
> -		     (int)(10 * flow_table->mask)))
> +		     (int)(10 << flow_table->log)))

I am assuming that we don't care that (10 * flow_table->mask) and
(10 << flow_table->log) are close but not exactly the same.

e.g. mask = 0x3f => log = 6

     10 * 0x3f = 630
     10 << 6   = 640

>  			expire = false;
>  	}
>  	rcu_read_unlock();

...

