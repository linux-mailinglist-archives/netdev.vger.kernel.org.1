Return-Path: <netdev+bounces-15746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A27497AD
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A1A1C20C77
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C697E6;
	Thu,  6 Jul 2023 08:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F736185C
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B12B9C433C9;
	Thu,  6 Jul 2023 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688633420;
	bh=aJfz8dDP5NttJwF1Z73B8R8tlOTOFk5spMoKt1M4TwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SApbaVJUIncHvm+QF2TKWS8NV2azsFAl+gsqQ6nUnd1fsna/aG/lBG89kdrqnNGpU
	 oCCf31rvd5lydM+t3Zl4d64Gyp5TbReHCY0l6jDwsMxGlp42EBASnFabO9hIJBe63t
	 /Zsuzo8LTliZEVLHToim/lA4Jv0RIX9TJjP30UFOPKh6tUQaRxjEBJYFo9y0FLAW1A
	 oRY1Nhxn2KbIv6ufm404lt4hh/KOHjZnA/d3XuAI7v/m7doKHOBqHPcIeclrBZnWB+
	 c2UCSbPErPfKmRB/M3ePK6OOL3HL7kZAltz6EssXAmkGKx31F5U8zH4XzSgBztHOet
	 KPG2In2ImY7Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C3C1C395C5;
	Thu,  6 Jul 2023 08:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mvneta: fix txq_map in case of txq_number==1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168863342063.1842.10746147881143228365.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 08:50:20 +0000
References: <20230705053712.3914-1-klaus.kudielka@gmail.com>
In-Reply-To: <20230705053712.3914-1-klaus.kudielka@gmail.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: thomas.petazzoni@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gregory.clement@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  5 Jul 2023 07:37:12 +0200 you wrote:
> If we boot with mvneta.txq_number=1, the txq_map is set incorrectly:
> MVNETA_CPU_TXQ_ACCESS(1) refers to TX queue 1, but only TX queue 0 is
> initialized. Fix this.
> 
> Fixes: 50bf8cb6fc9c ("net: mvneta: Configure XPS support")
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: mvneta: fix txq_map in case of txq_number==1
    https://git.kernel.org/netdev/net/c/21327f81db63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



