Return-Path: <netdev+bounces-198838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC39ADDFB0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB26189BA04
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925E2BD5A7;
	Tue, 17 Jun 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvBR/YOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291622BD022
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203030; cv=none; b=PPtzdXvar708zuUI+hetu8xmdYuJbhNq55xRw2KQv7baDN7i84FjT64x8E6Np5HdgzSLOwQY2OPHIcwD/dKnPoSrh3wLzHODJw/bhh8Zi2rblWlRg/FRH90LuGuW14MsBwPZbBJW0xUMbV7O2c8TStejWl13pg7fZBEFijLQ/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203030; c=relaxed/simple;
	bh=73H5ECTS6wNX9RBNyA+x+jh+26xq9XojuYwV90BXPe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XWSHPe9HY4djx3Lnb24u8z+0NZq7SPy1nc6FHN0IoxTaik91OAA//EQW6JF8fac5ue25JdFw6K5IAa87Nt7CPWVQp9wcUvNBDflKb8Vb3z8NZCsTR6xZHyaINCQLdAsX6iBA50Dd3V+t0/zrSU9qON21HFpUttyPI7zWNECmHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvBR/YOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0595C4CEED;
	Tue, 17 Jun 2025 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203029;
	bh=73H5ECTS6wNX9RBNyA+x+jh+26xq9XojuYwV90BXPe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvBR/YOQIqbgmo/b1QBDV/cnzAJ1AElSmrqFQ2J4ldv/KH0RgGZ7NlWDlOjD+T6o5
	 leOpRHoNOvQmLayslMISy9luGHhJYSmS2XGbL5Xvt1m5O7ObFWQtl+uaDQz3KBPozV
	 KZKYBaxurWrrWLIwc7IDmi4WYjYkMwidsKc/l3T0Zk13jjvnXgJHvM1E1QpjgHx5Am
	 YL0aKryBJnBtIpOVVcKF0gBHEpBvlfSj5O1ODdhE3B2mdR5v5tVjJVQk3EMw7FRMOv
	 FFglirm7FX+TEB9BVUuhHXTeZHUhbd+IwcTzJuaraVh0dNkWKbchrh/JrbySZQ0Eb4
	 X4il6c3OwR75Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCA38111DD;
	Tue, 17 Jun 2025 23:30:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] tcp: remove obsolete RFC3517/RFC6675 code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020305798.3735715.10987456229938172839.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:30:57 +0000
References: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
In-Reply-To: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 20:14:32 -0400 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> RACK-TLP loss detection has been enabled as the default loss detection
> algorithm for Linux TCP since 2018, in:
> 
>  commit b38a51fec1c1 ("tcp: disable RFC6675 loss detection")
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] tcp: remove obsolete and unused RFC3517/RFC6675 loss recovery code
    https://git.kernel.org/netdev/net-next/c/1c120191dcec
  - [net-next,v2,2/3] tcp: remove RFC3517/RFC6675 hint state: lost_skb_hint, lost_cnt_hint
    https://git.kernel.org/netdev/net-next/c/ba4618885b23
  - [net-next,v2,3/3] tcp: remove RFC3517/RFC6675 tcp_clear_retrans_hints_partial()
    https://git.kernel.org/netdev/net-next/c/db16319efcc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



