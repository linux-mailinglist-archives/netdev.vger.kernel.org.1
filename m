Return-Path: <netdev+bounces-22090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5758C766088
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2516C1C21606
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CFB800;
	Fri, 28 Jul 2023 00:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE017F2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A710C433CA;
	Fri, 28 Jul 2023 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690503020;
	bh=VbRcUuylfguUh1AoVmw5ofnP90RIPK9Zz2DwAdjYYRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OnsHikEU/VMHoIuAt5PM8oihFp1NAILxJaQ895FfXhJPtOlyfHjCoNTLnmJf/U8FT
	 stSX8xfgj2YynDbNrUJ5vGJbrjF10m75MuHduiQnJywPkdjhuNBp9z9OIW56gGP9Ig
	 pNUaBgQ+WJdcdwbC8JGZfSdxoxojKXOaxgBJGJf4QvTmMzXKZ7uz9WsJ0y09k2W2pr
	 sOu80CbY65T0Ek7LGN6W/tsBy9YUhTTJ5B+2+d6X7wKTch0b8rm5A1Dm0+5cP4zEoh
	 slvcHSVHOGjbEn9X8MXJhTRN5bHBq+4CLqQF6ylvsNuPATVu1tyCKDJSJTGF2qNGLC
	 6fvdI2LZtJZ4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD2EC41672;
	Fri, 28 Jul 2023 00:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: remove comment in ndisc_router_discovery
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050302017.20080.3221025722245457668.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:10:20 +0000
References: <20230726184742.342825-1-prohr@google.com>
In-Reply-To: <20230726184742.342825-1-prohr@google.com>
To: Patrick Rohr <prohr@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 11:47:42 -0700 you wrote:
> Removes superfluous (and misplaced) comment from ndisc_router_discovery.
> 
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  net/ipv6/ndisc.c | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [v2] net: remove comment in ndisc_router_discovery
    https://git.kernel.org/netdev/net-next/c/ef27ba5c845d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



