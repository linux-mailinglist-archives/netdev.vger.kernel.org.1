Return-Path: <netdev+bounces-52350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7D7FE7D1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018CA1C20A71
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E013FE3;
	Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTr8NUQP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52313AF9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50A18C433D9;
	Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701316227;
	bh=AxReVR+vNL315koogJMxMbFXeIS5J2/EzTVROA2PUY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WTr8NUQP2P/S3p1Nc5wMWoQYe2OwY5m5G1kAtic0zmjjXhwGf4Z9ETDGrTLYMNMme
	 PzHcPbRwQ69vco8lGsMACncy4UJa7JeH+CyaYEIxuqjH3Ktd9Jf5111uNg5kV7As4p
	 p793r00XZ8JpWNqxC++kbMgjz4GPhnvwlL63wLXrVSnaC1nW3ejsQ8umoPOahFaDof
	 lsCO8e+lOJZAZHdrjr3Zc+MYKWFnPdg7kAZawUB1GXT8ogDfTjItIJv15urxPzzEZ4
	 CdgDNcxUCTNrwnfyhv4Z2ryPlOjQYaydgo/AWNjQe83A6kWXpqr+jdrI2BBvV0T4xy
	 wXMVkBDWOSEtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3ACA3C64459;
	Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: improve handling task scheduling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131622723.14621.8854537531511799398.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 03:50:27 +0000
References: <c65873a3-7394-4107-99a7-83f20030779c@gmail.com>
In-Reply-To: <c65873a3-7394-4107-99a7-83f20030779c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 18:20:11 +0100 you wrote:
> If we know that the task is going to be a no-op, don't even schedule it.
> And remove the check for netif_running() in the worker function, the
> check for flag RTL_FLAG_TASK_ENABLED is sufficient. Note that we can't
> remove the check for flag RTL_FLAG_TASK_ENABLED in the worker function
> because we have no guarantee when it will be executed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: improve handling task scheduling
    https://git.kernel.org/netdev/net-next/c/127532cd0f06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



