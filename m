Return-Path: <netdev+bounces-125050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B8096BC05
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE7AB25B87
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2A1D4175;
	Wed,  4 Sep 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP19CWjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CB1D0144
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452431; cv=none; b=oWxVegzCm617M5LVXKqUqmXXf+Tg8XQUyi/3GGxeb9gf21eZyR2SCrHJyqoYHgGMrhm8aopQwRiz2rTLn6gxsT4RgwKBkkcQQYXjK1t2I9yqA9+oBKfNLqFgxPtY2lQnbiL7f4BviouiAsAYVqsEdn3JX0jY5zTq3BnXm/2arxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452431; c=relaxed/simple;
	bh=o64GG+5u6XIHijZKyVeJlVspplZhN5O6GF7DP2hLvE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQ+N7MeaIJSAL1OBUF4TXDmfY8kjw4D8m5TghC0cHTMCZWU1VUVhSddccZhOCfghEKYYk9LLTt0tHQgx6o/aRnvZeW7Q760I/5jg/c0ilG/3TWSb01ouPHqthwo3OgS4XlsGi2VEcURUwbe44pYmiegu4O7FZO3iq8z9TxcisPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP19CWjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8712C4CEC2;
	Wed,  4 Sep 2024 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725452429;
	bh=o64GG+5u6XIHijZKyVeJlVspplZhN5O6GF7DP2hLvE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cP19CWjlpnJmRUeYrZPtNho9PzIxpfybLzteQl931Isn2rYECLrh/JyxQ0mjHhrGO
	 sniH/azH/qERXdmTs4NnPRFzTm/jKdEuDmwa5DelSFWeadgsawfA+G+wppc3cNEinS
	 hrU/avqhVSysPXm+Wk7KAmb6eE3iqPtDB/K0XlxS5Zu83IVVrLCzvtAOBtOGECxXNE
	 76+vMuxv0/2lItq/CBVPC0MFgFd5KklEHmhTV8+1NFVbMQmb9SqoCjV2UXQd4boioD
	 Bk54v+uX4+5eSJcpF5VSGkfmA247Mr4sWSPQzrTQo8GgRSEmyur8MbFx/6ThFzWHIc
	 M5nRsouPYAV8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB13806651;
	Wed,  4 Sep 2024 12:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] eth: Add basic ethtool support for fbnic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172545243051.991376.8496396240105346508.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 12:20:30 +0000
References: <20240902173907.925023-1-mohsin.bashr@gmail.com>
In-Reply-To: <20240902173907.925023-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, sdf@fomichev.me,
 jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  2 Sep 2024 10:39:05 -0700 you wrote:
> This patch series adds basic ethtool support for fbnic. Specifically,
> the two patches focus on the following two features respectively:
> 
> 1: Enable 'ethtool -i <dev>' to provide driver, firmware and bus information.
> 2: Provide mac group stats.
> 
> Changes since v2:
> - Fix v1 reference link
> - Fix nit
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] eth: fbnic: Add ethtool support for fbnic
    https://git.kernel.org/netdev/net-next/c/bd2557a554a0
  - [net-next,v3,2/2] eth: fbnic: Add support to fetch group stats
    https://git.kernel.org/netdev/net-next/c/4eb7f20bcf06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



