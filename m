Return-Path: <netdev+bounces-199978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A164DAE29AD
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CFD17854C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70977191F92;
	Sat, 21 Jun 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8q6nWZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7672629;
	Sat, 21 Jun 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517991; cv=none; b=knuwzQU1/tuCdRYwQInUBjF/JcWNTSIvIp1gPfrQaxX/OovUDUEeIMutz6kvN0VHIkpN9Df0LUjBDySgqYZvcKxlrTNGKyKxcvLiZg/J5UCJYRRL+6DTlSSu/ZlZxr1FXbrwxWlWVBInrljSmkoJGf4w71pN/G8ElmupD2s9Qao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517991; c=relaxed/simple;
	bh=9IFTSYd97DuqqHreOaWo70EA069Nr2zggBk/86tCMys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nXpEfOaVKk1+eJxLBh/6CT3XZnNPP4/Zk2+VNyAM0e87K+5uPRlJu4791TcEJ3zm8wGgjSCwwYuc4dVzoeqxpak7K4G5TXp2NNh1julM5PYqbkD0JGcMbgHtYXeVFKwkuTZHDaD6nL0Ub2KAkeTXpEJUoA/U2px8EgPl68TJM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8q6nWZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C935DC4CEE7;
	Sat, 21 Jun 2025 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517990;
	bh=9IFTSYd97DuqqHreOaWo70EA069Nr2zggBk/86tCMys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W8q6nWZhFy8dueJxM0rqyjZ3SSx083cQbHU1jipM076nHq5STdtduOMzehotCxxyR
	 mQAtJuF0HNGR3+HkEkV61qw+M+0Bn4jxFSaL5s/k9Vc6jXCHvyJG3Ng+8K8DZXYrdf
	 PTLsHHFZS8g9U6NHujxWAFpPaT/IwDCZPPrXF4ZT7Lk0SpmtQNjHHr5DKggoLvHpsh
	 AOCEK6bQPEZ6ZjEpMuL5BL7VaeqMfrpLiIUxdxoA8xviH8pttwiehF2epiu6XdWqbQ
	 BkABlRx4u2fpcvjnSgvxc2aODP/tIaN0sKxWibraRKDFnYIUUiOAdR0EZfYLv8mRbs
	 1kzC3Gtne6uVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBC38111DD;
	Sat, 21 Jun 2025 15:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netmem: fix skb_frag_address_safe with
 unreadable
 skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051801849.1877807.4023369290062514193.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:00:18 +0000
References: <20250619175239.3039329-1-almasrymina@google.com>
In-Reply-To: <20250619175239.3039329-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ap420073@gmail.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 17:52:38 +0000 you wrote:
> skb_frag_address_safe() needs a check that the
> skb_frag_page exists check similar to skb_frag_address().
> 
> Cc: ap420073@gmail.com
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netmem: fix skb_frag_address_safe with unreadable skbs
    https://git.kernel.org/netdev/net-next/c/4672aec56d2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



