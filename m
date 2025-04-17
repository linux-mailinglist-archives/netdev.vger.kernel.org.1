Return-Path: <netdev+bounces-183718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01320A91A90
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892B419E56E8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFFE23BF9E;
	Thu, 17 Apr 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKg5j4dr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC423A98D;
	Thu, 17 Apr 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888801; cv=none; b=qHswVP3XC+nfIkOPs5r/OauKPnx4hCtDuJOEfm8w45jkSl8Wmn3KybjfqyrlU4FAjhIID4TFUwVazCzy3HSEv6vlPXau5hC7WvHFCnBtJFquPG3+M7mzoG7ugNDytDkUMexGvDjZSMlIBGKZkW07HI3IrRsVHAgH2ljPtKtEe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888801; c=relaxed/simple;
	bh=gjSq58SBhGjilxhcf8ahCdIfOdfoQdwtD7QU9PawL1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdYyo30S2UALE6jnAjf/GNb2rsGE1MndWsxyYbvQ0Uo/+hty7omloCbIJubsVl8z7k9Dl1lXKOX3C4IzTGPinVc8OvIvBcl6dVFu+OgqkXzOWGxn5insGGbH+4wE/w3WhjA9je5rGc7IlwUIlrz5mEqM0u1BKYqVR+fQB+ABMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKg5j4dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68988C4CEE4;
	Thu, 17 Apr 2025 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888801;
	bh=gjSq58SBhGjilxhcf8ahCdIfOdfoQdwtD7QU9PawL1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bKg5j4drkhoiGpf3VleG/8HhtUw0Z2FbCvPGXuyrwpMKG4IJG9cOx5550+wq5FVJi
	 5Lv/3EZ8Q1LtQyFdvhmLvIdOwSjXMcmd5yuimFY4Y7gqUJNc/T5H1khk46PHdqfvIE
	 jBmSy5u5umB5hxb3xcJ1WegMYDR+y661WgUWEYND+WrYGxe8VEvuWsDLGc9x41P18j
	 4sRj6bxMxv4tNZuTYgVeAPiTvuCzwtlSf+JctcSNcsSEHEKi91DJeI0+uI24bakUyS
	 d8gX5LqAA/1OaQDHJc1BCegZsHr1yBUcyqE4jEd2inNsoHMUASEb/hKIStpTfkTj7C
	 mw9FbSwOMtndQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF9A380664C;
	Thu, 17 Apr 2025 11:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: pktgen: fix checkpatch code style
 errors/warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174488883923.4039084.4754428619480833278.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 11:20:39 +0000
References: <20250415112916.113455-1-ps.report@gmx.net>
In-Reply-To: <20250415112916.113455-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 toke@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 13:29:13 +0200 you wrote:
> Fix checkpatch detected code style errors/warnings detected in
> the file net/core/pktgen.c (remaining checkpatch checks will be addressed
> in a follow up patch set).
> 
> Changes v1 -> v2:
>   - drop already applied patches
>   - update "net: pktgen: fix code style (ERROR: else should follow close brace
>     '}')"
>     Additional add braces around the else statement (as suggested by a follow
>     up checkpatch run and by Jakub Kicinski from code review).
>   - update "net: pktgen: fix code style (WARNING: please, no space before tabs)"
>     Change from spaces to tab for indent (suggested by Jakub Kicinski).
>   - update "net: pktgen: fix code style (WARNING: Prefer strscpy over strcpy)"
>     Squash memset/strscpy pattern into single strscpy_pad call (suggested
>     by Jakub Kicinski).
>   - drop "net: pktgen: fix code style (WARNING: braces {} are not necessary for
>     single statement blocks)" (suggestd by Jakub Kicinski)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: pktgen: fix code style (ERROR: else should follow close brace '}')
    https://git.kernel.org/netdev/net-next/c/3bc1ca7e173c
  - [net-next,v2,2/3] net: pktgen: fix code style (WARNING: please, no space before tabs)
    https://git.kernel.org/netdev/net-next/c/65f5b9cb5431
  - [net-next,v2,3/3] net: pktgen: fix code style (WARNING: Prefer strscpy over strcpy)
    https://git.kernel.org/netdev/net-next/c/422cf22aa332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



