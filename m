Return-Path: <netdev+bounces-78601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78083875D6A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CAD283A6A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AEE3BBD6;
	Fri,  8 Mar 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2ujPFbf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3993308A
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=FxBWjRzlIIZ6wcpVu3+txtbIqBY9pqZ75sngNlu/IQKjvC7NGRFoJJUIntQp8D0QWiZ+drpykxpig6v3yKl+XAUJQqykgQn+jznuPgJrtlD9t8HJzIzQgfNLC9me8vhiKVHp+fRV8wX9lC6N7y/t3NozugYfzVG16DaGiYsZN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=OFU/zRF9ho/UBK4jYzfbx1/6FBa7Yr1HQ1/kJlFdxZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MlVq+lKXcsqiuzWcwXmZ6kf2vA1FYVQF8TLz3bj/IqRjMCWe1gGKotOW7Z2B/XsoYcG0dL9XrFetds2+bzeeLqHXnCH6xNDyOsXYx1pYFwEywRtWmOtbINxlZlQCuAqg5lSFFshR+aBMarGnSLP2Mmw5PPqkr0athXmKL1Iuc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2ujPFbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C039C4166C;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=OFU/zRF9ho/UBK4jYzfbx1/6FBa7Yr1HQ1/kJlFdxZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2ujPFbffR04ehv0HEYM9rcy5evEEDSr8NauP4Ypea8dQ8idSlgUv/se9jmdnduDB
	 hUBH0ijyxa8gqa78+8v38dvwYeGaGp1rhPAWd5Ab5IU2L/KMC5ocXZg4W3nJJ8Rzhb
	 +qX13w5OubjoGKenlfQMxFb0sXPtsHAbx95xaZDF9nwnLm1GWAtznjAJ4IZwQ2uspO
	 daNEuKL8iyV2IzsYtofl3w+rMZnFKtihqh5iWBRDj1lN+9NCz6enGKO0lOdtxrlUt3
	 D4jvU/aYuMT25YnoriNhExy7RPpuxz1gyVjfqyqX0MfPvN6qdANmiWNv44oQKeICrJ
	 00xY7Xgx2Ojkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 876C6D84BDE;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests/net: fix waiting time for ipv6_gc test
 in fib_tests.sh.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403755.8362.4504288196738104380.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240305183949.258473-1-thinker.li@gmail.com>
In-Reply-To: <20240305183949.258473-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, kuba@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, sinquersw@gmail.com, kuifeng@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 10:39:49 -0800 you wrote:
> ipv6_gc fails occasionally. According to the study, fib6_run_gc() using
> jiffies_round() to round the GC interval could increase the waiting time up
> to 750ms (3/4 seconds). The timer has a granularity of 512ms at the range
> 4s to 32s. That means a route with an expiration time E seconds can wait
> for more than E * 2 + 1 seconds if the GC interval is also E seconds.
> 
> E * 2 + 2 seconds should be enough for waiting for removing routes.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests/net: fix waiting time for ipv6_gc test in fib_tests.sh.
    https://git.kernel.org/netdev/net-next/c/4af9a0bee116

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



