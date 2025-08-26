Return-Path: <netdev+bounces-216750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D8FB3508E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6349B1A8149C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE92550CD;
	Tue, 26 Aug 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaQqHfye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE226A1A4
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170005; cv=none; b=SIcUpW9anovGm/pUh9AQnzaNUmC+FvkKR2xgnSJe/nMvSVBa3fTf1H9r2l4ZcrpGE0IL75nar6I/ZzHtAXY8wqQMGfGcScXznkDUhPDJIV4ZkO+nm7bTAqQmI5TcdYZEGCilVheg0NEsW9+FJkHzEiCRW7uSq2ZkSBQYkYaSxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170005; c=relaxed/simple;
	bh=J3/x2DnraeVU3FW7kfgA91LNG8vtWmvlQzQ1SN+yuy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tAvy1N9Q3yck6nr8z8tiQdGzUs9wc0k6MsoFuJOq9eysGa1kS7QCZIq6nA6otrRhZ6unr2j5ZpTI8JKs63xCZYqP5H81PljKhM9XRJFeNN6VsPtyy31GlvX/qtDUNeYAX4iVUjj0LYiAayYVlN1GSPTEGBkt++U5+3lvf791Q8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaQqHfye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17056C4CEED;
	Tue, 26 Aug 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756170005;
	bh=J3/x2DnraeVU3FW7kfgA91LNG8vtWmvlQzQ1SN+yuy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kaQqHfyefVZbihHUoTXADgbpmxDBZzl4wEiRN5TZS6tIlvLBvvDudCskozzMBBdLj
	 maGhdK2kbUSN56XkwaEHv1x+thstscHUaCKEW05XnGe+zcX13iiHSEPGTTdn0eqKwK
	 kSu7709SBmcWO7ScBIcLdke2BDdPqKaEeanXWCny7SQugXyyzxhUkZzA6LwuAtL2ib
	 Mg9mOMYfwmJmRbl8NXb6Yq/8/3FSj6gbFgB/i56Gaw70yN6cxP/qVwxFQ9AD9HTNOC
	 p7xrFyuGT/Ad59qtcAcqLGj8BxS/VtN5uLRjkLirSEqv+vhe0EueR3mxzrQlMX8dHG
	 5xAHC5gbtF6Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B81383BF70;
	Tue, 26 Aug 2025 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/6] tcp: Follow up for DCCP removal.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175617001301.3612382.4616195762654179835.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 01:00:13 +0000
References: <20250822190803.540788-1-kuniyu@google.com>
In-Reply-To: <20250822190803.540788-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 19:06:55 +0000 you wrote:
> As I mentioned in [0], TCP still has code for DCCP.
> 
> This series cleans up such leftovers.
> 
> [0]: https://patch.msgid.link/20250410023921.11307-3-kuniyu@amazon.com
> 
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/6] tcp: Remove sk_protocol test for tcp_twsk_unique().
    https://git.kernel.org/netdev/net-next/c/9db0163e3cad
  - [v2,net-next,2/6] tcp: Remove timewait_sock_ops.twsk_destructor().
    https://git.kernel.org/netdev/net-next/c/2d842b6c670b
  - [v2,net-next,3/6] tcp: Remove hashinfo test for inet6?_lookup_run_sk_lookup().
    https://git.kernel.org/netdev/net-next/c/8150f3a44b17
  - [v2,net-next,4/6] tcp: Don't pass hashinfo to socket lookup helpers.
    https://git.kernel.org/netdev/net-next/c/cb16f4b6c73d
  - [v2,net-next,5/6] tcp: Don't pass hashinfo to inet_diag helpers.
    https://git.kernel.org/netdev/net-next/c/f1241200cd66
  - [v2,net-next,6/6] tcp: Move TCP-specific diag functions to tcp_diag.c.
    https://git.kernel.org/netdev/net-next/c/382a4d9cb6dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



