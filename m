Return-Path: <netdev+bounces-220906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9FB496F8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FB1C25A44
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886035947;
	Mon,  8 Sep 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKb0Vaa6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F128399;
	Mon,  8 Sep 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352709; cv=none; b=RXt+8fPeLht4hOLPaWnvZEJ3AJMhXdO8G6xRQIZOtRHJBzNAwljQivOnKaPDlQoLb6qivPmPoAkI1z8tlZKltvJMMxPut/BbXC0ifkclRLRB+gcpuBCUif0t/laeb4u+g7yU3NPgcy4IHaH7GeqBivpO+pkeo2ZW9CIfvzqZ7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352709; c=relaxed/simple;
	bh=+GJvdWbYdEkO2iexLk7YraWW+Q1K7c80iEct8a7Ig08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myFgTMlijUpivlObkhpf9SM+gz/89mPcn1pnyCqQIs0INvVmEk64ufNcAb1Pqx2BAII23TTy3jgGE74BgI9AsNKHwaH4bbLYxFeaKDE7aU9HRF0mA5/nZeYUx45aFGiIarY6u3WKBvrZzTFmmOWwpGt25uO9c5FTH6UxCTb3/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKb0Vaa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2627C4CEF1;
	Mon,  8 Sep 2025 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757352708;
	bh=+GJvdWbYdEkO2iexLk7YraWW+Q1K7c80iEct8a7Ig08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nKb0Vaa6R6NYNEhMOdCuSCZp+oUbllfgqCTq09Di+mi3HR05l7lLTtqUXO2QiPh5D
	 2TkhXqVhsnCGDCILeuJ3Th5CZnGG/+Qy0vxAG1rQ7kOTmpDbwoxX0SpIlmc6yizT2u
	 PBjtsWe4axam2aOM6I6nsko6txOuJ921r9tItcjIzmsK4kpJs9uFkg+dnjPocJxG6E
	 i08+j0L54EyL4hquPoVsrO70xn22r89elZosE1O65Jzv/BIyWhEOE9/iwQNlQFw4EX
	 gEEuvbp2hHx3njq3vEXg+8sgwjfCPgqFs8D8t63V0nQP0r8cronoUzyfFtmzjAPQDa
	 lV0LtmAheILWg==
Message-ID: <23a66a02-7de9-40c5-995d-e701cb192f8b@kernel.org>
Date: Mon, 8 Sep 2025 19:31:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Content-Language: en-GB, fr-BE
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Reaver <me@davidreaver.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
 <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
 <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
 <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org>
 <aL8RoSniweGJgm3h@templeofstupid.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aL8RoSniweGJgm3h@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krister,

On 08/09/2025 19:25, Krister Johansen wrote:
> On Mon, Sep 08, 2025 at 07:13:12PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 07/09/2025 02:51, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
>>>> Hi Krister,
>>>>
>>>> On 06/09/2025 02:43, Krister Johansen wrote:
>>>>> Users reported a scenario where MPTCP connections that were
>>>>> configured
>>>>> with SO_KEEPALIVE prior to connect would fail to enable their
>>>>> keepalives
>>>>> if MTPCP fell back to TCP mode.
>>>>>
>>>>> After investigating, this affects keepalives for any connection
>>>>> where
>>>>> sync_socket_options is called on a socket that is in the closed or
>>>>> listening state.  Joins are handled properly. For connects,
>>>>> sync_socket_options is called when the socket is still in the
>>>>> closed
>>>>> state.  The tcp_set_keepalive() function does not act on sockets
>>>>> that
>>>>> are closed or listening, hence keepalive is not immediately
>>>>> enabled.
>>>>> Since the SO_KEEPOPEN flag is absent, it is not enabled later in
>>>>> the
>>>>> connect sequence via tcp_finish_connect.  Setting the keepalive via
>>>>> sockopt after connect does work, but would not address any
>>>>> subsequently
>>>>> created flows.
>>>>>
>>>>> Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on
>>>>> the
>>>>> subflow when calling sync_socket_options.
>>>>>
>>>>> The fix was valdidated both by using tcpdump to observe keeplaive
>>>>> packets not being sent before the fix, and being sent after the
>>>>> fix.  It
>>>>> was also possible to observe via ss that the keepalive timer was
>>>>> not
>>>>> enabled on these sockets before the fix, but was enabled
>>>>> afterwards.
>>>>
>>>>
>>>> Thank you for the fix! Indeed, the SOCK_KEEPOPEN flag was missing!
>>>> This
>>>> patch looks good to me as well:
>>>>
>>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>
>>>>
>>>> @Netdev Maintainers: please apply this patch in 'net' directly. But I
>>>> can always re-send it later if preferred.
>>>
>>> nit:
>>>
>>> I just noticed his patch breaks 'Reverse X-Mas Tree' order in
>>> sync_socket_options(). If you think any changes are needed, please
>>> update this when you re-send it.
>>
>> Sure, I can do the modification and send it with other fixes we have.
> 
> Thanks for the reviews, Geliang and Matt.  If you'd like me to fix the
> formatting up and send a v2, I'm happy to do that as well.  Just let me
> know.

I was going to apply this diff:

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 13108e9f982b..2abe6f1e9940 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1532,11 +1532,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  {
>         static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>         struct sock *sk = (struct sock *)msk;
> -       int kaval = !!sock_flag(sk, SOCK_KEEPOPEN);
> +       bool keep_open;
>  
> +       keep_open = sock_flag(sk, SOCK_KEEPOPEN);
>         if (ssk->sk_prot->keepalive)
> -               ssk->sk_prot->keepalive(ssk, kaval);
> -       sock_valbool_flag(ssk, SOCK_KEEPOPEN, kaval);
> +               ssk->sk_prot->keepalive(ssk, keep_open);
> +       sock_valbool_flag(ssk, SOCK_KEEPOPEN, keep_open);
>  
>         ssk->sk_priority = sk->sk_priority;
>         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;

(sock_flag() returns a bool, and 'keep_open' is maybe clearer)

But up to you, I really don't mind if you prefer to send the v2 by
yourself, just let me know.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


