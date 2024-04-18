Return-Path: <netdev+bounces-88940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1D8A90CF
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012821C21C08
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95A3F8DE;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP5gTkSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D58C1F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404428; cv=none; b=PiSX6avvpPV2T0QvGRy+fgQmvufrHsBe+svC4jGYzA/JNJlIQSp3rWHZHBMrAYH6bfCFavySXxWpWYUrMGNeb1yQvc9uEK8qO9P4x4xtvtXKoh/9n1BxsTZ7jB/pL5EbMqgBf++T6tMwIKqx7rfcByYtPyQJT4zwHJDS3rG640w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404428; c=relaxed/simple;
	bh=pm//dt2Agk5QNExT39w2soXMzVRNOAVwG/poy1yAt18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TiEIRfnCIH/rV/kESNXMWCSJOUjXF/gbya1y9AWuYKN1OpKEc+1W3DOkt8zUev5b3i6TJbFnrSZK0lJoVhGRxk86pKWiI5tmhz82IyT2wTurFHED9V/L7pd7rFUN7lqbkCGqg3pKpUoIx32qh0PbonPoaLloyj1SImzP/hPvxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP5gTkSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DFBDC32781;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404428;
	bh=pm//dt2Agk5QNExT39w2soXMzVRNOAVwG/poy1yAt18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XP5gTkSQEVmKKuiFgr/XEHNm5QjvTOMwGQE5tJvnmQEe0uESmbkYAyfZ8rh46xhDZ
	 qTIx6lLq0AhCybcyZuyQ5dEdFrgif3xKS7zgLeOjugtKCXNygzAEgkdoeu9WlNUATh
	 pS1gHiq5dM33URctwxwPgNy1G4xdfi6ZKit/6ALsTVtyaUtRmz12zFgZsCT/5ZYh+Q
	 jDiei5BBWHiTaM887aQqFTQjEXpaeUbZmD3lKVcjMdpA2BS9+Th2ZyA5P2YffsEISB
	 bBOf58rGXQcO3jVwR57zZnlSMC9Z319wr46UkUPJT1oAxGVz3QFNSrg6+aRzasrHBP
	 r2yMive7r6+8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3D42C43619;
	Thu, 18 Apr 2024 01:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp_metrics: use parallel_ops for
 tcp_metrics_nl_family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442796.27861.9767381408543638290.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:27 +0000
References: <20240416162025.1251547-1-edumazet@google.com>
In-Reply-To: <20240416162025.1251547-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 16:20:25 +0000 you wrote:
> TCP_METRICS_CMD_GET and TCP_METRICS_CMD_DEL use their
> own locking (tcp_metrics_lock and RCU),
> they do not need genl_mutex protection.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] tcp_metrics: use parallel_ops for tcp_metrics_nl_family
    https://git.kernel.org/netdev/net-next/c/ba3de6d8035e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



