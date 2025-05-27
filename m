Return-Path: <netdev+bounces-193576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65707AC4954
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C4E188F89B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76822756A;
	Tue, 27 May 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVP4FJke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3F226D1A
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331002; cv=none; b=s/lGRi3Ye8i5CTzBW7J6WXhtqZIBQfnQvHpytEv/RoJwiorCNSu2WiKsEO1YgyjzDOyggoyDfn7qCaEWhAB1e1U1afwIvWEIpdjYtHWS1owiQ9F+u+GBOWHA+HAMxRLkNP3JeUXU6FfRwWyEHy4tLEl99groksWJu85XEZ3qKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331002; c=relaxed/simple;
	bh=AWI9kLnuT1AtAxgKH1AkVSteeqPunoTZVDJNBNfOALw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kt98hNsj5gKE/uPC6V3zYkSjx5T8EMbUlPsrzaVo61WRybA9B0Jk7XMeVxma3e/tCAdhbkzAa90Kv56m/F1UeajNczpTRVlOX9on25O4w2pTDv8hawGA3Yb1FJBcYUzKAkUOvOgp1Og3e6QL7GK0O0QfglxrLRrkv+dSSRhqOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVP4FJke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D96C4CEE9;
	Tue, 27 May 2025 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748331000;
	bh=AWI9kLnuT1AtAxgKH1AkVSteeqPunoTZVDJNBNfOALw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lVP4FJkelbIVpXLfcuGze4rmAknEq4bCjVL8jtFLJqrrkOjLT7G5xgyj9bNj5Zexz
	 HvP0nPwcYtXt/maJhJIoRuzlQ+l1TBjXtL7W+ngqMWmtdnZ5VM8H5VNOQGoWmfwPjF
	 ieUfHTatBEz3jFY7p3SQYi1n+bWnQNYuV/nDvXg0Y6Jmd0ZexJ6uuU0f7UXnO6nY8p
	 0RHuAjUkkOyi6+h/BCLce4AgolBwg0YSBGN137GR7IGJYFaosFsw+rUXx83Y+nMgz/
	 e77Ndt5ftoxdF7fndY2osuA3yTvhfmN2/NHYjYQlsa59GdzTjZ6u2J79sdzj8S4q1H
	 OiXDEwTz0DwTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E06380AAE2;
	Tue, 27 May 2025 07:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] wireguard updates for 6.16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174833103500.1194728.8228604988048864577.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 07:30:35 +0000
References: <20250521212707.1767879-1-Jason@zx2c4.com>
In-Reply-To: <20250521212707.1767879-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 23:27:02 +0200 you wrote:
> Hi Jakub,
> 
> This small series contains mostly cleanups and one new feature:
> 
> 1) Kees' __nonstring annotation comes to wireguard.
> 
> 2) Two selftest fixes, one to help with compilation on gcc 15, and one
>    removing stale config options.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] wireguard: selftests: cleanup CONFIG_UBSAN_SANITIZE_ALL
    https://git.kernel.org/netdev/net-next/c/e74e9ee2c800
  - [net-next,2/5] wireguard: global: add __nonstring annotations for unterminated strings
    https://git.kernel.org/netdev/net-next/c/71e5da46e78c
  - [net-next,3/5] wireguard: netlink: use NLA_POLICY_MASK where possible
    https://git.kernel.org/netdev/net-next/c/c8529020070c
  - [net-next,4/5] wireguard: allowedips: add WGALLOWEDIP_F_REMOVE_ME flag
    https://git.kernel.org/netdev/net-next/c/ba3d7b93dbe3
  - [net-next,5/5] wireguard: selftests: specify -std=gnu17 for bash
    https://git.kernel.org/netdev/net-next/c/ca8bf8f38334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



