Return-Path: <netdev+bounces-131237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BD98D740
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638641F2468E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4711CF5FB;
	Wed,  2 Oct 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR7DiPCX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4329CE7
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876857; cv=none; b=A9JSbljFsREwEF1q4zaKJZJKeahB3jGtdNzE2dq14Pk7/gsVit6kH2gXjgJEhvx6r82fBEPmNOJHA75xufYUFRAuktuSN2UHOG2sq/iGwa5937i8pyWCLF9LA07/vqWc2enwTB3yrUzNTKYqR3Bf643yIpqvf/2Mec8lREC4SA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876857; c=relaxed/simple;
	bh=+dWXrkj8wj828iMjni3BKi2k8M40IKLtAPYQkmtZ9cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ggg21vDnD8EzSD5Jsa8rF/AsTnZ2KUAKvCg717hjk7K10FpkPjh8wKlNXXOv1vLiPZk4aeBe12zX7fWdSeJGE5OT0YQaTb7qAmWawtDTiQ8azg5MixYeM//WaRjFWIkQPhkns0xusQkgzETzF1AxvNd+qaQJTyfPU/OOlJgINAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR7DiPCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80679C4CEC2;
	Wed,  2 Oct 2024 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876856;
	bh=+dWXrkj8wj828iMjni3BKi2k8M40IKLtAPYQkmtZ9cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FR7DiPCXy7nI2TD83k3CwzAYFQeIAPPmwjQS5pXY9hhwoHuJ5ChgauPnfxXqCq7wb
	 6UvexysrYRdAVssic/caaUUK88siqMrqL2R0QMQGT96m0TUxT+sQfM0l4QbyTzTyu6
	 ziTc6QbX9DWc2QRuusX1+RimxYzqADE82wemnDmXfma6VxvOzr7FoxmzamMb3sMN2q
	 sxmaJXCcvKfdx106gL5FKyhrj9oj2DlJiCoPuWaQRPLlXtMner7L3aZ7yQxDSKZjlt
	 eTaNLl0HZbRNOsQmwZBOfan2Zgy0+yFQyOyDQfa5SENLtQjQ9cwxLcO2pOWsEnadUO
	 QX4xN1Zpf3ZLw==
Date: Wed, 2 Oct 2024 06:47:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jeffrey Ji
 <jeffreyji@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON
 device attribute
Message-ID: <20241002064735.5b1127ab@kernel.org>
In-Reply-To: <20240930152304.472767-2-edumazet@google.com>
References: <20240930152304.472767-1-edumazet@google.com>
	<20240930152304.472767-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:23:03 +0000 Eric Dumazet wrote:
> @@ -1867,6 +1868,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  			READ_ONCE(dev->tso_max_size)) ||
>  	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
>  			READ_ONCE(dev->tso_max_segs)) ||
> +	    nla_put_u64_64bit(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
> +			      READ_ONCE(dev->max_pacing_offload_horizon),
> +			      IFLA_PAD) ||

nla_put_uint() ?

>  #ifdef CONFIG_RPS
>  	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
>  			READ_ONCE(dev->num_rx_queues)) ||
> @@ -2030,6 +2034,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
>  	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
>  	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
>  	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
> +	[IFLA_MAX_PACING_OFFLOAD_HORIZON]= { .type = NLA_REJECT },

Let's do this instead ?

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a520987085..a68de5c15b46 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1975,6 +1975,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 }
 
 static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
+       [IFLA_UNSPEC]           = { .strict_start_type = IFLA_DPLL_PIN },
        [IFLA_IFNAME]           = { .type = NLA_STRING, .len = IFNAMSIZ-1 },
        [IFLA_ADDRESS]          = { .type = NLA_BINARY, .len = MAX_ADDR_LEN },
        [IFLA_BROADCAST]        = { .type = NLA_BINARY, .len = MAX_ADDR_LEN },

