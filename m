Return-Path: <netdev+bounces-39418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEB7BF11D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C690281A11
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A49454;
	Tue, 10 Oct 2023 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcoVvryf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB391C29;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7286C43395;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=tF6Ro/gUUkI2B8wI0IuZ1BycMb8KeaBwrWo0SwKCyqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jcoVvryflOiWJM3DgFwH70JlH6mBYXmACKaQLce/MaJzLBBgzJnvoO7oEUMwaIzh0
	 4Lqfz3RjTW92ZKZgLYWfRj55qGlKJ4okPRujkda/z6ReltCUO47Vx/MA3nc7FqOefi
	 850eMWuHlNx+UjHifagPWysFvym3jhWTir0wYbv5n+CNS207q3rMnOnqdzc+OJ+o0o
	 gkSGgNqsLo2KhT06VeBGws0wUQWYvft86wVg4bk2igDPg+UruMYdB+d1f3aK4k5mbf
	 o+CCt1nFLecAlsLA8Jlmxr5XfOaKkqbLDrLPRKABONjiHbwTtzNuCEScSgyXysY8EN
	 tgrOC49LrI7Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D59EE11F4B;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] liquidio: replace deprecated strncpy/strcpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622550.548.16340767982539390712.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 21:33:19 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as drvinfo is memset to 0:
> |	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
> 
> [...]

Here is the summary with links:
  - liquidio: replace deprecated strncpy/strcpy with strscpy
    https://git.kernel.org/netdev/net-next/c/52cdbea1a54a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



