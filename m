Return-Path: <netdev+bounces-130161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEBE988BBE
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839271C2142B
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E21C2DAC;
	Fri, 27 Sep 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6yEO5M5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB314EC5E
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727472028; cv=none; b=qQdGJgmH8s2645FVRUsT8IzLeWvx2KbxpJPDz4URBMqnWxMcFJ3RYHzznVkY2+3CMlh+NMEvERLw9K1FcIwPG85ID18yBMG3M2J3z//BVibjnioj0DP4UUC99IMpBLAlM78fUQV/LafkPjx3s1C/Nm3h4SwxZg+q98LkbRyJGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727472028; c=relaxed/simple;
	bh=opz6pQiAqq4a3coCyKHOsTWGN//bHUJSsO/2/3lFcGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IL81MneajQdRe+jvlWz96Zak6lIZDbuOb9L4rri/a1Zqa7hO8nWuk8M2Yf5J0N+bSnDQ1IWHH26o6gWUm8f/HA2s/oy8nsYu+zKcuwNLbEt7kcCnxTZVNyLHcaxHicF9Cb7R09GGvIp0lBGeOOIdu10UUdwmau0W0qgiMfE2BzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6yEO5M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51433C4CEC4;
	Fri, 27 Sep 2024 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727472028;
	bh=opz6pQiAqq4a3coCyKHOsTWGN//bHUJSsO/2/3lFcGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6yEO5M5IPAGjB/BlE5Jxdd57PjqvwybaKWSGIRA0JtywVyuloFzP5jrDN/3BTie+
	 vmYTwrqKiYKLdpQRFfB+bjlVU2Vtifr62VNx8btUCZ4GvMotRLnUxDpuvNaaVrVM/U
	 2j54FjZgETXtrm/eNydtU5DmY53hI6M8MzYX/quECug/t4S6oU3H94S6ljO82lKhnv
	 /ekxtAakydwDpZQ/ZdTSROEfzLTQAVIdhWKYa6ZnliaqSq0VnbUV7KwXBlXCBniGe5
	 iv3fpMUPwMoBdwxk2+oBm/LtoSfnUOWU5ZKA9wQm3zGM9lnL8seaFw28D3LBNfz8Cj
	 U2OsGFV9dKqaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 359463809A80;
	Fri, 27 Sep 2024 21:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2, PATCH 1/2] bridge: mst: fix a musl build issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172747203103.2086938.7256358584550153269.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 21:20:31 +0000
References: <20240922145011.2104040-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240922145011.2104040-1-dario.binacchi@amarulasolutions.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 linux-amarula@amarulasolutions.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 22 Sep 2024 16:50:10 +0200 you wrote:
> This patch fixes a compilation error raised by the bump to version 6.11.0
> in Buildroot using musl as the C library for the cross-compilation
> toolchain.
> 
> After setting the CFLGAS
> 
> ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
> IPROUTE2_CFLAGS += -D__UAPI_DEF_IN6_ADDR=0 -D__UAPI_DEF_SOCKADDR_IN6=0 \
> 			-D__UAPI_DEF_IPV6_MREQ=0
> endif
> 
> [...]

Here is the summary with links:
  - [iproute2,1/2] bridge: mst: fix a musl build issue
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6a77abab9251
  - [iproute2,2/2] bridge: mst: fix a further musl build issue
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=043ef90e2fa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



