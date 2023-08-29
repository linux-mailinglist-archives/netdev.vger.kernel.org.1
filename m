Return-Path: <netdev+bounces-31136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2178BD1C
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570271C20996
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8BA47;
	Tue, 29 Aug 2023 03:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A27EC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B391C433C9;
	Tue, 29 Aug 2023 03:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693278023;
	bh=R8rW4JSwfvEGQvpxUWruACyowU1eSZJ5eXNogArkxB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NOzbCW8l704MRu1JerPbWDAd10fdvEP4hdCRzD5FH5YiBQRCuMGcjP8V5A3JkaEeL
	 ySm7YABHv3tgxmRdxBHBklPzpekU7bm2s4lwSE/7ldjsQydWAD+oYhG76bOhyx0YEg
	 zcFSDCQdZDlNMCUdC0ZzfhCJkO076+s3hC/MPmvEi+VV0OpwnR5vdX9xUOq5wiDP6F
	 JxUox9IxbLRTYnVLHCAmt4dPNtEOJ0iQZ4molKKH+DwA6dquqoNzap5dOZkifGp3zW
	 yqra6GPADTC9y5u6KNES6wqdvkNZOReEC1Xjjkv9z1paYg2+Y907VKsVfogQeSWi/X
	 WsJuFftl7pa8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E486E21EDF;
	Tue, 29 Aug 2023 03:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2-next 0/2] tc: support the netem seed parameter for
 loss and corruption events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169327802351.27710.5654548674614966803.git-patchwork-notify@kernel.org>
Date: Tue, 29 Aug 2023 03:00:23 +0000
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
In-Reply-To: <20230823100128.54451-1-francois.michel@uclouvain.be>
To: =?utf-8?q?Fran=C3=A7ois_Michel_=3Cfrancois=2Emichel=40uclouvain=2Ebe=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 23 Aug 2023 12:01:08 +0200 you wrote:
> From: François Michel <francois.michel@uclouvain.be>
> 
> Linux now features a seed parameter to guide and reproduce
> the loss and corruption events. This patch integrates these
> results in the tc CLI.
> 
> For instance, setting the seed 42424242 on the loopback
> with a loss rate of 10% will systematically drop the 5th,
> 12th and 24th packet when sending 25 packets.
> 
> [...]

Here is the summary with links:
  - [v2,iproute2-next,1/2] tc: support the netem seed parameter for loss and corruption events
    (no matching commit)
  - [v2,iproute2-next,2/2] man: tc-netem: add section for specifying the netem seed
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fcff3a8fe980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



