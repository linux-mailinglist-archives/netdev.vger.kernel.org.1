Return-Path: <netdev+bounces-156119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40019A0505E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216011884DC2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B219D084;
	Wed,  8 Jan 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbdHq6pP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4319CD13
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302219; cv=none; b=tgE0rpN3eHDEjagoF//p72nIPPaooYYwADQctDNeIeukdgyBP4h8muySwocyWHoCZZ1rRxApmGNsCtWVlQhTv/lYncLr8rFirxboyE9llKYl2CDXC0nmoRKuDJacRkJzbMuevGLj6db+LPW/C20wwv/7KxiJ62m59nA8KLH02nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302219; c=relaxed/simple;
	bh=AYnIyivxGlyFlyVkVSGXd8LNEBmJGJ+1ULYqf+m8MiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BL+HA1ZbMuews3cC6nKlq2tbICtRb0o+Bpk1E377l1asI26aBmlMYNb03Txt1Z0yh+Tr8j3Rr+OMeqVa93T390jtPZXmmo1wk2Ye+kN1PWAw0epA41z4kw6HyYO71JlS6Z7cPBbdwjbK1T4moEXCmgnpCPG5w23XsddeDUZReQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbdHq6pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F1C4CEE0;
	Wed,  8 Jan 2025 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302219;
	bh=AYnIyivxGlyFlyVkVSGXd8LNEBmJGJ+1ULYqf+m8MiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UbdHq6pP+1GolbwPoAyxpjGFnClkxlLkr0eOhuLb5fayqdRy8YMLOcJDvKJJ7lGoN
	 XficY0leUG3AE0+Gy90v+xs4z+8U8jbsR7mQTMPlyRwtpbPZ8LKSVAmy/RRVqwWVxk
	 KVnRZ+wJ/CikJzWkyoR5nfa7t0wMmeuCH5f6DqO85B2Ci11vp7QopK7JfR7RruM5CH
	 +h93meeb6vc6uT78P90IC78yhCwEmWMzLmLpKjFfwm7gUYMAIZcy9JoArdh+ak3KjQ
	 r0qdE1Z3fEY/wrmm5glYmrpwphI7YnnXQyvWABqu2XRHmvKD/agBLGnSVdtxrAX4JG
	 2I72IW+QEiN/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB314380A97E;
	Wed,  8 Jan 2025 02:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: watchdog: rename __dev_watchdog_up() and
 dev_watchdog_down()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630224049.165659.18225447862381599025.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:10:40 +0000
References: <20250105090924.1661822-1-edumazet@google.com>
In-Reply-To: <20250105090924.1661822-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 herbert@gondor.apana.org.au

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  5 Jan 2025 09:09:24 +0000 you wrote:
> In commit d7811e623dd4 ("[NET]: Drop tx lock in dev_watchdog_up")
> dev_watchdog_up() became a simple wrapper for __netdev_watchdog_up()
> 
> Herbert also said : "In 2.6.19 we can eliminate the unnecessary
> __dev_watchdog_up and replace it with dev_watchdog_up."
> 
> This patch consolidates things to have only two functions, with
> a common prefix.
> 
> [...]

Here is the summary with links:
  - [net-next] net: watchdog: rename __dev_watchdog_up() and dev_watchdog_down()
    https://git.kernel.org/netdev/net-next/c/1b960cd19311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



