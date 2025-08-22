Return-Path: <netdev+bounces-216171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FCB3255C
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E6B620689
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202A279915;
	Fri, 22 Aug 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J52FOqSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587F1BC4E;
	Fri, 22 Aug 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904801; cv=none; b=DhWnc0OAl80MxPBNhaqEGQofPkmV2D+ykTIPa51hOsJu9ww0Yjgm94mNCo4itKuiJzs5CZs6pr5kASvHoMZKSnBZlnjD1t0INrNZVGGk2VjA/g37euxexWqiLKC37PZkE4trLtLP+IQlez4J62O40LWoOyNaDtsgu7SPUC9fGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904801; c=relaxed/simple;
	bh=b0145TecL6AiWliykubpQbxXyN0lq6fu7ZWZv2P6DPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ozkIeZTeXqezPqGeUks7LMv7BTK2mhQ1aCVrXocZdwttvUfWpecoKak4vjTPiU7Q3050LkYMi9sM4Ykqq/YJTue/rDnhorZ1exJmkDDyLvUNm29NTpaKNqWCaAPDy7v/lsLK+t4BeLeugV1MVjhTp2gTQNSswP1R+y/vx0Er3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J52FOqSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C166C4CEED;
	Fri, 22 Aug 2025 23:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755904800;
	bh=b0145TecL6AiWliykubpQbxXyN0lq6fu7ZWZv2P6DPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J52FOqStkrYagAsCwkBnGSJ2MKCIYOvZhT63LHdoLXpvbvAy2ZjEBRUGQhCZW8j50
	 fqPjx58ft6n2dliK1zB96ih+Wm4yzDfuALONKyWC2TWgeNNSGKR/E4SkEn+pPq6Wi2
	 4i9NRW99lG0gZ9MjfxU9+XBMV4j1+5RCufDv7DFpdWsaANgkrBG0OtIoWS4DoX0pjH
	 FkTgXzG8bk0VltIB3s/k0UtDUWTyJ+fFHT3eJeoG4DFCQmoJwZIalIeda/MBdQ2wCW
	 vnJlguN5KpUYlH/VHOSxw/TWtzgffPvAmfDWwnqGHXyHHCjzGdZFpvImok5BB2qm9i
	 G3mE3Ge51F7dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A89CE383BF69;
	Fri, 22 Aug 2025 23:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-08-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590480950.2028930.1900073054090928591.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 23:20:09 +0000
References: <20250822180230.345979-1-luiz.dentz@gmail.com>
In-Reply-To: <20250822180230.345979-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 14:02:30 -0400 you wrote:
> The following changes since commit 01b9128c5db1b470575d07b05b67ffa3cb02ebf1:
> 
>   net: macb: fix unregister_netdev call order in macb_remove() (2025-08-21 18:38:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-22
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-08-22
    https://git.kernel.org/netdev/net/c/1559c9c23110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



