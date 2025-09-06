Return-Path: <netdev+bounces-220535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC1B467FD
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656A71893983
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320B18FC92;
	Sat,  6 Sep 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abbouuqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA354A944;
	Sat,  6 Sep 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757122148; cv=none; b=CspALBO4/Ao05ycdaWBVTgeyYPaliU/wKqJgkRPqQukWBABEwKWchvXSTIGksdctBkCuZ8zoqs8t2D5wFkLW4nK3wHz95Lm3VVFI+VxxvK+3TGGjtVDC24t+CpaP1v7pmHGH0qnuCjgsx16GMQBQAeEGSoR10oW7E8cMoCH1tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757122148; c=relaxed/simple;
	bh=LzitgvyrHgnJrhbLuGvEj9PVO8+obvo3+maTh6Lztc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RViUPZ7Zq3SfnmdjZ4Myhet58wBsZBNb33xIDV2sXgauCVwCqYdw4n4TiTpdWwc6jlCQa89A1uH2EhGYlY9jTl6OAxlYcK4PFiqQN8HSPRGUhx2ucL86YlJD8SakFAql/ooHmClXfBIYpPI55+pJ77an+2krFXnJZ460BF66jVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abbouuqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC336C4CEF1;
	Sat,  6 Sep 2025 01:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757122148;
	bh=LzitgvyrHgnJrhbLuGvEj9PVO8+obvo3+maTh6Lztc8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=abbouuqv7zwrLqz8j+ZHxzmmEtPuIgox60zFy5ynhS0cwFfBhfumOxSAVC2+NCP8J
	 /O8GpA/tAIkoICTsQu0pTWFT9nEvqT6us0Qek30PzKotVcTx3vmjhzD1t94sk/L82w
	 +USXQrcbGF5dR2J7yWmQBOa2GtXwM5i8QACmXYbhSblCIks78bUxEyjhSRQrDtuPE7
	 Ut4BYUw4a6qtzBK5r7NWZ5OwZyNwBKtGXnQvQMqU1HuwcqKDqDZJZZNAVKetyZZe/6
	 3+k9faBesMxq8JgrGhf42Hjm5UZkevk1+aU7IshwRZNIquyVDe/VCr/hTOBS5dGhEk
	 QNEYIWiUa8ZvA==
Message-ID: <802a2629b135d7f69f42f7bac5a5350374ed2570.camel@kernel.org>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options
 propagate SOCK_KEEPOPEN
From: Geliang Tang <geliang@kernel.org>
To: Krister Johansen <kjlx@templeofstupid.com>, Matthieu Baerts
	 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, 	mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Reaver	 <me@davidreaver.com>
Date: Sat, 06 Sep 2025 09:29:01 +0800
In-Reply-To: <aLuDmBsgC7wVNV1J@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krister,

On Fri, 2025-09-05 at 17:43 -0700, Krister Johansen wrote:
> Users reported a scenario where MPTCP connections that were
> configured
> with SO_KEEPALIVE prior to connect would fail to enable their
> keepalives
> if MTPCP fell back to TCP mode.
> 
> After investigating, this affects keepalives for any connection where
> sync_socket_options is called on a socket that is in the closed or
> listening state.  Joins are handled properly. For connects,
> sync_socket_options is called when the socket is still in the closed
> state.  The tcp_set_keepalive() function does not act on sockets that
> are closed or listening, hence keepalive is not immediately enabled.
> Since the SO_KEEPOPEN flag is absent, it is not enabled later in the
> connect sequence via tcp_finish_connect.  Setting the keepalive via
> sockopt after connect does work, but would not address any
> subsequently
> created flows.
> 
> Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on
> the
> subflow when calling sync_socket_options.
> 
> The fix was valdidated both by using tcpdump to observe keeplaive
> packets not being sent before the fix, and being sent after the fix. 
> It
> was also possible to observe via ss that the keepalive timer was not
> enabled on these sockets before the fix, but was enabled afterwards.
> 
> Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and
> SO_PRIORITY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>

Thanks for this fix. Good catch!

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  net/mptcp/sockopt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 2c267aff95be..13108e9f982b 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1532,13 +1532,11 @@ static void sync_socket_options(struct
> mptcp_sock *msk, struct sock *ssk)
>  {
>  	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK |
> SOCK_SNDBUF_LOCK;
>  	struct sock *sk = (struct sock *)msk;
> +	int kaval = !!sock_flag(sk, SOCK_KEEPOPEN);
>  
> -	if (ssk->sk_prot->keepalive) {
> -		if (sock_flag(sk, SOCK_KEEPOPEN))
> -			ssk->sk_prot->keepalive(ssk, 1);
> -		else
> -			ssk->sk_prot->keepalive(ssk, 0);
> -	}
> +	if (ssk->sk_prot->keepalive)
> +		ssk->sk_prot->keepalive(ssk, kaval);
> +	sock_valbool_flag(ssk, SOCK_KEEPOPEN, kaval);
>  
>  	ssk->sk_priority = sk->sk_priority;
>  	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> 
> base-commit: 319f7385f22c85618235ab0169b80092fa3c7696

