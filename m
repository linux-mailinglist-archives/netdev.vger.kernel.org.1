Return-Path: <netdev+bounces-29829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12F784DD2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2ED1C209EC
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F508A23;
	Wed, 23 Aug 2023 00:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42667947A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE44BC433CA;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692750624;
	bh=TSv4HzbZf9yJGHYModJaor4znzl4kLAnhhPpxAu5xQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TIia88ID3IefAFBCrve7PaWhZ1s9/NMTffgU4WqRQxD+ovHAqSZczevAvn9mDSnzE
	 wwQQRhKLQyxOHFJVTk/Iur1Uh0TpYbDhJCEQmlFdIn6HxXI6EawjyY2Vst/VeSuYYE
	 1h86JVh05gMqT8FWiE8FgrajY/K9oAAvXlz8Pkzr/1uGabb3AHkAtn4ePbhxSsFuZB
	 yedrSniTK4mI/kbVMFplxp+qIf5tkefbBZNQ/v8fD4KZ6s6NyI7qCYGU1KXaibIj2D
	 4ZbMjI1+zXcWfeKP8/oFgnLQn+zVwIgvFztCoQ3Wye4rpK1jj0sTp19Q/Z15a5zpbJ
	 +79ChDD6BvSxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C704E21EDC;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [NET 0/2] CAN fixes for 6.5-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275062457.22438.1864998736721387025.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 00:30:24 +0000
References: <20230821144547.6658-1-socketcan@hartkopp.net>
In-Reply-To: <20230821144547.6658-1-socketcan@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, mkl@pengutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 16:45:45 +0200 you wrote:
> Hello Jakub,
> 
> as Marc is probably on vacation I send these two fixes directly to the netdev
> mailing list to hopefully get them into the current 6.5 cycle.
> 
> The isotp fix removes an unnecessary check which leads to delays and/or a wrong
> error notification.
> 
> [...]

Here is the summary with links:
  - [NET,1/2] can: isotp: fix support for transmission of SF without flow control
    https://git.kernel.org/netdev/net/c/0bfe71159230
  - [NET,2/2] can: raw: add missing refcount for memory leak fix
    https://git.kernel.org/netdev/net/c/c275a176e4b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



