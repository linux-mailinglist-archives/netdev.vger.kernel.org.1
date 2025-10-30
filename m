Return-Path: <netdev+bounces-234252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB32C1E20B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C00D3B40F0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B93164D3;
	Thu, 30 Oct 2025 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urtn5yYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93330102D
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791430; cv=none; b=sbpxfGo8du+yHOgp6G9BazeKf3g5ZZqCQbioY/IZaLvtQMgCa2wG8ihY8QzA2JmwL8Q+2NnvsyFum1QzdN/oOvAI7A8yRvC4a3ix9GckvmVjaV/l7znXZBO1KMXN0URR26gd2Zk+Jf5WzqqAsVoxMpsCz9T4hj9qIRErHufNRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791430; c=relaxed/simple;
	bh=H5iRGN53u1S64+Dt6v939iz8m7g/yJdAtgJPzjDMvJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LPT7DTF94EWej9W4JkbUvOFZvSQV5OW72n3ISfwT9K2ZcwjSTyiWvmsXic4+0xuf92PMTEG96d5wWWBy0xwylDWZURHKsq7cUqeDI0I9dgAxhnZXQOXxc9D5qfVQGroUG2peOSeSdQaBRcwV+3WbCYDBCFhfIrNw+6xg+6ceQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urtn5yYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CA2C4CEF7;
	Thu, 30 Oct 2025 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761791429;
	bh=H5iRGN53u1S64+Dt6v939iz8m7g/yJdAtgJPzjDMvJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Urtn5yYrLwnQNmJ+K0sz2lP9GJHPiC4NILjd5o8fuKmImfukkCJfFbvs9a91laRBs
	 KRHdwubig8uBaYWPRID0hAXB2/5y8SQkdpa9Fvol8Rc8IRpv2EzE5VItOWW/8qCvuN
	 Oa74NhvXIWstUzO15aOhAzuvEzPubvye/xOFbnJ0xc0/wFl6cdD1iVTxUiJrO8/JWf
	 kQCwK8toYNyBrGkpJKO8xXrUJzi2o3VYh99HkWoE+Fo2JndWWvjOxPTqlhUHk4me/C
	 ndVh0SsIGSgHwdZFYGSdyPtgJSQxH2fiS8Xlbp9pdHwZ1lq0zne9bAq2F6UJEdcX4a
	 KaykCNXX01jGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11B3A55EE0;
	Thu, 30 Oct 2025 02:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: devmem: refresh devmem TX dst in case of
 route
 invalidation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176179140676.3289294.5372826777029403419.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 02:30:06 +0000
References: <20251029065420.3489943-1-shivajikant@google.com>
In-Reply-To: <20251029065420.3489943-1-shivajikant@google.com>
To: Shivaji Kant <shivajikant@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 sdf@fomichev.me, asml.silence@gmail.com, praan@google.com,
 bobbyeshleman@meta.com, vedantmathur@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 06:54:19 +0000 you wrote:
> The zero-copy Device Memory (Devmem) transmit path
> relies on the socket's route cache (`dst_entry`) to
> validate that the packet is being sent via the network
> device to which the DMA buffer was bound.
> 
> However, this check incorrectly fails and returns `-ENODEV`
> if the socket's route cache entry (`dst`) is merely missing
> or expired (`dst == NULL`). This scenario is observed during
> network events, such as when flow steering rules are deleted,
> leading to a temporary route cache invalidation.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: devmem: refresh devmem TX dst in case of route invalidation
    https://git.kernel.org/netdev/net/c/6a2108c78069

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



