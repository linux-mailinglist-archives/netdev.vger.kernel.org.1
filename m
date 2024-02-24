Return-Path: <netdev+bounces-74666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D4862273
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4A41F2538D
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC512B9D;
	Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVQlREAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169BE566;
	Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744233; cv=none; b=j+1WSeaC8KtZixD94z/Uh99xhqKMBHu5tVG1TYi47BX3F4n2ux4rtZ3Wsa7JULW5tLMpIPykDavuJfANtda4s8JNt8SbnVQ4Is7jV3PwWosdKX7IxAF/JHsu2XZ/zCf+upTwjJhzs/tHQJjdSjC1c0CNQ/AVKxH0dCLsWKwezNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744233; c=relaxed/simple;
	bh=6c50vqQy0N8sARqM/FYPf0zAfLsppI6dFzZNzb1Hc6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0LpjI5ePMSkAMp5RAzo+1U5eD4K6HfkJ7PKNBYSwWTG1d/AL0V6zykQ7Mw6RjYEX0FbYa9FO4m/gX/0J8JcIMkGPYBOylsA3ZXoAzENxni52z0rvQcTGPhRoJV55aFO2292vh/j7GcD6ME1AHWQh1VvBhzowOpnjP5Gl2b0uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVQlREAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2239C433C7;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708744232;
	bh=6c50vqQy0N8sARqM/FYPf0zAfLsppI6dFzZNzb1Hc6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nVQlREAJqbib59/S6XXB/JrTu58Q2qgdxaIPUkn7O8h0oUuwa7yDy08Qakfdprl0U
	 rFlQ85PNV4NdiOQfgxeWrZCQEmS7DYzcJnbQ3r1t5naNhbM4Mnd4g250lOiXg+cICk
	 osJ1AMQVX7wfSI8zjwQf88yRwrs1WOcArLDOW2VzDmzUxvESH4uhHDbuOio9PmI4LX
	 jmW2rlZv0cbOP1/pksDR8+imvw1FpAzsPLAiy+goKIEWUao0Xg9rab9hMCodsEbvIB
	 s2Pzjmv7W5UHl+9m36wO9ANy9qcxT2onmaKMU6tD/UUtjWI3JlZOXs5VUrp1QHndvU
	 ggBI+0m1Lm8Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8572D990CB;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/staging: Don't bother filling in ethtool
 driver version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874423274.898.17692880234682888016.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 03:10:32 +0000
References: <20240222090042.12609-1-john.g.garry@oracle.com>
In-Reply-To: <20240222090042.12609-1-john.g.garry@oracle.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-staging@lists.linux.dev, masahiroy@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 09:00:39 +0000 you wrote:
> The drivers included in this series set the ethtool driver version to the
> same as the default, UTS_RELEASE, so don't both doing this.
> 
> As noted by Masahiro in [0], with CONFIG_MODVERSIONS=y, some drivers could
> be built as modules against a different kernel tree with differing
> UTS_RELEASE. As such, these changes could lead to a change in behaviour.
> However, defaulting to the core kernel UTS_RELEASE would be expected
> behaviour.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] rocker: Don't bother filling in ethtool driver version
    https://git.kernel.org/netdev/net-next/c/23fe265fbfbc
  - [net-next,2/3] net: team: Don't bother filling in ethtool driver version
    https://git.kernel.org/netdev/net-next/c/0a4e1b453a8a
  - [3/3] staging: octeon: Don't bother filling in ethtool driver version
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



