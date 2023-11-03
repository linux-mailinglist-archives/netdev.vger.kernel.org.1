Return-Path: <netdev+bounces-45891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3687E025A
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133091C20A10
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E4154BE;
	Fri,  3 Nov 2023 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ77tkS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18794154B6
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 11:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 863E0C433CB;
	Fri,  3 Nov 2023 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699012224;
	bh=Zx2N/UgLkLpnNiz9eZRdN3T3MEz1nZqesUohPncQ0Qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hZ77tkS6dnEiII4tuxAGEY25uGGz6BGdK8p/J6lVH5YUjXH1atofLCzYa8X6QqHI8
	 SJqn5+GurDxMK7jXfcISEphqU28S8QHb8TvXbHGzAOMvM/EaUizHHhIv/ze0EUqw1+
	 F2tAfM/nj0e8iqVt+Myi5gGKsPFBGv8ilB8g7v3RRiFX8xYmlIaic66mO3IFjFZ2C+
	 MqWLvbsAsBUEOSZ67MQYXtgVPrHEAkwlrS5n5Ou2dj7mLbIWeKURQE6uFiXzomhyiY
	 0UKyU9APixFk3IQ4+09g0/90ka1iTbmZQ65hrlKlpebsfI8RbvfK9Fck6/OfHtsdST
	 S/9PxUXm9yGPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BA75E00085;
	Fri,  3 Nov 2023 11:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: fill in missing MODULE_DESCRIPTION()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169901222443.28417.6947124459040946167.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 11:50:24 +0000
References: <20231102045724.2516647-1-kuba@kernel.org>
In-Reply-To: <20231102045724.2516647-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  1 Nov 2023 21:57:24 -0700 you wrote:
> W=1 builds now warn if a module is built without
> a MODULE_DESCRIPTION(). Fill it in for sock_diag.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/netlink/diag.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] netlink: fill in missing MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net/c/016b9332a334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



