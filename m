Return-Path: <netdev+bounces-157808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E243EA0BD11
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566D27A289B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3614D6EB;
	Mon, 13 Jan 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaQBIjQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD426AC3;
	Mon, 13 Jan 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784989; cv=none; b=FYB57dxvBqabS34K8qtzlGa2UcYtrMTYhD5ZVl3YT8rR/10ITcpxETQ5u747A2tCQ4ALiF4DUmPhNn3l879HoqbJeuFBZIuQWKmo/l0uRgyMT/31t7iU8HZ8ggp3zXxr4klUu8J3jaaYP++rjo2weM2Lp6DCPs4sLpFbPOV3bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784989; c=relaxed/simple;
	bh=IEvc23cC3czyXNqETuVossVcOEIiCltxG59+/3Dqy+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVcDmz6tOudhW5JTiGOwIOQJ5dl3UwW3HgzeRalkQOOG/kMLRK2DAuZHTjPLSGpjzQQlr/Q1/qt98FAncXu/mON3iE8j9ZT8IjUmKTiVAlBYqNJ9yEcd6OE5I2xVuj9Pn0tyHIC0Zi3KDX27gQIY9kRa4E1tDD/STu0cPpj3q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaQBIjQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778EDC4CED6;
	Mon, 13 Jan 2025 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736784989;
	bh=IEvc23cC3czyXNqETuVossVcOEIiCltxG59+/3Dqy+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WaQBIjQKqRDp4iQU/EZPDTZIpQm3MWO4xQEr8qq9zg4/yEkPIJBHI5MIko8FpdSlc
	 GgYY8zmU226FSh6FBcPySUxwLD33W/7e4NYS9v9+vAc9QHwmjQ9dTajUVHg4uzFH/z
	 qNvm20+xnu46zOYUyfycbFQECRjr6g0T0PrvpFSpL0GWaKv1JOe5cNmv36ldmcQ45k
	 wZjsswP/raj3UzHyAagwWFzPlwQmr1fOCvVQdZIM5ChvV0hJIxIQrLROo7VFOz2g2h
	 7C53IKLeHo8MDVLSudJJQ5e6ZnP87aXLyaaKFRf+lWzRHnKTncayT9vIph0fCKsbxI
	 nhBCRJMzMqXuw==
Message-ID: <95b33055-5cb4-4ba0-880f-f39a565c963b@kernel.org>
Date: Mon, 13 Jan 2025 17:16:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 1/2] net: remove init_dummy_netdev()
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 martineau@kernel.org, geliang@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, mptcp@lists.linux.dev
References: <20250113003456.3904110-1-kuba@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250113003456.3904110-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 13/01/2025 01:34, Jakub Kicinski wrote:
> init_dummy_netdev() can initialize statically declared or embedded
> net_devices. Such netdevs did not come from alloc_netdev_mqs().
> After recent work by Breno, there are the only two cases where
> we have do that.
> 
> Switch those cases to alloc_netdev_mqs() and delete init_dummy_netdev().
> Dealing with static netdevs is not worth the maintenance burden.

Thank you for the patch!

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1b2e7cbb577f..c44c89ecaca6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -47,7 +47,7 @@ static void __mptcp_destroy_sock(struct sock *sk);
>  static void mptcp_check_send_data_fin(struct sock *sk);
>  
>  DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> -static struct net_device mptcp_napi_dev;
> +static struct net_device *mptcp_napi_dev;
>  
>  /* Returns end sequence number of the receiver's advertised window */
>  static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
> @@ -4147,11 +4147,13 @@ void __init mptcp_proto_init(void)
>  	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
>  		panic("Failed to allocate MPTCP pcpu counter\n");
>  
> -	init_dummy_netdev(&mptcp_napi_dev);
> +	mptcp_napi_dev = alloc_netdev_dummy(0);

This seems to initialise quite a few things that are not needed for the
MPTCP case. But it doesn't seem to hurt, and the dummy net device
doesn't seem to be exposed to the userspace (net devices, sysfs). So if
it helps with the maintenance, it looks fine to do that.

For the modifications in MPTCP code:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> +	if (!mptcp_napi_dev)
> +		panic("Failed to allocate MPTCP dummy netdev\n");
>  	for_each_possible_cpu(cpu) {
>  		delegated = per_cpu_ptr(&mptcp_delegated_actions, cpu);
>  		INIT_LIST_HEAD(&delegated->head);
> -		netif_napi_add_tx(&mptcp_napi_dev, &delegated->napi,
> +		netif_napi_add_tx(mptcp_napi_dev, &delegated->napi,
>  				  mptcp_napi_poll);
>  		napi_enable(&delegated->napi);
>  	}

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


