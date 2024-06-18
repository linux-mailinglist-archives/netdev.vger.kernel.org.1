Return-Path: <netdev+bounces-104343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF1F90C35B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D91F23B2D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDA3A1DD;
	Tue, 18 Jun 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R86Oxj8p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945729D19;
	Tue, 18 Jun 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691353; cv=none; b=C9VVS5KNZtSQuVUoIMwnJSQlja1zcW6/VTIXxJWa6eUaVG37kwCFUhxmF92wFc70VHUTAXKU8/w4KX4pllW58p+CIPkSQ6iqJV908GGh0HOx85t+yMSZWO80gzIH4Lj2HxRW2XOHmKDM/AFJ+OUUEh4HZUsOREamDZZNJBYJV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691353; c=relaxed/simple;
	bh=OfuS3cCRT0YlKX+L3wsRDwSbLkgaX20udGS/iPVKMgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkPDAQHwEK5bQldr7NamVMjnFThX+RpluA6Qaf4pIiikjf+/6nbxnYZTqkidctKAHCU0FFd5FOwzhn+o0E8ECiNWkHrxshpqgqRTdx2Wn1R68c934gbh/sduC79FhgCNIRhq1qh9fIfeXbiKXPBiIkLT1RSfrP8S061HFeEafAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R86Oxj8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC0FC4AF1C;
	Tue, 18 Jun 2024 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691352;
	bh=OfuS3cCRT0YlKX+L3wsRDwSbLkgaX20udGS/iPVKMgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R86Oxj8pc+5yQOTSWdJNYRV65Jk3l0lHgY2vQJqS5zbiSPD2cYAp+DuOjaT4cLwTr
	 5I3x83iiB0afZJ8Zo46LtpUj6gia7iqF+cQqvwpsoK9j8tuu1XC0TO7uWFL4+lI//A
	 mgYcSDGB6JE50W6av1BJ1rV01zO1UwhsGC5AEaw0FoG7MJ8D1KrNp9J96ukpgQg7g+
	 Cw3hz82Yucrbjhkpomt37qgc+yeEI6kCwLdpBVoE+mMDK4qvf58mzlB4Sz7mFjSRUc
	 7kOS32bHj7pGDiWJeRFHO+PLza++cCfrOC6wjmN8F1mD8edvxC73EIAnV4nO8iHop2
	 3vS04iD1GQm4A==
Message-ID: <62d9ce06-8e3f-43d7-8003-977672f4b3b1@kernel.org>
Date: Tue, 18 Jun 2024 08:15:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/7] net: add rx_sk to trace_kfree_skb
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Neil Horman <nhorman@tuxdriver.com>, linux-trace-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <cover.1718642328.git.yan@cloudflare.com>
 <1c6af55f8c51e60df39122406248eddd1afee995.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1c6af55f8c51e60df39122406248eddd1afee995.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/06/2024 20.09, Yan Zhai wrote:
> skb does not include enough information to find out receiving
> sockets/services and netns/containers on packet drops. In theory
> skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
> stack for OOO packet lookup. Similarly, skb->sk often identifies a local
> sender, and tells nothing about a receiver.
> 
> Allow passing an extra receiving socket to the tracepoint to improve
> the visibility on receiving drops.
> 
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
> v4->v5: rename rx_skaddr -> rx_sk as Jesper Dangaard Brouer suggested
> v3->v4: adjusted the TP_STRUCT field order to be consistent
> v2->v3: fixed drop_monitor function prototype
> ---
>   include/trace/events/skb.h | 11 +++++++----
>   net/core/dev.c             |  2 +-
>   net/core/drop_monitor.c    |  9 ++++++---
>   net/core/skbuff.c          |  2 +-
>   4 files changed, 15 insertions(+), 9 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

