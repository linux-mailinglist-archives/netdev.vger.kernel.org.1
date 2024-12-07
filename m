Return-Path: <netdev+bounces-149877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06229E7DF0
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 03:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5171889324
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84385628;
	Sat,  7 Dec 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBmpZEpA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CF83CC1
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536829; cv=none; b=RX2zClO80udgUqanZrsDCpKCeFv37uYP2r1LhiGV1J3VjABwbJ1hEwvQS359U4TOotQWOtkv43Dr4GPMrO+HopfnyABYQC+pacjhgvou0qgovRfoqASGmgfoQhfsLUkiXJj/2+mC4thB9WZ5gMBHeSZ9tEyVPPb00NW9ksVsZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536829; c=relaxed/simple;
	bh=W7G/k3Y/uaVaVP+gId1YWFSVeFfnxUSAQVsRZrEBuS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ez6/0APP3q7xbeOmw//qDLat+ALT6mwFn+PWJFBbjwRT+7zWtG0pDI1z8MlpzzH8s5w2tLumkvRx7ImVUGabRJCJ309oNW/ldlbm+webDK6L1UZBGXoLgb0f4x1llAEZXphh9jewYS0K8etBEm8rC6aAmS1Ci2iJDvmTq8d4UZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBmpZEpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE0BC4CEDC;
	Sat,  7 Dec 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536828;
	bh=W7G/k3Y/uaVaVP+gId1YWFSVeFfnxUSAQVsRZrEBuS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VBmpZEpAdQmvHjkZVzsARvv4rzNuWpwD7dyWwGGCU3EOL2MsILBJf+wydw9swDdrH
	 tkRZTBvpKOgCCPxfPLFOqpAtbkxW6CQOvUDWKUatWbeaoKfCHbB8WUp7dRgG2UCbKa
	 uLCQwvLYyCb68wyx+UYE+RsAJidBeknMex/C7YgG4zskUnxJZfSUEspeVVZboH++0l
	 Y6Pngeq9hUtfMRyxRtmyRaKIFLDi9+66Hxo/20V/TApayo46JAmwuvF6EleoGNPU+e
	 rgVwRkw9Xkzt33dKy3tBdiHSazwxnfq7uKQgPbetLj6pPy0OFNzGuwxJdIMfyiYUDk
	 /hM1p9JljEu2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD68380A95C;
	Sat,  7 Dec 2024 02:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: tipc: remove one synchronize_net() from
 tipc_nametbl_stop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353684352.2872036.6433917524896551776.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 02:00:43 +0000
References: <20241204210234.319484-1-edumazet@google.com>
In-Reply-To: <20241204210234.319484-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 jmaloy@redhat.com, ying.xue@windriver.com,
 tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 21:02:34 +0000 you wrote:
> tipc_exit_net() is very slow and is abused by syzbot.
> 
> tipc_nametbl_stop() is called for each netns being dismantled.
> 
> Calling synchronize_net() right before freeing tn->nametbl
> is a big hammer.
> 
> [...]

Here is the summary with links:
  - [net-next] net: tipc: remove one synchronize_net() from tipc_nametbl_stop()
    https://git.kernel.org/netdev/net-next/c/6c36b5c244d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



