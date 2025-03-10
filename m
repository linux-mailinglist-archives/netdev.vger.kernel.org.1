Return-Path: <netdev+bounces-173649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B246BA5A51E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC61D1892AAE
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7054A1E0DEB;
	Mon, 10 Mar 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjM0Q6to"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AE1E0DE2
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639208; cv=none; b=tT3IJoXsSyZzrspOt7+Y49fP+O1DVYddMFlvteygNsT1FBASi6wg7qaryK8PrcrlZI5b2q7lRIM7nz+uzy0A35Hv92JXSc+1/lTPRyAPJjsBhUS4VZmxKqjLnlb1KT1cmY6/neE6oWgNGuurBTJ1tRwc9kKrwQsVeU6Tea7GmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639208; c=relaxed/simple;
	bh=ur/XmdMzRc2K02HolxOY9a2qgpbe85bt+nhbWd7WPms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GT27ATtsxjXkBjy/R2DpzqbtbyrOTl91/ey1Guk7MvGAGmGJMnYSk/reMPF38p1aHZ2V6Fdbc7+2rtHpTtWsprrB8zcg27qx6QF1UYTszNRE77n/zR3KI7+iFX7a8HsMyWL4gp3VjafvLrON/bFZ36oDGo0ppFK7Ge/9FIIr2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjM0Q6to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2184DC4CEE5;
	Mon, 10 Mar 2025 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639208;
	bh=ur/XmdMzRc2K02HolxOY9a2qgpbe85bt+nhbWd7WPms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pjM0Q6togFZTN9ESDzIhqorr9zGs/PzXvpTNDrBb6QJ/IrYUVvc4pPvtKX0hCsgWi
	 Iv66K2s8JJaUB5ss6Uw/bUpqoT5nFSF4as2zSEZmqY1kX2hULCZyIxbm/QA+e90b86
	 LppB3Kztx1iiGw4wRGWqpR1JYMX8HmCMTtkPvC+LD7cV/6bkYAJRB8bZ2B5EYAIziK
	 vH/pnznizDLGCtC956QMq+SRSMMKhAA2sD+0Y1ihilyBP57bXkcdnVurKnp4xETTyY
	 jHg3E5Y2kOauoEr1+jMlr/yaYi0fGjfg3S1c15UrlzVGqoENVMHjurq8SgDgGNOJr3
	 IrhTpLQO4Ciag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FBD380AACB;
	Mon, 10 Mar 2025 20:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] follow-up on deduplicate cookie logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163924223.3688527.15258487720660984799.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:40:42 +0000
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 22:34:07 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> 1/3: I came across a leftover from cookie deduplication, due to UDP
> having two code paths: lockless fast path and locked cork path.
> 
> 3/3: Even though the leftover was in the fast path, this prompted me
> to complete coverage to the cork path.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ipv6: remove leftover ip6 cookie initializer
    https://git.kernel.org/netdev/net-next/c/54580ccdd8a9
  - [net-next,2/3] ipv6: save dontfrag in cork
    https://git.kernel.org/netdev/net-next/c/a18dfa9925b9
  - [net-next,3/3] selftests/net: expand cmsg_ip with MSG_MORE
    https://git.kernel.org/netdev/net-next/c/0922cb68edfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



