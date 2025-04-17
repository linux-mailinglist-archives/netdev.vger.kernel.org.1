Return-Path: <netdev+bounces-183582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA4A91149
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203361908066
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAB1B87EE;
	Thu, 17 Apr 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1G/f14D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451B1B6CE5;
	Thu, 17 Apr 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854019; cv=none; b=V/2ZfCCpf8IrW/S8EkVeL5I7Eoo6Ou5Z6LV/xsQGOgRasYF+VNo/AbdM4nolR2A4OhIsHflVTRDlGhJBRrblsyHNh4BObZAoiUMtaNo54CBHvWNcMz3E4xmMivK6KW3NPioDZ9mEWqUWsqzR0mVgbaoXhHXLTrzCJnsErS1tkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854019; c=relaxed/simple;
	bh=Atde5Ks7I5Aac64xStcrSlU/c79sYdeoyG+S+K2z4uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ApTIh0nUTzF6FolFsqfG9xqD8B5YLXt6KaamctGJGdjJW/XKSszOOrh1uAEtxh4sXhbgxY1PYvmyzAb8yuGpM9D7AQPikHgCydoZRuNYTqiZ9LHcr5OYQLRDcxnU9lFBG6EFwGQN1qFsv1oZktatBil90TGhGesHJB8PtiXoMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1G/f14D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31189C4CEED;
	Thu, 17 Apr 2025 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854019;
	bh=Atde5Ks7I5Aac64xStcrSlU/c79sYdeoyG+S+K2z4uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1G/f14DWRpziXuvQorgSN9J5TnNgykVNUEm3eJqY8/ayPoSxy4xpuPb7FwSssNJ9
	 ACs30uGTt36os0HVUphY2nnDke0W1sgfhxhSFMUfMehAYAkemvzrT0/DiSvRqX97ID
	 jdXmhfUBKi8v37uZtmOGJFDkotgobuD2kLyamLRM/L0UrkLdrfe8/iDJoIXKcNe4z7
	 ryy1JoLcrBMFhQMINkXPVxenu12rTrK6XgddeXdEjSftYHZ3sKRvOY8WaPEkX6Z88f
	 AlwpawdF+GjrZzIxD7Qebh6JiCd9d2/UJzy1RrMAReiuay2aFkx4tQrqNH68yweqCI
	 BletXGCmkYn9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFD3822D5A;
	Thu, 17 Apr 2025 01:40:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] Adopting nlmsg_payload() in IPv4/IPv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485405708.3559972.2924998558882407129.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:40:57 +0000
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuniyu@amazon.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 12:28:51 -0700 you wrote:
> The commit 95d06e92a4019 ("netlink: Introduce nlmsg_payload helper")
> introduced the nlmsg_payload() helper function.
> 
> This patchset aims to replace manual implementations with the
> nlmsg_payload() helper in IPv4 and IPv6 files, one file per patch.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ipv6: Use nlmsg_payload in addrlabel file
    https://git.kernel.org/netdev/net-next/c/5ef4097ed155
  - [net-next,2/8] ipv6: Use nlmsg_payload in addrconf file
    https://git.kernel.org/netdev/net-next/c/6c454270a851
  - [net-next,3/8] ipv6: Use nlmsg_payload in route file
    https://git.kernel.org/netdev/net-next/c/bc05add844fc
  - [net-next,4/8] ipv4: Use nlmsg_payload in devinet file
    https://git.kernel.org/netdev/net-next/c/7d82cc229c09
  - [net-next,5/8] ipv4: Use nlmsg_payload in fib_frontend file
    https://git.kernel.org/netdev/net-next/c/b411638fb925
  - [net-next,6/8] ipv4: Use nlmsg_payload in route file
    https://git.kernel.org/netdev/net-next/c/d5ce0ed528c4
  - [net-next,7/8] ipv4: Use nlmsg_payload in ipmr file
    https://git.kernel.org/netdev/net-next/c/04e00a849e7c
  - [net-next,8/8] vxlan: Use nlmsg_payload in vxlan_vnifilter_dump
    https://git.kernel.org/netdev/net-next/c/9b1097a4108f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



