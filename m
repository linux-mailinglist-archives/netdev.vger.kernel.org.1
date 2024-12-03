Return-Path: <netdev+bounces-148412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E779E16CE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6A81633C3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B21DE4EA;
	Tue,  3 Dec 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/S00nTu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5E1DE4D9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217031; cv=none; b=OLhc023SLQhB2b7r5nTunjlGKa5HpU+kDCGW4kMaENgfC/XG0lO0cn3JcrJAgGtsBXO8iGyHBxuPSO3cwI/Uxoj7i5poiDTUNJJHkE2En5BdiPp0dpdLhpEfcVzrWEq/TIuyqHf+NDWhGMA0mdcE9g5eq8sAQNJfykql4fp7/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217031; c=relaxed/simple;
	bh=t2rIDheqjcBU9D907pHcVZZDQMqpDHx8i/WTx64rQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAgp6Iz8OGkfciui8de0fAcqBJ55g6lVxs/hmg8lqRf47mSCFK99EXRW4odDJTcQ2GhvNXzz1uE2rsOl0o4LzMWeZ8CRBo0gi5qwImFf/DSWmFwH68ty2oiKs+zDCfKFRcmZmQO/vKHmjS/cqDb/lSD4TiliwEl0cthajFdVNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/S00nTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C9DC4CED6;
	Tue,  3 Dec 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733217031;
	bh=t2rIDheqjcBU9D907pHcVZZDQMqpDHx8i/WTx64rQ1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/S00nTutZFeFDap47LU2wOH4RkX8Rw+FKXBJkY2DC9GFMirmrJkSgs5zUSUQODMm
	 uI/Z+0ygF9/uxwmqjBAAU3cMKrF68qBNWeRLuU9+9ZwIfcp+O79rJo0Lnbg2/ITgGB
	 i7VyIrCWqluCegLc5eK0j9Y0rJ4BGtRTpNwYl9p8hd4NtloYD8zk67XHgW1NJVrw1O
	 PgyWUsZq83zh8BAVG2xiZ1TrZy290zrkSLf55QOrcMn/zBk3bC/zZW1oFQsy5v0aUm
	 NDz9DhvX7AwLjt5EuQket3aYIz8n62FSFyaubK41zGO6xFlY2owTqIaYFpx5nDC7Sv
	 djbAIoJgXhqXg==
Date: Tue, 3 Dec 2024 09:09:27 +0000
From: Simon Horman <horms@kernel.org>
To: greearb@candelatech.com
Cc: netdev@vger.kernel.org, Jason@zx2c4.com, wireguard@lists.zx2c4.com,
	dsahern@kernel.org
Subject: Re: [PATCH] net: wireguard: Allow binding to specific ifindex
Message-ID: <20241203090927.GA9361@kernel.org>
References: <20241125212111.1533982-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125212111.1533982-1-greearb@candelatech.com>

On Mon, Nov 25, 2024 at 01:21:11PM -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Which allows us to bind to VRF.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> NOTE:  Modified user-space to utilize this may be found here:
> https://github.com/greearb/wireguard-tools-ct
> Only the 'wg' part has been tested with this new feature as of today.

...

> diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
> index 0414d7a6ce74..a7cb1c7c3112 100644
> --- a/drivers/net/wireguard/socket.c
> +++ b/drivers/net/wireguard/socket.c
> @@ -25,7 +25,8 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
>  		.daddr = endpoint->addr4.sin_addr.s_addr,
>  		.fl4_dport = endpoint->addr4.sin_port,
>  		.flowi4_mark = wg->fwmark,
> -		.flowi4_proto = IPPROTO_UDP
> +		.flowi4_proto = IPPROTO_UDP,
> +		.flowi4_oif = wg->lowerdev,
>  	};
>  	struct rtable *rt = NULL;
>  	struct sock *sock;
> @@ -111,6 +112,9 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
>  	struct sock *sock;
>  	int ret = 0;
>  
> +	if (wg->lowerdev)
> +		fl.flowi6_oif = wg->lowerdev,

Hi Ben,

I think that the trailing ',' on the line above should be a ';'.
As written, with a ',', the call to skb_mark_not_on_list() 
below will be included in the conditional block above.
And this doesn't seem to be the intention of the code based on indentation.

Flagged by clang-19 with -Wcomma

> +
>  	skb_mark_not_on_list(skb);
>  	skb->dev = wg->dev;
>  	skb->mark = wg->fwmark;

...

