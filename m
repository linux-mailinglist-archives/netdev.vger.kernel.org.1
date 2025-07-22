Return-Path: <netdev+bounces-208846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED1BB0D646
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1D6171155
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781E24169F;
	Tue, 22 Jul 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpYEK0MJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464E273813
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177794; cv=none; b=iggdVmEL1VM5lBHg1VQDmWU6DlioqzPwDOKZui7UzKLC1XW97POOiQkBH3P1r1ipagQ/Q0NnKwgRiu1Iu8Af7mFtMgmauOib/9Kuzcqnec6MUak8qN8I0cFQNovbCmRJD3ri9EwR34Ae0is6IkgdZpdptCh4d71CZSeFkjCnVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177794; c=relaxed/simple;
	bh=9h0C12PnlrEBqH7bHuilBBxOHLz9y1+B1tRkmC3wTDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vCfCoG8Rehvhp9yIkb6WiCeZgyXgjE3Gb6hjSSC0SKFhskkWUp339sAHzAEC9eQ5fS49Az/kXH35awhjEK5mQwlyua3rdLMlLvunwNT8CG4anajjL6UoES7KYD4d2dVML4djUf2tWrWYet+JwzhBJ3y+eJ2/BmLFRRBDB1NEKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpYEK0MJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD83C4CEEB;
	Tue, 22 Jul 2025 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753177793;
	bh=9h0C12PnlrEBqH7bHuilBBxOHLz9y1+B1tRkmC3wTDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qpYEK0MJO4DdB+fNaYLTefwTbYAMPO1dbhTEy4FslLUSFWawXJjGhrx/7en9/HX69
	 wFZmq5wIhSGySts0nfggTj/hRunc9lxmvGgYXO8MQk6LYhneDLOZHQGGHAZPYcsfBa
	 iSYGXIg599X6e7tgWp4AnnP/LijoiSe5QkEjOk+cod5bAmSnyTRxHuLRSoBcA+eu6+
	 +F84aUMmuSqlKvqclE1mZctYI4QxMX6ASOR9ScZLCVs9v5VwVaWYIZhO3pUiq7O7KW
	 zu9fqnUYhO1RCB5PGoPJFEGXrUxWJ51TEkB/A5/WCYUtptX+y7WEz+kQOfKGSlAQdW
	 Cg6gdNG+WBsww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D04383BF5D;
	Tue, 22 Jul 2025 09:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] gve: AF_XDP zero-copy for DQO RDA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175317781226.738038.9120112425524052716.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 09:50:12 +0000
References: <20250717152839.973004-1-jeroendb@google.com>
In-Reply-To: <20250717152839.973004-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com,
 joshwash@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Jul 2025 08:28:34 -0700 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> This patch series adds support for AF_XDP zero-copy in the DQO RDA queue
> format.
> 
> XSK infrastructure is updated to re-post buffers when adding XSK pools
> because XSK umem will be posted directly to the NIC, a departure from
> the bounce buffer model used in GQI QPL. A registry of XSK pools is
> introduced to prevent the usage of XSK pools when in copy mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] gve: deduplicate xdp info and xsk pool registration logic
    https://git.kernel.org/netdev/net-next/c/d57ae093c887
  - [net-next,v2,2/5] gve: merge xdp and xsk registration
    https://git.kernel.org/netdev/net-next/c/077f7153fd25
  - [net-next,v2,3/5] gve: keep registry of zc xsk pools in netdev_priv
    https://git.kernel.org/netdev/net-next/c/652fe13b1fd8
  - [net-next,v2,4/5] gve: implement DQO TX datapath for AF_XDP zero-copy
    https://git.kernel.org/netdev/net-next/c/2236836eab26
  - [net-next,v2,5/5] gve: implement DQO RX datapath and control path for AF_XDP zero-copy
    https://git.kernel.org/netdev/net-next/c/c1fffc5d66a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



