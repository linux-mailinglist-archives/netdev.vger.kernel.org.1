Return-Path: <netdev+bounces-178426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD7A76FB2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261621885CB4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C2E21B180;
	Mon, 31 Mar 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJglLtz+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411E215181
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454463; cv=none; b=KdY7Mc+MhCDxraCbMHJOBob0YlMR8pY+R1giYB7dbI5/oTGvtvSPL39zHkhIIPaQA+M8v+x6KNHZSRu8dbifgeHE6+a+8Qk43ognw/OoCxRbq0waOZxhYjTPNi8RvHVXPIop0BPVIaDmYhvJCfjKsJp4knSS2DwqtdP8OU3PNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454463; c=relaxed/simple;
	bh=SFnS1ZnSLLX2JrX3YwhFtgGoroyRHaggsKIdRWBPHqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtkXczejVaZIZqMSYd4+Rgs3rKlmFpHClZs2USPeZIDHU6U2yTPI1bvoJHnnZzJLLkCR7WYLE4/vvN4HppJB67QlXYHMEd2nUBHUZCN9w+2r6t9Sk8RH5ptnjUgW4jgoGpNVLpgnBv5WGJhsPRGWHHM/M8F/sGLMxlwrCQ+kqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJglLtz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCF1C4CEE3;
	Mon, 31 Mar 2025 20:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454462;
	bh=SFnS1ZnSLLX2JrX3YwhFtgGoroyRHaggsKIdRWBPHqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vJglLtz+4Y3DbS0X9TT1RDr97uRKIyT30DNIyLou4jFHVZt11JBN9UV3gIg07iLKK
	 2pW0OxgZu5l5KsZQQIwASM897vNIp6EmWXiQrWaacKxejcZR/asGtAbRgmowzeVVr2
	 MObJg6kY3L1voGfzy+gUOxdDf0Ljk3S5+jEUJRUrjfV8sT5cP/92Cn6+ueyyO5l76n
	 HpJNXjMjUavq1UkeXKmXO1n9Rd6dYk6E/+6ZnjX1Z6YzJZc1Z4eJZvB6mKs0KZE0TG
	 YADf6Nj3VRXRLip/N2bv39UlMPI7w8HZu41G0jZVebCsYLkybFkRpv0lyVhqnrPvrb
	 jIqOF4BmzgyCQ==
Date: Mon, 31 Mar 2025 13:54:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v4 05/11] netdevsim: add dummy device notifiers
Message-ID: <20250331135421.018c49db@kernel.org>
In-Reply-To: <20250331150603.1906635-6-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
	<20250331150603.1906635-6-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 08:05:57 -0700 Stanislav Fomichev wrote:
> +#if IS_ENABLED(CONFIG_DEBUG_NET)
> +int netdev_debug_event(struct notifier_block *nb, unsigned long event,
> +		       void *ptr);
> +#else
> +static inline int netdev_debug_event(struct notifier_block *nb,
> +				     unsigned long event, void *ptr)
> +{
> +	return 0;
> +}
> +#endif

Maybe we can wrap the while notifier setup in

	if (IS_ENABLED(CONFIG_DEBUG_NET)) {

instead? We don't expect more users of the event callback, and it may
be useful to give readers of the netdevsim code a hint that this
callback will only do something when DEBUG_NET=y

>  #endif
> diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
> index 7ecd28cc1c22..506899164f31 100644
> --- a/net/core/lock_debug.c
> +++ b/net/core/lock_debug.c

> @@ -66,6 +69,7 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
>  
>  	return NOTIFY_DONE;
>  }
> +EXPORT_SYMBOL_GPL(netdev_debug_event);

EXPORT_SYMBOL_NS_GPL(netdev_debug_event, "NETDEV_INTERNAL");

