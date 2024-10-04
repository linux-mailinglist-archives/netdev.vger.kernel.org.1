Return-Path: <netdev+bounces-132229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B6499107B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A28282DC7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F771D89E6;
	Fri,  4 Oct 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMQrydxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424901ADFEE
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073307; cv=none; b=XZt40/+SoTEGe+/3Kn6mFKnfjAh7LqQ0lUgvq/Hoxa2pWR4kwGui1FEB6bTA+bOlpIvKYyAOUD9gzxr+P0XDEdPbQKsCQKMGakfjVUK1WJnX0brYbnxMB/fLrzwW/Y71xfzwnrbi9PyJGarl4RJ8aReWA7qchf/h4MnzEMn76Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073307; c=relaxed/simple;
	bh=CvTE9ISyfN8FGRxPvET32LdoFai78JMFlJAgZjx2CgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3akRsk/wsMl6jVn8mDJ0Hvur5TMV49Xuimi84Hu+S/8RPMdaSzo+J4x9T/Y9R9oPsN4eq0TtAf+8hIAX0adANUTQab5qQFIhUfAR5RUbPh/3cPWDhSTfuWLQaHVPRmQse7kawgja7mwv3KFvw5o5EIOHcJVk0kg1QlsFu/BC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMQrydxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF5C4CEC6;
	Fri,  4 Oct 2024 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728073306;
	bh=CvTE9ISyfN8FGRxPvET32LdoFai78JMFlJAgZjx2CgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMQrydxuDDjPUPOgHnVHgX96F547jrutsG01zEVzwUtKsY46sn0IcMDmDEsV6DOHY
	 zRozSd1x8syLIpkVlKKxsUrAennN7eBQJKNUeAehl8IZjlthZ7eotuuEIrn2KcUZg0
	 gaF8Hxz82TK1GcJULelXreoA/Lif81Rrg9nYqTXiIKy6nwDhNl5Dq49f6UC0oo5sq2
	 McuCzxem+HM5yF2aU/iWQmovMYDGlZHDkfn24KoGpPZfUTCYAVaBdltXEZ8SWIGVhn
	 6lRtI3aOaKSO/WTGkavr/gzr/WENX1FX4Ay0LikZZ1EEVFY/c6OWZCKP3HN/xkV2Ki
	 Cf6iKYptVEHBA==
Date: Fri, 4 Oct 2024 13:21:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/4] rtnetlink: Add per-netns RTNL.
Message-ID: <20241004132145.7fd208e9@kernel.org>
In-Reply-To: <20241002151240.49813-3-kuniyu@amazon.com>
References: <20241002151240.49813-1-kuniyu@amazon.com>
	<20241002151240.49813-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 08:12:38 -0700 Kuniyuki Iwashima wrote:
> +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> +void __rtnl_net_lock(struct net *net);
> +void __rtnl_net_unlock(struct net *net);
> +void rtnl_net_lock(struct net *net);
> +void rtnl_net_unlock(struct net *net);
> +int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
> +#else
> +#define __rtnl_net_lock(net)
> +#define __rtnl_net_unlock(net)
> +#define rtnl_net_lock(net) rtnl_lock()
> +#define rtnl_net_unlock(net) rtnl_unlock()

Let's make sure net is always evaluated?
At the very least make sure the preprocessor doesn't eat it completely
otherwise we may end up with config-dependent "unused variable"
warnings down the line.

> +#endif
-- 
pw-bot: cr

