Return-Path: <netdev+bounces-140057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D1A9B521F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D50B21DB6
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6118206E8C;
	Tue, 29 Oct 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmNWjyIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F7206E82;
	Tue, 29 Oct 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227838; cv=none; b=HMh2m63pifpDO54qK5uzLjgsY8QhYLs3Bk1OdDwNsHj9wt6QyV2R24cfIfWinYkm5y7S3TPqBDQRVxubJ+91x9euScXgPASI5nNG7CDEIwxapW6ObUJSrxxByDb0ILUfQcJytOdePcYwcayTNh1H59RpFuUqolEbi65Zy5plalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227838; c=relaxed/simple;
	bh=lV81+lqraE6WdVVhlwTOO1Qi3SkG2SKwe5qZ1XrLC58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pvseNK/AOGF5SfleQVcGcgMy/NH7WUtPqHzgroN11AjiZciUGbnhyKu4wY3s5ygGYk9Vm8zDMXBDG9qIleNyF7e1J4RJgeT9m72ZEtiIiGn60t43ZheehRJkkJIyUGy11szPBuL3pnClnPF0nFC7qVgeo6nYXmXbU4Tt2koeoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmNWjyIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26790C4CEE4;
	Tue, 29 Oct 2024 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227838;
	bh=lV81+lqraE6WdVVhlwTOO1Qi3SkG2SKwe5qZ1XrLC58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GmNWjyIv1UZ/iiuQlQYkUmglNQnPDcs9lCA/zix7CmpsCDHSuWSNGVCVfH4eKCF1G
	 OlFlKffM/KBjOuqraKFfOsPiDutmYxNxuiv4sTD33TQcSipiZYAtnR/UQ+2Te3+7eS
	 Dqp3ElE35P6tqgfOmuE3PT8L0uXZBOXVLYeW4h8rkDXeVqF1lcQxNBmgtAEo6LGMFG
	 eQyul4CR2IpPRLkg9zYTW3nIZRFztVQCmpNs4WbzsMwph59RsB/vJ7pHR5RGeeTsfe
	 W+zvUktLkdhpm79Hc7let2DJ95VvXBjF02+XnMqVNZ9ouhR5m7Vmc4nJWmmFVyorut
	 ZNSPDI5zrfy3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB44B380AC08;
	Tue, 29 Oct 2024 18:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] wwan: core: Pass string literal as format
 argument of dev_set_name()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022784550.787364.9831173645509301356.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:45 +0000
References: <20241023-wwan-fmt-v1-1-521b39968639@kernel.org>
In-Reply-To: <20241023-wwan-fmt-v1-1-521b39968639@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 13:15:28 +0100 you wrote:
> Both gcc-14 and clang-18 report that passing a non-string literal as the
> format argument of dev_set_name() is potentially insecure.
> 
> E.g. clang-18 says:
> 
> drivers/net/wwan/wwan_core.c:442:34: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>   442 |         return dev_set_name(&port->dev, buf);
>       |                                         ^~~
> drivers/net/wwan/wwan_core.c:442:34: note: treat the string as an argument to avoid this
>   442 |         return dev_set_name(&port->dev, buf);
>       |                                         ^
>       |                                         "%s",
> 
> [...]

Here is the summary with links:
  - [net-next] wwan: core: Pass string literal as format argument of dev_set_name()
    https://git.kernel.org/netdev/net-next/c/3f7f3ef44f4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



