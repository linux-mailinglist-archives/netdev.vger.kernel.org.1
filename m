Return-Path: <netdev+bounces-13259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588B373AEFF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A592817F3
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9738C;
	Fri, 23 Jun 2023 03:20:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C78A20
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B51C4C433C9;
	Fri, 23 Jun 2023 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687490448;
	bh=DwbACjbiiSYkZEcEzktTKHsfX0I+KAANaVcOSfX8VAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/9YC1BPnkMkKsOpWwJUgf4Yqpg3n9FXEpR6nN5fsth7BLkKBXVBoolDYz3Vt7EFe
	 eW4MliApAUETHd+dUCNzKW3YMAUdDakCDGi1md94a4c7yIoUm8gWhtRU7rZHBL2SCZ
	 jb/0P6X9AXm9UzZGnFzVFCXaKd+Pma+3/B0SnqcEe/YuTruCB35X+Zbh5VGBDWxFRc
	 t7YiBhUe6JX71IAVm7HFpXddp3TmUIQvRfjuCEenVxPe8StmqTv+JMbX9krion0yyA
	 r/Bohtvzsa4eouHqxqGzgiJkQ3wqHvkQgOERPibhbdtwK7M4EjIhoyCSatfM5SvI/o
	 0abMl6IRJZy/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91F31C395D9;
	Fri, 23 Jun 2023 03:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-06-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168749044858.15040.8646713875880229434.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:20:48 +0000
References: <20230622185602.147650-2-johannes@sipsolutions.net>
In-Reply-To: <20230622185602.147650-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 20:56:03 +0200 you wrote:
> Hi,
> 
> Here's another set of updates for -next, almost certainly
> the last as we go off into the vacation period soon. Have
> a great summer, and already thanks for all the help!
> 
> Please pull and let me know if there's any problem. I'll
> likely be around a little bit at times if needed.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-06-22
    https://git.kernel.org/netdev/net-next/c/e6988447c15d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



