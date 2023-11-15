Return-Path: <netdev+bounces-47891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934567EBC7D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E151C20B02
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED5A5C;
	Wed, 15 Nov 2023 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi6w7rTG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B1A55
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE95C433C8;
	Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700020826;
	bh=GP9AOiP08EL+YmbPhaW830EIbWSCwj+NchiHetIHqNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zi6w7rTGRMWJZTES6tXCGv1w0glXXyjO4m+LuxpZTM4Xsdh3pLrp7suxTUtWiG9gt
	 KGPAT69UydJ7dz1U0zChJ2Igptw2bLgkqAHa64TOckCz3+x2YWY59Jd1LRZO3WZOM1
	 gX3SqygpXbHtOMk/4LC5B2a/NpTsPn6/LiEe5qH9NvyEaL4ySMmhRN5VKAQwpqddww
	 f4SOuGCmwRjHb5CdWMmEXK5r9CHGorTKn8n+oLon7kfiSprXOBliSsN03Y+KLcAnG5
	 mUdcYq9eTKYlIbHygwPYSDJXMCB4TVubIlOzvV3c4ohJoYfWdzeR2+rIWMxSnpkec3
	 sHdEv6lorSGfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E28E1F671;
	Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002082585.14036.6726245489238150125.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:00:25 +0000
References: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
In-Reply-To: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
To: Alex Pakhunov <alexey.pakhunov@spacex.com>
Cc: mchan@broadcom.com, vincent.wong2@spacex.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 10:23:49 -0800 you wrote:
> From: Alex Pakhunov <alexey.pakhunov@spacex.com>
> 
> This change moves [rt]x_dropped counters to tg3_napi so that they can be
> updated by a single writer, race-free.
> 
> Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
> Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
> 
> [...]

Here is the summary with links:
  - [v4,1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
    https://git.kernel.org/netdev/net/c/907d1bdb8b2c
  - [v4,2/2] tg3: Increment tx_dropped in tg3_tso_bug()
    https://git.kernel.org/netdev/net/c/17dd5efe5f36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



