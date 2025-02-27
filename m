Return-Path: <netdev+bounces-170075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A8A47341
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F13AF16D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D23192D8A;
	Thu, 27 Feb 2025 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2YDOt3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306E1917FB
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625200; cv=none; b=e2RibbDuS/bLhDjmBYJ9BW7VzNMI3EKcGLxM2nLTPcri3OsLsw3IVKwYbb3TvNMcFI8ECNVJqDdF2+RDzyYDKSWPKdBZPw6flMiq7AF76JxiFlLwC2aAfU0xg2BwX8Av2dYnUwxyuz97pSSg2ur4ZVHISncsRhRz64Hg2nODiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625200; c=relaxed/simple;
	bh=uqQNpeLHw0z03XdKbicrUYYuN/2uBBdq0wc1fs7ysas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WLYl3BAe1JOmxuB/S2KF4SgVjQDhJ9z3+I7ebEyP2nP22Miq0/VYv3kLk10XpqU+E7Gfijn6PSxMVglK0Oe2rDkoYJQdUfa9Phsaof8ESdqbmOKKFJMlDQDhHuknE5g6IkiOoYgDAe4ONZb4idlmzAYvwp1HYUxbOaVcQlMnuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2YDOt3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A14C4CEE2;
	Thu, 27 Feb 2025 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740625199;
	bh=uqQNpeLHw0z03XdKbicrUYYuN/2uBBdq0wc1fs7ysas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T2YDOt3vRN5Zjg5B1aNSWL4JiOobijN0utWdVpbygAJ33OhJad+fOPJI8b2EIU3ZA
	 5CWimr27IMjYQ38AId3kSTjWZMlFjR9KCfH9LWft9fLqWA3R4bIWHnzXcU+pL8ESdc
	 X2zLESqqeKho9UnenQvf7LeaXB2vYTbGZMmF6b9Pza0d5xJnZ9OeOwDRLGy5TMx3ZH
	 lDmEDuAB0Gpqx84MkIlkLnkhlXo/UWZYyJDrErAFjWAMeunQ7qooI0B8miEsWM6xGb
	 ovzDkMuJSwDQdWYlLDJS6f9uPWlcE1ME86nVBY4cFaI5DLEIs35DTL6bH+ewX4e8Mn
	 k9p8mAzN6TCFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0B380CFE6;
	Thu, 27 Feb 2025 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: Use rtnl_net_dev_lock() in
 register_netdevice_notifier_dev_net().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062523174.949564.895279006455452816.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:00:31 +0000
References: <20250225211023.96448-1-kuniyu@amazon.com>
In-Reply-To: <20250225211023.96448-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, leitao@debian.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 13:10:23 -0800 you wrote:
> Breno Leitao reported the splat below. [0]
> 
> Commit 65161fb544aa ("net: Fix dev_net(dev) race in
> unregister_netdevice_notifier_dev_net().") added the
> DEBUG_NET_WARN_ON_ONCE(), assuming that the netdev is not
> registered before register_netdevice_notifier_dev_net().
> 
> [...]

Here is the summary with links:
  - [v1,net] net: Use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().
    https://git.kernel.org/netdev/net/c/01c9c123db76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



