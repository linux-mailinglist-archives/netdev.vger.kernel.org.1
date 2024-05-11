Return-Path: <netdev+bounces-95656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E18C2F08
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 550DFB216FC
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A022EE4;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAGfFBH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651462209F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394634; cv=none; b=IJp1vJsqrRK330uBj7f84YInSYBWW6P1YpWrgDHz1w09eYlXXDC08bx1TTeVl4ohbsb3vEspEOGqdtWmzDylaKyxNTz1/tHSFU1AVjR3XTqBqNeUcv0WAB6YW2KgraqKXW6B0YhkOS3glalj5Z0FxKKvCmciUeY6dO3Vu5KYSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394634; c=relaxed/simple;
	bh=8VkVPsg0MazL+9Dctt2LZU3E8YHe2Z5sxG/eUizypIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=roznL0OOHDCfQQheEBZ2j5ZHlcDtYT00IUHRDblQxCuLwz5P2qteof55FNsOVljlCsf/1+fHeIXKJFXKFUspR49hIL48Hrievcoq75thB516meCoCGynyuHlcn+aoY++XWDqjY6wE0ZrINMpWfHdHlxY0YDzpCaRGyFUaXzwk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAGfFBH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D20C32781;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394634;
	bh=8VkVPsg0MazL+9Dctt2LZU3E8YHe2Z5sxG/eUizypIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OAGfFBH0Z+VFm12wpNj4MUiql9KVtJNqhu3X2v43/EkI6yJhCOxubo66aN9foQ9cX
	 zJ4NVp3jj52Tac44bYSg2WqrbGsiVSzlBGMJmOBdm5mAWGwQnwh0Axr8j9P81kHjHU
	 WEO3xE/ehPVbVCIN08nZCWi39jR4WQjFCBxvxASK6JniwFjICekQtknRV7VRW/JOk6
	 yBWHHeRJpMjDmeSmuxJAo3+qk3k8RuJBE7bdnIXWlZqpw6JMQYrE/cuoXPZpuZsmvj
	 /fPOQSaw/Hri3RuSEu0fN6z/nD1XqpMfAt3JWr8krC9tc8diwHz43BvLM8Te0A9tQ/
	 +E4dHqn+cUJ+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1447C32759;
	Sat, 11 May 2024 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: cortina: Locking fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539463391.29955.2891193541370648978.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:30:33 +0000
References: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>
In-Reply-To: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ulli.kroll@googlemail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 May 2024 09:44:54 +0200 you wrote:
> This fixes a probably long standing problem in the Cortina
> Gemini ethernet driver: there are some paths in the code
> where the IRQ registers are written without taking the proper
> locks.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: cortina: Locking fixes
    https://git.kernel.org/netdev/net/c/812552808f7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



