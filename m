Return-Path: <netdev+bounces-104345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2A90C364
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3F42844CB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23F1C2A3;
	Tue, 18 Jun 2024 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnjzjFOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E79FC0E;
	Tue, 18 Jun 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691500; cv=none; b=DHGZy8fNcEtVyZxxn2YQHmIZb+zKXq2qDWOFB2YcdTe7qqnFlaIDqoqAIjegtlrnRo/nJ+XlFxjFb9CrFuiRe2eXJnFdmpXGNoc8IyA2H/Q7s+BJkId1LFp73Avd/mBY1KVwFY+Pjmzq9k3IV2Ik/rOfPPkl1Tc7Ptw8Bg6pB80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691500; c=relaxed/simple;
	bh=HkJdpsAULQR2xrRc3tq+4t135ZH+O+GnnLuAQ4wKgeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZ25m9IhISLz1n1bpTtup/MbBMdQSnKQErrNp6b7w5JNuTqNPzzsgcJgv9sClWL9ggVae5qIDiZDGfpKCI2BWs+9VaTlJsjyvBKHEzCful95JyUEIXDJhw9vWsaZwgDe1aPDjiMrKsf5ixEaywQKJQNL9sdOdvGNCYI2N5KEg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnjzjFOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66393C3277B;
	Tue, 18 Jun 2024 06:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691499;
	bh=HkJdpsAULQR2xrRc3tq+4t135ZH+O+GnnLuAQ4wKgeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hnjzjFOTje7evbA0tZ+lYt65js85/nJnvDSq4fXd6dD3Nygi4IfDXSnm37kjJBz6o
	 R7g51qnuTfU5EKG9PyoMSggb5UMQ/AbNpoYN2m9CBh7IAr+/5j2WCmxBmdtTQAiJ7e
	 /g0rQSVdbIuOqEn0gFXjq4mFrLxFWDtBUNlEJxynqNh4F5nl8SB2e/OVyBR+HyBTw1
	 x19CHdA9KuVvQhXafanh1NP0c6HdUjoeqQ4eRs49Jz5+H6VQN+mFBcGPM29zlGYQ3O
	 4tufcJrGtyDMCjli5MwyjaNv0u5B4+2rvzxyAp4P3b7S91MB1/Rd4bAUAlsvAVdxr0
	 ZHCNJAJKO1Egw==
Message-ID: <86512cfe-3359-4d2c-ab27-8b298f56f15f@kernel.org>
Date: Tue, 18 Jun 2024 08:18:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] net: introduce sk_skb_reason_drop
 function
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
 <5610bfe554a02f92dd279fad839e65503902f710.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <5610bfe554a02f92dd279fad839e65503902f710.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/06/2024 20.09, Yan Zhai wrote:
> Long used destructors kfree_skb and kfree_skb_reason do not pass
> receiving socket to packet drop tracepoints trace_kfree_skb.
> This makes it hard to track packet drops of a certain netns (container)
> or a socket (user application).
> 
> The naming of these destructors are also not consistent with most sk/skb
> operating functions, i.e. functions named "sk_xxx" or "skb_xxx".
> Introduce a new functions sk_skb_reason_drop as drop-in replacement for
> kfree_skb_reason on local receiving path. Callers can now pass receiving
> sockets to the tracepoints.
> 
> kfree_skb and kfree_skb_reason are still usable but they are now just
> inline helpers that call sk_skb_reason_drop.
> 
> Note it is not feasible to do the same to consume_skb. Packets not
> dropped can flow through multiple receive handlers, and have multiple
> receiving sockets. Leave it untouched for now.
> 
> Suggested-by: Eric Dumazet<edumazet@google.com>
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
> v1->v2: changes function names to be more consistent with common sk/skb
> operations
> ---
>   include/linux/skbuff.h | 10 ++++++++--
>   net/core/skbuff.c      | 22 ++++++++++++----------
>   2 files changed, 20 insertions(+), 12 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

