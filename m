Return-Path: <netdev+bounces-67211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6D8425A7
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E2F291A5E
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E46A353;
	Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSzX4FVa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33536A031
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619627; cv=none; b=eLEZvjBh9kmfXaVQlYxEC0lupnyU9Li4yh+8wr5NZqnoi2gY/+f3sJGwwOF3rJ+KjemppJuQgmxCXu7L18pv/sI1xzStcg+55wnZu2dFBsENfelKHeMMlpxGD6fsv1UuzBTDsgsv2XpkMuzYLFwpESujSZFk9/wnxFMAblr0PyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619627; c=relaxed/simple;
	bh=o4nmALaJHk6+cWfPrcO6P2mouIBiKyz0PgtRk9WjRV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rSKymiHfCNtPrKBW5HzuP2jX3t1ifjovm1LGTo3M8wwC25D6Md7/9ICDiDEk/3v2FQU1ATWdzrwKXYl11pn0uB6ZWpERaOn3Q73zI0Ya+8dXMx5vHMWAoibP2KtYpwdgMkny9wbhcuPRqz5acxAjDbjYIoZ31t9sI7ceacbr1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSzX4FVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 589E0C433B2;
	Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619627;
	bh=o4nmALaJHk6+cWfPrcO6P2mouIBiKyz0PgtRk9WjRV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NSzX4FVajWFnf7jiHxKxnSMW/mZjLfazSb6ERuyvRx4rVaA2eHz7HKLiAuRXe7oqE
	 frOHH7dSN7j8D4/Ku3AZYfTAp7geZ51DUw5yNgVknhY1IHy+aA1Uouinb+OZm+A406
	 JxSyq0lQi407E19u7krHSVC+/bumZ2/XOnOnkmFXJss/y/wiITfWd6rG6nxSm1az9k
	 LKi4TFwfqGFpnWoXmvo+2YkjEqH7wh56EAWAPWTGm6e9vRIpvqeH2EFG33DeZXkaqA
	 v3/LXwmsNexWKFWFNbqw8Jtn8eexnwA6z7KW707WUN3bRTlfBeWCdBYHpGBuQs9eXm
	 tbx+r4vGmBWgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45F0CE3237E;
	Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661962728.22779.7928925829236578595.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 13:00:27 +0000
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
In-Reply-To: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Jan 2024 17:36:16 +0100 you wrote:
> The config file contains a partial kernel configuration to be used by
> `virtme-configkernel --custom'. The presumption is that the config file
> contains all Kconfig options needed by the selftests from the directory.
> 
> In net/forwarding/config, many are missing, which manifests as spurious
> failures when running the selftests, with messages about unknown device
> types, qdisc kinds or classifier actions. Add the missing configurations.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: Add missing config entries
    https://git.kernel.org/netdev/net-next/c/4acf4e62cd57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



