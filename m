Return-Path: <netdev+bounces-150136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734699E913E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE861625DF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A8198831;
	Mon,  9 Dec 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6ON6cE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADEA1E48A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742042; cv=none; b=gil6JiPCZRNLlyFFnu45wgbZdbbH7JqYJfnyKTSmTMnlje9m6zMX34YsBJaDxjChkjgtZ51tujgQGUpNNFNPe57biJtQeqGBE1bvtJhkyUT6oS2FtR3MXHnB9dBp7waRP+8tGsZfcdXLkBXyURb8i09XnO1hNx5QvpK9MfrEh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742042; c=relaxed/simple;
	bh=gX2LrG/mYdhLY+JCsMO4sGga6SBxNRk6mwx/+0U5qYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=db1g85xn8bnHRONUsdsvuvRp1fTG2OAAJ6kHGeeaaIoLBkiPSPmwK3ARDtES/GXpxlG4z+vM5oV1C9CWJvUycY/pLxs+LlRgp9dKSmd5KT93WIqK1q7pDiCio/sEvupVcmGrHX6cTQcL7hHywDpGcZas6vRzzivzNfdfDrhfsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6ON6cE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC13C4CEDE;
	Mon,  9 Dec 2024 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733742041;
	bh=gX2LrG/mYdhLY+JCsMO4sGga6SBxNRk6mwx/+0U5qYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e6ON6cE9Y+Hmji+9jImdKogbCy1TkkAtRjo+EZob6u77R/mXpUBS86SSMukS5Yplu
	 0GATQtotcOoVNqzOKiwAclYrbHjmwV1EXRjhGK249ZyPQhfJJG/mAXHFPkznOuqDQ8
	 ZOYe3lJZ8kACbYyiOWY1+HUyyoGLXZ3Wb42M6zDQQdBl8gtbC12/UU5mmYovVf5JwB
	 J9ETxl2v5bbDv0KjtViMGMwTXmTv8SH9/awq0X7CxelheoZqvMFXWzfvbkJV7z4y8K
	 EF2JWW6QUg1rURAsWX/k2FO37uEKiKNOedzNlM9KV7okzL75Ia5sno3Bc2x3LkvcxA
	 BMTRM56qYGDmA==
Message-ID: <cbdd3097-97af-45da-b689-fede851f3791@kernel.org>
Date: Mon, 9 Dec 2024 12:00:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v1 net-next 12/15] socket: Remove kernel socket
 conversion.
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Steve French <sfrench@samba.org>, Mat Martineau <martineau@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
References: <20241206075504.24153-1-kuniyu@amazon.com>
 <20241206075504.24153-13-kuniyu@amazon.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20241206075504.24153-13-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

Thank you for working on this!

On 06/12/2024 08:55, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference count
> the netns of kernel sockets."), TCP kernel socket has caused many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have the
> same pattern in cifs, mptcp, rds, smc, and sunrpc.
> 
> Let's drop the conversion and use sock_create_net() instead.
> 
> The changes for cifs, mptcp, and smc are straightforward.

(...)

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fc534290f119..e7e8972bdfca 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1755,7 +1755,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	if (unlikely(!sk->sk_socket))
>  		return -EINVAL;
>  
> -	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
> +	err = sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
>  	if (err)
>  		return err;
>  
> @@ -1768,14 +1768,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	/* the newly created socket has to be in the same cgroup as its parent */
>  	mptcp_attach_cgroup(sk, sf->sk);
>  
> -	/* kernel sockets do not by default acquire net ref, but TCP timer
> -	 * needs it.
> -	 * Update ns_tracker to current stack trace and refcounted tracker.
> -	 */
> -	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
> -	sf->sk->sk_net_refcnt = 1;
> -	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
> -
>  	err = tcp_set_ulp(sf->sk, "mptcp");
>  	if (err)
>  		goto err_free;
Regarding the modification on MPTCP side, it looks good to me: that's
clearer and cleaner without this old workaround here!

For MPTCP:

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


