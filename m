Return-Path: <netdev+bounces-178747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE12A78AE1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE671893054
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9D1EA7CA;
	Wed,  2 Apr 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A35wde/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1001C8603
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585528; cv=none; b=IaqPMR5MslKut+g7DleKJ5LjyKXPp4UD99cyd3YmqmMMgZG1xnLq859j7yTM56DfSEqLMH3335bnKIydCzrHte8bi+Fm6LKm/l3NtMyZVyQpW5fK+ESDwS/fzm58RQvKVsu+eU3nALuvB+aTClXdvl/hcHELXw09iH1da6ziNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585528; c=relaxed/simple;
	bh=5tIe8AeVL6EBQa5t0+y75Fl7Ur7DEdYANY/Fo5BBG6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJN/jc2DJs/tqDHjBjWShsYpb+O/zlo7pSrC5j53RhVe/6ORteyV3V5HRJi1LtpYkRjiL3DsdBM0JdUhd+fsigP2Vn40ExqQQeiFt1UfSoEeVLyBfEWk2e8Z83BSXUkQnBXssyOKrBlHP0dp1e+XkTy2NohMnneiFYVXnTifjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A35wde/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C82C4CEDD;
	Wed,  2 Apr 2025 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743585527;
	bh=5tIe8AeVL6EBQa5t0+y75Fl7Ur7DEdYANY/Fo5BBG6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A35wde/QyMw3yzwM1k1NFa6JQX7c6K9gXFrs8Ds8Plwam+xYnCnY4j6/TI2znhuze
	 hVA17vUwm/TkG6f921PN+XwXwFgModlvFZeKwoO79OettZjDjhQd9P2mm0H69kFJNP
	 aqdfSd4i69vQrR7QNsTawPHK7FtWnUVEEg9xBhmxEDqJRlxXcOF0O2n1QlbwoBPVBj
	 RYfJBNwE6nryhKZ0+0/kfYNtzRFaAvTtdfH+VVVgOyWNzKxOHNjVJUIAZcpDLW3Jfk
	 47IUfJh+m3oHqyHQWVzJyDODRzYXNB+7ZvftAEfIa0sag03sRkJYePa9TuL2J0t2ho
	 VIv933X1w16zw==
Date: Wed, 2 Apr 2025 10:18:44 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] rtnetlink: Use register_pernet_subsys() in
 rtnl_net_debug_init().
Message-ID: <20250402091844.GI214849@horms.kernel.org>
References: <20250401190716.70437-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401190716.70437-1-kuniyu@amazon.com>

On Tue, Apr 01, 2025 at 12:07:08PM -0700, Kuniyuki Iwashima wrote:
> rtnl_net_debug_init() registers rtnl_net_debug_net_ops by
> register_pernet_device() but calls unregister_pernet_subsys()
> in case register_netdevice_notifier() fails.
> 
> It corrupts pernet_list because first_device is updated in
> register_pernet_device() but not unregister_pernet_subsys().
> 
> Let's fix it by calling register_pernet_subsys() instead.
> 
> The _subsys() one fits better for the use case because it keeps
> the notifier alive until default_device_exit_net(), giving it
> more chance to test NETDEV_UNREGISTER.
> 
> Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2: Correct changelog
> v1: https://lore.kernel.org/netdev/20250328220453.97138-1-kuniyu@amazon.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

...

