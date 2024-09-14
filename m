Return-Path: <netdev+bounces-128287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0621978D54
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3041F258FE
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC01F5FD;
	Sat, 14 Sep 2024 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz7/ePLt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D072030A
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288239; cv=none; b=WsxxjGU3Ytew8HGbjnLWk7bwlSrWBIpIkUVUjYGbfYlT8zanW5HwHu9FW9kTS+vAh0Cdlte3+fLHkc6pDSrrnLBW4LvKjyfCp/AZW0mo9qjPIipuv0v1Yrwe8g8OowhlPU63dr7MOcEvKd4hHjiQ9Q6P4qqbiNgfhPdh+7Bwzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288239; c=relaxed/simple;
	bh=VMEodgcdcYHGcZABHML/pSaBhvNnZqJKXFnp5qHAODc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ue+W1G8OAMExJFkwT5vpHEZP+sBKplPgLeHXl3LWha7MBAHp0HiFEBBW6RASuU8I9Lr0brtky8h6m7QS9kg8pybEVBYUIEDFLs1YUNTwppb2fNybcR3Da2R0nf74x5LL6u4DV325+mnlAjXoLtWqjgf/gokIb9OBxs3G5mhS8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz7/ePLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF4DC4CECF;
	Sat, 14 Sep 2024 04:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288238;
	bh=VMEodgcdcYHGcZABHML/pSaBhvNnZqJKXFnp5qHAODc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fz7/ePLtBX4TfP4U+tRvxN/aFnoGJE/petXetRXUoNSMngzSHVqJhLQvrDmYhRDP5
	 ZL9r6hAUiF6cVUkovICZ2etOlW/V80e0rtfC6yi9I6aYKQKpdkHMXCFhdrVgyBXvuK
	 Xy4yOl+XeC2HSW7N179//oSxd3rompJSxaWYHb3MjlnmgFpWTih2Mqesj6dpheYVPd
	 xEcH/xkc1cf+uR+JoltvpYZAvCUDdNb79NDuAtFQ/0u1T/NOWxBjuE34kk10e+iwtZ
	 HEx+fD5EnF/fD+oZBce51A0sVDzoveUHpkBxFhYGEj6vaQV1sVPVuvnSrK3HgTBhkh
	 fsXzMP4VZorzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBABC3806655;
	Sat, 14 Sep 2024 04:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628823950.2458848.8519208623251427822.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:39 +0000
References: <20240911093748.3662015-1-idosch@nvidia.com>
In-Reply-To: <20240911093748.3662015-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, gnault@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 12:37:42 +0300 you wrote:
> Currently, the kernel rejects IPv4 FIB rules that try to match on the
> upper three DSCP bits:
> 
>  # ip -4 rule add tos 0x1c table 100
>  # ip -4 rule add tos 0x3c table 100
>  Error: Invalid tos.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: fib_rules: Add DSCP selector attribute
    https://git.kernel.org/netdev/net-next/c/c951a29f6ba5
  - [net-next,2/6] ipv4: fib_rules: Add DSCP selector support
    https://git.kernel.org/netdev/net-next/c/b9455fef8b1f
  - [net-next,3/6] ipv6: fib_rules: Add DSCP selector support
    https://git.kernel.org/netdev/net-next/c/2cf630034e4e
  - [net-next,4/6] net: fib_rules: Enable DSCP selector usage
    https://git.kernel.org/netdev/net-next/c/4b041d286e91
  - [net-next,5/6] selftests: fib_rule_tests: Add DSCP selector match tests
    https://git.kernel.org/netdev/net-next/c/ac6ad3f3b5b1
  - [net-next,6/6] selftests: fib_rule_tests: Add DSCP selector connect tests
    https://git.kernel.org/netdev/net-next/c/2bf1259a6ea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



